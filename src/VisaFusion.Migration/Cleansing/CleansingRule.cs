using VisaFusion.Migration.Configuration;

namespace VisaFusion.Migration.Cleansing;

/// <summary>Result of applying one cleansing rule.</summary>
public sealed record CleansingResult(string Rule, string Table, string Action, int RowsAffected);

/// <summary>
/// Base for an approved cleansing rule (SPEC-0004 FR-005, BR-005).
/// A rule runs only when its recorded sign-off is present (approver + date).
/// Rules operate on the TARGET database after copy.
/// </summary>
public abstract class CleansingRule
{
    protected CleansingRule(MigrationOptions options) => Options = options;

    public MigrationOptions Options { get; }

    /// <summary>Rule id: a | b | c | d.</summary>
    public abstract string RuleId { get; }

    /// <summary>The sign-off gate for this rule.</summary>
    protected abstract SignOff SignOff { get; }

    public bool IsApproved => SignOff.Approved;

    /// <summary>Applies the rule; returns the recorded action result.</summary>
    public abstract Task<CleansingResult> ApplyAsync(CleansingContext context, CancellationToken ct = default);

    protected Reporting.CleansingAction.SignOffRecord ToSignOffRecord()
        => new()
        {
            By = Options.Operator,
            Approver = SignOff.Approver,
            Date = SignOff.Date
        };
}

/// <summary>Context for cleansing execution (target database access).</summary>
public sealed class CleansingContext
{
    public required Microsoft.Data.SqlClient.SqlConnection Target { get; init; }
    public required VisaFusion.Migration.Snapshot.SnapshotBaseline Baseline { get; init; }
}
