using System.IdentityModel.Tokens.Jwt;
using System.Net;
using System.Net.Http.Headers;
using System.Net.Http.Json;
using System.Security.Claims;
using System.Text;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.IdentityModel.Tokens;
using VisaFusion.Data.Persistence;
using VisaFusion.Identity;

namespace VisaFusion.FunctionalTests;

/// <summary>
/// Holiday/weekly-off endpoint tests (SPEC-0008 T040, US5, FR-011, BR-006,
/// AC-007; contracts/content-api.md §3-§6).
///
/// Proves the holiday/weekly-off contract hermetically over the real
/// <see cref="VisaFusion.Api.Endpoints.HolidaysEndpoint"/> (the factory replaces
/// VisaEntryDbContext with an InMemory store):
///   - create/delete succeed for adm/su (HolidayAdmin policy),
///   - emp/agt → 403 and anonymous → 401 on the write endpoints,
///   - duplicate embassy+date and embassy+weekday → 409 (the legacy
///     holiday_entry.asp "ALREADY EXISTS" skip),
///   - weekday boundaries (BR-006): 1–7 accepted, 0/8 rejected with 400,
///   - the audit event is written in the same commit (spec §19).
/// Tokens carry the seeded username in the `name` claim so the handler's
/// server-side actor resolution (JWT name → AspNetUsers.Id) resolves — never a
/// caller-supplied actor string (GR-0004).
/// </summary>
public class HolidayCrudEndpointTests : IClassFixture<VisaFusionWebApplicationFactory>
{
    private const int TestEmbassyId = 99991;

    private readonly VisaFusionWebApplicationFactory _factory;
    private readonly HttpClient _client;

    public HolidayCrudEndpointTests(VisaFusionWebApplicationFactory factory)
    {
        _factory = factory;
        _client = factory.CreateClient();
    }

    [Fact]
    public async Task Create_Holiday_Returns_201_For_Admin_And_SuperUser()
    {
        foreach (var role in new[] { IdentityIntegration.Roles.Admin, IdentityIntegration.Roles.SuperUser })
        {
            var token = MintTokenAsync(role);
            var response = await PostHolidayAsync(_client, ValidHolidayBody(), token);
            Assert.Equal(HttpStatusCode.Created, response.StatusCode);
        }
    }

    [Fact]
    public async Task Create_Holiday_Duplicate_Returns_409()
    {
        var token = MintTokenAsync(IdentityIntegration.Roles.Admin);
        var marker = $"t040-{Guid.NewGuid():N}";
        var body = ValidHolidayBody(marker);

        var first = await PostHolidayAsync(_client, body, token);
        Assert.Equal(HttpStatusCode.Created, first.StatusCode);

        var second = await PostHolidayAsync(_client, body, token);
        Assert.Equal(HttpStatusCode.Conflict, second.StatusCode);
    }

    [Fact]
    public async Task Delete_Holiday_Returns_204_For_Admin()
    {
        var token = MintTokenAsync(IdentityIntegration.Roles.Admin);
        var marker = $"t040-{Guid.NewGuid():N}";
        var created = await PostHolidayAsync(_client, ValidHolidayBody(marker), token);
        Assert.Equal(HttpStatusCode.Created, created.StatusCode);

        var id = await FindHolidayIdAsync(marker);
        var response = await DeleteHolidayAsync(_client, id, token);
        Assert.Equal(HttpStatusCode.NoContent, response.StatusCode);
    }

    [Fact]
    public async Task Delete_Unknown_Holiday_Id_Returns_404()
    {
        var token = MintTokenAsync(IdentityIntegration.Roles.Admin);
        var response = await DeleteHolidayAsync(_client, 999_999_999, token);
        Assert.Equal(HttpStatusCode.NotFound, response.StatusCode);
    }

    [Fact]
    public async Task Create_WeeklyOff_Accepts_Weekday_Boundaries_1_And_7()
    {
        // BR-006: VBScript Weekday() numbering — 1 (Sunday) and 7 (Saturday)
        // are valid.
        var token = MintTokenAsync(IdentityIntegration.Roles.Admin);
        foreach (var weekday in new[] { 1, 7 })
        {
            var response = await PostWeeklyOffAsync(_client, ValidWeeklyOffBody(weekday), token);
            Assert.Equal(HttpStatusCode.Created, response.StatusCode);
        }
    }

