using System.ComponentModel.DataAnnotations;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using VisaFusion.Api.Contracts;
using VisaFusion.Data.Persistence;
using VisaFusion.Data.Persistence.Entities;

namespace VisaFusion.IntegrationTests;

/// <summary>
/// dailyUpdate content CMS persistence tests (SPEC-0008 T034, US4, FR-010,
/// AC-006).
///
/// Exercises the REAL <see cref="VisaEntryDbContext"/> against the legacy
/// <c>dailyUpdate</c> table (unchanged — SPEC-0004; the <c>ContentUpdate</c>
/// entity adds the surrogate <c>Id</c> key, FR-003):
///   - create/edit/delete round-trip through the surrogate key,
///   - the §17 validation rules (entrydate required, description ≤ 8,000 chars)
///     as enforced by the shared DataAnnotations validator the endpoint runs.
/// Test rows are deleted in a <c>finally</c> block. Tests skip when SQL Server
/// is unreachable or the table does not exist (existing convention).
/// </summary>
public class ContentUpdateCrudTests
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

    [Fact]
    public async Task Content_Update_Create_Edit_Delete_Roundtrip()
    {
        if (!TargetReachable()) return;
        await using var connection = new SqlConnection(TargetConnectionString);
        await connection.OpenAsync();
        if (!await TableExistsAsync(connection, "dailyUpdate")) return;

        var marker = $"t034-{Guid.NewGuid():N}";
        var entryDate = new DateTime(2026, 8, 18);
        await using var db = CreateContext();

        // Create (the endpoint's insert path — surrogate Id generated).
        var entry = new ContentUpdate
        {
            Entrydate = entryDate,
            Description = $"Created {marker}",
        };
        db.ContentUpdates.Add(entry);
        await db.SaveChangesAsync();

        try
        {
            var created = await db.ContentUpdates.SingleAsync(c => c.Id == entry.Id);
            Assert.Equal(entryDate, created.Entrydate);
            Assert.Equal($"Created {marker}", created.Description);

            // Edit (the endpoint's update path — same row, new values).
            created.Description = $"Edited {marker}";
            created.Entrydate = new DateTime(2026, 8, 19);
            await db.SaveChangesAsync();

            var edited = await db.ContentUpdates.SingleAsync(c => c.Id == entry.Id);
            Assert.Equal(new DateTime(2026, 8, 19), edited.Entrydate);
            Assert.Equal($"Edited {marker}", edited.Description);

            // Delete (the endpoint's delete path).
            db.ContentUpdates.Remove(edited);
            await db.SaveChangesAsync();
            Assert.Null(await db.ContentUpdates.FindAsync(entry.Id));
        }
        finally
        {
            await db.Database.ExecuteSqlRawAsync(
                "DELETE FROM dailyUpdate WHERE Description LIKE {0}", $"%{marker}%");
        }
    }

    [Fact]
    public void Content_Update_Request_Requires_Entrydate()
    {
        // §17: entrydate required — the same Validator the endpoint runs.
        var request = new ContentUpdateRequest
        {
            Entrydate = null,
            Description = "A description",
        };

        var results = new List<ValidationResult>();
        var isValid = Validator.TryValidateObject(
            request, new ValidationContext(request), results, validateAllProperties: true);

        Assert.False(isValid);
        Assert.Contains(results, r => r.MemberNames.Contains(nameof(ContentUpdateRequest.Entrydate)));
    }

    [Fact]
    public void Content_Update_Request_Rejects_Description_Over_8000_Chars()
    {
        // §17: description ≤ 8,000 chars (the dailyUpdate.Description column
        // limit) — the same Validator the endpoint runs.
        var request = new ContentUpdateRequest
        {
            Entrydate = new DateTime(2026, 8, 18),
            Description = new string('x', 8001),
        };

        var results = new List<ValidationResult>();
        var isValid = Validator.TryValidateObject(
            request, new ValidationContext(request), results, validateAllProperties: true);

        Assert.False(isValid);
        Assert.Contains(results, r => r.MemberNames.Contains(nameof(ContentUpdateRequest.Description)));
    }

    [Fact]
    public void Content_Update_Request_Accepts_Description_At_8000_Chars()
    {
        // §17 boundary: exactly 8,000 chars is valid.
        var request = new ContentUpdateRequest
        {
            Entrydate = new DateTime(2026, 8, 18),
            Description = new string('x', 8000),
        };

        var results = new List<ValidationResult>();
        var isValid = Validator.TryValidateObject(
            request, new ValidationContext(request), results, validateAllProperties: true);

        Assert.True(isValid);
    }
}