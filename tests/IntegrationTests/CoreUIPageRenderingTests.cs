using System;
using System.IO;
using System.Linq;
using Xunit;

namespace VisaFusion.IntegrationTests;

/// <summary>
/// CoreUI page-rendering tests (SPEC-0009 TS-006, FR-004/AC-005). Verifies
/// every native page in COREUI_VISA_FUSION_MAPPING.md renders with its mapped
/// CoreUI presentation and preserved functional composition: no legacy vf-*
/// classes remain in the areas, no per-page SidebarNav sections remain, and
/// the re-skinned pages use the mapped components/classes.
/// </summary>
public class CoreUIPageRenderingTests
{
    private readonly string _webRoot = Path.GetFullPath(Path.Combine(AppContext.BaseDirectory, @"..\..\..\..\..\src\VisaFusion.Web\wwwroot"));
    private readonly string _projectRoot = Path.GetFullPath(Path.Combine(AppContext.BaseDirectory, @"..\..\..\..\.."));

    [Fact]
    public void No_Legacy_Vf_Classes_Remain_In_Area_Pages()
    {
        // T078: every native page re-skinned onto CoreUI classes.
        var areaPages = Directory.GetFiles(Path.Combine(_projectRoot, @"src\VisaFusion.Web\Areas"), "*.cshtml", SearchOption.AllDirectories);
        Assert.NotEmpty(areaPages);

        foreach (var file in areaPages)
        {
            var content = File.ReadAllText(file);
            Assert.False(content.Contains("vf-"), $"Legacy vf-* class found in {file}");
        }
    }

    [Fact]
    public void No_Per_Page_SidebarNav_Sections_Remain()
    {
        // T079: navigation renders only from RoleAwareNavigation.
        var cshtmlFiles = Directory.GetFiles(_projectRoot, "*.cshtml", SearchOption.AllDirectories);
        foreach (var file in cshtmlFiles)
        {
            var content = File.ReadAllText(file);
            Assert.False(content.Contains("@section SidebarNav"), $"Per-page SidebarNav section found in {file}");
        }
    }

    [Fact]
    public void ReSkinned_Pages_Use_CoreUI_Table_And_Card_Classes()
    {
        // The 22 re-skinned pages must use CoreUI table/card/button classes.
        var reSkinned = new[]
        {
            @"src\VisaFusion.Web\Areas\Reporting\Pages\Pending.cshtml",
            @"src\VisaFusion.Web\Areas\Reporting\Pages\TodaySubmission.cshtml",
            @"src\VisaFusion.Web\Areas\Reporting\Pages\TodayCollection.cshtml",
            @"src\VisaFusion.Web\Areas\Reporting\Pages\TodayTransaction.cshtml",
            @"src\VisaFusion.Web\Areas\Reporting\Pages\DailyVisaFee.cshtml",
            @"src\VisaFusion.Web\Areas\Reporting\Pages\DailyBill.cshtml",
            @"src\VisaFusion.Web\Areas\Agent\Pages\Entries.cshtml",
            @"src\VisaFusion.Web\Areas\Agent\Pages\Statuses.cshtml",
            @"src\VisaFusion.Web\Areas\Agent\Pages\Statement.cshtml",
            @"src\VisaFusion.Web\Areas\Agent\Pages\Account.cshtml",
            @"src\VisaFusion.Web\Areas\Admin\Pages\Agents\List.cshtml",
            @"src\VisaFusion.Web\Areas\Admin\Pages\Agents\Create.cshtml",
            @"src\VisaFusion.Web\Areas\Admin\Pages\Agents\Detail.cshtml",
            @"src\VisaFusion.Web\Areas\Admin\Pages\Agents\Edit.cshtml",
            @"src\VisaFusion.Web\Areas\Admin\Pages\Users\List.cshtml",
            @"src\VisaFusion.Web\Areas\Admin\Pages\Users\Create.cshtml",
            @"src\VisaFusion.Web\Areas\Admin\Pages\Holidays\Index.cshtml",
            @"src\VisaFusion.Web\Areas\Admin\Pages\ContentUpdate\Index.cshtml",
            @"src\VisaFusion.Web\Areas\Admin\Pages\SecurityDay\Index.cshtml",
            @"src\VisaFusion.Web\Areas\Public\Pages\DailyUpdate.cshtml",
            @"src\VisaFusion.Web\Areas\Public\Pages\Queries.cshtml",
            @"src\VisaFusion.Web\Areas\Notifications\Pages\Index.cshtml",
        };

        foreach (var relative in reSkinned)
        {
            var path = Path.Combine(_projectRoot, relative);
            Assert.True(File.Exists(path), $"Re-skinned page missing: {relative}");
            var content = File.ReadAllText(path);

            // Component-based pages carry the presentation in the component
            // partial; direct pages must carry CoreUI presentation classes.
            if (content.Contains("_PublicQueryForm") || content.Contains("_InfoPage") || content.Contains("_DataTable") || content.Contains("_FormCard"))
            {
                continue;
            }

            Assert.True(
                content.Contains("card") || content.Contains("btn ") || content.Contains("alert "),
                $"No CoreUI presentation classes found in {relative}");
        }
    }

