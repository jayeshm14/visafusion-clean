using System.ComponentModel.DataAnnotations;
using System.Net.Http.Json;
using System.Text.Json;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using VisaFusion.Api.Contracts;
using VisaFusion.Api.Errors;
using VisaFusion.Identity;

namespace VisaFusion.Api.Endpoints;

/// <summary>
/// Public write endpoint (SPEC-0005 T012, US1, FR-012; contracts/auth-api.md §4).
///
/// `POST /api/v1/public/register` is anonymous by design and creates a
/// `guest`-only account: the role is fixed server-side, any privileged role a
/// caller might put in the payload is never read (fixes the §2.2 escalation
/// finding). Passwords meet the shared policy (min 8, no forced complexity —
/// enforced by the single Identity `RequiredLength` validator, spec §17/CHK044).
/// Rate limiting is configuration-driven only (spec §17/R7) — the built-in
/// limiter is wired by the host when the owner supplies the thresholds.
/// </summary>
public static class PublicEndpoint
{
    public static async Task RegisterAsync(
        HttpContext context,
        UserManager<IdentityIntegration.VisaFusionUser> userManager)
    {
        var request = await TryReadJsonAsync<RegisterRequest>(context);
        if (request is null) return;

        var userName = request.UserName?.Trim();
        var email = request.Email?.Trim();
        var password = request.Password;

        if (string.IsNullOrEmpty(userName) || string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password))
        {
            await WriteProblemAsync(
                context, StatusCodes.Status400BadRequest, "Validation Failed",
                "username, email and password are required");
            return;
        }

        if (!new EmailAddressAttribute().IsValid(email))
        {
            await WriteProblemAsync(
                context, StatusCodes.Status400BadRequest, "Validation Failed",
                "email must be a valid email address");
            return;
        }

        var existingByName = await userManager.FindByNameAsync(userName);
        if (existingByName is not null)
        {
            await WriteProblemAsync(
                context, StatusCodes.Status409Conflict, "Conflict",
                $"username '{userName}' is already registered");
            return;
        }

        var existingByEmail = await userManager.FindByEmailAsync(email);
        if (existingByEmail is not null)
        {
            await WriteProblemAsync(
                context, StatusCodes.Status409Conflict, "Conflict",
                $"email '{email}' is already registered");
            return;
        }

        var user = new IdentityIntegration.VisaFusionUser { UserName = userName, Email = email };
        var createResult = await userManager.CreateAsync(user, password);
        if (!createResult.Succeeded)
        {
            // Duplicate race outcomes map to 409; validation/policy failures to
            // 400 (contracts/auth-api.md §4).
            var isDuplicate = createResult.Errors.Any(e => e.Code is "DuplicateUserName" or "DuplicateEmail");
            await WriteProblemAsync(
                context,
                isDuplicate ? StatusCodes.Status409Conflict : StatusCodes.Status400BadRequest,
                isDuplicate ? "Conflict" : "Validation Failed",
                string.Join("; ", createResult.Errors.Select(e => e.Description)));
            return;
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
            await WriteProblemAsync(
                context, StatusCodes.Status500InternalServerError, "Internal Server Error",
                string.Join("; ", roleResult.Errors.Select(e => e.Description)));
            return;
        }

        context.Response.StatusCode = StatusCodes.Status201Created;
    }

    private static async Task<T?> TryReadJsonAsync<T>(HttpContext context)
        where T : class
    {
        try
        {
            return await context.Request.ReadFromJsonAsync<T>();
        }
        catch (JsonException)
        {
            // Malformed/non-JSON body on the anonymous register endpoint must be
            // a 400 validation problem-details response, not a 500.
            await WriteProblemAsync(
                context, StatusCodes.Status400BadRequest, "Validation Failed",
                "request body must be valid JSON");
            return null;
        }
    }

    private static async Task WriteProblemAsync(HttpContext context, int statusCode, string title, string detail)
    {
        context.Response.StatusCode = statusCode;
        context.Response.ContentType = "application/problem+json";
        var problem = ApiError.Create(statusCode, title, context);
        problem.Detail = detail;
        await context.Response.WriteAsync(JsonSerializer.Serialize(problem, JsonOptions));
    }

    private static readonly JsonSerializerOptions JsonOptions = new(JsonSerializerDefaults.Web);
}
