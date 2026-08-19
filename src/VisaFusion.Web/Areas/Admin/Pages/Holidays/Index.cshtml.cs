using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using VisaFusion.Api.Authorization;
using VisaFusion.Data.Persistence;
using VisaFusion.Data.Persistence.Entities;
using VisaFusion.Identity;

namespace VisaFusion.Web.Areas.Admin.Pages.Holidays;

/// <summary>
/// Holiday/weekly-off management page (SPEC-0008 T042, US5, FR-011, BR-006,
/// AC-007; contracts/content-api.md §3-§6). Backs the legacy
/// <c>holiday_entry.asp</c>/<c>holidayDeleteSubmit.asp</c>/<c>WeeklyOffList.asp</c>
/// management surface.
///
/// The page is gated by the <c>HolidayAdmin</c> policy (adm/su — DP-001). The
/// create/delete handlers mirror the API surface
/// (<c>HolidaysEndpoint</c>): duplicate embassy+date and embassy+weekday are
/// rejected, weekday must be 1–7 (VBScript <c>Weekday()</c> numbering — BR-006),
/// and the audit event is written in the SAME commit as the change (spec §19).
/// The audit actor is resolved from the authenticated cookie principal — never
/// from the form (GR-0004). Rows created here are immediately honored by
/// <c>IHolidayService.IsEmbassyClosedAsync</c> (AC-007).
/// </summary>
[Authorize(Policy = AuthorizationPolicies.HolidayAdmin)]
public class IndexModel : PageModel
{
    private readonly VisaEntryDbContext _db;
    private readonly UserManager<IdentityIntegration.VisaFusionUser> _userManager;

    public IndexModel(
        VisaEntryDbContext db,
        UserManager<IdentityIntegration.VisaFusionUser> userManager)
    {
        _db = db;
        _userManager = userManager;
    }

    /// <summary>An embassy row for the dropdown (id + description).</summary>
    public sealed record EmbassyRow(int Id, string Description);

    /// <summary>A holiday row for the list table.</summary>
    public sealed record HolidayRow(long Id, int? CountryId, DateTime? HolidayDate, string? Description);

    /// <summary>A weekly-off row for the list table.</summary>
    public sealed record WeeklyOffRow(long Id, int? EmbassyId, int? Weekend, string? Description);

    public List<EmbassyRow> Embassies { get; private set; } = new();

    public List<HolidayRow> Holidays { get; private set; } = new();

    public List<WeeklyOffRow> WeeklyOffs { get; private set; } = new();

    /// <summary>Inline outcome message mirroring the endpoint responses.</summary>
    public string? OutcomeMessage { get; private set; }

    public string? OutcomeError { get; private set; }

    public async Task OnGetAsync()
    {
        ViewData["Title"] = "Holidays & Weekly Off";
        ViewData["UseSidebar"] = true;

        await LoadAsync();
    }

    public async Task<IActionResult> OnPostCreateHolidayAsync(int? embassyId, DateTime? holidayDate, string? description)
    {
        ViewData["Title"] = "Holidays & Weekly Off";
        ViewData["UseSidebar"] = true;

        var actor = await ResolveActorAsync();
        if (actor is null)
        {
            return RedirectToPage("/Auth/Login");
        }

        if (embassyId is null)
        {
            OutcomeError = "Embassy is required.";
            await LoadAsync();
            return Page();
        }

        if (holidayDate is null)
        {
            OutcomeError = "Holiday date is required.";
            await LoadAsync();
            return Page();
        }

        var embassy = embassyId.Value;
        var date = holidayDate.Value.Date;
        if (await _db.Holidays.AnyAsync(h => h.CountryId == embassy && h.HolidayDate == date))
        {
            OutcomeError = $"A holiday for embassy {embassy} on {date:dd-MMM-yyyy} already exists.";
            await LoadAsync();
            return Page();
        }

        _db.Holidays.Add(new Holiday
        {
            CountryId = embassy,
            HolidayDate = date,
            Description = description?.Trim(),
        });
        _db.AdminAuditLogs.Add(new AdminAuditLog
        {
            EventType = "HolidayCreated",
            ActorUserId = actor.Value.UserId,
            ActorUserName = actor.Value.UserName,
            Date = DateTime.Now,
            Detail = $"{embassy}:{date:yyyy-MM-dd}",
        });
        await _db.SaveChangesAsync();
        OutcomeMessage = $"Holiday for {await EmbassyNameAsync(embassy)} on {date:dd-MMM-yyyy} recorded.";

        await LoadAsync();
        return Page();
    }

    public async Task<IActionResult> OnPostDeleteHolidayAsync(long id)
    {
        ViewData["Title"] = "Holidays & Weekly Off";
        ViewData["UseSidebar"] = true;

        var actor = await ResolveActorAsync();
        if (actor is null)
        {
            return RedirectToPage("/Auth/Login");
        }

        var existing = await _db.Holidays.FindAsync(id);
        if (existing is null)
        {
            OutcomeError = $"Holiday {id} was not found.";
            await LoadAsync();
            return Page();
        }

        _db.Holidays.Remove(existing);
        _db.AdminAuditLogs.Add(new AdminAuditLog
        {
            EventType = "HolidayDeleted",
            ActorUserId = actor.Value.UserId,
            ActorUserName = actor.Value.UserName,
            Date = DateTime.Now,
            Detail = $"{existing.CountryId}:{existing.HolidayDate:yyyy-MM-dd}",
        });
        await _db.SaveChangesAsync();
        OutcomeMessage = $"Holiday for {existing.HolidayDate:dd-MMM-yyyy} deleted.";

        await LoadAsync();
        return Page();
    }

