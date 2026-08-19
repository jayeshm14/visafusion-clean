using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using VisaFusion.Data.Application;
using VisaFusion.Data.Persistence;
using VisaFusion.Data.Persistence.Entities;

namespace VisaFusion.IntegrationTests;

/// <summary>
/// Holiday/weekly-off CRUD parity tests (SPEC-0008 T039, US5, FR-011, AC-007;
/// contracts/content-api.md §3-§6).
///
/// Exercises the REAL <see cref="VisaEntryDbContext"/> against the legacy
/// <c>holidaylist</c> and <c>weeklyoff</c> tables and proves the AC-007 parity
/// rule: a row created by the CRUD surface is IMMEDIATELY honored by the
/// authoritative <see cref="HolidayService.IsEmbassyClosedAsync"/> rule, and a
/// deleted row stops being honored (the Sunday leg of the rule is excluded by
/// choosing non-Sunday dates).
///
/// The weekly-off table has an enforced FK to <c>embassy.EmbassyID</c>, so the
/// test resolves an existing embassy id first and skips when the table is
/// empty. Test rows are deleted in a <c>finally</c> block. Tests skip when SQL
/// Server is unreachable or the required tables do not exist (existing
/// convention).
/// </summary>
public class HolidayCrudParityTests
{
    private const string DefaultTargetConnectionString =
        "Server=localhost;Database=VisaFusion;Trusted_Connection=True;TrustServerCertificate=True;MultipleActiveResultSets=true";

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

    private static async Task<bool> TableExistsAsync(SqlConnection connection, string table)
    {
        await using var command = connection.CreateCommand();
        command.CommandText = "SELECT COUNT(*) FROM sys.tables WHERE name = @name";
        command.Parameters.AddWithValue("@name", table);
        var count = (int)(await command.ExecuteScalarAsync())!;
        return count > 0;
    }

    private static VisaEntryDbContext CreateContext()
    {
        var options = new DbContextOptionsBuilder<VisaEntryDbContext>()
            .UseSqlServer(TargetConnectionString)
            .Options;
        return new VisaEntryDbContext(options);
    }

    /// <summary>A non-Sunday date (the Sunday leg would mask the holiday/weekly-off effect).</summary>
    private static DateTime NonSundayDate()
    {
        var date = DateTime.Today;
        while (date.DayOfWeek == DayOfWeek.Sunday)
        {
            date = date.AddDays(1);
        }

        return date;
    }

    [Fact]
    public async Task Created_Holiday_Is_Immediately_Honored_And_Deleted_Is_Not()
    {
        if (!TargetReachable()) return;
        await using var connection = new SqlConnection(TargetConnectionString);
        await connection.OpenAsync();
        if (!await TableExistsAsync(connection, "holidaylist")) return;

        var marker = $"t039-{Guid.NewGuid():N}";
        var holidayDate = NonSundayDate();
        await using var db = CreateContext();
        var service = new HolidayService(db);

        // AC-007: before the row exists the embassy is open on this date.
        var embassyId = await ResolveEmbassyIdAsync(db);
        if (embassyId is null) return; // no embassy rows to attach weekly-off/holiday to
        Assert.False(await service.IsEmbassyClosedAsync(embassyId.Value, holidayDate));

        var holiday = new Holiday
        {
            CountryId = embassyId.Value,
            HolidayDate = holidayDate,
            Description = $"Created {marker}",
        };
        db.Holidays.Add(holiday);
        await db.SaveChangesAsync();

        try
        {
            // AC-007: the CRUD row is immediately honored by the rule.
            Assert.True(await service.IsEmbassyClosedAsync(embassyId.Value, holidayDate));
        }
        finally
        {
            await db.Database.ExecuteSqlRawAsync(
                "DELETE FROM holidaylist WHERE Description = {0}", $"Created {marker}");
        }

        // Deleted: the row stops being honored.
        Assert.False(await service.IsEmbassyClosedAsync(embassyId.Value, holidayDate));
    }

    [Fact]
    public async Task Created_WeeklyOff_Is_Immediately_Honored_And_Deleted_Is_Not()
    {
        if (!TargetReachable()) return;
        await using var connection = new SqlConnection(TargetConnectionString);
        await connection.OpenAsync();
        if (!await TableExistsAsync(connection, "weeklyoff")) return;

        var marker = $"t039-{Guid.NewGuid():N}";
        await using var db = CreateContext();
        var service = new HolidayService(db);

        var embassyId = await ResolveEmbassyIdAsync(db);
        if (embassyId is null) return; // no embassy rows to attach the weekly-off to
        var testDate = NonSundayDate();
        var weekday = (int)testDate.DayOfWeek + 1; // VBScript Weekday() numbering (BR-006)

        Assert.False(await service.IsEmbassyClosedAsync(embassyId.Value, testDate));

        var weeklyOff = new WeeklyOff
        {
            Embassyid = embassyId.Value,
            Weekend = weekday,
            Description = $"Created {marker}",
        };
        db.WeeklyOffs.Add(weeklyOff);
        await db.SaveChangesAsync();

        try
        {
            // AC-007: the CRUD row is immediately honored by the rule.
            Assert.True(await service.IsEmbassyClosedAsync(embassyId.Value, testDate));
        }
        finally
        {
            await db.Database.ExecuteSqlRawAsync(
                "DELETE FROM weeklyoff WHERE Description = {0}", $"Created {marker}");
        }

        // Deleted: the row stops being honored.
        Assert.False(await service.IsEmbassyClosedAsync(embassyId.Value, testDate));
    }

    /// <summary>
    /// Resolves an existing embassy id for the FK-constrained weeklyoff rows
    /// (null when the embassy table is empty — the test then skips). Scalar
    /// <c>SqlQuery&lt;T&gt;</c> results require the column named <c>Value</c>.
    /// </summary>
    private static async Task<int?> ResolveEmbassyIdAsync(VisaEntryDbContext db)
        => await db.Database.SqlQuery<int>($"SELECT TOP 1 EmbassyID AS [Value] FROM embassy")
            .FirstOrDefaultAsync() is var id && id != 0 ? id : null;
}