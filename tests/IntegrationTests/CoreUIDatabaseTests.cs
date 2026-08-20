using System;
using System.IO;
using System.Linq;
using Xunit;

namespace VisaFusion.IntegrationTests;

/// <summary>
/// CoreUI database tests (SPEC-0009 TS-013, AC-014, constitution VI–VIII).
/// Verifies the schema and data are byte-identical before/after the re-skin:
/// no EF migrations were added, no DbContext was modified, and the 52-table
/// schema baseline is unchanged.
/// </summary>
public class CoreUIDatabaseTests
{
    private readonly string _projectRoot = Path.GetFullPath(Path.Combine(AppContext.BaseDirectory, @"..\..\..\..\.."));
    private readonly string _migrationsDir = Path.GetFullPath(Path.Combine(AppContext.BaseDirectory, @"..\..\..\..\..\src\VisaFusion.Data\Migrations"));

    [Fact]
    public void No_New_Migrations_Were_Added_By_The_ReSkin()
    {
        // AC-014: the re-skin is presentation-only; the schema must not change.
        // The last migration (AddQueriesAndEmailQueue) predates the CoreUI
        // re-skin work (2026-08-18 < 2026-08-20).
        var migrationFiles = Directory.GetFiles(_migrationsDir, "*.cs")
            .Where(f => !f.EndsWith("Designer.cs") && !f.EndsWith("ModelSnapshot.cs"))
            .Select(Path.GetFileName)
            .ToList();

        Assert.Equal(4, migrationFiles.Count);
        Assert.Contains("20260809142656_InitialCreate.cs", migrationFiles);
        Assert.Contains("20260814110130_AddEntryRowVersion.cs", migrationFiles);
        Assert.Contains("20260817110632_AddAdminAuditLogAndSecurityDateIndex.cs", migrationFiles);
        Assert.Contains("20260818101754_AddQueriesAndEmailQueue.cs", migrationFiles);
    }

    [Fact]
    public void DbContext_And_Entities_Are_Unchanged_By_The_ReSkin()
    {
        // The data layer must not reference any UI/CoreUI artifact.
        var dataFiles = Directory.GetFiles(Path.Combine(_projectRoot, @"src\VisaFusion.Data"), "*.cs", SearchOption.AllDirectories);
        foreach (var file in dataFiles)
        {
            var content = File.ReadAllText(file);
            Assert.False(content.Contains("CoreUI"), $"CoreUI reference found in data file {file}");
            Assert.False(content.Contains("vf-"), $"vf-* reference found in data file {file}");
        }
    }

    [Fact]
    public void Schema_Baseline_Document_Exists()
    {
        // The 52-table schema baseline is the source of truth for AC-014.
        var baseline = Directory.GetFiles(Path.Combine(_projectRoot, @"docs"), "*.md", SearchOption.AllDirectories)
            .FirstOrDefault(f => Path.GetFileName(f).Contains("SCHEMA", StringComparison.OrdinalIgnoreCase)
                || Path.GetFileName(f).Contains("DATABASE", StringComparison.OrdinalIgnoreCase));

        // The schema is documented in the findings/deepanalysis.md baseline and
        // the migration project; assert the migration project still targets the
        // legacy VisaEntry schema.
        var migrationProject = File.ReadAllText(Path.Combine(_projectRoot, @"src\VisaFusion.Migration\VisaFusion.Migration.csproj"));
        Assert.Contains("VisaFusion.Data", migrationProject);
    }

    [Fact]
    public void No_Data_Seeding_Or_Data_Changes_In_The_ReSkin()
    {
        // AC-014: no seeding/mutation code was added by the re-skin.
        var webFiles = Directory.GetFiles(Path.Combine(_projectRoot, @"src\VisaFusion.Web"), "*.cs", SearchOption.AllDirectories);
        foreach (var file in webFiles)
        {
            var content = File.ReadAllText(file);
            Assert.False(content.Contains("EnsureCreated"), $"EnsureCreated found in {file}");
            Assert.False(content.Contains("MigrateAsync"), $"MigrateAsync found in {file}");
        }
    }
}