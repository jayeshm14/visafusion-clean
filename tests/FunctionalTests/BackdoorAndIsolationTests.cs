using System.IdentityModel.Tokens.Jwt;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Net.Http.Json;
using System.Security.Claims;
using System.Text;
using System.Text.Json;
using Microsoft.AspNetCore.Identity;
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
///   data; the own id with a valid body updates the agent's own record
///   (SPEC-0007 US4, FR-020).
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
    public async Task Agent_Requesting_Own_Id_With_Valid_Body_Returns_200()
    {
        // Own record: the claim-bound AgentId equals the route id → the
        // implemented self-update handler (SPEC-0007 US4, FR-020) updates the
        // agent's own record. The stub is seeded through the API surface (the
        // same convention as AgentRbacTests) so the update resolves.
        var adminToken = MintToken(IdentityIntegration.Roles.Admin);
        var create = new HttpRequestMessage(HttpMethod.Post, "/api/v1/agents");
        create.Headers.Authorization = new AuthenticationHeaderValue("Bearer", adminToken);
        create.Content = JsonContent.Create(new
        {
            companyname = "Self Update Co",
            username = $"self-{Guid.NewGuid():N}",
            password = "Str0ngPass!",
        });
        var createResponse = await _client.SendAsync(create);
        Assert.Equal(HttpStatusCode.Created, createResponse.StatusCode);
        var created = await createResponse.Content.ReadFromJsonAsync<JsonElement>();
        var agentId = created.GetProperty("id").GetInt32();

        var request = new HttpRequestMessage(HttpMethod.Put, $"/api/v1/agents/{agentId}/self");
        request.Headers.Authorization = new AuthenticationHeaderValue("Bearer", CreateTestToken(agentId: agentId));
        request.Content = JsonContent.Create(new { city = "Pune" });

        var response = await _client.SendAsync(request);

        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
    }

    private string MintToken(string role)
    {
        var userName = $"backdoor-{role}-{Guid.NewGuid():N}";
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