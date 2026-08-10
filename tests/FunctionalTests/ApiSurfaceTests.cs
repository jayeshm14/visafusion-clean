using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Net.Http.Json;
using System.Text;
using System.Text.Json;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;

namespace VisaFusion.FunctionalTests;

/// <summary>
/// Api surface tests (SPEC-0003 T040/T041, User Story 4, FR-004/FR-010).
///
/// - `GET /api/v1/health` returns 200 with `status: ok` (no auth).
/// - A representative endpoint returns 401 without a bearer token and 200 with one.
///
/// The bearer token is minted locally with the same development key used by the
/// host (test-only; production keys come from configuration, NFR-004).
/// </summary>
public class ApiSurfaceTests : IClassFixture<VisaFusionWebApplicationFactory>
{
    private readonly HttpClient _client;
    private readonly VisaFusionWebApplicationFactory _factory;

    public ApiSurfaceTests(VisaFusionWebApplicationFactory factory)
    {
        _factory = factory;
        _client = factory.CreateClient();
    }

    [Fact]
    public async Task Health_Returns_200_With_Status_Ok()
    {
        var response = await _client.GetAsync("/api/v1/health");

        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
        var body = await response.Content.ReadFromJsonAsync<HealthResponse>();
        Assert.NotNull(body);
        Assert.Equal("ok", body.Status);
        Assert.Equal("1", body.Version);
    }

    [Fact]
    public async Task Representative_Endpoint_Returns_401_Without_Token()
    {
        var response = await _client.GetAsync("/api/v1/employee");

        Assert.Equal(HttpStatusCode.Unauthorized, response.StatusCode);
    }

    [Fact]
    public async Task Representative_Endpoint_Returns_200_With_Token()
    {
        var request = new HttpRequestMessage(HttpMethod.Get, "/api/v1/employee");
        request.Headers.Authorization = new AuthenticationHeaderValue("Bearer", CreateTestToken("emp"));

        var response = await _client.SendAsync(request);

        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
        var body = await response.Content.ReadFromJsonAsync<RepresentativeListResponse>();
        Assert.NotNull(body);
        Assert.True(body.Count >= 1);
    }

    [Fact]
    public async Task Public_Endpoint_Is_Anonymous_Allowed()
    {
        var response = await _client.GetAsync("/api/v1/public");

        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
    }

    [Fact]
    public async Task Auth_Endpoint_Is_Anonymous_Allowed_And_Returns_Empty_Stub()
    {
        // T064/T070 (HG-1): the eighth area endpoint must resolve. The legacy Auth
        // module is the anonymous login/registration entry point, so /api/v1/auth
        // is anonymous-allowed and returns the standard stub { items: [], count: 0 }.
        var response = await _client.GetAsync("/api/v1/auth");

        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
        var body = await response.Content.ReadFromJsonAsync<RepresentativeListResponse>();
        Assert.NotNull(body);
        Assert.Equal(0, body.Count);
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

    private sealed class HealthResponse
    {
        public string? Status { get; set; }
        public string? Version { get; set; }
    }

    private sealed class RepresentativeListResponse
    {
        public int Count { get; set; }
    }
}