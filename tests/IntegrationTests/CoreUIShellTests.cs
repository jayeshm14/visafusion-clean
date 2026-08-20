using System;
using System.IO;
using System.Linq;
using Xunit;

namespace VisaFusion.IntegrationTests;

/// <summary>
/// CoreUI shell composition tests (SPEC-0009 TS-002/TS-003, FR-003/AC-004,
/// Addendum §6/§12). Verifies the shell renders CoreUI markup with role-aware
/// content: the layout composes the canonical _Sidebar/_PageHeader/_Breadcrumb
/// partials, no per-page SidebarNav sections remain, and the shell CSS/JS
/// assets are present and referenced.
/// </summary>
public class CoreUIShellTests
{
    private readonly string _webRoot = Path.GetFullPath(Path.Combine(AppContext.BaseDirectory, @"..\..\..\..\..\src\VisaFusion.Web\wwwroot"));
    private readonly string _sharedDir = Path.GetFullPath(Path.Combine(AppContext.BaseDirectory, @"..\..\..\..\..\src\VisaFusion.Web\Pages\Shared"));
    private readonly string _projectRoot = Path.GetFullPath(Path.Combine(AppContext.BaseDirectory, @"..\..\..\..\.."));

    [Fact]
    public void Layout_Renders_Sidebar_From_Canonical_Partial()
    {
        var layout = File.ReadAllText(Path.Combine(_sharedDir, "_Layout.cshtml"));

        // The sidebar must come from the canonical partial, not an inlined duplicate.
        Assert.Contains("PartialAsync(\"_Sidebar\"", layout);
        Assert.DoesNotContain("sidebar-nav", layout);
    }

    [Fact]
    public void Layout_Renders_PageHeader_And_Breadcrumb_Partials()
    {
        var layout = File.ReadAllText(Path.Combine(_sharedDir, "_Layout.cshtml"));

        Assert.Contains("PartialAsync(\"_PageHeader\"", layout);
        Assert.Contains("PartialAsync(\"_Header\"", layout);
        Assert.Contains("PartialAsync(\"_Footer\"", layout);
    }

    [Fact]
    public void No_Per_Page_SidebarNav_Sections_Remain()
    {
        // T079: navigation renders only from RoleAwareNavigation (FR-003/NFR-002).
        var cshtmlFiles = Directory.GetFiles(_projectRoot, "*.cshtml", SearchOption.AllDirectories);
        foreach (var file in cshtmlFiles)
        {
            var content = File.ReadAllText(file);
            Assert.False(content.Contains("@section SidebarNav"), $"Per-page SidebarNav section found in {file}");
        }
    }

    [Fact]
    public void Sidebar_Partial_Has_No_RenderSection()
    {
        var sidebar = File.ReadAllText(Path.Combine(_sharedDir, "_Sidebar.cshtml"));
        Assert.DoesNotContain("RenderSectionAsync", sidebar);
    }

    [Fact]
    public void Shell_Css_Classes_Are_Defined_In_Component_Stylesheet()
    {
        var css = File.ReadAllText(Path.Combine(_webRoot, @"css\vf-component-styles.css"));

        foreach (var selector in new[] { ".vf-shell", ".vf-main", ".vf-content", ".vf-skip-link", ".page-header" })
        {
            Assert.Contains(selector, css);
        }
    }

    [Fact]
    public void Shell_Assets_Are_Referenced_And_Present()
    {
        var layout = File.ReadAllText(Path.Combine(_sharedDir, "_Layout.cshtml"));

        foreach (var asset in new[]
        {
            @"lib\coreui\vendors\coreui.min.css",
            @"lib\coreui\vendors\simplebar.min.css",
            @"css\vf-coreui.css",
            @"css\vf-component-styles.css",
            @"lib\coreui\vendors\coreui.bundle.min.js",
            @"lib\coreui\vendors\simplebar.min.js",
            @"js\vf-coreui.js",
        })
        {
            var url = asset.Replace('\\', '/');
            Assert.Contains(url, layout);
            Assert.True(File.Exists(Path.Combine(_webRoot, asset)), $"Shell asset missing: {asset}");
        }
    }

    [Fact]
    public void Legacy_Theme_Assets_Are_Removed()
    {
        // T077: tokens.css/theme.css deleted; no layout may reference them.
        Assert.False(File.Exists(Path.Combine(_webRoot, @"css\tokens.css")), "tokens.css should be removed");
        Assert.False(File.Exists(Path.Combine(_webRoot, @"css\theme.css")), "theme.css should be removed");

        foreach (var layout in new[] { "_Layout.cshtml", "_AuthLayout.cshtml" })
        {
            var content = File.ReadAllText(Path.Combine(_sharedDir, layout));
            Assert.DoesNotContain("tokens.css", content);
            Assert.DoesNotContain("theme.css", content);
        }
    }

    [Fact]
    public void Shell_Is_Selected_By_UseSidebar_Flag()
    {
        var layout = File.ReadAllText(Path.Combine(_sharedDir, "_Layout.cshtml"));

        // Authenticated pages default to the sidebar shell; public/auth pages
        // opt in via ViewData["UseSidebar"] (SPEC-0007 T009, R-003).
        Assert.Contains("ViewData[\"UseSidebar\"]", layout);
        Assert.Contains("vf-skip-link", layout);
    }
}