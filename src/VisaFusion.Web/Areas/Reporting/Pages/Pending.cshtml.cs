using VisaFusion.Api.Contracts;
using VisaFusion.Api.Endpoints;
using VisaFusion.Data.Persistence;

namespace VisaFusion.Web.Areas.Reporting.Pages;

/// <summary>
/// Pending entries report (SPEC-0008 T047, US6, FR-012; legacy
/// <c>pendinglist.asp</c>): pax status rows in the pending band
/// (statusid 401..409). Rendered through the shared
/// <see cref="ReportQueries.PendingAsync"/> — the same parameterized query the
/// API endpoint serves (AC-008).
/// </summary>
public class PendingModel : ReportingPageModel
{
    public PendingModel(VisaEntryDbContext db)
        : base(db)
    {
    }

    public List<PendingReportRow> Rows { get; private set; } = new();

    public async Task OnGetAsync()
    {
        ViewData["Title"] = "Pending List";
        ViewData["UseSidebar"] = true;

        TryResolveParams();
        if (Params is not null)
        {
            Rows = await ReportQueries.PendingAsync(Db, Params);
        }
    }
}