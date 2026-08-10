using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Net.Http.Json;
using System.Text;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.IdentityModel.Tokens;
using VisaFusion.Core.Application;

namespace VisaFusion.FunctionalTests;

/// <summary>
/// Shared business rule test (SPEC-0003 T039/T074, AC-003, TS-003).
///
/// Asserts the representative rule (T038, Canada DOB validation) returns the same
/// result when invoked via the Web service and via the employee representative Api
/// endpoint (T045). This proves the shared-Core surface: one business rule, two
/// entry points, identical behavior (FR-003).
///
/// The employee representative endpoint requires a bearer token (T045); the token
/// is minted locally with the same development key used by the host (test-only;
/// production keys come from configuration, NFR-004).
/// </summary>
public class SharedRuleTests : IClassFixture<VisaFusionWebApplicationFactory>
{
    private readonly HttpClient _client;
    private readonly VisaFusionWebApplicationFactory _factory;

    public SharedRuleTests(VisaFusionWebApplicationFactory factory)
    {
        _factory = factory;
        _client = factory.CreateClient();
    }

    [Fact]
    public async Task Employee_Api_Endpoint_Returns_Same_Rule_Result_As_Web_Service()
    {
        // Web-side rule: resolve the shared rule directly from the DI container
        // (the same registration the Web UI would use, T023/FR-003).
        var webRule = _factory.Services.GetRequiredService<ICanadaDobRule>();
        var webResult = webRule.IsAdultForCanadaVisa(new DateOnly(1990, 1, 1));

        // Api-side rule: the employee representative endpoint invokes the same
        // shared rule (T045, AC-003) and returns it in the stub payload.
        var request = new HttpRequestMessage(HttpMethod.Get, "/api/v1/employee");
        request.Headers.Authorization = new AuthenticationHeaderValue("Bearer", CreateTestToken("emp"));

        var response = await _client.SendAsync(request);

        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
        var body = await response.Content.ReadFromJsonAsync<EmployeeListResponse>();
        Assert.NotNull(body);
        Assert.True(body.Count >= 1);
        Assert.NotNull(body.Items);
        Assert.Equal(webResult, body.Items[0].CanadaAdultEligible);
    }

    [Fact]
    public async Task Employee_Api_Endpoint_Returns_401_Without_Token()
    {
        // The employee representative endpoint requires a bearer token (T045).
        var response = await _client.GetAsync("/api/v1/employee");

        Assert.Equal(HttpStatusCode.Unauthorized, response.StatusCode);
        var problem = await response.Content.ReadFromJsonAsync<EmployeeUnauthorizedResponse>();
        Assert.NotNull(problem);
        Assert.Equal(401, problem.Status);
    }

    private string CreateTestToken(string role)
    {
        var jwtKey = _factory.Services.GetService(typeof(IConfiguration)) is IConfiguration config
            ? config["Jwt:Key"]
            : null;
        jwtKey ??= "CHANGE_ME_development_only_do_not_use_in_production_0123456789";

        var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(jwtKey));
        var credentials = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);
        var claims = new[] { new Claim(ClaimTypes.Role, role) };
        var token = new JwtSecurityToken(
            issuer: "VisaFusion",
            audience: "VisaFusion.Api",
            claims: claims,
            expires: DateTime.UtcNow.AddHours(1),
            signingCredentials: credentials);

        return new JwtSecurityTokenHandler().WriteToken(token);
    }

    private sealed class EmployeeListResponse
    {
        public EmployeeItem[]? Items { get; set; }
        public int Count { get; set; }
    }

    private sealed class EmployeeItem
    {
        public bool CanadaAdultEligible { get; set; }
    }

    private sealed class EmployeeUnauthorizedResponse
    {
        public int Status { get; set; }
    }
}