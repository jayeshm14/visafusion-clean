using System;
using System.IO;
using System.Linq;
using Xunit;

namespace VisaFusion.IntegrationTests;

/// <summary>
/// CoreUI accessibility tests (SPEC-0009 TS-009, FR-010/AC-011, NFR-003).
/// Verifies semantic HTML, keyboard navigation (skip link), form labels,
/// table header scope, ARIA attributes, and contrast-safe token usage on the
/// migrated surfaces.
/// </summary>
public class CoreUIAccessibilityTests
{
    private readonly string _projectRoot = Path.GetFullPath(Path.Combine(AppContext.BaseDirectory, @"..\..\..\..\.."));

    [Fact]
    public void Skip_Link_Is_Present_In_The_Layout()
    {
        // WCAG 2.4.1 (Bypass Blocks): the skip link targets the main content.
        var layout = File.ReadAllText(Path.Combine(_projectRoot, @"src\VisaFusion.Web\Pages\Shared\_Layout.cshtml"));
        Assert.Contains("vf-skip-link", layout);
        Assert.Contains("Skip to main content", layout);
        Assert.Contains("id=\"vf-content\"", layout);
    }

    [Fact]
    public void Main_Content_Is_Semantic_And_Focusable()
    {
        var layout = File.ReadAllText(Path.Combine(_projectRoot, @"src\VisaFusion.Web\Pages\Shared\_Layout.cshtml"));
        Assert.Contains("<main", layout);
        Assert.Contains("tabindex=\"-1\"", layout);
    }

    [Fact]
    public void Table_Headers_Use_Scope_Attribute()
    {
        // WCAG 1.3.1: every table header must declare its scope.
        var cshtmlFiles = Directory.GetFiles(Path.Combine(_projectRoot, @"src\VisaFusion.Web\Areas"), "*.cshtml", SearchOption.AllDirectories);
        foreach (var file in cshtmlFiles)
        {
            var content = File.ReadAllText(file);
            if (content.Contains("<table"))
            {
                Assert.True(
                    content.Contains("scope=\"col\"") || content.Contains("scope=\"row\""),
                    $"Table without scope attribute in {file}");
            }
        }
    }

    [Fact]
    public void Form_Inputs_Have_Labels()
    {
        // WCAG 3.3.2 / 1.3.1: every visible form control must have an
        // associated label. Hidden inputs (e.g. asp-for="Id" in handler
        // forms) are exempt.
        var cshtmlFiles = Directory.GetFiles(Path.Combine(_projectRoot, @"src\VisaFusion.Web\Areas"), "*.cshtml", SearchOption.AllDirectories);
        foreach (var file in cshtmlFiles)
        {
            var content = File.ReadAllText(file);
            var visibleInputs = System.Text.RegularExpressions.Regex.Matches(content, @"<input\b(?![^>]*type=""hidden"")[^>]*>");
            if (visibleInputs.Count > 0 || content.Contains("<select") || content.Contains("<textarea"))
            {
                Assert.True(
                    content.Contains("<label") || content.Contains("aria-label"),
                    $"Form control without label in {file}");
            }
        }
    }

    [Fact]
    public void Icon_Only_Actions_Are_Visually_Hidden_Labeled()
    {
        // WCAG 1.1.1: icon-only table action columns carry an accessible label.
        // The _DataTable component renders a dropdown toggle with aria-label="Row
        // actions" — verify these pages use _DataTable (which provides the label).
        foreach (var relative in new[]
        {
            @"src\VisaFusion.Web\Areas\Admin\Pages\Agents\List.cshtml",
            @"src\VisaFusion.Web\Areas\Admin\Pages\Users\List.cshtml",
            @"src\VisaFusion.Web\Areas\Admin\Pages\Holidays\Index.cshtml",
            @"src\VisaFusion.Web\Areas\Admin\Pages\ContentUpdate\Index.cshtml",
        })
        {
            var content = File.ReadAllText(Path.Combine(_projectRoot, relative));
            Assert.True(
                content.Contains("visually-hidden") || content.Contains("aria-label") || content.Contains("_DataTable"),
                $"Icon-only actions without accessible label in {relative}");
        }
    }

    [Fact]
    public void Alerts_Declare_Role_Or_Status()
    {
        // WCAG 4.1.3: status/alert messages declare their live region role.
        // Razor pages that build alert markup inside C# string literals use
        // escaped quotes (\"alert\") — normalize before checking.
        var cshtmlFiles = Directory.GetFiles(Path.Combine(_projectRoot, @"src\VisaFusion.Web\Areas"), "*.cshtml", SearchOption.AllDirectories);
        foreach (var file in cshtmlFiles)
        {
            var content = File.ReadAllText(file).Replace("\\\"", "\"");
            if (content.Contains("alert alert-"))
            {
                Assert.True(
                    content.Contains("role=\"alert\"") || content.Contains("role=\"status\""),
                    $"Alert without role in {file}");
            }
        }
    }

    [Fact]
    public void Component_Stylesheet_Uses_Contrast_Safe_Tokens()
    {
        // NFR-003: no hard-coded colors in the component stylesheet — all
        // colors come from the --cui-* token system (theme-switchable).
        var css = File.ReadAllText(Path.Combine(_projectRoot, @"src\VisaFusion.Web\wwwroot\css\vf-component-styles.css"));
        Assert.False(System.Text.RegularExpressions.Regex.IsMatch(css, @"#[0-9a-fA-F]{3,8}\b"), "Hard-coded hex color found");
        Assert.False(System.Text.RegularExpressions.Regex.IsMatch(css, @"(?<![\w-])(white|black|red|blue|green|gray|grey|orange|purple|yellow|pink|brown|navy|teal|olive|maroon|silver|gold)(?![\w-])"),
            "Hard-coded named color found");
    }

    [Fact]
    public void Sidebar_Nav_Is_Semantic()
    {
        var sidebar = File.ReadAllText(Path.Combine(_projectRoot, @"src\VisaFusion.Web\Pages\Shared\_Sidebar.cshtml"));
        Assert.Contains("<nav", sidebar);
        Assert.Contains("aria-label", sidebar);
    }
}