using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using VisaFusion.Api.Authorization;
using VisaFusion.Data.Persistence;
using VisaFusion.Data.Persistence.Entities;
using VisaFusion.Identity;

// The page namespace's final segment collides with the entity type name
// (CS0118), so the entity is referenced through an alias.
using ContentUpdateEntity = VisaFusion.Data.Persistence.Entities.ContentUpdate;

namespace VisaFusion.Web.Areas.Admin.Pages.ContentUpdate;

/// <summary>
/// dailyUpdate content CMS page (SPEC-0008 T036, US4, FR-010, BR-003, AC-006;
/// contracts/content-api.md §1/§2). Backs the legacy <c>dailyupdate.asp</c>
/// write surface.
///
/// The page is gated by the <c>AdminPanel</c> policy (adm/su — DP-001), closing
/// the legacy anonymous <c>dailyupdate.asp</c> write endpoint (BR-003). The
/// create/edit/delete handlers mirror the API surface
/// (<c>ContentEndpoint</c>): upsert by the surrogate <c>Id</c> (create when
/// absent, edit when present), §17 validation (entrydate required, description
/// ≤ 8,000 chars), and the audit event written in the SAME commit as the change
/// (spec §19). The audit actor is resolved from the authenticated cookie
/// principal — never from the form (GR-0004).
/// </summary>
[Authorize(Policy = AuthorizationPolicies.AdminPanel)]
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

    /// <summary>A daily-update row for the list table.</summary>
    public sealed record ContentUpdateRow(long Id, DateTime? Entrydate, string? Description);

    public List<ContentUpdateRow> Entries { get; private set; } = new();

    /// <summary>Inline outcome message mirroring the endpoint responses.</summary>
    public string? OutcomeMessage { get; private set; }

    public string? OutcomeError { get; private set; }

    public async Task OnGetAsync()
    {
        ViewData["Title"] = "Daily Updates";
        ViewData["UseSidebar"] = true;

        Entries = await LoadEntriesAsync();
    }

    public async Task<IActionResult> OnPostCreateAsync(DateTime? entrydate, string? description)
    {
        ViewData["Title"] = "Daily Updates";
        ViewData["UseSidebar"] = true;

        var actor = await ResolveActorAsync();
        if (actor is null)
        {
            return RedirectToPage("/Auth/Login");
        }

        if (!TryValidate(entrydate, description, out var error))
        {
            OutcomeError = error;
            Entries = await LoadEntriesAsync();
            return Page();
        }

        var entryDate = entrydate!.Value.Date;
        _db.ContentUpdates.Add(new ContentUpdateEntity
        {
            Entrydate = entryDate,
            Description = description!.Trim(),
        });
        _db.AdminAuditLogs.Add(new AdminAuditLog
        {
            EventType = "DailyUpdateCreated",
            ActorUserId = actor.Value.UserId,
            ActorUserName = actor.Value.UserName,
            Date = DateTime.Now,
            Detail = entryDate.ToString("yyyy-MM-dd"),
        });
        await _db.SaveChangesAsync();
        OutcomeMessage = $"Daily update for {entryDate:dd-MMM-yyyy} recorded.";

        Entries = await LoadEntriesAsync();
        return Page();
    }

    public async Task<IActionResult> OnPostEditAsync(long id, DateTime? entrydate, string? description)
    {
        ViewData["Title"] = "Daily Updates";
        ViewData["UseSidebar"] = true;

        var actor = await ResolveActorAsync();
        if (actor is null)
        {
            return RedirectToPage("/Auth/Login");
        }

        if (!TryValidate(entrydate, description, out var error))
        {
            OutcomeError = error;
            Entries = await LoadEntriesAsync();
            return Page();
        }

        var existing = await _db.ContentUpdates.FindAsync(id);
        if (existing is null)
        {
            OutcomeError = $"Daily-update entry {id} was not found.";
            Entries = await LoadEntriesAsync();
            return Page();
        }

        var entryDate = entrydate!.Value.Date;
        existing.Entrydate = entryDate;
        existing.Description = description!.Trim();
        _db.AdminAuditLogs.Add(new AdminAuditLog
        {
            EventType = "DailyUpdateUpdated",
            ActorUserId = actor.Value.UserId,
            ActorUserName = actor.Value.UserName,
            Date = DateTime.Now,
            Detail = entryDate.ToString("yyyy-MM-dd"),
        });
        await _db.SaveChangesAsync();
        OutcomeMessage = $"Daily update for {entryDate:dd-MMM-yyyy} updated.";

        Entries = await LoadEntriesAsync();
        return Page();
    }

    public async Task<IActionResult> OnPostDeleteAsync(long id)
    {
        ViewData["Title"] = "Daily Updates";
        ViewData["UseSidebar"] = true;

        var actor = await ResolveActorAsync();
        if (actor is null)
        {
            return RedirectToPage("/Auth/Login");
        }

        var existing = await _db.ContentUpdates.FindAsync(id);
        if (existing is null)
        {
            OutcomeError = $"Daily-update entry {id} was not found.";
            Entries = await LoadEntriesAsync();
            return Page();
        }

        _db.ContentUpdates.Remove(existing);
        _db.AdminAuditLogs.Add(new AdminAuditLog
        {
            EventType = "DailyUpdateDeleted",
            ActorUserId = actor.Value.UserId,
            ActorUserName = actor.Value.UserName,
            Date = DateTime.Now,
            Detail = existing.Entrydate?.ToString("yyyy-MM-dd") ?? string.Empty,
        });
        await _db.SaveChangesAsync();
        OutcomeMessage = $"Daily update for {existing.Entrydate:dd-MMM-yyyy} deleted.";

        Entries = await LoadEntriesAsync();
        return Page();
    }

    /// <summary>
    /// §17 validation shared with the API surface: entrydate required,
    /// description required and ≤ 8,000 chars (the column limit).
    /// </summary>
    private static bool TryValidate(DateTime? entrydate, string? description, out string? error)
    {
        if (entrydate is null)
        {
            error = "Date is required.";
            return false;
        }

        if (string.IsNullOrWhiteSpace(description))
        {
            error = "Message is required.";
            return false;
        }

        if (description.Trim().Length > 8000)
        {
            error = "Message must be 8,000 characters or fewer.";
            return false;
        }

        error = null;
        return true;
    }

    private async Task<List<ContentUpdateRow>> LoadEntriesAsync()
        => await _db.ContentUpdates
            .OrderByDescending(c => c.Entrydate)
            .Select(c => new ContentUpdateRow(c.Id, c.Entrydate, c.Description))
            .ToListAsync();

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