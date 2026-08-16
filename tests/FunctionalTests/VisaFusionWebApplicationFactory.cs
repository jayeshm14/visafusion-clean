using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc.Testing;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.DependencyInjection.Extensions;
using Microsoft.Extensions.Hosting;
using VisaFusion.Core.Application;
using VisaFusion.Identity;
using VisaFusion.Identity.Persistence;
using VisaFusion.Web;

namespace VisaFusion.FunctionalTests;

/// <summary>
/// WebApplicationFactory for the VisaFusion single-process host (SPEC-0003 T024).
///
/// Overrides configuration so functional tests do not depend on a live SQL Server:
/// the Serilog SQL sink and EF Core connection are pointed at a non-routable
/// placeholder, and the SQL sink is disabled to keep tests hermetic.
///
/// SPEC-0005 (T007): the SQL Server <see cref="VisaFusionIdentityDbContext"/> is
/// additionally replaced with an EF Core InMemory store so the auth functional tests
/// (5-role login, bad credentials, inactive-account block) seed and authenticate
/// users hermetically. The database name is unique per factory instance because EF
/// InMemory databases are process-global by name. The five roles are seeded once at
/// host start (idempotent) because <c>AddToRoleAsync</c> requires the role row to
/// exist.
/// </summary>
public class VisaFusionWebApplicationFactory : WebApplicationFactory<Program>
{
    private readonly string _identityDatabaseName = $"VisaFusionIdentity-{Guid.NewGuid():N}";

    protected override void ConfigureWebHost(IWebHostBuilder builder)
    {
        builder.UseEnvironment("Testing");

        builder.ConfigureAppConfiguration((_, config) =>
        {
            config.AddInMemoryCollection(new Dictionary<string, string?>
            {
                // Disable the Serilog SQL sink for hermetic tests (NFR-006 is
                // exercised in the real host; tests must not require a database).
                ["Serilog:WriteTo:0:Name"] = "Console",
                ["ConnectionStrings:DefaultConnection"] =
                    "Server=localhost;Database=VisaFusion_Test;Trusted_Connection=True;TrustServerCertificate=True;MultipleActiveResultSets=true",
            });
        });

        builder.ConfigureServices(services =>
        {
            services.RemoveAll<DbContextOptions<VisaFusionIdentityDbContext>>();
            services.RemoveAll<VisaFusionIdentityDbContext>();
            services.AddDbContext<VisaFusionIdentityDbContext>(options =>
                options.UseInMemoryDatabase(_identityDatabaseName));

            // US2 (T019/T020): the real day-gate implementation reads the
            // `security` table via VisaEntryDbContext, which points at a
            // non-routable placeholder connection here. Stub the shared Core
            // rule as an open day so the hermetic emp-login success path
            // (AC-001) is proven without a database (plan.md "Testing").
            services.RemoveAll<ISecurityGateService>();
            services.AddScoped<ISecurityGateService, OpenDaySecurityGateStub>();

            // SPEC-0006 (T024-T026): the real entry service calls the
            // owner-supplied stored procedures via VisaEntryDbContext, which
            // points at a non-routable placeholder connection here. Stub the
            // shared Core service with a faithful in-memory fake so the
            // Entries functional tests (5-role matrix, optimistic concurrency,
            // problem-details errors) are hermetic — the service behavior
            // itself is covered by the unit and integration tests.
            services.RemoveAll<IEntryService>();
            services.AddSingleton<IEntryService, InMemoryEntryServiceStub>();

            services.AddSingleton<IHostedService, IdentityRoleSeeder>();
        });
    }

    /// <summary>
    /// Idempotently creates the five legacy role rows (su/adm/emp/agt/guest,
    /// <see cref="IdentityIntegration.Roles"/>) in the InMemory identity store at
    /// host start, so seeded users can be added to a role without a live SQL
    /// dependency (SPEC-0005 T007).
    /// </summary>
    private sealed class IdentityRoleSeeder : IHostedService
    {
        private readonly IServiceProvider _services;

        public IdentityRoleSeeder(IServiceProvider services) => _services = services;

        public Task StartAsync(CancellationToken cancellationToken)
        {
            using var scope = _services.CreateScope();
            var roleManager = scope.ServiceProvider
                .GetRequiredService<RoleManager<IdentityRole>>();
            foreach (var role in new[]
            {
                IdentityIntegration.Roles.SuperUser,
                IdentityIntegration.Roles.Admin,
                IdentityIntegration.Roles.Employee,
                IdentityIntegration.Roles.Agent,
                IdentityIntegration.Roles.Guest,
            })
            {
                if (!roleManager.RoleExistsAsync(role).GetAwaiter().GetResult())
                {
                    var result = roleManager.CreateAsync(new IdentityRole(role)).GetAwaiter().GetResult();
                    if (!result.Succeeded)
                    {
                        throw new InvalidOperationException(
                            $"Could not seed role '{role}': {string.Join("; ", result.Errors.Select(e => e.Description))}");
                    }
                }
            }

            return Task.CompletedTask;
        }

        public Task StopAsync(CancellationToken cancellationToken) => Task.CompletedTask;
    }

    /// <summary>
    /// Open-day stub for the shared day-gate rule (US2, plan.md "Testing"):
    /// hermetic functional tests must not touch the `security` table, so the
    /// gate always allows the login. The rejection paths are covered by the
    /// unit tests (evaluation) and the integration tests (real SQL Server).
    /// </summary>
    private sealed class OpenDaySecurityGateStub : ISecurityGateService
    {
        public Task<SecurityGateDecision> EvaluateAsync(IEnumerable<string> roles, DateTime date)
            => Task.FromResult(SecurityGateDecision.Allowed);
    }

