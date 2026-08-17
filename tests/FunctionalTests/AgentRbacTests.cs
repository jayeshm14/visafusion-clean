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
using VisaFusion.Api.Contracts;
using VisaFusion.Identity;

namespace VisaFusion.FunctionalTests;

/// <summary>
/// Agents admin-surface RBAC matrix functional test (SPEC-0007 T014, US1,
/// FR-001..004/FR-022, AC-001/AC-002/AC-016/AC-017; contracts/agents-api.md
/// §1/§5/§6/§7).
///
/// Asserts the authorization matrix over all five agent-management endpoints
/// (AdminPanel = adm/su, §4.2): anonymous → 401, wrong role (agt/emp/guest) →
/// 403, correct role (adm/su) → 201/200. Also asserts the lifecycle responses
/// (deactivate → Active 'N', reactivate → 'Y'), duplicate-username → 409, and
/// unknown-agent → 404. Uses the hermetic
/// <see cref="VisaFusionWebApplicationFactory"/> with the in-memory
/// <see cref="IAgentService"/> stub (the real service behavior is covered by
/// the unit and integration tests).
///
/// Tokens are minted locally with the same development key the host uses
/// (test-only; production keys come from configuration, NFR-004) — the
/// established convention for role-matrix tests (EntriesRbacTests,
/// SecuredWriteRoutesTests). The JWT `name` claim carries the seeded username
/// so the handlers' server-side actor resolution (JWT name → AspNetUsers.Id via
/// UserManager.FindByNameAsync, GR-0004) resolves.
/// </summary>
public class AgentRbacTests : IClassFixture<VisaFusionWebApplicationFactory>
{
    private readonly VisaFusionWebApplicationFactory _factory;
    private readonly HttpClient _client;

    public AgentRbacTests(VisaFusionWebApplicationFactory factory)
    {
        _factory = factory;
        _client = factory.CreateClient();
    }

    [Fact]
    public async Task Anonymous_Is_Unauthorized_On_All_Agent_Endpoints()
    {
        var create = new CreateAgentRequest { Companyname = "A", Username = "u", Password = "Pass123!" };

        Assert.Equal(HttpStatusCode.Unauthorized, (await _client.PostAsync("/api/v1/agents", Json(create))).StatusCode);
        Assert.Equal(HttpStatusCode.Unauthorized, (await _client.GetAsync("/api/v1/agents")).StatusCode);
        Assert.Equal(HttpStatusCode.Unauthorized, (await _client.PutAsync("/api/v1/agents/1", Json(create))).StatusCode);
        Assert.Equal(HttpStatusCode.Unauthorized, (await _client.PostAsync("/api/v1/agents/1/deactivate", null)).StatusCode);
        Assert.Equal(HttpStatusCode.Unauthorized, (await _client.PostAsync("/api/v1/agents/1/reactivate", null)).StatusCode);
    }

    [Theory]
    [InlineData(IdentityIntegration.Roles.Agent)]
    [InlineData(IdentityIntegration.Roles.Employee)]
    [InlineData(IdentityIntegration.Roles.Guest)]
    public async Task Wrong_Role_Is_Forbidden_On_All_Agent_Endpoints(string role)
    {
        var token = MintTokenAsync(role);
        var create = new CreateAgentRequest { Companyname = "A", Username = "u", Password = "Pass123!" };

        Assert.Equal(HttpStatusCode.Forbidden,
            (await PostAsync("/api/v1/agents", create, token)).StatusCode);
        Assert.Equal(HttpStatusCode.Forbidden,
            (await GetAsync("/api/v1/agents", token)).StatusCode);
        Assert.Equal(HttpStatusCode.Forbidden,
            (await PutAsync("/api/v1/agents/1", new UpdateAgentRequest { Companyname = "A" }, token)).StatusCode);
        Assert.Equal(HttpStatusCode.Forbidden,
            (await PostAsync("/api/v1/agents/1/deactivate", token)).StatusCode);
        Assert.Equal(HttpStatusCode.Forbidden,
            (await PostAsync("/api/v1/agents/1/reactivate", token)).StatusCode);
    }

