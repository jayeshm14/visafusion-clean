using System.Net.Http;
using System.Threading.Tasks;
using Xunit;

namespace VisaFusion.FunctionalTests;

/// <summary>
/// CoreUI Responsive Behavior Tests (T055, SPEC-0009 Phase 22).
///
/// Validates responsive breakpoint patterns across all migrated surfaces:
/// - Table horizontal scroll (.table-responsive)
/// - Card stacking (col-sm-6 → col-xl-3)
/// - Sidebar collapse/unfoldable narrow mode
/// - Mobile close button (d-lg-none)
/// - Header username hidden on mobile (d-none d-md-inline)
/// - Sidebar collapse text hidden on mobile (d-none d-lg-inline)
/// - Brand narrow/full variants for unfoldable mode
/// - Flex shell layout (sidebar + main column)
///
/// Source evidence: spec.md AC-012, TS-006; COREUI_DESIGN_SYSTEM.md §6;
/// validation checklist CHK052.
/// </summary>
public class CoreUIResponsiveTests : IClassFixture<VisaFusionWebApplicationFactory>
{
    private readonly VisaFusionWebApplicationFactory _factory;
    private readonly HttpClient _client;

    public CoreUIResponsiveTests(VisaFusionWebApplicationFactory factory)
    {
        _factory = factory;
        _client = factory.CreateClient();
    }

    private static string GetSourceRoot() =>
        System.IO.Path.GetFullPath(
            System.IO.Path.Combine(System.AppContext.BaseDirectory, "..", "..", "..", "..", ".."));

    private static string ReadTemplate(string relativePath)
    {
        var path = System.IO.Path.Combine(GetSourceRoot(), relativePath);
        return System.IO.File.ReadAllText(path);
    }

    // ─── Layout Shell Responsive Structure ────────────────────────────

    [Fact]
    public async Task Layout_Has_Viewport_Meta_Tag()
    {
        var response = await _client.GetAsync("/");
        var content = await response.Content.ReadAsStringAsync();

        Assert.Contains("viewport", content, System.StringComparison.OrdinalIgnoreCase);
        Assert.Contains("width=device-width", content);
        Assert.Contains("initial-scale=1", content);
    }

    [Fact]
    public void Sidebar_Template_Has_Sidebar_Fixed_Class()
    {
        // Unauthenticated "/" renders the top-nav shell (no sidebar).
        // Verify the sidebar template directly for the sidebar-fixed class.
        var template = ReadTemplate("src/VisaFusion.Web/Pages/Shared/_Sidebar.cshtml");

        Assert.Contains("sidebar-fixed", template);
    }

    [Fact]
    public void Sidebar_Template_Has_Unfoldable_Toggler()
    {
        var template = ReadTemplate("src/VisaFusion.Web/Pages/Shared/_Sidebar.cshtml");

        Assert.Contains("data-coreui-toggle=\"unfoldable\"", template);
    }

    [Fact]
    public void Sidebar_Template_Mobile_Close_Button_Has_D_Lg_None()
    {
        var template = ReadTemplate("src/VisaFusion.Web/Pages/Shared/_Sidebar.cshtml");

        Assert.Contains("d-lg-none", template);
    }

    [Fact]
    public void Sidebar_Template_Nav_Has_Data_Coreui_Navigation()
    {
        var template = ReadTemplate("src/VisaFusion.Web/Pages/Shared/_Sidebar.cshtml");

        Assert.Contains("data-coreui=\"navigation\"", template);
    }

    // ─── Header Responsive Patterns ───────────────────────────────────

    [Fact]
    public void Header_Template_Has_Container_Fluid()
    {
        var template = ReadTemplate("src/VisaFusion.Web/Pages/Shared/_Header.cshtml");

        Assert.Contains("container-fluid", template);
    }

    [Fact]
    public void Header_Template_Username_Hidden_On_Mobile()
    {
        var template = ReadTemplate("src/VisaFusion.Web/Pages/Shared/_Header.cshtml");

        Assert.Contains("d-none d-md-inline", template);
    }

