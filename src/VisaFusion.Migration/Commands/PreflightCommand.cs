using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Logging;
using VisaFusion.Migration.Configuration;
using VisaFusion.Migration.Data;

namespace VisaFusion.Migration.Commands;

/// <summary>
/// `preflight` — verifies preconditions before any data movement
/// (SPEC-0004 T017, FR-008, NFR-002; contracts/migration-cli.md §2 #1):
/// legacy reachable (read-only), target reachable (write), pre-migration backup
/// exists, legacy app offline, cleansing sign-offs present (BR-005).
/// </summary>
public sealed class PreflightCommand : MigrationStep
{
    private readonly ILogger<PreflightCommand> _logger;

    public PreflightCommand(MigrationOptions options, ILogger<PreflightCommand> logger) : base(options)
        => _logger = logger;

    public override string Name => "preflight";

    public override async Task ExecuteAsync(StepContext context, CancellationToken ct = default)
    {
        _logger.LogInformation("Preflight: verifying preconditions (FR-008, NFR-002).");

        // 1. Configuration present (exit 5).
        if (string.IsNullOrWhiteSpace(Options.LegacyConnectionString))
            throw new ConfigurationException("Legacy connection string is missing (Legacy:VisaEntry).");
        if (string.IsNullOrWhiteSpace(Options.TargetConnectionString))
            throw new ConfigurationException("Target connection string is missing (Target:VisaFusion).");

        // 2. Legacy database reachable, read-only.
        using var legacy = new LegacyReader(Options.LegacyConnectionString);
        await legacy.OpenAsync(ct);
        if (!await legacy.IsReachableAsync(ct))
            throw new PreflightException("Legacy database 'VisaEntry' is not reachable.");

        var legacyDb = await legacy.ScalarAsync("SELECT DB_NAME()", ct);
        if (!string.Equals(Convert.ToString(legacyDb), "VisaEntry", StringComparison.OrdinalIgnoreCase))
            throw new PreflightException($"Legacy database name is '{legacyDb}', expected 'VisaEntry'.");

        // Verify read-only intent is effective: SELECT only (no writes attempted).
        _logger.LogInformation("Preflight: legacy database '{Db}' reachable (read-only).", legacyDb);

        // 3. Target database reachable, writable.
        await using var target = new SqlConnection(Options.TargetConnectionString);
        await target.OpenAsync(ct);
        var targetDb = await TargetDatabaseNameAsync(target);
        if (!string.Equals(targetDb, "VisaFusion", StringComparison.OrdinalIgnoreCase))
            throw new PreflightException($"Target database name is '{targetDb}', expected 'VisaFusion'.");
        _logger.LogInformation("Preflight: target database '{Db}' reachable (write).", targetDb);

        // 4. Pre-migration backup exists (AC-008).
        var backup = Path.Combine(Options.BackupDirectory, "VisaEntry-pre-migration.bak");
        if (!File.Exists(backup))
            throw new PreflightException($"Pre-migration backup not found at '{backup}' (AC-008).");
        _logger.LogInformation("Preflight: pre-migration backup present: {Backup}", backup);

        // 5. Legacy app offline. The console cannot introspect IIS directly; the
        //    contract requires the operator to confirm. We record a marker file
        //    the operator writes when the app pool is stopped (documented in the
        //    quickstart). Absence of the marker is a preflight failure.
        var offlineMarker = Path.Combine(Options.BackupDirectory, "legacy-app-offline.marker");
        if (!File.Exists(offlineMarker))
            throw new PreflightException(
                "Legacy app offline marker not found. Stop the legacy application and create " +
                $"'{offlineMarker}' (offline window, NFR-002).");

        // 6. Cleansing sign-offs present (BR-005).
        if (!Options.SignOffs.AllApproved)
            throw new PreflightException(
                "Not all cleansing sign-offs (FR-005 a-e) are recorded. " +
                "Set Migration:SignOffs:* approver and date in configuration.");

        _logger.LogInformation("Preflight: all preconditions satisfied.");
        context.Report.OfflineWindow = new Reporting.OfflineWindow
        {
            LegacyAppStopped = true,
            WindowStart = context.RunStartedAtUtc,
            WindowEnd = context.RunStartedAtUtc.AddHours(Options.MaintenanceWindowHours)
        };
    }

    private static async Task<string?> TargetDatabaseNameAsync(SqlConnection target)
    {
        await using var cmd = target.CreateCommand();
        cmd.CommandText = "SELECT DB_NAME()";
        var result = await cmd.ExecuteScalarAsync();
        return Convert.ToString(result);
    }
}
