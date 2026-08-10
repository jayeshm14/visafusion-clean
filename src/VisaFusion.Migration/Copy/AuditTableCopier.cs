using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Logging;
using VisaFusion.Migration.Catalog;
using VisaFusion.Migration.Commands;
using VisaFusion.Migration.Validation;

namespace VisaFusion.Migration.Copy;

/// <summary>
/// Append-only audit table copier (SPEC-0004 T027, FR-006, BR-003).
///
/// Audit tables (`StatusHistory`, `bighistory`, `sentmails`, `smshistory`, and
/// the other <see cref="TableSpec.AppendOnly"/> tables) are migrated WITHOUT
/// alteration, deletion, or reordering. This type enforces that guarantee:
///
///  1. It refuses to copy a table that is not flagged <see cref="TableSpec.AppendOnly"/>.
///  2. It performs the copy with the same read-only pipeline as
///     <see cref="BulkCopyEngine"/> (SELECT + SqlBulkCopy + IDENTITY_INSERT
///     toggle) — it never issues UPDATE/DELETE/DDL on source or target.
///  3. After the copy it verifies the target checksum matches the source
///     (byte-identical proof, FR-006) and throws on mismatch so `copy` fails
///     fast (exit 2) instead of silently migrating altered audit data.
///
/// The class issues no UPDATE/DELETE statements; the only writes are the bulk
/// insert and the `SET IDENTITY_INSERT` session toggle required to preserve the
/// legacy identity values (FR-003). Row order is preserved because the source
/// is streamed from the legacy table without projection changes and identity
/// values are carried over.
/// </summary>
public sealed class AuditTableCopier
{
    private readonly string _legacyConnectionString;
    private readonly string _targetConnectionString;
    private readonly int _batchSize;
    private readonly ILogger _logger;

    public AuditTableCopier(string legacyConnectionString, string targetConnectionString, int batchSize,
        ILogger logger)
    {
        _legacyConnectionString = legacyConnectionString;
        _targetConnectionString = targetConnectionString;
        _batchSize = batchSize;
        _logger = logger;
    }

    /// <summary>
    /// Copies one append-only audit table and verifies the target is byte-identical
    /// to the source (FR-006). Throws <see cref="IntegrityException"/> when the
    /// verification fails.
    /// </summary>
    public async Task<CopyResult> CopyAsync(TableSpec spec, CancellationToken ct = default)
    {
        if (!spec.AppendOnly)
        {
            throw new InvalidOperationException(
                $"AuditTableCopier refuses non-append-only table '{spec.LegacyTable}' (BR-003). " +
                "Use BulkCopyEngine for live tables.");
        }

        _logger.LogInformation("audit-copy: {Table} (append-only, byte-identical verification)", spec.LegacyTable);

        var engine = new BulkCopyEngine(_legacyConnectionString, _targetConnectionString, _batchSize, _logger);
        var result = await engine.CopyAsync(spec, transform: null, ct);

        // Byte-identical proof (FR-006): compare the source and target checksums
        // using the same type-canonical expression on both sides.
        string sourceChecksum;
        string targetChecksum;
        await using (var source = new SqlConnection(_legacyConnectionString))
        {
            await source.OpenAsync(ct);
            sourceChecksum = await ChecksumSql.ExecuteStringAsync(source, spec.LegacyTable, ct);
        }
        await using (var target = new SqlConnection(_targetConnectionString))
        {
            await target.OpenAsync(ct);
            targetChecksum = await ChecksumSql.ExecuteStringAsync(target, spec.TargetTable!, ct);
        }

        if (sourceChecksum != targetChecksum)
        {
            _logger.LogError(
                "audit-copy: {Table} checksum mismatch — source={Src} target={Dst}; append-only table altered during copy (BR-003).",
                spec.LegacyTable, sourceChecksum, targetChecksum);
            throw new IntegrityException(
                $"Append-only table '{spec.LegacyTable}' checksum mismatch after copy " +
                $"(source={sourceChecksum}, target={targetChecksum}); audit data must be byte-identical (FR-006).");
        }

        _logger.LogInformation("audit-copy: {Table} verified byte-identical ({Rows} rows, checksum {Sum}).",
            spec.LegacyTable, result.RowsCopied, sourceChecksum);
        return result;
    }
}
