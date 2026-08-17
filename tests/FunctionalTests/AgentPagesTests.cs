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
using VisaFusion.Api.Contracts;
using VisaFusion.Identity;

namespace VisaFusion.FunctionalTests;

/// <summary>
/// Admin agent pages functional test (SPEC-0007 T015/T016, US1, FR-001..004,
/// FR-022, AC-001/AC-002/AC-016/AC-017; contracts/ui-contract.md §5,
/// contracts/agents-api.md §1/§5/§6/§7).
///
/// Proves the cookie-backed Razor Pages admin surfaces for agent management:
///   - anonymous → redirect to /Auth/Login ([Authorize]),
///   - authenticated non-admin (emp) → redirect to /Auth/AccessDenied
///     (AdminPanel policy = adm/su),
///   - adm list renders (empty state explicit — CHK027; populated rows),
///   - create page form + field-level validation (companyname/username/password
///     required, password policy — spec §17),
///   - the full create → detail → deactivate → reactivate → edit flows
///     (AC-016), with inline outcome messages (spec §18),
///   - unknown agent → inline not-found message.
///
/// Uses the hermetic <see cref="VisaFusionWebApplicationFactory"/> with the
/// in-memory <see cref="IAgentService"/> stub. Agents used by the detail/edit/
/// lifecycle tests are seeded through the API surface with a locally-minted
/// admin JWT (the AgentRbacTests convention) so the shared factory's stub is
/// the only source of records.
/// </summary>
public class AgentPagesTests : IClassFixture<VisaFusionWebApplicationFactory>
{
    private readonly VisaFusionWebApplicationFactory _factory;
    private readonly HttpClient _client;

    public AgentPagesTests(VisaFusionWebApplicationFactory factory)
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

        var response = await client.GetAsync("/Admin/Agents/List");

