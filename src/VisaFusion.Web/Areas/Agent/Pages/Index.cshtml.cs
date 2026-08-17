using Microsoft.AspNetCore.Identity;
using VisaFusion.Core.Application;
using VisaFusion.Identity;

namespace VisaFusion.Web.Areas.Agent.Pages;

/// <summary>
/// Agent portal home page (SPEC-0007 T031, US4, FR-017; legacy
/// `agentHome.asp`). Shows the agent's company identity resolved from the
/// claim-bound id (<see cref="AgentPortalPageModel"/>), the portal navigation,
/// and the CHK026 "no linked agent" state for unlinked accounts.
/// </summary>
public class IndexModel : AgentPortalPageModel
{
    private readonly IAgentService _agents;

    public IndexModel(
        IAgentService agents,
        UserManager<IdentityIntegration.VisaFusionUser> userManager)
        : base(userManager)
    {
        _agents = agents;
    }

    /// <summary>The linked agent's detail; null when unlinked (CHK026) or missing.</summary>
    public AgentDetail? Agent { get; private set; }

    public async Task OnGetAsync()
    {
        ViewData["Title"] = "Agent portal";
        ViewData["UseSidebar"] = true;

        await ResolveAgentIdAsync();
        if (HasNoLinkedAgent) return;

        Agent = await _agents.GetByIdAsync(AgentId!.Value);
    }
}
