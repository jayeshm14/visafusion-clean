using System.IdentityModel.Tokens.Jwt;
using System.Net;
using System.Net.Http;
using System.Net.Http.Json;
using System.Security.Claims;
using System.Text;
using Microsoft.AspNetCore.Identity;
using Microsoft.Extensions.DependencyInjection;
using VisaFusion.Api.Authorization;
using VisaFusion.Api.Contracts;
using VisaFusion.Identity;

namespace VisaFusion.FunctionalTests;

/// <summary>
/// 5-role login functional test (SPEC-0005 T007, US1, AC-001/TS-001, FR-017,
/// contracts/auth-api.md §1).
///
/// Seeds a user per role into the hermetic EF InMemory identity store and
/// signs in via the real `POST /api/v1/auth/login` endpoint. Asserts the
/// token claims contract: role set, `AgentId` for `agt`, `SuperUser` for `su`,
/// plus the bad-credentials (401) and inactive-account (401) rejection paths.
/// The `emp` case is covered here without the day-gate (US2 wires the gate
/// separately per AC-011; the seeded-open-day qualification is documented in
/// spec §20/CHK038).
/// </summary>
public class AuthLoginTests : IClassFixture<VisaFusionWebApplicationFactory>
{
    private readonly VisaFusionWebApplicationFactory _factory;
    private readonly HttpClient _client;

    public AuthLoginTests(VisaFusionWebApplicationFactory factory)
    {
        _factory = factory;
        _client = factory.CreateClient();
    }

    [Fact]
    public async Task Login_SuperUser_Returns_Token_With_Admin_Role_And_SuperUser_Claim()
    {
        SeedUser("su-login", IdentityIntegration.Roles.SuperUser);

        var body = await LoginSuccessAsync("su-login");

        Assert.Equal("su-login", body.UserName);
        Assert.Contains(IdentityIntegration.Roles.SuperUser, body.Roles);
        Assert.Contains(IdentityIntegration.Roles.Admin, body.Roles);
        Assert.Null(body.AgentId);

        var claims = Decode(body.Token).Claims;
        Assert.Contains(claims, c => c.Type == ClaimTypes.Role && c.Value == IdentityIntegration.Roles.SuperUser);
        Assert.Contains(claims, c => c.Type == ClaimTypes.Role && c.Value == IdentityIntegration.Roles.Admin);
        Assert.Contains(claims, c => c.Type == IdentityClaims.SuperUserClaimType && c.Value == "true");
        Assert.DoesNotContain(claims, c => c.Type == IdentityClaims.AgentIdClaimType);
        Assert.Contains(claims, c => c.Type == "sub" && c.Value == "su-login");
    }

    [Fact]
    public async Task Login_Admin_Returns_Token_With_Admin_Role()
    {
        SeedUser("adm-login", IdentityIntegration.Roles.Admin);

        var body = await LoginSuccessAsync("adm-login");

        Assert.Equal(IdentityIntegration.Roles.Admin, Assert.Single(body.Roles));
        Assert.Null(body.AgentId);
        Assert.DoesNotContain(Decode(body.Token).Claims, c => c.Type == IdentityClaims.SuperUserClaimType);
    }

    [Fact]
    public async Task Login_Employee_Returns_Token_With_Employee_Role()
    {
        SeedUser("emp-login", IdentityIntegration.Roles.Employee);

        var body = await LoginSuccessAsync("emp-login");

        Assert.Equal(IdentityIntegration.Roles.Employee, Assert.Single(body.Roles));
    }

    [Fact]
    public async Task Login_Agent_Returns_Token_With_Claim_Bound_AgentId()
    {
        SeedUser("agt-login", IdentityIntegration.Roles.Agent, agentId: 5771);

        var body = await LoginSuccessAsync("agt-login");

        Assert.Equal(IdentityIntegration.Roles.Agent, Assert.Single(body.Roles));
        Assert.Equal(5771, body.AgentId);
        // FR-007: agent identity is claim-bound (surfaced in the token), never
        // re-derived from a URL/query parameter.
        Assert.Contains(Decode(body.Token).Claims,
            c => c.Type == IdentityClaims.AgentIdClaimType && c.Value == "5771");
    }

    [Fact]
    public async Task Login_Guest_Returns_Token_With_Guest_Role()
    {
        SeedUser("guest-login", IdentityIntegration.Roles.Guest);

        var body = await LoginSuccessAsync("guest-login");

        Assert.Equal(IdentityIntegration.Roles.Guest, Assert.Single(body.Roles));
        Assert.Null(body.AgentId);
    }

