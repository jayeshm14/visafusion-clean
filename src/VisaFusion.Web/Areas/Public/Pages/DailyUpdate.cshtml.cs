using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using VisaFusion.Data.Persistence;

namespace VisaFusion.Web.Areas.Public.Pages;

/// <summary>
/// Anonymous public daily-update read page (SPEC-0008 T037, US4, FR-010,
/// AC-006; contracts/content-api.md §7). Backs the legacy
/// <c>viewdailyupdate.asp</c>: renders the dated entries newer than 30 days
/// (the legacy <c>entrydate &gt; date()-30</c> window), most recent first, with
/// a friendly empty state (the legacy "NO UPDATE FOUND FOR THIS MONTH").
/// Read-only — the CMS writes go through the AdminPanel-gated API
/// (<c>ContentEndpoint</c>), never this page.
/// </summary>
public class DailyUpdateModel : PageModel
{
    private readonly VisaEntryDbContext _db;

    public DailyUpdateModel(VisaEntryDbContext db) => _db = db;

    /// <summary>A dated daily-update row for the page table.</summary>
    public sealed record DailyUpdateEntry(DateTime Entrydate, string Description);

    public IReadOnlyList<DailyUpdateEntry> Entries { get; private set; } = Array.Empty<DailyUpdateEntry>();

    public async Task OnGetAsync()
    {
        ViewData["Title"] = "Daily Updates";

        // Legacy viewdailyupdate.asp window: entrydate > today - 30 days.
        var cutoff = DateTime.Today.AddDays(-30);
        Entries = await _db.ContentUpdates
            .Where(c => c.Entrydate > cutoff)
            .OrderByDescending(c => c.Entrydate)
            .Select(c => new DailyUpdateEntry(c.Entrydate!.Value, c.Description ?? string.Empty))
            .ToListAsync();
    }
}