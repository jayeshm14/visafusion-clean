using System.IdentityModel.Tokens.Jwt;
using System.Net;
using System.Net.Http;
using System.Net.Http.Json;
using System.Security.Claims;
using System.Text;
using Microsoft.AspNetCore.Identity;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.IdentityModel.Tokens;
using VisaFusion.Api.Authorization;
using VisaFusion.Api.Contracts;
using VisaFusion.Identity;

namespace VisaFusion.FunctionalTests;

/// <summary>
/// Admin user-management API tests (SPEC-0007 T020, US2, FR-005..007/FR-023,
/// BR-004; AC-003/AC-018; contracts/admin-api.md §4/§5/§6).
///
/// The routes are gated by the <c>UserManagement</c> policy (adm/emp — DP-001;
/// su passes via the inherited adm claim) and the claim-based
/// <c>SuperUserOnly</c> policy. The shared Core service is stubbed hermetically
/// (InMemoryUserManagementServiceStub) — the service behavior itself is covered
/// by the unit and integration tests. The audit actor and the actor's roles are
/// resolved server-side from the JWT principal (GR-0004), so the tokens minted
/// here carry the seeded username in the `name` claim.
/// </summary>
public class AdminUserManagementTests : IClassFixture<VisaFusionWebApplicationFactory>
{
    private readonly HttpClient _client;
    private readonly VisaFusionWebApplicationFactory _factory;

    public AdminUserManagementTests(VisaFusionWebApplicationFactory factory)
    {
        _factory = factory;
        _client = factory.CreateClient();
    }

    // ---- §4 create-user auth matrix (UserManagement = adm/emp) ----

    [Fact]
    public async Task Create_User_Requires_Authentication()
    {
        var response = await PostAsync("/api/v1/admin/users",
            new CreateUserRequest { Username = "u1", Password = "Pass123!", Role = "emp" }, token: null);

        Assert.Equal(HttpStatusCode.Unauthorized, response.StatusCode);
    }

    [Theory]
    [InlineData("agt")]
    [InlineData("guest")]
    public async Task Create_User_Rejects_Non_UserManagement_Roles(string role)
    {
        var token = MintTokenAsync(role);

        var response = await PostAsync("/api/v1/admin/users",
            new CreateUserRequest { Username = "u1", Password = "Pass123!", Role = "emp" }, token);

        Assert.Equal(HttpStatusCode.Forbidden, response.StatusCode);
    }

    [Theory]
    [InlineData("emp")]
    [InlineData("adm")]
    [InlineData("su")]
    public async Task Create_User_Allows_UserManagement_Roles(string role)
    {
        var token = MintTokenAsync(role);

        var response = await PostAsync("/api/v1/admin/users",
            new CreateUserRequest { Username = $"u-{role}-{Guid.NewGuid():N}", Password = "Pass123!", Role = "emp" }, token);

        Assert.Equal(HttpStatusCode.Created, response.StatusCode);
        var body = await response.Content.ReadFromJsonAsync<UserResponse>();
        Assert.NotNull(body);
        Assert.Contains("emp", body!.Roles);
        Assert.True(body.Active);
    }

    // ---- §4 create-user business rules ----

    [Fact]
    public async Task Create_User_Rejects_Su_Role()
    {
        var token = MintTokenAsync("adm");

        var response = await PostAsync("/api/v1/admin/users",
            new CreateUserRequest { Username = "u-su", Password = "Pass123!", Role = "su" }, token);

        Assert.Equal(HttpStatusCode.BadRequest, response.StatusCode);
    }

    [Fact]
    public async Task Create_Agt_Without_AgentId_Is_Validation_Failure()
    {
        var token = MintTokenAsync("adm");

        var response = await PostAsync("/api/v1/admin/users",
            new CreateUserRequest { Username = "u-agt", Password = "Pass123!", Role = "agt" }, token);

        Assert.Equal(HttpStatusCode.BadRequest, response.StatusCode);
    }

    [Fact]
    public async Task Create_Agt_With_AgentId_Succeeds()
    {
        var token = MintTokenAsync("adm");

        var response = await PostAsync("/api/v1/admin/users",
            new CreateUserRequest { Username = "u-agt", Password = "Pass123!", Role = "agt", AgentId = 1 }, token);

        Assert.Equal(HttpStatusCode.Created, response.StatusCode);
        var body = await response.Content.ReadFromJsonAsync<UserResponse>();
        Assert.Contains("agt", body!.Roles);
    }

