namespace VisaFusion.Data.Persistence.Entities;

/// <summary>
/// Admin/user-management audit events (SPEC-0007 §19; contracts/admin-api.md
/// §4/§5/§6). One row per audited event: user creation/deactivation,
/// su provisioning, security-day open/close. Written in the SAME commit as the
/// change it records (spec §19) so a failed operation never leaves an audit
/// gap. The actor is always the authenticated caller resolved server-side from
/// the JWT (GR-0004 anti-spoofing) — never a caller-supplied string.
/// </summary>
public class AdminAuditLog
{
    /// <summary>Identity primary key.</summary>
    public int Id { get; set; }

    /// <summary>
    /// Event type: <c>UserCreated</c>, <c>UserDeactivated</c>,
    /// <c>UserReactivated</c>, <c>SuperUserProvisioned</c>,
    /// <c>SecurityDayOpened</c>, <c>SecurityDayClosed</c>.
    /// </summary>
    public string EventType { get; set; } = string.Empty;

    /// <summary>The authenticated actor's AspNetUsers.Id (GR-0004).</summary>
    public string ActorUserId { get; set; } = string.Empty;

    /// <summary>The authenticated actor's username.</summary>
    public string ActorUserName { get; set; } = string.Empty;

    /// <summary>The target user's AspNetUsers.Id (user events); null otherwise.</summary>
    public string? TargetUserId { get; set; }

    /// <summary>The target user's username (user events); null otherwise.</summary>
    public string? TargetUserName { get; set; }

    /// <summary>The role granted on user creation; null otherwise.</summary>
    public string? Role { get; set; }

    /// <summary>Event timestamp.</summary>
    public DateTime Date { get; set; }

    /// <summary>Free-form detail (e.g. the security-day date for open/close events).</summary>
    public string? Detail { get; set; }
}