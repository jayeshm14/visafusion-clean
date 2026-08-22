using System.Security.Claims;

namespace VisaFusion.Web.Services;

/// <summary>
/// Represents a navigation group in the role-aware navigation model.
/// </summary>
public sealed record NavigationGroup
{
    public string Id { get; init; } = string.Empty;
    public string Title { get; init; } = string.Empty;
    public string Route { get; init; } = string.Empty;
    /// <summary>
    /// CoreUI icon name (e.g., "cui-home", "cui-user"). Rendered via SVG use[href] referencing free-symbol-defs.svg.
    /// </summary>
    public string Icon { get; init; } = "cui-list"; // default menu icon
    public List<NavigationItem> Children { get; init; } = new();
    public bool IsDivider { get; init; } = false;
    public bool IsTitle { get; init; } = false;
    public string[] AllowedRoles { get; init; } = Array.Empty<string>();

    public bool IsVisibleFor(ClaimsPrincipal user)
    {
        if (!AllowedRoles.Any())
            return true;

        var userRoles = user.FindAll(ClaimTypes.Role).Select(c => c.Value).ToHashSet(StringComparer.OrdinalIgnoreCase);
        
        // Anonymous users have no roles; treat as "guest" for Public group visibility
        if (!userRoles.Any() && AllowedRoles.Contains("guest", StringComparer.OrdinalIgnoreCase))
            return true;

        return AllowedRoles.Any(r => userRoles.Contains(r, StringComparer.OrdinalIgnoreCase));
    }

    public static NavigationGroup Divider() => new() { IsDivider = true };
    public static NavigationGroup CreateTitle(string title) => new() { IsTitle = true, Title = title };
}

/// <summary>
/// Represents a navigation item (menu or submenu item).
/// </summary>
public sealed record NavigationItem
{
    public string Id { get; init; } = string.Empty;
    public string Title { get; init; } = string.Empty;
    public string Route { get; init; } = string.Empty;
    /// <summary>
    /// CoreUI icon name (e.g., "cui-home", "cui-user"). Empty string means no icon.
    /// </summary>
    public string Icon { get; init; } = string.Empty;
    public List<NavigationItem> Children { get; init; } = new();
    public string[] AllowedRoles { get; init; } = Array.Empty<string>();
    public string[] RequiredPermissions { get; init; } = Array.Empty<string>();

    public bool IsVisibleFor(ClaimsPrincipal user)
    {
        if (!AllowedRoles.Any() && !RequiredPermissions.Any())
            return true;

        var userRoles = user.FindAll(ClaimTypes.Role).Select(c => c.Value).ToHashSet(StringComparer.OrdinalIgnoreCase);
        var userPermissions = user.FindAll("permission").Select(c => c.Value).ToHashSet(StringComparer.OrdinalIgnoreCase);

        // Anonymous users have no roles; treat as "guest" for Public group visibility
        var roleMatch = !AllowedRoles.Any() 
            || AllowedRoles.Any(r => userRoles.Contains(r, StringComparer.OrdinalIgnoreCase))
            || (!userRoles.Any() && AllowedRoles.Contains("guest", StringComparer.OrdinalIgnoreCase));
        
        var permMatch = !RequiredPermissions.Any() || RequiredPermissions.Any(p => userPermissions.Contains(p, StringComparer.OrdinalIgnoreCase));

        return roleMatch && permMatch;
    }
}

/// <summary>
/// Centralized role-aware navigation service.
/// Exposes exactly 8 navigation groups with per-role visibility per ROLE_NAVIGATION_MATRIX.md §4.
/// </summary>
public interface IRoleAwareNavigation
{
    IEnumerable<NavigationGroup> GetNavigationGroups(ClaimsPrincipal user);
    IEnumerable<NavigationItem> GetVisibleMenuItems(ClaimsPrincipal user, string groupId);
}

public sealed class RoleAwareNavigation : IRoleAwareNavigation
{
    private readonly IReadOnlyList<NavigationGroup> _allGroups;

    public RoleAwareNavigation()
    {
        _allGroups = BuildNavigationModel();
    }

    public IEnumerable<NavigationGroup> GetNavigationGroups(ClaimsPrincipal user)
    {
        return _allGroups
            .Where(g => g.IsVisibleFor(user))
            .Select(g => g with
            {
                Children = g.Children.Where(c => c.IsVisibleFor(user)).ToList()
            });
    }

    public IEnumerable<NavigationItem> GetVisibleMenuItems(ClaimsPrincipal user, string groupId)
    {
        var group = _allGroups.FirstOrDefault(g => g.Id == groupId);
        if (group == null)
            return Enumerable.Empty<NavigationItem>();

        return group.Children.Where(c => c.IsVisibleFor(user));
    }

