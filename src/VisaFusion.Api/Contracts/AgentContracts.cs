using System.ComponentModel.DataAnnotations;

namespace VisaFusion.Api.Contracts;

/// <summary>
/// Request body for POST /api/v1/agents (SPEC-0007 US1, FR-001, BR-009, AC-017;
/// contracts/agents-api.md §6). Backs the legacy `addnewagents.asp`/`newagent.asp`.
///
/// The create is a single atomic operation: the agent row AND the linked `agt`
/// login (username/password) are created together (BR-009). The username must be
/// unique — a duplicate yields 409 (CHK025). The initial password is hashed by
/// the Identity store (never plaintext) and delivered out-of-band (CHK002).
/// The role is fixed server-side to `agt` — no caller input influences it (BR-004).
/// </summary>
public sealed record CreateAgentRequest
{
    /// <summary>Agent name — required (contract §6).</summary>
    [Required]
    public string? Companyname { get; init; }

    /// <summary>Login username — required, unique (contract §6, CHK025).</summary>
    [Required]
    public string? Username { get; init; }

    /// <summary>Initial password — required, hashed at rest (contract §6, CHK002).</summary>
    [Required]
    public string? Password { get; init; }

    public string? Description { get; init; }
    public string? Street1 { get; init; }
    public string? Street2 { get; init; }
    public string? Area { get; init; }
    public string? City { get; init; }
    public string? Pincode { get; init; }
    public string? Phoneno { get; init; }
    public string? Faxno { get; init; }
    public string? Emailid { get; init; }
    public string? Smsno { get; init; }
    public string? Directorname { get; init; }
    public string? DirectorPH { get; init; }
    public string? AcMgrPH { get; init; }
    public string? VisaInchargeName { get; init; }
    public string? VisaInchargePH { get; init; }
    public string? Acno { get; init; }
    public string? Payment { get; init; }
    public string? TAAI { get; init; }
    public string? TAFI { get; init; }
    public string? Membership { get; init; }
    public string? IATA { get; init; }
}

/// <summary>
/// Request body for PUT /api/v1/agents/{id} and PUT /api/v1/agents/{id}/self
/// (SPEC-0007 US1, FR-003/FR-020, AC-001/AC-014; contracts/agents-api.md §1/§2).
/// Backs the legacy `editdoneagent1.asp`/`editdonebyagent1.asp`.
///
/// Every field is optional on update; at least one must be present (contract §1,
/// enforced by the service). The lifecycle flag `Active` is never updatable here —
/// it is managed exclusively by the deactivate/reactivate endpoints.
/// </summary>
public sealed record UpdateAgentRequest
{
    public string? Companyname { get; init; }
    public string? Description { get; init; }
    public string? Street1 { get; init; }
    public string? Street2 { get; init; }
    public string? Area { get; init; }
    public string? City { get; init; }
    public string? Pincode { get; init; }
    public string? Phoneno { get; init; }
    public string? Faxno { get; init; }
    public string? Emailid { get; init; }
    public string? Smsno { get; init; }
    public string? Directorname { get; init; }
    public string? DirectorPH { get; init; }
    public string? AcMgrPH { get; init; }
    public string? VisaInchargeName { get; init; }
    public string? VisaInchargePH { get; init; }
    public string? Acno { get; init; }
    public string? Payment { get; init; }
    public string? TAAI { get; init; }
    public string? TAFI { get; init; }
    public string? Membership { get; init; }
    public string? IATA { get; init; }
}

/// <summary>
/// Agent response body (SPEC-0007 US1, FR-002/FR-003; contracts/agents-api.md
/// §1/§5/§6/§7). Includes the lifecycle state (<c>Active</c>, R-007 convention:
/// <c>'Y'</c> active, <c>'N'</c> deactivated) and the creation audit fields.
/// </summary>
public sealed record AgentResponse
{
    public int Id { get; init; }
    public string? Companyname { get; init; }
    public string? Description { get; init; }
    public string? Street1 { get; init; }
    public string? Street2 { get; init; }
    public string? Area { get; init; }
    public string? City { get; init; }
    public string? Pincode { get; init; }
    public string? Phoneno { get; init; }
    public string? Faxno { get; init; }
    public string? Emailid { get; init; }
    public string? Smsno { get; init; }
    public string? Directorname { get; init; }
    public string? DirectorPH { get; init; }
    public string? AcMgrPH { get; init; }
    public string? VisaInchargeName { get; init; }
    public string? VisaInchargePH { get; init; }
    public string? Acno { get; init; }
    public string? Payment { get; init; }
    public string? TAAI { get; init; }
    public string? TAFI { get; init; }
    public string? Membership { get; init; }
    public string? IATA { get; init; }
    public string? Active { get; init; }
    public DateTime? Creationdate { get; init; }
    public string? Enteredby { get; init; }
}

/// <summary>
/// Paginated agent-list response body for GET /api/v1/agents (SPEC-0007 US1,
/// FR-002, AC-001; contracts/agents-api.md §5). Backs the legacy `viewagent.asp`.
/// </summary>
public sealed record AgentListResponse
{
    public IReadOnlyList<AgentResponse> Items { get; init; } = Array.Empty<AgentResponse>();
    public int Total { get; init; }
}
