using Microsoft.AspNetCore.Mvc.RazorPages;

namespace VisaFusion.Web.Pages.Auth;

/// <summary>
/// Access-denied page (SPEC-0005 T014, US1; spec §14, contracts/web-ui.md §1.2).
///
/// Authenticated-but-unauthorized requests land here via the cookie scheme's
/// `AccessDeniedPath` (wired in Program.cs). Visibility alone is not the
/// control — the server-side role denial is (spec §14).
/// </summary>
public class AccessDeniedModel : PageModel
{
    public void OnGet()
    {
    }
}
