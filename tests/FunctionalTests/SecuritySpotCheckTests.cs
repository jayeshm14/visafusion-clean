using System.Net;
using System.Net.Http.Json;
using VisaFusion.Api.Contracts;

namespace VisaFusion.FunctionalTests;

/// <summary>
/// Security spot-checks (SPEC-0005 T037, US5; quickstart.md §5, AC-002).
///
///   - No plaintext password material in any response surface: register (201,
///     empty body), login (token/claims only), change-password (204, empty).
///   - The deferred admin user-management and agent password-set routes do NOT
///     exist yet (contracts/secured-write-routes.md §3) — they 404 rather than
///     exposing a half-built write path.
///   - Backdoor-parameter inertness is asserted by BackdoorAndIsolationTests
///     (T027, AC-006); ProductionSecretsGuard fail-fast by
///     ProductionSecretsGuardTests (T037, NFR-004); no password material in
///     log templates is verified by the fixed-string log templates in src/
///     (no password placeholder exists in any Log* call).
/// </summary>
public class SecuritySpotCheckTests : IClassFixture<VisaFusionWebApplicationFactory>
{
    private readonly HttpClient _client;

    public SecuritySpotCheckTests(VisaFusionWebApplicationFactory factory)
    {
        _client = factory.CreateClient();
    }

    [Fact]
    public async Task No_Plaintext_Password_Material_In_Any_Response_Surface()
    {
        const string password = "SpotCheckPass123!";

        var register = await _client.PostAsJsonAsync("/api/v1/public/register",
            new RegisterRequest { UserName = "spotcheck", Email = "spotcheck@example.com", Password = password });
        Assert.Equal(HttpStatusCode.Created, register.StatusCode);
        Assert.Equal(string.Empty, await register.Content.ReadAsStringAsync());

        var login = await _client.PostAsJsonAsync("/api/v1/auth/login",
            new LoginRequest { UserName = "spotcheck", Password = password });
        Assert.Equal(HttpStatusCode.OK, login.StatusCode);
        var loginBody = await login.Content.ReadAsStringAsync();
        Assert.DoesNotContain(password, loginBody);
        Assert.DoesNotContain("Password", loginBody, StringComparison.OrdinalIgnoreCase);

        var token = (await login.Content.ReadFromJsonAsync<LoginResponse>())!.Token;
        using var changeRequest = new HttpRequestMessage(HttpMethod.Post, "/api/v1/auth/change-password")
        {
            Content = JsonContent.Create(new ChangePasswordRequest
            {
                CurrentPassword = password,
                NewPassword = "SpotCheckNewPass123!",
                ConfirmPassword = "SpotCheckNewPass123!",
            }),
        };
        changeRequest.Headers.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);
        var changePassword = await _client.SendAsync(changeRequest);
        Assert.Equal(HttpStatusCode.NoContent, changePassword.StatusCode);
        Assert.Equal(string.Empty, await changePassword.Content.ReadAsStringAsync());
    }

    [Theory]
    [InlineData("/api/v1/agents/1/password")]
    [InlineData("/api/v1/admin/unknown-path")]
    public async Task Deferred_Admin_And_Agent_Password_Routes_Do_Not_Exist(string path)
    {
        // secured-write-routes.md §3: the agent password-set route is still
        // deferred and unknown admin paths are never half-built — they must
        // 404, not half-exist.
        var response = await _client.GetAsync(path);

        Assert.Equal(HttpStatusCode.NotFound, response.StatusCode);
    }
}