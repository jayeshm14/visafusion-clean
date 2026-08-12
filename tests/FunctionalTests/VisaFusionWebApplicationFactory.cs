using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc.Testing;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.DependencyInjection.Extensions;
using Microsoft.Extensions.Hosting;
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
}
