using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using VisaFusion.Core.Application;
using VisaFusion.Data.Persistence;
using VisaFusion.Data.Persistence.Entities;
using VisaFusion.Identity;

namespace VisaFusion.Api.Application;

/// <summary>
/// User-management service (SPEC-0007 US2, FR-006/FR-023, BR-004; AC-003,
/// AC-018; contracts/admin-api.md §4/§5/§6).
///
/// Placed in VisaFusion.Api (approved deviation, deviation log §8): every
/// operation touches the Identity store (UserManager) and the audit log
/// (VisaEntryDbContext). VisaFusion.Data cannot reference VisaFusion.Identity
/// (Identity → Data is one-way; a reverse reference would be a cycle), so the
/// flow is hosted in the Api layer — the exact mirror of the RegistrationFlow
/// precedent (SPEC-0005 T040). The interface (<see cref="IUserManagementService"/>)
/// is the shared Core rule.
/// </summary>
public sealed class UserManagementService : IUserManagementService
{
    // Role whitelist (BR-004, spec §12): su is NOT creatable here — it is only
    // reachable via the su-only provisioning path (FR-006).
    private static readonly string[] CreateWhitelist =
    {
        IdentityIntegration.Roles.Admin,
        IdentityIntegration.Roles.Employee,
        IdentityIntegration.Roles.Agent,
        IdentityIntegration.Roles.Guest,
    };

    private readonly VisaEntryDbContext _db;
    private readonly UserManager<IdentityIntegration.VisaFusionUser> _userManager;

    public UserManagementService(
        VisaEntryDbContext db,
        UserManager<IdentityIntegration.VisaFusionUser> userManager)
    {
        _db = db;
        _userManager = userManager;
    }

    public async Task<UserSummary> CreateAsync(
        CreateUserInput input, string actorUserId, string actorUserName,
        CancellationToken ct = default)
    {
        var username = input.Username?.Trim() ?? string.Empty;
        if (string.IsNullOrWhiteSpace(username))
        {
            throw new UserManagementValidationException("username is required.");
        }

        if (string.IsNullOrWhiteSpace(input.Password))
        {
            throw new UserManagementValidationException("password is required.");
        }

        // Role whitelist (BR-004, spec §12): su is rejected here (400) — the
        // su-only provisioning path is the only way to create a super-user.
        var role = input.Role?.Trim() ?? string.Empty;
        if (!CreateWhitelist.Contains(role, StringComparer.OrdinalIgnoreCase))
        {
            throw new UserManagementValidationException(
                $"role '{role}' is not creatable; allowed roles: adm, emp, agt, guest.");
        }

        // role=agt requires the AgentId claim link (contract §4, CHK026): the
        // account must reference an existing agent row so the agent-portal
        // scoping (BR-007) can bind — a user-created agt account can never be an
        // unlinked orphan (403 on every portal route).
        if (string.Equals(role, IdentityIntegration.Roles.Agent, StringComparison.OrdinalIgnoreCase)
            && input.AgentId is null)
        {
            throw new UserManagementValidationException("agentId is required when role is agt.");
        }

        if (input.AgentId is not null
            && !await _db.Agents.AnyAsync(a => a.Id == input.AgentId.Value, ct))
        {
            throw new UserManagementValidationException($"agent {input.AgentId.Value} does not exist.");
        }

        // Duplicate username → 409 (contracts/admin-api.md §4, CHK025).
        if (await _userManager.FindByNameAsync(username) is not null)
        {
            throw new UserManagementConflictException($"username '{username}' already exists.");
        }

        var user = new IdentityIntegration.VisaFusionUser
        {
            UserName = username,
            Email = string.IsNullOrWhiteSpace(input.Email) ? null : input.Email.Trim(),
            // The claim link is set only for agt roles (contract §4); a caller
            // passing an agentId for another role has it ignored.
            AgentId = string.Equals(role, IdentityIntegration.Roles.Agent, StringComparison.OrdinalIgnoreCase)
                ? input.AgentId
                : null,
        };

        var createResult = await _userManager.CreateAsync(user, input.Password);
        if (!createResult.Succeeded)
        {
            var isDuplicate = createResult.Errors.Any(e => e.Code is "DuplicateUserName" or "DuplicateEmail");
            throw isDuplicate
                ? new UserManagementConflictException($"username '{username}' already exists.")
                : new UserManagementValidationException(
                    string.Join("; ", createResult.Errors.Select(e => e.Description)));
        }

        var roleResult = await _userManager.AddToRoleAsync(user, role);
        if (!roleResult.Succeeded)
        {
            // Roll back the created user (RegistrationFlow precedent) so a
            // half-created account never blocks re-creation with a 409.
            await _userManager.DeleteAsync(user);
            throw new UserManagementValidationException(
                string.Join("; ", roleResult.Errors.Select(e => e.Description)));
        }

        // User-creation audit event (spec §19).
        _db.AdminAuditLogs.Add(new AdminAuditLog
        {
            EventType = "UserCreated",
            ActorUserId = actorUserId,
            ActorUserName = actorUserName,
            TargetUserId = user.Id,
            TargetUserName = user.UserName,
            Role = role,
            Date = DateTime.Now,
        });
        await _db.SaveChangesAsync(ct);

        return await ToSummaryAsync(user, ct);
    }

