using System.IdentityModel.Tokens.Jwt;
using System.Net;
using System.Net.Http;
using System.Security.Claims;
using System.Text;
using System.Text.RegularExpressions;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc.Testing;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.IdentityModel.Tokens;
using VisaFusion.Identity;

namespace VisaFusion.FunctionalTests;

/// <summary>
/// Security-day page functional test (SPEC-0007 T026, US3, FR-008, AC-004;
/// contracts/ui-contract.md §5, contracts/admin-api.md §1-§3).
///
/// Proves the cookie-backed Razor Pages admin surface for the working-day
/// gate (legacy `securityHome.asp`/`openForDay.asp`/`closeForDay.asp`):
///   - anonymous → redirect to /Auth/Login ([Authorize]),
///   - authenticated non-privileged (guest) → redirect to /Auth/AccessDenied
///     (SecurityGate policy = adm/su),
///   - adm sees the today-status card (not-yet-opened state on a fresh day),
///   - adm can open the day through the page → inline success message and the
///     open state card,
///   - opening an already-open day → inline "already open" message (409 parity),
///   - adm can close the open day → inline success message and the closed
///     state card,
///   - closing with no open day → inline "no open day" message (404 parity).
///
/// Uses the hermetic <see cref="VisaFusionWebApplicationFactory"/> with the
/// stateful in-memory <see cref="ISecurityGateService"/> stub (the write
/// surface semantics — AlreadyOpen/NotFound — are faithful; the real DB
/// behavior is covered by the unit and integration tests). Users are seeded
/// through the factory's UserManager (the AgentPagesTests convention).
/// </summary>
public class SecurityDayPagesTests : IClassFixture<VisaFusionWebApplicationFactory>
{
    private readonly VisaFusionWebApplicationFactory _factory;
    private readonly HttpClient _client;

    public SecurityDayPagesTests(VisaFusionWebApplicationFactory factory)
    {
        _factory = factory;
        _client = factory.CreateClient();
    }

    [Fact]
    public async Task Anonymous_Get_Redirects_To_Login()
    {
        var client = _factory.CreateClient(new WebApplicationFactoryClientOptions
        {
            AllowAutoRedirect = false,
        });

        var response = await client.GetAsync("/Admin/SecurityDay");

        Assert.Equal(HttpStatusCode.Redirect, response.StatusCode);
        var location = response.Headers.Location;
        Assert.NotNull(location);
        Assert.Equal("/Auth/Login", location!.AbsolutePath);
    }

    [Fact]
    public async Task Wrong_Role_Is_Redirected_To_AccessDenied()
    {
        SeedUser("pages-guest", IdentityIntegration.Roles.Guest);

        var client = _factory.CreateClient(new WebApplicationFactoryClientOptions
        {
            AllowAutoRedirect = false,
        });
        await SignInOnClientAsync(client, "pages-guest");

        var response = await client.GetAsync("/Admin/SecurityDay");

        Assert.Equal(HttpStatusCode.Redirect, response.StatusCode);
        // Cookie auth's AccessDeniedPath (/Auth/AccessDenied) — the page-level
        // mirror of the API's 403 (AC-004).
        Assert.Equal("/Auth/AccessDenied", response.Headers.Location?.AbsolutePath);
    }

    [Fact]
    public async Task Admin_Sees_The_Today_Status_Card()
    {
        var userName = $"pages-adm-{Guid.NewGuid():N}";
        SeedUser(userName, IdentityIntegration.Roles.Admin);
        await SignInAsync(userName);

        var response = await _client.GetAsync("/Admin/SecurityDay");

        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
        var html = await response.Content.ReadAsStringAsync();
        Assert.Contains("Security day", html);
        Assert.Contains("has not been opened", html); // fresh-day state
        Assert.Contains("Open the day", html);
    }

    [Fact]
    public async Task Admin_Can_Open_The_Day_Through_The_Page()
    {
        var userName = $"pages-adm-{Guid.NewGuid():N}";
        SeedUser(userName, IdentityIntegration.Roles.Admin);
        await SignInAsync(userName);

        var token = await GetAntiforgeryTokenAsync("/Admin/SecurityDay");
        var response = await _client.PostAsync(
            "/Admin/SecurityDay?handler=Open",
            new FormUrlEncodedContent(new Dictionary<string, string>
            {
                ["__RequestVerificationToken"] = token,
            }));

        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
        var html = await response.Content.ReadAsStringAsync();
        Assert.Contains("The working day is open.", html);
        Assert.Contains("Close the day", html); // the open-state action
    }

