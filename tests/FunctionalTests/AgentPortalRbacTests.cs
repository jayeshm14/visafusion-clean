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
using VisaFusion.Api.Authorization;
using VisaFusion.Core.Application;
using VisaFusion.Identity;

namespace VisaFusion.FunctionalTests;

/// <summary>
/// Agent portal HTTP matrix (SPEC-0007 T048, US4, FR-017..021, BR-007/BR-008,
/// AC-012/AC-013/AC-014, CHK026; contracts/agents-api.md §2/§3/§3a/§4).
///
/// The hermetic factory stubs <see cref="VisaFusion.Core.Application.IAgentService"/>
/// (InMemoryAgentServiceStub returns deterministic sample data), so this suite
/// proves the ENDPOINT wiring hermetically:
///   - anonymous → 401 on all four portal routes,
///   - <c>agt</c> own <c>{id}</c> → 200 on entries/statuses/statement,
///   - <c>agt</c> other agent's <c>{id}</c> → 403 (BR-007, AC-012),
///   - <c>agt</c> without a linked AgentId claim → 403 (CHK026),
///   - <c>emp</c>/<c>adm</c>/<c>su</c> may read any <c>{id}</c> → 200,
///   - <c>PUT /agents/{id}/self</c>: own → 200, other → 403, staff → 403
///     (contract §2, FR-020),
///   - <c>?q=</c> keyword filter passthrough on entries/statuses (FR-021).
/// The real data path is covered by AgentPortalIntegrationTests (T028).
/// </summary>
public class AgentPortalRbacTests : IClassFixture<VisaFusionWebApplicationFactory>
{
    private readonly VisaFusionWebApplicationFactory _factory;
    private readonly HttpClient _client;

    public AgentPortalRbacTests(VisaFusionWebApplicationFactory factory)
    {
        _factory = factory;
        _client = factory.CreateClient();

        // Seed agents 42 and 43 for the portal RBAC tests (T048).
        var stub = factory.Services.GetRequiredService<IAgentService>() as VisaFusionWebApplicationFactory.InMemoryAgentServiceStub;
        stub?.SeedPortalAgents();
    }

    [Theory]
    [InlineData("/api/v1/agents/42/entries")]
    [InlineData("/api/v1/agents/42/statuses")]
    [InlineData("/api/v1/agents/42/statement")]
    public async Task Portal_Routes_Anonymous_Returns_401(string route)
    {
        var response = await _client.GetAsync(route);

        Assert.Equal(HttpStatusCode.Unauthorized, response.StatusCode);
    }

    [Fact]
    public async Task Self_Route_Anonymous_Returns_401()
    {
        var response = await _client.PutAsync("/api/v1/agents/42/self", JsonContent.Create(new { city = "Pune" }));

        Assert.Equal(HttpStatusCode.Unauthorized, response.StatusCode);
    }

    [Theory]
    [InlineData("/api/v1/agents/42/entries")]
    [InlineData("/api/v1/agents/42/statuses")]
    [InlineData("/api/v1/agents/42/statement")]
    public async Task Agent_Own_Id_Returns_200_With_Data(string route)
    {
        var token = CreateTestToken(IdentityIntegration.Roles.Agent, agentId: 42);
        var request = new HttpRequestMessage(HttpMethod.Get, route);
        request.Headers.Authorization = new AuthenticationHeaderValue("Bearer", token);

        var response = await _client.SendAsync(request);

        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
        var body = await response.Content.ReadAsStringAsync();
        Assert.Contains("Portal Pax", body); // the stub's deterministic sample data
    }

    [Theory]
    [InlineData("/api/v1/agents/43/entries")]
    [InlineData("/api/v1/agents/43/statuses")]
    [InlineData("/api/v1/agents/43/statement")]
    public async Task Agent_Other_Agents_Id_Returns_403(string route)
    {
        // BR-007/AC-012: agt callers may only read their own record — the
        // claim-bound AgentId (42) never matches the requested id (43).
        var token = CreateTestToken(IdentityIntegration.Roles.Agent, agentId: 42);
        var request = new HttpRequestMessage(HttpMethod.Get, route);
        request.Headers.Authorization = new AuthenticationHeaderValue("Bearer", token);

        var response = await _client.SendAsync(request);

        Assert.Equal(HttpStatusCode.Forbidden, response.StatusCode);
    }

    [Theory]
    [InlineData("/api/v1/agents/42/entries")]
    [InlineData("/api/v1/agents/42/statuses")]
    [InlineData("/api/v1/agents/42/statement")]
    public async Task Agent_Without_AgentId_Claim_Returns_403(string route)
    {
        // CHK026: an agt without a linked AgentId claim is denied on portal
        // routes — the claim-bound identity is never re-derived from the route.
        var token = CreateTestToken(IdentityIntegration.Roles.Agent, agentId: null);
        var request = new HttpRequestMessage(HttpMethod.Get, route);
        request.Headers.Authorization = new AuthenticationHeaderValue("Bearer", token);

        var response = await _client.SendAsync(request);

        Assert.Equal(HttpStatusCode.Forbidden, response.StatusCode);
    }

