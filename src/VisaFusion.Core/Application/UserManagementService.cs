namespace VisaFusion.Core.Application;

/// <summary>
/// Signals a validation failure in the user-management workflow (SPEC-0007
/// US2, FR-006/FR-023, BR-004). The API layer maps this to a 400
/// problem-details response (contracts/admin-api.md §4/§5/§6).
/// </summary>
public sealed class UserManagementValidationException : Exception
{
    public UserManagementValidationException(string message) : base(message) { }
}

/// <summary>
/// Signals a not-found condition in the user-management workflow (SPEC-0007
/// US2, FR-023). The API layer maps this to a 404 problem-details response
/// (contracts/admin-api.md §6).
/// </summary>
public sealed class UserManagementNotFoundException : Exception
{
    public UserManagementNotFoundException(string message) : base(message) { }
}

/// <summary>
/// Signals a conflict in the user-management workflow (SPEC-0007 US2, FR-006,
/// CHK025): a duplicate username on create. The API layer maps this to a 409
/// problem-details response (contracts/admin-api.md §4).
/// </summary>
public sealed class UserManagementConflictException : Exception
{
    public UserManagementConflictException(string message) : base(message) { }
}

/// <summary>
/// The user-creation input (SPEC-0007 US2, FR-006, BR-004; contracts/admin-api.md
/// §4). The role is validated against the whitelist (<c>adm</c>, <c>emp</c>,
/// <c>agt</c>, <c>guest</c>); <c>su</c> is rejected here and only reachable via
/// the su-only provisioning path (FR-006). When the role is <c>agt</c>, the
/// <c>AgentId</c> claim link is required (contract §4, CHK026): the account must
/// reference an existing agent row so the agent-portal scoping (BR-007) can bind.
/// </summary>
public sealed record CreateUserInput(
    string Username, string Password, string? Email, string Role, int? AgentId = null);

/// <summary>
/// A user as surfaced to callers (SPEC-0007 US2; contracts/admin-api.md §4/§6).
/// <c>Active</c> reflects the deactivation state (FR-023): a deactivated user
/// has the linked login locked.
/// </summary>
public sealed record UserSummary(
    string Id,
    string UserName,
    string? Email,
    IReadOnlyList<string> Roles,
    bool Active);

/// <summary>
/// The user-management rules (SPEC-0007 US2, FR-006/FR-023, BR-004; AC-003,
/// AC-018; contracts/admin-api.md §4/§5/§6).
///
/// The implementation lives in VisaFusion.Api (approved deviation, deviation
/// log §8): every operation touches the Identity store (UserManager) and the
/// audit log (VisaEntryDbContext). VisaFusion.Data cannot reference
/// VisaFusion.Identity (Identity → Data is one-way; a reverse reference would
/// be a cycle), so the flow is hosted in the Api layer — the exact mirror of
/// the RegistrationFlow precedent (SPEC-0005 T040).
/// </summary>
public interface IUserManagementService
{
    /// <summary>
    /// Creates a user with a whitelisted role (SPEC-0007 FR-006, BR-004,
    /// AC-003; contracts/admin-api.md §4). <c>su</c> is rejected with
    /// <see cref="UserManagementValidationException"/> (400) — super-users are
    /// only created via <see cref="ProvisionSuperUserAsync"/>. A duplicate
    /// username throws <see cref="UserManagementConflictException"/> (409,
    /// CHK025). The password is hashed by the Identity store and delivered
    /// out-of-band (CHK002). Writes the user-creation audit event (spec §19).
    /// </summary>
    Task<UserSummary> CreateAsync(
        CreateUserInput input, string actorUserId, string actorUserName,
        CancellationToken ct = default);

    /// <summary>
    /// Deactivates a user (SPEC-0007 FR-023, AC-018; contracts/admin-api.md §6):
    /// the linked login is locked so authentication is rejected; the row and
    /// audit references are preserved; reversible. Deactivating an <c>su</c>
    /// target additionally requires the actor to be <c>su</c> (FR-007) — the
    /// endpoint enforces the policy, the service re-checks the target role and
    /// throws <see cref="UserManagementValidationException"/> when the actor is
    /// not <c>su</c>. Throws <see cref="UserManagementNotFoundException"/> when
    /// the user id does not exist. Writes the deactivation audit event (spec §19).
    /// </summary>
    Task<UserSummary> DeactivateAsync(
        string userId, string actorUserId, string actorUserName,
        IReadOnlyList<string> actorRoles, CancellationToken ct = default);

    /// <summary>
    /// Provisions a super-user (SPEC-0007 FR-006, AC-003; contracts/admin-api.md
    /// §5): grants the <c>su</c> role and the <c>SuperUser</c> claim. The
    /// su-only policy is enforced by the endpoint; the service re-checks the
    /// actor's roles and throws <see cref="UserManagementValidationException"/>
    /// when the actor is not <c>su</c>. Throws
    /// <see cref="UserManagementNotFoundException"/> when the target user does
    /// not exist. Writes the su-provisioning audit event (spec §19).
    /// </summary>
    Task<UserSummary> ProvisionSuperUserAsync(
        string userId, string actorUserId, string actorUserName,
        IReadOnlyList<string> actorRoles, CancellationToken ct = default);
}