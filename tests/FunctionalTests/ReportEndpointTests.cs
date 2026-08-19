using System.IdentityModel.Tokens.Jwt;
using System.Net;
using System.Net.Http.Headers;
using System.Security.Claims;
using System.Text;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.IdentityModel.Tokens;
using VisaFusion.Data.Persistence;
using VisaFusion.Data.Persistence.Entities;
using VisaFusion.Identity;

namespace VisaFusion.FunctionalTests;

/// <summary>
/// Report endpoint tests (SPEC-0008 T044, US6, FR-012, AC-008;
/// contracts/reports-api.md).
///
/// Proves the seven report GETs hermetically over the real
/// <see cref="VisaFusion.Api.Endpoints.ReportsEndpoint"/> (the factory replaces
/// VisaEntryDbContext with an InMemory store):
///   - all seven routes return 200 for emp/adm/su (EntryOperations policy),
///   - agt/guest → 403 and anonymous → 401 (AC-008),
///   - invalid dates and dateTo &lt; dateFrom → 400 BEFORE any query runs
///     (spec §17),
///   - the pending report returns the seeded rows (the LINQ joins resolve),
///   - the same inputs produce byte-identical output on repeat calls
///     (deterministic ordering — NFR-006).
/// Tokens carry the seeded username in the `name` claim (GR-0004 convention).
/// </summary>
public class ReportEndpointTests : IClassFixture<VisaFusionWebApplicationFactory>
{
    private const int TestAgentId = 90001;
    private const int TestEmbassyId = 90002;
    private const int TestRefno = 900001;
    private const int TestPaxId = 900003;

    private static readonly string[] ReportRoutes =
    {
        "/api/v1/reports/agent-status/today",
        "/api/v1/reports/pending",
        "/api/v1/reports/today-submission",
        "/api/v1/reports/today-collection",
        "/api/v1/reports/today-transaction",
        "/api/v1/reports/daily-visa-fee",
        "/api/v1/reports/daily-bill",
    };

    private readonly VisaFusionWebApplicationFactory _factory;
    private readonly HttpClient _client;

    public ReportEndpointTests(VisaFusionWebApplicationFactory factory)
    {
        _factory = factory;
        _client = factory.CreateClient();
    }

    [Fact]
    public async Task Report_Endpoints_Return_200_For_Employee_Admin_SuperUser()
    {
        foreach (var role in new[] { IdentityIntegration.Roles.Employee, IdentityIntegration.Roles.Admin, IdentityIntegration.Roles.SuperUser })
        {
            var token = MintTokenAsync(role);
            foreach (var route in ReportRoutes)
            {
                var response = await GetAsync(_client, route, token);
                Assert.Equal(HttpStatusCode.OK, response.StatusCode);
            }
        }
    }

    [Fact]
    public async Task Report_Endpoints_Return_403_For_Agent_And_Guest()
    {
        // AC-008: agt/guest receive 403 on every report surface.
        foreach (var role in new[] { IdentityIntegration.Roles.Agent, IdentityIntegration.Roles.Guest })
        {
            var token = MintTokenAsync(role);
            foreach (var route in ReportRoutes)
            {
                var response = await GetAsync(_client, route, token);
                Assert.Equal(HttpStatusCode.Forbidden, response.StatusCode);
            }
        }
    }

    [Fact]
    public async Task Report_Endpoints_Return_401_For_Anonymous()
    {
        foreach (var route in ReportRoutes)
        {
            var response = await _client.GetAsync(route);
            Assert.Equal(HttpStatusCode.Unauthorized, response.StatusCode);
        }
    }