    [Theory]
    [InlineData(IdentityIntegration.Roles.Employee)]
    [InlineData(IdentityIntegration.Roles.Admin)]
    [InlineData(IdentityIntegration.Roles.SuperUser)]
    public async Task Staff_Can_Read_Any_Agents_Data(string role)
    {
        // emp/adm/su may read any agent (contract §3/§3a/§4) — no AgentId
        // claim required.
        var token = CreateTestToken(role, agentId: null);
        foreach (var route in new[] { "/api/v1/agents/42/entries", "/api/v1/agents/42/statuses", "/api/v1/agents/42/statement" })
        {
            var request = new HttpRequestMessage(HttpMethod.Get, route);
            request.Headers.Authorization = new AuthenticationHeaderValue("Bearer", token);

            var response = await _client.SendAsync(request);

            Assert.Equal(HttpStatusCode.OK, response.StatusCode);
        }
    }

    [Fact]
    public async Task Entries_Keyword_Filter_Is_Passed_Through()
    {
        // FR-021: ?q= on entries — the stub filters its sample data; the
        // endpoint must pass the keyword through and return 200.
        var token = CreateTestToken(IdentityIntegration.Roles.Agent, agentId: 42);
        var request = new HttpRequestMessage(HttpMethod.Get, "/api/v1/agents/42/entries?q=One");
        request.Headers.Authorization = new AuthenticationHeaderValue("Bearer", token);

        var response = await _client.SendAsync(request);

        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
        var body = await response.Content.ReadAsStringAsync();
        Assert.Contains("Portal Pax One", body);
        Assert.DoesNotContain("Portal Pax Two", body);
    }

    [Fact]
    public async Task Statuses_Keyword_Filter_Is_Passed_Through()
    {
        // FR-021: ?q= on statuses.
        var token = CreateTestToken(IdentityIntegration.Roles.Agent, agentId: 42);
        var request = new HttpRequestMessage(HttpMethod.Get, "/api/v1/agents/42/statuses?q=Two");
        request.Headers.Authorization = new AuthenticationHeaderValue("Bearer", token);

        var response = await _client.SendAsync(request);

        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
        var body = await response.Content.ReadAsStringAsync();
        Assert.Contains("Portal Pax Two", body);
        Assert.DoesNotContain("Portal Pax One", body);
    }

    [Fact]
    public async Task Self_Update_Own_Record_Returns_200()
    {
        // FR-020/AC-014: the route id equals the claim-bound AgentId → the
        // agent's own record is updated.
        var token = CreateTestToken(IdentityIntegration.Roles.Agent, agentId: 42);
        var request = new HttpRequestMessage(HttpMethod.Put, "/api/v1/agents/42/self");
        request.Headers.Authorization = new AuthenticationHeaderValue("Bearer", token);
        request.Content = JsonContent.Create(new { city = "Pune" });

        var response = await _client.SendAsync(request);

        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
    }

    [Fact]
    public async Task Self_Update_Another_Agents_Id_Returns_403()
    {
        var token = CreateTestToken(IdentityIntegration.Roles.Agent, agentId: 42);
        var request = new HttpRequestMessage(HttpMethod.Put, "/api/v1/agents/43/self");
        request.Headers.Authorization = new AuthenticationHeaderValue("Bearer", token);
        request.Content = JsonContent.Create(new { city = "Pune" });

        var response = await _client.SendAsync(request);

        Assert.Equal(HttpStatusCode.Forbidden, response.StatusCode);
    }

    [Theory]
    [InlineData(IdentityIntegration.Roles.Employee)]
    [InlineData(IdentityIntegration.Roles.Admin)]
    [InlineData(IdentityIntegration.Roles.SuperUser)]
    public async Task Self_Update_By_Staff_Returns_403(string role)
    {
        // Staff carry no AgentId claim — the self route is own-only (contract
        // §2); they use the admin update route instead.
        var token = CreateTestToken(role, agentId: null);
        var request = new HttpRequestMessage(HttpMethod.Put, "/api/v1/agents/42/self");
        request.Headers.Authorization = new AuthenticationHeaderValue("Bearer", token);
        request.Content = JsonContent.Create(new { city = "Pune" });

        var response = await _client.SendAsync(request);

        Assert.Equal(HttpStatusCode.Forbidden, response.StatusCode);
    }

    private string CreateTestToken(string role, int? agentId)
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
            claims.Add(new Claim(IdentityClaims.AgentIdClaimType, agentId.Value.ToString()));
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