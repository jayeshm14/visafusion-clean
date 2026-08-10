using Microsoft.Data.SqlClient;

namespace VisaFusion.Migration.Validation;

/// <summary>
/// Builds a type-canonical checksum query so the SAME SQL expression can be run
/// against the legacy source table and the target table (FR-009 AC-002).
///
/// The legacy and target schemas differ in types (datetime -> datetime2,
/// money -> decimal(19,4), varchar -> nvarchar, numeric -> bigint), so a raw
/// row rendering would not match. Each column is normalized to a canonical
/// string keyed by its SOURCE type family:
///   - date/time types: converted to datetime2(3) then ISO 8601 (both sides
///     render the identical canonical string for the same instant)
///   - money/decimal/numeric: converted to decimal(19,4) with style 2
///   - float/real: converted with style 2 (deterministic scientific)
///   - binary/varbinary: hex string
///   - all other scalar types: nvarchar(max)
/// NULL is normalized to the empty string on both sides.
/// </summary>
public static class ChecksumSql
{
    /// <summary>
    /// Reads the source column list with types and returns the canonical
    /// checksum SQL for the given table (source or target �?" same expression).
    /// </summary>
    public static async Task<string> BuildAsync(SqlConnection connection, string tableName,
        CancellationToken ct = default)
    {
        var cols = await LoadColumnsAsync(connection, tableName, ct);
        if (cols.Count == 0)
            return "SELECT CAST(0 AS bigint)";

        var rowText = string.Join(", ", cols.Select(c => Canonical(c.DataType, c.ColumnName)));
        // CONCAT_WS requires 3 to 254 arguments (separator + at least 2 values).
        // A table with a single non-identity column (e.g. Attestation,
        // certificate, cab, hotel) would otherwise produce CONCAT_WS('|', col) —
        // only 2 arguments — which SQL Server rejects. Pad with a constant empty
        // string so the expression is always valid; the constant is identical on
        // both source and target, so the checksum comparison stays deterministic.
        var concatArgs = cols.Count == 1 ? $"{rowText}, N''" : rowText;
        // The per-row SHA2-256 (first 8 bytes as signed bigint) is summed into
        // decimal(38,0): SUM(bigint) would overflow for tables with many rows
        // (e.g. Mainentry has 271k+), decimal(38,0) never does for any real
        // legacy table. Deterministic on both sides.
        return $"""
            SELECT ISNULL(SUM(CONVERT(decimal(38,0),
                       CONVERT(bigint,
                         CONVERT(varbinary(8), HASHBYTES('SHA2_256', CONCAT_WS('|', {concatArgs})))))), 0)
              FROM [{tableName.Replace("]", "]]", StringComparison.Ordinal)}]
            """;
    }

    /// <summary>
    /// Executes the canonical checksum for a table and returns the exact value
    /// as a string (invariant formatting), suitable for byte-identical comparison.
    /// </summary>
    public static async Task<string> ExecuteStringAsync(SqlConnection connection, string tableName,
        CancellationToken ct = default)
    {
        var sql = await BuildAsync(connection, tableName, ct);
        await using var cmd = connection.CreateCommand();
        cmd.CommandText = sql;
        var result = await cmd.ExecuteScalarAsync(ct);
        return Convert.ToString(result, System.Globalization.CultureInfo.InvariantCulture) ?? "0";
    }

    private static async Task<List<Column>> LoadColumnsAsync(SqlConnection connection, string tableName,
        CancellationToken ct)
    {
        var sql = @"
            SELECT c.COLUMN_NAME, c.DATA_TYPE
              FROM INFORMATION_SCHEMA.COLUMNS c
             WHERE c.TABLE_NAME = @table
               AND COLUMNPROPERTY(OBJECT_ID(QUOTENAME(c.TABLE_SCHEMA) + '.' + QUOTENAME(c.TABLE_NAME)),
                                  c.COLUMN_NAME, 'IsIdentity') = 0
             ORDER BY c.ORDINAL_POSITION";
        await using var cmd = connection.CreateCommand();
        cmd.CommandText = sql;
        cmd.Parameters.AddWithValue("@table", tableName);
        var cols = new List<Column>();
        await using (var r = await cmd.ExecuteReaderAsync(ct))
        {
            while (await r.ReadAsync(ct))
                cols.Add(new Column(r.GetString(0), r.GetString(1)));
        }
        return cols;
    }

    private static string Canonical(string dataType, string column)
    {
        var q = "[" + column.Replace("]", "]]", StringComparison.Ordinal) + "]";
        var t = dataType.ToLowerInvariant();
        return t switch
        {
            // datetime/smalldatetime/datetime2/datetimeoffset/date/time
            "datetime" or "datetime2" or "smalldatetime" or "date" or "time" or "datetimeoffset" =>
                $"CONVERT(nvarchar(40), CONVERT(datetime2(3), ISNULL({q}, '19000101')), 126)",
            "money" or "smallmoney" or "decimal" or "numeric" =>
                $"CONVERT(nvarchar(40), CONVERT(decimal(19,4), ISNULL({q}, 0)), 2)",
            "float" or "real" =>
                $"CONVERT(nvarchar(40), ISNULL({q}, 0), 2)",
            "binary" or "varbinary" =>
                $"CONVERT(nvarchar(max), ISNULL({q}, 0x), 2)",
            "bit" =>
                $"CONVERT(nvarchar(2), ISNULL({q}, 0))",
            "uniqueidentifier" =>
                $"CONVERT(nvarchar(36), ISNULL({q}, '00000000-0000-0000-0000-000000000000'))",
            _ =>
                $"CONVERT(nvarchar(max), ISNULL(CAST({q} AS nvarchar(max)), N''))"
        };
    }

    private sealed record Column(string ColumnName, string DataType);
}
