namespace VisaFusion.Migration.Copy;

/// <summary>
/// A copy-time row transform applied to a single legacy table as it is read
/// by <see cref="BulkCopyEngine"/>. Copy-time transforms exist ONLY where a
/// target PK/UNIQUE constraint would reject raw legacy rows before the
/// post-copy cleanse step runs (the cleanse runs after copy, so it cannot
/// repair a row the copy itself refuses to insert). Every transform MUST be
/// backed by a documented, sign-off-gated cleansing rule in SPEC-0004
/// (library/01 §deterministic-rules: never guess; legacy behavior is truth).
/// </summary>
public abstract record CopyTransform
{
    /// <summary>Legacy table name this transform applies to.</summary>
    public abstract string LegacyTable { get; }

    /// <summary>Human-readable identifier matching the cleansing rule id.</summary>
    public abstract string RuleId { get; }

    /// <summary>
    /// Produces the legacy source SELECT (over the given column list) so it
    /// yields exactly the rows the target schema accepts. Implementations must
    /// be deterministic (same input yields the same rows) and traceable to the
    /// approved rule.
    /// </summary>
    public abstract string Apply(string columnList);

    /// <summary>
    /// Deduplicates a legacy table on a single key column, keeping one row per
    /// key value. The surviving row is the one ranked first by
    /// <c>ROW_NUMBER() OVER (PARTITION BY [key] ORDER BY [key])</c> — the exact
    /// expression the approved post-copy cleansing rule uses, so the copy-time
    /// transform and the post-copy rule agree on which row survives.
    /// </summary>
    public sealed record DeduplicateOn : CopyTransform
    {
        public DeduplicateOn(string legacyTable, string keyColumn, string ruleId)
        {
            LegacyTable = legacyTable;
            KeyColumn = keyColumn;
            RuleId = ruleId;
        }

        public override string LegacyTable { get; }

        /// <summary>Key column to deduplicate on (e.g. statusID).</summary>
        public string KeyColumn { get; }

        public override string RuleId { get; }

        public override string Apply(string columnList) => $"""
            SELECT {columnList}
            FROM (
                SELECT {columnList}, ROW_NUMBER() OVER (PARTITION BY [{KeyColumn}] ORDER BY [{KeyColumn}]) AS [vf_rn]
                FROM [{LegacyTable}]
            ) AS [vf_src]
            WHERE [vf_rn] = 1
            """;
    }
}
