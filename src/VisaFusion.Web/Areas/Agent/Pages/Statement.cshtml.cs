using Microsoft.AspNetCore.Identity;
using VisaFusion.Core.Application;
using VisaFusion.Identity;

namespace VisaFusion.Web.Areas.Agent.Pages;

/// <summary>
/// Agent statement page (SPEC-0007 T031, US4, FR-019, BR-008; legacy
/// `agentStatement*`).
///
/// Thin Razor Pages wrapper over the shared <see cref="IAgentService"/>
/// <see cref="IAgentService.GetPortalStatementAsync"/> — the same single
/// implementation the `GET /api/v1/agents/{id}/statement` endpoint uses
/// (contracts/agents-api.md §4) — so the page and the API can never diverge.
/// The agent id is the claim-bound id resolved from the authenticated user row
/// (<see cref="AgentPortalPageModel"/>), never a query string (GR-0004). Shows
/// the ledger lines with the debit/credit/balance summary exactly as the API
/// returns it (FR-019, BR-008).
/// </summary>
public class StatementModel : AgentPortalPageModel
{
    private readonly IAgentService _agents;

    public StatementModel(
        IAgentService agents,
        UserManager<IdentityIntegration.VisaFusionUser> userManager)
        : base(userManager)
    {
        _agents = agents;
    }

    /// <summary>The scoped statement; null when unlinked (CHK026).</summary>
    public AgentStatementResult? Result { get; private set; }

    public async Task OnGetAsync()
    {
        ViewData["Title"] = "Statement";
        ViewData["UseSidebar"] = true;

        await ResolveAgentIdAsync();
        if (HasNoLinkedAgent) return;

        Result = await _agents.GetPortalStatementAsync(AgentId!.Value);
    }
}
