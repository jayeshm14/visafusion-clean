using System.Security.Claims;
using VisaFusion.Identity;

namespace VisaFusion.Api.Authorization;

/// <summary>
/// Own-agent scoping rules for the agent portal (SPEC-0007 US4, BR-007, BR-008,
/// AC-012/AC-013/AC-014, CHK026; contracts/agents-api.md §2/§3/§3a/§4).
///
/// All scoping decisions are based on the claim-bound <see cref="IdentityClaims.AgentIdClaimType"/>
/// minted into the JWT at login — never on a query string or route-supplied
/// identity (BR-007, AC-013).
/// </summary>
public static class AgentPortalScoping
{
    /// <summary>
    /// May the principal read the agent record/entries/statuses/statement of
    /// <paramref name="agentId"/>? <c>agt</c> callers may only read their OWN
    /// record — the claim-bound AgentId must equal the requested id (BR-007,
    /// AC-012). An <c>agt</c> without a linked AgentId claim is denied (CHK026).
    /// <c>emp</c>/<c>adm</c>/<c>su</c> may read any agent (contract §3/§3a/§4).
    /// </summary>
    public static bool CanRead(ClaimsPrincipal? principal, int agentId)
    {
        if (principal is null) return false;

        if (principal.IsInRole(IdentityIntegration.Roles.Agent))
        {
            var bound = IdentityClaims.GetAgentId(principal);
            return bound.HasValue && bound.Value == agentId;
        }

        return true;
    }

    /// <summary>
    /// May the principal update their own record via <c>PUT /agents/{id}/self</c>?
    /// The route id must equal the claim-bound AgentId (FR-020, AC-014, BR-007).
    /// <c>emp</c>/<c>adm</c>/<c>su</c> carry no AgentId claim — they use the
    /// admin update route instead (contract §2).
    /// </summary>
    public static bool CanUpdateSelf(ClaimsPrincipal? principal, int agentId)
    {
        if (principal is null) return false;

        var bound = IdentityClaims.GetAgentId(principal);
        return bound.HasValue && bound.Value == agentId;
    }
}
