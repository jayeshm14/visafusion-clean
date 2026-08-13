using System.Net;
using System.Net.Http.Json;
using System.Text.RegularExpressions;
using Microsoft.AspNetCore.Mvc.Testing;
using Microsoft.AspNetCore.Identity;
using Microsoft.Extensions.DependencyInjection;
using VisaFusion.Api.Contracts;
using VisaFusion.Identity;

namespace VisaFusion.FunctionalTests;

/// <summary>
/// Web change-password page tests (SPEC-0005 rigorous-testing pass, web-ui.md
/// §1.4, FR-019, AC-012).
///
/// The self-service page (T022) was delivered but only the API surface was
/// exercised (ChangePasswordTests). These tests prove the cookie-backed page:
///   - unauthenticated GET redirects to /Auth/Login ([Authorize]),
///   - a signed-in user changes their own password — success message inline
///     (mirrors legacy changepassword.asp?flag=1) and the NEW password
///     authenticates (stored hashed, no lowercasing),
///   - wrong current password → inline flag=3 message,
///   - new ≠ confirm → inline flag=2 message,
///   - new password under 8 characters → inline policy-violation message.
/// </summary>
public class ChangePasswordPageTests : IClassFixture<VisaFusionWebApplicationFactory>
{
    private readonly VisaFusionWebApplicationFactory _factory;
    private readonly HttpClient _client;

    public ChangePasswordPageTests(VisaFusionWebApplicationFactory factory)
    {
        _factory = factory;
        _client = factory.CreateClient();
    }

    [Fact]
    public async Task Unauthenticated_Get_Redirects_To_Login()
    {
        var client = _factory.CreateClient(new WebApplicationFactoryClientOptions
        {
            AllowAutoRedirect = false,
        });

        var response = await client.GetAsync("/Auth/ChangePassword");

        Assert.Equal(HttpStatusCode.Redirect, response.StatusCode);
        // The cookie scheme redirects to the LoginPath with the ReturnUrl
        // preserved (the page is [Authorize]).
        var location = response.Headers.Location;
        Assert.NotNull(location);
        Assert.Equal("/Auth/Login", location!.AbsolutePath);
        Assert.Contains("ReturnUrl=", location.Query);
    }

    [Fact]
    public async Task Signed_In_User_Changes_Password_And_The_New_Password_Authenticates()
    {
        SeedUser("web-cp-ok", IdentityIntegration.Roles.Guest);
        await SignInAsync("web-cp-ok");

        var token = await GetAntiforgeryTokenAsync();
        var response = await _client.PostAsync("/Auth/ChangePassword", new FormUrlEncodedContent(new Dictionary<string, string>
        {
            ["__RequestVerificationToken"] = token,
            ["CurrentPassword"] = TestPassword,
            ["NewPassword"] = NewPassword,
            ["ConfirmPassword"] = NewPassword,
        }));

        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
        var html = await response.Content.ReadAsStringAsync();
        Assert.Contains("Password changed successfully.", html);

        // The new password authenticates via the API (hash replaced, no legacy
        // lowercasing — "NewPass123!" would not match a stored "newpass123!").
        var login = await _client.PostAsJsonAsync("/api/v1/auth/login",
            new LoginRequest { UserName = "web-cp-ok", Password = NewPassword });
        Assert.Equal(HttpStatusCode.OK, login.StatusCode);
    }

    [Fact]
    public async Task Wrong_Current_Password_Shows_The_Flag_3_Message()
    {
        SeedUser("web-cp-wrong", IdentityIntegration.Roles.Guest);
        await SignInAsync("web-cp-wrong");

        var token = await GetAntiforgeryTokenAsync();
        var response = await _client.PostAsync("/Auth/ChangePassword", new FormUrlEncodedContent(new Dictionary<string, string>
        {
            ["__RequestVerificationToken"] = token,
            ["CurrentPassword"] = "WrongCurrent1!",
            ["NewPassword"] = NewPassword,
            ["ConfirmPassword"] = NewPassword,
        }));

        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
        var html = await response.Content.ReadAsStringAsync();
        Assert.Contains("Please check the current password.", html);
    }

    [Fact]
    public async Task New_Does_Not_Match_Confirm_Shows_The_Flag_2_Message()
    {
        SeedUser("web-cp-mismatch", IdentityIntegration.Roles.Guest);
        await SignInAsync("web-cp-mismatch");

        var token = await GetAntiforgeryTokenAsync();
        var response = await _client.PostAsync("/Auth/ChangePassword", new FormUrlEncodedContent(new Dictionary<string, string>
        {
            ["__RequestVerificationToken"] = token,
            ["CurrentPassword"] = TestPassword,
            ["NewPassword"] = NewPassword,
            ["ConfirmPassword"] = "Different123!",
        }));

        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
        var html = await response.Content.ReadAsStringAsync();
        Assert.Contains("Please enter the same values for new and confirm password.", html);
    }

    [Fact]
    public async Task New_Password_Under_8_Characters_Shows_The_Policy_Violation_Inline()
    {
        SeedUser("web-cp-short", IdentityIntegration.Roles.Guest);
        await SignInAsync("web-cp-short");

        var token = await GetAntiforgeryTokenAsync();
        var response = await _client.PostAsync("/Auth/ChangePassword", new FormUrlEncodedContent(new Dictionary<string, string>
        {
            ["__RequestVerificationToken"] = token,
            ["CurrentPassword"] = TestPassword,
            ["NewPassword"] = "Short1!",
            ["ConfirmPassword"] = "Short1!",
        }));

        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
        var html = await response.Content.ReadAsStringAsync();
        // The shared Identity validator's description (spec §17/CHK044) is
        // rendered inline — the same rule the API surface enforces.
        Assert.Contains("at least 8 characters", html);
    }

    /// <summary>Signs in via the Web login page so the shared client holds the cookie.</summary>
    private async Task SignInAsync(string userName)
    {
        var token = await GetAntiforgeryTokenAsync();
        var response = await _client.PostAsync("/Auth/Login", new FormUrlEncodedContent(new Dictionary<string, string>
        {
            ["__RequestVerificationToken"] = token,
            ["UserName"] = userName,
            ["Password"] = TestPassword,
        }));
        Assert.Equal(HttpStatusCode.OK, response.StatusCode); // followed the 302 to /
    }

    private async Task<string> GetAntiforgeryTokenAsync()
    {
        var response = await _client.GetAsync("/Auth/ChangePassword");
        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
        var html = await response.Content.ReadAsStringAsync();
        var match = Regex.Match(html, "__RequestVerificationToken[^>]*value=\"([^\"]+)\"");
        Assert.True(match.Success, "antiforgery token not found in the change-password page");
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
    private const string NewPassword = "NewPass123!";
}