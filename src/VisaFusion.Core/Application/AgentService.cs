namespace VisaFusion.Core.Application;

/// <summary>
/// Signals a validation failure in the agent workflow (SPEC-0007 US1,
/// FR-001/FR-003/FR-004). The API layer maps this to a 400 problem-details
/// response (contracts/agents-api.md §1/§6/§7).
/// </summary>
public sealed class AgentValidationException : Exception
{
    public AgentValidationException(string message) : base(message) { }
}

/// <summary>
/// Signals a not-found condition in the agent workflow (SPEC-0007 US1,
/// FR-003/FR-004). The API layer maps this to a 404 problem-details response
/// (contracts/agents-api.md §1/§7).
/// </summary>
public sealed class AgentNotFoundException : Exception
{
    public AgentNotFoundException(string message) : base(message) { }
}

/// <summary>
/// Signals a conflict in the agent workflow (SPEC-0007 US1, FR-001, BR-009,
/// CHK025): a duplicate login username on create. The API layer maps this to a
/// 409 problem-details response (contracts/agents-api.md §6).
/// </summary>
public sealed class AgentConflictException : Exception
{
    public AgentConflictException(string message) : base(message) { }
}

/// <summary>
/// The writable agent fields (SPEC-0007 US1; contracts/agents-api.md §1/§6).
/// Core-level projection of the legacy `agents` row — the interface lives in
/// Core, which cannot reference Data entities (one-way Data → Core), so the
/// record is the shared input shape. All fields are optional on update
/// (contract §1: at least one field required); on create only
/// <c>Companyname</c> is required (contract §6).
/// </summary>
public sealed record AgentInput(
    string? Companyname,
    string? Description,
    string? Street1,
    string? Street2,
    string? Area,
    string? City,
    string? Pincode,
    string? Phoneno,
    string? Faxno,
    string? Emailid,
    string? Smsno,
    string? Directorname,
    string? DirectorPH,
    string? AcMgrPH,
    string? VisaInchargeName,
    string? VisaInchargePH,
    string? Acno,
    string? Payment,
    string? TAAI,
    string? TAFI,
    string? Membership,
    string? IATA);

/// <summary>
/// The agent as surfaced to callers (SPEC-0007 US1; contracts/agents-api.md
/// §1/§5/§6). Includes the lifecycle state (<c>Active</c>, R-007 convention:
/// <c>'Y'</c> active, <c>'N'</c> deactivated) and the creation audit fields.
/// </summary>
public sealed record AgentDetail(
    int Id,
    string? Companyname,
    string? Description,
    string? Street1,
    string? Street2,
    string? Area,
    string? City,
    string? Pincode,
    string? Phoneno,
    string? Faxno,
    string? Emailid,
    string? Smsno,
    string? Directorname,
    string? DirectorPH,
    string? AcMgrPH,
    string? VisaInchargeName,
    string? VisaInchargePH,
    string? Acno,
    string? Payment,
    string? TAAI,
    string? TAFI,
    string? Membership,
    string? IATA,
    string? Active,
    DateTime? Creationdate,
    string? Enteredby);

/// <summary>
/// Paginated agent list (SPEC-0007 US1; contracts/agents-api.md §5).
/// </summary>
public sealed record AgentListResult(IReadOnlyList<AgentDetail> Items, int Total);

/// <summary>
/// One of an agent's entries as surfaced to the agent portal (SPEC-0007 US4,
/// FR-017/FR-021; contracts/agents-api.md §3). Maps the legacy `Mainentry` row
/// (`listforagents.asp`): refno, principal paxname, travel date, and the
/// entry's status — <c>StatusDescription</c> is the description the legacy page
/// renders via <c>writeIDDescription("status", statusid)</c>.
/// </summary>
public sealed record AgentPortalEntry(
    int Refno,
    string? Paxname,
    DateTime? Traveldate,
    int? Status,
    string? StatusDescription);

/// <summary>
/// Paginated agent entries list (SPEC-0007 US4, FR-017; contracts/agents-api.md
/// §3). Default page size 50, max 200 (contract General).
/// </summary>
public sealed record AgentPortalEntriesResult(IReadOnlyList<AgentPortalEntry> Items, int Total);

