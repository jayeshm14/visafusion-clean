namespace VisaFusion.Api.Contracts;

/// <summary>
/// A passenger row inside an entry response (SPEC-0006 US6, FR-008;
/// contracts/entries-api.md §2). Maps the legacy `entryDetails` row for the
/// principal passenger (the entry-level fields duplicate the principal's data
/// in the legacy schema; the aggregate carries its own `EntryPassenger`
/// child with the same values).
/// </summary>
public sealed record EntryPassengerResponse
{
    public int Id { get; init; }
    public string? Paxname { get; init; }
    public string? Passportno { get; init; }
    public DateTime? DateOfBirth { get; init; }
    public int? Category { get; init; }
}

/// <summary>
/// A per-pax-per-country status row inside an entry response (SPEC-0006 US6,
/// FR-008; contracts/entries-api.md §2). Maps the legacy `PaxStatus` chain
/// (BR-005). Fee columns round-trip verbatim (decimal(19,4), FR-002).
/// </summary>
public sealed record PaxStatusResponse
{
    public int? PaxId { get; init; }
    public int? CountryId { get; init; }
    public int? StatusId { get; init; }
    public string? Remarks { get; init; }
    public decimal? Visafee { get; init; }
    public decimal? Handlingfee { get; init; }
    public decimal? Ddcharges { get; init; }
    public decimal? Couriercharges { get; init; }
    public decimal? Misccharges { get; init; }
    public decimal? Total { get; init; }
    public decimal? VFSTTCharges { get; init; }
}

/// <summary>
/// Entry response body for GET /api/v1/entries/{refno} and PUT
/// /api/v1/entries/{refno} (SPEC-0006 US6, FR-008; contracts/entries-api.md
/// §2–§3). The `etag` is the entry's `RowVersion` as base64 (AC-011) and is
/// echoed back in the `If-Match` header for optimistic concurrency (RFC 7232
/// §2.3.2).
/// </summary>
public sealed record EntryResponse
{
    public int Refno { get; init; }
    public string? Paxname { get; init; }
    public string? Passportno { get; init; }
    public int? Agent { get; init; }
    public int? Status { get; init; }
    public DateTime? TravelDate { get; init; }
    public DateTime? Subdate { get; init; }
    public DateTime? Coldate { get; init; }
    public DateTime? Receivedate { get; init; }
    public DateTime? SentDate { get; init; }
    public int? TotalPassengers { get; init; }
    public IReadOnlyList<EntryPassengerResponse> Passengers { get; init; } = Array.Empty<EntryPassengerResponse>();
    public IReadOnlyList<PaxStatusResponse> PaxStatuses { get; init; } = Array.Empty<PaxStatusResponse>();
    public string Etag { get; init; } = string.Empty;
}
