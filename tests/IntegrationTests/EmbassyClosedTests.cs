using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using VisaFusion.Data.Application;
using VisaFusion.Data.Persistence;

namespace VisaFusion.IntegrationTests;

/// <summary>
/// fn_IsEmbassyClosed parity integration tests (SPEC-0006 T019, US4, FR-006,
/// BR-003, AC-005).
///
/// Asserts the read-only reporting mirror <c>dbo.fn_IsEmbassyClosed</c>
/// (script 02) returns the SAME verdict as the authoritative C#
/// <see cref="HolidayService"/> for the four date classes — holiday,
/// weekly-off, Sunday, normal day (AC-005 parity). Seeds a synthetic embassy
/// plus one holiday and one weekly-off row for it, evaluates both surfaces for
/// each date class, and deletes the seeded rows in a <c>finally</c> block.
/// Tests skip when SQL Server is unreachable or the function does not exist
/// (existing convention).
/// </summary>
public class EmbassyClosedTests
{
    private const string DefaultTargetConnectionString =
        "Server=localhost;Database=VisaFusion;Trusted_Connection=True;TrustServerCertificate=True;MultipleActiveResultSets=true";

    private const string TestEmbassyDescription = "T019-parity-test";

    private static string TargetConnectionString =>
        Environment.GetEnvironmentVariable("VISA_FUSION_TEST_CONNECTION") ?? DefaultTargetConnectionString;

    private static bool TargetReachable()
    {
        try
        {
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
    public async Task Fn_IsEmbassyClosed_Matches_HolidayService_For_All_Date_Classes()
    {
        if (!TargetReachable()) return;

        await using var connection = new SqlConnection(TargetConnectionString);
        await connection.OpenAsync();
        if (!await FunctionExistsAsync(connection, "fn_IsEmbassyClosed")) return;

        // Synthetic embassy id (identity) — never a real embassy.
        var embassyId = await InsertEmbassyAsync(connection);
        try
        {
            // 2026-08-17 (Mon) holiday, 2026-08-18 (Tue) weekly-off (Weekday=3),
            // 2026-08-16 (Sun) Sunday, 2026-08-19 (Wed) normal day.
            await InsertHolidayAsync(connection, embassyId, new DateTime(2026, 8, 17));
            await InsertWeeklyOffAsync(connection, embassyId, weekday: 3);

            var options = new DbContextOptionsBuilder<VisaEntryDbContext>()
                .UseSqlServer(connection.ConnectionString)
                .Options;
            await using var db = new VisaEntryDbContext(options);
            var service = new HolidayService(db);

            var cases = new (DateTime Date, bool Expected)[]
            {
                (new DateTime(2026, 8, 16), true),  // Sunday
                (new DateTime(2026, 8, 17), true),  // holiday
                (new DateTime(2026, 8, 18), true),  // weekly-off
                (new DateTime(2026, 8, 19), false), // normal day
            };

            foreach (var (date, expected) in cases)
            {
                var sql = await FnIsEmbassyClosedAsync(connection, embassyId, date);
                var csharp = await service.IsEmbassyClosedAsync(embassyId, date);

                Assert.Equal(expected, sql);
                Assert.Equal(expected, csharp);
                Assert.Equal(sql, csharp); // AC-005 parity
            }
        }
        finally
        {
            await DeleteTestRowsAsync(connection, embassyId);
        }
    }

    private static async Task<int> InsertEmbassyAsync(SqlConnection connection)
    {
        await using var cmd = connection.CreateCommand();
        cmd.CommandText = "INSERT INTO [embassy] ([description]) VALUES (@description); SELECT SCOPE_IDENTITY();";
        cmd.Parameters.AddWithValue("@description", TestEmbassyDescription);
        return Convert.ToInt32(await cmd.ExecuteScalarAsync());
    }

    private static async Task InsertHolidayAsync(SqlConnection connection, int embassyId, DateTime date)
    {
        await using var cmd = connection.CreateCommand();
        cmd.CommandText = "INSERT INTO [holidaylist] ([countryID],[holiday],[description]) VALUES (@countryID,@holiday,@description)";
        cmd.Parameters.AddWithValue("@countryID", embassyId);
        cmd.Parameters.AddWithValue("@holiday", date);
        cmd.Parameters.AddWithValue("@description", TestEmbassyDescription);
        await cmd.ExecuteNonQueryAsync();
    }

    private static async Task InsertWeeklyOffAsync(SqlConnection connection, int embassyId, int weekday)
    {
        await using var cmd = connection.CreateCommand();
        cmd.CommandText = "INSERT INTO [weeklyoff] ([embassyid],[weekend],[description]) VALUES (@embassyid,@weekend,@description)";
        cmd.Parameters.AddWithValue("@embassyid", embassyId);
        cmd.Parameters.AddWithValue("@weekend", weekday);
        cmd.Parameters.AddWithValue("@description", TestEmbassyDescription);
        await cmd.ExecuteNonQueryAsync();
    }

    private static async Task<bool> FnIsEmbassyClosedAsync(SqlConnection connection, int embassyId, DateTime date)
    {
        await using var cmd = connection.CreateCommand();
        cmd.CommandText = "SELECT dbo.fn_IsEmbassyClosed(@embassyId, @date)";
        cmd.Parameters.AddWithValue("@embassyId", embassyId);
        cmd.Parameters.AddWithValue("@date", date.Date);
        return Convert.ToBoolean(await cmd.ExecuteScalarAsync());
    }

    private static async Task DeleteTestRowsAsync(SqlConnection connection, int embassyId)
    {
        // Deletes only the rows this test inserted (marker description), never real data.
        await using var cmd = connection.CreateCommand();
        cmd.CommandText = """
            DELETE FROM [weeklyoff] WHERE [embassyid] = @embassyId AND [description] = @marker;
            DELETE FROM [holidaylist] WHERE [countryID] = @embassyId AND [description] = @marker;
            DELETE FROM [embassy] WHERE [embassyid] = @embassyId AND [description] = @marker;
            """;
        cmd.Parameters.AddWithValue("@embassyId", embassyId);
        cmd.Parameters.AddWithValue("@marker", TestEmbassyDescription);
        await cmd.ExecuteNonQueryAsync();
    }

    private static async Task<bool> FunctionExistsAsync(SqlConnection connection, string function)
    {
        await using var cmd = connection.CreateCommand();
        cmd.CommandText = "SELECT COUNT(*) FROM sys.objects WHERE type = 'FN' AND name = @function";
        cmd.Parameters.AddWithValue("@function", function);
        return Convert.ToInt32(await cmd.ExecuteScalarAsync()) > 0;
    }
}