    public async Task<UserSummary> DeactivateAsync(
        string userId, string actorUserId, string actorUserName,
        IReadOnlyList<string> actorRoles, CancellationToken ct = default)
    {
        var user = await _userManager.FindByIdAsync(userId)
            ?? throw new UserManagementNotFoundException($"User {userId} was not found.");

        // Deactivating an su target additionally requires the actor to be su
        // (FR-007; contracts/admin-api.md §6). The endpoint enforces the policy
        // via SuperUserOnly; the service re-checks so the rule holds for every
        // caller.
        var targetRoles = await _userManager.GetRolesAsync(user);
        if (targetRoles.Contains(IdentityIntegration.Roles.SuperUser, StringComparer.OrdinalIgnoreCase)
            && !actorRoles.Contains(IdentityIntegration.Roles.SuperUser, StringComparer.OrdinalIgnoreCase))
        {
            throw new UserManagementValidationException(
                "Only a super-user can deactivate a super-user account.");
        }

        // Lock the login (FR-023): authentication is rejected; the row and
        // audit references are preserved; reversible.
        user.LockoutEnabled = true;
        user.LockoutEnd = DateTimeOffset.MaxValue;
        await _userManager.UpdateAsync(user);

        // Deactivation audit event (spec §19).
        _db.AdminAuditLogs.Add(new AdminAuditLog
        {
            EventType = "UserDeactivated",
            ActorUserId = actorUserId,
            ActorUserName = actorUserName,
            TargetUserId = user.Id,
            TargetUserName = user.UserName,
            Date = DateTime.Now,
        });
        await _db.SaveChangesAsync(ct);

        return await ToSummaryAsync(user, ct);
    }

    public async Task<UserSummary> ProvisionSuperUserAsync(
        string userId, string actorUserId, string actorUserName,
        IReadOnlyList<string> actorRoles, CancellationToken ct = default)
    {
        // su-only (FR-006, AC-003; contracts/admin-api.md §5). The endpoint
        // enforces the policy via SuperUserOnly; the service re-checks so the
        // rule holds for every caller.
        if (!actorRoles.Contains(IdentityIntegration.Roles.SuperUser, StringComparer.OrdinalIgnoreCase))
        {
            throw new UserManagementValidationException(
                "Only a super-user can provision a super-user account.");
        }

        var user = await _userManager.FindByIdAsync(userId)
            ?? throw new UserManagementNotFoundException($"User {userId} was not found.");

        // Grant the su role (idempotent — AddToRoleAsync is a no-op when the
        // role is already held).
        var roleResult = await _userManager.AddToRoleAsync(user, IdentityIntegration.Roles.SuperUser);
        if (!roleResult.Succeeded)
        {
            throw new UserManagementValidationException(
                string.Join("; ", roleResult.Errors.Select(e => e.Description)));
        }

        // su-provisioning audit event (spec §19, FR-006).
        _db.AdminAuditLogs.Add(new AdminAuditLog
        {
            EventType = "SuperUserProvisioned",
            ActorUserId = actorUserId,
            ActorUserName = actorUserName,
            TargetUserId = user.Id,
            TargetUserName = user.UserName,
            Role = IdentityIntegration.Roles.SuperUser,
            Date = DateTime.Now,
        });
        await _db.SaveChangesAsync(ct);

        return await ToSummaryAsync(user, ct);
    }

    private async Task<UserSummary> ToSummaryAsync(
        IdentityIntegration.VisaFusionUser user, CancellationToken ct)
    {
        var roles = await _userManager.GetRolesAsync(user);
        // Active = not locked (FR-023): a deactivated user has the linked login
        // locked (LockoutEnabled + far-future LockoutEnd).
        var active = !user.LockoutEnabled
            || user.LockoutEnd is null
            || user.LockoutEnd <= DateTimeOffset.UtcNow;

        return new UserSummary(
            user.Id,
            user.UserName ?? string.Empty,
            user.Email,
            roles.ToList(),
            active);
    }
}