using System.Net;
using System.Net.Http;
using System.Net.Http.Json;
using VisaFusion.Api.Contracts;
using VisaFusion.Identity;

namespace VisaFusion.FunctionalTests;

/// <summary>
/// Registration security functional test (SPEC-0005 T026, US4, AC-005/TS-005,
/// FR-012; contracts/auth-api.md §4).
///
/// Asserts the §2.2 escalation fix: a privileged role in the registration
/// payload is NEVER read — the account is created as `guest` only. And the
/// password policy (minimum 8 characters, no forced complexity, spec §17) is
/// enforced on the new account's password.
/// </summary>
public class RegistrationEscalationTests : IClassFixture<VisaFusionWebApplicationFactory>
{
    private readonly HttpClient _client;

    public RegistrationEscalationTests(VisaFusionWebApplicationFactory factory)
    {
        _client = factory.CreateClient();
    }

    [Fact]
    public async Task Register_With_Privileged_Role_In_Payload_Creates_Guest_Only()
    {
        var userName = $"esc-{Guid.NewGuid():N}";

        // The payload carries role=su — the endpoint must ignore it entirely
        // (the role is fixed server-side to `guest`, FR-012/BR-004).
        var register = await _client.PostAsJsonAsync("/api/v1/public/register", new
        {
            username = userName,
            email = $"{userName}@test.local",
            password = "TestPass123!",
            role = IdentityIntegration.Roles.SuperUser,
        });

        Assert.Equal(HttpStatusCode.Created, register.StatusCode);

        // The account authenticates as a plain guest — no escalation, no
        // SuperUser claim, no AgentId.
        var login = await _client.PostAsJsonAsync("/api/v1/auth/login",
            new LoginRequest { UserName = userName, Password = "TestPass123!" });
        Assert.Equal(HttpStatusCode.OK, login.StatusCode);

        var body = await login.Content.ReadFromJsonAsync<LoginResponse>();
        Assert.NotNull(body);
        Assert.Equal(new[] { IdentityIntegration.Roles.Guest }, body!.Roles);
        Assert.Null(body.AgentId);
    }

    [Fact]
    public async Task Register_With_Password_Under_8_Characters_Returns_400()
    {
        var userName = $"short-{Guid.NewGuid():N}";

        // 7 characters — below the shared policy minimum of 8 (spec §17).
        var register = await _client.PostAsJsonAsync("/api/v1/public/register", new
        {
            username = userName,
            email = $"{userName}@test.local",
            password = "Short1!",
        });

        Assert.Equal(HttpStatusCode.BadRequest, register.StatusCode);
        Assert.Equal("application/problem+json", register.Content.Headers.ContentType?.MediaType);
    }
}