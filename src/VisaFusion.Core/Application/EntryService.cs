namespace VisaFusion.Core.Application;

/// <summary>
/// Signals a validation failure in the entry workflow (SPEC-0006 US1/US3,
/// FR-002/FR-005). The API layer maps this to a 400 problem-details response
/// (contracts/entries-api.md §1/§4).
/// </summary>
public sealed class EntryValidationException : Exception
{
    public EntryValidationException(string message) : base(message) { }
}

/// <summary>
/// Signals a not-found condition in the entry workflow (SPEC-0006 US1/US3,
/// FR-002/FR-005). The API layer maps this to a 404 problem-details response
/// (contracts/entries-api.md §2/§4/§5).
/// </summary>
public sealed class EntryNotFoundException : Exception
{
    public EntryNotFoundException(string message) : base(message) { }
}

/// <summary>
/// Signals a conflict in the entry workflow (SPEC-0006 US1/US6, FR-002,
/// AC-011): a duplicate reference number or a stale optimistic-concurrency
/// write. The API layer maps this to a 409 problem-details response
/// (contracts/entries-api.md §1/§3).
/// </summary>
public sealed class EntryConflictException : Exception
{
    public EntryConflictException(string message) : base(message) { }
}

/// <summary>
/// A passenger row of an entry aggregate (SPEC-0006 US1, FR-001/002, BR-005).
/// Core-level projection of the legacy `entryDetails` row — the interface lives
/// in Core, which cannot reference Data entities (one-way Data → Core), so the
/// aggregate is surfaced as these records.
/// </summary>
public sealed record EntryPassengerData(
    int Id,
    string? Paxname,
    string? Passportno,
    DateTime? DateOfBirth,
    int? Category);

/// <summary>
/// A per-pax-per-country status row of an entry aggregate (SPEC-0006 US1,
/// BR-005). Core-level projection of the legacy `PaxStatus` chain.
/// </summary>
public sealed record PaxStatusData(
    int? PaxId,
    int? CountryId,
    int? StatusId,
    string? Remarks,
    decimal? Visafee,
    decimal? Handlingfee,
    decimal? Ddcharges,
    decimal? Couriercharges,
    decimal? Misccharges,
    decimal? Total,
    decimal? VFSTTCharges);

/// <summary>
/// The entry aggregate as returned by <see cref="IEntryService"/> (SPEC-0006
/// US1, FR-001/002). Carries the principal passenger fields, the passenger
/// list, the per-pax-per-country status chain, and the optimistic-concurrency
/// token (<see cref="RowVersion"/>, AC-011).
/// </summary>
public sealed record EntryAggregate(
    int Refno,
    string? Paxname,
    string? Passportno,
    int? Agent,
    int? Status,
    DateTime? TravelDate,
    DateTime? Subdate,
    DateTime? Coldate,
    DateTime? Receivedate,
    DateTime? SentDate,
    int? TotalPassengers,
    IReadOnlyList<EntryPassengerData> Passengers,
    IReadOnlyList<PaxStatusData> PaxStatuses,
    byte[]? RowVersion);

/// <summary>
/// Command to create an entry (SPEC-0006 US1, FR-002, AC-002). The principal
/// passenger is carried at the entry level (legacy `insertEntry.asp` writes
/// `paxname`/`passportno` on the `Mainentry` row); the ≥ 1-passenger invariant
/// (BR-005) is enforced by the service.
/// </summary>
public sealed record CreateEntryCommand(
    string? Paxname,
    string? Passportno,
    DateTime? DateOfBirth,
    int? Category,
    int? TotalPassengers,
    DateTime? TravelDate,
    string? Remarks,
    string? AgentInstruction);

/// <summary>
/// Result of a successful entry create (SPEC-0006 US1, AC-002): the allocated
/// reference number, the concurrency token, and the created aggregate.
/// </summary>
public sealed record CreateEntryResult(
    int Refno,
    byte[]? RowVersion,
    EntryAggregate Entry);

/// <summary>
/// Command to record an audited status change (SPEC-0006 US3, FR-005, AC-004).
/// <see cref="ActorUserId"/> is the authenticated caller's <c>AspNetUsers.Id</c>
/// resolved server-side from the JWT `sub` claim — never a caller-supplied
/// formatted actor string (anti-spoofing, GR-0004).
/// </summary>
public sealed record RecordStatusChangeCommand(
    int Refno,
    int PaxId,
    int CountryId,
    int NewStatusId,
    string? Remarks,
    DateTime? ChangeDate,
    string ActorUserId);

/// <summary>
/// Result of a recorded status change (SPEC-0006 US3, AC-004): the new
/// <c>StatusHistory</c> id and the <c>{role}:{username}</c> actor string
/// composed by the proc (GR-0004).
/// </summary>
public sealed record StatusChangeResult(
    long StatusHistoryId,
    string UpdatedBy);

/// <summary>
/// Command to record a sent-AWB event (SPEC-0006 US6, FR-008;
/// contracts/entries-api.md §5). Backs the legacy <c>sendawbgo</c> page. The
/// <c>Awb</c> is required (legacy guard sendawbgo.asp:24); the entry's owning
/// agent id is resolved from the entry aggregate, never from the request.
/// </summary>
public sealed record RecordAwbCommand(
    string Awb,
    string? ToEmail,
    string? Remark);

