using System.IdentityModel.Tokens.Jwt;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Net.Http.Json;
using System.Security.Claims;
using System.Text;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.IdentityModel.Tokens;
using VisaFusion.Identity;

namespace VisaFusion.FunctionalTests;

/// <summary>
/// §4.3 re-secured write routes matrix test (SPEC-0005 T025, US4, AC-004/TS-004,
/// FR-011; contracts/secured-write-routes.md §1).
///
/// For each of the 8 role-secured routes still on the standardized placeholder:
/// anonymous → 401, wrong role → 403, correct role → 501 (the placeholder until
/// the module feature delivers the business payload). The 2 public-by-design
/// routes stay anonymous: register → 201, queries → 501.
///
/// The three `/api/v1/entries*` rows from the original 11-route matrix were
/// removed when SPEC-0006 T027/T028 implemented the Entries endpoints — those
/// routes now return real payloads and their 5-role matrix is covered by
/// EntriesRbacTests (T024). The remaining 8 routes (agents, billing, holidays,
/// reports, security-day) are still placeholders.
///
/// Tokens are minted locally with the same development key the host uses
/// (test-only; production keys come from configuration, NFR-004).
/// </summary>
public class SecuredWriteRoutesTests : IClassFixture<VisaFusionWebApplicationFactory>
{
    private readonly VisaFusionWebApplicationFactory _factory;
    private readonly HttpClient _client;

    public SecuredWriteRoutesTests(VisaFusionWebApplicationFactory factory)
    {
        _factory = factory;
        _client = factory.CreateClient();
    }

    [Theory]
    [MemberData(nameof(SecuredRoutes))]
    public async Task SecuredRoute_Anonymous_Returns_401(HttpMethod method, string route, string[] minRoles, bool ownAgent)
    {
        _ = minRoles;
        _ = ownAgent;

        var response = await _client.SendAsync(new HttpRequestMessage(method, route));

        Assert.Equal(HttpStatusCode.Unauthorized, response.StatusCode);
    }

    [Theory]
    [MemberData(nameof(SecuredRoutes))]
    public async Task SecuredRoute_Wrong_Role_Returns_403(HttpMethod method, string route, string[] minRoles, bool ownAgent)
    {
        _ = minRoles;
        _ = ownAgent;

        // `guest` is in none of the 11 minimum-role sets (§4.3).
        var request = new HttpRequestMessage(method, route);
        request.Headers.Authorization = new AuthenticationHeaderValue("Bearer", CreateTestToken(IdentityIntegration.Roles.Guest));

        var response = await _client.SendAsync(request);

        Assert.Equal(HttpStatusCode.Forbidden, response.StatusCode);
    }

    [Theory]
    [MemberData(nameof(SecuredRoutes))]
    public async Task SecuredRoute_Correct_Role_Returns_501(HttpMethod method, string route, string[] minRoles, bool ownAgent)
    {
        // The first minimum role is sufficient (the policy is the full set).
        var role = minRoles[0];
        var token = ownAgent
            ? CreateTestToken(role, agentId: 5771) // /self: claim-bound AgentId must equal the route id (FR-016)
            : CreateTestToken(role);

        var request = new HttpRequestMessage(method, route);
        request.Headers.Authorization = new AuthenticationHeaderValue("Bearer", token);

        var response = await _client.SendAsync(request);

        Assert.Equal(HttpStatusCode.NotImplemented, response.StatusCode);
    }

    [Fact]
    public async Task Public_Register_Anonymous_Returns_201()
    {
        var userName = $"reg-{Guid.NewGuid():N}";
        var response = await _client.PostAsJsonAsync("/api/v1/public/register", new
        {
            username = userName,
            email = $"{userName}@test.local",
            password = "TestPass123!",
        });

        Assert.Equal(HttpStatusCode.Created, response.StatusCode);
    }

    [Fact]
    public async Task Public_Queries_Anonymous_Returns_501()
    {
        // contracts/auth-api.md §5: anonymous by design; the payload lands with
        // the Public/Contact module feature — this feature secures the route
        // and returns the standardized 501 placeholder.
        var response = await _client.PostAsJsonAsync("/api/v1/public/queries", new { });

        Assert.Equal(HttpStatusCode.NotImplemented, response.StatusCode);
    }

    public static IEnumerable<object[]> SecuredRoutes()
    {
        // Routes + minimum roles verbatim from contracts/secured-write-routes.md §1.
        // The three /api/v1/entries* rows were removed on SPEC-0006 T027/T028
        // (implemented; covered by EntriesRbacTests T024).
        yield return new object[] { HttpMethod.Put, "/api/v1/agents/5771", new[] { "adm", "su" }, false };
        yield return new object[] { HttpMethod.Put, "/api/v1/agents/5771/self", new[] { "agt" }, true };
        yield return new object[] { HttpMethod.Post, "/api/v1/billing/entries", new[] { "emp", "adm", "su" }, false };
        yield return new object[] { HttpMethod.Post, "/api/v1/holidays", new[] { "adm", "su" }, false };
        yield return new object[] { HttpMethod.Delete, "/api/v1/holidays/5", new[] { "adm", "su" }, false };
        yield return new object[] { HttpMethod.Post, "/api/v1/reports/agent-status/today", new[] { "emp", "adm", "su" }, false };
        yield return new object[] { HttpMethod.Post, "/api/v1/admin/security-day/open", new[] { "adm", "su" }, false };
        yield return new object[] { HttpMethod.Post, "/api/v1/admin/security-day/close", new[] { "adm", "su" }, false };
    }

    private string CreateTestToken(string role, int? agentId = null)
    {
        var jwtKey = _factory.Services.GetService(typeof(IConfiguration)) is IConfiguration config
            ? config["Jwt:Key"]
            : null;
        jwtKey ??= "CHANGE_ME_development_only_do_not_use_in_production_0123456789";

        var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(jwtKey));
        var credentials = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);
        var claims = new List<Claim> { new(ClaimTypes.Role, role) };
        if (agentId.HasValue)
        {
            claims.Add(new Claim(VisaFusion.Api.Authorization.IdentityClaims.AgentIdClaimType, agentId.Value.ToString()));
        }

        var token = new JwtSecurityToken(
            issuer: "VisaFusion",
            audience: "VisaFusion.Api",
            claims: claims,
            expires: DateTime.UtcNow.AddHours(1),
            signingCredentials: credentials);

        return new JwtSecurityTokenHandler().WriteToken(token);
    }
}