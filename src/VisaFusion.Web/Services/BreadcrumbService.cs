using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.AspNetCore.Mvc.ViewFeatures;
using System.Security.Claims;

namespace VisaFusion.Web.Services;

/// <summary>
/// Represents a breadcrumb item in the navigation hierarchy.
/// </summary>
public sealed record BreadcrumbItem
{
    public string Title { get; init; } = string.Empty;
    public string Route { get; init; } = string.Empty;
    public bool IsCurrent { get; init; } = false;
}

/// <summary>
/// Service that derives breadcrumb trails from the RoleAwareNavigation hierarchy
/// (Role → Module → Feature → Page), not from URL segments.
/// </summary>
public interface IBreadcrumbService
{
    IEnumerable<BreadcrumbItem> GetBreadcrumbs(ViewContext viewContext);
}

public sealed class BreadcrumbService : IBreadcrumbService
{
    private readonly IRoleAwareNavigation _navigation;

    public BreadcrumbService(IRoleAwareNavigation navigation)
    {
        _navigation = navigation;
    }

    public IEnumerable<BreadcrumbItem> GetBreadcrumbs(ViewContext viewContext)
    {
        var user = viewContext.HttpContext.User;
        var pagePath = viewContext.HttpContext.Request.Path.Value ?? string.Empty;
        var area = viewContext.RouteData.Values["area"]?.ToString() ?? string.Empty;

        var breadcrumbs = new List<BreadcrumbItem>();

        // Determine the navigation group and build hierarchy
        var (group, menu, submenu) = FindNavigationLocation(pagePath, area, user);

        if (group != null)
        {
            // Role level (implicit from user)
            var role = GetPrimaryRole(user);
            if (!string.IsNullOrEmpty(role))
            {
                breadcrumbs.Add(new BreadcrumbItem
                {
                    Title = role,
                    Route = GetRoleLandingRoute(role),
                    IsCurrent = false
                });
            }

            // Module (Navigation Group)
            breadcrumbs.Add(new BreadcrumbItem
            {
                Title = group.Title,
                Route = group.Route,
                IsCurrent = false
            });

            // Feature (Menu)
            if (menu != null)
            {
                breadcrumbs.Add(new BreadcrumbItem
                {
                    Title = menu.Title,
                    Route = menu.Route,
                    IsCurrent = false
                });

                // Page (Submenu item)
                if (submenu != null)
                {
                    breadcrumbs.Add(new BreadcrumbItem
                    {
                        Title = submenu.Title,
                        Route = submenu.Route,
                        IsCurrent = true
                    });
                }
                else
                {
                    // Current page is the menu itself
                    breadcrumbs[^1] = breadcrumbs[^1] with { IsCurrent = true };
                }
            }
            else
            {
                // Current page is the group itself
                breadcrumbs[^1] = breadcrumbs[^1] with { IsCurrent = true };
            }
        }
        else
        {
            // Fallback: use page title
            var title = viewContext.ViewData["Title"]?.ToString() ?? "Page";
            breadcrumbs.Add(new BreadcrumbItem
            {
                Title = title,
                Route = string.Empty,
                IsCurrent = true
            });
        }

        return breadcrumbs;
    }

    private (NavigationGroup? group, NavigationItem? menu, NavigationItem? submenu) FindNavigationLocation(string pagePath, string area, ClaimsPrincipal user)
    {
        var groups = _navigation.GetNavigationGroups(user);

        foreach (var group in groups)
        {
            foreach (var menu in group.Children)
            {
                // Submenu parents (Route = "#") never match a page path
                // directly — only their children do. Without this guard,
                // "#".TrimEnd('#') is "" and pagePath.StartsWith("") matches
                // every page, so the first #-routed menu in the first visible
                // group wins for all paths (review finding 2026-08-20).
                if (menu.Children.Any())
                {
                    foreach (var submenu in menu.Children)
                    {
                        if (submenu.Route == pagePath)
                        {
                            return (group, menu, submenu);
                        }
                    }
                }

                if (string.IsNullOrEmpty(menu.Route) || menu.Route == "#")
                {
                    continue;
                }

                if (menu.Route == pagePath || pagePath.StartsWith(menu.Route.TrimEnd('#')))
                {
                    return (group, menu, null);
                }
            }
        }

        return (null, null, null);
    }

    private static string GetPrimaryRole(ClaimsPrincipal user)
    {
        var role = user.FindFirstValue(ClaimTypes.Role);
        return role ?? string.Empty;
    }

    private static string GetRoleLandingRoute(string role)
    {
        return role switch
        {
            "agt" => "/Agent/Index",
            "emp" => "/Reporting/Index",
            "adm" => "/Admin/Index",
            "su" => "/Admin/Index",
            _ => "/"
        };
    }
}