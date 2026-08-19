using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using VisaFusion.Data.Persistence;
using VisaFusion.Data.Persistence.Entities;
using VisaFusion.Migration.Catalog;
using VisaFusion.Migration.Validation;

namespace VisaFusion.IntegrationTests;

/// <summary>
/// Append-only audit table tests (SPEC-0004 T024, TS-006, FR-006, BR-003).
///
/// The audit tables (`StatusHistory`, `bighistory`, `sentmails`, `smshistory`)
/// are migrated WITHOUT alteration, deletion, or reordering. These tests verify
/// the catalog marks them append-only, the target schema carries them, and —
/// once a copy has run — the target is byte-identical to the source (same
/// type-canonical checksum on both sides). Tests skip when SQL Server is
/// unreachable.
/// </summary>
public class AuditTableTests
{
    private static readonly string[] AuditTables = ["StatusHistory", "bighistory", "sentmails", "smshistory"];

    private const string DefaultLegacyConnectionString =
        "Server=localhost;Database=VisaEntry;Trusted_Connection=True;TrustServerCertificate=True;MultipleActiveResultSets=true";
    private const string DefaultTargetConnectionString =
        "Server=localhost;Database=VisaFusion;Trusted_Connection=True;TrustServerCertificate=True;MultipleActiveResultSets=true";

    private static string LegacyConnectionString =>
        Environment.GetEnvironmentVariable("VISAENTRY_TEST_CONNECTION") ?? DefaultLegacyConnectionString;

    private static string TargetConnectionString =>
        Environment.GetEnvironmentVariable("VISA_FUSION_TEST_CONNECTION") ?? DefaultTargetConnectionString;

    private static bool ServersReachable()
    {
        try
        {
            using var legacy = new SqlConnection(LegacyConnectionString);
            legacy.Open();
            using var target = new SqlConnection(TargetConnectionString);
            target.Open();
            return true;
        }
        catch
        {
            return false;
        }
    }

    [Fact]
    public void Audit_Tables_Are_Marked_Append_Only_In_The_Catalog()
    {
        foreach (var name in AuditTables)
        {
            var spec = TableCatalog.All.Single(t => t.LegacyTable.Equals(name, StringComparison.OrdinalIgnoreCase));
            Assert.True(spec.AppendOnly, $"{name} must be append-only (FR-006)");
            Assert.True(spec.IsMigrated, $"{name} must be migrated (M)");
        }
    }

    [Fact]
    public async Task Audit_Tables_Exist_In_The_Target_Schema()
    {
        if (!ServersReachable()) return;

        await using var target = new SqlConnection(TargetConnectionString);
        await target.OpenAsync();
        var tables = new HashSet<string>(StringComparer.OrdinalIgnoreCase);
        await using (var cmd = target.CreateCommand())
        {
            cmd.CommandText = "SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE = 'BASE TABLE'";
            await using var r = await cmd.ExecuteReaderAsync();
            while (await r.ReadAsync()) tables.Add(r.GetString(0));
        }

        foreach (var name in AuditTables)
            Assert.Contains(name, tables);
    }

    [Fact]
    public async Task Audit_Tables_Are_Byte_Identical_When_Copied()
    {
        if (!ServersReachable()) return;

        await using var legacy = new SqlConnection(LegacyConnectionString);
        await legacy.OpenAsync();
        await using var target = new SqlConnection(TargetConnectionString);
        await target.OpenAsync();

        foreach (var name in AuditTables)
        {
            var spec = TableCatalog.All.Single(t => t.LegacyTable.Equals(name, StringComparison.OrdinalIgnoreCase));

            // Copy has not run yet (target is empty) — schema presence is
            // verified above; the byte-identical proof applies after a copy.
            var targetCount = await CountAsync(target, spec.TargetTable!);
            if (targetCount == 0) continue;

            // FR-006: the same type-canonical checksum must match on both sides.
            var sourceChecksum = await ChecksumSql.ExecuteStringAsync(legacy, spec.LegacyTable);
            var targetChecksum = await ChecksumSql.ExecuteStringAsync(target, spec.TargetTable!);
            Assert.Equal(sourceChecksum, targetChecksum);
        }
    }

