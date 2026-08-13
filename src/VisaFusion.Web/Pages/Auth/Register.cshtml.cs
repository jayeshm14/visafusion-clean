using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using VisaFusion.Api.Registration;
using VisaFusion.Identity;

namespace VisaFusion.Web.Pages.Auth;

/// <summary>
/// Guest-only registration page (SPEC-0005 T040, US1; spec §14,
/// contracts/web-ui.md §1.3).
///
/// Thin form wrapper over the shared <see cref="RegistrationFlow"/> — the same
/// single implementation the anonymous `POST /api/v1/public/register` endpoint
/// uses (validation, the server-side-fixed `guest` role — FR-012/§2.2 fix —
/// and conflict mapping), so the page and the API can never diverge. The page
/// renders the outcome inline, mirroring the legacy `regsub.asp` →
/// `regsubmit.asp` → `regsubdone.asp` flow (success page with a link to
/// logon.asp) without duplicating any registration logic.
/// </summary>
[AllowAnonymous]
public class RegisterModel : PageModel
{
    private readonly UserManager<IdentityIntegration.VisaFusionUser> _userManager;

    public RegisterModel(UserManager<IdentityIntegration.VisaFusionUser> userManager)
    {
        _userManager = userManager;
    }

    [BindProperty]
    public string? UserName { get; set; }

    [BindProperty]
    public string? Email { get; set; }

    [BindProperty]
    public string? Password { get; set; }

    [BindProperty]
    public string? ConfirmPassword { get; set; }

    /// <summary>Inline outcome message (success mirrors `regsubdone.asp`; errors mirror the API problem-details).</summary>
    public string? OutcomeMessage { get; private set; }

    public bool Registered { get; private set; }

    public void OnGet()
    {
    }

    public async Task<IActionResult> OnPostAsync()
    {
        var userName = UserName?.Trim();
        var email = Email?.Trim();

        if (string.IsNullOrEmpty(userName) || string.IsNullOrEmpty(email)
            || string.IsNullOrEmpty(Password) || string.IsNullOrEmpty(ConfirmPassword))
        {
            ModelState.AddModelError(string.Empty, "Username, email and password are required.");
            return Page();
        }

        if (!string.Equals(Password, ConfirmPassword, StringComparison.Ordinal))
        {
            // Mirrors the legacy regsubmit.asp new≠confirm outcome (and the
            // change-password flag=2 semantics).
            ModelState.AddModelError(string.Empty, "Password and confirm password do not match.");
            return Page();
        }

        var outcome = await RegistrationFlow.RegisterAsync(_userManager, userName, email, Password);

        if (outcome.Created)
        {
            // Success mirrors the legacy `regsubdone.asp` page: confirmation
            // with a link to log in.
            Registered = true;
            OutcomeMessage = "Registration successful. You can now log in.";
            return Page();
        }

        // 400 validation / 409 conflict / 5xx — surface the shared flow's
        // detail inline (no password material is ever echoed).
        ModelState.AddModelError(string.Empty, outcome.Detail);
        return Page();
    }
}