    [Fact]
    public async Task Login_Bad_Credentials_Returns_401_Problem_Details()
    {
        SeedUser("bad-cred", IdentityIntegration.Roles.Guest);

        var response = await LoginAsync("bad-cred", "WrongPass123!");

        Assert.Equal(HttpStatusCode.Unauthorized, response.StatusCode);
        Assert.Equal("application/problem+json", response.Content.Headers.ContentType?.MediaType);
        var problem = await response.Content.ReadFromJsonAsync<ProblemDetailsResponse>();
        Assert.NotNull(problem);
        Assert.Equal(401, problem!.Status);
    }

    [Fact]
    public async Task Login_Unknown_User_Returns_401()
    {
        var response = await LoginAsync("nobody", "Anything123!");

        Assert.Equal(HttpStatusCode.Unauthorized, response.StatusCode);
    }

    [Fact]
    public async Task Login_Inactive_Account_Returns_401()
    {
        // AC-010/TS-010: a legacy account with active=false is mapped to a
        // lockout (LockoutEnabled + far-future LockoutEnd) and cannot sign in.
        SeedUser("inactive-login", IdentityIntegration.Roles.Guest, inactive: true);

        var response = await LoginAsync("inactive-login", "TestPass123!");

        Assert.Equal(HttpStatusCode.Unauthorized, response.StatusCode);
    }

    [Fact]
    public async Task Login_Missing_Fields_Returns_400()
    {
        var response = await _client.PostAsJsonAsync("/api/v1/auth/login", new { UserName = "", Password = "" });

        Assert.Equal(HttpStatusCode.BadRequest, response.StatusCode);
    }

    [Fact]
    public async Task Login_Malformed_Json_Returns_400_Not_500()
    {
        // A non-JSON body on the anonymous login endpoint must be a 400
        // validation problem-details response, not a 500 (the centralized
        // exception middleware would otherwise surface JsonException as 500).
        using var content = new StringContent("this is not json", Encoding.UTF8, "application/json");
        var response = await _client.PostAsync("/api/v1/auth/login", content);

        Assert.Equal(HttpStatusCode.BadRequest, response.StatusCode);
        Assert.Equal("application/problem+json", response.Content.Headers.ContentType?.MediaType);
    }

    private async Task<LoginResponse> LoginSuccessAsync(string userName)
    {
        var response = await LoginAsync(userName, TestPassword);
        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
        var body = await response.Content.ReadFromJsonAsync<LoginResponse>();
        Assert.NotNull(body);
        Assert.False(string.IsNullOrWhiteSpace(body!.Token));
        return body;
    }

    private Task<HttpResponseMessage> LoginAsync(string userName, string password)
        => _client.PostAsJsonAsync("/api/v1/auth/login",
            new LoginRequest { UserName = userName, Password = password });

    private static JwtSecurityToken Decode(string token)
        => new JwtSecurityTokenHandler().ReadJwtToken(token);

    private void SeedUser(string userName, string role, int? agentId = null, bool inactive = false)
    {
        using var scope = _factory.Services.CreateScope();
        var userManager = scope.ServiceProvider
            .GetRequiredService<UserManager<IdentityIntegration.VisaFusionUser>>();

        var user = new IdentityIntegration.VisaFusionUser
        {
            UserName = userName,
            Email = $"{userName}@test.local",
            AgentId = agentId,
        };

        var createResult = userManager.CreateAsync(user, TestPassword).GetAwaiter().GetResult();
        Assert.True(createResult.Succeeded,
            string.Join("; ", createResult.Errors.Select(e => e.Description)));

        var roleResult = userManager.AddToRoleAsync(user, role).GetAwaiter().GetResult();
        Assert.True(roleResult.Succeeded,
            string.Join("; ", roleResult.Errors.Select(e => e.Description)));

        if (inactive)
        {
            user.LockoutEnabled = true;
            user.LockoutEnd = DateTimeOffset.UtcNow.AddYears(100);
            var updateResult = userManager.UpdateAsync(user).GetAwaiter().GetResult();
            Assert.True(updateResult.Succeeded,
                string.Join("; ", updateResult.Errors.Select(e => e.Description)));
        }
    }

    private const string TestPassword = "TestPass123!";

    private sealed class ProblemDetailsResponse
    {
        public string? Title { get; set; }
        public int Status { get; set; }
    }
}
