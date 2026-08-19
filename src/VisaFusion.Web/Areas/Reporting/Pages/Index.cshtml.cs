using VisaFusion.Data.Persistence;

namespace VisaFusion.Web.Areas.Reporting.Pages;

/// <summary>
/// Reporting area landing page (SPEC-0008 T047, US6, FR-012; spec §14) — links
/// to the six operational report surfaces. Gated like the report pages by the
/// <c>EntryOperations</c> policy via <see cref="ReportingPageModel"/>.
/// </summary>
public class ReportingIndexModel : ReportingPageModel
{
    public ReportingIndexModel(VisaEntryDbContext db)
        : base(db)
    {
    }

    public void OnGet()
    {
        ViewData["Title"] = "Operational Reports";
        ViewData["UseSidebar"] = true;
    }
}