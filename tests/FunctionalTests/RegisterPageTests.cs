using System.Net;
using System.Net.Http.Json;
using System.Text.RegularExpressions;
using VisaFusion.Api.Contracts;

namespace VisaFusion.FunctionalTests;

/// <summary>
/// Web /Auth/Register page tests (SPEC-0005 T040, US1; contracts/web-ui.md §1.3).
///
/// The page is a thin form wrapper over the anonymous register API: it must
/// render the form, surface the API's validation/conflict outcomes inline
/// (never echoing password material), and on success confirm registration
/// (mirroring the legacy `regsubdone.asp`) with the account actually usable.
/// </summary>
public class RegisterPageTests : IClassFixture<VisaFusionWebApplicationFactory>
{
    private readonly HttpClient _client;

    public RegisterPageTests(VisaFusionWebApplicationFactory factory)
    {
        _client = factory.CreateClient();
    }

    [Fact]
    public async Task Get_Renders_The_Registration_Form()
    {
        var response = await _client.GetAsync("/Auth/Register");

        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
        var html = await response.Content.ReadAsStringAsync();
        Assert.Contains("Register", html);
        Assert.Contains("name=\"UserName\"", html);
        Assert.Contains("name=\"Email\"", html);
        Assert.Contains("name=\"Password\"", html);
        Assert.Contains("name=\"ConfirmPassword\"", html);
    }

    [Fact]
    public async Task Valid_Registration_Confirms_And_The_Account_Can_Log_In()
    {
        var token = await GetAntiforgeryTokenAsync();
        var userName = $"pageuser{Guid.NewGuid():N}";

        var post = await PostFormAsync(token, userName, "page@example.com", "PagePass123!", "PagePass123!");
        Assert.Equal(HttpStatusCode.OK, post.StatusCode);
        var html = await post.Content.ReadAsStringAsync();
        Assert.Contains("Registration successful", html);
        Assert.Contains("/Auth/Login", html);

        // The account created through the page is real: it signs in via the API.
        var login = await _client.PostAsJsonAsync("/api/v1/auth/login",
            new LoginRequest { UserName = userName, Password = "PagePass123!" });
        Assert.Equal(HttpStatusCode.OK, login.StatusCode);
    }

    [Fact]
    public async Task Under_8_Character_Password_Shows_The_Api_Validation_Error_Inline()
    {
        var token = await GetAntiforgeryTokenAsync();

        var post = await PostFormAsync(token, $"short{Guid.NewGuid():N}", "short@example.com", "short", "short");
        Assert.Equal(HttpStatusCode.OK, post.StatusCode);
        var html = await post.Content.ReadAsStringAsync();
        // The API's Identity validation detail is rendered inline (the page
        // never echoes the submitted password value).
        Assert.Contains("at least 8 characters", html);
    }

    [Fact]
    public async Task Mismatched_Confirm_Password_Is_Rejected_By_The_Page()
    {
        var token = await GetAntiforgeryTokenAsync();

        var post = await PostFormAsync(token, $"mismatch{Guid.NewGuid():N}", "mismatch@example.com", "PagePass123!", "Different123!");
        Assert.Equal(HttpStatusCode.OK, post.StatusCode);
        var html = await post.Content.ReadAsStringAsync();
        Assert.Contains("do not match", html);
    }

    [Fact]
    public async Task Duplicate_Username_Shows_The_Conflict_Error_Inline()
    {
        var token = await GetAntiforgeryTokenAsync();
        const string userName = "dupuser";

        // First registration succeeds.
        var first = await PostFormAsync(token, userName, "dup1@example.com", "PagePass123!", "PagePass123!");
        Assert.Contains("Registration successful", await first.Content.ReadAsStringAsync());

        // Second registration with the same username shows the API's 409 detail.
        var token2 = await GetAntiforgeryTokenAsync();
        var second = await PostFormAsync(token2, userName, "dup2@example.com", "PagePass123!", "PagePass123!");
        Assert.Equal(HttpStatusCode.OK, second.StatusCode);
        var html = await second.Content.ReadAsStringAsync();
        Assert.Contains("already registered", html);
    }

    private async Task<string> GetAntiforgeryTokenAsync()
    {
        // The factory client routes to the TestServer and keeps its cookie jar,
        // so the antiforgery cookie set by this GET is sent with the POST.
        var response = await _client.GetAsync("/Auth/Register");
        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
        var html = await response.Content.ReadAsStringAsync();
        var match = Regex.Match(html, "__RequestVerificationToken[^>]*value=\"([^\"]+)\"");
        Assert.True(match.Success, "antiforgery token not found in the register page");
        return match.Groups[1].Value;
    }

    private async Task<HttpResponseMessage> PostFormAsync(
        string token, string userName, string email,
        string password, string confirmPassword)
    {
        return await _client.PostAsync("/Auth/Register", new FormUrlEncodedContent(new Dictionary<string, string>
        {
            ["__RequestVerificationToken"] = token,
            ["UserName"] = userName,
            ["Email"] = email,
            ["Password"] = password,
            ["ConfirmPassword"] = confirmPassword,
        }));
    }
}