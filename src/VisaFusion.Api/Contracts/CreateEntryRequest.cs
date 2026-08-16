using System.ComponentModel.DataAnnotations;

namespace VisaFusion.Api.Contracts;

/// <summary>
/// Request body for POST /api/v1/entries (SPEC-0006 US6, FR-008, AC-007;
/// contracts/entries-api.md §1). Backs the legacy `makeEntry`/`insertEntry`
/// pages.
///
/// The legacy schema carries all passenger fields at the entry level (the
/// principal passenger is the entry). The ≥ 1-passenger aggregate invariant
/// (BR-005) is enforced by <c>VisaFusion.Core.EntryService</c>; the bookable-date
/// rule (BR-003) is enforced transactionally by <c>HolidayService</c> where a
/// travel date is supplied.
/// </summary>
public sealed record CreateEntryRequest
{
    [Required]
    public string? Paxname { get; init; }

    [Required]
    public string? Passportno { get; init; }

    public DateTime? DateOfBirth { get; init; }

    public int? Category { get; init; }

    public int? TotalPassengers { get; init; }

    public DateTime? TravelDate { get; init; }

    /// <summary>External remark (legacy `externalremark`).</summary>
    public string? Remarks { get; init; }

    /// <summary>Legacy `AgentInstruction`.</summary>
    public string? AgentInstruction { get; init; }
}
