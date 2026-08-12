using System.Security.Claims;
using VisaFusion.Api.Authorization;
using VisaFusion.Identity;

namespace VisaFusion.UnitTests;

/// <summary>
/// Claim-resolution unit tests (SPEC-0005 T006, US1, FR-007/FR-008).
///
/// Asserts the claim contract minted at login (contracts/auth-api.md §1):
///   - roles carried as `ClaimTypes.Role` (one claim per effective role),
///   - `su` ⇒ role `adm` is added and a distinct `SuperUser` claim is set
///     (FR-008),
///   - `agt` principals with a bound `AgentId` carry the `AgentId` claim
///     (FR-007) — the claim, never a query string, is the agent identity,
///   - the `AgentId`-from-claims helper tolerates a missing/invalid value.
/// </summary>
public class IdentityClaimsTests
{
    [Fact]
    public void EffectiveRoles_Adds_Admin_For_SuperUser()
    {
        var effective = IdentityClaims.EffectiveRoles(new[] { IdentityIntegration.Roles.SuperUser });

        Assert.Equal(new[] { IdentityIntegration.Roles.SuperUser, IdentityIntegration.Roles.Admin }, effective);
    }

    [Fact]
    public void EffectiveRoles_Deduplicates_SuperUser_And_Admin()
    {
        var effective = IdentityClaims.EffectiveRoles(new[]
        {
            IdentityIntegration.Roles.Admin,
            IdentityIntegration.Roles.SuperUser,
            IdentityIntegration.Roles.Admin,
        });

        Assert.Equal(2, effective.Count);
        Assert.Contains(IdentityIntegration.Roles.SuperUser, effective);
        Assert.Contains(IdentityIntegration.Roles.Admin, effective);
    }

    [Fact]
    public void EffectiveRoles_Leaves_Other_Roles_Untouched()
    {
        var effective = IdentityClaims.EffectiveRoles(new[]
        {
            IdentityIntegration.Roles.Employee,
            IdentityIntegration.Roles.Agent,
            IdentityIntegration.Roles.Guest,
        });

        Assert.Equal(
            new[] { IdentityIntegration.Roles.Employee, IdentityIntegration.Roles.Agent, IdentityIntegration.Roles.Guest },
            effective);
    }

    [Fact]
    public void FromUser_SuperUser_Carries_Admin_Role_And_SuperUser_Claim()
    {
        var user = NewUser("root", role: IdentityIntegration.Roles.SuperUser);

        var claims = IdentityClaims.FromUser(user, new[] { IdentityIntegration.Roles.SuperUser });

        var roleClaims = claims.Where(c => c.Type == ClaimTypes.Role).Select(c => c.Value).ToArray();
        Assert.Equal(
            new[] { IdentityIntegration.Roles.SuperUser, IdentityIntegration.Roles.Admin },
            roleClaims);
        var superUser = claims.SingleOrDefault(c => c.Type == IdentityClaims.SuperUserClaimType);
        Assert.NotNull(superUser);
        Assert.Equal("true", superUser!.Value);
    }

    [Fact]
    public void FromUser_Agent_Carries_AgentId_Claim_When_Bound()
    {
        var user = NewUser("agent1", role: IdentityIntegration.Roles.Agent, agentId: 5771);

        var claims = IdentityClaims.FromUser(user, new[] { IdentityIntegration.Roles.Agent });

        Assert.Contains(claims, c => c.Type == IdentityClaims.AgentIdClaimType && c.Value == "5771");
        Assert.DoesNotContain(claims, c => c.Type == IdentityClaims.SuperUserClaimType);
    }

    [Fact]
    public void FromUser_Agent_Without_AgentId_Has_No_AgentId_Claim()
    {
        var user = NewUser("agent2", role: IdentityIntegration.Roles.Agent, agentId: null);

        var claims = IdentityClaims.FromUser(user, new[] { IdentityIntegration.Roles.Agent });

        Assert.DoesNotContain(claims, c => c.Type == IdentityClaims.AgentIdClaimType);
    }

    [Fact]
    public void FromUser_Guest_Has_Only_Guest_Role_Claim()
    {
        var user = NewUser("guest1", role: IdentityIntegration.Roles.Guest);

        var claims = IdentityClaims.FromUser(user, new[] { IdentityIntegration.Roles.Guest });

        var roleClaims = claims.Where(c => c.Type == ClaimTypes.Role).Select(c => c.Value).ToArray();
        Assert.Equal(new[] { IdentityIntegration.Roles.Guest }, roleClaims);
        Assert.DoesNotContain(claims, c => c.Type == IdentityClaims.AgentIdClaimType);
        Assert.DoesNotContain(claims, c => c.Type == IdentityClaims.SuperUserClaimType);
    }

    [Fact]
    public void FromUser_Carries_Username_As_Sub_And_Name()
    {
        var user = NewUser("tester", role: IdentityIntegration.Roles.Guest);

        var claims = IdentityClaims.FromUser(user, new[] { IdentityIntegration.Roles.Guest });

        // contracts/auth-api.md §1: token claims `name`/`sub` (username).
        Assert.Contains(claims, c => c.Type == System.IdentityModel.Tokens.Jwt.JwtRegisteredClaimNames.Sub && c.Value == "tester");
        Assert.Contains(claims, c => c.Type == ClaimTypes.Name && c.Value == "tester");
    }

    [Fact]
    public void GetAgentId_Returns_Claim_Value()
    {
        var principal = PrincipalWith(new Claim(IdentityClaims.AgentIdClaimType, "42"));

        Assert.Equal(42, IdentityClaims.GetAgentId(principal));
    }

    [Fact]
    public void GetAgentId_Returns_Null_When_Claim_Absent()
    {
        Assert.Null(IdentityClaims.GetAgentId(PrincipalWith()));
    }

    [Fact]
    public void GetAgentId_Returns_Null_When_Claim_Not_Numeric()
    {
        var principal = PrincipalWith(new Claim(IdentityClaims.AgentIdClaimType, "not-a-number"));

        Assert.Null(IdentityClaims.GetAgentId(principal));
    }

    [Fact]
    public void IsSuperUser_True_Only_For_Exact_True_Value()
    {
        Assert.True(IdentityClaims.IsSuperUser(PrincipalWith(new Claim(IdentityClaims.SuperUserClaimType, "true"))));
        Assert.False(IdentityClaims.IsSuperUser(PrincipalWith(new Claim(IdentityClaims.SuperUserClaimType, "TRUE"))));
        Assert.False(IdentityClaims.IsSuperUser(PrincipalWith(new Claim(IdentityClaims.SuperUserClaimType, "1"))));
        Assert.False(IdentityClaims.IsSuperUser(PrincipalWith()));
    }

    private static IdentityIntegration.VisaFusionUser NewUser(string userName, string role, int? agentId = null)
    {
        var user = new IdentityIntegration.VisaFusionUser
        {
            UserName = userName,
            AgentId = agentId,
        };
        _ = role; // role is passed via FromUser's roles collection, not stored on the user.
        return user;
    }

    private static ClaimsPrincipal PrincipalWith(params Claim[] claims)
        => new(new ClaimsIdentity(claims, "test"));
}
