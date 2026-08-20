using System.Net;
using System.Net.Http;
using System.Text.RegularExpressions;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc.Testing;
using Microsoft.Extensions.DependencyInjection;
using VisaFusion.Core.Application;
using VisaFusion.Identity;

namespace VisaFusion.FunctionalTests;

/// <summary>
/// Role-specific landing pages smoke test (SPEC-0009 T032–T038, FR-005;
/// Addendum §7).
///
/// Proves each role's landing page renders the CoreUI presentation with its
/// existing content/data:
///   - anonymous → root `/` renders the PublicLanding component,
///   - <c>agt</c> with a linked agent → `/Agent/Index` renders the identity
///     card (RoleDashboard component),
///   - <c>agt</c> without a linked agent → `/Agent/Index` renders the CHK026
///     "no linked agent" alert,
///   - <c>emp</c> → `/Reporting/Index` renders the six report links,
///   - <c>adm</c> → `/Admin/Index` renders the placeholder.
///
/// No KPI cards, charts or progress groups are asserted: the existing pages
/// expose no metric/chart data and the feature constraint forbids inventing
/// any (T039 deferred).
/// </summary>
public class LandingPagesTests : IClassFixture<VisaFusionWebApplicationFactory>
{
    private const string TestPassword = "TestPass123!";

    private readonly VisaFusionWebApplicationFactory _factory;
    private readonly HttpClient _client;

    public LandingPagesTests(VisaFusionWebApplicationFactory factory)
    {
        _factory = factory;
        _client = factory.CreateClient();
    }

    [Fact]
    public async Task Anonymous_Get_Root_Renders_PublicLanding()
    {
        var response = await _client.GetAsync("/");

        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
        var html = await response.Content.ReadAsStringAsync();
        Assert.Contains("VisaFusion", html);
        Assert.Contains("single-process host", html);
        Assert.Contains("public-landing", html);
    }

    [Fact]
    public async Task Agent_Get_AgentIndex_Renders_Identity_Card()
    {
        // Seed the portal agents (42/43) so the identity card path renders.
        var stub = _factory.Services.GetRequiredService<IAgentService>() as VisaFusionWebApplicationFactory.InMemoryAgentServiceStub;
        stub?.SeedPortalAgents();

        SeedUser("landing-agt", IdentityIntegration.Roles.Agent, agentId: 42);
        await SignInAsync("landing-agt");

        var response = await _client.GetAsync("/Agent/Index");

        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
        var html = await response.Content.ReadAsStringAsync();
        Assert.Contains("Agent portal", html);
        Assert.Contains("Portal Agent 42", html); // stub identity card data
        Assert.Contains("role-dashboard", html);
    }

    [Fact]
    public async Task Agent_Without_Linked_Agent_Renders_Chk026_Alert()
    {
        SeedUser("landing-agt-unlinked", IdentityIntegration.Roles.Agent, agentId: null);
        await SignInAsync("landing-agt-unlinked");

        var response = await _client.GetAsync("/Agent/Index");

        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
        var html = await response.Content.ReadAsStringAsync();
        Assert.Contains("no linked agent", html);
        Assert.Contains("alert-danger", html);
    }

    [Fact]
    public async Task Agent_Identity_Card_Encodes_Data()
    {
        // The RoleDashboard BodyHtml is rendered via @Html.Raw, so the page
        // must pre-encode data values (WebUtility.HtmlEncode). Seed an agent
        // with hostile markup and assert the rendered page escapes it.
        var stub = _factory.Services.GetRequiredService<IAgentService>() as VisaFusionWebApplicationFactory.InMemoryAgentServiceStub;
        Assert.NotNull(stub);

        var agent = await stub.CreateAsync(
            new AgentInput(
                Companyname: "<script>alert('xss')</script>",
                Description: null,
                Street1: "1 <b>St</b>",
                Street2: null,
                Area: null,
                City: null,
                Pincode: null,
                Phoneno: null,
                Faxno: null,
                Emailid: null,
                Smsno: null,
                Directorname: null,
                DirectorPH: null,
                AcMgrPH: null,
                VisaInchargeName: null,
                VisaInchargePH: null,
                Acno: null,
                Payment: null,
                TAAI: null,
                TAFI: null,
                Membership: null,
                IATA: null),
            "hostile-agent-user", TestPassword, "test-actor", "test-actor");

        SeedUser("landing-agt-xss", IdentityIntegration.Roles.Agent, agentId: agent.Id);
        await SignInAsync("landing-agt-xss");

        var response = await _client.GetAsync("/Agent/Index");

        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
        var html = await response.Content.ReadAsStringAsync();
        Assert.Contains("&lt;script&gt;", html);
        Assert.Contains("&lt;b&gt;", html);
        Assert.DoesNotContain("<script>alert", html);
    }

    [Fact]
    public async Task Employee_Get_ReportingIndex_Renders_Report_Links()
    {
        SeedUser("landing-emp", IdentityIntegration.Roles.Employee, agentId: null);
        await SignInAsync("landing-emp");

        var response = await _client.GetAsync("/Reporting/Index");

        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
        var html = await response.Content.ReadAsStringAsync();
        Assert.Contains("Operational Reports", html);
        Assert.Contains("Daily bill", html);
        Assert.Contains("role-dashboard", html);
    }

    [Fact]
    public async Task Anonymous_Get_AdminIndex_Redirects_To_Login()
    {
        // Admin Index is now gated by the AdminPanel policy (adm/su) via its
        // page model — the previous no-policy state left the route reachable
        // by any caller (review finding 3).
        var client = _factory.CreateClient(new WebApplicationFactoryClientOptions
        {
            AllowAutoRedirect = false,
        });

        var response = await client.GetAsync("/Admin/Index");

        Assert.Equal(HttpStatusCode.Redirect, response.StatusCode);
        Assert.Contains("/Auth/Login", response.Headers.Location?.OriginalString);
    }

    [Fact]
    public async Task Admin_Get_AdminIndex_Renders_Placeholder()
    {
        SeedUser("landing-adm", IdentityIntegration.Roles.Admin, agentId: null);
        await SignInAsync("landing-adm");

        var response = await _client.GetAsync("/Admin/Index");

        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
        var html = await response.Content.ReadAsStringAsync();
        Assert.Contains("Admin Area", html);
        Assert.Contains("role-dashboard", html);
    }

    private void SeedUser(string userName, string role, int? agentId)
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
    }

    /// <summary>Signs in via the Web login page so the shared client holds the cookie.</summary>
    private async Task SignInAsync(string userName)
    {
        var token = await GetAntiforgeryTokenAsync("/Auth/Login");
        var response = await _client.PostAsync("/Auth/Login", new FormUrlEncodedContent(new Dictionary<string, string>
        {
            ["__RequestVerificationToken"] = token,
            ["UserName"] = userName,
            ["Password"] = TestPassword,
        }));
        Assert.True(response.StatusCode is HttpStatusCode.OK or HttpStatusCode.Redirect,
            $"login failed with {response.StatusCode}");
    }

    private async Task<string> GetAntiforgeryTokenAsync(string url)
    {
        var response = await _client.GetAsync(url);
        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
        var html = await response.Content.ReadAsStringAsync();
        var match = Regex.Match(html, "__RequestVerificationToken[^>]*value=\"([^\"]+)\"");
        Assert.True(match.Success, $"antiforgery token not found in {url}");
        return match.Groups[1].Value;
    }
}