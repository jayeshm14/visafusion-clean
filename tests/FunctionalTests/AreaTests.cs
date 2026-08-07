using System.Net;
using System.Net.Http;

namespace VisaFusion.FunctionalTests;

/// <summary>
/// Web Areas test (SPEC-0003 T025, User Story 2, FR-005).
///
/// Asserts all eight Razor Pages Areas resolve to their default pages from the
/// single hosted process.
/// </summary>
public class AreaTests : IClassFixture<VisaFusionWebApplicationFactory>
{
    private static readonly string[] Areas =
    {
        "Public", "Auth", "Employee", "Agent", "Admin", "Billing", "Reporting", "Notifications",
    };

    private readonly HttpClient _client;

    public AreaTests(VisaFusionWebApplicationFactory factory)
    {
        _client = factory.CreateClient();
    }

    [Theory]
    [MemberData(nameof(AreaRoutes))]
    public async Task Area_Resolves_To_Its_Default_Page(string area)
    {
        var response = await _client.GetAsync($"/{area}");

        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
        var body = await response.Content.ReadAsStringAsync();
        Assert.Contains(area, body, StringComparison.OrdinalIgnoreCase);
    }

    public static IEnumerable<object[]> AreaRoutes() => Areas.Select(a => new object[] { a });
}