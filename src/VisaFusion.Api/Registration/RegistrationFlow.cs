using System.ComponentModel.DataAnnotations;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using VisaFusion.Identity;

namespace VisaFusion.Api.Registration;

/// <summary>
/// Shared guest-registration flow (SPEC-0005 T040; contracts/auth-api.md §4).
///
/// Single implementation of the register rules used by both the anonymous
/// `POST /api/v1/public/register` endpoint (PublicEndpoint) and the Web
/// `/Auth/Register` page (RegisterModel): the page must not duplicate the
/// endpoint's logic, and the endpoint must not diverge from the page.
///
/// The role is fixed server-side to `guest` — any privileged role a caller
/// might put in a payload is never read (fixes the §2.2 escalation finding,
/// FR-012). Passwords meet the shared policy (min 8, no forced complexity —
/// enforced by the single Identity `RequiredLength` validator, spec §17/
/// CHK044).
/// </summary>
public static class RegistrationFlow
{
    public sealed record Outcome(bool Created, int StatusCode, string Title, string Detail);

    public static async Task<Outcome> RegisterAsync(
        UserManager<IdentityIntegration.VisaFusionUser> userManager,
        string? userName, string? email, string? password)
    {
        userName = userName?.Trim();
        email = email?.Trim();

        if (string.IsNullOrEmpty(userName) || string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password))
        {
            return new Outcome(false, StatusCodes.Status400BadRequest, "Validation Failed",
                "username, email and password are required");
        }

        if (!new EmailAddressAttribute().IsValid(email))
        {
            return new Outcome(false, StatusCodes.Status400BadRequest, "Validation Failed",
                "email must be a valid email address");
        }

        var existingByName = await userManager.FindByNameAsync(userName);
        if (existingByName is not null)
        {
            return new Outcome(false, StatusCodes.Status409Conflict, "Conflict",
                $"username '{userName}' is already registered");
        }

        var existingByEmail = await userManager.FindByEmailAsync(email);
        if (existingByEmail is not null)
        {
            return new Outcome(false, StatusCodes.Status409Conflict, "Conflict",
                $"email '{email}' is already registered");
        }

        var user = new IdentityIntegration.VisaFusionUser { UserName = userName, Email = email };
        var createResult = await userManager.CreateAsync(user, password);
        if (!createResult.Succeeded)
        {
            // Duplicate race outcomes map to 409; validation/policy failures to
            // 400 (contracts/auth-api.md §4).
            var isDuplicate = createResult.Errors.Any(e => e.Code is "DuplicateUserName" or "DuplicateEmail");
            return new Outcome(false,
                isDuplicate ? StatusCodes.Status409Conflict : StatusCodes.Status400BadRequest,
                isDuplicate ? "Conflict" : "Validation Failed",
                string.Join("; ", createResult.Errors.Select(e => e.Description)));
        }

        // FR-012/BR-004: the role is fixed server-side to `guest`; no caller
        // input influences it.
        var roleResult = await userManager.AddToRoleAsync(user, IdentityIntegration.Roles.Guest);
        if (!roleResult.Succeeded)
        {
            // Roll back the created user so the failure is recoverable: a
            // half-registered account (no role) could never sign in and would
            // block re-registration with a 409 on username/email.
            await userManager.DeleteAsync(user);
            return new Outcome(false, StatusCodes.Status500InternalServerError, "Internal Server Error",
                string.Join("; ", roleResult.Errors.Select(e => e.Description)));
        }

        return new Outcome(true, StatusCodes.Status201Created, string.Empty, string.Empty);
    }
}
