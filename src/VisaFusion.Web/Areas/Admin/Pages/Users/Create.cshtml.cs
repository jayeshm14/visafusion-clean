using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using VisaFusion.Api.Authorization;
using VisaFusion.Core.Application;
using VisaFusion.Identity;

namespace VisaFusion.Web.Areas.Admin.Pages.Users;

/// <summary>
/// User creation page (SPEC-0007 T021, US2, FR-006, BR-004, AC-003; legacy
/// `addNewUser.asp`/`editdonetest.asp`).
///
/// Thin Razor Pages wrapper over the shared <see cref="IUserManagementService"/>
/// — the same single implementation the `POST /api/v1/admin/users` endpoint
/// uses (contracts/admin-api.md §4) — so the page and the API can never
/// diverge. Field-level validation mirrors the contract: username/password/
/// role required, role whitelist `adm`/`emp`/`agt`/`guest` (`su` rejected,
/// BR-004), `agentId` required when the role is `agt` (claim link, CHK026).
/// The audit actor is resolved from the authenticated cookie principal — never
/// from the request body (GR-0004). Only `adm`/`emp` pass the
/// <c>UserManagement</c> policy (DP-001; `su` passes via the inherited `adm`
/// claim).
/// </summary>
[Authorize(Policy = AuthorizationPolicies.UserManagement)]
public class CreateModel : PageModel
{
    private readonly IUserManagementService _users;
    private readonly UserManager<IdentityIntegration.VisaFusionUser> _userManager;

    public CreateModel(
        IUserManagementService users,
        UserManager<IdentityIntegration.VisaFusionUser> userManager)
    {
        _users = users;
        _userManager = userManager;
    }

    [BindProperty]
    public string? Username { get; set; }

    [BindProperty]
    public string? Password { get; set; }

    [BindProperty]
    public string? Email { get; set; }

    [BindProperty]
    public string? Role { get; set; }

    [BindProperty]
    public int? AgentId { get; set; }

    /// <summary>The role whitelist (contract §4, BR-004) — `su` is not offered.</summary>
    public IReadOnlyList<string> AllowedRoles { get; } = new[]
    {
        IdentityIntegration.Roles.Admin,
        IdentityIntegration.Roles.Employee,
        IdentityIntegration.Roles.Agent,
        IdentityIntegration.Roles.Guest,
    };

    public void OnGet()
    {
        ViewData["Title"] = "New user";
        ViewData["UseSidebar"] = true;
    }

    public async Task<IActionResult> OnPostAsync()
    {
        ViewData["Title"] = "New user";
        ViewData["UseSidebar"] = true;

        // Field-level validation mirroring contracts/admin-api.md §4.
        if (string.IsNullOrWhiteSpace(Username))
        {
            ModelState.AddModelError(nameof(Username), "Login username is required.");
        }

        if (string.IsNullOrEmpty(Password))
        {
            ModelState.AddModelError(nameof(Password), "Initial password is required.");
        }

        if (string.IsNullOrWhiteSpace(Role))
        {
            ModelState.AddModelError(nameof(Role), "Role is required.");
        }
        else if (!AllowedRoles.Contains(Role, StringComparer.OrdinalIgnoreCase))
        {
            ModelState.AddModelError(nameof(Role), "Role must be one of: adm, emp, agt, guest.");
        }
        else if (string.Equals(Role, IdentityIntegration.Roles.Agent, StringComparison.OrdinalIgnoreCase)
                 && AgentId is null)
        {
            ModelState.AddModelError(nameof(AgentId), "Agent ID is required when the role is agt.");
        }

        if (!ModelState.IsValid)
        {
            return Page();
        }

        var actor = await ResolveActorAsync();
        if (actor is null)
        {
            return RedirectToPage("/Auth/Login");
        }

        try
        {
            var created = await _users.CreateAsync(
                new CreateUserInput(
                    Username!.Trim(),
                    Password!,
                    string.IsNullOrWhiteSpace(Email) ? null : Email.Trim(),
                    Role!.Trim(),
                    AgentId),
                actor.Value.UserId,
                actor.Value.UserName);

            return RedirectToPage("List");
        }
        catch (UserManagementValidationException ex)
        {
            // Contract §4: whitelist / agentId-link rules — inline message.
            ModelState.AddModelError(string.Empty, ex.Message);
            return Page();
        }
        catch (UserManagementConflictException ex)
        {
            // Contract §4, CHK025: duplicate username — inline message.
            ModelState.AddModelError(nameof(Username), ex.Message);
            return Page();
        }
    }

    /// <summary>
    /// Resolves the audit actor from the authenticated cookie principal — the
    /// same source the API endpoints use (JWT `name`/`nameidentifier` claims).
    /// </summary>
    private async Task<(string UserId, string UserName)?> ResolveActorAsync()
    {
        var user = await _userManager.GetUserAsync(User);
        return user is null ? null : (user.Id, user.UserName ?? string.Empty);
    }
}