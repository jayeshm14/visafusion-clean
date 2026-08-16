using System.ComponentModel.DataAnnotations;

namespace VisaFusion.Api.Contracts;

/// <summary>
/// Request body for PUT /api/v1/entries/{refno} (SPEC-0006 US6, FR-008,
/// AC-011; contracts/entries-api.md §3). Backs the legacy `editentry*` /
/// `editdone` pages.
///
/// The request carries the same payload as <see cref="CreateEntryRequest"/>.
/// Optimistic concurrency is enforced by the required `If-Match` header (the
/// entry's current ETag / RowVersion); a stale write returns 409 (AC-011).
/// </summary>
public sealed record UpdateEntryRequest
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
