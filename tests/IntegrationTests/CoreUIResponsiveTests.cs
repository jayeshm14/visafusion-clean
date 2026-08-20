using System;
using System.IO;
using System.Linq;
using Xunit;

namespace VisaFusion.IntegrationTests;

/// <summary>
/// CoreUI responsive tests (SPEC-0009 TS-008, FR-011/AC-012, NFR-001/002/004/006/007).
/// Verifies every migrated surface is responsive at desktop/tablet/mobile:
/// tables are wrapped in .table-responsive, forms use the responsive grid
/// (row g-3 / col-*), and no fixed-width layout containers remain.
/// </summary>
public class CoreUIResponsiveTests
{
    private readonly string _projectRoot = Path.GetFullPath(Path.Combine(AppContext.BaseDirectory, @"..\..\..\..\.."));

    private static readonly string[] ReSkinnedPages =
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
    };

    [Fact]
    public void Tables_Are_Wrapped_In_Table_Responsive()
    {
        // AC-012: every data table must scroll horizontally on small screens.
        foreach (var relative in ReSkinnedPages)
        {
            var content = File.ReadAllText(Path.Combine(_projectRoot, relative));
            if (content.Contains("<table"))
            {
                Assert.True(
                    content.Contains("table-responsive"),
                    $"Table without .table-responsive wrapper in {relative}");
            }
        }
    }

    [Fact]
    public void Filter_Forms_Use_The_Responsive_Grid()
    {
        // AC-012: filter/search forms use row g-3 + col-* so fields wrap on
        // tablet/mobile instead of overflowing.
        foreach (var relative in new[]
        {
            @"src\VisaFusion.Web\Areas\Reporting\Pages\TodaySubmission.cshtml",
            @"src\VisaFusion.Web\Areas\Reporting\Pages\TodayCollection.cshtml",
            @"src\VisaFusion.Web\Areas\Reporting\Pages\TodayTransaction.cshtml",
            @"src\VisaFusion.Web\Areas\Reporting\Pages\DailyVisaFee.cshtml",
            @"src\VisaFusion.Web\Areas\Reporting\Pages\DailyBill.cshtml",
            @"src\VisaFusion.Web\Areas\Agent\Pages\Entries.cshtml",
            @"src\VisaFusion.Web\Areas\Agent\Pages\Statuses.cshtml",
            @"src\VisaFusion.Web\Areas\Admin\Pages\Agents\List.cshtml",
        })
        {
            var content = File.ReadAllText(Path.Combine(_projectRoot, relative));
            Assert.True(
                content.Contains("row g-3") && content.Contains("col-auto"),
                $"Filter form not using the responsive grid in {relative}");
        }
    }

    [Fact]
    public void No_Fixed_Width_Layout_Containers()
    {
        // AC-012: no fixed pixel-width containers that break at tablet/mobile.
        // max-width/min-width are responsive-safe (auth card, toast host);
        // table column widths and progress bars are not layout containers.
        var cshtmlFiles = Directory.GetFiles(Path.Combine(_projectRoot, @"src\VisaFusion.Web"), "*.cshtml", SearchOption.AllDirectories);
        foreach (var file in cshtmlFiles)
        {
            var content = File.ReadAllText(file);
            foreach (System.Text.RegularExpressions.Match m in System.Text.RegularExpressions.Regex.Matches(content, @"style=""[^""]*width:\s*\d{3,}px"))
            {
                // Every 3+ digit width must be a responsive-safe max-width or
                // min-width (auth card, toast host) — never a fixed width.
                Assert.True(
                    m.Value.Contains("max-width") || m.Value.Contains("min-width"),
                    $"Fixed-width container found in {file}: {m.Value}");
            }
        }
    }

    [Fact]
    public void Shell_Uses_Flex_For_Sidebar_And_Main()
    {
        // The shell must be a flex layout so the sidebar collapses on mobile.
        var css = File.ReadAllText(Path.Combine(_projectRoot, @"src\VisaFusion.Web\wwwroot\css\vf-component-styles.css"));
        Assert.Contains(".vf-shell", css);
        Assert.Contains("display: flex", css);
        Assert.Contains(".vf-main", css);
        Assert.Contains("flex: 1", css);
    }

    [Fact]
    public void Viewport_Meta_Is_Present_In_Both_Layouts()
    {
        foreach (var layout in new[] { "_Layout.cshtml", "_AuthLayout.cshtml" })
        {
            var content = File.ReadAllText(Path.Combine(_projectRoot, @"src\VisaFusion.Web\Pages\Shared", layout));
            Assert.Contains("width=device-width, initial-scale=1.0", content);
        }
    }
}