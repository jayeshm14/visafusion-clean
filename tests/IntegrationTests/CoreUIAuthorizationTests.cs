using System;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using Xunit;

namespace VisaFusion.IntegrationTests;

/// <summary>
/// CoreUI Authorization Validation Tests (TS-004 / Phase 12, AC-009, CHK042/CHK015/CHK028)
///
/// Verifies the authorization-aware UI contract:
/// - every protected page retains its server-side [Authorize] attribute
///   (ROLE_PAGE_PERMISSION_MATRIX.md §4 — the matrix is the source of truth);
/// - anonymous pages remain anonymous;
/// - UI visibility is never used as authorization: no authorization decisions
///   in presentation code (.cshtml), and the navigation model is config-driven
///   (AllowedRoles), not authorization-driven (constitution XV; Addendum §10);
/// - the 11-policy catalog is unchanged (AuthorizationPolicies.cs).
/// </summary>
public class CoreUIAuthorizationTests
{
    private readonly string _webRoot = Path.GetFullPath(Path.Combine(AppContext.BaseDirectory, @"..\..\..\..\..\src\VisaFusion.Web"));
    private readonly string _projectRoot = Path.GetFullPath(Path.Combine(AppContext.BaseDirectory, @"..\..\..\..\.."));

    /// <summary>
    /// Protected page models and the exact [Authorize] attribute the matrix
    /// (ROLE_PAGE_PERMISSION_MATRIX.md §4) assigns. Agent (5) and Reporting (7)
    /// pages inherit from their base page models, which carry the policy.
    /// </summary>
    [Theory]
    [InlineData(@"Pages\Auth\ChangePassword.cshtml.cs", "[Authorize]")]
    [InlineData(@"Areas\Agent\Pages\AgentPortalPageModel.cs", "AgentSelf")]
    [InlineData(@"Areas\Reporting\Pages\ReportingPageModel.cs", "EntryOperations")]
    [InlineData(@"Areas\Admin\Pages\Agents\List.cshtml.cs", "AdminPanel")]
    [InlineData(@"Areas\Admin\Pages\Agents\Create.cshtml.cs", "AdminPanel")]
    [InlineData(@"Areas\Admin\Pages\Agents\Detail.cshtml.cs", "AdminPanel")]
    [InlineData(@"Areas\Admin\Pages\Agents\Edit.cshtml.cs", "AdminPanel")]
    [InlineData(@"Areas\Admin\Pages\Users\List.cshtml.cs", "UserManagement")]
    [InlineData(@"Areas\Admin\Pages\Users\Create.cshtml.cs", "UserManagement")]
    [InlineData(@"Areas\Admin\Pages\Holidays\Index.cshtml.cs", "HolidayAdmin")]
    [InlineData(@"Areas\Admin\Pages\ContentUpdate\Index.cshtml.cs", "AdminPanel")]
    [InlineData(@"Areas\Admin\Pages\SecurityDay\Index.cshtml.cs", "SecurityGate")]
    public void Protected_Page_Model_Retains_Its_Authorize_Attribute(string relativePath, string expectedPolicy)
    {
        var fullPath = Path.Combine(_webRoot, relativePath);
        Assert.True(File.Exists(fullPath), $"Missing page model: {relativePath}");

        var content = File.ReadAllText(fullPath);

        if (expectedPolicy == "[Authorize]")
        {
            Assert.Matches(@"\[Authorize\]", content);
        }
        else
        {
            Assert.Contains($"Policy = AuthorizationPolicies.{expectedPolicy}", content);
        }
    }

    [Theory]
    [InlineData(@"Pages\Auth\Login.cshtml.cs")]
    [InlineData(@"Pages\Auth\Register.cshtml.cs")]
    [InlineData(@"Pages\Auth\AccessDenied.cshtml.cs")]
    [InlineData(@"Pages\Error.cshtml.cs")]
    public void Anonymous_Page_Model_Has_No_Authorize_Attribute(string relativePath)
    {
        var fullPath = Path.Combine(_webRoot, relativePath);
        Assert.True(File.Exists(fullPath), $"Missing page model: {relativePath}");

        var content = File.ReadAllText(fullPath);
        Assert.DoesNotContain("[Authorize", content);
    }

    /// <summary>
    /// CHK015 / Addendum §10: no authorization decisions in presentation code.
    /// The only claim read in any .cshtml is the documented role-badge display
    /// rule in _Header.cshtml (ROLE_NAVIGATION_MATRIX.md §5.5) — a display
    /// read, never a grant/deny decision.
    /// </summary>
    [Fact]
    public void No_Authorization_Decisions_In_Presentation_Code()
    {
        var cshtmlFiles = Directory.GetFiles(_webRoot, "*.cshtml", SearchOption.AllDirectories);

        var offenders = cshtmlFiles
            .Where(f => Regex.IsMatch(File.ReadAllText(f),
                @"\.IsInRole\b|\.IsInRoleAsync\b|\.HasClaim\b|\.FindFirst\b|\.FindAll\b"))
            .Select(f => Path.GetRelativePath(_webRoot, f))
            .ToList();

        // _Header.cshtml reads the role claim for the badge display only
        // (FindFirstValue — display, not authorization). No other .cshtml may
        // touch claims.
        Assert.All(offenders, path => Assert.Equal(@"Pages\Shared\_Header.cshtml", path));
    }

    /// <summary>
    /// CHK013: the 11-policy catalog is unchanged (AuthorizationPolicies.cs).
    /// </summary>
    [Fact]
    public void All_11_Policies_Are_Defined_Unchanged()
    {
        var policiesPath = Path.Combine(_projectRoot, @"src\VisaFusion.Api\Authorization\AuthorizationPolicies.cs");
        Assert.True(File.Exists(policiesPath), "AuthorizationPolicies.cs missing");

        var content = File.ReadAllText(policiesPath);

        string[] policies =
        {
            "EntryOperations", "AgentSelf", "AgentLedger", "BillingOperations",
            "Search", "UserManagement", "HolidayAdmin", "SecurityGate",
            "PasswordSelf", "AdminPanel", "SuperUserOnly"
        };

        foreach (var policy in policies)
        {
            Assert.Contains($"const string {policy} = \"{policy}\"", content);
        }
    }

    /// <summary>
    /// Addendum §9/§10: the navigation model is config-driven (AllowedRoles),
    /// never authorization-driven — no role checks, no [Authorize] in the
    /// service. Menu hiding must not grant/deny access.
    /// </summary>
    [Fact]
    public void Navigation_Model_Is_Config_Driven_Not_Authorization()
    {
        var navPath = Path.Combine(_webRoot, @"Services\RoleAwareNavigation.cs");
        Assert.True(File.Exists(navPath), "RoleAwareNavigation.cs missing");

        var content = File.ReadAllText(navPath);

        Assert.DoesNotContain("IsInRole", content);
        Assert.DoesNotContain("HasClaim", content);
        Assert.DoesNotContain("[Authorize", content);
        Assert.Contains("AllowedRoles", content);
    }
}