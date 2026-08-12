using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using VisaFusion.Identity;

namespace VisaFusion.Web.Pages.Auth;

/// <summary>
/// Web cookie sign-in page (SPEC-0005 T013, US1; spec §14, contracts/web-ui.md §1.1).
///
/// Authenticates against the consolidated Identity store via SignInManager and
/// renders the legacy `relogin.asp?rsn=` reason inline (deepanalysis §1.2 —
/// `B` bad credentials, `O` day not opened, `C` day closed, `S` session
/// expired, `V` relogin, `usb` register/login first). On success the post-login
/// redirect defaults to the existing home page (CHK011: per-role landing
/// routes land with each module feature). The employee day-gate rejection
/// (`/Auth/Login?rsn=O`) is wired by US2 (T020, FR-018).
/// </summary>
[AllowAnonymous]
public class LoginModel : PageModel
{
    private readonly SignInManager<IdentityIntegration.VisaFusionUser> _signInManager;

    public LoginModel(SignInManager<IdentityIntegration.VisaFusionUser> signInManager)
        => _signInManager = signInManager;

    [BindProperty]
    public string? UserName { get; set; }

    [BindProperty]
    public string? Password { get; set; }

    public string? ReturnUrl { get; private set; }

    /// <summary>Inline reason message mirroring the legacy `relogin.asp?rsn=` table (deepanalysis §1.2).</summary>
    public string? ReasonMessage { get; private set; }

    public IActionResult OnGet(string? rsn, string? returnUrl)
    {
        ReasonMessage = rsn switch
        {
            "B" => "Invalid username or password.",
            "O" => "The office has not been opened for today.",
            "C" => "The office is closed for today.",
            "S" => "Your session has expired.",
            "V" => "Please log in again.",
            "usb" => "Please register or log in first.",
            _ => null,
        };
        ReturnUrl = returnUrl;

        return User.Identity?.IsAuthenticated == true
            ? RedirectToPage("/Index")
            : Page();
    }

    public async Task<IActionResult> OnPostAsync(string? returnUrl)
    {
        var userName = UserName?.Trim();
        if (string.IsNullOrEmpty(userName) || string.IsNullOrEmpty(Password))
        {
            ModelState.AddModelError(string.Empty, "Username and password are required.");
            return Page();
        }

        var result = await _signInManager.PasswordSignInAsync(
            userName, Password, isPersistent: false, lockoutOnFailure: false);

        if (result.Succeeded)
        {
            // Phase 0 default landing (CHK011) — the per-role landings land
            // with each module feature. Only local return URLs are honored:
            // LocalRedirect throws on a non-local value, and an external URL
            // must never be used as an open-redirect target.
            return LocalRedirect(Url.IsLocalUrl(returnUrl) ? returnUrl : "/");
        }

        ModelState.AddModelError(string.Empty, "Invalid username or password.");
        return Page();
    }
}
