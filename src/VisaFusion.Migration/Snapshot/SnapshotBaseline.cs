namespace VisaFusion.Migration.Snapshot;

/// <summary>One table's static baseline row (snapshot step, FR-009).
/// Checksum is the exact decimal string from <see cref="Validation.ChecksumSql"/>
/// (a decimal(38,0) aggregate that may exceed Int64 for large tables).</summary>
public sealed record SnapshotRow(string LegacyTable, long RowCount, string Checksum);

/// <summary>
/// The static snapshot baseline captured by the `snapshot` step before any copy
/// (contracts/migration-cli.md §2 #2). Used by `validate` to compare source vs
/// target after copy (AC-002) and to prove the legacy was untouched (FR-008,
/// AC-006 — compare snapshot before and after).
/// </summary>
public sealed class SnapshotBaseline
{
    public string RunId { get; set; } = string.Empty;
    public DateTime CapturedAtUtc { get; set; } = DateTime.UtcNow;
    public List<SnapshotRow> Tables { get; set; } = new();

    public SnapshotRow? Get(string legacyTable)
        => Tables.FirstOrDefault(t => string.Equals(t.LegacyTable, legacyTable, StringComparison.OrdinalIgnoreCase));
}