    public async Task<IActionResult> OnPostCreateWeeklyOffAsync(int? embassyId, int? weekday, string? description)
    {
        ViewData["Title"] = "Holidays & Weekly Off";
        ViewData["UseSidebar"] = true;

        var actor = await ResolveActorAsync();
        if (actor is null)
        {
            return RedirectToPage("/Auth/Login");
        }

        if (embassyId is null)
        {
            OutcomeError = "Embassy is required.";
            await LoadAsync();
            return Page();
        }

        // BR-006: VBScript Weekday() numbering — 1 (Sunday) .. 7 (Saturday).
        if (weekday is null or < 1 or > 7)
        {
            OutcomeError = "Weekday must be between 1 (Sunday) and 7 (Saturday).";
            await LoadAsync();
            return Page();
        }

        var embassy = embassyId.Value;
        var day = weekday.Value;
        if (await _db.WeeklyOffs.AnyAsync(w => w.Embassyid == embassy && w.Weekend == day))
        {
            OutcomeError = $"A weekly-off for embassy {embassy} on weekday {day} already exists.";
            await LoadAsync();
            return Page();
        }

        _db.WeeklyOffs.Add(new WeeklyOff
        {
            Embassyid = embassy,
            Weekend = day,
            Description = description?.Trim(),
        });
        _db.AdminAuditLogs.Add(new AdminAuditLog
        {
            EventType = "WeeklyOffCreated",
            ActorUserId = actor.Value.UserId,
            ActorUserName = actor.Value.UserName,
            Date = DateTime.Now,
            Detail = $"{embassy}:{day}",
        });
        await _db.SaveChangesAsync();
        OutcomeMessage = $"Weekly-off for {await EmbassyNameAsync(embassy)} on {WeekdayName(day)} recorded.";

        await LoadAsync();
        return Page();
    }

    public async Task<IActionResult> OnPostDeleteWeeklyOffAsync(long id)
    {
        ViewData["Title"] = "Holidays & Weekly Off";
        ViewData["UseSidebar"] = true;

        var actor = await ResolveActorAsync();
        if (actor is null)
        {
            return RedirectToPage("/Auth/Login");
        }

        var existing = await _db.WeeklyOffs.FindAsync(id);
        if (existing is null)
        {
            OutcomeError = $"Weekly-off {id} was not found.";
            await LoadAsync();
            return Page();
        }

        _db.WeeklyOffs.Remove(existing);
        _db.AdminAuditLogs.Add(new AdminAuditLog
        {
            EventType = "WeeklyOffDeleted",
            ActorUserId = actor.Value.UserId,
            ActorUserName = actor.Value.UserName,
            Date = DateTime.Now,
            Detail = $"{existing.Embassyid}:{existing.Weekend}",
        });
        await _db.SaveChangesAsync();
        OutcomeMessage = $"Weekly-off for {WeekdayName(existing.Weekend)} deleted.";

        await LoadAsync();
        return Page();
    }

    private async Task LoadAsync()
    {
        Embassies = await _db.Embassies
            .OrderBy(e => e.Description)
            .Select(e => new EmbassyRow(e.Id, e.Description))
            .ToListAsync();
        Holidays = await _db.Holidays
            .OrderByDescending(h => h.HolidayDate)
            .Select(h => new HolidayRow(h.Id, h.CountryId, h.HolidayDate, h.Description))
            .ToListAsync();
        WeeklyOffs = await _db.WeeklyOffs
            .OrderBy(w => w.Embassyid)
            .ThenBy(w => w.Weekend)
            .Select(w => new WeeklyOffRow(w.Id, w.Embassyid, w.Weekend, w.Description))
            .ToListAsync();
    }

    private async Task<string> EmbassyNameAsync(int id)
        => (await _db.Embassies.FindAsync(id))?.Description ?? id.ToString();

    /// <summary>VBScript Weekday() numbering to a display name (BR-006).</summary>
    private static string WeekdayName(int? weekday) => weekday switch
    {
        1 => "Sunday",
        2 => "Monday",
        3 => "Tuesday",
        4 => "Wednesday",
        5 => "Thursday",
        6 => "Friday",
        7 => "Saturday",
        _ => $"Weekday {weekday}",
    };

    /// <summary>
    /// Resolves the audit actor (user id + username) from the authenticated
    /// cookie principal — the same source the API endpoints use (JWT
    /// <c>name</c>/<c>nameidentifier</c> claims).
    /// </summary>
    private async Task<(string UserId, string UserName)?> ResolveActorAsync()
    {
        var user = await _userManager.GetUserAsync(User);
        if (user is null)
        {
            return null;
        }

        return (user.Id, user.UserName ?? string.Empty);
    }
}