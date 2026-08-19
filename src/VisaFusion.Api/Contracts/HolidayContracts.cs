using System.ComponentModel.DataAnnotations;

namespace VisaFusion.Api.Contracts;

/// <summary>
/// Request body for POST /api/v1/holidays (SPEC-0008 FR-011;
/// contracts/content-api.md §3). Backs the legacy <c>holiday_entry.asp</c>
/// create path. Validation per spec §17: embassyId and holidayDate required.
/// The legacy page skipped a duplicate embassy+date ("ALREADY EXISTS"); the
/// modern contract maps that to 409.
/// </summary>
public sealed record HolidayCreateRequest
{
    /// <summary>Embassy id — required (legacy <c>holidaylist.countryID</c>).</summary>
    [Required]
    public int? EmbassyId { get; init; }

    /// <summary>The holiday date — required.</summary>
    [Required]
    public DateTime? HolidayDate { get; init; }

    /// <summary>Optional reason text.</summary>
    public string? Description { get; init; }
}

/// <summary>
/// Request body for POST /api/v1/holidays/weekly-off (SPEC-0008 FR-011;
/// contracts/content-api.md §5). Backs the legacy <c>holiday_entry.asp</c>
/// weekly-off path. Validation per spec §17: embassyId and weekday required;
/// weekday must be 1–7 in VBScript <c>Weekday()</c> numbering (1=Sunday ..
/// 7=Saturday — BR-006, WeeklyOffList.asp CASE WHEN weekend = 1 THEN 'SUNDAY'
/// ... WHEN 7 THEN 'SATURDAY').
/// </summary>
public sealed record WeeklyOffCreateRequest
{
    /// <summary>Embassy id — required (<c>weeklyoff.embassyid</c>, FK <c>Embassy.Id</c>).</summary>
    [Required]
    public int? EmbassyId { get; init; }

    /// <summary>Weekday — required, 1–7 (1=Sunday .. 7=Saturday, BR-006).</summary>
    [Required]
    [Range(1, 7, ErrorMessage = "weekday must be between 1 (Sunday) and 7 (Saturday)")]
    public int? Weekday { get; init; }

    /// <summary>Optional reason text.</summary>
    public string? Description { get; init; }
}