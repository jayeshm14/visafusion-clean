using Microsoft.Data.SqlClient;

namespace VisaFusion.Migration.Data;

/// <summary>
/// Read-only access to the legacy <c>VisaEntry</c> database (SPEC-0004 T019).
///
/// Guarantees (NFR-003): every query is parameterized — no string-concatenated
/// SQL with unescaped identifiers; FR-008 (legacy untouched): this type never
/// issues INSERT/UPDATE/DELETE/DDL.
/// </summary>
public sealed class LegacyReader : IDisposable
{
    private readonly SqlConnection _connection;

    public LegacyReader(string connectionString)
    {
        var builder = new SqlConnectionStringBuilder(connectionString);
        builder.ApplicationIntent = ApplicationIntent.ReadOnly;
        builder.ApplicationName = "VisaFusion.Migration (read-only)";
        _connection = new SqlConnection(builder.ConnectionString);
    }

    public async Task OpenAsync(CancellationToken ct = default) => await _connection.OpenAsync(ct);

    public SqlConnection Connection => _connection;

    /// <summary>Executes a parameterized scalar query.</summary>
    public async Task<object?> ScalarAsync(string sql, CancellationToken ct = default)
    {
        await using var cmd = _connection.CreateCommand();
        cmd.CommandText = sql;
        // The checksum query is a full-table SHA2_256 scan; over the verified
        // data volumes (bighistory ≈ 1.4M rows) it exceeds the 30s default
        // command timeout (observed 2026-08-16 during T032: SnapshotTests
        // "Execution Timeout Expired"). 300s covers the largest legacy tables.
        cmd.CommandTimeout = 300;
        return await cmd.ExecuteScalarAsync(ct);
    }

    /// <summary>Verifies the legacy database is reachable (preflight, FR-008).</summary>
    public async Task<bool> IsReachableAsync(CancellationToken ct = default)
    {
        try { return await ScalarAsync("SELECT 1", ct) is not null; }
        catch (SqlException) { return false; }
    }

    /// <summary>Live row count for one legacy table (snapshot/validate).</summary>
    public async Task<long> RowCountAsync(string tableName, CancellationToken ct = default)
    {
        var result = await ScalarAsync($"SELECT COUNT_BIG(*) FROM {Q(tableName)}", ct);
        return Convert.ToInt64(result ?? 0L);
    }

    /// <summary>
    /// Migrated-column list for a legacy table: all ordinary (non-identity)
    /// columns, in column-ordinal order, NULL-able columns included. Identity
    /// columns are excluded because the target either regenerates them
    /// (surrogate) or preserves them via IDENTITY_INSERT (identical values).
    /// Used to build checksums and bulk-copy mappings (FR-009).
    /// </summary>
    public async Task<IReadOnlyList<string>> DataColumnsAsync(string tableName, CancellationToken ct = default)
    {
        var sql = @"
            SELECT c.COLUMN_NAME
              FROM INFORMATION_SCHEMA.COLUMNS c
             WHERE c.TABLE_NAME = @table
               AND COLUMNPROPERTY(OBJECT_ID(QUOTENAME(c.TABLE_SCHEMA) + '.' + QUOTENAME(c.TABLE_NAME)), c.COLUMN_NAME, 'IsIdentity') = 0
             ORDER BY c.ORDINAL_POSITION";
        await using var cmd = _connection.CreateCommand();
        cmd.CommandText = sql;
        cmd.Parameters.AddWithValue("@table", tableName);
        var cols = new List<string>();
        await using (var r = await cmd.ExecuteReaderAsync(ct))
        {
            while (await r.ReadAsync(ct)) cols.Add(r.GetString(0));
        }
        return cols;
    }

    /// <summary>
    /// Deterministic checksum over a legacy table's data columns (excluding
    /// identity columns), using the type-canonical expression from
    /// <see cref="Validation.ChecksumSql"/> so the identical query can run
    /// against the target (FR-009 AC-002). Returns the exact decimal string
    /// (may exceed Int64 range for large tables).
    /// </summary>
    public async Task<string> ChecksumAsync(string tableName, CancellationToken ct = default)
    {
        var sql = await Validation.ChecksumSql.BuildAsync(_connection, tableName, ct);
        var result = await ScalarAsync(sql, ct);
        return Convert.ToString(result, System.Globalization.CultureInfo.InvariantCulture) ?? "0";
    }

    /// <summary>
    /// Returns the maximum ordinal / identity seed value of a legacy identity
    /// column so the target surrogate sequence can be reseeded past it
    /// (FR-003 identity preservation, avoid collisions).
    /// </summary>
    public async Task<long?> IdentityMaxAsync(string tableName, string columnName, CancellationToken ct = default)
    {
        var result = await ScalarAsync(
            $"SELECT MAX([{columnName.Replace("]", "]]", StringComparison.Ordinal)}]) FROM {Q(tableName)}", ct);
        return result is null or DBNull ? null : Convert.ToInt64(result);
    }

    private static string Q(string identifier)
        => "[" + identifier.Replace("]", "]]", StringComparison.Ordinal) + "]";

    public void Dispose() => _connection.Dispose();
}
