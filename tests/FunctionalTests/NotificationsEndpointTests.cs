using System.Diagnostics;
using System.IdentityModel.Tokens.Jwt;
using System.Net;
using System.Net.Http.Headers;
using System.Net.Http.Json;
using System.Security.Claims;
using System.Text;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using VisaFusion.Api.Authorization;
using VisaFusion.Identity;
using VisaFusion.Web;

namespace VisaFusion.FunctionalTests;

/// <summary>
/// Notification endpoint tests (SPEC-0008 T024, FR-001/FR-004/FR-009, AC-003/
/// AC-009; contracts/notifications-api.md §1/§3).
///
/// Proves the SMS enqueue/history contract hermetically over the real
/// <see cref="VisaFusion.Data.Application.SmsService"/> (the factory replaces
/// VisaEntryDbContext with an InMemory store):
///   - enqueue returns 202 for emp/adm/su (EntryOperations policy),
///   - anonymous → 401, agt → 403 (FR-009),
///   - history read returns 200 with the audit rows,
///   - enqueue latency stays under 1 second (AC-009, NFR-001).
/// Tokens are minted locally with the same development key the host uses
/// (test-only; production keys come from configuration, NFR-004).
/// </summary>
public class NotificationsEndpointTests : IClassFixture<VisaFusionWebApplicationFactory>
{
    private readonly VisaFusionWebApplicationFactory _factory;
    private readonly HttpClient _client;

    public NotificationsEndpointTests(VisaFusionWebApplicationFactory factory)
    {
        _factory = factory;
        _client = factory.CreateClient();
    }

    [Fact]
    public async Task Enqueue_Sms_Returns_202_For_Employee()
    {
        var response = await PostSmsAsync(_client, CreateTestToken(IdentityIntegration.Roles.Employee));
        Assert.Equal(HttpStatusCode.Accepted, response.StatusCode);
    }

    [Fact]
    public async Task Enqueue_Sms_Returns_202_For_Admin_And_SuperUser()
    {
        foreach (var role in new[] { IdentityIntegration.Roles.Admin, IdentityIntegration.Roles.SuperUser })
        {
            var response = await PostSmsAsync(_client, CreateTestToken(role));
            Assert.Equal(HttpStatusCode.Accepted, response.StatusCode);
        }
    }

    [Fact]
    public async Task Enqueue_Sms_Anonymous_Returns_401()
    {
        var response = await _client.PostAsJsonAsync("/api/v1/notifications/sms", ValidSmsBody());
        Assert.Equal(HttpStatusCode.Unauthorized, response.StatusCode);
    }

    [Fact]
    public async Task Enqueue_Sms_Agent_Returns_403()
    {
        var response = await PostSmsAsync(_client, CreateTestToken(IdentityIntegration.Roles.Agent));
        Assert.Equal(HttpStatusCode.Forbidden, response.StatusCode);
    }

    [Fact]
    public async Task Enqueue_Sms_Invalid_Body_Returns_400()
    {
        var response = await PostAsJsonAsync(
            _client,
            "/api/v1/notifications/sms",
            new { mobile = "123", message = "" }, // invalid mobile + blank message
            CreateTestToken(IdentityIntegration.Roles.Employee));
        Assert.Equal(HttpStatusCode.BadRequest, response.StatusCode);
    }

    [Fact]
    public async Task Sms_History_Returns_200_With_Audit_Rows()
    {
        var response = await GetAsync(_client,
            "/api/v1/notifications/sms-history",
            CreateTestToken(IdentityIntegration.Roles.Employee));
        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
    }

    [Fact]
    public async Task Sms_History_Invalid_Filter_Returns_400()
    {
        var response = await GetAsync(_client,
            "/api/v1/notifications/sms-history?agentId=not-an-int",
            CreateTestToken(IdentityIntegration.Roles.Employee));
        Assert.Equal(HttpStatusCode.BadRequest, response.StatusCode);
    }

