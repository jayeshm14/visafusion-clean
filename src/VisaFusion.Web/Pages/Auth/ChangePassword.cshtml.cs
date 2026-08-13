using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using VisaFusion.Identity;

namespace VisaFusion.Web.Pages.Auth;

/// <summary>
/// Self-service change-password page (SPEC-0005 T022, US3, FR-019; spec §14,
/// contracts/web-ui.md §1.4).
///
/// Authenticated (any role). Outcomes mirror the legacy
/// `changepassword.asp?flag=1|2|3` as inline messages (verified 2026-08-11:
/// flag=1 "PASSWORD CHANGED SUCCESSFULLY.", flag=2 "PLEASE ENTER THE SAME
/// VALUES FOR NEW AND CONFIRM PASSWORD.", flag=3 "PLEASE CHECK USERNAME OR
/// PASSWORD.") plus the policy-violation outcome (new password under 8
/// characters, spec §17). The new password is stored hashed via
/// UserManager.ChangePasswordAsync — no legacy lowercasing, no plaintext.
/// </summary>
[Authorize]
public class ChangePasswordModel : PageModel
{
    private readonly UserManager<IdentityIntegration.VisaFusionUser> _userManager;

    public ChangePasswordModel(UserManager<IdentityIntegration.VisaFusionUser> userManager)
    {
        _userManager = userManager;
    }

    [BindProperty]
    public string? CurrentPassword { get; set; }

    [BindProperty]
    public string? NewPassword { get; set; }

    [BindProperty]
    public string? ConfirmPassword { get; set; }

    /// <summary>Inline outcome message mirroring the legacy `changepassword.asp?flag=` table.</summary>
    public string? ResultMessage { get; private set; }

    public void OnGet()
    {
    }

    public async Task<IActionResult> OnPostAsync()
    {
        // [Authorize] guarantees an authenticated cookie principal; the user
        // row is resolved from the cookie identity (nameidentifier = user id).
        var user = await _userManager.GetUserAsync(User);
        if (user is null)
        {
            return RedirectToPage("/Auth/Login");
        }

        if (string.IsNullOrEmpty(CurrentPassword)
            || string.IsNullOrEmpty(NewPassword)
            || string.IsNullOrEmpty(ConfirmPassword))
        {
            ResultMessage = "Please enter the current, new and confirm passwords.";
            return Page();
        }

        // flag=2: "PLEASE ENTER THE SAME VALUES FOR NEW AND CONFIRM PASSWORD."
        if (!string.Equals(NewPassword, ConfirmPassword, StringComparison.Ordinal))
        {
            ResultMessage = "Please enter the same values for new and confirm password.";
            return Page();
        }

        // flag=3: "PLEASE CHECK USERNAME OR PASSWORD." — the current password
        // must verify before any change is attempted.
        if (!await _userManager.CheckPasswordAsync(user, CurrentPassword))
        {
            ResultMessage = "Please check the current password.";
            return Page();
        }

        // The single shared Identity password validator (RequiredLength = 8,
        // registered in Program.cs) enforces the policy — the same rule the
        // API surface uses (spec §17/CHK044). Policy violations surface here
        // as the validator's error descriptions.
        var result = await _userManager.ChangePasswordAsync(user, CurrentPassword, NewPassword);
        if (!result.Succeeded)
        {
            ResultMessage = string.Join(" ", result.Errors.Select(e => e.Description));
            return Page();
        }

        // flag=1: "PASSWORD CHANGED SUCCESSFULLY."
        ResultMessage = "Password changed successfully.";
        return Page();
    }
}