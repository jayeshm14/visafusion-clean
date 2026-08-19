using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Migrations;
using Microsoft.EntityFrameworkCore.Migrations.Operations;
using VisaFusion.Data.Migrations;
using VisaFusion.Data.Persistence;

using EfMigration = Microsoft.EntityFrameworkCore.Migrations.Migration;

namespace VisaFusion.IntegrationTests;

/// <summary>
/// Migration reversibility tests (SPEC-0008 T010, constitution gate III).
///
/// The SPEC-0008 migration creates exactly two NEW additive tables (`queries`,
/// `emailQueue`) and nothing else — no existing table is altered (spec §16
/// "No change"). The Up/Down operation sets are inspected directly from the
/// compiled migration, and the generated Up/Down SQL scripts are asserted to
/// contain exactly the expected CREATE/DROP statements. Both checks are
/// hermetic (no database connection required).
/// </summary>
public class MigrationReversibilityTests
{
    private const string DefaultTargetConnectionString =
        "Server=localhost;Database=VisaFusion;Trusted_Connection=True;TrustServerCertificate=True;MultipleActiveResultSets=true";

    private const string PriorMigrationId = "20260817110632_AddAdminAuditLogAndSecurityDateIndex";
    private const string AdditiveMigrationId = "20260818101754_AddQueriesAndEmailQueue";

    private static string TargetConnectionString =>
        Environment.GetEnvironmentVariable("VISA_FUSION_TEST_CONNECTION") ?? DefaultTargetConnectionString;

    private static EfMigration CompiledMigration() => new AddQueriesAndEmailQueue();

    [Fact]
    public void Up_Only_Creates_The_Two_New_Tables()
    {
        var up = CompiledMigration().UpOperations;

        var creates = up.OfType<CreateTableOperation>().ToList();
        Assert.Equal(2, creates.Count);
        Assert.Contains(creates, t => t.Name == "queries");
        Assert.Contains(creates, t => t.Name == "emailQueue");

        // Every other operation is additive metadata (index/FK on the new
        // tables) — nothing alters an existing table.
        Assert.All(up, op => Assert.True(
            op is CreateTableOperation or CreateIndexOperation,
            $"Unexpected Up operation: {op.GetType().Name}"));
    }

    [Fact]
    public void Down_Drops_Exactly_The_Two_New_Tables()
    {
        var down = CompiledMigration().DownOperations;
        var drops = down.OfType<DropTableOperation>().ToList();
        Assert.Equal(2, drops.Count);
        Assert.Contains(drops, t => t.Name == "queries");
        Assert.Contains(drops, t => t.Name == "emailQueue");
    }

    [Fact]
    public void Generated_Up_And_Down_Scripts_Are_Symmetric()
    {
        var options = new DbContextOptionsBuilder<VisaEntryDbContext>()
            .UseSqlServer(TargetConnectionString)
            .Options;
        using var context = new VisaEntryDbContext(options);
        var migrator = context.GetService<IMigrator>();

        // Up direction (prior -> additive): creates both tables.
        var upScript = migrator.GenerateScript(PriorMigrationId, AdditiveMigrationId);
        Assert.Contains("CREATE TABLE [queries]", upScript);
        Assert.Contains("CREATE TABLE [emailQueue]", upScript);

        // Down direction (additive -> prior): drops both tables.
        var downScript = migrator.GenerateScript(AdditiveMigrationId, PriorMigrationId);
        Assert.Contains("DROP TABLE [queries]", downScript);
        Assert.Contains("DROP TABLE [emailQueue]", downScript);
    }
}
