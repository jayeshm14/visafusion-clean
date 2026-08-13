using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Authorization.Infrastructure;
using VisaFusion.Api.Authorization;
using VisaFusion.Identity;

namespace VisaFusion.UnitTests;

/// <summary>
/// Policy-catalog unit tests (SPEC-0005 T024, US4, FR-010; spec §5, §4.2).
///
/// Asserts the authorization policy catalog derived from the §4.2 module × role
/// matrix (`library/complete_migration_plan.md` §4.2): each of the 10 role-based
/// policies maps to exactly the matrix's role set for its module, and
/// SuperUserOnly is the claim-based su gate (plan.md §4.1/§10: su accounts get
/// the `SuperUser` claim so su-provisioning is gated separately from ordinary
/// admin actions).
/// </summary>
public class AuthorizationPoliciesTests
{
    [Theory]
    [MemberData(nameof(RoleBasedPolicies))]
    public void RoleBased_Policy_Maps_To_The_Section_4_2_Role_Set(string policyName, string[] expectedRoles)
    {
        var options = new AuthorizationOptions();
        AuthorizationPolicies.Register(options);

        var policy = options.GetPolicy(policyName);
        Assert.NotNull(policy);

        var requirement = Assert.Single(policy!.Requirements.OfType<RolesAuthorizationRequirement>());
        Assert.Equal(
            expectedRoles.OrderBy(r => r, StringComparer.Ordinal),
            requirement.AllowedRoles.OrderBy(r => r, StringComparer.Ordinal));
    }

    [Fact]
    public void SuperUserOnly_Requires_The_SuperUser_Claim()
    {
        // plan.md §4.1/§10: su accounts carry a `SuperUser` claim so
        // [Authorize(Policy="SuperUserOnly")] gates su-provisioning separately
        // from ordinary admin actions (FR-008).
        var options = new AuthorizationOptions();
        AuthorizationPolicies.Register(options);

        var policy = options.GetPolicy(AuthorizationPolicies.SuperUserOnly);
        Assert.NotNull(policy);

        var requirement = Assert.Single(policy!.Requirements.OfType<ClaimsAuthorizationRequirement>());
        Assert.Equal(IdentityClaims.SuperUserClaimType, requirement.ClaimType);
        Assert.Equal(new[] { "true" }, requirement.AllowedValues);
    }

    [Fact]
    public void RoleSets_Contains_Exactly_The_10_Role_Based_Policies()
    {
        var expected = new[]
        {
            AuthorizationPolicies.EntryOperations,
            AuthorizationPolicies.AgentSelf,
            AuthorizationPolicies.AgentLedger,
            AuthorizationPolicies.BillingOperations,
            AuthorizationPolicies.Search,
            AuthorizationPolicies.UserManagement,
            AuthorizationPolicies.HolidayAdmin,
            AuthorizationPolicies.SecurityGate,
            AuthorizationPolicies.PasswordSelf,
            AuthorizationPolicies.AdminPanel,
        };

        Assert.Equal(
            expected.OrderBy(n => n, StringComparer.Ordinal),
            AuthorizationPolicies.RoleSets.Keys.OrderBy(n => n, StringComparer.Ordinal));
    }

    public static IEnumerable<object[]> RoleBasedPolicies()
    {
        // Role sets verbatim from the §4.2 matrix (complete_migration_plan.md §4.2).
        yield return new object[] { AuthorizationPolicies.EntryOperations, new[] { IdentityIntegration.Roles.Employee, IdentityIntegration.Roles.Admin, IdentityIntegration.Roles.SuperUser } };
        yield return new object[] { AuthorizationPolicies.AgentSelf, new[] { IdentityIntegration.Roles.Agent, IdentityIntegration.Roles.Employee, IdentityIntegration.Roles.Admin, IdentityIntegration.Roles.SuperUser } };
        yield return new object[] { AuthorizationPolicies.AgentLedger, new[] { IdentityIntegration.Roles.Agent, IdentityIntegration.Roles.Employee, IdentityIntegration.Roles.Admin, IdentityIntegration.Roles.SuperUser } };
        yield return new object[] { AuthorizationPolicies.BillingOperations, new[] { IdentityIntegration.Roles.Employee, IdentityIntegration.Roles.Admin, IdentityIntegration.Roles.SuperUser } };
        yield return new object[] { AuthorizationPolicies.Search, new[] { IdentityIntegration.Roles.Agent, IdentityIntegration.Roles.Employee, IdentityIntegration.Roles.Admin, IdentityIntegration.Roles.SuperUser } };
        yield return new object[] { AuthorizationPolicies.UserManagement, new[] { IdentityIntegration.Roles.Admin, IdentityIntegration.Roles.SuperUser } };
        yield return new object[] { AuthorizationPolicies.HolidayAdmin, new[] { IdentityIntegration.Roles.Admin, IdentityIntegration.Roles.SuperUser } };
        yield return new object[] { AuthorizationPolicies.SecurityGate, new[] { IdentityIntegration.Roles.Admin, IdentityIntegration.Roles.SuperUser } };
        yield return new object[] { AuthorizationPolicies.PasswordSelf, new[] { IdentityIntegration.Roles.Agent, IdentityIntegration.Roles.Employee, IdentityIntegration.Roles.Admin, IdentityIntegration.Roles.SuperUser } };
        yield return new object[] { AuthorizationPolicies.AdminPanel, new[] { IdentityIntegration.Roles.Admin, IdentityIntegration.Roles.SuperUser } };
    }
}