/// <summary>
/// One passenger status row as surfaced to the agent portal (SPEC-0007 US4,
/// FR-018/FR-021; contracts/agents-api.md §3a). Maps the legacy
/// <c>PaxStatus</c> chain joined to <c>entryDetails</c> and <c>Mainentry</c>
/// (<c>agentpaxStatus.asp</c>): paxname, refno, the status description
/// (resolved via the <c>status</c> lookup), and <c>Updated</c> = the
/// <c>Subdate</c> of the current status row (the submission date the legacy
/// page displays).
/// </summary>
public sealed record AgentPortalStatus(
    string? Paxname,
    int Refno,
    int? CountryId,
    int? StatusId,
    string? StatusDescription,
    DateTime? Updated);

/// <summary>
/// The agent's passenger statuses list (SPEC-0007 US4, FR-018;
/// contracts/agents-api.md §3a).
/// </summary>
public sealed record AgentPortalStatusesResult(IReadOnlyList<AgentPortalStatus> Items);

/// <summary>
/// One ledger line of the agent's financial statement (SPEC-0007 US4, FR-019;
/// contracts/agents-api.md §4). Maps the legacy <c>Ledger</c> row exactly as
/// <c>agentStatement.asp</c> renders it: date, bank, transaction type, ref no.,
/// paxname, debit, credit, balance (plus the voucher type/no. pair the page
/// derives from <c>reftype</c>/<c>invno</c>).
/// </summary>
public sealed record AgentStatementLine(
    int Id,
    DateTime? Date,
    int? Bank,
    string? TransactionType,
    int? Refno,
    string? Paxname,
    string? Reftype,
    int? Invno,
    decimal? Debit,
    decimal? Credit,
    decimal? Balance);

/// <summary>
/// The agent's financial statement (SPEC-0007 US4, FR-019; contracts/agents-api.md
/// §4): the ledger lines plus the summary totals (total debits, total credits,
/// and the running balance — the last line's balance, the same figure the
/// legacy page's final row shows).
/// </summary>
public sealed record AgentStatementResult(
    IReadOnlyList<AgentStatementLine> Items,
    decimal? TotalDebits,
    decimal? TotalCredits,
    decimal? Balance);

/// <summary>
/// The agent lifecycle rules (SPEC-0007 US1, FR-001..004, FR-022; AC-001,
/// AC-016, AC-017; contracts/agents-api.md §1/§6/§7).
///
/// The implementation lives in VisaFusion.Api (approved deviation, deviation
/// log §8): the atomic create (BR-009) and the deactivate/reactivate lock
/// (FR-004/FR-022) must touch BOTH the legacy `agents` row (VisaEntryDbContext)
/// AND the linked Identity login (UserManager). VisaFusion.Data cannot
/// reference VisaFusion.Identity (Identity → Data is one-way; a reverse
/// reference would be a cycle), so the flow is hosted in the Api layer — the
/// exact mirror of the RegistrationFlow precedent (SPEC-0005 T040).
/// </summary>
public interface IAgentService
{
    /// <summary>
    /// Creates the agent row and the linked <c>agt</c> login atomically
    /// (SPEC-0007 FR-001, BR-009, AC-017; contracts/agents-api.md §6). The
    /// <c>username</c> must be unique — a duplicate throws
    /// <see cref="AgentConflictException"/> (409, CHK025). The initial
    /// <c>password</c> is hashed by the Identity store and never stored in
    /// plaintext; it is delivered out-of-band (CHK002). On any failure after
    /// the agent row is inserted, the fresh unreferenced row is rolled back
    /// (FR-004 allows deleting unreferenced records). The <c>Active</c> flag is
    /// set to the active convention <c>'Y'</c> (R-007).
    /// </summary>
    Task<AgentDetail> CreateAsync(
        AgentInput input, string username, string password,
        string actorUserId, string actorUserName, CancellationToken ct = default);

