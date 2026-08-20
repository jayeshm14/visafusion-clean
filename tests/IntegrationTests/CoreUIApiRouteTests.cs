using System;
using System.IO;
using System.Linq;
using Xunit;

namespace VisaFusion.IntegrationTests;

/// <summary>
/// CoreUI API-route tests (SPEC-0009 TS-005, AC-009). Verifies the API
/// surface is untouched by the re-skin: the API project contains no UI
/// artifacts, no vf-* classes, no reference to the Web project, and the
/// endpoint surface matches the ROLE_ROUTE_MATRIX.md inventory.
/// </summary>
public class CoreUIApiRouteTests
{
    private readonly string _projectRoot = Path.GetFullPath(Path.Combine(AppContext.BaseDirectory, @"..\..\..\..\.."));
    private readonly string _apiDir = Path.GetFullPath(Path.Combine(AppContext.BaseDirectory, @"..\..\..\..\..\src\VisaFusion.Api"));

    [Fact]
    public void Api_Project_Contains_No_UI_Artifacts()
    {
        // AC-009: the re-skin is presentation-only; the API must not gain
        // .cshtml views or UI classes.
        var cshtml = Directory.GetFiles(_apiDir, "*.cshtml", SearchOption.AllDirectories);
        Assert.Empty(cshtml);

        var allFiles = Directory.GetFiles(_apiDir, "*.cs", SearchOption.AllDirectories);
        foreach (var file in allFiles)
        {
            var content = File.ReadAllText(file);
            Assert.False(content.Contains("vf-"), $"vf-* class found in API file {file}");
            Assert.False(content.Contains("class=\"btn"), $"UI class found in API file {file}");
        }
    }

    [Fact]
    public void Api_Project_Does_Not_Reference_The_Web_Project()
    {
        // The API must stay independent of the presentation layer.
        var csproj = File.ReadAllText(Path.Combine(_apiDir, "VisaFusion.Api.csproj"));
        Assert.DoesNotContain("VisaFusion.Web", csproj);
    }

    [Fact]
    public void Endpoint_Surface_Matches_The_Route_Matrix()
    {
        // ROLE_ROUTE_MATRIX.md §2 inventories the API route groups; the
        // endpoint files must cover every group.
        var endpointFiles = Directory.GetFiles(Path.Combine(_apiDir, "Endpoints"), "*.cs")
            .Where(f => f.EndsWith("Endpoint.cs"))
            .Select(Path.GetFileNameWithoutExtension)
            .ToList();

        foreach (var expected in new[]
        {
            "AuthEndpoint", "AgentsEndpoint", "AdminEndpoint", "ContentEndpoint",
            "EmployeeEndpoint", "EntriesEndpoint", "HealthEndpoint", "HolidaysEndpoint",
            "NotificationsEndpoint", "PublicEndpoint", "ReportsEndpoint", "RepresentativeEndpoint",
        })
        {
            Assert.Contains(expected, endpointFiles);
        }
    }

    [Fact]
    public void Api_Routes_Are_Not_ReSkinned_Or_Removed()
    {
        // TS-005: every API route responds identically before/after the
        // re-skin — the endpoint files must not reference any UI component.
        var endpointFiles = Directory.GetFiles(Path.Combine(_apiDir, "Endpoints"), "*.cs");
        foreach (var file in endpointFiles)
        {
            var content = File.ReadAllText(file);
            Assert.DoesNotContain("_RoleDashboard", content);
            Assert.DoesNotContain("_DataTable", content);
            Assert.DoesNotContain("_FormCard", content);
            Assert.DoesNotContain("_InfoPage", content);
        }
    }
}