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
/// Entries optimistic-concurrency functional test (SPEC-0006 T025, US6, AC-011;
/// contracts/entries-api.md §3).
///
/// Asserts the If-Match/ETag concurrency contract over PUT /api/v1/entries/{refno}:
/// a stale If-Match ETag → 409 (problem-details), a fresh ETag → 200 with a new
/// etag. Uses the hermetic <see cref="VisaFusionWebApplicationFactory"/> with the
/// in-memory <see cref="IEntryService"/> stub, whose UpdateAsync mirrors the real
/// service's RowVersion concurrency (stale → EntryConflictException → 409).
///
/// Tokens are minted locally (the ApiSurfaceTests/SecuredWriteRoutesTests
/// convention) — the real login endpoint is not exercised here (see
/// EntriesRbacTests header for the runtime-mismatch note).
/// </summary>
public class EntriesConcurrencyTests : IClassFixture<VisaFusionWebApplicationFactory>
{
    private readonly VisaFusionWebApplicationFactory _factory;
    private readonly HttpClient _client;

    public EntriesConcurrencyTests(VisaFusionWebApplicationFactory factory)
    {
        _factory = factory;
        _client = factory.CreateClient();
    }

    [Fact]
    public async Task Stale_If_Match_Returns_409_Problem_Details()
    {
        var token = MintTokenAsync(IdentityIntegration.Roles.Employee);

        // Create an entry and capture its current ETag.
        var create = await _client.SendAsync(Request(HttpMethod.Post, "/api/v1/entries", token,
            Json(new CreateEntryRequest { Paxname = "A", Passportno = "P" }), ifMatch: null));
        Assert.Equal(HttpStatusCode.Created, create.StatusCode);
        var created = await create.Content.ReadFromJsonAsync<CreateEntryResponse>();
        Assert.NotNull(created);
        Assert.False(string.IsNullOrWhiteSpace(created!.Etag));

        // A stale ETag (a different base64 value) must be rejected with 409.
        var stale = Convert.ToBase64String(new byte[] { 9, 9, 9, 9, 9, 9, 9, 9 });
        var put = await _client.SendAsync(Request(HttpMethod.Put, $"/api/v1/entries/{created.Refno}", token,
            Json(new UpdateEntryRequest { Paxname = "A2", Passportno = "P2" }), ifMatch: stale));

        Assert.Equal(HttpStatusCode.Conflict, put.StatusCode);
        Assert.Equal("application/problem+json", put.Content.Headers.ContentType?.MediaType);
        var problem = await put.Content.ReadFromJsonAsync<ProblemDetailsResponse>();
        Assert.NotNull(problem);
        Assert.Equal(409, problem!.Status);
    }

    [Fact]
    public async Task Fresh_If_Match_Returns_200_With_New_Etag()
    {
        var token = MintTokenAsync(IdentityIntegration.Roles.Employee);

        var create = await _client.SendAsync(Request(HttpMethod.Post, "/api/v1/entries", token,
            Json(new CreateEntryRequest { Paxname = "A", Passportno = "P" }), ifMatch: null));
        Assert.Equal(HttpStatusCode.Created, create.StatusCode);
        var created = await create.Content.ReadFromJsonAsync<CreateEntryResponse>();
        Assert.NotNull(created);
        Assert.False(string.IsNullOrWhiteSpace(created!.Etag));

        // A fresh ETag (the one just returned) succeeds and returns a new etag.
        var put = await _client.SendAsync(Request(HttpMethod.Put, $"/api/v1/entries/{created.Refno}", token,
            Json(new UpdateEntryRequest { Paxname = "A2", Passportno = "P2" }), ifMatch: created.Etag));

        Assert.Equal(HttpStatusCode.OK, put.StatusCode);
        var updated = await put.Content.ReadFromJsonAsync<EntryResponse>();
        Assert.NotNull(updated);
        Assert.False(string.IsNullOrWhiteSpace(updated!.Etag));
        Assert.NotEqual(created.Etag, updated.Etag);
    }

    [Fact]
    public async Task Missing_If_Match_Returns_400()
    {
        var token = MintTokenAsync(IdentityIntegration.Roles.Employee);

        var create = await _client.SendAsync(Request(HttpMethod.Post, "/api/v1/entries", token,
            Json(new CreateEntryRequest { Paxname = "A", Passportno = "P" }), ifMatch: null));
        Assert.Equal(HttpStatusCode.Created, create.StatusCode);
        var created = await create.Content.ReadFromJsonAsync<CreateEntryResponse>();
        Assert.NotNull(created);

        // No If-Match header → 400 (the header is required, AC-011).
        var put = await _client.SendAsync(Request(HttpMethod.Put, $"/api/v1/entries/{created!.Refno}", token,
            Json(new UpdateEntryRequest { Paxname = "A2", Passportno = "P2" }), ifMatch: null));

        Assert.Equal(HttpStatusCode.BadRequest, put.StatusCode);
    }

    private string MintTokenAsync(string role)
    {
        var userName = $"entries-conc-{role}-{Guid.NewGuid():N}";
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
        public string? Etag { get; set; }
    }

    private sealed class ProblemDetailsResponse
    {
        public string? Title { get; set; }
        public int Status { get; set; }
    }
}