    [Fact]
    public void Landing_Pages_Render_RoleDashboard_Component()
    {
        // Agent/Reporting/Admin landings map to RoleDashboard (mapping §3/§4/§5).
        foreach (var relative in new[]
        {
            @"src\VisaFusion.Web\Areas\Agent\Pages\Index.cshtml",
            @"src\VisaFusion.Web\Areas\Reporting\Pages\Index.cshtml",
            @"src\VisaFusion.Web\Areas\Admin\Pages\Index.cshtml",
        })
        {
            var content = File.ReadAllText(Path.Combine(_projectRoot, relative));
            Assert.Contains("_RoleDashboard", content);
        }
    }

    [Fact]
    public void Queries_Page_Renders_PublicQueryForm_Component()
    {
        var queries = File.ReadAllText(Path.Combine(_projectRoot, @"src\VisaFusion.Web\Areas\Public\Pages\Queries.cshtml"));
        Assert.Contains("_PublicQueryForm", queries);
        Assert.Contains("/api/v1/public/queries", queries);
    }

    [Fact]
    public void Notifications_Page_Renders_InfoPage_Component()
    {
        var notifications = File.ReadAllText(Path.Combine(_projectRoot, @"src\VisaFusion.Web\Areas\Notifications\Pages\Index.cshtml"));
        Assert.Contains("_InfoPage", notifications);
    }

    [Fact]
    public void Public_DailyUpdate_Page_Keeps_Its_Model_And_Content()
    {
        // TS-006: preserved functional composition — the page model and data
        // columns are unchanged; only presentation classes were swapped.
        var dailyUpdate = File.ReadAllText(Path.Combine(_projectRoot, @"src\VisaFusion.Web\Areas\Public\Pages\DailyUpdate.cshtml"));
        Assert.Contains("Model.Entries", dailyUpdate);
        Assert.Contains("table", dailyUpdate);
        Assert.DoesNotContain("vf-", dailyUpdate);
    }

    [Fact]
    public void Reporting_Pages_Preserve_Server_Side_Pagination_And_Filters()
    {
        // The re-skin uses the _DataTable component which supports server-side
        // pagination via PageUrlTemplate (behavior preservation). The date-range
        // pages keep their GET filter forms.
        foreach (var relative in new[]
        {
            @"src\VisaFusion.Web\Areas\Reporting\Pages\TodaySubmission.cshtml",
            @"src\VisaFusion.Web\Areas\Reporting\Pages\TodayCollection.cshtml",
            @"src\VisaFusion.Web\Areas\Reporting\Pages\TodayTransaction.cshtml",
            @"src\VisaFusion.Web\Areas\Reporting\Pages\DailyVisaFee.cshtml",
            @"src\VisaFusion.Web\Areas\Reporting\Pages\DailyBill.cshtml",
        })
        {
            var content = File.ReadAllText(Path.Combine(_projectRoot, relative));
            Assert.Contains("method=\"get\"", content);
            // Server-side pagination is preserved via the _DataTable component's
            // PageUrlTemplate — verify the component is used.
            Assert.Contains("_DataTable", content);
        }

        // Pending has no filter form (legacy parity)
        var pending = File.ReadAllText(Path.Combine(_projectRoot,
            @"src\VisaFusion.Web\Areas\Reporting\Pages\Pending.cshtml"));
        Assert.Contains("_DataTable", pending);
    }
}