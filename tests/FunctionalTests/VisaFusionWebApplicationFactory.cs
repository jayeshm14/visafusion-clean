using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc.Testing;
using Microsoft.Extensions.Configuration;
using VisaFusion.Web;

namespace VisaFusion.FunctionalTests;

/// <summary>
/// WebApplicationFactory for the VisaFusion single-process host (SPEC-0003 T024).
///
/// Overrides configuration so functional tests do not depend on a live SQL Server:
/// the Serilog SQL sink and EF Core connection are pointed at a non-routable
/// placeholder, and the SQL sink is disabled to keep tests hermetic.
/// </summary>
public class VisaFusionWebApplicationFactory : WebApplicationFactory<Program>
{
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
    }
}