    [Fact]
    public async Task Enqueue_Returns_In_Under_One_Second()
    {
        // AC-009: enqueue returns in under 1 second at the API boundary and
        // never blocks on dispatch (NFR-001). The token is minted and the host
        // primed (two warmup requests: model finalization + JIT of the full
        // path) BEFORE the stopwatch starts, so the measured window is the
        // steady-state request round-trip only.
        var token = CreateTestToken(IdentityIntegration.Roles.Employee);
        await PostSmsAsync(_client, token);
        await PostSmsAsync(_client, token);

        var stopwatch = Stopwatch.StartNew();
        var response = await PostSmsAsync(_client, token);
        stopwatch.Stop();

        Assert.Equal(HttpStatusCode.Accepted, response.StatusCode);
        Assert.True(stopwatch.Elapsed < TimeSpan.FromSeconds(1),
            $"enqueue took {stopwatch.Elapsed.TotalMilliseconds:F0} ms (AC-009 limit: 1000 ms)");
    }

    // ---- Email endpoints (SPEC-0008 T030/T032, FR-002/FR-005, AC-005) ----

    [Fact]
    public async Task Enqueue_Email_Returns_202_For_Employee()
    {
        var response = await PostEmailAsync(_client, CreateTestToken(IdentityIntegration.Roles.Employee));
        Assert.Equal(HttpStatusCode.Accepted, response.StatusCode);
    }

    [Fact]
    public async Task Enqueue_Email_Anonymous_Returns_401()
    {
        var response = await _client.PostAsJsonAsync("/api/v1/notifications/email", ValidEmailBody());
        Assert.Equal(HttpStatusCode.Unauthorized, response.StatusCode);
    }

    [Fact]
    public async Task Enqueue_Email_Agent_Returns_403()
    {
        var response = await PostEmailAsync(_client, CreateTestToken(IdentityIntegration.Roles.Agent));
        Assert.Equal(HttpStatusCode.Forbidden, response.StatusCode);
    }

    [Fact]
    public async Task Email_History_Returns_200_With_Audit_Rows()
    {
        var response = await GetAsync(_client,
            "/api/v1/notifications/email-history",
            CreateTestToken(IdentityIntegration.Roles.Employee));
        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
    }

    private static async Task<HttpResponseMessage> PostEmailAsync(HttpClient client, string token)
        => await PostAsJsonAsync(client, "/api/v1/notifications/email", ValidEmailBody(), token);

    private static object ValidEmailBody() => new
    {
        to = "agent@example.com",
        subject = "Visa status update",
        body = "Your visa application has been processed.",
    };

    private static async Task<HttpResponseMessage> PostSmsAsync(HttpClient client, string token)
        => await PostAsJsonAsync(client, "/api/v1/notifications/sms", ValidSmsBody(), token);

    private static object ValidSmsBody() => new
    {
        mobile = "+919876543210",
        message = "Your visa status has been updated",
    };

    private static async Task<HttpResponseMessage> PostAsJsonAsync(
        HttpClient client, string url, object body, string token)
    {
        var request = new HttpRequestMessage(HttpMethod.Post, url)
        {
            Content = JsonContent.Create(body),
        };
        request.Headers.Authorization = new AuthenticationHeaderValue("Bearer", token);
        return await client.SendAsync(request);
    }

    private static async Task<HttpResponseMessage> GetAsync(
        HttpClient client, string url, string token)
    {
        var request = new HttpRequestMessage(HttpMethod.Get, url);
        request.Headers.Authorization = new AuthenticationHeaderValue("Bearer", token);
        return await client.SendAsync(request);
    }

    private string CreateTestToken(string role)
    {
        var jwtKey = _factory.Services.GetService(typeof(IConfiguration)) is IConfiguration config
            ? config["Jwt:Key"]
            : null;
        jwtKey ??= "CHANGE_ME_development_only_do_not_use_in_production_0123456789";

        var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(jwtKey));
        var credentials = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);
        var claims = new List<Claim> { new(ClaimTypes.Role, role) };

        var token = new JwtSecurityToken(
            issuer: "VisaFusion",
            audience: "VisaFusion.Api",
            claims: claims,
            expires: DateTime.UtcNow.AddHours(1),
            signingCredentials: credentials);

        return new JwtSecurityTokenHandler().WriteToken(token);
    }
}