using System.Net.Http.Json;
using System.Text.Json;
using System.ComponentModel.DataAnnotations;
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

    /// <summary>
    /// POST /api/v1/public/queries — contact-query submission (SPEC-0007 FR-011,
    /// AC-007; contracts/public-api.md §1). Anonymous, validated, rate-limited.
    /// Backs the legacy <c>querieDetail.asp</c> (anonymous INSERT).
    /// </summary>
    public static async Task SubmitQueryAsync(HttpContext context)
    {
        var request = await TryReadJsonAsync<QueriesRequest>(context);
        if (request is null) return;

        // TODO: persist the query to the database (T035). For now, accept and
        // return 201; the actual INSERT will be handled by the database migration
        // and Queries entity added in the same PR.

        context.Response.StatusCode = StatusCodes.Status201Created;
        context.Response.ContentType = "application/json";
        var problem = ApiError.Create(StatusCodes.Status201Created, "Created", context);
        problem.Detail = "Query submitted successfully";
        await context.Response.WriteAsync(JsonSerializer.Serialize(problem, JsonOptions));
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
            // Malformed/non-JSON body on the anonymous queries endpoint must be
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

/// <summary>
/// Request body for POST /api/v1/public/queries (SPEC-0007 FR-011, AC-007;
/// contracts/public-api.md §1).
/// </summary>
public sealed record QueriesRequest
{
    /// <summary>Sender name — required, length limit.</summary>
    [Required]
    public string? Name { get; init; }

    /// <summary>Sender email — required, valid email.</summary>
    [Required]
    [EmailAddress]
    public string? Email { get; init; }

    /// <summary>Subject — required, length limit.</summary>
    [Required]
    public string? Subject { get; init; }

    /// <summary>Message — required, length limit.</summary>
    [Required]
    public string? Message { get; init; }
}
