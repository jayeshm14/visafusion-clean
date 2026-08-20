using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc.RazorPages;
using VisaFusion.Api.Authorization;

namespace VisaFusion.Web.Areas.Admin.Pages;

/// <summary>
/// Admin area landing page (SPEC-0009 T035/T038, FR-005; SPEC-0003 T027).
/// Placeholder content only; the page model exists to carry the explicit
/// <c>AdminPanel</c> authorization rule (adm/su) that the model-less page
/// previously lacked — closing the anonymous-reachable gap recorded in
/// <c>ROLE_PAGE_PERMISSION_MATRIX.md</c> §6.1. No business behavior is added.
/// </summary>
[Authorize(Policy = AuthorizationPolicies.AdminPanel)]
public class IndexModel : PageModel
{
    public void OnGet()
    {
        ViewData["Title"] = "Admin Area";
    }
}