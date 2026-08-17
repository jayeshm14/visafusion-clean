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

            // SPEC-0007 (T014): the real agent service coordinates
            // VisaEntryDbContext (non-routable placeholder here) with the
            // Identity store. Stub the shared Core service with a faithful
            // in-memory fake so the Agent functional tests (adm/su matrix,
            // lifecycle responses, problem-details errors) are hermetic — the
            // service behavior itself is covered by the unit and integration
            // tests (AgentLifecycleTests, AgentCrudIntegrationTests).
            services.RemoveAll<IAgentService>();
            services.AddSingleton<IAgentService, InMemoryAgentServiceStub>();

            // SPEC-0007 (T020): the real user-management service coordinates
            // VisaEntryDbContext (non-routable placeholder here) with the
            // Identity store. Stub the shared Core service with a faithful
            // in-memory fake so the Admin user-management functional tests
            // (adm/emp matrix, su-only provisioning, su-target deactivation,
            // problem-details errors) are hermetic — the service behavior
            // itself is covered by the unit and integration tests
            // (UserManagementTests, UserManagementIntegrationTests).
            services.RemoveAll<IUserManagementService>();
            services.AddSingleton<IUserManagementService, InMemoryUserManagementServiceStub>();

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

        // SPEC-0007 T005: open/close/today surface is a no-op in the hermetic
        // stub (the write paths are covered by the unit and integration tests).
        public Task<SecurityDayOpenResult> OpenDayAsync(DateTime date, string openedBy)
            => Task.FromResult(SecurityDayOpenResult.Opened);

        public Task<SecurityDayCloseResult> CloseDayAsync(DateTime date, string closedBy)
            => Task.FromResult(SecurityDayCloseResult.Closed);

        public Task<SecurityDayStatus?> GetTodayAsync(DateTime date) => Task.FromResult<SecurityDayStatus?>(null);
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
    /// status-code set (deepanalysis.md §4.4 lines 175-191 —
    /// 101/201/251/301/401/408/411/501/502/503/509/601) with the same
    /// EntryValidationException the API maps to 400, so the endpoint's
    /// problem-details path is exercised hermetically (T026).
    /// </summary>
    private sealed class InMemoryEntryServiceStub : IEntryService
    {
        private readonly Dictionary<int, EntryAggregate> _entries = new();
        private int _nextRefno = 1;

        // Legacy status codes, verbatim from findings/deepanalysis.md §4.4
        // (lines 175-191): the `status` table's natural-key set.
        private static readonly HashSet<int> LegacyStatusCodes = new()
        {
            101, 201, 251, 301, 401, 408, 411, 501, 502, 503, 509, 601,
        };

        public Task<CreateEntryResult> CreateAsync(
            int refno, CreateEntryCommand command, EntryActor actor, CancellationToken ct = default)
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
            int refno, CreateEntryCommand command, byte[] expectedRowVersion, EntryActor actor, CancellationToken ct = default)
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

    /// <summary>
    /// Faithful in-memory <see cref="IAgentService"/> fake (SPEC-0007 T014):
    /// hermetic functional tests must not touch the legacy `agents` table or
    /// the real Identity store (both point at non-routable placeholders here).
    /// Implements the full contract surface — atomic create, list with keyword
    /// filter, update, deactivate, reactivate, get-by-id — so the endpoint
    /// wiring (adm/su auth matrix, lifecycle responses, problem-details
    /// mapping) is proven hermetically. The real service behavior is covered by
    /// the unit and integration tests (AgentLifecycleTests,
    /// AgentCrudIntegrationTests).
    /// </summary>
    private sealed class InMemoryAgentServiceStub : IAgentService
    {
        private readonly Dictionary<int, AgentDetail> _agents = new();
        private readonly HashSet<string> _usernames = new(StringComparer.OrdinalIgnoreCase);
        private int _nextId = 1;

        public Task<AgentDetail> CreateAsync(
            AgentInput input, string username, string password,
            string actorUserId, string actorUserName, CancellationToken ct = default)
        {
            if (string.IsNullOrWhiteSpace(input.Companyname))
            {
                throw new AgentValidationException("companyname is required.");
            }

            if (string.IsNullOrWhiteSpace(username) || string.IsNullOrWhiteSpace(password))
            {
                throw new AgentValidationException("username and password are required.");
            }

            if (!_usernames.Add(username))
            {
                throw new AgentConflictException($"username '{username}' already exists.");
            }

            var agent = new AgentDetail(
                _nextId++, input.Companyname, input.Description, input.Street1, input.Street2,
                input.Area, input.City, input.Pincode, input.Phoneno, input.Faxno, input.Emailid,
                input.Smsno, input.Directorname, input.DirectorPH, input.AcMgrPH,
                input.VisaInchargeName, input.VisaInchargePH, input.Acno, input.Payment,
                input.TAAI, input.TAFI, input.Membership, input.IATA,
                Active: "Y", Creationdate: DateTime.Now, Enteredby: actorUserName);
            _agents[agent.Id] = agent;
            return Task.FromResult(agent);
        }

        public Task<AgentDetail> UpdateAsync(int agentId, AgentInput patch, CancellationToken ct = default)
        {
            if (!_agents.TryGetValue(agentId, out var current))
            {
                throw new AgentNotFoundException($"Agent {agentId} was not found.");
            }

            var updated = current with
            {
                Companyname = patch.Companyname,
                Description = patch.Description,
                Street1 = patch.Street1,
                Street2 = patch.Street2,
                Area = patch.Area,
                City = patch.City,
                Pincode = patch.Pincode,
                Phoneno = patch.Phoneno,
                Faxno = patch.Faxno,
                Emailid = patch.Emailid,
                Smsno = patch.Smsno,
                Directorname = patch.Directorname,
                DirectorPH = patch.DirectorPH,
                AcMgrPH = patch.AcMgrPH,
                VisaInchargeName = patch.VisaInchargeName,
                VisaInchargePH = patch.VisaInchargePH,
                Acno = patch.Acno,
                Payment = patch.Payment,
                TAAI = patch.TAAI,
                TAFI = patch.TAFI,
                Membership = patch.Membership,
                IATA = patch.IATA,
            };
            _agents[agentId] = updated;
            return Task.FromResult(updated);
        }

        public Task<AgentDetail> DeactivateAsync(
            int agentId, string actorUserId, string actorUserName, CancellationToken ct = default)
        {
            if (!_agents.TryGetValue(agentId, out var current))
            {
                throw new AgentNotFoundException($"Agent {agentId} was not found.");
            }

            var updated = current with { Active = "N" };
            _agents[agentId] = updated;
            return Task.FromResult(updated);
        }

        public Task<AgentDetail> ReactivateAsync(
            int agentId, string actorUserId, string actorUserName, CancellationToken ct = default)
        {
            if (!_agents.TryGetValue(agentId, out var current))
            {
                throw new AgentNotFoundException($"Agent {agentId} was not found.");
            }

            var updated = current with { Active = "Y" };
            _agents[agentId] = updated;
            return Task.FromResult(updated);
        }

        public Task<AgentDetail?> GetByIdAsync(int agentId, CancellationToken ct = default)
            => Task.FromResult(_agents.TryGetValue(agentId, out var agent) ? agent : null);

        public Task<AgentListResult> ListAsync(
            int page, int pageSize, string? q, CancellationToken ct = default)
        {
            IEnumerable<AgentDetail> query = _agents.Values;
            if (!string.IsNullOrWhiteSpace(q))
            {
                var needle = q.Trim();
                query = query.Where(a =>
                    (a.Companyname is not null && a.Companyname.Contains(needle))
                    || (a.Description is not null && a.Description.Contains(needle)));
            }

            var items = query.OrderBy(a => a.Companyname).ToList();
            return Task.FromResult(new AgentListResult(items, items.Count));
        }
    }

    /// <summary>
    /// Faithful in-memory <see cref="IUserManagementService"/> fake (SPEC-0007
    /// T020): hermetic functional tests must not touch the legacy `agents`
    /// table (VisaEntryDbContext points at a non-routable placeholder here).
    /// Implements the full contract surface — create with the role whitelist
    /// and the agt claim-link rule (CHK026), deactivate with the su-target
    /// rule (FR-007), su-only provisioning (FR-006) — so the endpoint wiring
    /// (adm/emp auth matrix, su-only policy, problem-details mapping) is proven
    /// hermetically. The real service behavior is covered by the unit and
    /// integration tests (UserManagementTests, UserManagementIntegrationTests).
    ///
    /// The user row is created in the InMemory Identity store (the same store
    /// the seeded test users live in) so the endpoint's username→id resolution
    /// (FindByNameAsync) and the actor resolution (GetRolesAsync) work against
    /// one consistent store. The audit-log write is skipped here — it is
    /// covered by the unit and integration tests.
    /// </summary>
    private sealed class InMemoryUserManagementServiceStub : IUserManagementService
    {
        private static readonly string[] CreateWhitelist = { "adm", "emp", "agt", "guest" };

        private readonly IServiceProvider _services;
        private readonly Dictionary<string, UserSummary> _users = new();
        private readonly HashSet<string> _usernames = new(StringComparer.OrdinalIgnoreCase);

        public InMemoryUserManagementServiceStub(IServiceProvider services) => _services = services;

        public async Task<UserSummary> CreateAsync(
            CreateUserInput input, string actorUserId, string actorUserName,
            CancellationToken ct = default)
        {
            var username = input.Username?.Trim() ?? string.Empty;
            if (string.IsNullOrWhiteSpace(username))
            {
                throw new UserManagementValidationException("username is required.");
            }

            if (string.IsNullOrWhiteSpace(input.Password))
            {
                throw new UserManagementValidationException("password is required.");
            }

            var role = input.Role?.Trim() ?? string.Empty;
            if (!CreateWhitelist.Contains(role, StringComparer.OrdinalIgnoreCase))
            {
                throw new UserManagementValidationException(
                    $"role '{role}' is not creatable; allowed roles: adm, emp, agt, guest.");
            }

            if (role == "agt" && input.AgentId is null)
            {
                throw new UserManagementValidationException("agentId is required when role is agt.");
            }

            if (!_usernames.Add(username))
            {
                throw new UserManagementConflictException($"username '{username}' already exists.");
            }

            // Mirror the real service: the user row lives in the Identity store.
            using var scope = _services.CreateScope();
            var userManager = scope.ServiceProvider
                .GetRequiredService<UserManager<IdentityIntegration.VisaFusionUser>>();
            var user = new IdentityIntegration.VisaFusionUser
            {
                UserName = username,
                Email = input.Email,
                AgentId = role == "agt" ? input.AgentId : null,
            };
            var createResult = await userManager.CreateAsync(user, input.Password);
            if (!createResult.Succeeded)
            {
                throw new UserManagementValidationException(
                    string.Join("; ", createResult.Errors.Select(e => e.Description)));
            }

            var roleResult = await userManager.AddToRoleAsync(user, role);
            if (!roleResult.Succeeded)
            {
                await userManager.DeleteAsync(user);
                throw new UserManagementValidationException(
                    string.Join("; ", roleResult.Errors.Select(e => e.Description)));
            }

            var summary = new UserSummary(
                user.Id, user.UserName ?? string.Empty, user.Email, new[] { role }, Active: true);
            _users[user.Id] = summary;
            return summary;
        }

        public async Task<UserSummary> DeactivateAsync(
            string userId, string actorUserId, string actorUserName,
            IReadOnlyList<string> actorRoles, CancellationToken ct = default)
        {
            if (!_users.TryGetValue(userId, out var current))
            {
                throw new UserManagementNotFoundException($"User {userId} was not found.");
            }

            // FR-007: only a super-user can deactivate a super-user account.
            if (current.Roles.Contains("su", StringComparer.OrdinalIgnoreCase)
                && !actorRoles.Contains("su", StringComparer.OrdinalIgnoreCase))
            {
                throw new UserManagementValidationException(
                    "Only a super-user can deactivate a super-user account.");
            }

            // Mirror the real service (FR-023): lock the Identity login so the
            // user-management list page (which reads the Identity store) shows
            // the Deactivated badge.
            using var scope = _services.CreateScope();
            var userManager = scope.ServiceProvider
                .GetRequiredService<UserManager<IdentityIntegration.VisaFusionUser>>();
            var user = await userManager.FindByIdAsync(userId);
            if (user is not null)
            {
                user.LockoutEnabled = true;
                user.LockoutEnd = DateTimeOffset.MaxValue;
                await userManager.UpdateAsync(user);
            }

            var updated = current with { Active = false };
            _users[userId] = updated;
            return updated;
        }

        public Task<UserSummary> ProvisionSuperUserAsync(
            string userId, string actorUserId, string actorUserName,
            IReadOnlyList<string> actorRoles, CancellationToken ct = default)
        {
            // FR-006: only a super-user can provision a super-user account.
            if (!actorRoles.Contains("su", StringComparer.OrdinalIgnoreCase))
            {
                throw new UserManagementValidationException(
                    "Only a super-user can provision a super-user account.");
            }

            if (!_users.TryGetValue(userId, out var current))
            {
                throw new UserManagementNotFoundException($"User {userId} was not found.");
            }

            var roles = current.Roles.Append("su").Distinct(StringComparer.OrdinalIgnoreCase).ToList();
            var updated = current with { Roles = roles };
            _users[userId] = updated;
            return Task.FromResult(updated);
        }
    }
}