    // ─── DataTable Component Template Verification ────────────────────

    [Fact]
    public void DataTable_Template_Supports_Table_Responsive_Wrapper()
    {
        var template = ReadTemplate("src/VisaFusion.Web/Components/_DataTable.cshtml");

        Assert.Contains("table-responsive", template);
        Assert.Contains("responsiveOpen", template);
        Assert.Contains("responsiveClose", template);
    }

    [Fact]
    public void DataTable_Template_Supports_Pagination()
    {
        var template = ReadTemplate("src/VisaFusion.Web/Components/_DataTable.cshtml");

        Assert.Contains("pagination", template);
        Assert.Contains("pagination-sm", template);
        Assert.Contains("page-link", template);
    }

    [Fact]
    public void DataTable_Template_Supports_Search_Input()
    {
        var template = ReadTemplate("src/VisaFusion.Web/Components/_DataTable.cshtml");

        Assert.Contains("input-group", template);
        Assert.Contains("data-table-search", template);
    }

    // ─── RoleDashboard Card Stacking (col-sm-6 → col-xl-3) ───────────

    [Fact]
    public void RoleDashboard_KPI_Cards_Use_Col_Sm6_Col_Xl3()
    {
        var template = ReadTemplate("src/VisaFusion.Web/Components/_RoleDashboard.cshtml");

        Assert.Contains("col-sm-6 col-xl-3", template);
    }

    [Fact]
    public void RoleDashboard_Charts_Use_Col_Lg6()
    {
        var template = ReadTemplate("src/VisaFusion.Web/Components/_RoleDashboard.cshtml");

        Assert.Contains("col-lg-6", template);
    }

    [Fact]
    public void RoleDashboard_Tables_Wrapped_In_Table_Responsive()
    {
        var template = ReadTemplate("src/VisaFusion.Web/Components/_RoleDashboard.cshtml");

        Assert.Contains("table-responsive", template);
    }

    // ─── Sidebar Responsive Patterns ──────────────────────────────────

    [Fact]
    public void Sidebar_Footer_Toggler_Has_DNone_DlgInline()
    {
        var template = ReadTemplate("src/VisaFusion.Web/Pages/Shared/_Sidebar.cshtml");

        Assert.Contains("d-none d-lg-inline", template);
    }

    [Fact]
    public void Sidebar_Brand_Has_Narrow_And_Full_Variants()
    {
        var template = ReadTemplate("src/VisaFusion.Web/Pages/Shared/_Sidebar.cshtml");

        Assert.Contains("sidebar-brand-full", template);
        Assert.Contains("sidebar-brand-narrow", template);
    }

    [Fact]
    public void Header_Brand_Has_Narrow_And_Full_Variants()
    {
        var template = ReadTemplate("src/VisaFusion.Web/Pages/Shared/_Header.cshtml");

        Assert.Contains("header-brand-full", template);
        Assert.Contains("header-brand-narrow", template);
    }

    // ─── Component Styles Responsive Shell ─────────────────────────────

    [Fact]
    public void ComponentStyles_Has_Shell_Flex_Layout()
    {
        var css = ReadTemplate("src/VisaFusion.Web/wwwroot/css/vf-component-styles.css");

        Assert.Contains(".vf-shell", css);
        Assert.Contains("display: flex", css);
        Assert.Contains(".vf-main", css);
    }

    [Fact]
    public void ComponentStyles_Has_Skip_Link()
    {
        var css = ReadTemplate("src/VisaFusion.Web/wwwroot/css/vf-component-styles.css");

        Assert.Contains(".vf-skip-link", css);
        Assert.Contains("left: -9999px", css);
    }

    [Fact]
    public void ComponentStyles_Has_Content_Padding()
    {
        var css = ReadTemplate("src/VisaFusion.Web/wwwroot/css/vf-component-styles.css");

        Assert.Contains(".vf-content", css);
        Assert.Contains("padding:", css);
    }
}
