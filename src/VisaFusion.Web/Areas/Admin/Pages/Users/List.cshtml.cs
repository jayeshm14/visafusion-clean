using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using VisaFusion.Api.Authorization;
using VisaFusion.Core.Application;
using VisaFusion.Identity;

namespace VisaFusion.Web.Areas.Admin.Pages.Users;

/// <summary>
/// User management list page (SPEC-0007 T021, US2, FR-005..007/FR-023,
/// AC-003/AC-018; legacy `addNewUser.asp`/`deleteUser.asp`).
///
/// The list is a read-only surface over the Identity store (there is no
/// business rule to route through <see cref="IUserManagementService"/> for the
/// listing itself), while the deactivate action routes through the shared
/// service so the su-target rule (FR-007) and the audit event (spec §19) apply
/// exactly as on the API surface. The audit actor AND the actor's roles are
/// resolved from the authenticated principal — never from the request body
/// (GR-0004). Only `adm`/`emp` pass the <c>UserManagement</c> policy (DP-001;
/// `su` passes via the inherited `adm` claim).
/// </summary>
[Authorize(Policy = AuthorizationPolicies.UserManagement)]
public class ListModel : PageModel
{
    private readonly IUserManagementService _users;
    private readonly UserManager<IdentityIntegration.VisaFusionUser> _userManager;

    public ListModel(
        IUserManagementService users,
        UserManager<IdentityIntegration.VisaFusionUser> userManager)
    {
        _users = users;
        _userManager = userManager;
    }

    /// <summary>A user row for the list table.</summary>
    public sealed record UserRow(
        string Id, string UserName, string? Email, IReadOnlyList<string> Roles, bool Active);

    public List<UserRow> Users { get; private set; } = new();

    /// <summary>Inline outcome message mirroring the endpoint problem-details.</summary>
    public string? OutcomeMessage { get; private set; }

    public string? OutcomeError { get; private set; }

    public async Task OnGetAsync()
    {
        ViewData["Title"] = "Users";
        ViewData["UseSidebar"] = true;

        Users = await LoadUsersAsync();
    }

    public async Task<IActionResult> OnPostDeactivateAsync(string id)
    {
        ViewData["Title"] = "Users";
        ViewData["UseSidebar"] = true;

        var actor = await ResolveActorAsync();
        if (actor is null)
        {
            return RedirectToPage("/Auth/Login");
        }

        try
        {
            var user = await _users.DeactivateAsync(
                id, actor.Value.UserId, actor.Value.UserName, actor.Value.Roles);
            OutcomeMessage = $"User {user.UserName} deactivated. The login is now locked.";
        }
        catch (UserManagementValidationException ex)
        {
            // FR-007 (su-target) or other service-level rule — inline message.
            OutcomeError = ex.Message;
        }
        catch (UserManagementNotFoundException ex)
        {
            OutcomeError = ex.Message;
        }

        Users = await LoadUsersAsync();
        return Page();
    }

    private async Task<List<UserRow>> LoadUsersAsync()
    {
        var users = await _userManager.Users
            .OrderBy(u => u.UserName)
            .ToListAsync();

        var rows = new List<UserRow>(users.Count);
        foreach (var user in users)
        {
            var roles = await _userManager.GetRolesAsync(user);
            // Active = not locked (FR-023) — the same rule the service's
            // ToSummaryAsync applies, kept in sync here for the page display.
            var active = !user.LockoutEnabled
                || user.LockoutEnd is null
                || user.LockoutEnd <= DateTimeOffset.UtcNow;
            rows.Add(new UserRow(
                user.Id, user.UserName ?? string.Empty, user.Email, roles.ToList(), active));
        }

        return rows;
    }

    /// <summary>
    /// Resolves the audit actor (user id + username) and the actor's roles from
    /// the authenticated cookie principal — the same source the API endpoints
    /// use (JWT `name`/`nameidentifier` claims). The roles feed the service's
    /// su-target re-check (FR-007).
    /// </summary>
    private async Task<(string UserId, string UserName, IReadOnlyList<string> Roles)?> ResolveActorAsync()
    {
        var user = await _userManager.GetUserAsync(User);
        if (user is null)
        {
            return null;
        }

        var roles = await _userManager.GetRolesAsync(user);
        return (user.Id, user.UserName ?? string.Empty, roles.ToList());
    }
}
