using System.ComponentModel.DataAnnotations;

namespace VisaFusion.Api.Contracts;

/// <summary>
/// Request body for POST /api/v1/entries/{refno}/status (SPEC-0006 US6,
/// FR-005, AC-004; contracts/entries-api.md §4). Backs the legacy status-change
/// flow.
///
/// The proc <c>usp_RecordEntryStatusChange</c> (script 08) is called explicitly
/// by the entry service — the caller's <c>AspNetUsers.Id</c> is resolved
/// server-side from the JWT `sub` claim and passed as <c>@ActorUserId</c>
/// (anti-spoofing, GR-0004); it is never a caller-supplied actor string.
/// </summary>
public sealed record ChangeEntryStatusRequest
{
    [Required]
    public int PaxId { get; init; }

    [Required]
    public int CountryId { get; init; }

    [Required]
    public int NewStatusId { get; init; }

    public string? Remarks { get; init; }

    /// <summary>Defaults to server time when omitted.</summary>
    public DateTime? ChangeDate { get; init; }
}
