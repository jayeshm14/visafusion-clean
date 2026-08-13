using System.Net.Http.Json;
using System.Text.Json;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using VisaFusion.Api.Contracts;
using VisaFusion.Api.Errors;
using VisaFusion.Api.Registration;
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

        // The register rules live in the shared RegistrationFlow (T040) so the
        // Web /Auth/Register page and this endpoint can never diverge.
        var outcome = await RegistrationFlow.RegisterAsync(
            userManager, request.UserName, request.Email, request.Password);

        if (!outcome.Created)
        {
            await WriteProblemAsync(context, outcome.StatusCode, outcome.Title, outcome.Detail);
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
