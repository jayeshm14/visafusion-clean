using System.ComponentModel.DataAnnotations;

namespace VisaFusion.Api.Contracts;

/// <summary>
/// Request body for POST /api/v1/admin/content/daily-update (SPEC-0008 FR-010;
/// contracts/content-api.md §1). Validation per spec §17: entrydate and
/// description required; description ≤ 8,000 chars (the
/// <c>dailyUpdate.Description</c> column limit — data-model.md §1).
///
/// The optional <c>id</c> selects create (absent) vs edit (present) — the
/// legacy <c>dailyupdate.asp</c> upsert-by-entrydate is modernized to a
/// surrogate-key upsert (FR-003; the legacy table has no identity column, so
/// the <c>ContentUpdate.Id</c> surrogate key is the edit handle).
/// </summary>
public sealed record ContentUpdateRequest
{
    /// <summary>Entry date — required.</summary>
    [Required]
    public DateTime? Entrydate { get; init; }

    /// <summary>Entry text — required, length limit 8000 (column limit).</summary>
    [Required]
    [StringLength(8000)]
    public string? Description { get; init; }

    /// <summary>Surrogate id — when present, updates that entry instead of inserting.</summary>
    public long? Id { get; init; }
}