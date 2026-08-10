using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Logging.Abstractions;
using VisaFusion.Migration.Commands;
using VisaFusion.Migration.Configuration;
using VisaFusion.Migration.Reporting;
using VisaFusion.Migration.Snapshot;

namespace VisaFusion.IntegrationTests;

/// <summary>
/// Preflight integration tests (SPEC-0004 T015, FR-008, NFR-002).
///
/// Verifies the preflight precondition checks against the LIVE legacy
/// `VisaEntry` and target `VisaFusion` databases: missing pre-migration backup
/// (AC-008), missing offline marker (NFR-002), missing cleansing sign-offs
/// (BR-005), and the passing path that records the offline window. Tests skip
/// when SQL Server is unreachable (same convention as <see cref="CopyTests"/>).
/// </summary>
public class PreflightTests
{
    private const string DefaultLegacyConnectionString =
        "Server=localhost;Database=VisaEntry;Trusted_Connection=True;TrustServerCertificate=True;MultipleActiveResultSets=true";
    private const string DefaultTargetConnectionString =
        "Server=localhost;Database=VisaFusion;Trusted_Connection=True;TrustServerCertificate=True;MultipleActiveResultSets=true";

    private static string LegacyConnectionString =>
        Environment.GetEnvironmentVariable("VISAENTRY_TEST_CONNECTION") ?? DefaultLegacyConnectionString;

    private static string TargetConnectionString =>
        Environment.GetEnvironmentVariable("VISA_FUSION_TEST_CONNECTION") ?? DefaultTargetConnectionString;

    private static bool ServersReachable()
    {
        try
        {
            using var legacy = new SqlConnection(LegacyConnectionString);
            legacy.Open();
            using var target = new SqlConnection(TargetConnectionString);
            target.Open();
            return true;
        }
        catch
        {
            return false;
        }
    }

    private static MigrationOptions Options(string backupDir) => new()
    {
        LegacyConnectionString = LegacyConnectionString,
        TargetConnectionString = TargetConnectionString,
        BackupDirectory = backupDir,
        Operator = "test-operator",
        SignOffs = AllSignOffs()
    };

    private static CleansingSignOffs AllSignOffs() => new()
    {
        Status508 = new SignOff { Approver = "owner", Date = "2026-08-09" },
        EntryTypeDefault = new SignOff { Approver = "owner", Date = "2026-08-09" },
        OrphanAgent = new SignOff { Approver = "owner", Date = "2026-08-09" },
        JunkDateClamp = new SignOff { Approver = "owner", Date = "2026-08-09" },
        Agents4114 = new SignOff { Approver = "owner", Date = "2026-08-09" }
    };

    private static StepContext Context() => new()
    {
        RunState = new RunState(),
        Baseline = new SnapshotBaseline(),
        Report = new MigrationReport()
    };

    private static string CreateTempDir()
    {
        var dir = Path.Combine(Path.GetTempPath(), "visafusion-preflight-tests", Guid.NewGuid().ToString("N"));
        Directory.CreateDirectory(dir);
        return dir;
    }

    [Fact]
    public async Task Preflight_Fails_When_Pre_Migration_Backup_Missing()
    {
        if (!ServersReachable()) return;
        var dir = CreateTempDir();
        try
        {
            var command = new PreflightCommand(Options(dir), NullLogger<PreflightCommand>.Instance);
            var ex = await Assert.ThrowsAsync<PreflightException>(() => command.ExecuteAsync(Context()));
            Assert.Contains("Pre-migration backup not found", ex.Message);
            Assert.Contains("AC-008", ex.Message);
        }
        finally
        {
            Directory.Delete(dir, recursive: true);
        }
    }

    [Fact]
    public async Task Preflight_Fails_When_Offline_Marker_Missing()
    {
        if (!ServersReachable()) return;
        var dir = CreateTempDir();
        try
        {
            File.WriteAllText(Path.Combine(dir, "VisaEntry-pre-migration.bak"), "dummy");
            var command = new PreflightCommand(Options(dir), NullLogger<PreflightCommand>.Instance);
            var ex = await Assert.ThrowsAsync<PreflightException>(() => command.ExecuteAsync(Context()));
            Assert.Contains("offline marker", ex.Message);
        }
        finally
        {
            Directory.Delete(dir, recursive: true);
        }
    }

    [Fact]
    public async Task Preflight_Fails_When_Cleansing_Sign_Offs_Missing()
    {
        if (!ServersReachable()) return;
        var dir = CreateTempDir();
        try
        {
            File.WriteAllText(Path.Combine(dir, "VisaEntry-pre-migration.bak"), "dummy");
            File.WriteAllText(Path.Combine(dir, "legacy-app-offline.marker"), "stopped");

            var options = Options(dir);
            options.SignOffs = new CleansingSignOffs(); // none approved (BR-005)
            var command = new PreflightCommand(options, NullLogger<PreflightCommand>.Instance);
            var ex = await Assert.ThrowsAsync<PreflightException>(() => command.ExecuteAsync(Context()));
            Assert.Contains("sign-offs", ex.Message);
        }
        finally
        {
            Directory.Delete(dir, recursive: true);
        }
    }

    [Fact]
    public async Task Preflight_Passes_And_Records_The_Offline_Window()
    {
        if (!ServersReachable()) return;
        var dir = CreateTempDir();
        try
        {
            File.WriteAllText(Path.Combine(dir, "VisaEntry-pre-migration.bak"), "dummy");
            File.WriteAllText(Path.Combine(dir, "legacy-app-offline.marker"), "stopped");

            var command = new PreflightCommand(Options(dir), NullLogger<PreflightCommand>.Instance);
            var context = Context();
            await command.ExecuteAsync(context);

            Assert.NotNull(context.Report.OfflineWindow);
            Assert.True(context.Report.OfflineWindow.LegacyAppStopped);
            Assert.Equal(context.RunStartedAtUtc, context.Report.OfflineWindow.WindowStart);
            Assert.Equal(context.RunStartedAtUtc.AddHours(4), context.Report.OfflineWindow.WindowEnd);
        }
        finally
        {
            Directory.Delete(dir, recursive: true);
        }
    }
}