    [Fact]
    public async Task Create_User_Duplicate_Username_Is_Conflict()
    {
        var token = MintTokenAsync("adm");
        var request = new CreateUserRequest { Username = "u-dup", Password = "Pass123!", Role = "emp" };

        var first = await PostAsync("/api/v1/admin/users", request, token);
        Assert.Equal(HttpStatusCode.Created, first.StatusCode);

        var second = await PostAsync("/api/v1/admin/users", request, token);
        Assert.Equal(HttpStatusCode.Conflict, second.StatusCode);
    }

    [Fact]
    public async Task Create_User_Missing_Username_Is_Validation_Failure()
    {
        var token = MintTokenAsync("adm");

        var response = await PostAsync("/api/v1/admin/users",
            new CreateUserRequest { Username = "", Password = "Pass123!", Role = "emp" }, token);

        Assert.Equal(HttpStatusCode.BadRequest, response.StatusCode);
    }

    // ---- §5 super-user provisioning (SuperUserOnly = claim-based su) ----

    [Fact]
    public async Task Provision_SuperUser_Requires_Authentication()
    {
        var response = await PostAsync("/api/v1/admin/superusers",
            new ProvisionSuperUserRequest { Username = "target" }, token: null);

        Assert.Equal(HttpStatusCode.Unauthorized, response.StatusCode);
    }

    [Theory]
    [InlineData("adm")]
    [InlineData("emp")]
    [InlineData("agt")]
    public async Task Provision_SuperUser_Rejects_Non_Su_Roles(string role)
    {
        var token = MintTokenAsync(role);

        var response = await PostAsync("/api/v1/admin/superusers",
            new ProvisionSuperUserRequest { Username = "target" }, token);

        Assert.Equal(HttpStatusCode.Forbidden, response.StatusCode);
    }

    [Fact]
    public async Task Provision_SuperUser_Unknown_Username_Is_NotFound()
    {
        var token = MintTokenAsync("su");

        var response = await PostAsync("/api/v1/admin/superusers",
            new ProvisionSuperUserRequest { Username = "no-such-user" }, token);

        Assert.Equal(HttpStatusCode.NotFound, response.StatusCode);
    }

    [Fact]
    public async Task Provision_SuperUser_Grants_Su_Role()
    {
        var adminToken = MintTokenAsync("adm");
        var suToken = MintTokenAsync("su");
        var targetName = $"target-{Guid.NewGuid():N}";

        var created = await PostAsync("/api/v1/admin/users",
            new CreateUserRequest { Username = targetName, Password = "Pass123!", Role = "adm" }, adminToken);
        Assert.Equal(HttpStatusCode.Created, created.StatusCode);

        var provisioned = await PostAsync("/api/v1/admin/superusers",
            new ProvisionSuperUserRequest { Username = targetName }, suToken);

        Assert.Equal(HttpStatusCode.OK, provisioned.StatusCode);
        var body = await provisioned.Content.ReadFromJsonAsync<UserResponse>();
        Assert.Contains("su", body!.Roles);
        Assert.True(body.Active);
    }

    // ---- §6 deactivate (UserManagement = adm/emp; su-target rule FR-007) ----

    [Fact]
    public async Task Deactivate_Requires_Authentication()
    {
        var response = await PostAsync(
            $"/api/v1/admin/users/{Guid.NewGuid():N}/deactivate", token: null);

        Assert.Equal(HttpStatusCode.Unauthorized, response.StatusCode);
    }

    [Theory]
    [InlineData("agt")]
    [InlineData("guest")]
    public async Task Deactivate_Rejects_Non_UserManagement_Roles(string role)
    {
        var token = MintTokenAsync(role);

        var response = await PostAsync(
            $"/api/v1/admin/users/{Guid.NewGuid():N}/deactivate", token);

        Assert.Equal(HttpStatusCode.Forbidden, response.StatusCode);
    }

    [Fact]
    public async Task Deactivate_Unknown_User_Is_NotFound()
    {
        var token = MintTokenAsync("adm");

        var response = await PostAsync(
            $"/api/v1/admin/users/{Guid.NewGuid():N}/deactivate", token);

        Assert.Equal(HttpStatusCode.NotFound, response.StatusCode);
    }

    [Fact]
    public async Task Deactivate_User_By_UserManagement_Role_Succeeds()
    {
        var adminToken = MintTokenAsync("adm");
        var empToken = MintTokenAsync("emp");
        var targetName = $"target-{Guid.NewGuid():N}";

        var created = await PostAsync("/api/v1/admin/users",
            new CreateUserRequest { Username = targetName, Password = "Pass123!", Role = "emp" }, adminToken);
        var createdBody = await created.Content.ReadFromJsonAsync<UserResponse>();

        var deactivated = await PostAsync(
            $"/api/v1/admin/users/{createdBody!.Id}/deactivate", empToken);

        Assert.Equal(HttpStatusCode.OK, deactivated.StatusCode);
        var body = await deactivated.Content.ReadFromJsonAsync<UserResponse>();
        Assert.False(body!.Active);
    }

