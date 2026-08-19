using System.Net;
using System.Net.Http.Json;
using System.Text;
using Microsoft.AspNetCore.Mvc.Testing;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using VisaFusion.Api.Endpoints;
using VisaFusion.Web;

namespace VisaFusion.FunctionalTests;

/// <summary>
/// Contact-query endpoint tests (SPEC-0008 T018, FR-007, AC-001; SPEC-0007
/// contract `public-api.md` §1).
///
/// Proves the anonymous, validated, rate-limited contract hermetically:
///   - a valid query returns 201 (the real PublicEndpoint.SubmitQueryAsync
///     persists to the InMemory VisaEntryDbContext and enqueues the office
///     email — factory replacement in VisaFusionWebApplicationFactory),
///   - malformed JSON / missing fields / invalid email return 400 problem
///     details (spec §17),
///   - the config-driven limiter rejects the excess request with 429.
///
/// NOTE: the base factory's appsettings.json ships `RateLimiting:Queries`
/// 5/3600 (owner Q3:A default), so this class posts at most 4 requests to the
/// base factory's route — the rate-limit scenario uses its own factory with
/// 2/60 thresholds (RateLimitTests precedent for env-var-driven config).
/// </summary>
public class QueriesEndpointTests : IClassFixture<VisaFusionWebApplicationFactory>
{
    private readonly VisaFusionWebApplicationFactory _factory;
    private readonly HttpClient _client;

    public QueriesEndpointTests(VisaFusionWebApplicationFactory factory)
    {
        _factory = factory;
        _client = factory.CreateClient();
        
        // Ensure the in-memory database schema is created
        using var scope = _factory.Services.CreateScope();
        var db = scope.ServiceProvider.GetRequiredService<VisaFusion.Data.Persistence.VisaEntryDbContext>();
        db.Database.EnsureCreated();
    }

    [Fact]
    public async Task Valid_Query_Returns_201()
    {
        var response = await _client.PostAsJsonAsync("/api/v1/public/queries", ValidRequest());
        Assert.Equal(HttpStatusCode.Created, response.StatusCode);
    }

    [Fact]
    public async Task Malformed_Json_Returns_400()
    {
        var response = await _client.PostAsync(
            "/api/v1/public/queries",
            new StringContent("{ not valid json", Encoding.UTF8, "application/json"));
        Assert.Equal(HttpStatusCode.BadRequest, response.StatusCode);
    }

    [Fact]
    public async Task Missing_Field_Returns_400()
    {
        var response = await _client.PostAsJsonAsync("/api/v1/public/queries", new
        {
            name = "Test User",
            email = "test@example.com",
            subject = "Test subject",
            // message intentionally omitted
        });
        Assert.Equal(HttpStatusCode.BadRequest, response.StatusCode);
    }

    [Fact]
    public async Task Invalid_Email_Returns_400()
    {
        var response = await _client.PostAsJsonAsync("/api/v1/public/queries", new
        {
            name = "Test User",
            email = "not-an-email",
            subject = "Test subject",
            message = "Test message",
        });
        Assert.Equal(HttpStatusCode.BadRequest, response.StatusCode);
    }

    [Fact]
    public async Task Queries_Are_Throttled_When_The_Owner_Supplies_Thresholds()
    {
        // Owner-supplied thresholds (spec §17/R7, FR-007): 2 permits per
        // 60-second window. The third request in the window must be rejected
        // with 429. Env vars are loaded into builder.Configuration by the
        // default configuration sources during CreateBuilder, so they are
        // visible to the early rate-limit read in Program.Main (see
        // RateLimitTests for the same pattern); they are restored immediately
        // after the test host is built.
        Environment.SetEnvironmentVariable("RateLimiting__Queries__PermitLimit", "2");
        Environment.SetEnvironmentVariable("RateLimiting__Queries__WindowSeconds", "60");
        try
        {
            var factory = _factory.WithWebHostBuilder(_ => { });
            var client = factory.CreateClient();

            // Diagnostic: the derived host must actually see the owner-supplied
            // thresholds (Program.cs gates the limiter on them) — otherwise the
            // 429 below is meaningless.
            using (var scope = factory.Services.CreateScope())
            {
                var config = scope.ServiceProvider.GetRequiredService<IConfiguration>();
                Assert.Equal("2", config["RateLimiting:Queries:PermitLimit"]);
                Assert.Equal("60", config["RateLimiting:Queries:WindowSeconds"]);
            }

            var first = await SubmitAsync(client, "throttled-1");
            var second = await SubmitAsync(client, "throttled-2");
            var third = await SubmitAsync(client, "throttled-3");

            Assert.Equal(HttpStatusCode.Created, first.StatusCode);
            Assert.Equal(HttpStatusCode.Created, second.StatusCode);
            Assert.Equal(HttpStatusCode.TooManyRequests, third.StatusCode);
        }
        finally
        {
            Environment.SetEnvironmentVariable("RateLimiting__Queries__PermitLimit", null);
            Environment.SetEnvironmentVariable("RateLimiting__Queries__WindowSeconds", null);
        }
    }

    private static QueriesRequest ValidRequest() => new()
    {
        Name = "Test User",
        Email = "test@example.com",
        Subject = "Test subject",
        Message = "Test message",
    };

    private static async Task<HttpResponseMessage> SubmitAsync(HttpClient client, string marker)
        => await client.PostAsJsonAsync("/api/v1/public/queries", new QueriesRequest
        {
            Name = $"User {marker}",
            Email = $"{marker}@test.local",
            Subject = "Test subject",
            Message = "Test message",
        });
}