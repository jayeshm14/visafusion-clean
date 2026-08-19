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
using VisaFusion.Api.Authorization;
using VisaFusion.Data.Persistence;
using VisaFusion.Identity;

namespace VisaFusion.FunctionalTests;

/// <summary>
/// dailyUpdate content CMS tests (SPEC-0008 T033, US4, FR-010, BR-003, AC-006;
/// contracts/content-api.md §1/§2).
///
/// Proves the CMS contract hermetically over the real
/// <see cref="VisaFusion.Api.Endpoints.ContentEndpoint"/> (the factory replaces
/// VisaEntryDbContext with an InMemory store):
///   - create/edit/delete succeed for adm/su (AdminPanel policy),
///   - emp/agt → 403 and anonymous → 401 on the write endpoints (AC-006; the
///     legacy anonymous dailyupdate.asp write is closed — BR-003),
///   - the §17 validation rules reject an invalid body with 400,
///   - the audit event is written in the same commit (spec §19),
///   - the anonymous public read page reflects CMS changes (AC-006).
/// Tokens carry the seeded username in the `name` claim so the handler's
/// server-side actor resolution (JWT name → AspNetUsers.Id) resolves — never a
/// caller-supplied actor string (GR-0004).
/// </summary>
public class ContentCmsTests : IClassFixture<VisaFusionWebApplicationFactory>
{
    private readonly VisaFusionWebApplicationFactory _factory;
    private readonly HttpClient _client;

    public ContentCmsTests(VisaFusionWebApplicationFactory factory)
    {
        _factory = factory;
        _client = factory.CreateClient();
    }

    [Fact]
    public async Task Create_Returns_201_For_Admin_And_SuperUser()
    {
        foreach (var role in new[] { IdentityIntegration.Roles.Admin, IdentityIntegration.Roles.SuperUser })
        {
            var token = MintTokenAsync(role);
            var response = await PostDailyUpdateAsync(_client, ValidBody(), token);
            Assert.Equal(HttpStatusCode.Created, response.StatusCode);
        }
    }

    [Fact]
    public async Task Create_Writes_Audit_Event_In_Same_Commit()
    {
        // spec §19: dailyUpdate create records actor + entrydate + action in the
        // same commit as the change.
        var token = MintTokenAsync(IdentityIntegration.Roles.Admin);
        var marker = $"t033-{Guid.NewGuid():N}";
        var response = await PostDailyUpdateAsync(_client, ValidBody(marker), token);
        Assert.Equal(HttpStatusCode.Created, response.StatusCode);

        using var scope = _factory.Services.CreateScope();
        var db = scope.ServiceProvider.GetRequiredService<VisaEntryDbContext>();
        var audit = await db.AdminAuditLogs
            .OrderByDescending(a => a.Id)
            .FirstAsync(a => a.EventType == "DailyUpdateCreated");
        Assert.Equal(DateTime.Today.ToString("yyyy-MM-dd"), audit.Detail);
        Assert.False(string.IsNullOrEmpty(audit.ActorUserId));
        Assert.False(string.IsNullOrEmpty(audit.ActorUserName));
    }

    [Fact]
    public async Task Update_Returns_200_For_Admin()
    {
        var token = MintTokenAsync(IdentityIntegration.Roles.Admin);
        var marker = $"t033-{Guid.NewGuid():N}";
        var created = await PostDailyUpdateAsync(_client, ValidBody(marker), token);
        Assert.Equal(HttpStatusCode.Created, created.StatusCode);

        var id = await FindEntryIdAsync(marker);
        var response = await PostDailyUpdateAsync(
            _client, ValidBody(marker, description: $"Edited {marker}", id: id), token);
        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
    }

    [Fact]
    public async Task Delete_Returns_204_For_Admin()
    {
        var token = MintTokenAsync(IdentityIntegration.Roles.Admin);
        var marker = $"t033-{Guid.NewGuid():N}";
        var created = await PostDailyUpdateAsync(_client, ValidBody(marker), token);
        Assert.Equal(HttpStatusCode.Created, created.StatusCode);

        var id = await FindEntryIdAsync(marker);
        var response = await DeleteDailyUpdateAsync(_client, id, token);
        Assert.Equal(HttpStatusCode.NoContent, response.StatusCode);
    }

    [Fact]
    public async Task Delete_Unknown_Id_Returns_404()
    {
        var token = MintTokenAsync(IdentityIntegration.Roles.Admin);
        var response = await DeleteDailyUpdateAsync(_client, 999_999_999, token);
        Assert.Equal(HttpStatusCode.NotFound, response.StatusCode);
    }