    [Fact]
    public async Task Deactivate_Su_Target_Requires_Su_Actor()
    {
        var adminToken = MintTokenAsync("adm");
        var suToken = MintTokenAsync("su");
        var targetName = $"target-{Guid.NewGuid():N}";

        var created = await PostAsync("/api/v1/admin/users",
            new CreateUserRequest { Username = targetName, Password = "Pass123!", Role = "adm" }, adminToken);
        var createdBody = await created.Content.ReadFromJsonAsync<UserResponse>();

        var provisioned = await PostAsync("/api/v1/admin/superusers",
            new ProvisionSuperUserRequest { Username = targetName }, suToken);
        Assert.Equal(HttpStatusCode.OK, provisioned.StatusCode);

        // FR-007: a non-su actor cannot deactivate an su account.
        var asAdmin = await PostAsync(
            $"/api/v1/admin/users/{createdBody!.Id}/deactivate", adminToken);
        Assert.Equal(HttpStatusCode.BadRequest, asAdmin.StatusCode);

        // The su actor can.
        var asSu = await PostAsync(
            $"/api/v1/admin/users/{createdBody.Id}/deactivate", suToken);
        Assert.Equal(HttpStatusCode.OK, asSu.StatusCode);
        var body = await asSu.Content.ReadFromJsonAsync<UserResponse>();
        Assert.False(body!.Active);
    }

    // ---- helpers (AgentRbacTests convention) ----

    /// <summary>
    /// Seeds a user in the hermetic InMemory identity store and mints a JWT
    /// locally. The `name` claim carries the seeded username so the handlers'
    /// server-side actor resolution (JWT name → AspNetUsers.Id) resolves —
    /// never a caller-supplied actor string (GR-0004). For `su` the token
    /// mirrors IdentityClaims.FromUser: the effective adm role (FR-008) and the
    /// SuperUser claim the SuperUserOnly policy requires.
    /// </summary>
    private string MintTokenAsync(string role)
    {
        var userName = $"admin-user-{role}-{Guid.NewGuid():N}";
        SeedUser(userName, role);
        return CreateTestToken(userName, role);
    }

    private string CreateTestToken(string userName, string role)
    {
        var jwtKey = _factory.Services.GetService(typeof(IConfiguration)) is IConfiguration config
            ? config["Jwt:Key"]
            : null;
        jwtKey ??= "CHANGE_ME_development_only_do_not_use_in_production_0123456789";

        var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(jwtKey));
        var credentials = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);
        var claims = new List<Claim>
        {
            new(ClaimTypes.Name, userName),
            new(ClaimTypes.Role, role),
        };
        if (role == "su")
        {
            claims.Add(new Claim(ClaimTypes.Role, "adm"));
            claims.Add(new Claim(IdentityClaims.SuperUserClaimType, "true"));
        }

        var token = new JwtSecurityToken(
            issuer: "VisaFusion",
            audience: "VisaFusion.Api",
            claims: claims,
            expires: DateTime.UtcNow.AddHours(1),
            signingCredentials: credentials);

        return new JwtSecurityTokenHandler().WriteToken(token);
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
        var createResult = userManager.CreateAsync(user, "TestPass123!").GetAwaiter().GetResult();
        Assert.True(createResult.Succeeded,
            string.Join("; ", createResult.Errors.Select(e => e.Description)));
        var roleResult = userManager.AddToRoleAsync(user, role).GetAwaiter().GetResult();
        Assert.True(roleResult.Succeeded,
            string.Join("; ", roleResult.Errors.Select(e => e.Description)));
    }

    private static HttpContent Json<T>(T body)
        => JsonContent.Create(body, body?.GetType() ?? typeof(object));

    private static HttpRequestMessage Request(HttpMethod method, string url, string? token, HttpContent? body)
    {
        var request = new HttpRequestMessage(method, url) { Content = body };
        if (token is not null)
        {
            request.Headers.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);
        }

        return request;
    }

    private async Task<HttpResponseMessage> PostAsync(string url, object body, string? token)
        => await _client.SendAsync(Request(HttpMethod.Post, url, token, Json(body)));

    private async Task<HttpResponseMessage> PostAsync(string url, string? token)
        => await _client.SendAsync(Request(HttpMethod.Post, url, token, body: null));
}