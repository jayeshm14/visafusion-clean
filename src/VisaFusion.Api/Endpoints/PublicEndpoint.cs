using System.Net.Http.Json;
using System.Text.Json;
using System.ComponentModel.DataAnnotations;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using VisaFusion.Api.Contracts;
using VisaFusion.Api.Errors;
using VisaFusion.Api.Registration;
using VisaFusion.Core.Application;
using VisaFusion.Data.Persistence;
using VisaFusion.Data.Persistence.Entities;
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
    /// AC-007; SPEC-0008 FR-007/FR-008, AC-001/AC-002; contracts/public-api.md §1).
    /// Anonymous, validated, rate-limited. Persists the query to the NEW
    /// <c>queries</c> table (status defaults to <c>new</c>, owner Q4:A) and
    /// enqueues the office notification email that is the legacy behavior of
    /// <c>contactus.asp</c> → <c>contactsendpre.asp</c> (the legacy flow had no
    /// DB persistence — the email IS the behavior; the legacy
    /// <c>querieDetail.asp</c> is a <c>visaInfo</c> content upsert and is NOT
    /// related to contact queries).
    /// Both operations commit in a single transaction so the query and its
    /// notification are atomic (if email enqueue fails, the query is not persisted).
    /// The office email recipient is configuration-driven (Notifications:OfficeEmail)
    /// with no fallback (BR-005 — no credentials/addresses hard-coded in source).
    /// </summary>
    public static async Task SubmitQueryAsync(HttpContext context)
    {
        var request = await TryReadJsonAsync<QueriesRequest>(context);
        if (request is null) return;

        if (!TryValidate(request, out var validationDetail))
        {
            await WriteProblemAsync(
                context, StatusCodes.Status400BadRequest, "Validation Failed", validationDetail);
            return;
        }

        var services = context.RequestServices;
        var db = services.GetRequiredService<VisaEntryDbContext>();
        var emailService = services.GetRequiredService<IEmailService>();
        var configuration = services.GetRequiredService<IConfiguration>();

        var query = new ContactQuery
        {
            Name = request.Name!.Trim(),
            Email = request.Email!.Trim(),
            Subject = request.Subject!.Trim(),
            Message = request.Message!.Trim(),
            Subdate = DateTime.Now,
            Status = "new",
            IpAddress = context.Connection.RemoteIpAddress?.ToString() ?? "",
        };

        // Office notification email (FR-008, AC-002): the recipient is
        // configuration-driven (Notifications:OfficeEmail) with no fallback
        // (BR-005 — no credentials/addresses hard-coded in source).
        var officeAddress = configuration["Notifications:OfficeEmail"]
            ?? throw new InvalidOperationException("Notifications:OfficeEmail is not configured. Set it in appsettings / User Secrets / Key Vault.");

        await using var tx = await db.Database.BeginTransactionAsync();
        try
        {
            db.ContactQueries.Add(query);
            await db.SaveChangesAsync();

            await emailService.EnqueueAsync(new EmailMessage(
                officeAddress,
                OfficeEmailTemplate.Subject,
                OfficeEmailTemplate.BuildHtmlBody(query.Name, query.Email, query.Message)));

            await tx.CommitAsync();
        }
        catch (Exception)
        {
            await tx.RollbackAsync();
            throw; // Let the global error handler map to 500
        }

        context.Response.StatusCode = StatusCodes.Status201Created;
        context.Response.ContentType = "application/json";
        var problem = ApiError.Create(StatusCodes.Status201Created, "Created", context);
        problem.Detail = "Query submitted successfully";
        await context.Response.WriteAsync(JsonSerializer.Serialize(problem, JsonOptions));
    }

    /// <summary>
    /// Runs the shared DataAnnotations validation over the request (spec §17:
    /// name, email, subject, message all required with length limits; email
    /// must be a valid address). Returns the joined error detail on failure.
    /// </summary>
    private static bool TryValidate(QueriesRequest request, out string detail)
    {
        var results = new List<ValidationResult>();
        var isValid = Validator.TryValidateObject(
            request, new ValidationContext(request), results, validateAllProperties: true);
        detail = isValid
            ? ""
            : string.Join("; ", results.Select(r => r.ErrorMessage));
        return isValid;
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
/// SPEC-0008 §17; contracts/public-api.md §1). Length limits: name/email/
/// subject cap at the `queries` column limit (256, ConfigureContactQuery);
/// message caps at 4000 — the column is nvarchar(max) with no schema limit, so
/// 4000 is the documented validation bound (documented in data-model.md §1).
/// </summary>
public sealed record QueriesRequest
{
    /// <summary>Sender name — required, length limit 256.</summary>
    [Required]
    [StringLength(256)]
    public string? Name { get; init; }

    /// <summary>Sender email — required, valid email, length limit 256.</summary>
    [Required]
    [EmailAddress]
    [StringLength(256)]
    public string? Email { get; init; }

    /// <summary>Subject — required, length limit 256.</summary>
    [Required]
    [StringLength(256)]
    public string? Subject { get; init; }

    /// <summary>Message — required, length limit 4000.</summary>
    [Required]
    [StringLength(4000)]
    public string? Message { get; init; }
}
