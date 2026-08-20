using System;
using System.IO;
using System.Linq;
using Xunit;

namespace VisaFusion.IntegrationTests;

/// <summary>
/// CoreUI visual-validation tests (SPEC-0009 TS-012, AC-016, Addendum §17).
/// Verifies the role-based visual surface is complete for every role
/// (guest/agt/emp/adm/su): landing pages render the RoleDashboard component
/// with the correct title, the shell partials exist, the auth pages use the
/// auth layout, and the ROLE_*_MATRIX documentation is present.
/// </summary>
public class CoreUIVisualTests
{
    private readonly string _projectRoot = Path.GetFullPath(Path.Combine(AppContext.BaseDirectory, @"..\..\..\..\.."));
    private readonly string _webRoot = Path.GetFullPath(Path.Combine(AppContext.BaseDirectory, @"..\..\..\..\..\src\VisaFusion.Web"));

    [Fact]
    public void Role_Landing_Pages_Render_RoleDashboard_With_Correct_Title()
    {
        // Addendum §17: each role's landing page must render the dashboard
        // component with its role-appropriate title.
        var cases = new[]
        {
            (@"src\VisaFusion.Web\Areas\Agent\Pages\Index.cshtml", "Agent Portal"),
            (@"src\VisaFusion.Web\Areas\Reporting\Pages\Index.cshtml", "Operational Reports"),
            (@"src\VisaFusion.Web\Areas\Admin\Pages\Index.cshtml", "Admin Area"),
        };

        foreach (var (relative, title) in cases)
        {
            var content = File.ReadAllText(Path.Combine(_projectRoot, relative));
            Assert.Contains("_RoleDashboard", content);
            Assert.Contains(title, content);
        }
    }

    [Fact]
    public void Shell_Partials_Exist_For_Every_Role_Surface()
    {
        // Addendum §17: header, sidebar, footer, page header, breadcrumb.
        foreach (var partial in new[] { "_Header.cshtml", "_Sidebar.cshtml", "_Footer.cshtml", "_PageHeader.cshtml", "_Breadcrumb.cshtml" })
        {
            Assert.True(File.Exists(Path.Combine(_webRoot, @"Pages\Shared", partial)), $"Shell partial missing: {partial}");
        }
    }

    [Fact]
    public void Auth_Pages_Use_The_Auth_Layout()
    {
        // Addendum §17: login/register/change-password render the centered
        // auth card layout, not the sidebar shell.
        foreach (var page in new[] { "Login.cshtml", "Register.cshtml", "ChangePassword.cshtml", "AccessDenied.cshtml" })
        {
            var path = Path.Combine(_webRoot, @"Pages\Auth", page);
            Assert.True(File.Exists(path), $"Auth page missing: {page}");
            var content = File.ReadAllText(path);
            Assert.Contains("_AuthLayout", content);
        }
    }

    [Fact]
    public void Error_Page_Exists_For_Unauthorized_And_Error_Surfaces()
    {
        // Addendum §17: unauthorized (403) and error (500) surfaces exist.
        Assert.True(File.Exists(Path.Combine(_webRoot, @"Pages\Auth\AccessDenied.cshtml")), "AccessDenied page missing");
        Assert.True(File.Exists(Path.Combine(_webRoot, @"Pages\Error.cshtml")), "Error page missing");
    }

    [Fact]
    public void Role_Matrices_Documentation_Is_Present()
    {
        // Addendum §16/§17: the role-based matrices are the visual-validation
        // source of truth.
        foreach (var doc in new[]
        {
            "ROLE_NAVIGATION_MATRIX.md",
            "ROLE_ROUTE_MATRIX.md",
            "ROLE_PAGE_PERMISSION_MATRIX.md",
            "ROLE_BASED_NATIVE_PAGES_INVENTORY.md",
            "COREUI_VISA_FUSION_MAPPING.md",
        })
        {
            Assert.True(File.Exists(Path.Combine(_projectRoot, @"docs\ui", doc)), $"Role matrix doc missing: {doc}");
        }
    }

    [Fact]
    public void Public_Landing_Renders_PublicLanding_Component()
    {
        // Guest surface: the root landing renders the PublicLanding component.
        var rootIndex = File.ReadAllText(Path.Combine(_webRoot, @"Pages\Index.cshtml"));
        Assert.Contains("_PublicLanding", rootIndex);
    }

    [Fact]
    public void Logout_Surface_Exists()
    {
        // Addendum §17: logout is part of every authenticated role's surface.
        Assert.True(File.Exists(Path.Combine(_webRoot, @"Pages\Auth\Logout.cshtml")), "Logout page missing");
    }
}