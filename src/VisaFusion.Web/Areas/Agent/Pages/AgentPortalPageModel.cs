using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc.RazorPages;
using VisaFusion.Api.Authorization;
using VisaFusion.Identity;

namespace VisaFusion.Web.Areas.Agent.Pages;

/// <summary>
/// Shared base for the agent portal pages (SPEC-0007 T031, US4, FR-017..020,
/// BR-007/BR-008, CHK026; contracts/web-ui.md §2).
///
/// Resolves the claim-bound <c>AgentId</c> from the AUTHENTICATED user row
/// (<c>IdentityIntegration.VisaFusionUser.AgentId</c>) — the same authoritative
/// source <see cref="IdentityClaims.FromUser"/> mints the JWT <c>AgentId</c>
/// claim from (IdentityClaims.cs) — never from a query string or route value
/// (GR-0004). An authenticated principal with no linked agent (an
/// <c>agt</c>-less account, or an agt whose user row has no AgentId) is the
/// CHK026 case: the portal shows an explicit "no linked agent" state instead of
/// rendering another agent's data. The scoping decision itself lives in
/// <see cref="AgentPortalScoping"/> (shared with the API endpoints) — the page
/// models call it with the resolved id so page and API can never diverge.
/// </summary>
[Authorize(Policy = AuthorizationPolicies.AgentSelf)]
public abstract class AgentPortalPageModel : PageModel
{
    private readonly UserManager<IdentityIntegration.VisaFusionUser> _userManager;

    protected AgentPortalPageModel(UserManager<IdentityIntegration.VisaFusionUser> userManager)
    {
        _userManager = userManager;
    }

    /// <summary>The claim-bound agent id resolved from the authenticated user; null when unlinked (CHK026).</summary>
    public int? AgentId { get; private set; }

    /// <summary>True when the authenticated user has no linked agent (CHK026).</summary>
    public bool HasNoLinkedAgent { get; private set; }

    /// <summary>Resolves the agent id; call at the top of every handler.</summary>
    protected async Task ResolveAgentIdAsync()
    {
        var user = await _userManager.GetUserAsync(User);
        AgentId = user?.AgentId;
        HasNoLinkedAgent = user is null || !user.AgentId.HasValue;
    }
}
