using System.ComponentModel.DataAnnotations;

namespace VisaFusion.Api.Contracts;

/// <summary>
/// Request body for POST /api/v1/entries/{refno}/awb (SPEC-0006 US6, FR-008;
/// contracts/entries-api.md §5). Backs the legacy `sendawbgo` page.
///
/// Mirrors the legacy guard (sendawbgo.asp:24 — `if trim(request("awb"))=""`):
/// an empty `awb` is a 400 validation failure. No charset rule exists in the
/// legacy page — preserved as-is per Legacy-as-Source-of-Truth.
/// </summary>
public sealed record RecordAwbRequest
{
    [Required]
    public string? Awb { get; init; }

    public string? ToEmail { get; init; }

    public string? Remark { get; init; }
}