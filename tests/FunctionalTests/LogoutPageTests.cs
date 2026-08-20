using System.Net;
using System.Text.RegularExpressions;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc.Testing;
using Microsoft.Extensions.DependencyInjection;
using VisaFusion.Identity;

namespace VisaFusion.FunctionalTests;

/// <summary>
/// Web cookie sign-out page tests (SPEC-0009 review fix 2026-08-20).
///
/// The header "Sign out" action posts to /Auth/Logout — previously a
/// non-existent page that returned the 404 error page. The handler clears the
/// application cookie via SignInManager.SignOutAsync and redirects to home;
/// GET never signs out (the header only posts).
/// </summary>
public class LogoutPageTests : IClassFixture<VisaFusionWebApplicationFactory>
{
    private readonly VisaFusionWebApplicationFactory _factory;
    private readonly HttpClient _client;

    public LogoutPageTests(VisaFusionWebApplicationFactory factory)
    {
        _factory = factory;
        _client = factory.CreateClient();
    }

    private HttpClient NoRedirectClient() => _factory.CreateClient(new WebApplicationFactoryClientOptions
    {
        AllowAutoRedirect = false,
    });

    [Fact]
    public async Task Get_Logout_While_Anonymous_Redirects_To_Login()
    {
        var client = NoRedirectClient();
        var response = await client.GetAsync("/Auth/Logout");

        Assert.Equal(HttpStatusCode.Redirect, response.StatusCode);
        // Cookie auth redirects to the absolute LoginPath URL.
        Assert.Contains("/Auth/Login", response.Headers.Location?.OriginalString);
    }

    [Fact]
    public async Task Post_Logout_Clears_The_Cookie_And_Redirects_To_Home()
    {
        SeedUser("web-logout-ok", IdentityIntegration.Roles.Guest);
        var client = NoRedirectClient();

        // Sign in first (the header only shows Sign out when authenticated).
        var loginToken = await GetAntiforgeryTokenAsync(client, "/Auth/Login");
        var login = await client.PostAsync("/Auth/Login", new FormUrlEncodedContent(new Dictionary<string, string>
        {
            ["__RequestVerificationToken"] = loginToken,
            ["UserName"] = "web-logout-ok",
            ["Password"] = TestPassword,
        }));
        Assert.Equal(HttpStatusCode.Redirect, login.StatusCode);
        Assert.True(login.Headers.TryGetValues("Set-Cookie", out var loginCookies));
        Assert.Contains(loginCookies, c => c.Contains(".AspNetCore.Identity.Application"));

        // The antiforgery token is bound to the authenticated identity, so a
        // fresh token is fetched from an authenticated page after login.
        var logoutToken = await GetAntiforgeryTokenAsync(client, "/Auth/ChangePassword");

        var logout = await client.PostAsync("/Auth/Logout", new FormUrlEncodedContent(new Dictionary<string, string>
        {
            ["__RequestVerificationToken"] = logoutToken,
        }));

        Assert.Equal(HttpStatusCode.Redirect, logout.StatusCode);
        Assert.Equal("/", logout.Headers.Location?.OriginalString);
        // The application cookie is cleared (expired) in the response.
        Assert.True(logout.Headers.TryGetValues("Set-Cookie", out var logoutCookies));
        Assert.Contains(logoutCookies, c => c.Contains(".AspNetCore.Identity.Application") && c.Contains("expires="));
    }

    [Fact]
    public async Task After_Logout_An_Authenticated_Page_Redirects_To_Login()
    {
        SeedUser("web-logout-verify", IdentityIntegration.Roles.Guest);
        var client = NoRedirectClient();

        var loginToken = await GetAntiforgeryTokenAsync(client, "/Auth/Login");
        var login = await client.PostAsync("/Auth/Login", new FormUrlEncodedContent(new Dictionary<string, string>
        {
            ["__RequestVerificationToken"] = loginToken,
            ["UserName"] = "web-logout-verify",
            ["Password"] = TestPassword,
        }));
        Assert.Equal(HttpStatusCode.Redirect, login.StatusCode);

        // Before logout, the authenticated page renders.
        var before = await client.GetAsync("/Auth/ChangePassword");
        Assert.Equal(HttpStatusCode.OK, before.StatusCode);

        var logoutToken = await GetAntiforgeryTokenAsync(client, "/Auth/ChangePassword");
        var logout = await client.PostAsync("/Auth/Logout", new FormUrlEncodedContent(new Dictionary<string, string>
        {
            ["__RequestVerificationToken"] = logoutToken,
        }));
        Assert.Equal(HttpStatusCode.Redirect, logout.StatusCode);

        // After logout, the same page redirects to the login page.
        var after = await client.GetAsync("/Auth/ChangePassword");
        Assert.Equal(HttpStatusCode.Redirect, after.StatusCode);
        Assert.Contains("/Auth/Login", after.Headers.Location?.OriginalString);
    }

    private async Task<string> GetAntiforgeryTokenAsync(HttpClient client, string pagePath)
    {
        var response = await client.GetAsync(pagePath);
        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
        var html = await response.Content.ReadAsStringAsync();
        var match = Regex.Match(html, "__RequestVerificationToken[^>]*value=\"([^\"]+)\"");
        Assert.True(match.Success, $"antiforgery token not found in {pagePath}");
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