    private static IReadOnlyList<NavigationGroup> BuildNavigationModel()
    {
        return new List<NavigationGroup>
        {
            // 1. Public (Guest/Anonymous) - 9 pages, URL-only reachable per ROLE_NAVIGATION_MATRIX.md §5.1
            new NavigationGroup
            {
                Id = "public",
                Title = "Public",
                Route = "/Public/Index",
                Icon = "cui-globe-alt",
                AllowedRoles = new[] { "guest" },
                Children = new List<NavigationItem>
                {
                    new() { Id = "public-home", Title = "Home", Route = "/Public/Index", AllowedRoles = new[] { "guest" } },
                    new() { Id = "public-visa-info", Title = "Visa Info", Route = "/Public/VisaInfo", AllowedRoles = new[] { "guest" } },
                    new() { Id = "public-embassy", Title = "Embassy", Route = "/Public/Embassy", AllowedRoles = new[] { "guest" } },
                    new() { Id = "public-country-info", Title = "Country Info", Route = "/Public/CountryInfo", AllowedRoles = new[] { "guest" } },
                    new() { Id = "public-daily-update", Title = "Daily Update", Route = "/Public/DailyUpdate", AllowedRoles = new[] { "guest" } },
                    new() { Id = "public-queries", Title = "Queries", Route = "/Public/Queries", AllowedRoles = new[] { "guest" } },
                    new() { Id = "public-contact", Title = "Contact", Route = "/Public/Contact", AllowedRoles = new[] { "guest" } },
                    new() { Id = "public-subscribe", Title = "Subscribe", Route = "/Public/Subscribe", AllowedRoles = new[] { "guest" } },
                    new() { Id = "public-register", Title = "Register", Route = "/Public/Register", AllowedRoles = new[] { "guest" } },
                }
            },

            // 2. Account (all authenticated roles)
            new NavigationGroup
            {
                Id = "account",
                Title = "Account",
                Route = "/Auth/Login",
                Icon = "cui-user",
                AllowedRoles = new[] { "agt", "emp", "adm", "su" },
                Children = new List<NavigationItem>
                {
                    new() { Id = "account-login", Title = "Login", Route = "/Auth/Login", AllowedRoles = new[] { "guest" } },
                    new() { Id = "account-register", Title = "Register", Route = "/Auth/Register", AllowedRoles = new[] { "guest" } },
                    new() { Id = "account-change-password", Title = "Change password", Route = "/Auth/ChangePassword", AllowedRoles = new[] { "agt", "emp", "adm", "su" } },
                }
            },

            // 3. Agent Portal (agt, emp, adm, su) - 5 pages
            new NavigationGroup
            {
                Id = "agent-portal",
                Title = "Agent Portal",
                Route = "/Agent/Index",
                Icon = "cui-briefcase",
                AllowedRoles = new[] { "agt", "emp", "adm", "su" },
                Children = new List<NavigationItem>
                {
                    new() { Id = "agent-dashboard", Title = "Dashboard", Route = "/Agent/Index", AllowedRoles = new[] { "agt", "emp", "adm", "su" } },
                    new() { Id = "agent-entries", Title = "My Entries", Route = "/Agent/Entries", AllowedRoles = new[] { "agt", "emp", "adm", "su" } },
                    new() { Id = "agent-statuses", Title = "Passenger Statuses", Route = "/Agent/Statuses", AllowedRoles = new[] { "agt", "emp", "adm", "su" } },
                    new() { Id = "agent-statement", Title = "Statement", Route = "/Agent/Statement", AllowedRoles = new[] { "agt", "emp", "adm", "su" } },
                    new() { Id = "agent-account", Title = "My Account", Route = "/Agent/Account", AllowedRoles = new[] { "agt", "emp", "adm", "su" } },
                }
            },

            // 4. Reporting (emp, adm, su) - 7 pages with submenus
            new NavigationGroup
            {
                Id = "reporting",
                Title = "Reporting",
                Route = "/Reporting/Index",
                Icon = "cui-chart",
                AllowedRoles = new[] { "emp", "adm", "su" },
                Children = new List<NavigationItem>
                {
                    new() { Id = "reporting-dashboard", Title = "Dashboard", Route = "/Reporting/Index", AllowedRoles = new[] { "emp", "adm", "su" } },
                    new() { Id = "reporting-pending", Title = "Pending", Route = "/Reporting/Pending", AllowedRoles = new[] { "emp", "adm", "su" } },
                    new NavigationItem
                    {
                        Id = "reporting-today",
                        Title = "Today",
                        Route = "#",
                        AllowedRoles = new[] { "emp", "adm", "su" },
                        Children = new List<NavigationItem>
                        {
                            new() { Id = "reporting-today-submission", Title = "Submission", Route = "/Reporting/TodaySubmission", AllowedRoles = new[] { "emp", "adm", "su" } },
                            new() { Id = "reporting-today-collection", Title = "Collection", Route = "/Reporting/TodayCollection", AllowedRoles = new[] { "emp", "adm", "su" } },
                            new() { Id = "reporting-today-transaction", Title = "Transaction", Route = "/Reporting/TodayTransaction", AllowedRoles = new[] { "emp", "adm", "su" } },
                        }
                    },
                    new NavigationItem
                    {
                        Id = "reporting-daily",
                        Title = "Daily",
                        Route = "#",
                        AllowedRoles = new[] { "emp", "adm", "su" },
                        Children = new List<NavigationItem>
                        {
                            new() { Id = "reporting-daily-visa-fee", Title = "Visa Fee", Route = "/Reporting/DailyVisaFee", AllowedRoles = new[] { "emp", "adm", "su" } },
                            new() { Id = "reporting-daily-bill", Title = "Bill", Route = "/Reporting/DailyBill", AllowedRoles = new[] { "emp", "adm", "su" } },
                        }
                    },
                }
            },

            // 5. Admin (adm, su) - 5 modules with submenus
            new NavigationGroup
            {
                Id = "admin",
                Title = "Admin",
                Route = "/Admin/Index",
                Icon = "cui-shield-alt",
                AllowedRoles = new[] { "adm", "su" },
                Children = new List<NavigationItem>
                {
                    new() { Id = "admin-dashboard", Title = "Dashboard", Route = "/Admin/Index", AllowedRoles = new[] { "adm", "su" } },
                    new NavigationItem
                    {
                        Id = "admin-agents",
                        Title = "Agents",
                        Route = "#",
                        AllowedRoles = new[] { "adm", "su" },
                        Children = new List<NavigationItem>
                        {
                            new() { Id = "admin-agents-list", Title = "List", Route = "/Admin/Agents/List", AllowedRoles = new[] { "adm", "su" } },
                            new() { Id = "admin-agents-create", Title = "Create", Route = "/Admin/Agents/Create", AllowedRoles = new[] { "adm", "su" } },
                            new() { Id = "admin-agents-detail", Title = "Detail", Route = "/Admin/Agents/Detail", AllowedRoles = new[] { "adm", "su" } },
                            new() { Id = "admin-agents-edit", Title = "Edit", Route = "/Admin/Agents/Edit", AllowedRoles = new[] { "adm", "su" } },
                        }
                    },
                    new NavigationItem
                    {
                        Id = "admin-users",
                        Title = "Users",
                        Route = "#",
                        AllowedRoles = new[] { "adm", "su" },
                        Children = new List<NavigationItem>
                        {
                            new() { Id = "admin-users-list", Title = "List", Route = "/Admin/Users/List", AllowedRoles = new[] { "adm", "emp" } },
                            new() { Id = "admin-users-create", Title = "Create", Route = "/Admin/Users/Create", AllowedRoles = new[] { "adm", "emp" } },
                        }
                    },
                    new() { Id = "admin-holidays", Title = "Holidays", Route = "/Admin/Holidays/Index", AllowedRoles = new[] { "adm", "su" } },
                    new() { Id = "admin-content-update", Title = "Daily Updates", Route = "/Admin/ContentUpdate/Index", AllowedRoles = new[] { "adm", "su" } },
                    new() { Id = "admin-security-day", Title = "Security Day", Route = "/Admin/SecurityDay/Index", AllowedRoles = new[] { "adm", "su" } },
                }
            },

            // 6. Employee (placeholder, GAP-004)
            new NavigationGroup
            {
                Id = "employee",
                Title = "Employee",
                Route = "/Employee/Index",
                Icon = "cui-user-female",
                AllowedRoles = new[] { "emp" },
                Children = new List<NavigationItem>
                {
                    new() { Id = "employee-home", Title = "Home", Route = "/Employee/Index", AllowedRoles = new[] { "emp" } },
                }
            },

            // 7. Billing (placeholder, GAP-004)
            new NavigationGroup
            {
                Id = "billing",
                Title = "Billing",
                Route = "/Billing/Index",
                Icon = "cui-credit-card",
                AllowedRoles = new[] { "emp", "adm", "su" },
                Children = new List<NavigationItem>
                {
                    new() { Id = "billing-home", Title = "Home", Route = "/Billing/Index", AllowedRoles = new[] { "emp", "adm", "su" } },
                }
            },

            // 8. Notifications (placeholder, PARTIAL)
            new NavigationGroup
            {
                Id = "notifications",
                Title = "Notifications",
                Route = "/Notifications/Index",
                Icon = "cui-bell",
                AllowedRoles = new[] { "adm", "su" },
                Children = new List<NavigationItem>
                {
                    new() { Id = "notifications-home", Title = "Home", Route = "/Notifications/Index", AllowedRoles = new[] { "adm", "su" } },
                }
            },
        };
    }
}