/// <summary>
/// The authenticated actor performing an entry create/update (SPEC-0006 §19
/// audit, T040; FR-002/FR-008). Resolved server-side by the API layer from the
/// validated JWT claims — never from the request body (anti-spoofing, GR-0004).
/// <see cref="UserName"/> is the claim-bound username (<c>sub</c>/<c>name</c>,
/// IdentityClaims.cs:66) and <see cref="EffectiveRoles"/> the claim-bound
/// effective role set (<c>role</c> claims; <c>su</c> already expands to
/// <c>su</c>+<c>adm</c>, IdentityClaims.cs:36). The service composes the
/// <c>bighistory</c> <c>UpdatedBy</c> = <c>{role}:{username}</c> with the same
/// su &gt; adm &gt; emp &gt; agt precedence as <c>usp_RecordEntryStatusChange</c>
/// (script 08:70-89) so the create/update audit rows are indistinguishable in
/// format from the proc-written rows.
/// </summary>
public sealed record EntryActor(
    string UserName,
    IReadOnlyList<string> EffectiveRoles);

/// <summary>
/// Shared entry-aggregate service (SPEC-0006 US1/US2/US3, FR-001..FR-005,
/// BR-001/BR-002/BR-005, AC-002/AC-003/AC-004).
///
/// The interface lives in Core as the single-source rule shared by the Web UI
/// and the API (CHK045); the implementation lives in VisaFusion.Data because it
/// queries <c>VisaEntryDbContext</c> and Core must not reference Data (one-way
/// Data → Core; approved deviation, deviation log §5 — exact mirror of the
/// <c>ISecurityGateService</c> precedent).
/// </summary>
public interface IEntryService
{
    /// <summary>
    /// Creates an entry aggregate (SPEC-0006 US1, FR-002, AC-002). Enforces the
    /// ≥ 1-passenger invariant (BR-005) and a valid reference number; status is
    /// free-form per legacy (no transition validation, clarification Q3).
    /// The caller allocates the reference number first (US2) and passes it in.
    /// Writes the create-audit <c>bighistory</c> row in the same commit
    /// (spec §19; legacy insertEntry.asp:233), <c>UpdatedBy</c> composed
    /// <c>{role}:{username}</c> from <paramref name="actor"/> (GR-0004).
    /// </summary>
    Task<CreateEntryResult> CreateAsync(
        int refno, CreateEntryCommand command, EntryActor actor, CancellationToken ct = default);

    /// <summary>
    /// Loads an entry aggregate by reference number with its passengers and
    /// per-pax-per-country status chain (SPEC-0006 US1, FR-002). Returns null
    /// when the refno does not exist.
    /// </summary>
    Task<EntryAggregate?> GetByRefnoAsync(int refno, CancellationToken ct = default);

    /// <summary>
    /// Updates an entry aggregate (SPEC-0006 US6, FR-008, AC-011). The caller
    /// supplies the <c>expectedRowVersion</c> from the <c>If-Match</c> ETag; a
    /// stale write (the current rowversion differs) throws
    /// <see cref="EntryConflictException"/> (409) and writes no audit row.
    /// Writes the update-audit <c>bighistory</c> row in the same commit as the
    /// change (spec §19 subject/endpoint/outcome; legacy editEntrySubmit.asp:189),
    /// <c>UpdatedBy</c> composed <c>{role}:{username}</c> (GR-0004). Returns the
    /// updated aggregate with a fresh concurrency token.
    /// </summary>
    Task<CreateEntryResult> UpdateAsync(
        int refno, CreateEntryCommand command, byte[] expectedRowVersion,
        EntryActor actor, CancellationToken ct = default);

    /// <summary>
    /// Allocates the next reference number atomically via
    /// <c>usp_AllocateNextRefno</c> (SPEC-0006 US2, FR-003/004, BR-001, AC-003).
    /// The proc returns <c>BIGINT</c>; the value is converted to <c>int</c> for
    /// <c>Entry.Refno</c> (data-model.md §2; deviation log §2).
    /// </summary>
    Task<int> AllocateRefnoAsync(CancellationToken ct = default);

    /// <summary>
    /// Records an audited status change via <c>usp_RecordEntryStatusChange</c>
    /// (SPEC-0006 US3, FR-005, BR-002, AC-004). The proc atomically updates
    /// <c>PaxStatus.statusID</c> and writes <c>StatusHistory</c> + <c>bighistory</c>
    /// in one transaction.
    /// </summary>
    Task<StatusChangeResult> RecordStatusChangeAsync(RecordStatusChangeCommand command, CancellationToken ct = default);

    /// <summary>
    /// Records a sent-AWB event for the entry (SPEC-0006 US6, FR-008;
    /// contracts/entries-api.md §5). Backs the legacy <c>sendawbgo</c> page:
    /// the owning agent id is resolved from the entry aggregate, and a
    /// duplicate (agentsid, awb) pair is a no-op (legacy dedupe,
    /// sendawbgo.asp:65-71). Throws <see cref="EntryNotFoundException"/> when
    /// the refno does not exist and <see cref="EntryValidationException"/>
    /// when the awb is empty.
    /// </summary>
    Task RecordAwbAsync(int refno, RecordAwbCommand command, CancellationToken ct = default);
}