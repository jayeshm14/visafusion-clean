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
/// Entries 5-role RBAC matrix functional test (SPEC-0006 T024, US6, FR-008/009,
/// AC-008; contracts/entries-api.md "General").
///
/// Asserts the authorization matrix over all five Entries endpoints:
/// anonymous → 401, wrong role (agt/guest) → 403, correct role (emp/adm/su) →
/// 200/201/204. Uses the hermetic <see cref="VisaFusionWebApplicationFactory"/>
/// with the in-memory <see cref="IEntryService"/> stub.
///
/// Tokens are minted locally with the same development key the host uses
/// (test-only; production keys come from configuration, NFR-004) — the
/// established convention for role-matrix tests (ApiSurfaceTests,
/// SecuredWriteRoutesTests). The JWT `name` claim carries the seeded username
/// so the status endpoint's server-side actor resolution (JWT `sub`/`name` →
/// AspNetUsers.Id via UserManager.FindByNameAsync, GR-0004) resolves. The real
/// login endpoint is NOT exercised here: on this machine it runs the net8.0
/// host on the .NET 9 runtime, where WriteAsJsonAsync hits the known
/// PipeWriter.UnflushedBytes incompatibility (pre-existing block, deviation
/// log #3) — the login contract itself is covered by AuthLoginTests.
/// </summary>
public class EntriesRbacTests : IClassFixture<VisaFusionWebApplicationFactory>
{
    private readonly VisaFusionWebApplicationFactory _factory;
    private readonly HttpClient _client;

    public EntriesRbacTests(VisaFusionWebApplicationFactory factory)
    {
        _factory = factory;
        _client = factory.CreateClient();
    }

    [Fact]
    public async Task Anonymous_Is_Unauthorized_On_All_Entries_Endpoints()
    {
        var body = new CreateEntryRequest { Paxname = "A", Passportno = "P" };
        Assert.Equal(HttpStatusCode.Unauthorized, (await _client.PostAsync("/api/v1/entries", Json(body))).StatusCode);
        Assert.Equal(HttpStatusCode.Unauthorized, (await _client.GetAsync("/api/v1/entries/1")).StatusCode);
        Assert.Equal(HttpStatusCode.Unauthorized, (await _client.PutAsync("/api/v1/entries/1", Json(body))).StatusCode);
        Assert.Equal(HttpStatusCode.Unauthorized, (await _client.PostAsync("/api/v1/entries/1/status", Json(body))).StatusCode);
        Assert.Equal(HttpStatusCode.Unauthorized, (await _client.PostAsync("/api/v1/entries/1/awb", Json(body))).StatusCode);
    }

    [Theory]
    [InlineData(IdentityIntegration.Roles.Agent)]
    [InlineData(IdentityIntegration.Roles.Guest)]
    public async Task Wrong_Role_Is_Forbidden_On_All_Entries_Endpoints(string role)
    {
        var token = MintTokenAsync(role);

        Assert.Equal(HttpStatusCode.Forbidden,
            (await PostAsync("/api/v1/entries", new CreateEntryRequest { Paxname = "A", Passportno = "P" }, token)).StatusCode);
        Assert.Equal(HttpStatusCode.Forbidden,
            (await GetAsync("/api/v1/entries/1", token)).StatusCode);
        Assert.Equal(HttpStatusCode.Forbidden,
            (await PutAsync("/api/v1/entries/1", new UpdateEntryRequest { Paxname = "A", Passportno = "P" }, token)).StatusCode);
        Assert.Equal(HttpStatusCode.Forbidden,
            (await PostAsync("/api/v1/entries/1/status", new ChangeEntryStatusRequest { PaxId = 1, CountryId = 1, NewStatusId = 2 }, token)).StatusCode);
        Assert.Equal(HttpStatusCode.Forbidden,
            (await PostAsync("/api/v1/entries/1/awb", new RecordAwbRequest { Awb = "123" }, token)).StatusCode);
    }

    [Theory]
    [InlineData(IdentityIntegration.Roles.Employee)]
    [InlineData(IdentityIntegration.Roles.Admin)]
    [InlineData(IdentityIntegration.Roles.SuperUser)]
    public async Task Correct_Role_Can_Invoke_All_Entries_Endpoints(string role)
    {
        var token = MintTokenAsync(role);

        // POST /entries → 201.
        var create = await PostAsync("/api/v1/entries", new CreateEntryRequest { Paxname = "A", Passportno = "P" }, token);
        Assert.Equal(HttpStatusCode.Created, create.StatusCode);
        var created = await create.Content.ReadFromJsonAsync<CreateEntryResponse>();
        Assert.NotNull(created);
        Assert.True(created!.Refno > 0);
        Assert.False(string.IsNullOrWhiteSpace(created.Etag));

        var refno = created.Refno;

        // GET /entries/{refno} → 200.
        var get = await GetAsync($"/api/v1/entries/{refno}", token);
        Assert.Equal(HttpStatusCode.OK, get.StatusCode);

        // PUT /entries/{refno} with a fresh ETag → 200 (AC-011).
        var put = await PutAsync($"/api/v1/entries/{refno}",
            new UpdateEntryRequest { Paxname = "A2", Passportno = "P2" }, token, ifMatch: created.Etag);
        Assert.Equal(HttpStatusCode.OK, put.StatusCode);

        // POST /entries/{refno}/status → 200.
        var status = await PostAsync($"/api/v1/entries/{refno}/status",
            new ChangeEntryStatusRequest { PaxId = 1, CountryId = 1, NewStatusId = 2 }, token);
        Assert.Equal(HttpStatusCode.OK, status.StatusCode);

        // POST /entries/{refno}/awb → 204.
        var awb = await PostAsync($"/api/v1/entries/{refno}/awb",
            new RecordAwbRequest { Awb = "123" }, token);
        Assert.Equal(HttpStatusCode.NoContent, awb.StatusCode);
    }

    /// <summary>
    /// Seeds a user in the hermetic InMemory identity store and mints a JWT
    /// locally (the ApiSurfaceTests/SecuredWriteRoutesTests convention). The
    /// `name` claim carries the seeded username so the status endpoint's
    /// server-side actor resolution (JWT sub/name → AspNetUsers.Id) resolves —
    /// never a caller-supplied actor string (GR-0004).
    /// </summary>
    private string MintTokenAsync(string role)
    {
        var userName = $"entries-rbac-{role}-{Guid.NewGuid():N}";
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

    private async Task<HttpResponseMessage> PostAsync(string url, object body, string? token = null)
        => await _client.SendAsync(Request(HttpMethod.Post, url, token, Json(body), ifMatch: null));

    private async Task<HttpResponseMessage> GetAsync(string url, string? token = null)
        => await _client.SendAsync(Request(HttpMethod.Get, url, token, body: null, ifMatch: null));

    private async Task<HttpResponseMessage> PutAsync(string url, object body, string? token = null, string? ifMatch = null)
        => await _client.SendAsync(Request(HttpMethod.Put, url, token, Json(body), ifMatch));

    private sealed class CreateEntryResponse
    {
        public int Refno { get; set; }
        public string? Etag { get; set; }
    }
}
