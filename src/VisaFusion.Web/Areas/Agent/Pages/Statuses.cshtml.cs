using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using VisaFusion.Core.Application;
using VisaFusion.Identity;

namespace VisaFusion.Web.Areas.Agent.Pages;

/// <summary>
/// Agent passenger-statuses page (SPEC-0007 T031, US4, FR-018/FR-021, AC-012;
/// legacy `agentpaxStatus.asp`).
///
/// Thin Razor Pages wrapper over the shared <see cref="IAgentService"/>
/// <see cref="IAgentService.GetPortalStatusesAsync"/> — the same single
/// implementation the `GET /api/v1/agents/{id}/statuses` endpoint uses
/// (contracts/agents-api.md §3a) — so the page and the API can never diverge.
/// The agent id is the claim-bound id resolved from the authenticated user row
/// (<see cref="AgentPortalPageModel"/>), never a query string (GR-0004). The
/// <c>?q=</c> keyword filter (FR-021) matches passenger name or exact ref no.,
/// exactly as on the API surface.
/// </summary>
public class StatusesModel : AgentPortalPageModel
{
    private readonly IAgentService _agents;

    public StatusesModel(
        IAgentService agents,
        UserManager<IdentityIntegration.VisaFusionUser> userManager)
        : base(userManager)
    {
        _agents = agents;
    }

    [BindProperty(SupportsGet = true)]
    public string? Q { get; set; }

    /// <summary>The scoped statuses list; null when unlinked (CHK026).</summary>
    public AgentPortalStatusesResult? Result { get; private set; }

    public async Task OnGetAsync()
    {
        ViewData["Title"] = "Passenger statuses";
        ViewData["UseSidebar"] = true;

        await ResolveAgentIdAsync();
        if (HasNoLinkedAgent) return;

        Result = await _agents.GetPortalStatusesAsync(
            AgentId!.Value, string.IsNullOrWhiteSpace(Q) ? null : Q.Trim());
    }
}