        Assert.Equal(HttpStatusCode.Redirect, response.StatusCode);
        var location = response.Headers.Location;
        Assert.NotNull(location);
        Assert.Equal("/Auth/Login", location!.AbsolutePath);
    }

    [Fact]
    public async Task Wrong_Role_Is_Redirected_To_AccessDenied()
    {
        SeedUser("pages-emp", IdentityIntegration.Roles.Employee);

        var client = _factory.CreateClient(new WebApplicationFactoryClientOptions
        {
            AllowAutoRedirect = false,
        });
        await SignInOnClientAsync(client, "pages-emp");

        var response = await client.GetAsync("/Admin/Agents/List");

        Assert.Equal(HttpStatusCode.Redirect, response.StatusCode);
        // Cookie auth's AccessDeniedPath (/Auth/AccessDenied) — the page-level
        // mirror of the API's 403 (AC-002).
        Assert.Equal("/Auth/AccessDenied", response.Headers.Location?.AbsolutePath);
    }

    [Fact]
    public async Task Admin_Sees_Explicit_Empty_State_On_The_List()
    {
        // A fresh factory has an empty agent store — the shared class fixture
        // may already hold records from other tests.
        using var fresh = new VisaFusionWebApplicationFactory();
        var client = fresh.CreateClient();
        SeedUserOnFactory(fresh, "pages-empty", IdentityIntegration.Roles.Admin);
        await SignInOnClientAsync(client, "pages-empty");

        var response = await client.GetAsync("/Admin/Agents/List");

        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
        var html = await response.Content.ReadAsStringAsync();
        Assert.Contains("No agents found.", html); // CHK027 — never a blank page
    }

    [Fact]
    public async Task Admin_Can_Create_An_Agent_Through_The_Page()
    {
        var userName = $"pages-adm-{Guid.NewGuid():N}";
        SeedUser(userName, IdentityIntegration.Roles.Admin);
        await SignInAsync(userName);

        var token = await GetAntiforgeryTokenAsync("/Admin/Agents/Create");
        var company = $"page-co-{Guid.NewGuid():N}";
        var response = await _client.PostAsync("/Admin/Agents/Create", new FormUrlEncodedContent(new Dictionary<string, string>
        {
            ["__RequestVerificationToken"] = token,
            ["Companyname"] = company,
            ["Username"] = $"agt-page-{Guid.NewGuid():N}",
            ["Password"] = "PagePass123!",
            ["City"] = "Mumbai",
        }));

        // Success redirects to the detail page (followed by the default client).
        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
        var html = await response.Content.ReadAsStringAsync();
        Assert.Contains(company, html);
        Assert.Contains("Active", html); // the detail badge
    }

    [Fact]
    public async Task Create_Without_Companyname_Shows_The_Field_Error()
    {
        var userName = $"pages-adm-{Guid.NewGuid():N}";
        SeedUser(userName, IdentityIntegration.Roles.Admin);
        await SignInAsync(userName);

        var token = await GetAntiforgeryTokenAsync("/Admin/Agents/Create");
        var response = await _client.PostAsync("/Admin/Agents/Create", new FormUrlEncodedContent(new Dictionary<string, string>
        {
            ["__RequestVerificationToken"] = token,
            ["Username"] = $"agt-page-{Guid.NewGuid():N}",
            ["Password"] = "PagePass123!",
        }));

        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
        var html = await response.Content.ReadAsStringAsync();
        Assert.Contains("Company name is required.", html);
    }

    [Fact]
    public async Task Create_With_Short_Password_Shows_The_Policy_Error()
    {
        var userName = $"pages-adm-{Guid.NewGuid():N}";
        SeedUser(userName, IdentityIntegration.Roles.Admin);
        await SignInAsync(userName);

        var token = await GetAntiforgeryTokenAsync("/Admin/Agents/Create");
        var response = await _client.PostAsync("/Admin/Agents/Create", new FormUrlEncodedContent(new Dictionary<string, string>
        {
            ["__RequestVerificationToken"] = token,
            ["Companyname"] = "Short Pass Co",
            ["Username"] = $"agt-page-{Guid.NewGuid():N}",
            ["Password"] = "abc", // under RequiredLength = 8 (spec §17/CHK044)
        }));

        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
        var html = await response.Content.ReadAsStringAsync();
        Assert.Contains("Password must be at least 8 characters.", html);
    }

    [Fact]
    public async Task Admin_Can_Deactivate_And_Reactivate_From_The_Detail_Page()
    {
        var agentId = await CreateAgentViaApiAsync("lifecycle-pages");
        var userName = $"pages-adm-{Guid.NewGuid():N}";
        SeedUser(userName, IdentityIntegration.Roles.Admin);
        await SignInAsync(userName);

        // Detail shows the agent with the Deactivate action (FR-004).
        var detail = await _client.GetAsync($"/Admin/Agents/Detail?id={agentId}");
        Assert.Equal(HttpStatusCode.OK, detail.StatusCode);
        var detailHtml = await detail.Content.ReadAsStringAsync();
        Assert.Contains("lifecycle-pages", detailHtml);
        Assert.Contains("Deactivate", detailHtml);

        // Deactivate → inline success message + Reactivate action (AC-016).
        var token = await GetAntiforgeryTokenAsync($"/Admin/Agents/Detail?id={agentId}");
        var deactivate = await _client.PostAsync(
            $"/Admin/Agents/Detail?id={agentId}&handler=Deactivate",
            new FormUrlEncodedContent(new Dictionary<string, string>
            {
                ["__RequestVerificationToken"] = token,
                ["Id"] = agentId.ToString(),
            }));
        Assert.Equal(HttpStatusCode.OK, deactivate.StatusCode);
        var deactivatedHtml = await deactivate.Content.ReadAsStringAsync();
        Assert.Contains("deactivated", deactivatedHtml, StringComparison.OrdinalIgnoreCase);
        Assert.Contains("Reactivate", deactivatedHtml);

        // Reactivate → inline success message + Deactivate action (FR-022).
        token = await GetAntiforgeryTokenAsync($"/Admin/Agents/Detail?id={agentId}");
        var reactivate = await _client.PostAsync(
            $"/Admin/Agents/Detail?id={agentId}&handler=Reactivate",
            new FormUrlEncodedContent(new Dictionary<string, string>
            {
                ["__RequestVerificationToken"] = token,
                ["Id"] = agentId.ToString(),
            }));
        Assert.Equal(HttpStatusCode.OK, reactivate.StatusCode);
        var reactivatedHtml = await reactivate.Content.ReadAsStringAsync();
        Assert.Contains("reactivated", reactivatedHtml, StringComparison.OrdinalIgnoreCase);
        Assert.Contains("Deactivate", reactivatedHtml);
    }

    [Fact]
    public async Task Admin_Can_Edit_An_Agent_Through_The_Page()
    {
        var agentId = await CreateAgentViaApiAsync("edit-pages");
        var userName = $"pages-adm-{Guid.NewGuid():N}";
        SeedUser(userName, IdentityIntegration.Roles.Admin);
        await SignInAsync(userName);

        // Edit page pre-fills the current values (FR-003).
        var edit = await _client.GetAsync($"/Admin/Agents/Edit?id={agentId}");
        Assert.Equal(HttpStatusCode.OK, edit.StatusCode);
        var editHtml = await edit.Content.ReadAsStringAsync();
        Assert.Contains("edit-pages", editHtml);

        var token = await GetAntiforgeryTokenAsync($"/Admin/Agents/Edit?id={agentId}");
        var response = await _client.PostAsync(
            $"/Admin/Agents/Edit?id={agentId}",
            new FormUrlEncodedContent(new Dictionary<string, string>
            {
                ["__RequestVerificationToken"] = token,
                ["Id"] = agentId.ToString(),
                ["Companyname"] = "edit-pages",
                ["City"] = "Delhi",
            }));

        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
        var html = await response.Content.ReadAsStringAsync();
        Assert.Contains("Delhi", html); // detail page shows the updated city
    }

    [Fact]
    public async Task Unknown_Agent_Shows_The_Inline_Not_Found_Message()
    {
        var userName = $"pages-adm-{Guid.NewGuid():N}";
        SeedUser(userName, IdentityIntegration.Roles.Admin);
        await SignInAsync(userName);

        var detail = await _client.GetAsync("/Admin/Agents/Detail?id=999999");
        Assert.Equal(HttpStatusCode.OK, detail.StatusCode);
        Assert.Contains("was not found.", await detail.Content.ReadAsStringAsync());

        var edit = await _client.GetAsync("/Admin/Agents/Edit?id=999999");
        Assert.Equal(HttpStatusCode.OK, edit.StatusCode);
        Assert.Contains("was not found.", await edit.Content.ReadAsStringAsync());
    }

    /// <summary>Seeds an agent through the API surface and returns its id.</summary>
    private async Task<int> CreateAgentViaApiAsync(string company)
    {
        var token = MintToken(IdentityIntegration.Roles.Admin);
        var request = new HttpRequestMessage(HttpMethod.Post, "/api/v1/agents")
        {
            Content = JsonContent.Create(new CreateAgentRequest
            {
                Companyname = company,
                Username = $"agt-{Guid.NewGuid():N}",
                Password = "Str0ngPass!",
            }),
        };
        request.Headers.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);

        var response = await _client.SendAsync(request);
        Assert.Equal(HttpStatusCode.Created, response.StatusCode);
        var created = await response.Content.ReadFromJsonAsync<CreateAgentResponse>();
        Assert.NotNull(created);
        return created!.Id;
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

    /// <summary>Mints a local admin JWT (the AgentRbacTests convention).</summary>
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
        var claims = new[]
        {
            new Claim(ClaimTypes.Name, userName),
            new Claim(ClaimTypes.Role, role),
        };
        var token = new JwtSecurityToken(
            issuer: "VisaFusion",
            audience: "VisaFusion.Api",
            claims: claims,
            expires: DateTime.UtcNow.AddHours(1),
            signingCredentials: credentials);

        return new JwtSecurityTokenHandler().WriteToken(token);
    }

    private sealed class CreateAgentResponse
    {
        public int Id { get; set; }
    }

    private const string TestPassword = "TestPass123!";
}
