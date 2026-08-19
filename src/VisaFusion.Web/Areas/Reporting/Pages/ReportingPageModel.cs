using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc.RazorPages;
using VisaFusion.Api.Authorization;
using VisaFusion.Api.Endpoints;
using VisaFusion.Data.Persistence;

namespace VisaFusion.Web.Areas.Reporting.Pages;

/// <summary>
/// Shared base for the Reporting area pages (SPEC-0008 T047, US6, FR-012,
/// AC-008; spec §14).
///
/// Gated by the <c>EntryOperations</c> policy (emp/adm/su — DP-001). Parses
/// the common report query parameters through <see cref="ReportQueryParams"/>
/// — the SAME parser the API endpoints use — so the page and the API reject
/// invalid dates identically ("400 before query execution" on the API; an
/// inline error message here). The queries themselves run through
/// <see cref="ReportQueries"/> — the same parameterized EF Core LINQ the API
/// uses, so page and API can never diverge (AC-008, NFR-002/NFR-006).
/// </summary>
[Authorize(Policy = AuthorizationPolicies.EntryOperations)]
public abstract class ReportingPageModel : PageModel
{
    protected ReportingPageModel(VisaEntryDbContext db)
    {
        Db = db;
    }

    protected VisaEntryDbContext Db { get; }

    /// <summary>The validated report parameters; null when the query string was invalid.</summary>
    public ReportQueryParams? Params { get; private set; }

    /// <summary>Validation error to render inline (spec §17 mirror of the API 400).</summary>
    public string? ParamError { get; private set; }

    /// <summary>Parses and validates the query string; call at the top of every handler.</summary>
    protected void TryResolveParams()
    {
        if (ReportQueryParams.TryParse(Request.Query, out var parameters, out var error))
        {
            Params = parameters;
            return;
        }

        ParamError = error;
    }
}