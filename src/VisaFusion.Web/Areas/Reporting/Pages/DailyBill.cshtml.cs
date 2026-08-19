using VisaFusion.Api.Contracts;
using VisaFusion.Api.Endpoints;
using VisaFusion.Data.Persistence;

namespace VisaFusion.Web.Areas.Reporting.Pages;

/// <summary>
/// Daily bill report (SPEC-0008 T047, US6, FR-012; legacy <c>dailybill.asp</c>):
/// invoices dated in the range (defaults to today) plus the day's grand total.
/// Rendered through the shared <see cref="ReportQueries.DailyBillAsync"/> and
/// <see cref="ReportQueries.DailyBillGrandTotalAsync"/> queries (AC-008).
/// </summary>
public class DailyBillModel : ReportingPageModel
{
    public DailyBillModel(VisaEntryDbContext db)
        : base(db)
    {
    }

    public List<DailyBillRow> Rows { get; private set; } = new();

    public decimal? GrandTotal { get; private set; }

    public async Task OnGetAsync()
    {
        ViewData["Title"] = "Daily Bill";
        ViewData["UseSidebar"] = true;

        TryResolveParams();
        if (Params is not null)
        {
            Rows = await ReportQueries.DailyBillAsync(Db, Params);
            GrandTotal = await ReportQueries.DailyBillGrandTotalAsync(Db, Params);
        }
    }
}