    /// <summary>
    /// Faithful in-memory <see cref="IEntryService"/> fake (SPEC-0006 T024-T026):
    /// hermetic functional tests must not call the owner-supplied stored
    /// procedures (VisaEntryDbContext points at a non-routable placeholder
    /// here). Implements the full contract surface — create (with refno
    /// allocation), read, update with RowVersion optimistic concurrency
    /// (AC-011), status change, AWB record — so the endpoint wiring (auth
    /// matrix, If-Match/ETag, problem-details mapping) is proven hermetically.
    /// The real service behavior is covered by the unit and integration tests.
    ///
    /// The status-change validity check mirrors the real service's
    /// SqlException translation for the proc's "StatusID not found" RAISERROR
    /// (script 08:54-56): the stub rejects a NewStatusId outside the legacy
    /// status-code set (deepanalysis.md §4.5 line 165 / lines 182-191 —
    /// 101/201/251/301/401/408/411/501/502/503/509/601) with the same
    /// EntryValidationException the API maps to 400, so the endpoint's
    /// problem-details path is exercised hermetically (T026).
    /// </summary>
    private sealed class InMemoryEntryServiceStub : IEntryService
    {
        private readonly Dictionary<int, EntryAggregate> _entries = new();
        private int _nextRefno = 1;

        // Legacy status codes, verbatim from findings/deepanalysis.md §4.5
        // (lines 165, 182-191): the `status` table's natural-key set.
        private static readonly HashSet<int> LegacyStatusCodes = new()
        {
            101, 201, 251, 301, 401, 408, 411, 501, 502, 503, 509, 601,
        };

        public Task<CreateEntryResult> CreateAsync(
            int refno, CreateEntryCommand command, CancellationToken ct = default)
        {
            // ≥ 1-passenger invariant (BR-005) — mirror of the real service.
            if (string.IsNullOrWhiteSpace(command.Paxname)
                || string.IsNullOrWhiteSpace(command.Passportno))
            {
                throw new EntryValidationException(
                    "An entry must have at least one passenger with a name and passport number.");
            }

            if (refno <= 0)
            {
                throw new EntryValidationException("refno must be a positive integer.");
            }

            if (_entries.ContainsKey(refno))
            {
                throw new EntryConflictException($"An entry with refno {refno} already exists.");
            }

            var aggregate = new EntryAggregate(
                refno, command.Paxname, command.Passportno, Agent: null, Status: null,
                command.TravelDate, Subdate: null, Coldate: null, Receivedate: null, SentDate: null,
                command.TotalPassengers,
                new[]
                {
                    new EntryPassengerData(1, command.Paxname, command.Passportno,
                        command.DateOfBirth, command.Category),
                },
                Array.Empty<PaxStatusData>(),
                RowVersion: new byte[] { 1, 2, 3, 4, 5, 6, 7, 8 });
            _entries[refno] = aggregate;
            return Task.FromResult(new CreateEntryResult(refno, aggregate.RowVersion, aggregate));
        }

        public Task<EntryAggregate?> GetByRefnoAsync(int refno, CancellationToken ct = default)
            => Task.FromResult(_entries.TryGetValue(refno, out var entry) ? entry : null);

        public Task<int> AllocateRefnoAsync(CancellationToken ct = default)
            => Task.FromResult(_nextRefno++);

        public Task<CreateEntryResult> UpdateAsync(
            int refno, CreateEntryCommand command, byte[] expectedRowVersion, CancellationToken ct = default)
        {
            if (!_entries.TryGetValue(refno, out var current))
            {
                throw new EntryNotFoundException($"Entry {refno} was not found.");
            }

            if (!current.RowVersion!.SequenceEqual(expectedRowVersion))
            {
                throw new EntryConflictException(
                    $"Entry {refno} was modified by another request; the If-Match ETag is stale.");
            }

            var updated = new EntryAggregate(
                refno, command.Paxname, command.Passportno, current.Agent, current.Status,
                command.TravelDate, current.Subdate, current.Coldate, current.Receivedate, current.SentDate,
                command.TotalPassengers, current.Passengers, current.PaxStatuses,
                RowVersion: new byte[] { 9, 9, 9, 9, 9, 9, 9, 9 });
            _entries[refno] = updated;
            return Task.FromResult(new CreateEntryResult(refno, updated.RowVersion, updated));
        }

        public Task<StatusChangeResult> RecordStatusChangeAsync(
            RecordStatusChangeCommand command, CancellationToken ct = default)
        {
            if (!_entries.ContainsKey(command.Refno))
            {
                throw new EntryNotFoundException($"Entry {command.Refno} was not found.");
            }

            // Mirror of the real service's SqlException translation for the
            // proc's "StatusID not found" RAISERROR (script 08:54-56 → 400).
            if (!LegacyStatusCodes.Contains(command.NewStatusId))
            {
                throw new EntryValidationException(
                    $"Status id {command.NewStatusId} does not exist.");
            }

            return Task.FromResult(new StatusChangeResult(StatusHistoryId: 1, UpdatedBy: "emp:test-user"));
        }

        public Task RecordAwbAsync(int refno, RecordAwbCommand command, CancellationToken ct = default)
        {
            if (!_entries.ContainsKey(refno))
            {
                throw new EntryNotFoundException($"Entry {refno} was not found.");
            }

            return Task.CompletedTask;
        }
    }
}
