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
using VisaFusion.Api.Contracts;
using VisaFusion.Identity;

namespace VisaFusion.FunctionalTests;

/// <summary>
/// Backdoor-inertness and agent-isolation functional tests (SPEC-0005 T027, US4,
/// AC-003/AC-006, TS-003/TS-006, FR-015/FR-016).
///
/// - The legacy backdoor query parameters (`udaanappraj123guruadm`,
///   `udaan12345functiondisplaymarquee`, spec FR-015/§2.7) have NO effect on any
///   route: responses are byte-identical to requests without them.
/// - Agent isolation (FR-016/§17): an `agt` principal requesting another
///   agent's id on the own-record route yields 403, never the other agent's
///   data; the own id yields the 501 placeholder.
/// </summary>
public class BackdoorAndIsolationTests : IClassFixture<VisaFusionWebApplicationFactory>
{
    private const string BackdoorAdminParam = "udaanappraj123guruadm";
    private const string BackdoorMarqueeParam = "udaan12345functiondisplaymarquee";

    private readonly VisaFusionWebApplicationFactory _factory;
    private readonly HttpClient _client;

    public BackdoorAndIsolationTests(VisaFusionWebApplicationFactory factory)
    {
        _factory = factory;
        _client = factory.CreateClient();
    }

    [Theory]
    [InlineData(BackdoorAdminParam)]
    [InlineData(BackdoorMarqueeParam)]
    public async Task Backdoor_Query_Param_Has_No_Effect_On_Health(string param)
    {
        var baseline = await _client.GetAsync("/api/v1/health");
        var withParam = await _client.GetAsync($"/api/v1/health?{param}=1");

        Assert.Equal(HttpStatusCode.OK, baseline.StatusCode);
        Assert.Equal(HttpStatusCode.OK, withParam.StatusCode);
        Assert.Equal(await baseline.Content.ReadAsStringAsync(), await withParam.Content.ReadAsStringAsync());
    }

    [Theory]
    [InlineData(BackdoorAdminParam)]
    [InlineData(BackdoorMarqueeParam)]
    public async Task Backdoor_Query_Param_Has_No_Effect_On_Login(string param)
    {
        var baseline = await _client.PostAsJsonAsync("/api/v1/auth/login",
            new LoginRequest { UserName = "nobody", Password = "WrongPass123!" });
        var withParam = await _client.PostAsJsonAsync($"/api/v1/auth/login?{param}=1",
            new LoginRequest { UserName = "nobody", Password = "WrongPass123!" });

        Assert.Equal(HttpStatusCode.Unauthorized, baseline.StatusCode);
        Assert.Equal(HttpStatusCode.Unauthorized, withParam.StatusCode);

        // The problem-details body carries a per-request traceId, so the raw
        // bytes differ; the OUTCOME (title + status) must be identical — the
        // backdoor parameter changes nothing about the response.
        var baselineProblem = await baseline.Content.ReadFromJsonAsync<ProblemDetailsResponse>();
        var withParamProblem = await withParam.Content.ReadFromJsonAsync<ProblemDetailsResponse>();
        Assert.NotNull(baselineProblem);
        Assert.NotNull(withParamProblem);
        Assert.Equal(baselineProblem!.Title, withParamProblem!.Title);
        Assert.Equal(baselineProblem.Status, withParamProblem.Status);
    }

    [Fact]
    public async Task Agent_Requesting_Another_Agents_Id_Returns_403()
    {
        // FR-016/§17: the own-record route validates that the target id equals
        // the caller's claim-bound AgentId; mismatch → 403, never the other
        // agent's data.
        var request = new HttpRequestMessage(HttpMethod.Put, "/api/v1/agents/999/self");
        request.Headers.Authorization = new AuthenticationHeaderValue("Bearer", CreateTestToken(agentId: 5771));

        var response = await _client.SendAsync(request);

        Assert.Equal(HttpStatusCode.Forbidden, response.StatusCode);
    }

    [Fact]
    public async Task Agent_Requesting_Own_Id_Returns_501()
    {
        // Own record: the claim-bound AgentId (5771) equals the route id → the
        // placeholder 501 (the business payload lands with the Agent
        // self-service module feature).
        var request = new HttpRequestMessage(HttpMethod.Put, "/api/v1/agents/5771/self");
        request.Headers.Authorization = new AuthenticationHeaderValue("Bearer", CreateTestToken(agentId: 5771));

        var response = await _client.SendAsync(request);

        Assert.Equal(HttpStatusCode.NotImplemented, response.StatusCode);
    }

    private string CreateTestToken(int agentId)
    {
        var jwtKey = _factory.Services.GetService(typeof(IConfiguration)) is IConfiguration config
            ? config["Jwt:Key"]
            : null;
        jwtKey ??= "CHANGE_ME_development_only_do_not_use_in_production_0123456789";

        var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(jwtKey));
        var credentials = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);
        var claims = new[]
        {
            new Claim(ClaimTypes.Role, IdentityIntegration.Roles.Agent),
            new Claim(IdentityClaims.AgentIdClaimType, agentId.ToString()),
        };
        var token = new JwtSecurityToken(
            issuer: "VisaFusion",
            audience: "VisaFusion.Api",
            claims: claims,
            expires: DateTime.UtcNow.AddHours(1),
            signingCredentials: credentials);

        return new JwtSecurityTokenHandler().WriteToken(token);
    }

    private sealed class ProblemDetailsResponse
    {
        public string? Title { get; set; }
        public int Status { get; set; }
    }
}