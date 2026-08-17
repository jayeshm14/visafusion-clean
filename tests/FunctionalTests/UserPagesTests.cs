using System.IdentityModel.Tokens.Jwt;
using System.Net;
using System.Net.Http;
using System.Net.Http.Json;
using System.Security.Claims;
using System.Text;
using System.Text.RegularExpressions;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc.Testing;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.IdentityModel.Tokens;
using VisaFusion.Api.Authorization;
using VisaFusion.Api.Contracts;
using VisaFusion.Identity;

namespace VisaFusion.FunctionalTests;

/// <summary>
/// Admin user-management pages functional test (SPEC-0007 T021, US2, FR-006/
/// FR-007/FR-023, BR-004, AC-003/AC-018; contracts/ui-contract.md §5,
/// contracts/admin-api.md §4/§6).
///
/// Proves the cookie-backed Razor Pages admin surfaces for user management:
///   - anonymous → redirect to /Auth/Login ([Authorize]),
///   - authenticated non-privileged (guest) → redirect to /Auth/AccessDenied
///     (UserManagement policy = adm/emp — DP-001),
///   - emp CAN access the list (DP-001 correction: emp is in the policy),
///   - adm list renders (empty state explicit — CHK027; populated rows),
///   - create page form + field-level validation (username/password/role
///     required, role whitelist adm/emp/agt/guest — BR-004, agentId required
///     when role=agt — CHK026),
///   - the full create → list → deactivate flow (AC-018), with inline outcome
///     messages (spec §18),
///   - deactivating an su target as a non-su actor shows the FR-007 inline
///     error (the service re-check surfaces on the page exactly as on the API).
///
/// Uses the hermetic <see cref="VisaFusionWebApplicationFactory"/> with the
/// in-memory <see cref="IUserManagementService"/> stub. Users are seeded
/// through the factory's UserManager (the AgentPagesTests convention).
/// </summary>
public class UserPagesTests : IClassFixture<VisaFusionWebApplicationFactory>
{
    private readonly VisaFusionWebApplicationFactory _factory;
    private readonly HttpClient _client;

    public UserPagesTests(VisaFusionWebApplicationFactory factory)
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

        var response = await client.GetAsync("/Admin/Users/List");

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

        var response = await client.GetAsync("/Admin/Users/List");

