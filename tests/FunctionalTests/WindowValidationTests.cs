using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Logging.Abstractions;
using VisaFusion.Migration.Commands;
using VisaFusion.Migration.Configuration;
using VisaFusion.Migration.Reporting;
using VisaFusion.Migration.Snapshot;

namespace VisaFusion.FunctionalTests;

/// <summary>
/// Maintenance-window validation tests (SPEC-0004 T053, NFR-002).
///
/// NFR-002: the full migration + validation must complete within a maintenance
/// window acceptable to the business (target: under 4 hours). These tests
/// verify the window contract: the default window is 4 hours, and preflight
/// records the offline window as [run start, run start + configured window]
/// (the config-driven recording itself is covered by PreflightTests with the
/// default 4-hour value; here a non-default window proves the recording is
/// driven by configuration, not hardcoded). The full end-to-end timing
/// verification runs in the cutover rehearsal (blocked until the GAP-0002
/// decision and the pre-migration backup are provided).
/// </summary>
public class WindowValidationTests
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

    [Fact]
    public void Default_Maintenance_Window_Is_Four_Hours()
    {
        // NFR-002 target: under 4 hours for the full 52-table surface.
        var options = new MigrationOptions();
        Assert.Equal(4, options.MaintenanceWindowHours);
    }

    [Fact]
    public async Task Preflight_Records_The_Offline_Window_From_The_Configured_Value()
    {
        if (!ServersReachable()) return;

        var dir = Path.Combine(Path.GetTempPath(), "visafusion-window-tests", Guid.NewGuid().ToString("N"));
        Directory.CreateDirectory(dir);
        try
        {
            File.WriteAllText(Path.Combine(dir, "VisaEntry-pre-migration.bak"), "dummy");
            File.WriteAllText(Path.Combine(dir, "legacy-app-offline.marker"), "stopped");

            // A non-default window proves the recorded window is driven by
            // configuration (MigrationOptions.MaintenanceWindowHours), not a
            // hardcoded 4-hour constant.
            var options = new MigrationOptions
            {
                LegacyConnectionString = LegacyConnectionString,
                TargetConnectionString = TargetConnectionString,
                BackupDirectory = dir,
                Operator = "test-operator",
                MaintenanceWindowHours = 6,
                SignOffs = AllSignOffs()
            };

            var command = new PreflightCommand(options, NullLogger<PreflightCommand>.Instance);
            var context = new StepContext
            {
                RunState = new RunState(),
                Baseline = new SnapshotBaseline(),
                Report = new MigrationReport()
            };
            await command.ExecuteAsync(context);

            Assert.NotNull(context.Report.OfflineWindow);
            Assert.Equal(context.RunStartedAtUtc, context.Report.OfflineWindow.WindowStart);
            Assert.Equal(context.RunStartedAtUtc.AddHours(6), context.Report.OfflineWindow.WindowEnd);
        }
        finally
        {
            Directory.Delete(dir, recursive: true);
        }
    }

    private static CleansingSignOffs AllSignOffs() => new()
    {
        Status508 = new SignOff { Approver = "owner", Date = "2026-08-09" },
        EntryTypeDefault = new SignOff { Approver = "owner", Date = "2026-08-09" },
        OrphanAgent = new SignOff { Approver = "owner", Date = "2026-08-09" },
        JunkDateClamp = new SignOff { Approver = "owner", Date = "2026-08-09" },
        Agents4114 = new SignOff { Approver = "owner", Date = "2026-08-09" }
    };
}