    [Fact]
    public async Task Write_Endpoints_Return_403_For_Employee_And_Agent()
    {
        // AC-006: the CMS is adm/su only — emp/agt are rejected on both writes.
        foreach (var role in new[] { IdentityIntegration.Roles.Employee, IdentityIntegration.Roles.Agent })
        {
            var token = MintTokenAsync(role);
            var post = await PostDailyUpdateAsync(_client, ValidBody(), token);
            Assert.Equal(HttpStatusCode.Forbidden, post.StatusCode);

            var delete = await DeleteDailyUpdateAsync(_client, 1, token);
            Assert.Equal(HttpStatusCode.Forbidden, delete.StatusCode);
        }
    }

    [Fact]
    public async Task Write_Endpoints_Return_401_For_Anonymous()
    {
        var post = await _client.PostAsJsonAsync("/api/v1/admin/content/daily-update", ValidBody());
        Assert.Equal(HttpStatusCode.Unauthorized, post.StatusCode);

        var delete = await _client.DeleteAsync("/api/v1/admin/content/daily-update/1");
        Assert.Equal(HttpStatusCode.Unauthorized, delete.StatusCode);
    }

    [Fact]
    public async Task Invalid_Body_Returns_400()
    {
        var token = MintTokenAsync(IdentityIntegration.Roles.Admin);
        var response = await PostDailyUpdateAsync(
            _client, new { entrydate = (DateTime?)null, description = (string?)null }, token);
        Assert.Equal(HttpStatusCode.BadRequest, response.StatusCode);
    }

    [Fact]
    public async Task Public_Page_Reflects_Cms_Changes_Anonymously()
    {
        // AC-006: the public read page stays anonymous and reflects CMS changes.
        var token = MintTokenAsync(IdentityIntegration.Roles.Admin);
        var marker = $"t033-{Guid.NewGuid():N}";

        var created = await PostDailyUpdateAsync(_client, ValidBody(marker), token);
        Assert.Equal(HttpStatusCode.Created, created.StatusCode);

        var page = await _client.GetAsync("/Public/DailyUpdate");
        Assert.Equal(HttpStatusCode.OK, page.StatusCode);
        var html = await page.Content.ReadAsStringAsync();
        Assert.Contains(marker, html);

        var id = await FindEntryIdAsync(marker);
        var deleted = await DeleteDailyUpdateAsync(_client, id, token);
        Assert.Equal(HttpStatusCode.NoContent, deleted.StatusCode);

        var pageAfter = await _client.GetAsync("/Public/DailyUpdate");
        var htmlAfter = await pageAfter.Content.ReadAsStringAsync();
        Assert.DoesNotContain(marker, htmlAfter);
    }

    // ---- helpers (AdminUserManagementTests convention) ----

    private async Task<long> FindEntryIdAsync(string marker)
    {
        using var scope = _factory.Services.CreateScope();
        var db = scope.ServiceProvider.GetRequiredService<VisaEntryDbContext>();
        var entry = await db.ContentUpdates.SingleAsync(c => c.Description == $"Daily update {marker}");
        return entry.Id;
    }

    private string MintTokenAsync(string role)
    {
        var userName = $"content-user-{role}-{Guid.NewGuid():N}";
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
            claims.Add(new Claim(IdentityClaims.SuperUserClaimType, "true"));
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

    private static object ValidBody(string? marker = null, string? description = null, long? id = null) => new
    {
        entrydate = DateTime.Today,
        description = description ?? $"Daily update {marker ?? Guid.NewGuid().ToString("N")}",
        id = id,
    };

    private static async Task<HttpResponseMessage> PostDailyUpdateAsync(
        HttpClient client, object body, string token)
    {
        var request = new HttpRequestMessage(HttpMethod.Post, "/api/v1/admin/content/daily-update")
        {
            Content = JsonContent.Create(body),
        };
        request.Headers.Authorization = new AuthenticationHeaderValue("Bearer", token);
        return await client.SendAsync(request);
    }

    private static async Task<HttpResponseMessage> DeleteDailyUpdateAsync(
        HttpClient client, long id, string token)
    {
        var request = new HttpRequestMessage(HttpMethod.Delete, $"/api/v1/admin/content/daily-update/{id}");
        request.Headers.Authorization = new AuthenticationHeaderValue("Bearer", token);
        return await client.SendAsync(request);
    }
}