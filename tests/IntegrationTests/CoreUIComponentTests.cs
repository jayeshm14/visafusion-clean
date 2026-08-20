using System;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using Xunit;

namespace VisaFusion.IntegrationTests;

/// <summary>
/// CoreUI Component Validation Tests (TS-009 / Phase 10)
/// Verifies the canonical VisaFusion component library: all 10 partials + models exist,
/// no duplicate partial names anywhere in the repo, wrapper classes match the component
/// stylesheet selectors, and the component stylesheet is token-only (no hard-coded colors).
/// </summary>
public class CoreUIComponentTests
{
    private readonly string _componentsDir = Path.GetFullPath(Path.Combine(AppContext.BaseDirectory, @"..\..\..\..\..\src\VisaFusion.Web\Components"));
    private readonly string _webRoot = Path.GetFullPath(Path.Combine(AppContext.BaseDirectory, @"..\..\..\..\..\src\VisaFusion.Web\wwwroot"));
    private readonly string _projectRoot = Path.GetFullPath(Path.Combine(AppContext.BaseDirectory, @"..\..\..\..\.."));

    private static readonly string[] CanonicalPartials =
    {
        "_RoleDashboard.cshtml",
        "_DataTable.cshtml",
        "_FormCard.cshtml",
        "_AuthCard.cshtml",
        "_ErrorPage.cshtml",
        "_InfoPage.cshtml",
        "_PublicLanding.cshtml",
        "_PublicQueryForm.cshtml",
        "_ConfirmModal.cshtml",
        "_ToastHost.cshtml"
    };

    private static readonly string[] ComponentModels =
    {
        "RoleDashboardModel.cs",
        "DataTableModel.cs",
        "FormCardModel.cs",
        "AuthCardModel.cs",
        "ErrorPageModel.cs",
        "InfoPageModel.cs",
        "PublicLandingModel.cs",
        "PublicQueryFormModel.cs",
        "ConfirmModalModel.cs",
        "ToastHostModel.cs"
    };

    [Fact]
    public void All_Canonical_Component_Partials_Exist()
    {
        foreach (var partial in CanonicalPartials)
        {
            Assert.True(File.Exists(Path.Combine(_componentsDir, partial)), $"Missing component partial: {partial}");
        }
    }

    [Fact]
    public void All_Component_Models_Exist()
    {
        foreach (var model in ComponentModels)
        {
            Assert.True(File.Exists(Path.Combine(_componentsDir, model)), $"Missing component model: {model}");
        }
    }

    [Fact]
    public void No_Duplicate_Component_Partials_Anywhere_In_Repo()
    {
        foreach (var partial in CanonicalPartials)
        {
            var matches = Directory.GetFiles(_projectRoot, partial, SearchOption.AllDirectories);
            Assert.Single(matches);
        }
    }

    [Fact]
    public void Component_Stylesheet_Exists_And_Is_Token_Only()
    {
        var cssPath = Path.Combine(_webRoot, @"css\vf-component-styles.css");
        Assert.True(File.Exists(cssPath), "vf-component-styles.css missing");

        var css = File.ReadAllText(cssPath);

        // No hard-coded hex colors
        Assert.False(Regex.IsMatch(css, @"#[0-9a-fA-F]{3,8}\b"), "Hard-coded hex color found in vf-component-styles.css");

        // No hard-coded named colors
        Assert.False(Regex.IsMatch(css, @"(?<![\w-])(white|black|red|blue|green|gray|grey|orange|purple|yellow|pink|brown|navy|teal|olive|maroon|silver|gold)(?![\w-])"),
            "Hard-coded named color found in vf-component-styles.css");

        // Every rgba() must be token-driven (var(--cui-*-rgb))
        foreach (System.Text.RegularExpressions.Match m in Regex.Matches(css, @"rgba\(([^)]*)\)"))
        {
            Assert.Contains("var(--cui-", m.Groups[1].Value, StringComparison.OrdinalIgnoreCase);
        }
    }

    [Theory]
    [InlineData("_RoleDashboard.cshtml", "role-dashboard")]
    [InlineData("_DataTable.cshtml", "data-table")]
    [InlineData("_FormCard.cshtml", "form-card")]
    [InlineData("_AuthCard.cshtml", "auth-card")]
    [InlineData("_ErrorPage.cshtml", "error-page")]
    [InlineData("_InfoPage.cshtml", "info-page")]
    [InlineData("_PublicLanding.cshtml", "public-landing")]
    [InlineData("_PublicQueryForm.cshtml", "public-query-form")]
    [InlineData("_ConfirmModal.cshtml", "confirm-modal")]
    [InlineData("_ToastHost.cshtml", "toast-host")]
    public void Component_Partial_Renders_Its_Wrapper_Class(string partial, string wrapperClass)
    {
        var content = File.ReadAllText(Path.Combine(_componentsDir, partial));
        Assert.Contains($"class=\"{wrapperClass}", content);
    }
}
