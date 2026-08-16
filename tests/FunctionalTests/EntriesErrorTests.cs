using System.IdentityModel.Tokens.Jwt;
using System.Net;
using System.Net.Http;
using System.Net.Http.Json;
using System.Security.Claims;
using System.Text;
using Microsoft.AspNetCore.Identity;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.IdentityModel.Tokens;
using VisaFusion.Api.Contracts;
using VisaFusion.Identity;

namespace VisaFusion.FunctionalTests;

/// <summary>
/// Entries problem-details error-format functional test (SPEC-0006 T026, US6,
/// AC-007; contracts/entries-api.md §1-§5, spec §18).
///
/// Asserts the standardized problem-details error surface over the five Entries
/// endpoints: 404 unknown refno, 400 validation (incl. a nonexistent status id),
/// 401/403 auth failures, and the deferred superuser route → 404 (never 501 —
/// spec.md "API": the superuser endpoint is NOT registered, T023).
///
/// Uses the hermetic <see cref="VisaFusionWebApplicationFactory"/> with the
/// in-memory <see cref="IEntryService"/> stub, whose status-change validity
/// check mirrors the real service's SqlException translation for the proc's
/// "StatusID not found" RAISERROR (script 08:54-56 → 400). Tokens are minted
/// locally (the ApiSurfaceTests/SecuredWriteRoutesTests convention).
/// </summary>
public class EntriesErrorTests : IClassFixture<VisaFusionWebApplicationFactory>
{
    private readonly VisaFusionWebApplicationFactory _factory;
    private readonly HttpClient _client;

    public EntriesErrorTests(VisaFusionWebApplicationFactory factory)
    {
        _factory = factory;
        _client = factory.CreateClient();
    }

    [Fact]
    public async Task Get_Unknown_Refno_Returns_404_Problem_Details()
    {
        var token = MintTokenAsync(IdentityIntegration.Roles.Employee);

        var response = await _client.SendAsync(Request(HttpMethod.Get, "/api/v1/entries/999999", token, body: null, ifMatch: null));

        Assert.Equal(HttpStatusCode.NotFound, response.StatusCode);
        Assert.Equal("application/problem+json", response.Content.Headers.ContentType?.MediaType);
        var problem = await response.Content.ReadFromJsonAsync<ProblemDetailsResponse>();
        Assert.NotNull(problem);
        Assert.Equal(404, problem!.Status);
    }

    [Fact]
    public async Task Status_Change_With_Nonexistent_Status_Id_Returns_400()
    {
        var token = MintTokenAsync(IdentityIntegration.Roles.Employee);

        // Create an entry first so the request reaches the status-id check.
        var create = await _client.SendAsync(Request(HttpMethod.Post, "/api/v1/entries", token,
            Json(new CreateEntryRequest { Paxname = "A", Passportno = "P" }), ifMatch: null));
        Assert.Equal(HttpStatusCode.Created, create.StatusCode);
        var created = await create.Content.ReadFromJsonAsync<CreateEntryResponse>();
        Assert.NotNull(created);

        // 999 is outside the legacy status-code set (101/201/251/301/401/408/411/
        // 501/502/503/509/601 — deepanalysis.md §4.5) → 400 validation.
        var response = await _client.SendAsync(Request(HttpMethod.Post, $"/api/v1/entries/{created!.Refno}/status", token,
            Json(new ChangeEntryStatusRequest { PaxId = 1, CountryId = 1, NewStatusId = 999 }), ifMatch: null));

        Assert.Equal(HttpStatusCode.BadRequest, response.StatusCode);
        Assert.Equal("application/problem+json", response.Content.Headers.ContentType?.MediaType);
        var problem = await response.Content.ReadFromJsonAsync<ProblemDetailsResponse>();
        Assert.NotNull(problem);
        Assert.Equal(400, problem!.Status);
    }

    [Fact]
    public async Task Create_With_Empty_Passenger_Returns_400()
    {
        var token = MintTokenAsync(IdentityIntegration.Roles.Employee);

        // Missing paxname/passportno → the ≥ 1-passenger invariant (BR-005) → 400.
        var response = await _client.SendAsync(Request(HttpMethod.Post, "/api/v1/entries", token,
            Json(new CreateEntryRequest { Paxname = "", Passportno = "" }), ifMatch: null));

        Assert.Equal(HttpStatusCode.BadRequest, response.StatusCode);
        Assert.Equal("application/problem+json", response.Content.Headers.ContentType?.MediaType);
    }

    [Fact]
    public async Task Malformed_Json_Returns_400_Not_500()
    {
        var token = MintTokenAsync(IdentityIntegration.Roles.Employee);

        using var content = new StringContent("this is not json", Encoding.UTF8, "application/json");
        var request = new HttpRequestMessage(HttpMethod.Post, "/api/v1/entries") { Content = content };
        request.Headers.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);
        var response = await _client.SendAsync(request);

        Assert.Equal(HttpStatusCode.BadRequest, response.StatusCode);
        Assert.Equal("application/problem+json", response.Content.Headers.ContentType?.MediaType);
    }

    [Fact]
    public async Task Anonymous_Is_Unauthorized_On_Entries_Endpoints()
    {
        // Anonymous → 401 (problem-details, not a cookie redirect).
        var response = await _client.GetAsync("/api/v1/entries/1");

        Assert.Equal(HttpStatusCode.Unauthorized, response.StatusCode);
        Assert.Equal("application/problem+json", response.Content.Headers.ContentType?.MediaType);
    }

    [Fact]
    public async Task Wrong_Role_Is_Forbidden_On_Entries_Endpoints()
    {
        var token = MintTokenAsync(IdentityIntegration.Roles.Guest);

        var response = await _client.SendAsync(Request(HttpMethod.Get, "/api/v1/entries/1", token, body: null, ifMatch: null));

        Assert.Equal(HttpStatusCode.Forbidden, response.StatusCode);
        Assert.Equal("application/problem+json", response.Content.Headers.ContentType?.MediaType);
    }

    [Fact]
    public async Task Deferred_Superuser_Route_Returns_404_Not_501()
    {
        // The superuser provisioning endpoint is deliberately NOT registered
        // (T023, spec.md "API") — an unregistered route is 404, never 501.
        var token = MintTokenAsync(IdentityIntegration.Roles.SuperUser);

        var response = await _client.SendAsync(Request(HttpMethod.Post, "/api/v1/admin/superuser", token,
            Json(new { }), ifMatch: null));

        Assert.Equal(HttpStatusCode.NotFound, response.StatusCode);
    }

    private string MintTokenAsync(string role)
    {
        var userName = $"entries-err-{role}-{Guid.NewGuid():N}";
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
        var claims = new[]
        {
            new Claim(ClaimTypes.Name, userName),
            new Claim(ClaimTypes.Role, role),
        };
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

    private static HttpContent Json<T>(T body)
        => JsonContent.Create(body, body?.GetType() ?? typeof(object));

    private static HttpRequestMessage Request(HttpMethod method, string url, string? token, HttpContent? body, string? ifMatch)
    {
        var request = new HttpRequestMessage(method, url) { Content = body };
        if (token is not null)
        {
            request.Headers.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);
        }

        if (ifMatch is not null)
        {
            request.Headers.IfMatch.Add(new System.Net.Http.Headers.EntityTagHeaderValue($"\"{ifMatch}\""));
        }

        return request;
    }

    private sealed class CreateEntryResponse
    {
        public int Refno { get; set; }
    }

    private sealed class ProblemDetailsResponse
    {
        public string? Title { get; set; }
        public int Status { get; set; }
    }
}