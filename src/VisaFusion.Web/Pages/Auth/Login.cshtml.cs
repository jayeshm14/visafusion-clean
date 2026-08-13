using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using VisaFusion.Core.Application;
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
/// redirects to `/Auth/Login?rsn=O` (T020, FR-018).
/// </summary>
[AllowAnonymous]
public class LoginModel : PageModel
{
    private readonly SignInManager<IdentityIntegration.VisaFusionUser> _signInManager;
    private readonly ISecurityGateService _securityGateService;

    public LoginModel(
        SignInManager<IdentityIntegration.VisaFusionUser> signInManager,
        ISecurityGateService securityGateService)
    {
        _signInManager = signInManager;
        _securityGateService = securityGateService;
    }

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

        // Credential validation first, then the day-gate, then the cookie —
        // mirroring the legacy order (authenticate.asp lines 62–79 checks the
        // gate only after the credential query matches). A rejected emp login
        // redirects to /Auth/Login?rsn=O WITHOUT an authenticated session.
        var user = await _signInManager.UserManager.FindByNameAsync(userName);
        if (user is null
            || !await _signInManager.UserManager.CheckPasswordAsync(user, Password)
            || await _signInManager.UserManager.IsLockedOutAsync(user))
        {
            // Single generic message (no account-state disclosure) — the same
            // collapse as the previous PasswordSignInAsync failure path. The
            // password hash is always computed before the lockout check so the
            // response timing does not reveal lockout state (review finding
            // 2026-08-13; deviation log §7).
            ModelState.AddModelError(string.Empty, "Invalid username or password.");
            return Page();
        }

        // Day-gate (T020, FR-018, AC-011; contracts/web-ui.md §1.1): emp logins
        // require an open security day for today; rejection redirects with the
        // legacy reason code rsn=O (rsn=C is never produced).
        var roles = await _signInManager.UserManager.GetRolesAsync(user);
        if (await _securityGateService.EvaluateAsync(roles, DateTime.Today)
            == SecurityGateDecision.RejectedNotOpened)
        {
            return RedirectToPage("/Auth/Login", new { rsn = "O" });
        }

        await _signInManager.SignInAsync(user, isPersistent: false);

        // Phase 0 default landing (CHK011) — the per-role landings land
        // with each module feature. Only local return URLs are honored:
        // LocalRedirect throws on a non-local value, and an external URL
        // must never be used as an open-redirect target.
        return LocalRedirect(Url.IsLocalUrl(returnUrl) ? returnUrl : "/");
    }
}