    [Theory]
    [InlineData(IdentityIntegration.Roles.Admin)]
    [InlineData(IdentityIntegration.Roles.SuperUser)]
    public async Task Correct_Role_Can_Run_The_Agent_Lifecycle(string role)
    {
        var token = MintTokenAsync(role);
        var company = $"agent-rbac-{Guid.NewGuid():N}";
        var username = $"agt-{Guid.NewGuid():N}";

        // POST /agents → 201 with the new agent id.
        var create = await PostAsync("/api/v1/agents",
            new CreateAgentRequest
            {
                Companyname = company,
                Username = username,
                Password = "Str0ngPass!",
                City = "Mumbai",
            }, token);
        Assert.Equal(HttpStatusCode.Created, create.StatusCode);
        var created = await create.Content.ReadFromJsonAsync<CreateAgentResponse>();
        Assert.NotNull(created);
        Assert.True(created!.Id > 0);
        var agentId = created.Id;

        // GET /agents → 200, contains the created agent.
        var list = await GetAsync($"/api/v1/agents?q={company}", token);
        Assert.Equal(HttpStatusCode.OK, list.StatusCode);
        var body = await list.Content.ReadFromJsonAsync<AgentListResponse>();
        Assert.NotNull(body);
        Assert.True(body!.Total >= 1);
        Assert.Contains(body.Items, a => a.Id == agentId && a.Active == "Y");

        // PUT /agents/{id} → 200 with the updated fields.
        var update = await PutAsync($"/api/v1/agents/{agentId}",
            new UpdateAgentRequest { City = "Delhi", Phoneno = "011-1234" }, token);
        Assert.Equal(HttpStatusCode.OK, update.StatusCode);
        var updated = await update.Content.ReadFromJsonAsync<AgentResponse>();
        Assert.NotNull(updated);
        Assert.Equal("Delhi", updated!.City);
        Assert.Equal("Y", updated.Active); // lifecycle flag untouched by update

        // POST /agents/{id}/deactivate → 200, Active = 'N' (FR-004).
        var deactivate = await PostAsync($"/api/v1/agents/{agentId}/deactivate", token);
        Assert.Equal(HttpStatusCode.OK, deactivate.StatusCode);
        var deactivated = await deactivate.Content.ReadFromJsonAsync<AgentResponse>();
        Assert.NotNull(deactivated);
        Assert.Equal("N", deactivated!.Active);

        // POST /agents/{id}/reactivate → 200, Active = 'Y' (FR-022).
        var reactivate = await PostAsync($"/api/v1/agents/{agentId}/reactivate", token);
        Assert.Equal(HttpStatusCode.OK, reactivate.StatusCode);
        var reactivated = await reactivate.Content.ReadFromJsonAsync<AgentResponse>();
        Assert.NotNull(reactivated);
        Assert.Equal("Y", reactivated!.Active);
    }

    [Fact]
    public async Task Duplicate_Username_On_Create_Returns_409()
    {
        var token = MintTokenAsync(IdentityIntegration.Roles.Admin);
        var username = $"agt-dup-{Guid.NewGuid():N}";
        var create = new CreateAgentRequest
        {
            Companyname = "First Co",
            Username = username,
            Password = "Str0ngPass!",
        };

        Assert.Equal(HttpStatusCode.Created, (await PostAsync("/api/v1/agents", create, token)).StatusCode);

        var dup = await PostAsync("/api/v1/agents", create with { Companyname = "Second Co" }, token);
        Assert.Equal(HttpStatusCode.Conflict, dup.StatusCode);
    }

    [Fact]
    public async Task Missing_Companyname_On_Create_Returns_400()
    {
        var token = MintTokenAsync(IdentityIntegration.Roles.Admin);
        var create = new CreateAgentRequest
        {
            Username = $"agt-{Guid.NewGuid():N}",
            Password = "Str0ngPass!",
        };

        var response = await PostAsync("/api/v1/agents", create, token);
        Assert.Equal(HttpStatusCode.BadRequest, response.StatusCode);
    }

    [Fact]
    public async Task Unknown_Agent_On_Lifecycle_Returns_404()
    {
        var token = MintTokenAsync(IdentityIntegration.Roles.Admin);

        Assert.Equal(HttpStatusCode.NotFound,
            (await PostAsync("/api/v1/agents/999999/deactivate", token)).StatusCode);
        Assert.Equal(HttpStatusCode.NotFound,
            (await PostAsync("/api/v1/agents/999999/reactivate", token)).StatusCode);
        Assert.Equal(HttpStatusCode.NotFound,
            (await PutAsync("/api/v1/agents/999999", new UpdateAgentRequest { City = "X" }, token)).StatusCode);
    }

    /// <summary>
    /// Seeds a user in the hermetic InMemory identity store and mints a JWT
    /// locally (the EntriesRbacTests/SecuredWriteRoutesTests convention). The
    /// `name` claim carries the seeded username so the handlers' server-side
    /// actor resolution (JWT name → AspNetUsers.Id) resolves — never a
    /// caller-supplied actor string (GR-0004).
    /// </summary>
    private string MintTokenAsync(string role)
    {
        var userName = $"agent-rbac-{role}-{Guid.NewGuid():N}";
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

    private async Task<HttpResponseMessage> GetAsync(string url, string? token)
        => await _client.SendAsync(Request(HttpMethod.Get, url, token, body: null));

    private async Task<HttpResponseMessage> PutAsync(string url, object body, string? token)
        => await _client.SendAsync(Request(HttpMethod.Put, url, token, Json(body)));

    private sealed class CreateAgentResponse
    {
        public int Id { get; set; }
    }
}
