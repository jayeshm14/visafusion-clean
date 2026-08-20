using Microsoft.AspNetCore.Mvc.Testing;
using System.Net.Http;
using System.Threading.Tasks;
using Xunit;

namespace VisaFusion.FunctionalTests;

/// <summary>
/// CoreUI Theme System Tests (TS-007)
/// Verifies light/dark/auto switching, visafusion-theme persistence key, server-side light default.
/// </summary>
public class CoreUIThemeTests : IClassFixture<VisaFusionWebApplicationFactory>
{
    private readonly VisaFusionWebApplicationFactory _factory;
    private readonly HttpClient _client;

    public CoreUIThemeTests(VisaFusionWebApplicationFactory factory)
    {
        _factory = factory;
        _client = factory.CreateClient();
    }

    [Fact]
    public async Task Server_Renders_Light_Theme_By_Default()
    {
        // Arrange & Act
        var response = await _client.GetAsync("/");
        var content = await response.Content.ReadAsStringAsync();

        // Assert: Server renders data-coreui-theme="light" on <html>
        Assert.Contains("data-coreui-theme=\"light\"", content);
    }

    [Fact]
    public async Task Theme_JS_Includes_Visafusion_Theme_Key()
    {
        // Arrange & Act
        var response = await _client.GetAsync("/js/vf-coreui.js");
        var content = await response.Content.ReadAsStringAsync();

        // Assert: Theme persistence key is 'visafusion-theme' (not CoreUI default)
        Assert.Contains("visafusion-theme", content);
        Assert.DoesNotContain("coreui-free-bootstrap-admin-template-theme", content);
    }

    [Fact]
    public async Task Theme_JS_Includes_Color_Modes_Logic()
    {
        // Arrange & Act
        var response = await _client.GetAsync("/js/vf-coreui.js");
        var content = await response.Content.ReadAsStringAsync();

        // Assert: color-modes.js logic is included
        Assert.Contains("getPreferredTheme", content);
        Assert.Contains("setTheme", content);
        Assert.Contains("ColorSchemeChange", content);
        Assert.Contains("data-coreui-theme", content);
    }

    [Fact]
    public async Task Theme_JS_Includes_Toast_Init()
    {
        // Arrange & Act
        var response = await _client.GetAsync("/js/vf-coreui.js");
        var content = await response.Content.ReadAsStringAsync();

        // Assert: toasts.js logic is included (for Notifications placeholder)
        Assert.Contains("coreui.Toast", content);
    }

    [Fact]
    public async Task Theme_JS_Excludes_Tooltips_And_Popovers()
    {
        // Arrange & Act
        var response = await _client.GetAsync("/js/vf-coreui.js");
        var content = await response.Content.ReadAsStringAsync();

        // Assert: tooltips.js and popovers.js excluded (T006b - zero usage)
        Assert.DoesNotContain("coreui.Tooltip", content);
        Assert.DoesNotContain("coreui.Popover", content);
    }

    [Fact]
    public async Task Theme_JS_Includes_CoreUI_Bundle_And_SimpleBar()
    {
        // Arrange & Act
        var response = await _client.GetAsync("/js/vf-coreui.js");
        var content = await response.Content.ReadAsStringAsync();

        // Assert: CoreUI bundle and SimpleBar are included
        Assert.Contains("coreui.bundle.min.js", content);
        Assert.Contains("simplebar.min.js", content);
    }
}