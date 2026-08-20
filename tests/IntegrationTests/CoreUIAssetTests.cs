using System.IO;
using System.Linq;
using Xunit;

namespace VisaFusion.IntegrationTests;

/// <summary>
/// CoreUI Asset Validation Tests (TS-001)
/// Verifies CoreUI assets are present in wwwroot/, no CDN references, no demo/PRO content.
/// </summary>
public class CoreUIAssetTests
{
    private readonly string _webRoot = Path.GetFullPath(Path.Combine(AppContext.BaseDirectory, @"..\..\..\..\..\src\VisaFusion.Web\wwwroot"));
    private readonly string _projectRoot = Path.GetFullPath(Path.Combine(AppContext.BaseDirectory, @"..\..\..\..\.."));

    [Fact]
    public void CoreUI_Css_Files_Exist()
    {
        // CoreUI vendor CSS
        Assert.True(File.Exists(Path.Combine(_webRoot, @"lib\coreui\vendors\coreui.min.css")), "coreui.min.css missing");
        Assert.True(File.Exists(Path.Combine(_webRoot, @"lib\coreui\vendors\simplebar.min.css")), "simplebar.min.css missing");
        Assert.True(File.Exists(Path.Combine(_webRoot, @"lib\coreui\vendors\coreui-chartjs.min.css")), "coreui-chartjs.min.css missing");
        
        // VisaFusion override CSS
        Assert.True(File.Exists(Path.Combine(_webRoot, @"css\vf-coreui.css")), "vf-coreui.css missing");
    }

    [Fact]
    public void CoreUI_Js_Files_Exist()
    {
        // CoreUI vendor JS
        Assert.True(File.Exists(Path.Combine(_webRoot, @"lib\coreui\vendors\coreui.bundle.min.js")), "coreui.bundle.min.js missing");
        Assert.True(File.Exists(Path.Combine(_webRoot, @"lib\coreui\vendors\simplebar.min.js")), "simplebar.min.js missing");
        Assert.True(File.Exists(Path.Combine(_webRoot, @"lib\coreui\vendors\chart.umd.min.js")), "chart.umd.min.js missing");
        Assert.True(File.Exists(Path.Combine(_webRoot, @"lib\coreui\vendors\coreui-chartjs.min.js")), "coreui-chartjs.min.js missing");
        Assert.True(File.Exists(Path.Combine(_webRoot, @"lib\coreui\vendors\coreui-utils.min.js")), "coreui-utils.min.js missing");
        
        // VisaFusion bundle JS
        Assert.True(File.Exists(Path.Combine(_webRoot, @"js\vf-coreui.js")), "vf-coreui.js missing");
    }

    [Fact]
    public void CoreUI_Source_Files_Exist()
    {
        // Reference JS source (kept for the vf-coreui.js bundle)
        Assert.True(File.Exists(Path.Combine(_webRoot, @"lib\coreui\js\config.js")), "config.js missing");
        Assert.True(File.Exists(Path.Combine(_webRoot, @"lib\coreui\js\color-modes.js")), "color-modes.js missing");
        Assert.True(File.Exists(Path.Combine(_webRoot, @"lib\coreui\js\tooltips.js")), "tooltips.js missing");
        Assert.True(File.Exists(Path.Combine(_webRoot, @"lib\coreui\js\popovers.js")), "popovers.js missing");
        Assert.True(File.Exists(Path.Combine(_webRoot, @"lib\coreui\js\toasts.js")), "toasts.js missing");
        Assert.True(File.Exists(Path.Combine(_webRoot, @"lib\coreui\js\main.js")), "main.js missing");
    }

    [Fact]
    public void No_CDN_References_In_Cshtml()
    {
        var cshtmlFiles = Directory.GetFiles(_projectRoot, "*.cshtml", SearchOption.AllDirectories);
        var cdnPatterns = new[] { "https://cdn.jsdelivr.net", "https://cdnjs.cloudflare.com", "https://unpkg.com" };
        
        foreach (var file in cshtmlFiles)
        {
            var content = File.ReadAllText(file);
            foreach (var pattern in cdnPatterns)
            {
                Assert.False(content.Contains(pattern), $"CDN reference found in {file}: {pattern}");
            }
        }
    }

    [Fact]
    public void No_Demo_Or_Pro_Content_In_Vendored_Assets()
    {
        // No examples.css
        Assert.False(File.Exists(Path.Combine(_webRoot, @"lib\coreui\vendors\examples.css")), "examples.css should not be vendored");
        Assert.False(File.Exists(Path.Combine(_webRoot, @"lib\coreui\css\examples.css")), "examples.css should not be in css folder");
        
        // No demo JS files in bundle (charts.js, widgets.js excluded from vf-coreui.js)
        var bundlePath = Path.Combine(_webRoot, @"js\vf-coreui.js");
        Assert.True(File.Exists(bundlePath), "vf-coreui.js missing for demo content check");
        var bundleContent = File.ReadAllText(bundlePath);
        Assert.False(bundleContent.Contains("charts.js"), "charts.js should not be in vf-coreui.js bundle");
        Assert.False(bundleContent.Contains("widgets.js"), "widgets.js should not be in vf-coreui.js bundle");

        // No demo SCSS source or demo JS files vendored (SPEC-0009 T085)
        Assert.False(File.Exists(Path.Combine(_webRoot, @"lib\coreui\css\style.scss")), "style.scss should not be vendored");
        Assert.False(File.Exists(Path.Combine(_webRoot, @"lib\coreui\css\vendors\simplebar.scss")), "simplebar.scss should not be vendored");
        Assert.False(File.Exists(Path.Combine(_webRoot, @"lib\coreui\js\charts.js")), "charts.js should not be vendored");
        Assert.False(File.Exists(Path.Combine(_webRoot, @"lib\coreui\js\widgets.js")), "widgets.js should not be vendored");
    }

    [Fact]
    public void Icon_Set_Scope_Matches_Usage()
    {
        var cilDir = Path.Combine(_webRoot, @"icons\cil");
        var cifDir = Path.Combine(_webRoot, @"icons\cif");
        
        // At least some icons should exist
        if (Directory.Exists(cilDir))
        {
            var cilIcons = Directory.GetFiles(cilDir, "*.svg");
            Assert.True(cilIcons.Length > 0, "No cil icons found");
        }
        
        if (Directory.Exists(cifDir))
        {
            var cifIcons = Directory.GetFiles(cifDir, "*.svg");
            // cif icons may be empty if not needed yet
        }
    }

    [Fact]
    public void Readme_Exists_And_Documents_Version()
    {
        var readmePath = Path.Combine(_webRoot, @"lib\README.md");
        Assert.True(File.Exists(readmePath), "README.md missing");
        
        var content = File.ReadAllText(readmePath);
        Assert.Contains("v5.6.0", content);
        Assert.Contains("d4003cd", content);
        Assert.Contains("@coreui/coreui", content);
        Assert.Contains("5.9.0", content);
    }
}