using VisaFusion.Api.Contracts;
using VisaFusion.Api.Endpoints;
using VisaFusion.Data.Persistence;

namespace VisaFusion.Web.Areas.Reporting.Pages;

/// <summary>
/// Today collection report (SPEC-0008 T047, US6, FR-012; legacy
/// <c>todayCollection*.asp</c>): pax status rows whose collection date falls
/// in the requested range (defaults to today), with country and agent names.
/// Rendered through the shared <see cref="ReportQueries.TodayCollectionAsync"/>
/// query (AC-008).
/// </summary>
public class TodayCollectionModel : ReportingPageModel
{
    public TodayCollectionModel(VisaEntryDbContext db)
        : base(db)
    {
    }

    public List<CollectionReportRow> Rows { get; private set; } = new();

    public async Task OnGetAsync()
    {
        ViewData["Title"] = "Today Collection";
        ViewData["UseSidebar"] = true;

        TryResolveParams();
        if (Params is not null)
        {
            Rows = await ReportQueries.TodayCollectionAsync(Db, Params);
        }
    }
}