    [Fact]
    public async Task Opening_An_Already_Open_Day_Shows_The_Inline_Error()
    {
        var userName = $"pages-adm-{Guid.NewGuid():N}";
        SeedUser(userName, IdentityIntegration.Roles.Admin);
        await SignInAsync(userName);

        // Open once.
        var token = await GetAntiforgeryTokenAsync("/Admin/SecurityDay");
        var first = await _client.PostAsync(
            "/Admin/SecurityDay?handler=Open",
            new FormUrlEncodedContent(new Dictionary<string, string>
            {
                ["__RequestVerificationToken"] = token,
            }));
        Assert.Equal(HttpStatusCode.OK, first.StatusCode);

        // Open again → the stub's AlreadyOpen (the API's 409) surfaces inline.
        var second = await _client.PostAsync(
            "/Admin/SecurityDay?handler=Open",
            new FormUrlEncodedContent(new Dictionary<string, string>
            {
                ["__RequestVerificationToken"] = token,
            }));
        Assert.Equal(HttpStatusCode.OK, second.StatusCode);
        var html = await second.Content.ReadAsStringAsync();
        Assert.Contains("The working day is already open.", html);
    }

    [Fact]
    public async Task Admin_Can_Close_The_Open_Day_Through_The_Page()
    {
        var userName = $"pages-adm-{Guid.NewGuid():N}";
        SeedUser(userName, IdentityIntegration.Roles.Admin);
        await SignInAsync(userName);

        // Open, then close — the full AC-004 lifecycle on one page.
        var token = await GetAntiforgeryTokenAsync("/Admin/SecurityDay");
        await _client.PostAsync(
            "/Admin/SecurityDay?handler=Open",
            new FormUrlEncodedContent(new Dictionary<string, string>
            {
                ["__RequestVerificationToken"] = token,
            }));

        var closed = await _client.PostAsync(
            "/Admin/SecurityDay?handler=Close",
            new FormUrlEncodedContent(new Dictionary<string, string>
            {
                ["__RequestVerificationToken"] = token,
            }));

        Assert.Equal(HttpStatusCode.OK, closed.StatusCode);
        var html = await closed.Content.ReadAsStringAsync();
        Assert.Contains("The working day is closed.", html);
        Assert.Contains("Open the day", html); // back to the open action
    }

    [Fact]
    public async Task Closing_With_No_Open_Day_Shows_The_Inline_Error()
    {
        var userName = $"pages-adm-{Guid.NewGuid():N}";
        SeedUser(userName, IdentityIntegration.Roles.Admin);
        await SignInAsync(userName);

        // Close with no open day → the stub's NotFound (the API's 404).
        var token = await GetAntiforgeryTokenAsync("/Admin/SecurityDay");
        var response = await _client.PostAsync(
            "/Admin/SecurityDay?handler=Close",
            new FormUrlEncodedContent(new Dictionary<string, string>
            {
                ["__RequestVerificationToken"] = token,
            }));

        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
        var html = await response.Content.ReadAsStringAsync();
        Assert.Contains("No open working day exists to close.", html);
    }

    /// <summary>Signs in via the Web login page so the shared client holds the cookie.</summary>
    private async Task SignInAsync(string userName)
        => await SignInOnClientAsync(_client, userName);

    private async Task SignInOnClientAsync(HttpClient client, string userName)
    {
        var token = await GetAntiforgeryTokenOnClientAsync(client, "/Auth/Login");
        var response = await client.PostAsync("/Auth/Login", new FormUrlEncodedContent(new Dictionary<string, string>
        {
            ["__RequestVerificationToken"] = token,
            ["UserName"] = userName,
            ["Password"] = TestPassword,
        }));
        // 200 when the client followed the post-login redirect; 302 when the
        // client has auto-redirect disabled (the cookie is set either way).
        Assert.True(response.StatusCode is HttpStatusCode.OK or HttpStatusCode.Redirect,
            $"login failed with {response.StatusCode}");
    }

    private Task<string> GetAntiforgeryTokenAsync(string url)
        => GetAntiforgeryTokenOnClientAsync(_client, url);

    private async Task<string> GetAntiforgeryTokenOnClientAsync(HttpClient client, string url)
    {
        var response = await client.GetAsync(url);
        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
        var html = await response.Content.ReadAsStringAsync();
        var match = Regex.Match(html, "__RequestVerificationToken[^>]*value=\"([^\"]+)\"");
        Assert.True(match.Success, $"antiforgery token not found in {url}");
        return match.Groups[1].Value;
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
        var createResult = userManager.CreateAsync(user, TestPassword).GetAwaiter().GetResult();
        Assert.True(createResult.Succeeded,
            string.Join("; ", createResult.Errors.Select(e => e.Description)));
        var roleResult = userManager.AddToRoleAsync(user, role).GetAwaiter().GetResult();
        Assert.True(roleResult.Succeeded,
            string.Join("; ", roleResult.Errors.Select(e => e.Description)));
    }

    private const string TestPassword = "TestPass123!";
}