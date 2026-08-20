using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using Xunit;

namespace VisaFusion.FunctionalTests;

/// <summary>
/// CoreUI error page tests (SPEC-0009 T031 / Phase 13).
///
/// Proves the ErrorPage component surface:
/// - /Error/500 renders the component with the trace id and a 500 status;
/// - /Error/404 renders the component with a 404 status;
/// - an unmatched route re-executes to the error page and keeps the 404
///   status (UseStatusCodePages, Program.cs).
///
/// Error semantics are unchanged (status codes preserved; API responses keep
/// their problem-details contract — covered by ApiErrorFormatTests).
/// </summary>
public class ErrorPageTests : IClassFixture<VisaFusionWebApplicationFactory>
{
    private readonly HttpClient _client;

    public ErrorPageTests(VisaFusionWebApplicationFactory factory)
    {
        _client = factory.CreateClient();
    }

    [Fact]
    public async Task Get_Error500_Renders_Component_With_500_Status_And_TraceId()
    {
        var response = await _client.GetAsync("/Error/500");

        Assert.Equal(HttpStatusCode.InternalServerError, response.StatusCode);
        var html = await response.Content.ReadAsStringAsync();
        Assert.Contains("Something went wrong", html);
        // The trace id disclosure (ShowDetails, set by ErrorModel).
        Assert.Contains("Show technical details", html);
    }

    [Fact]
    public async Task Get_Error404_Renders_Component_With_404_Status()
    {
        var response = await _client.GetAsync("/Error/404");

        Assert.Equal(HttpStatusCode.NotFound, response.StatusCode);
        var html = await response.Content.ReadAsStringAsync();
        Assert.Contains("Page Not Found", html);
    }

    [Fact]
    public async Task Unmatched_Route_ReExecutes_To_Error_Page_Keeping_404()
    {
        var response = await _client.GetAsync("/this-route-does-not-exist");

        Assert.Equal(HttpStatusCode.NotFound, response.StatusCode);
        var html = await response.Content.ReadAsStringAsync();
        Assert.Contains("Page Not Found", html);
    }
}