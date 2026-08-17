using System.Security.Claims;
using VisaFusion.Api.Authorization;
using VisaFusion.Identity;

namespace VisaFusion.UnitTests;

/// <summary>
/// Own-agent scoping unit tests (SPEC-0007 T027, US4, BR-007/BR-008, AC-012/
/// AC-013/AC-014, CHK026; contracts/agents-api.md §2/§3/§3a/§4).
///
/// The scoping rule is the single decision point every portal route shares:
///   - <c>agt</c> callers may only read/update their OWN record — the
///     claim-bound AgentId must equal the requested id (BR-007, AC-012);
///   - an <c>agt</c> without a linked AgentId claim is denied (CHK026);
///   - <c>emp</c>/<c>adm</c>/<c>su</c> may read any agent (contract §3/§3a/§4)
///     but carry no AgentId claim, so the self-update route denies them
///     (contract §2 — they use the admin update route instead).
/// </summary>
public class AgentScopingTests
{
    [Fact]
    public void Agent_With_Matching_Claim_Can_Read_Own_Record()
    {
        var principal = Principal(IdentityIntegration.Roles.Agent, agentId: 42);

        Assert.True(AgentPortalScoping.CanRead(principal, 42));
    }

    [Fact]
    public void Agent_With_Mismatched_Claim_Cannot_Read_Another_Agents_Record()
    {
        var principal = Principal(IdentityIntegration.Roles.Agent, agentId: 42);

        Assert.False(AgentPortalScoping.CanRead(principal, 43));
    }

    [Fact]
    public void Agent_Without_AgentId_Claim_Is_Denied()
    {
        // CHK026: an agt without a linked AgentId claim → 403 on portal routes.
        var principal = Principal(IdentityIntegration.Roles.Agent, agentId: null);

        Assert.False(AgentPortalScoping.CanRead(principal, 42));
    }

    [Fact]
    public void Employee_Can_Read_Any_Agent()
    {
        var principal = Principal(IdentityIntegration.Roles.Employee, agentId: null);

        Assert.True(AgentPortalScoping.CanRead(principal, 42));
        Assert.True(AgentPortalScoping.CanRead(principal, 43));
    }

    [Fact]
    public void Admin_Can_Read_Any_Agent()
    {
        var principal = Principal(IdentityIntegration.Roles.Admin, agentId: null);

        Assert.True(AgentPortalScoping.CanRead(principal, 42));
    }

    [Fact]
    public void SuperUser_Can_Read_Any_Agent()
    {
        var principal = Principal(IdentityIntegration.Roles.SuperUser, agentId: null);

        Assert.True(AgentPortalScoping.CanRead(principal, 42));
    }

    [Fact]
    public void Null_Principal_Is_Denied()
    {
        Assert.False(AgentPortalScoping.CanRead(null, 42));
    }

    [Fact]
    public void Agent_With_Matching_Claim_Can_Update_Own_Record()
    {
        var principal = Principal(IdentityIntegration.Roles.Agent, agentId: 42);

        Assert.True(AgentPortalScoping.CanUpdateSelf(principal, 42));
    }

    [Fact]
    public void Agent_With_Mismatched_Claim_Cannot_Update_Another_Agents_Record()
    {
        var principal = Principal(IdentityIntegration.Roles.Agent, agentId: 42);

        Assert.False(AgentPortalScoping.CanUpdateSelf(principal, 43));
    }

    [Fact]
    public void Agent_Without_AgentId_Claim_Cannot_Update_Own_Record()
    {
        var principal = Principal(IdentityIntegration.Roles.Agent, agentId: null);

        Assert.False(AgentPortalScoping.CanUpdateSelf(principal, 42));
    }

    [Fact]
    public void Staff_Without_AgentId_Claim_Cannot_Use_The_Self_Update_Route()
    {
        // emp/adm/su carry no AgentId claim — the self route is own-only
        // (contract §2); they use the admin update route instead.
        var employee = Principal(IdentityIntegration.Roles.Employee, agentId: null);
        var admin = Principal(IdentityIntegration.Roles.Admin, agentId: null);

        Assert.False(AgentPortalScoping.CanUpdateSelf(employee, 42));
        Assert.False(AgentPortalScoping.CanUpdateSelf(admin, 42));
    }

    private static ClaimsPrincipal Principal(string role, int? agentId)
    {
        var claims = new List<Claim> { new(ClaimTypes.Role, role) };
        if (agentId.HasValue)
        {
            claims.Add(new Claim(IdentityClaims.AgentIdClaimType, agentId.Value.ToString()));
        }

        return new ClaimsPrincipal(new ClaimsIdentity(claims, "test"));
    }
}