        Assert.Equal(HttpStatusCode.Redirect, response.StatusCode);
        // Cookie auth's AccessDeniedPath (/Auth/AccessDenied) — the page-level
        // mirror of the API's 403 (AC-003).
        Assert.Equal("/Auth/AccessDenied", response.Headers.Location?.AbsolutePath);
    }

    [Fact]
    public async Task Employee_Can_Access_The_List()
    {
        // DP-001 correction: UserManagement = adm/emp (not adm/su).
        SeedUser("pages-emp", IdentityIntegration.Roles.Employee);
        await SignInAsync("pages-emp");

        var response = await _client.GetAsync("/Admin/Users/List");

        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
        var html = await response.Content.ReadAsStringAsync();
        Assert.Contains("Users", html);
    }

    [Fact]
    public async Task Admin_Sees_The_Seeded_User_On_The_List()
    {
        // The list reads the Identity store, so the signed-in user always
        // appears — the populated-row path (the empty state is unreachable
        // hermetically because the actor itself is a user row).
        var userName = $"pages-seeded-{Guid.NewGuid():N}";
        SeedUser(userName, IdentityIntegration.Roles.Admin);
        await SignInAsync(userName);

        var response = await _client.GetAsync("/Admin/Users/List");

        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
        var html = await response.Content.ReadAsStringAsync();
        Assert.Contains(userName, html);
        Assert.Contains("Active", html); // the list badge
    }

    [Fact]
    public async Task Admin_Can_Create_A_User_Through_The_Page()
    {
        var userName = $"pages-adm-{Guid.NewGuid():N}";
        SeedUser(userName, IdentityIntegration.Roles.Admin);
        await SignInAsync(userName);

        var token = await GetAntiforgeryTokenAsync("/Admin/Users/Create");
        var newLogin = $"emp-page-{Guid.NewGuid():N}";
        var response = await _client.PostAsync("/Admin/Users/Create", new FormUrlEncodedContent(new Dictionary<string, string>
        {
            ["__RequestVerificationToken"] = token,
            ["Username"] = newLogin,
            ["Password"] = "PagePass123!",
            ["Role"] = IdentityIntegration.Roles.Employee,
        }));

        // Success redirects to the list page (followed by the default client).
        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
        var html = await response.Content.ReadAsStringAsync();
        Assert.Contains(newLogin, html);
        Assert.Contains("Active", html); // the list badge
    }

    [Fact]
    public async Task Create_Without_Username_Shows_The_Field_Error()
    {
        var userName = $"pages-adm-{Guid.NewGuid():N}";
        SeedUser(userName, IdentityIntegration.Roles.Admin);
        await SignInAsync(userName);

        var token = await GetAntiforgeryTokenAsync("/Admin/Users/Create");
        var response = await _client.PostAsync("/Admin/Users/Create", new FormUrlEncodedContent(new Dictionary<string, string>
        {
            ["__RequestVerificationToken"] = token,
            ["Password"] = "PagePass123!",
            ["Role"] = IdentityIntegration.Roles.Employee,
        }));

        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
        var html = await response.Content.ReadAsStringAsync();
        Assert.Contains("Login username is required.", html);
    }

    [Fact]
    public async Task Create_With_Su_Role_Shows_The_Whitelist_Error()
    {
        // BR-004: su is rejected on the create surface (only reachable via the
        // su-only provisioning path).
        var userName = $"pages-adm-{Guid.NewGuid():N}";
        SeedUser(userName, IdentityIntegration.Roles.Admin);
        await SignInAsync(userName);

        var token = await GetAntiforgeryTokenAsync("/Admin/Users/Create");
        var response = await _client.PostAsync("/Admin/Users/Create", new FormUrlEncodedContent(new Dictionary<string, string>
        {
            ["__RequestVerificationToken"] = token,
            ["Username"] = $"emp-page-{Guid.NewGuid():N}",
            ["Password"] = "PagePass123!",
            ["Role"] = IdentityIntegration.Roles.SuperUser,
        }));

        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
        var html = await response.Content.ReadAsStringAsync();
        Assert.Contains("Role must be one of: adm, emp, agt, guest.", html);
    }

    [Fact]
    public async Task Create_Agent_Role_Without_AgentId_Shows_The_Field_Error()
    {
        // CHK026: role=agt requires the agentId claim link.
        var userName = $"pages-adm-{Guid.NewGuid():N}";
        SeedUser(userName, IdentityIntegration.Roles.Admin);
        await SignInAsync(userName);

        var token = await GetAntiforgeryTokenAsync("/Admin/Users/Create");
        var response = await _client.PostAsync("/Admin/Users/Create", new FormUrlEncodedContent(new Dictionary<string, string>
        {
            ["__RequestVerificationToken"] = token,
            ["Username"] = $"agt-page-{Guid.NewGuid():N}",
            ["Password"] = "PagePass123!",
            ["Role"] = IdentityIntegration.Roles.Agent,
        }));

        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
        var html = await response.Content.ReadAsStringAsync();
        Assert.Contains("Agent ID is required when the role is agt.", html);
    }

    [Fact]
    public async Task Admin_Can_Deactivate_A_User_From_The_List_Page()
    {
        // The target is created through the API surface so the hermetic stub's
        // user store holds it (the AgentPagesTests seeding convention).
        var target = $"target-page-{Guid.NewGuid():N}";
        var targetId = await CreateUserViaApiAsync(target, IdentityIntegration.Roles.Employee);
        var userName = $"pages-adm-{Guid.NewGuid():N}";
        SeedUser(userName, IdentityIntegration.Roles.Admin);
        await SignInAsync(userName);

        // List shows the target with the Deactivate action (FR-023).
        var list = await _client.GetAsync("/Admin/Users/List");
        Assert.Equal(HttpStatusCode.OK, list.StatusCode);
        var listHtml = await list.Content.ReadAsStringAsync();
        Assert.Contains(target, listHtml);
        Assert.Contains("Deactivate", listHtml);

        // Deactivate → inline success message (AC-018).
        var token = await GetAntiforgeryTokenAsync("/Admin/Users/List");
        var deactivate = await _client.PostAsync(
            "/Admin/Users/List?handler=Deactivate",
            new FormUrlEncodedContent(new Dictionary<string, string>
            {
                ["__RequestVerificationToken"] = token,
                ["id"] = targetId,
            }));
        Assert.Equal(HttpStatusCode.OK, deactivate.StatusCode);
        var deactivatedHtml = await deactivate.Content.ReadAsStringAsync();
        Assert.Contains("deactivated", deactivatedHtml, StringComparison.OrdinalIgnoreCase);
        Assert.Contains("Deactivated", deactivatedHtml); // the list badge
    }

    [Fact]
    public async Task Non_Su_Deactivating_An_Su_Target_Shows_The_Fr007_Error()
    {
        // FR-007: deactivating an su target requires the actor to be su — the
        // service re-check surfaces as an inline error on the page. The target
        // is created as adm and elevated to su through the API surface (the
        // Deactivate_Su_Target_Requires_Su_Actor convention).
        var target = $"su-target-{Guid.NewGuid():N}";
        var targetId = await CreateUserViaApiAsync(target, IdentityIntegration.Roles.Admin);
        await ProvisionSuperUserViaApiAsync(target);
        var userName = $"pages-emp-{Guid.NewGuid():N}";
        SeedUser(userName, IdentityIntegration.Roles.Employee);
        await SignInAsync(userName);

        var token = await GetAntiforgeryTokenAsync("/Admin/Users/List");
        var deactivate = await _client.PostAsync(
            "/Admin/Users/List?handler=Deactivate",
            new FormUrlEncodedContent(new Dictionary<string, string>
            {
                ["__RequestVerificationToken"] = token,
                ["id"] = targetId,
            }));
        Assert.Equal(HttpStatusCode.OK, deactivate.StatusCode);
        var html = await deactivate.Content.ReadAsStringAsync();
        Assert.Contains("Only a super-user can deactivate a super-user account.", html);
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
        => SeedUserOnFactory(_factory, userName, role);

    private void SeedUserOnFactory(VisaFusionWebApplicationFactory factory, string userName, string role)
    {
        using var scope = factory.Services.CreateScope();
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

    private string GetUserId(string userName)
    {
        using var scope = _factory.Services.CreateScope();
        var userManager = scope.ServiceProvider
            .GetRequiredService<UserManager<IdentityIntegration.VisaFusionUser>>();
        var user = userManager.FindByNameAsync(userName).GetAwaiter().GetResult();
        Assert.NotNull(user);
        return user!.Id;
    }

    /// <summary>
    /// Creates a user through the API surface (admin JWT) so the hermetic
    /// stub's user store holds it, and returns its id.
    /// </summary>
    private async Task<string> CreateUserViaApiAsync(string username, string role)
    {
        var token = MintToken(IdentityIntegration.Roles.Admin);
        var request = new HttpRequestMessage(HttpMethod.Post, "/api/v1/admin/users")
        {
            Content = JsonContent.Create(new CreateUserRequest
            {
                Username = username,
                Password = "Str0ngPass!",
                Role = role,
            }),
        };
        request.Headers.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);

        var response = await _client.SendAsync(request);
        Assert.Equal(HttpStatusCode.Created, response.StatusCode);
        var created = await response.Content.ReadFromJsonAsync<UserResponse>();
        Assert.NotNull(created);
        return created!.Id;
    }

    /// <summary>
    /// Elevates an existing user to su through the API surface (su JWT) — the
    /// only path that grants the su role (FR-006).
    /// </summary>
    private async Task ProvisionSuperUserViaApiAsync(string username)
    {
        var token = MintToken(IdentityIntegration.Roles.SuperUser);
        var request = new HttpRequestMessage(HttpMethod.Post, "/api/v1/admin/superusers")
        {
            Content = JsonContent.Create(new ProvisionSuperUserRequest { Username = username }),
        };
        request.Headers.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);

        var response = await _client.SendAsync(request);
        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
    }

    /// <summary>
    /// Mints a local JWT (the AgentRbacTests convention). For `su` the token
    /// mirrors IdentityClaims.FromUser: the effective adm role (FR-008) and the
    /// SuperUser claim the SuperUserOnly policy requires.
    /// </summary>
    private string MintToken(string role)
    {
        var userName = $"pages-token-{role}-{Guid.NewGuid():N}";
        SeedUser(userName, role);

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
        if (role == IdentityIntegration.Roles.SuperUser)
        {
            claims.Add(new Claim(ClaimTypes.Role, IdentityIntegration.Roles.Admin));
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

    private const string TestPassword = "TestPass123!";
}