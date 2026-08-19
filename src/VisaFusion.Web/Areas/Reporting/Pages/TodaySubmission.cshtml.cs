using VisaFusion.Api.Contracts;
using VisaFusion.Api.Endpoints;
using VisaFusion.Data.Persistence;

namespace VisaFusion.Web.Areas.Reporting.Pages;

/// <summary>
/// Today submission report (SPEC-0008 T047, US6, FR-012; legacy
/// <c>todaySubmission*.asp</c>): pax status rows whose submission date falls
/// in the requested range (defaults to today). Rendered through the shared
/// <see cref="ReportQueries.TodaySubmissionAsync"/> query (AC-008).
/// </summary>
public class TodaySubmissionModel : ReportingPageModel
{
    public TodaySubmissionModel(VisaEntryDbContext db)
        : base(db)
    {
    }

    public List<SubmissionReportRow> Rows { get; private set; } = new();

    public async Task OnGetAsync()
    {
        ViewData["Title"] = "Today Submission";
        ViewData["UseSidebar"] = true;

        TryResolveParams();
        if (Params is not null)
        {
            Rows = await ReportQueries.TodaySubmissionAsync(Db, Params);
        }
    }
}