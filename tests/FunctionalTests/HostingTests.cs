using System.Net;
using System.Net.Http;

namespace VisaFusion.FunctionalTests;

/// <summary>
/// Single-process hosting test (SPEC-0003 T024, User Story 2, FR-002).
///
/// Asserts the Web UI and the /api/v1 surface respond from a single hosted
/// process (the VisaFusion.Web host).
/// </summary>
public class HostingTests : IClassFixture<VisaFusionWebApplicationFactory>
{
    private readonly HttpClient _client;

    public HostingTests(VisaFusionWebApplicationFactory factory)
    {
        _client = factory.CreateClient();
    }

    [Fact]
    public async Task Root_Url_Serves_The_Web_UI()
    {
        var response = await _client.GetAsync("/");

        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
        var body = await response.Content.ReadAsStringAsync();
        Assert.Contains("VisaFusion", body);
    }

    [Fact]
    public async Task Api_Health_Endpoint_Responds_From_Same_Host()
    {
        var response = await _client.GetAsync("/api/v1/health");

        // Health is unauthenticated (contracts/api-v1-scaffolding.md); it must
        // respond from the same single process that serves the Web UI.
        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
    }
}