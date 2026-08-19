using VisaFusion.Api.Contracts;
using VisaFusion.Api.Endpoints;
using VisaFusion.Data.Persistence;

namespace VisaFusion.Web.Areas.Reporting.Pages;

/// <summary>
/// Today transaction report (SPEC-0008 T047, US6, FR-012; legacy
/// <c>todayTransaction.asp</c>): one row per reference number entered in the
/// range (defaults to today) with the per-refno visa-fee / hotel / cab totals.
/// Rendered through the shared <see cref="ReportQueries.TodayTransactionAsync"/>
/// query (AC-008).
/// </summary>
public class TodayTransactionModel : ReportingPageModel
{
    public TodayTransactionModel(VisaEntryDbContext db)
        : base(db)
    {
    }

    public List<TransactionReportRow> Rows { get; private set; } = new();

    public async Task OnGetAsync()
    {
        ViewData["Title"] = "Today Transaction";
        ViewData["UseSidebar"] = true;

        TryResolveParams();
        if (Params is not null)
        {
            Rows = await ReportQueries.TodayTransactionAsync(Db, Params);
        }
    }
}