using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Design;
using Microsoft.Extensions.Configuration;

namespace VisaFusion.Data.Persistence;

/// <summary>
/// Design-time factory for `dotnet ef` tooling (SPEC-0004 T021). The migration
/// tooling reads the target connection string from configuration the same way
/// the console does (env/user-secrets/appsettings) — never hardcoded.
/// </summary>
public sealed class VisaEntryDbContextFactory : IDesignTimeDbContextFactory<VisaEntryDbContext>
{
    public VisaEntryDbContext CreateDbContext(string[] args)
    {
        var configuration = new ConfigurationBuilder()
            .AddJsonFile("appsettings.json", optional: true)
            .AddUserSecrets<VisaEntryDbContextFactory>(optional: true)
            .AddEnvironmentVariables()
            .Build();

        var connectionString = configuration["Target:VisaFusion"]
            ?? configuration["ConnectionStrings:VisaFusion"];

        var options = new DbContextOptionsBuilder<VisaEntryDbContext>()
            .UseSqlServer(connectionString, sql => sql.MigrationsAssembly("VisaFusion.Data"))
            .Options;

        return new VisaEntryDbContext(options);
    }
}
