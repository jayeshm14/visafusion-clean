using System.Security.Claims;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc.ModelBinding;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.AspNetCore.Mvc.ViewFeatures;
using Microsoft.AspNetCore.Routing;
using VisaFusion.Web.Services;

namespace VisaFusion.UnitTests;

/// <summary>
/// BreadcrumbService tests (SPEC-0009 review fix 2026-08-20).
///
/// The service derives breadcrumbs from the RoleAwareNavigation hierarchy
/// (Role → Module → Feature → Page), not from URL segments. Regression
/// coverage for the "#"-route bug: a submenu parent (Route = "#") previously
/// matched every page path — "#".TrimEnd('#') is "" and
/// pagePath.StartsWith("") is always true — so the first #-routed menu in the
/// first visible group shadowed all other pages (e.g. an adm user on
/// /Admin/Agents/List got "Reporting > Today" instead of "Admin > Agents >
/// List").
/// </summary>
public class BreadcrumbServiceTests
{
    private static BreadcrumbService CreateService() => new(new RoleAwareNavigation());

    private static ViewContext CreateViewContext(string path, string role)
    {
        var httpContext = new DefaultHttpContext();
        httpContext.User = new ClaimsPrincipal(new ClaimsIdentity(
            new[] { new Claim(ClaimTypes.Role, role) }, "test"));
        httpContext.Request.Path = path;

        return new ViewContext
        {
            HttpContext = httpContext,
            RouteData = new RouteData(),
            ViewData = new ViewDataDictionary(new EmptyModelMetadataProvider(), new ModelStateDictionary()),
        };
    }

    [Fact]
    public void Submenu_Page_Under_Hash_Routed_Menu_Resolves_To_Its_Submenu()
    {
        var service = CreateService();
        var breadcrumbs = service.GetBreadcrumbs(CreateViewContext("/Reporting/TodaySubmission", "emp"));

        Assert.Equal(new[] { "emp", "Reporting", "Today", "Submission" }, breadcrumbs.Select(b => b.Title));
        Assert.True(breadcrumbs.Last().IsCurrent);
    }

    [Fact]
    public void Admin_Submenu_Page_Is_Not_Shadowed_By_Reporting_Hash_Menu()
    {
        // Regression: the Reporting group is visible to adm and its "Today"
        // menu (Route = "#") used to match every path before the Admin group
        // was reached.
        var service = CreateService();
        var breadcrumbs = service.GetBreadcrumbs(CreateViewContext("/Admin/Agents/List", "adm"));

        Assert.Equal(new[] { "adm", "Admin", "Agents", "List" }, breadcrumbs.Select(b => b.Title));
        Assert.True(breadcrumbs.Last().IsCurrent);
    }

    [Fact]
    public void Leaf_Menu_Page_Resolves_To_The_Menu_Itself()
    {
        var service = CreateService();
        var breadcrumbs = service.GetBreadcrumbs(CreateViewContext("/Reporting/Pending", "emp"));

        Assert.Equal(new[] { "emp", "Reporting", "Pending" }, breadcrumbs.Select(b => b.Title));
        Assert.True(breadcrumbs.Last().IsCurrent);
    }

    [Fact]
    public void Unknown_Page_Falls_Back_To_The_Page_Title()
    {
        var service = CreateService();
        var viewContext = CreateViewContext("/Some/Unknown", "adm");
        viewContext.ViewData["Title"] = "Unknown Page";

        var breadcrumbs = service.GetBreadcrumbs(viewContext);

        Assert.Equal(new[] { "Unknown Page" }, breadcrumbs.Select(b => b.Title));
        Assert.True(breadcrumbs.Single().IsCurrent);
    }
}