    /// <summary>
    /// Updates the agent fields (SPEC-0007 FR-003, AC-001; contracts/agents-api.md
    /// §1). At least one field must be set (contract §1); the lifecycle flag
    /// <c>Active</c> is NOT updatable here — it is managed exclusively by
    /// <see cref="DeactivateAsync"/> / <see cref="ReactivateAsync"/>. Throws
    /// <see cref="AgentNotFoundException"/> when the id does not exist.
    /// </summary>
    Task<AgentDetail> UpdateAsync(int agentId, AgentInput patch, CancellationToken ct = default);

    /// <summary>
    /// Deactivates the agent (SPEC-0007 FR-004, FR-022, AC-016; contracts/agents-api.md
    /// §7): sets <c>Active</c> to the inactive convention <c>'N'</c> (R-007) and
    /// locks the linked login so authentication is rejected (FR-004). Data rows
    /// and audit references are preserved; nothing is deleted. Reversible via
    /// <see cref="ReactivateAsync"/>. Throws <see cref="AgentNotFoundException"/>
    /// when the id does not exist. Writes the deactivation audit event (spec §19).
    /// </summary>
    Task<AgentDetail> DeactivateAsync(
        int agentId, string actorUserId, string actorUserName, CancellationToken ct = default);

    /// <summary>
    /// Reactivates the agent (SPEC-0007 FR-022, AC-016; contracts/agents-api.md
    /// §7): sets <c>Active</c> back to <c>'Y'</c> and unlocks the linked login.
    /// Throws <see cref="AgentNotFoundException"/> when the id does not exist.
    /// Writes the reactivation audit event (spec §19).
    /// </summary>
    Task<AgentDetail> ReactivateAsync(
        int agentId, string actorUserId, string actorUserName, CancellationToken ct = default);

    /// <summary>
    /// Loads a single agent (SPEC-0007 FR-003, AC-001; contracts/agents-api.md
    /// §1/§5). Returns null when the id does not exist.
    /// </summary>
    Task<AgentDetail?> GetByIdAsync(int agentId, CancellationToken ct = default);

    /// <summary>
    /// Paginated agent list with an optional keyword filter on name/company
    /// (SPEC-0007 FR-002, AC-001; contracts/agents-api.md §5). Default page size
    /// 50, max 200 (contract General).
    /// </summary>
    Task<AgentListResult> ListAsync(
        int page, int pageSize, string? q, CancellationToken ct = default);

    /// <summary>
    /// The agent's entries list (SPEC-0007 FR-017, AC-012;
    /// contracts/agents-api.md §3, legacy <c>listforagents.asp</c>): all
    /// <c>Mainentry</c> rows owned by <paramref name="agentId"/>. Optional
    /// <c>q</c> keyword filter (FR-021, §3): matches paxname (substring, the
    /// legacy <c>Paxname LIKE '%q%'</c> filter) or an exact refno when <c>q</c>
    /// parses as an integer. Default page size 50, max 200 (contract General).
    /// </summary>
    Task<AgentPortalEntriesResult> GetPortalEntriesAsync(
        int agentId, int page, int pageSize, string? q, CancellationToken ct = default);

    /// <summary>
    /// The agent's passenger statuses (SPEC-0007 FR-018, AC-012;
    /// contracts/agents-api.md §3a, legacy <c>agentpaxStatus.asp</c>): one row
    /// per <c>PaxStatus</c> entry for the agent's entries, joined to
    /// <c>entryDetails</c> for paxname. Optional <c>q</c> keyword filter
    /// (FR-021, §3a): same refno/paxname semantics as
    /// <see cref="GetPortalEntriesAsync"/>.
    /// </summary>
    Task<AgentPortalStatusesResult> GetPortalStatusesAsync(
        int agentId, string? q, CancellationToken ct = default);

    /// <summary>
    /// The agent's financial statement (SPEC-0007 FR-019, BR-008;
    /// contracts/agents-api.md §4, legacy <c>agentStatement*</c>): the agent's
    /// <c>Ledger</c> lines plus the debit/credit/balance summary.
    /// </summary>
    Task<AgentStatementResult> GetPortalStatementAsync(
        int agentId, CancellationToken ct = default);
}