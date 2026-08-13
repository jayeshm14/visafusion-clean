using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Net.Http.Json;
using Microsoft.AspNetCore.Identity;
using Microsoft.Extensions.DependencyInjection;
using VisaFusion.Api.Contracts;
using VisaFusion.Identity;

namespace VisaFusion.FunctionalTests;

/// <summary>
/// Self-service change-password functional test (SPEC-0005 T021, US3, AC-012/TS-014,
/// FR-019; contracts/auth-api.md §3).
///
/// Asserts the four outcomes over the real `POST /api/v1/auth/change-password`
/// endpoint against the hermetic EF InMemory identity store:
///   - success → 204 and the NEW password authenticates (stored hashed via
///     UserManager.ChangePasswordAsync — no legacy lowercasing, no plaintext),
///   - wrong current password → 400 (mirrors legacy changepassword.asp?flag=3),
///   - new ≠ confirm → 400 (mirrors legacy changepassword.asp?flag=2),
///   - new password under 8 characters → 400 (policy violation, spec §17),
///   - unauthenticated → 401.
/// </summary>
public class ChangePasswordTests : IClassFixture<VisaFusionWebApplicationFactory>
{
    private readonly VisaFusionWebApplicationFactory _factory;
    private readonly HttpClient _client;

    public ChangePasswordTests(VisaFusionWebApplicationFactory factory)
    {
        _factory = factory;
        _client = factory.CreateClient();
    }

    [Fact]
    public async Task ChangePassword_Success_Returns_204_And_New_Password_Authenticates()
    {
        SeedUser("cp-success", IdentityIntegration.Roles.Guest);
        var token = await LoginTokenAsync("cp-success", TestPassword);

        var response = await ChangePasswordAsync(token, TestPassword, NewPassword, NewPassword);

        Assert.Equal(HttpStatusCode.NoContent, response.StatusCode);

        // The new password must authenticate (hash replaced, no lowercasing):
        // if the legacy lcase() behavior were reproduced, "NewPass123!" would
        // not match the stored "newpass123!" hash.
        var newLogin = await LoginAsync("cp-success", NewPassword);
        Assert.Equal(HttpStatusCode.OK, newLogin.StatusCode);

        // The old password no longer authenticates.
        var oldLogin = await LoginAsync("cp-success", TestPassword);
        Assert.Equal(HttpStatusCode.Unauthorized, oldLogin.StatusCode);
    }

    [Fact]
    public async Task ChangePassword_Wrong_Current_Password_Returns_400()
    {
        SeedUser("cp-wrong-current", IdentityIntegration.Roles.Guest);
        var token = await LoginTokenAsync("cp-wrong-current", TestPassword);

        var response = await ChangePasswordAsync(token, "WrongCurrent1!", NewPassword, NewPassword);

        Assert.Equal(HttpStatusCode.BadRequest, response.StatusCode);
        Assert.Equal("application/problem+json", response.Content.Headers.ContentType?.MediaType);
    }

    [Fact]
    public async Task ChangePassword_New_Does_Not_Match_Confirm_Returns_400()
    {
        SeedUser("cp-mismatch", IdentityIntegration.Roles.Guest);
        var token = await LoginTokenAsync("cp-mismatch", TestPassword);

        var response = await ChangePasswordAsync(token, TestPassword, NewPassword, "Different123!");

        Assert.Equal(HttpStatusCode.BadRequest, response.StatusCode);
    }

    [Fact]
    public async Task ChangePassword_New_Password_Under_8_Characters_Returns_400()
    {
        SeedUser("cp-too-short", IdentityIntegration.Roles.Guest);
        var token = await LoginTokenAsync("cp-too-short", TestPassword);

        // 7 characters — below the shared policy minimum of 8 (spec §17).
        var response = await ChangePasswordAsync(token, TestPassword, "Short1!", "Short1!");

        Assert.Equal(HttpStatusCode.BadRequest, response.StatusCode);
    }

    [Fact]
    public async Task ChangePassword_Unauthenticated_Returns_401()
    {
        var response = await ChangePasswordAsync(token: null, TestPassword, NewPassword, NewPassword);

        Assert.Equal(HttpStatusCode.Unauthorized, response.StatusCode);
    }

    private async Task<string> LoginTokenAsync(string userName, string password)
    {
        var response = await LoginAsync(userName, password);
        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
        var body = await response.Content.ReadFromJsonAsync<LoginResponse>();
        Assert.NotNull(body);
        Assert.False(string.IsNullOrWhiteSpace(body!.Token));
        return body.Token;
    }

    private Task<HttpResponseMessage> LoginAsync(string userName, string password)
        => _client.PostAsJsonAsync("/api/v1/auth/login",
            new LoginRequest { UserName = userName, Password = password });

    private async Task<HttpResponseMessage> ChangePasswordAsync(
        string? token, string currentPassword, string newPassword, string confirmPassword)
    {
        var request = new HttpRequestMessage(HttpMethod.Post, "/api/v1/auth/change-password")
        {
            Content = JsonContent.Create(new ChangePasswordRequest
            {
                CurrentPassword = currentPassword,
                NewPassword = newPassword,
                ConfirmPassword = confirmPassword,
            }),
        };
        if (token is not null)
        {
            request.Headers.Authorization = new AuthenticationHeaderValue("Bearer", token);
        }

        return await _client.SendAsync(request);
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