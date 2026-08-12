using System.Globalization;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using Microsoft.AspNetCore.Identity;
using VisaFusion.Identity;

namespace VisaFusion.Api.Authorization;

/// <summary>
/// Claim contract for the login token (SPEC-0005 T010, US1, FR-007/FR-008;
/// contracts/auth-api.md §1).
///
/// The token carries:
///   - `name`/`sub` = username,
///   - `role` = one claim per EFFECTIVE role — `su` expands to `su` + `adm`
///     (FR-008) so super-users are also admins,
///   - `AgentId` = claim-bound agent identity for `agt` principals only
///     (FR-007) — never re-derived from a query string,
///   - `SuperUser` = "true" for `su` principals only (FR-008), so su-only
///     operations can be authorized separately from ordinary admin actions.
/// </summary>
public static class IdentityClaims
{
    /// <summary>Custom claim type carrying the agent identity bound at import (FR-007).</summary>
    public const string AgentIdClaimType = "AgentId";

    /// <summary>Custom claim type distinguishing super-users from ordinary admins (FR-008).</summary>
    public const string SuperUserClaimType = "SuperUser";

    private const string SuperUserTrue = "true";

    /// <summary>
    /// The effective role set for a principal. `su` implies `adm` (FR-008);
    /// duplicates (case-insensitive) are collapsed, first-seen order preserved.
    /// </summary>
    public static IReadOnlyList<string> EffectiveRoles(IEnumerable<string> roles)
    {
        var result = new List<string>();
        foreach (var role in roles ?? Array.Empty<string>())
        {
            if (!string.IsNullOrEmpty(role) && !result.Contains(role, StringComparer.OrdinalIgnoreCase))
            {
                result.Add(role);
            }
        }

        if (result.Contains(IdentityIntegration.Roles.SuperUser, StringComparer.OrdinalIgnoreCase)
            && !result.Contains(IdentityIntegration.Roles.Admin, StringComparer.OrdinalIgnoreCase))
        {
            result.Add(IdentityIntegration.Roles.Admin);
        }

        return result;
    }

    /// <summary>
    /// Builds the claim set minted into the login JWT for a user with the given
    /// roles (contracts/auth-api.md §1).
    /// </summary>
    public static IReadOnlyList<Claim> FromUser(
        IdentityIntegration.VisaFusionUser user, IEnumerable<string> roles)
    {
        var effective = EffectiveRoles(roles);
        var claims = new List<Claim>
        {
            new(JwtRegisteredClaimNames.Sub, user.UserName ?? string.Empty),
            new(ClaimTypes.Name, user.UserName ?? string.Empty),
        };

        foreach (var role in effective)
        {
            claims.Add(new Claim(ClaimTypes.Role, role));
        }

        if (effective.Contains(IdentityIntegration.Roles.SuperUser, StringComparer.OrdinalIgnoreCase))
        {
            claims.Add(new Claim(SuperUserClaimType, SuperUserTrue));
        }

        if (effective.Contains(IdentityIntegration.Roles.Agent, StringComparer.OrdinalIgnoreCase)
            && user.AgentId.HasValue)
        {
            claims.Add(new Claim(AgentIdClaimType, user.AgentId.Value.ToString(CultureInfo.InvariantCulture)));
        }

        return claims;
    }

    /// <summary>Resolves the claim-bound agent id from an authenticated principal; null when absent/invalid.</summary>
    public static int? GetAgentId(ClaimsPrincipal? principal)
    {
        var value = principal?.FindFirstValue(AgentIdClaimType);
        return value is not null
            && int.TryParse(value, NumberStyles.Integer, CultureInfo.InvariantCulture, out var agentId)
            ? agentId
            : null;
    }

    /// <summary>True when the principal carries the SuperUser claim (FR-008).</summary>
    public static bool IsSuperUser(ClaimsPrincipal? principal)
        => string.Equals(principal?.FindFirstValue(SuperUserClaimType), SuperUserTrue, StringComparison.Ordinal);
}
