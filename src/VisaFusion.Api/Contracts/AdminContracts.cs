using System.ComponentModel.DataAnnotations;

namespace VisaFusion.Api.Contracts;

/// <summary>
/// Request body for POST /api/v1/admin/users (SPEC-0007 US2, FR-005, BR-004,
/// AC-003; contracts/admin-api.md §4). Backs the legacy `addNewUser.asp`/
/// `editdonetest.asp`.
///
/// The role is validated server-side against the whitelist <c>adm</c>,
/// <c>emp</c>, <c>agt</c>, <c>guest</c> — <c>su</c> is rejected with 400
/// (BR-004, closing the legacy self-registration→SU escalation). When the role
/// is <c>agt</c>, <c>agentId</c> is required (CHK026): the account must
/// reference an existing agent row. The password is hashed by the Identity
/// store — never plaintext — and delivered out-of-band (CHK002).
/// </summary>
public sealed record CreateUserRequest
{
    /// <summary>Login username — required, unique (contract §4, CHK025).</summary>
    [Required]
    public string? Username { get; init; }

    /// <summary>Initial password — required, hashed at rest (contract §4, CHK002).</summary>
    [Required]
    public string? Password { get; init; }

    /// <summary>Whitelisted role: <c>adm</c>, <c>emp</c>, <c>agt</c>, <c>guest</c> (BR-004).</summary>
    [Required]
    public string? Role { get; init; }

    public string? Email { get; init; }

    /// <summary>Agent id — required when <c>role=agt</c> (claim link, CHK026).</summary>
    public int? AgentId { get; init; }
}

/// <summary>
/// Request body for POST /api/v1/admin/superusers (SPEC-0007 US2, FR-006,
/// AC-003; contracts/admin-api.md §5).
///
/// The <c>username</c> is an EXISTING account to elevate: the endpoint resolves
/// it to the user id and grants the <c>su</c> role (audited, spec §19). The
/// route itself is gated by the claim-based <c>SuperUserOnly</c> policy.
/// </summary>
public sealed record ProvisionSuperUserRequest
{
    /// <summary>Username of the existing account to elevate — required.</summary>
    [Required]
    public string? Username { get; init; }
}

/// <summary>
/// User response body (SPEC-0007 US2, FR-005..007/FR-023, AC-003/AC-018;
/// contracts/admin-api.md §4/§5/§6). <c>Active</c> reflects the deactivation
/// state (FR-023): a deactivated user has the linked login locked.
/// </summary>
public sealed record UserResponse
{
    public string Id { get; init; } = string.Empty;
    public string UserName { get; init; } = string.Empty;
    public string? Email { get; init; }
    public IReadOnlyList<string> Roles { get; init; } = Array.Empty<string>();
    public bool Active { get; init; }
}

/// <summary>
/// Request body for POST /api/v1/admin/security-day/open (SPEC-0007 US3,
/// FR-008, BR-003; contracts/admin-api.md §1). Backs the legacy
/// <c>openForDay.asp</c> (anonymous INSERT — now <c>adm</c>/<c>su</c> only).
///
/// The <c>date</c> defaults to the server-local today when omitted; the open
/// is atomic per date (unique <c>date1</c> index, CHK022) — a concurrent open
/// for the same date loses the race and receives 409.
/// </summary>
public sealed record OpenDayRequest
{
    /// <summary>The working day to open — defaults to the server-local today.</summary>
    public DateTime? Date { get; init; }
}

/// <summary>
/// Request body for POST /api/v1/admin/security-day/close (SPEC-0007 US3,
/// FR-008, BR-003; contracts/admin-api.md §2). Backs the legacy
/// <c>closeForDay.asp</c> (anonymous UPDATE — now <c>adm</c>/<c>su</c> only).
///
/// The <c>date</c> defaults to the server-local today when omitted; closing a
/// day with no open row yields 404 (CHK021).
/// </summary>
public sealed record CloseDayRequest
{
    /// <summary>The working day to close — defaults to the server-local today.</summary>
    public DateTime? Date { get; init; }
}

/// <summary>
/// Security-day response body (SPEC-0007 US3, FR-008, AC-004; contracts/
/// admin-api.md §1-§3). Backs the legacy <c>securityHome.asp</c> status view.
/// A <c>null</c> <c>OpeningTime</c> means no row exists for the date (the day
/// was never opened); a non-null <c>ClosingTime</c> means the day was closed.
/// </summary>
public sealed record SecurityDayResponse
{
    public DateTime Date { get; init; }
    public DateTime? OpeningTime { get; init; }
    public string? OpenedBy { get; init; }
    public DateTime? ClosingTime { get; init; }
    public string? ClosedBy { get; init; }
}
