using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace VisaFusion.Web.Pages;

/// <summary>
/// CoreUI error page (SPEC-0009 T031; mapping §2 AccessDenied row, ErrorPage
/// component).
///
/// Renders the <c>ErrorPage</c> component for non-API 4xx/5xx responses:
/// - 404 and other status codes arrive via <c>UseStatusCodePages</c>
///   (Program.cs) re-executing to <c>/Error/{code}</c>;
/// - 500 (unhandled exception, non-API) arrives via
///   <c>ExceptionHandlingMiddleware</c> re-executing to <c>/Error/500</c>.
///
/// The HTTP status code is preserved on the response and the trace id is
/// surfaced for 500s (the same Request Id the previous generic error page
/// showed). Error semantics are unchanged — presentation only.
/// </summary>
[AllowAnonymous]
public class ErrorModel : PageModel
{
    public int Code { get; private set; } = 500;

    public string? TraceId { get; private set; }

    public void OnGet(int? code)
    {
        Code = code ?? 500;
        TraceId = HttpContext.TraceIdentifier;
        HttpContext.Response.StatusCode = Code;
    }
}