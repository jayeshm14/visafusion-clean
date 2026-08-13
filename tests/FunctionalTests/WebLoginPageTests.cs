using System.Net;
using System.Net.Http.Json;
using System.Text.RegularExpressions;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc.Testing;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.DependencyInjection.Extensions;
using VisaFusion.Core.Application;
using VisaFusion.Identity;
using VisaFusion.Web;

namespace VisaFusion.FunctionalTests;

/// <summary>
/// Web cookie login page tests (SPEC-0005 rigorous-testing pass, web-ui.md §1.1,
/// FR-017/FR-018, AC-001/AC-011).
///
/// The cookie sign-in page (spec §14) was delivered (T013) but never exercised
/// end-to-end: the 5-role login was proven only over the bearer API
/// (AuthLoginTests), and the day-gate rejection only at the service level
/// (SecurityGateServiceTests + SecurityGateIntegrationTests). These tests close
/// that gap:
///   - GET renders the form (and the legacy `relogin.asp?rsn=` reason inline),
///   - a valid POST issues the cookie and redirects to the home page,
///   - bad credentials render the generic error inline (no account-state
///     disclosure),
///   - an `emp` POST rejected by the day-gate redirects to `/Auth/Login?rsn=O`
///     WITHOUT issuing a cookie (FR-018; rsn=C is never produced),
///   - the API login surfaces the same day-gate rejection as `403 rsn=O`
///     problem-details (contracts/auth-api.md §1),
///   - non-emp roles are never gated, even with a rejecting gate.
/// </summary>
public class WebLoginPageTests : IClassFixture<VisaFusionWebApplicationFactory>
{
    private readonly VisaFusionWebApplicationFactory _factory;
    private readonly HttpClient _client;

    public WebLoginPageTests(VisaFusionWebApplicationFactory factory)
    {
        _factory = factory;
        // Default factory client: follows redirects and keeps the cookie jar —
        // the browser-like flow used for the success path.
        _client = factory.CreateClient();
    }

    private HttpClient NoRedirectClient() => _factory.CreateClient(new WebApplicationFactoryClientOptions
    {
        AllowAutoRedirect = false,
    });

    [Fact]
    public async Task Get_Renders_The_Login_Form()
    {
        var response = await _client.GetAsync("/Auth/Login");

        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
        var html = await response.Content.ReadAsStringAsync();
        Assert.Contains("name=\"UserName\"", html);
        Assert.Contains("name=\"Password\"", html);
        Assert.Contains("name=\"returnUrl\"", html);
    }

    [Fact]
    public async Task Get_With_Rsn_O_Renders_The_Day_Gate_Reason_Inline()
    {
        // web-ui.md §1.1: the Web login renders the legacy `relogin.asp?rsn=`
        // reason inline — rsn=O is the day-gate rejection message.
        var response = await _client.GetAsync("/Auth/Login?rsn=O");

        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
        var html = await response.Content.ReadAsStringAsync();
        Assert.Contains("The office has not been opened for today.", html);
    }

    [Fact]
    public async Task Valid_Post_Issues_The_Cookie_And_Redirects_To_Home()
    {
        SeedUser("web-login-ok", IdentityIntegration.Roles.Guest);
        var token = await GetAntiforgeryTokenAsync();

        var response = await _client.PostAsync("/Auth/Login", new FormUrlEncodedContent(new Dictionary<string, string>
        {
            ["__RequestVerificationToken"] = token,
            ["UserName"] = "web-login-ok",
            ["Password"] = TestPassword,
        }));

        Assert.Equal(HttpStatusCode.OK, response.StatusCode); // followed the 302 to /
        // The cookie-authenticated home page renders after the redirect.
        Assert.Contains("VisaFusion", await response.Content.ReadAsStringAsync());
    }

    [Fact]
    public async Task Valid_Post_Issues_302_To_Home_Before_The_Redirect_Is_Followed()
    {
        SeedUser("web-login-302", IdentityIntegration.Roles.Guest);
        var client = NoRedirectClient();
        var token = await GetAntiforgeryTokenAsync(client);

        var response = await client.PostAsync("/Auth/Login", new FormUrlEncodedContent(new Dictionary<string, string>
        {
            ["__RequestVerificationToken"] = token,
            ["UserName"] = "web-login-302",
            ["Password"] = TestPassword,
        }));

        Assert.Equal(HttpStatusCode.Redirect, response.StatusCode);
        Assert.Equal("/", response.Headers.Location?.OriginalString);
    }

    [Fact]
    public async Task Bad_Credentials_Render_The_Generic_Error_Inline()
    {
        SeedUser("web-login-bad", IdentityIntegration.Roles.Guest);
        var client = NoRedirectClient();
        var token = await GetAntiforgeryTokenAsync(client);

        var response = await client.PostAsync("/Auth/Login", new FormUrlEncodedContent(new Dictionary<string, string>
        {
            ["__RequestVerificationToken"] = token,
            ["UserName"] = "web-login-bad",
            ["Password"] = "WrongPass123!",
        }));

        // The page re-renders with a single generic message — no account-state
        // disclosure (a bad password and a locked account look identical).
        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
        var html = await response.Content.ReadAsStringAsync();
        Assert.Contains("Invalid username or password.", html);
        // No cookie may be issued for a failed login.
        Assert.False(response.Headers.TryGetValues("Set-Cookie", out _));
    }

