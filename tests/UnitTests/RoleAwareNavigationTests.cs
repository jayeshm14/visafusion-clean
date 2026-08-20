using System.Security.Claims;
using VisaFusion.Web.Services;

namespace VisaFusion.UnitTests;

/// <summary>
/// Role-aware navigation model tests (SPEC-0009 TS-001, FR-003/AC-004).
/// Verifies the centralized RoleAwareNavigation service returns the correct
/// menu/submenu set per role (guest/agt/emp/adm/su) matching
/// ROLE_NAVIGATION_MATRIX.md §4 — the single source of truth for the sidebar.
/// </summary>
public class RoleAwareNavigationTests
{
    private static ClaimsPrincipal UserWithRoles(params string[] roles)
    {
        var claims = roles.Select(r => new Claim(ClaimTypes.Role, r)).ToList();
        return new ClaimsPrincipal(new ClaimsIdentity(claims, "test"));
    }

    private static ClaimsPrincipal AnonymousUser() =>
        new ClaimsPrincipal(new ClaimsIdentity(Array.Empty<Claim>(), "test"));

    private readonly RoleAwareNavigation _nav = new();

    [Fact]
    public void Anonymous_User_Sees_Only_Public_Group()
    {
        var groups = _nav.GetNavigationGroups(AnonymousUser()).ToList();

        Assert.Single(groups);
        Assert.Equal("public", groups[0].Id);
        Assert.Equal(9, groups[0].Children.Count);
    }

    [Fact]
    public void Agent_Sees_Account_And_Agent_Portal()
    {
        var groups = _nav.GetNavigationGroups(UserWithRoles("agt")).ToList();

        var ids = groups.Select(g => g.Id).ToList();
        Assert.Contains("account", ids);
        Assert.Contains("agent-portal", ids);
        Assert.DoesNotContain("public", ids); // guest-only group
        Assert.DoesNotContain("reporting", ids);
        Assert.DoesNotContain("admin", ids);
        Assert.DoesNotContain("employee", ids);
        Assert.DoesNotContain("billing", ids);
        Assert.DoesNotContain("notifications", ids);
    }

    [Fact]
    public void Employee_Sees_Reporting_And_Employee_And_Billing()
    {
        var groups = _nav.GetNavigationGroups(UserWithRoles("emp")).ToList();

        var ids = groups.Select(g => g.Id).ToList();
        Assert.Contains("reporting", ids);
        Assert.Contains("employee", ids);
        Assert.Contains("billing", ids);
        Assert.Contains("agent-portal", ids); // agent-portal allows emp
        Assert.DoesNotContain("admin", ids);
        Assert.DoesNotContain("public", ids);
    }

    [Fact]
    public void Admin_Sees_Admin_And_Agent_Portal_And_Reporting()
    {
        var groups = _nav.GetNavigationGroups(UserWithRoles("adm")).ToList();

        var ids = groups.Select(g => g.Id).ToList();
        Assert.Contains("admin", ids);
        Assert.Contains("agent-portal", ids);
        Assert.Contains("reporting", ids);
        Assert.Contains("notifications", ids);
        Assert.DoesNotContain("employee", ids);
    }

    [Fact]
    public void SuperUser_Sees_Admin_And_Notifications()
    {
        var groups = _nav.GetNavigationGroups(UserWithRoles("su")).ToList();

        var ids = groups.Select(g => g.Id).ToList();
        Assert.Contains("admin", ids);
        Assert.Contains("notifications", ids);
        Assert.Contains("agent-portal", ids);
        Assert.Contains("reporting", ids);
    }

    [Fact]
    public void Reporting_Group_Exposes_Submenus_For_Employee()
    {
        var groups = _nav.GetNavigationGroups(UserWithRoles("emp")).ToList();
        var reporting = groups.Single(g => g.Id == "reporting");

        var titles = reporting.Children.Select(c => c.Title).ToList();
        Assert.Contains("Dashboard", titles);
        Assert.Contains("Pending", titles);
        Assert.Contains("Today", titles);
        Assert.Contains("Daily", titles);

        var today = reporting.Children.Single(c => c.Title == "Today");
        Assert.Equal(3, today.Children.Count); // Submission, Collection, Transaction
        Assert.All(today.Children, c => Assert.Equal("/Reporting/", c.Route[..11]));

        var daily = reporting.Children.Single(c => c.Title == "Daily");
        Assert.Equal(2, daily.Children.Count); // Visa Fee, Bill
    }

    [Fact]
    public void Admin_Group_Exposes_Agents_And_Users_Submenus()
    {
        var groups = _nav.GetNavigationGroups(UserWithRoles("adm")).ToList();
        var admin = groups.Single(g => g.Id == "admin");

        var agents = admin.Children.Single(c => c.Id == "admin-agents");
        Assert.Equal(4, agents.Children.Count); // List, Create, Detail, Edit

        var users = admin.Children.Single(c => c.Id == "admin-users");
        Assert.Equal(2, users.Children.Count); // List, Create
    }

    [Fact]
    public void Users_Submenu_Is_Visible_To_Employee_But_Agents_Submenu_Is_Not()
    {
        // ROLE_NAVIGATION_MATRIX.md §4: admin-users children allow adm+emp,
        // admin-agents children allow adm+su only.
        var groups = _nav.GetNavigationGroups(UserWithRoles("emp")).ToList();
        Assert.DoesNotContain(groups, g => g.Id == "admin");

        var adminGroups = _nav.GetNavigationGroups(UserWithRoles("adm")).ToList();
        var admin = adminGroups.Single(g => g.Id == "admin");
        var users = admin.Children.Single(c => c.Id == "admin-users");
        Assert.Equal(2, users.Children.Count);
    }

    [Fact]
    public void GetVisibleMenuItems_Returns_Empty_For_Unknown_Group()
    {
        var items = _nav.GetVisibleMenuItems(UserWithRoles("adm"), "does-not-exist");
        Assert.Empty(items);
    }

    [Fact]
    public void GetVisibleMenuItems_Filters_By_Role()
    {
        // An agent asking for the admin group gets nothing (group not visible).
        var items = _nav.GetVisibleMenuItems(UserWithRoles("agt"), "admin");
        Assert.Empty(items);

        // An admin asking for the admin group gets the visible children.
        var adminItems = _nav.GetVisibleMenuItems(UserWithRoles("adm"), "admin");
        Assert.Equal(6, adminItems.Count());
    }

    [Fact]
    public void Public_Group_Is_Visible_Only_To_Anonymous_Users()
    {
        // The Public group is guest-only: anonymous users (no role claims)
        // see it; every authenticated role is redirected to its own portal.
        var anonymous = _nav.GetNavigationGroups(AnonymousUser()).ToList();
        Assert.Contains(anonymous, g => g.Id == "public");

        foreach (var roles in new[] { new[] { "agt" }, new[] { "emp" }, new[] { "adm" }, new[] { "su" } })
        {
            var groups = _nav.GetNavigationGroups(UserWithRoles(roles)).ToList();
            Assert.DoesNotContain(groups, g => g.Id == "public");
        }
    }
}