    [Fact]
    public async Task Invalid_Date_Inputs_Return_400_Before_Query_Execution()
    {
        var token = MintTokenAsync(IdentityIntegration.Roles.Employee);

        // Not a calendar date.
        var notADate = await GetAsync(_client, "/api/v1/reports/pending?dateFrom=not-a-date", token);
        Assert.Equal(HttpStatusCode.BadRequest, notADate.StatusCode);

        // dateTo before dateFrom.
        var reversed = await GetAsync(_client, "/api/v1/reports/pending?dateFrom=2026-02-01&dateTo=2026-01-01", token);
        Assert.Equal(HttpStatusCode.BadRequest, reversed.StatusCode);

        // agentId not an integer.
        var badAgent = await GetAsync(_client, "/api/v1/reports/pending?agentId=abc", token);
        Assert.Equal(HttpStatusCode.BadRequest, badAgent.StatusCode);
    }

    [Fact]
    public async Task Pending_Report_Returns_Seeded_Rows()
    {
        SeedReportData();
        var token = MintTokenAsync(IdentityIntegration.Roles.Employee);

        var response = await GetAsync(_client, "/api/v1/reports/pending", token);
        Assert.Equal(HttpStatusCode.OK, response.StatusCode);

        var body = await response.Content.ReadAsStringAsync();
        Assert.Contains($"\"refno\":{TestRefno}", body);
        Assert.Contains("T044 Pax", body);
        Assert.Contains("T044 Agent", body);
        Assert.Contains("T044 Embassy", body);
    }

    [Fact]
    public async Task Same_Inputs_Produce_Identical_Output_On_Repeat_Calls()
    {
        // AC-008 / NFR-006: fixed ORDER BY — the same inputs yield the same
        // rows in the same order.
        var token = MintTokenAsync(IdentityIntegration.Roles.Employee);

        var first = await GetAsync(_client, "/api/v1/reports/pending", token);
        var second = await GetAsync(_client, "/api/v1/reports/pending", token);

        Assert.Equal(HttpStatusCode.OK, first.StatusCode);
        Assert.Equal(await first.Content.ReadAsStringAsync(), await second.Content.ReadAsStringAsync());
    }

    // ---- helpers (HolidayCrudEndpointTests convention) ----

    private void SeedReportData()
    {
        using var scope = _factory.Services.CreateScope();
        var db = scope.ServiceProvider.GetRequiredService<VisaEntryDbContext>();

        if (!db.Agents.Any(a => a.Id == TestAgentId))
        {
            db.Agents.Add(new Agent { Id = TestAgentId, Description = "T044 Agent" });
        }

        if (!db.Embassies.Any(e => e.Id == TestEmbassyId))
        {
            db.Embassies.Add(new Embassy { Id = TestEmbassyId, Description = "T044 Embassy" });
        }

        if (!db.Entries.Any(e => e.Refno == TestRefno))
        {
            db.Entries.Add(new Entry
            {
                Refno = TestRefno,
                Agent = TestAgentId,
                Externalremark = "t044-pending",
            });
        }

        if (!db.EntryPassengers.Any(p => p.Id == TestPaxId))
        {
            db.EntryPassengers.Add(new EntryPassenger
            {
                Id = TestPaxId,
                Refno = TestRefno,
                Paxname = "T044 Pax",
            });
        }

        if (!db.PaxCountryStatuses.Any(ps => ps.Refno == TestRefno && ps.PaxId == TestPaxId))
        {
            db.PaxCountryStatuses.Add(new PaxCountryStatus
            {
                Refno = TestRefno,
                PaxId = TestPaxId,
                CountryId = TestEmbassyId,
                StatusId = 405, // pending band 401..409
                Subdate = DateTime.Today,
            });
        }

        db.SaveChanges();
    }

    private string MintTokenAsync(string role)
    {
        var userName = $"report-user-{role}-{Guid.NewGuid():N}";
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
            claims.Add(new Claim(VisaFusion.Api.Authorization.IdentityClaims.SuperUserClaimType, "true"));
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

    private static async Task<HttpResponseMessage> GetAsync(HttpClient client, string url, string token)
    {
        var request = new HttpRequestMessage(HttpMethod.Get, url);
        request.Headers.Authorization = new AuthenticationHeaderValue("Bearer", token);
        return await client.SendAsync(request);
    }
}