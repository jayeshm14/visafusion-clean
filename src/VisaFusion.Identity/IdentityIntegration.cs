using Microsoft.AspNetCore.Identity;

namespace VisaFusion.Identity;

/// <summary>
/// Identity integration point (SPEC-0003 T051, FR-007).
///
/// Documents the mapping of the three legacy identity sources to ASP.NET Core
/// Identity (data-model.md §2). The concrete store implementation is deferred to
/// the Identity Consolidation feature; this class establishes the integration
/// point and the store contract placeholder.
///
/// Legacy mapping (data-model.md §2):
///   - `Udaan_users` (`su`,`adm`,`emp`) -> AspNetUsers with roles su/adm/emp,
///     external key `LegacyUdaanUserId`, `LockoutEnabled = !active`.
///   - `Udaan_users` (`agt` rows)        -> AspNetUsers role `agt`, external key
///     `LegacyUdaanUserId` + `AgentId -> agents.agentsID` (fixes the never-set
///     `session("agentid")`).
///   - `registration`                    -> AspNetUsers role `guest`, external key
///     `LegacyRegistrationId`; password hashed on import, never re-stored.
/// </summary>
public static class IdentityIntegration
{
    /// <summary>
    /// The ASP.NET Core Identity user type used across the solution.
    /// </summary>
    public sealed class VisaFusionUser : IdentityUser
    {
        /// <summary>Legacy `Udaan_users` primary key (su/adm/emp/agt rows).</summary>
        public int? LegacyUdaanUserId { get; set; }

        /// <summary>Legacy `registration` primary key (guest rows).</summary>
        public int? LegacyRegistrationId { get; set; }

        /// <summary>Legacy `agents.agentsID` for agent (agt) users.</summary>
        public int? AgentId { get; set; }
    }

    /// <summary>
    /// The role names carried over verbatim from `Udaan_users.privilege`
    /// (migration plan §4.1).
    /// </summary>
    public static class Roles
    {
        public const string SuperUser = "su";
        public const string Admin = "adm";
        public const string Employee = "emp";
        public const string Agent = "agt";
        public const string Guest = "guest";
    }
}