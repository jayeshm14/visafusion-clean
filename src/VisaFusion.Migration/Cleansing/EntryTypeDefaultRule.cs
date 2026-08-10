using VisaFusion.Migration.Configuration;

namespace VisaFusion.Migration.Cleansing;

/// <summary>
/// Cleansing rule (b) — default the 100%-NULL `Mainentry.entrytype`
/// (FR-005b). The legacy column carries no historical data (100% NULL).
/// Pending the owner-provided default value (GAP-0001 §4.2) the rule is applied
/// as a documented no-op: NULL is preserved verbatim (FR-002) and the FK stays
/// nullable. When the owner supplies a value it is set here in a subsequent
/// approved run.
/// </summary>
public sealed class EntryTypeDefaultRule : CleansingRule
{
    public EntryTypeDefaultRule(MigrationOptions options) : base(options) { }

    public override string RuleId => "b";

    protected override SignOff SignOff => Options.SignOffs.EntryTypeDefault;

    public override Task<CleansingResult> ApplyAsync(CleansingContext context, CancellationToken ct = default)
    {
        // FR-005b is approved as "default the 100%-NULL column", but the default
        // VALUE was not recorded in the approval. Per the deterministic rule, no
        // value is invented (GAP-0001 §4.2): the rule is a recorded no-op.
        return Task.FromResult(new CleansingResult(
            RuleId,
            "Mainentry",
            "entrytype default: no value recorded in approval — NULL preserved verbatim (GAP-0001 §4.2)",
            0));
    }
}
