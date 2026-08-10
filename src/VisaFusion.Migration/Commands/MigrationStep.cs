using VisaFusion.Migration.Configuration;

namespace VisaFusion.Migration.Commands;

/// <summary>Exit codes per contracts/migration-cli.md §4.</summary>
public static class ExitCodes
{
    public const int Success = 0;
    public const int PreflightFailure = 1;
    public const int StepFailure = 2;
    public const int ValidationFailure = 3;
    public const int IntegrityViolation = 4;
    public const int ConfigurationError = 5;
}

/// <summary>Base class for a migration step command (SPEC-0004 T009).</summary>
public abstract class MigrationStep
{
    protected MigrationStep(MigrationOptions options) => Options = options;

    public MigrationOptions Options { get; }

    /// <summary>The step name as used in the fixed command order.</summary>
    public abstract string Name { get; }

    /// <summary>
    /// Executes the step. Throws <see cref="PreflightException"/> to signal
    /// preflight failure (exit 1) or <see cref="IntegrityException"/> to signal
    /// fail-fast integrity violation (exit 4). Any other exception is a step
    /// failure (exit 2).
    /// </summary>
    public abstract Task ExecuteAsync(StepContext context, CancellationToken ct = default);

    public override string ToString() => Name;
}

/// <summary>Thrown by preflight when a precondition fails (exit 1).</summary>
public sealed class PreflightException : Exception
{
    public PreflightException(string message) : base(message) { }
}

/// <summary>Thrown on fail-fast referential-integrity violation (exit 4).</summary>
public sealed class IntegrityException : Exception
{
    public IntegrityException(string message) : base(message) { }
}

/// <summary>
/// Thrown by the copy step when the legacy source contains a duplicate key
/// that the target PK/UNIQUE schema rejects and no documented, sign-off-gated
/// copy-time transform resolves it (exit 2, same as any step failure).
/// This is the deterministic "do not guess" path: an undocumented
/// data-quality gap must stop the migration with a precise report rather than
/// a raw SqlBulkCopy constraint error mid-stream.
/// </summary>
public sealed class DataQualityGapException : Exception
{
    /// <summary>Gap identifier, e.g. "GAP-0002".</summary>
    public string GapId { get; }

    /// <summary>Legacy table that contains the violation.</summary>
    public string LegacyTable { get; }

    /// <summary>Key column and offending value (or null for composite/summary).</summary>
    public string? KeyColumn { get; }

    public string? KeyValue { get; }

    public DataQualityGapException(string gapId, string legacyTable, string message,
        string? keyColumn = null, string? keyValue = null)
        : base(message)
    {
        GapId = gapId;
        LegacyTable = legacyTable;
        KeyColumn = keyColumn;
        KeyValue = keyValue;
    }
}

/// <summary>Context shared across the steps of one migration run.</summary>
public sealed class StepContext
{
    public required RunState RunState { get; init; }
    public required Snapshot.SnapshotBaseline Baseline { get; set; }
    public required Reporting.MigrationReport Report { get; init; }
    public DateTime RunStartedAtUtc { get; init; } = DateTime.UtcNow;
}
