using System.Net;

namespace VisaFusion.FunctionalTests;

/// <summary>
/// Web access-denied page test (SPEC-0005 rigorous-testing pass, web-ui.md §1.2,
/// spec §14).
///
/// The page (T014) is the cookie scheme's configured `AccessDeniedPath` —
/// authenticated-but-unauthorized requests land here. Delivered but never
/// exercised; this test proves it renders.
/// </summary>
public class AccessDeniedPageTests : IClassFixture<VisaFusionWebApplicationFactory>
{
    private readonly HttpClient _client;

    public AccessDeniedPageTests(VisaFusionWebApplicationFactory factory)
    {
        _client = factory.CreateClient();
    }

    [Fact]
    public async Task Get_Renders_The_Access_Denied_Page()
    {
        var response = await _client.GetAsync("/Auth/AccessDenied");

        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
        var html = await response.Content.ReadAsStringAsync();
        Assert.Contains("Access denied", html);
        Assert.Contains("You do not have permission to view this page.", html);
    }
}
