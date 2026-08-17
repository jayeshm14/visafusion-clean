using Microsoft.AspNetCore.Authorization;
using VisaFusion.Identity;

namespace VisaFusion.Api.Authorization;

/// <summary>
/// Authorization policy catalog (SPEC-0005 T028, US4, FR-010; spec §5).
///
/// The 11 policies are derived from the §4.2 module × role matrix
/// (`library/complete_migration_plan.md` §4.2): each module's display-only gate
/// becomes a hard server-side denial (fixes the "no role-denial check exists"
/// finding, deepanalysis §2.1).
///
/// - 10 policies are role-based: <see cref="RoleSets"/> maps each policy to the
///   exact matrix role set for its module.
/// - <see cref="SuperUserOnly"/> is claim-based (plan.md §4.1/§10): `su`
///   accounts carry the <see cref="IdentityClaims.SuperUserClaimType"/> claim so
///   su-provisioning is gated separately from ordinary admin actions (FR-008).
/// </summary>
public static class AuthorizationPolicies
{
    public const string EntryOperations = "EntryOperations";
    public const string AgentSelf = "AgentSelf";
    public const string AgentLedger = "AgentLedger";
    public const string BillingOperations = "BillingOperations";
    public const string Search = "Search";
    public const string UserManagement = "UserManagement";
    public const string HolidayAdmin = "HolidayAdmin";
    public const string SecurityGate = "SecurityGate";
    public const string PasswordSelf = "PasswordSelf";
    public const string AdminPanel = "AdminPanel";
    public const string SuperUserOnly = "SuperUserOnly";

    /// <summary>
    /// Policy → role set, verbatim from the §4.2 matrix cells
    /// (complete_migration_plan.md §4.2). SuperUserOnly is deliberately absent:
    /// it is the claim-based su gate.
    /// </summary>
    public static IReadOnlyDictionary<string, string[]> RoleSets { get; } =
        new Dictionary<string, string[]>
        {
            [EntryOperations] = new[] { IdentityIntegration.Roles.Employee, IdentityIntegration.Roles.Admin, IdentityIntegration.Roles.SuperUser },
            [AgentSelf] = new[] { IdentityIntegration.Roles.Agent, IdentityIntegration.Roles.Employee, IdentityIntegration.Roles.Admin, IdentityIntegration.Roles.SuperUser },
            [AgentLedger] = new[] { IdentityIntegration.Roles.Agent, IdentityIntegration.Roles.Employee, IdentityIntegration.Roles.Admin, IdentityIntegration.Roles.SuperUser },
            [BillingOperations] = new[] { IdentityIntegration.Roles.Employee, IdentityIntegration.Roles.Admin, IdentityIntegration.Roles.SuperUser },
            [Search] = new[] { IdentityIntegration.Roles.Agent, IdentityIntegration.Roles.Employee, IdentityIntegration.Roles.Admin, IdentityIntegration.Roles.SuperUser },
            [UserManagement] = new[] { IdentityIntegration.Roles.Admin, IdentityIntegration.Roles.Employee },
            [HolidayAdmin] = new[] { IdentityIntegration.Roles.Admin, IdentityIntegration.Roles.SuperUser },
            [SecurityGate] = new[] { IdentityIntegration.Roles.Admin, IdentityIntegration.Roles.SuperUser },
            [PasswordSelf] = new[] { IdentityIntegration.Roles.Agent, IdentityIntegration.Roles.Employee, IdentityIntegration.Roles.Admin, IdentityIntegration.Roles.SuperUser },
            [AdminPanel] = new[] { IdentityIntegration.Roles.Admin, IdentityIntegration.Roles.SuperUser },
        };

    /// <summary>
    /// Registers the catalog with the host's authorization options. The value
    /// `"true"` mirrors IdentityClaims' SuperUser claim value (identity claim
    /// contract, contracts/auth-api.md §1).
    /// </summary>
    public static void Register(AuthorizationOptions options)
    {
        foreach (var (name, roles) in RoleSets)
        {
            options.AddPolicy(name, policy => policy.RequireRole(roles));
        }

        options.AddPolicy(SuperUserOnly, policy => policy
            .RequireClaim(IdentityClaims.SuperUserClaimType, "true"));
    }
}