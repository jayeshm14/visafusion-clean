using System.Net;
using System.Net.Http.Json;
using Microsoft.AspNetCore.Mvc.Testing;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using VisaFusion.Api.Contracts;
using VisaFusion.Web;

namespace VisaFusion.FunctionalTests;

/// <summary>
/// Public-write rate-limiting tests (SPEC-0005 rigorous-testing pass, spec §17,
/// Risk R7, FR-012).
///
/// The register/queries limiters are configuration-driven ONLY — no threshold
/// is hard-coded or invented (the owner supplies the values before go-live).
/// These tests prove both sides of that contract:
///   - with NO `RateLimiting:*` configuration the register route is NOT
///     throttled (the limiter is not even registered — Program.cs gates
///     AddRateLimiter/UseRateLimiter on the config),
///   - when the owner supplies thresholds, the fixed-window limiter rejects
///     the excess request with 429 (RejectionStatusCode).
/// </summary>
public class RateLimitTests : IClassFixture<VisaFusionWebApplicationFactory>
{
    private readonly VisaFusionWebApplicationFactory _factory;
    private readonly HttpClient _client;

    public RateLimitTests(VisaFusionWebApplicationFactory factory)
    {
        _factory = factory;
        _client = factory.CreateClient();
    }

    [Fact]
    public async Task Register_Is_Not_Throttled_Without_RateLimiting_Configuration()
    {
        // The base factory's configuration has no RateLimiting:* values, so no
        // limiter is registered and every request succeeds (201).
        for (var i = 0; i < 5; i++)
        {
            var userName = $"nothrottled-{Guid.NewGuid():N}";
            var response = await _client.PostAsJsonAsync("/api/v1/public/register", new RegisterRequest
            {
                UserName = userName,
                Email = $"{userName}@test.local",
                Password = "TestPass123!",
            });

            Assert.Equal(HttpStatusCode.Created, response.StatusCode);
        }
    }

    [Fact]
    public async Task Register_Is_Throttled_When_The_Owner_Supplies_Thresholds()
    {
        // Owner-supplied thresholds (spec §17/R7): 2 permits per 60-second
        // window. The third request in the window must be rejected with 429.
        //
        // Program.Main reads the rate-limit keys from builder.Configuration
        // BEFORE builder.Build(), and WebApplicationFactory's
        // ConfigureAppConfiguration / UseSetting are only applied to the final
        // configuration at Build time — too late for that read. Environment
        // variables are loaded into builder.Configuration by the default
        // configuration sources during CreateBuilder, so they are visible to
        // the early read. They are restored immediately after the test host is
        // built (no other test reads RateLimiting:*).
        Environment.SetEnvironmentVariable("RateLimiting__Register__PermitLimit", "2");
        Environment.SetEnvironmentVariable("RateLimiting__Register__WindowSeconds", "60");
        try
        {
            // The host is built lazily on the first CreateClient()/Services
            // access, so the variables must stay set until then.
            var factory = _factory.WithWebHostBuilder(_ => { });
            var client = factory.CreateClient();

            // Diagnostic: the derived host must actually see the owner-supplied
            // thresholds (Program.cs gates AddRateLimiter/UseRateLimiter on
            // them) — otherwise the 429 below is meaningless.
            using (var scope = factory.Services.CreateScope())
            {
                var config = scope.ServiceProvider.GetRequiredService<IConfiguration>();
                Assert.Equal("2", config["RateLimiting:Register:PermitLimit"]);
                Assert.Equal("60", config["RateLimiting:Register:WindowSeconds"]);
            }

            var first = await RegisterAsync(client, "throttled-1");
            var second = await RegisterAsync(client, "throttled-2");
            var third = await RegisterAsync(client, "throttled-3");

            Assert.Equal(HttpStatusCode.Created, first.StatusCode);
            Assert.Equal(HttpStatusCode.Created, second.StatusCode);
            Assert.Equal(HttpStatusCode.TooManyRequests, third.StatusCode);
        }
        finally
        {
            Environment.SetEnvironmentVariable("RateLimiting__Register__PermitLimit", null);
            Environment.SetEnvironmentVariable("RateLimiting__Register__WindowSeconds", null);
        }
    }

    private static async Task<HttpResponseMessage> RegisterAsync(HttpClient client, string userName)
        => await client.PostAsJsonAsync("/api/v1/public/register", new RegisterRequest
        {
            UserName = userName,
            Email = $"{userName}@test.local",
            Password = "TestPass123!",
        });
}