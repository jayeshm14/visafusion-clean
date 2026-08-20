using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using VisaFusion.Identity;

namespace VisaFusion.Web.Pages.Auth;

/// <summary>
/// Web cookie sign-out page (SPEC-0009 review fix — the header "Sign out"
/// action previously posted to a non-existent page and returned the 404
/// error page).
///
/// The authenticated shell header posts here; the handler clears the
/// application cookie via SignInManager.SignOutAsync and returns to the home
/// page. GET never signs out — it redirects to home (the header only posts).
/// </summary>
[Authorize]
public class LogoutModel : PageModel
{
    private readonly SignInManager<IdentityIntegration.VisaFusionUser> _signInManager;

    public LogoutModel(SignInManager<IdentityIntegration.VisaFusionUser> signInManager)
    {
        _signInManager = signInManager;
    }

    public IActionResult OnGet()
    {
        // GET never signs out; the header only posts here.
        return RedirectToPage("/Index");
    }

    public async Task<IActionResult> OnPostAsync()
    {
        await _signInManager.SignOutAsync();
        return RedirectToPage("/Index");
    }
}