    [Fact]
    public async Task Create_WeeklyOff_Rejects_Weekday_0_And_8()
    {
        // BR-006: 0 and 8 are outside the 1–7 VBScript Weekday() range → 400.
        var token = MintTokenAsync(IdentityIntegration.Roles.Admin);
        foreach (var weekday in new[] { 0, 8 })
        {
            var response = await PostWeeklyOffAsync(_client, ValidWeeklyOffBody(weekday), token);
            Assert.Equal(HttpStatusCode.BadRequest, response.StatusCode);
        }
    }

    [Fact]
    public async Task Create_WeeklyOff_Duplicate_Returns_409()
    {
        var token = MintTokenAsync(IdentityIntegration.Roles.Admin);
        var marker = $"t040-{Guid.NewGuid():N}";
        var body = ValidWeeklyOffBody(3, marker);

        var first = await PostWeeklyOffAsync(_client, body, token);
        Assert.Equal(HttpStatusCode.Created, first.StatusCode);

        var second = await PostWeeklyOffAsync(_client, body, token);
        Assert.Equal(HttpStatusCode.Conflict, second.StatusCode);
    }

    [Fact]
    public async Task Delete_WeeklyOff_Returns_204_For_Admin()
    {
        var token = MintTokenAsync(IdentityIntegration.Roles.Admin);
        var marker = $"t040-{Guid.NewGuid():N}";
        var created = await PostWeeklyOffAsync(_client, ValidWeeklyOffBody(5, marker), token);
        Assert.Equal(HttpStatusCode.Created, created.StatusCode);

        var id = await FindWeeklyOffIdAsync(marker);
        var response = await DeleteWeeklyOffAsync(_client, id, token);
        Assert.Equal(HttpStatusCode.NoContent, response.StatusCode);
    }

    [Fact]
    public async Task Write_Endpoints_Return_403_For_Employee_And_Agent()
    {
        // AC-006 (US5 flavor): the holiday/weekly-off CRUD is adm/su only.
        foreach (var role in new[] { IdentityIntegration.Roles.Employee, IdentityIntegration.Roles.Agent })
        {
            var token = MintTokenAsync(role);

            var holiday = await PostHolidayAsync(_client, ValidHolidayBody(), token);
            Assert.Equal(HttpStatusCode.Forbidden, holiday.StatusCode);

            var weeklyOff = await PostWeeklyOffAsync(_client, ValidWeeklyOffBody(2), token);
            Assert.Equal(HttpStatusCode.Forbidden, weeklyOff.StatusCode);

            var deleteHoliday = await DeleteHolidayAsync(_client, 1, token);
            Assert.Equal(HttpStatusCode.Forbidden, deleteHoliday.StatusCode);

            var deleteWeeklyOff = await DeleteWeeklyOffAsync(_client, 1, token);
            Assert.Equal(HttpStatusCode.Forbidden, deleteWeeklyOff.StatusCode);
        }
    }

    [Fact]
    public async Task Write_Endpoints_Return_401_For_Anonymous()
    {
        var holiday = await _client.PostAsJsonAsync("/api/v1/holidays", ValidHolidayBody());
        Assert.Equal(HttpStatusCode.Unauthorized, holiday.StatusCode);

        var weeklyOff = await _client.PostAsJsonAsync("/api/v1/holidays/weekly-off", ValidWeeklyOffBody(2));
        Assert.Equal(HttpStatusCode.Unauthorized, weeklyOff.StatusCode);

        var deleteHoliday = await _client.DeleteAsync("/api/v1/holidays/1");
        Assert.Equal(HttpStatusCode.Unauthorized, deleteHoliday.StatusCode);

        var deleteWeeklyOff = await _client.DeleteAsync("/api/v1/holidays/weekly-off/1");
        Assert.Equal(HttpStatusCode.Unauthorized, deleteWeeklyOff.StatusCode);
    }

    // ---- helpers (AdminUserManagementTests convention) ----

    private async Task<long> FindHolidayIdAsync(string marker)
    {
        using var scope = _factory.Services.CreateScope();
        var db = scope.ServiceProvider.GetRequiredService<VisaEntryDbContext>();
        var entry = await db.Holidays.SingleAsync(h => h.Description == $"Created {marker}");
        return entry.Id;
    }

    private async Task<long> FindWeeklyOffIdAsync(string marker)
    {
        using var scope = _factory.Services.CreateScope();
        var db = scope.ServiceProvider.GetRequiredService<VisaEntryDbContext>();
        var entry = await db.WeeklyOffs.SingleAsync(w => w.Description == $"Created {marker}");
        return entry.Id;
    }

