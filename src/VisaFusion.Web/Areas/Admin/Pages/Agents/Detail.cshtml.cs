using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using VisaFusion.Api.Authorization;
using VisaFusion.Core.Application;
using VisaFusion.Identity;

namespace VisaFusion.Web.Areas.Admin.Pages.Agents;

/// <summary>
/// Agent detail page (SPEC-0007 T015/T016, US1, FR-002/FR-004/FR-022, AC-001,
/// AC-016; legacy `viewagent.asp` detail view).
///
/// Thin Razor Pages wrapper over the shared <see cref="IAgentService"/> — the
/// same single implementation the `GET /api/v1/agents/{id}` and the
/// deactivate/reactivate endpoints use (contracts/agents-api.md §1/§7). The
/// lifecycle actions resolve the audit actor from the authenticated cookie
/// principal (never from the request body — GR-0004), mirroring the endpoint
/// behavior. Only `adm`/`su` pass the <c>AdminPanel</c> policy (AC-002).
/// </summary>
[Authorize(Policy = AuthorizationPolicies.AdminPanel)]
public class DetailModel : PageModel
{
    private readonly IAgentService _agents;
    private readonly UserManager<IdentityIntegration.VisaFusionUser> _userManager;

    public DetailModel(IAgentService agents, UserManager<IdentityIntegration.VisaFusionUser> userManager)
    {
        _agents = agents;
        _userManager = userManager;
    }

    [BindProperty(SupportsGet = true)]
    public int Id { get; set; }

    public AgentDetail? Agent { get; private set; }

    public bool IsNotFound { get; private set; }

    /// <summary>Inline outcome message mirroring the endpoint problem-details.</summary>
    public string? OutcomeMessage { get; private set; }

    public async Task OnGetAsync()
    {
        ViewData["Title"] = "Agent detail";
        ViewData["UseSidebar"] = true;

        Agent = await _agents.GetByIdAsync(Id);
        IsNotFound = Agent is null;
    }

    public async Task<IActionResult> OnPostDeactivateAsync()
    {
        ViewData["Title"] = "Agent detail";
        ViewData["UseSidebar"] = true;

        var actor = await ResolveActorAsync();
        if (actor is null)
        {
            return RedirectToPage("/Auth/Login");
        }

        try
        {
            Agent = await _agents.DeactivateAsync(Id, actor.Value.UserId, actor.Value.UserName);
            OutcomeMessage = $"Agent {Agent.Companyname} deactivated. The linked login is now locked.";
        }
        catch (AgentNotFoundException)
        {
            IsNotFound = true;
        }

        return Page();
    }

    public async Task<IActionResult> OnPostReactivateAsync()
    {
        ViewData["Title"] = "Agent detail";
        ViewData["UseSidebar"] = true;

        var actor = await ResolveActorAsync();
        if (actor is null)
        {
            return RedirectToPage("/Auth/Login");
        }

        try
        {
            Agent = await _agents.ReactivateAsync(Id, actor.Value.UserId, actor.Value.UserName);
            OutcomeMessage = $"Agent {Agent.Companyname} reactivated. The linked login is unlocked.";
        }
        catch (AgentNotFoundException)
        {
            IsNotFound = true;
        }

        return Page();
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