    [Fact]
    public async Task Emp_Login_Rejected_By_The_Day_Gate_Redirects_To_Rsn_O_Without_A_Cookie()
    {
        // FR-018/AC-011: an emp login with no open security day for today is
        // rejected with rsn=O (rsn=C is never produced) and redirected to
        // /Auth/Login?rsn=O, mirroring the legacy relogin.asp?rsn=.
        var factory = RejectingDayGateFactory();
        var client = factory.CreateClient(new WebApplicationFactoryClientOptions
        {
            AllowAutoRedirect = false,
        });
        SeedUser("web-emp-gated", IdentityIntegration.Roles.Employee, factory);
        var token = await GetAntiforgeryTokenAsync(client);

        var response = await client.PostAsync("/Auth/Login", new FormUrlEncodedContent(new Dictionary<string, string>
        {
            ["__RequestVerificationToken"] = token,
            ["UserName"] = "web-emp-gated",
            ["Password"] = TestPassword,
        }));

        Assert.Equal(HttpStatusCode.Redirect, response.StatusCode);
        Assert.Equal("/Auth/Login?rsn=O", response.Headers.Location?.OriginalString);
        // A rejected emp login never receives an authenticated cookie.
        Assert.False(response.Headers.TryGetValues("Set-Cookie", out _));
    }

    [Fact]
    public async Task Api_Emp_Login_Rejected_By_The_Day_Gate_Returns_403_With_Rsn_O()
    {
        // contracts/auth-api.md §1: the API login returns 403 with rsn=O in the
        // problem-details body for a gated emp login (FR-018).
        var factory = RejectingDayGateFactory();
        var client = factory.CreateClient();
        SeedUser("api-emp-gated", IdentityIntegration.Roles.Employee, factory);

        var response = await client.PostAsJsonAsync("/api/v1/auth/login",
            new Api.Contracts.LoginRequest { UserName = "api-emp-gated", Password = TestPassword });

        Assert.Equal(HttpStatusCode.Forbidden, response.StatusCode);
        var body = await response.Content.ReadAsStringAsync();
        Assert.Contains("\"status\":403", body);
        Assert.Contains("\"rsn\":\"O\"", body);
        Assert.DoesNotContain("\"C\"", body); // rsn=C is never produced (legacy dead code)
    }

    [Fact]
    public async Task Non_Emp_Login_Is_Not_Gated_Even_With_A_Rejecting_Gate()
    {
        // FR-018: the day-gate applies to emp logins only (authenticate.asp
        // lines 62–79) — adm/su/agt/guest logins are never gated.
        var factory = RejectingDayGateFactory();
        var client = factory.CreateClient();
        SeedUser("web-adm-ok", IdentityIntegration.Roles.Admin, factory);

        var response = await client.PostAsJsonAsync("/api/v1/auth/login",
            new Api.Contracts.LoginRequest { UserName = "web-adm-ok", Password = TestPassword });

        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
    }

    /// <summary>
    /// Derived factory that swaps the open-day stub for a rejecting gate, so
    /// the endpoint-level day-gate wiring (403 rsn=O / rsn=O redirect) is
    /// proven hermetically without a database (plan.md "Testing").
    /// </summary>
    private WebApplicationFactory<Program> RejectingDayGateFactory()
        => _factory.WithWebHostBuilder(builder =>
            builder.ConfigureServices(services =>
            {
                services.RemoveAll<ISecurityGateService>();
                services.AddScoped<ISecurityGateService, RejectingDayGateStub>();
            }));

    private sealed class RejectingDayGateStub : ISecurityGateService
    {
        // Mirrors the real SecurityGateService rule (authenticate.asp lines
        // 62–79): only emp logins are gated; adm/su/agt/guest are never.
        public Task<SecurityGateDecision> EvaluateAsync(IEnumerable<string> roles, DateTime date)
            => Task.FromResult(roles.Contains(IdentityIntegration.Roles.Employee)
                ? SecurityGateDecision.RejectedNotOpened
                : SecurityGateDecision.Allowed);
    }

    private async Task<string> GetAntiforgeryTokenAsync(HttpClient? client = null)
    {
        client ??= _client;
        var response = await client.GetAsync("/Auth/Login");
        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
        var html = await response.Content.ReadAsStringAsync();
        var match = Regex.Match(html, "__RequestVerificationToken[^>]*value=\"([^\"]+)\"");
        Assert.True(match.Success, "antiforgery token not found in the login page");
        return match.Groups[1].Value;
    }

    private void SeedUser(string userName, string role, WebApplicationFactory<Program>? factory = null)
    {
        using var scope = (factory ?? _factory).Services.CreateScope();
        var userManager = scope.ServiceProvider
            .GetRequiredService<UserManager<IdentityIntegration.VisaFusionUser>>();

        var user = new IdentityIntegration.VisaFusionUser
        {
            UserName = userName,
            Email = $"{userName}@test.local",
        };
        var createResult = userManager.CreateAsync(user, TestPassword).GetAwaiter().GetResult();
        Assert.True(createResult.Succeeded,
            string.Join("; ", createResult.Errors.Select(e => e.Description)));
        var roleResult = userManager.AddToRoleAsync(user, role).GetAwaiter().GetResult();
        Assert.True(roleResult.Succeeded,
            string.Join("; ", roleResult.Errors.Select(e => e.Description)));
    }

    private const string TestPassword = "TestPass123!";
}
