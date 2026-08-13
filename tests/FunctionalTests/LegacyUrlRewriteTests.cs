using System.Net;
using System.Net.Http.Headers;
using Microsoft.AspNetCore.Mvc.Testing;

namespace VisaFusion.FunctionalTests;

/// <summary>
/// Legacy URL rewrite functional tests (SPEC-0005 T033, US5, AC-007/TS-007,
/// FR-003; contracts/web-ui.md §2).
///
/// The legacy Classic ASP entry URLs must keep working after cutover: each
/// documented entry page 301-redirects to its modern counterpart, and any
/// other legacy `.asp` URL gets a clear 404 (NFR-005 — no wildcard forwarding
/// to an unrelated page). Redirects are asserted with auto-redirect disabled
/// so the 301 + Location header are observable.
/// </summary>
public class LegacyUrlRewriteTests : IClassFixture<VisaFusionWebApplicationFactory>
{
    private readonly HttpClient _client;

    public LegacyUrlRewriteTests(VisaFusionWebApplicationFactory factory)
    {
        _client = factory.CreateClient(new WebApplicationFactoryClientOptions
        {
            AllowAutoRedirect = false,
        });
    }

    [Theory]
    [InlineData("/Default.asp", "/")]
    [InlineData("/authenticate.asp", "/Auth/Login")]
    [InlineData("/logon.asp", "/Auth/Login")]
    [InlineData("/regsub.asp", "/Auth/Register")]
    [InlineData("/regsubmit.asp", "/Auth/Register")]
    [InlineData("/regsubdone.asp", "/Auth/Register")]
    public async Task Legacy_Entry_Url_Redirects_To_Its_Modern_Target(string legacyPath, string expectedTarget)
    {
        var response = await _client.GetAsync(legacyPath);

        Assert.Equal(HttpStatusCode.MovedPermanently, response.StatusCode);
        Assert.Equal(expectedTarget, response.Headers.Location?.OriginalString);
    }

    [Theory]
    [InlineData("/unknownLegacyPage.asp")]
    [InlineData("/some/deep/path/page.asp")]
    public async Task Unknown_Legacy_Asp_Url_Returns_Clear_404(string legacyPath)
    {
        // NFR-005: unknown legacy URLs must 404 explicitly — never a silent
        // redirect to an unrelated page.
        var response = await _client.GetAsync(legacyPath);

        Assert.Equal(HttpStatusCode.NotFound, response.StatusCode);
    }

    [Fact]
    public async Task Modern_Routes_Are_Not_Affected_By_The_Rewrite()
    {
        var response = await _client.GetAsync("/api/v1/health");

        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
        Assert.Equal("application/json", response.Content.Headers.ContentType?.MediaType);
    }
}