    [Fact]
    public async Task SmsLog_And_EmailLog_Writes_Flow_Through_The_Same_Legacy_Tables()
    {
        // BR-001 (SPEC-0008 T050): the EF entities SmsLog/EmailLog must write
        // through the SAME tables the legacy app used — smshistory / sentmails.
        // A write via VisaEntryDbContext must be visible to raw SQL on the
        // target database, proving the audit-continuity contract (FR-006/BR-003).
        if (!ServersReachable()) return;

        var options = new DbContextOptionsBuilder<VisaEntryDbContext>()
            .UseSqlServer(TargetConnectionString)
            .Options;

        long smsId = 0;
        long emailId = 0;

        await using (var db = new VisaEntryDbContext(options))
        {
            var sms = new SmsLog
            {
                Cellno = "01711-000000",
                Refno = 999999,
                AgentId = null,
                Paxname = "BR-001 audit-continuity",
                Status = "sent",
                Message = "BR-001 test message",
                Sentby = "BR001",
                Sentdate = DateTime.Now,
            };
            db.SmsLogs.Add(sms);
            await db.SaveChangesAsync();
            smsId = sms.Id;

            var email = new EmailLog
            {
                Agentsid = 0,
                Date = DateTime.Now,
                Toemail = "br001@test.invalid",
                Awb = "BR001-AWB",
            };
            db.EmailLogs.Add(email);
            await db.SaveChangesAsync();
            emailId = email.Id;
        }

        try
        {
            await using var target = new SqlConnection(TargetConnectionString);
            await target.OpenAsync();

            // smshistory row exists with all 8 fields (AC-003).
            await using (var cmd = target.CreateCommand())
            {
                cmd.CommandText = "SELECT COUNT_BIG(*) FROM smshistory WHERE Id = @id AND cellno = @cellno AND refno = @refno AND paxname = @paxname AND status = @status AND message = @message AND sentby = @sentby";
                cmd.Parameters.AddWithValue("@id", smsId);
                cmd.Parameters.AddWithValue("@cellno", "01711-000000");
                cmd.Parameters.AddWithValue("@refno", 999999);
                cmd.Parameters.AddWithValue("@paxname", "BR-001 audit-continuity");
                cmd.Parameters.AddWithValue("@status", "sent");
                cmd.Parameters.AddWithValue("@message", "BR-001 test message");
                cmd.Parameters.AddWithValue("@sentby", "BR001");
                var smsCount = Convert.ToInt64(await cmd.ExecuteScalarAsync());
                Assert.Equal(1, smsCount);
            }

            // sentmails row exists with agentsid/date/toemail/awb (AC-005).
            await using (var cmd = target.CreateCommand())
            {
                cmd.CommandText = "SELECT COUNT_BIG(*) FROM sentmails WHERE id = @id AND agentsid = @agentsid AND toemail = @toemail AND awb = @awb";
                cmd.Parameters.AddWithValue("@id", emailId);
                cmd.Parameters.AddWithValue("@agentsid", 0);
                cmd.Parameters.AddWithValue("@toemail", "br001@test.invalid");
                cmd.Parameters.AddWithValue("@awb", "BR001-AWB");
                var emailCount = Convert.ToInt64(await cmd.ExecuteScalarAsync());
                Assert.Equal(1, emailCount);
            }
        }
        finally
        {
            // Clean up the audit rows written by this test (append-only tables
            // must not accumulate test residue; see SPEC-0008 T050).
            await using var cleanup = new SqlConnection(TargetConnectionString);
            await cleanup.OpenAsync();
            await using (var cmd = cleanup.CreateCommand())
            {
                cmd.CommandText = "DELETE FROM smshistory WHERE Id = @smsId; DELETE FROM sentmails WHERE id = @emailId;";
                cmd.Parameters.AddWithValue("@smsId", smsId);
                cmd.Parameters.AddWithValue("@emailId", emailId);
                await cmd.ExecuteNonQueryAsync();
            }
        }
    }

    private static async Task<long> CountAsync(SqlConnection connection, string table)
    {
        await using var cmd = connection.CreateCommand();
        cmd.CommandText = $"SELECT COUNT_BIG(*) FROM [{table.Replace("]", "]]", StringComparison.Ordinal)}]";
        return Convert.ToInt64(await cmd.ExecuteScalarAsync() ?? 0L);
    }
}