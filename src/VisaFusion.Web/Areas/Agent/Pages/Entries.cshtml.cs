using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using VisaFusion.Core.Application;
using VisaFusion.Identity;

namespace VisaFusion.Web.Areas.Agent.Pages;

/// <summary>
/// Agent entries page (SPEC-0007 T031, US4, FR-017/FR-021, AC-012; legacy
/// `listforagents.asp`).
///
/// Thin Razor Pages wrapper over the shared <see cref="IAgentService"/>
/// <see cref="IAgentService.GetPortalEntriesAsync"/> — the same single
/// implementation the `GET /api/v1/agents/{id}/entries` endpoint uses
/// (contracts/agents-api.md §3) — so the page and the API can never diverge.
/// The agent id is the claim-bound id resolved from the authenticated user row
/// (<see cref="AgentPortalPageModel"/>), never a query string (GR-0004). The
/// <c>?q=</c> keyword filter (FR-021) matches passenger name or exact ref no.,
/// exactly as on the API surface. Default page size 50, max 200 (contract
/// General).
/// </summary>
public class EntriesModel : AgentPortalPageModel
{
    private const int PageSize = 50;

    private readonly IAgentService _agents;

    public EntriesModel(
        IAgentService agents,
        UserManager<IdentityIntegration.VisaFusionUser> userManager)
        : base(userManager)
    {
        _agents = agents;
    }

    [BindProperty(SupportsGet = true)]
    public int PageNumber { get; set; } = 1;

    [BindProperty(SupportsGet = true)]
    public string? Q { get; set; }

    /// <summary>The scoped entries list; null when unlinked (CHK026).</summary>
    public AgentPortalEntriesResult? Result { get; private set; }

    public async Task OnGetAsync()
    {
        ViewData["Title"] = "My entries";
        ViewData["UseSidebar"] = true;

        await ResolveAgentIdAsync();
        if (HasNoLinkedAgent) return;

        Result = await _agents.GetPortalEntriesAsync(
            AgentId!.Value, PageNumber, PageSize, string.IsNullOrWhiteSpace(Q) ? null : Q.Trim());
    }
}
