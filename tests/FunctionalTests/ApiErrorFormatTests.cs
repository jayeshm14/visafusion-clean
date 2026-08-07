using System.Net;
using System.Net.Http;
using System.Net.Http.Json;

namespace VisaFusion.FunctionalTests;

/// <summary>
/// Api error-format contract test (SPEC-0003 T042,
/// contracts/api-v1-scaffolding.md "Error Format").
///
/// Asserts the standardized problem-details JSON shape for 401/403 responses.
/// </summary>
public class ApiErrorFormatTests : IClassFixture<VisaFusionWebApplicationFactory>
{
    private readonly HttpClient _client;

    public ApiErrorFormatTests(VisaFusionWebApplicationFactory factory)
    {
        _client = factory.CreateClient();
    }

    [Fact]
    public async Task Unauthorized_Returns_Problem_Details_Shape()
    {
        var response = await _client.GetAsync("/api/v1/employee");

        Assert.Equal(HttpStatusCode.Unauthorized, response.StatusCode);
        Assert.Equal("application/problem+json", response.Content.Headers.ContentType?.MediaType);

        var problem = await response.Content.ReadFromJsonAsync<ProblemDetailsResponse>();
        Assert.NotNull(problem);
        Assert.Equal(401, problem.Status);
        Assert.False(string.IsNullOrWhiteSpace(problem.Title));
    }

    private sealed class ProblemDetailsResponse
    {
        public string? Type { get; set; }
        public string? Title { get; set; }
        public int Status { get; set; }
        public string? TraceId { get; set; }
    }
}