using VisaFusion.Api.Contracts;
using VisaFusion.Api.Endpoints;
using VisaFusion.Data.Persistence;

namespace VisaFusion.Web.Areas.Reporting.Pages;

/// <summary>
/// Daily visa fee report (SPEC-0008 T047, US6, FR-012; legacy
/// <c>dailyVisaFee.asp</c>): pax status rows submitted in the range (defaults
/// to today) with the country name and the linked invoice. Rendered through
/// the shared <see cref="ReportQueries.DailyVisaFeeAsync"/> query (AC-008).
/// </summary>
public class DailyVisaFeeModel : ReportingPageModel
{
    public DailyVisaFeeModel(VisaEntryDbContext db)
        : base(db)
    {
    }

    public List<VisaFeeReportRow> Rows { get; private set; } = new();

    public async Task OnGetAsync()
    {
        ViewData["Title"] = "Daily Visa Fee";
        ViewData["UseSidebar"] = true;

        TryResolveParams();
        if (Params is not null)
        {
            Rows = await ReportQueries.DailyVisaFeeAsync(Db, Params);
        }
    }
}