using Microsoft.Data.SqlClient;
using VisaFusion.Migration.Catalog;

namespace VisaFusion.Migration.Copy;

/// <summary>One detected duplicate key violation in a legacy table.</summary>
public sealed record DuplicateKeyViolation(
    string LegacyTable,
    string TargetTable,
    string KeyColumn,
    string KeyValue,
    int RowCount)
{
    public override string ToString()
        => $"{LegacyTable}.{KeyColumn} = {KeyValue} appears {RowCount} times (target PK {TargetTable}.{KeyColumn})";
}

/// <summary>
/// Pre-copy guard that scans the legacy source for duplicate values on the
/// TARGET primary-key columns (the target PK is authoritative — SPEC-0004
/// data-model.md §3.1/§3.2). The copy step runs this for every migrated table
/// BEFORE writing anything, so a data-quality gap is detected as a precise,
/// actionable error instead of a raw PK-constraint violation from
/// SqlBulkCopy mid-stream.
///
/// Surrogate-key tables (target PK is a generated `Id` that has no legacy
/// counterpart) are skipped: no legacy key columns exist to scan.
///
/// Tables with an approved copy-time transform (e.g. status FR-005a) are
/// excluded from the guard because the transform deterministically resolves
/// the documented duplicate (see CopyTransform.DeduplicateOn).
/// </summary>
public sealed class DuplicateKeyGuard
{
    /// <summary>
    /// Scans every migrated table in <paramref name="specs"/> for legacy
    /// duplicates on the target PK columns. Returns every violation found
    /// (never throws).
    /// </summary>
    public static async Task<IReadOnlyList<DuplicateKeyViolation>> ScanAsync(
        SqlConnection legacy, SqlConnection target, IEnumerable<TableSpec> specs,
        Func<TableSpec, bool>? isTransformCovered = null, CancellationToken ct = default)
    {
        var findings = new List<DuplicateKeyViolation>();

        foreach (var spec in specs.Where(s => s.IsMigrated && s.TargetTable is not null))
        {
            // A documented copy-time transform deterministically resolves the
            // duplicate before it reaches the target PK — no guard needed.
            if (isTransformCovered?.Invoke(spec) == true)
                continue;

            var keyColumns = await TargetPkColumnsAsync(target, spec.TargetTable!, ct);
            if (keyColumns.Count == 0)
                continue; // surrogate-key table (target-only Id) — nothing to scan

            var legacyColumns = await LegacyColumnsAsync(legacy, spec.LegacyTable, ct);
            var common = keyColumns.Where(k => legacyColumns.Contains(k, StringComparer.OrdinalIgnoreCase)).ToList();
            if (common.Count == 0)
                continue;

            await foreach (var (value, count) in ScanDuplicatesAsync(legacy, spec.LegacyTable, common, ct))
            {
                findings.Add(new DuplicateKeyViolation(
                    spec.LegacyTable, spec.TargetTable!, common[0], value, count));
            }
        }

        return findings;
    }

    /// <summary>Target PK column names for a table (ordinal order).</summary>
    private static async Task<List<string>> TargetPkColumnsAsync(SqlConnection target, string targetTable,
        CancellationToken ct)
    {
        const string sql = @"
            SELECT kcu.COLUMN_NAME
              FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS tc
              JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE kcu
                ON tc.CONSTRAINT_NAME = kcu.CONSTRAINT_NAME
             WHERE tc.TABLE_NAME = @table
               AND tc.CONSTRAINT_TYPE = 'PRIMARY KEY'
             ORDER BY kcu.ORDINAL_POSITION";
        await using var cmd = target.CreateCommand();
        cmd.CommandText = sql;
        cmd.Parameters.AddWithValue("@table", targetTable);
        var cols = new List<string>();
        await using (var r = await cmd.ExecuteReaderAsync(ct))
        {
            while (await r.ReadAsync(ct)) cols.Add(r.GetString(0));
        }
        return cols;
    }

    /// <summary>Legacy column names for a table.</summary>
    private static async Task<List<string>> LegacyColumnsAsync(SqlConnection legacy, string legacyTable,
        CancellationToken ct)
    {
        const string sql = @"
            SELECT COLUMN_NAME
              FROM INFORMATION_SCHEMA.COLUMNS
             WHERE TABLE_NAME = @table";
        await using var cmd = legacy.CreateCommand();
        cmd.CommandText = sql;
        cmd.Parameters.AddWithValue("@table", legacyTable);
        var cols = new List<string>();
        await using (var r = await cmd.ExecuteReaderAsync(ct))
        {
            while (await r.ReadAsync(ct)) cols.Add(r.GetString(0));
        }
        return cols;
    }

    /// <summary>Yields (keyValue, rowCount) for duplicate key groups.</summary>
    private static async IAsyncEnumerable<(string Value, int Count)> ScanDuplicatesAsync(
        SqlConnection legacy, string legacyTable, IReadOnlyList<string> keyColumns, [System.Runtime.CompilerServices.EnumeratorCancellation] CancellationToken ct)
    {
        var keyList = string.Join(", ", keyColumns.Select(k => "[" + k.Replace("]", "]]", StringComparison.Ordinal) + "]"));
        var sql = $@"
            SELECT {keyList}, COUNT(*) AS [vf_cnt]
              FROM [{legacyTable.Replace("]", "]]", StringComparison.Ordinal)}]
             GROUP BY {keyList}
            HAVING COUNT(*) > 1";
        await using var cmd = legacy.CreateCommand();
        cmd.CommandText = sql;
        await using var r = await cmd.ExecuteReaderAsync(ct);
        while (await r.ReadAsync(ct))
            yield return (r.GetValue(0)?.ToString() ?? "(null)", r.GetInt32(keyColumns.Count));
    }
}