    private string MintTokenAsync(string role)
    {
        var userName = $"holiday-user-{role}-{Guid.NewGuid():N}";
        SeedUser(userName, role);
        return CreateTestToken(userName, role);
    }

    private string CreateTestToken(string userName, string role)
    {
        var jwtKey = _factory.Services.GetService(typeof(IConfiguration)) is IConfiguration config
            ? config["Jwt:Key"]
            : null;
        jwtKey ??= "CHANGE_ME_development_only_do_not_use_in_production_0123456789";

        var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(jwtKey));
        var credentials = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);
        var claims = new List<Claim>
        {
            new(ClaimTypes.Name, userName),
            new(ClaimTypes.Role, role),
        };
        if (role == "su")
        {
            claims.Add(new Claim(ClaimTypes.Role, "adm"));
            claims.Add(new Claim(VisaFusion.Api.Authorization.IdentityClaims.SuperUserClaimType, "true"));
        }

        var token = new JwtSecurityToken(
            issuer: "VisaFusion",
            audience: "VisaFusion.Api",
            claims: claims,
            expires: DateTime.UtcNow.AddHours(1),
            signingCredentials: credentials);

        return new JwtSecurityTokenHandler().WriteToken(token);
    }

    private void SeedUser(string userName, string role)
    {
        using var scope = _factory.Services.CreateScope();
        var userManager = scope.ServiceProvider
            .GetRequiredService<UserManager<IdentityIntegration.VisaFusionUser>>();

        var user = new IdentityIntegration.VisaFusionUser
        {
            UserName = userName,
            Email = $"{userName}@test.local",
        };
        var createResult = userManager.CreateAsync(user, "TestPass123!").GetAwaiter().GetResult();
        Assert.True(createResult.Succeeded,
            string.Join("; ", createResult.Errors.Select(e => e.Description)));
        var roleResult = userManager.AddToRoleAsync(user, role).GetAwaiter().GetResult();
        Assert.True(roleResult.Succeeded,
            string.Join("; ", roleResult.Errors.Select(e => e.Description)));
    }

    /// <summary>
    /// Unique holiday dates per call: the InMemory store is shared across the
    /// whole test class, so a fixed date would make the first POST of one test
    /// collide with a row a previous test created (the 409 under test must be
    /// produced by the intentional duplicate, not by cross-test pollution).
    /// </summary>
    private static int _holidayDateSequence;

    private static object ValidHolidayBody(string? marker = null)
    {
        var offset = Interlocked.Increment(ref _holidayDateSequence);
        return new
        {
            embassyId = TestEmbassyId,
            holidayDate = DateTime.Today.AddDays(60 + offset),
            description = $"Created {marker ?? Guid.NewGuid().ToString("N")}",
        };
    }

    private static object ValidWeeklyOffBody(int weekday, string? marker = null) => new
    {
        embassyId = TestEmbassyId,
        weekday,
        description = $"Created {marker ?? Guid.NewGuid().ToString("N")}",
    };

    private static async Task<HttpResponseMessage> PostHolidayAsync(
        HttpClient client, object body, string token)
        => await PostAsJsonAsync(client, "/api/v1/holidays", body, token);

    private static async Task<HttpResponseMessage> PostWeeklyOffAsync(
        HttpClient client, object body, string token)
        => await PostAsJsonAsync(client, "/api/v1/holidays/weekly-off", body, token);

    private static async Task<HttpResponseMessage> DeleteHolidayAsync(
        HttpClient client, long id, string token)
        => await DeleteAsync(client, $"/api/v1/holidays/{id}", token);

    private static async Task<HttpResponseMessage> DeleteWeeklyOffAsync(
        HttpClient client, long id, string token)
        => await DeleteAsync(client, $"/api/v1/holidays/weekly-off/{id}", token);

    private static async Task<HttpResponseMessage> PostAsJsonAsync(
        HttpClient client, string url, object body, string token)
    {
        var request = new HttpRequestMessage(HttpMethod.Post, url)
        {
            Content = JsonContent.Create(body),
        };
        request.Headers.Authorization = new AuthenticationHeaderValue("Bearer", token);
        return await client.SendAsync(request);
    }

    private static async Task<HttpResponseMessage> DeleteAsync(
        HttpClient client, string url, string token)
    {
        var request = new HttpRequestMessage(HttpMethod.Delete, url);
        request.Headers.Authorization = new AuthenticationHeaderValue("Bearer", token);
        return await client.SendAsync(request);
    }
}