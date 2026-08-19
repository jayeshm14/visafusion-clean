using System.ComponentModel.DataAnnotations;
using System.Text.Json;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using VisaFusion.Api.Contracts;
using VisaFusion.Api.Errors;
using VisaFusion.Data.Persistence;
using VisaFusion.Data.Persistence.Entities;
using VisaFusion.Identity;

namespace VisaFusion.Api.Endpoints;

/// <summary>
/// Content module endpoints — dailyUpdate CMS (SPEC-0008 T035, US4, FR-010,
/// BR-003, AC-006; contracts/content-api.md §1/§2). Backs the legacy pages
/// <c>dailyupdate.asp</c> (write) and <c>viewdailyupdate.asp</c> (read).
///
/// Routes are gated by the <c>AdminPanel</c> policy (adm/su — DP-001) wired in
/// the host, closing the legacy anonymous <c>dailyupdate.asp</c> write endpoint
/// (BR-003, §2.8 finding). Handlers follow the existing <c>AdminEndpoint</c>
/// pattern: <see cref="TryReadJsonAsync{T}"/> for the body,
/// <see cref="WriteProblemAsync"/> for standardized problem-details errors, and
/// the audit actor resolved from the validated JWT principal — never from the
/// request body (anti-spoofing, GR-0004; spec §19). The audit event is written
/// in the SAME commit as the change it records (spec §19) so a failed operation
/// never leaves an audit gap.
/// </summary>
public static class ContentEndpoint
{
    /// <summary>
    /// POST /api/v1/admin/content/daily-update — create/edit a daily-update
    /// entry (contract §1, FR-010). Inserts when <c>id</c> is absent (201
    /// Created), updates when present (200 OK); a present <c>id</c> that does
    /// not exist maps to 404. The legacy <c>dailyupdate.asp</c> upserted by
    /// entrydate; the modern contract upserts by the surrogate <c>Id</c>
    /// (FR-003) — the entrydate is still required and stored on both paths.
    /// </summary>
    public static async Task SaveDailyUpdateAsync(
        HttpContext context, VisaEntryDbContext db,
        UserManager<IdentityIntegration.VisaFusionUser> userManager)
    {
        var request = await TryReadJsonAsync<ContentUpdateRequest>(context);
        if (request is null) return;

        if (!TryValidate(request, out var validationDetail))
        {
            await WriteProblemAsync(
                context, StatusCodes.Status400BadRequest, "Validation Failed", validationDetail);
            return;
        }

        var actor = await ResolveActorAsync(context, userManager);
        if (actor is null) return;

        var entryDate = request.Entrydate!.Value.Date;
        var description = request.Description!.Trim();

        if (request.Id is { } id)
        {
            var existing = await db.ContentUpdates.FindAsync(id);
            if (existing is null)
            {
                await WriteProblemAsync(
                    context, StatusCodes.Status404NotFound, "Not Found",
                    $"daily-update entry {id} was not found.");
                return;
            }

            existing.Entrydate = entryDate;
            existing.Description = description;
            db.AdminAuditLogs.Add(new AdminAuditLog
            {
                EventType = "DailyUpdateUpdated",
                ActorUserId = actor.UserId,
                ActorUserName = actor.UserName,
                Date = DateTime.Now,
                Detail = entryDate.ToString("yyyy-MM-dd"),
            });
            await db.SaveChangesAsync();

            context.Response.StatusCode = StatusCodes.Status200OK;
            return;
        }

        db.ContentUpdates.Add(new ContentUpdate
        {
            Entrydate = entryDate,
            Description = description,
        });
        db.AdminAuditLogs.Add(new AdminAuditLog
        {
            EventType = "DailyUpdateCreated",
            ActorUserId = actor.UserId,
            ActorUserName = actor.UserName,
            Date = DateTime.Now,
            Detail = entryDate.ToString("yyyy-MM-dd"),
        });
        await db.SaveChangesAsync();

        context.Response.StatusCode = StatusCodes.Status201Created;
    }

    /// <summary>
    /// DELETE /api/v1/admin/content/daily-update/{id} — delete a daily-update
    /// entry (contract §2, FR-010). 204 No Content on success; 404 when the id
    /// does not exist.
    /// </summary>
    public static async Task DeleteDailyUpdateAsync(
        HttpContext context, VisaEntryDbContext db,
        UserManager<IdentityIntegration.VisaFusionUser> userManager, long id)
    {
        var actor = await ResolveActorAsync(context, userManager);
        if (actor is null) return;

        var existing = await db.ContentUpdates.FindAsync(id);
        if (existing is null)
        {
            await WriteProblemAsync(
                context, StatusCodes.Status404NotFound, "Not Found",
                $"daily-update entry {id} was not found.");
            return;
        }

        db.ContentUpdates.Remove(existing);
        db.AdminAuditLogs.Add(new AdminAuditLog
        {
            EventType = "DailyUpdateDeleted",
            ActorUserId = actor.UserId,
            ActorUserName = actor.UserName,
            Date = DateTime.Now,
            Detail = existing.Entrydate?.ToString("yyyy-MM-dd") ?? string.Empty,
        });
        await db.SaveChangesAsync();

        context.Response.StatusCode = StatusCodes.Status204NoContent;
    }

    /// <summary>
    /// Runs the shared DataAnnotations validation over the request (spec §17:
    /// entrydate and description required; description ≤ 8,000 chars). Returns
    /// the joined error detail on failure.
    /// </summary>
    private static bool TryValidate(ContentUpdateRequest request, out string detail)
    {
        var results = new List<ValidationResult>();
        var isValid = Validator.TryValidateObject(
            request, new ValidationContext(request), results, validateAllProperties: true);
        detail = isValid
            ? ""
            : string.Join("; ", results.Select(r => r.ErrorMessage));
        return isValid;
    }

    /// <summary>
    /// Resolves the audit actor (AspNetUsers.Id + username) from the validated
    /// JWT principal — never from the request body (anti-spoofing, GR-0004;
    /// spec §19). Mirrors <see cref="AdminEndpoint"/>'s actor resolution: a
    /// principal with no resolvable user row is answered with a defensive 401
    /// (unreachable for policy-secured routes).
    /// </summary>
    private static async Task<Actor?> ResolveActorAsync(
        HttpContext context, UserManager<IdentityIntegration.VisaFusionUser> userManager)
    {
        var userName = context.User.Identity?.Name;
        var user = string.IsNullOrEmpty(userName)
            ? null
            : await userManager.FindByNameAsync(userName);
        if (user is null)
        {
            await WriteProblemAsync(
                context, StatusCodes.Status401Unauthorized, "Unauthorized",
                "The authenticated principal does not resolve to a user.");
            return null;
        }

        return new Actor(user.Id, user.UserName ?? string.Empty);
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
            await WriteProblemAsync(
                context, StatusCodes.Status400BadRequest, "Validation Failed",
                "request body must be valid JSON");
            return null;
        }
    }

    private static async Task WriteProblemAsync(
        HttpContext context, int statusCode, string title, string detail)
    {
        context.Response.StatusCode = statusCode;
        context.Response.ContentType = "application/problem+json";
        var problem = ApiError.Create(statusCode, title, context);
        problem.Detail = detail;
        await context.Response.WriteAsync(JsonSerializer.Serialize(problem, JsonOptions));
    }

    private static readonly JsonSerializerOptions JsonOptions = new(JsonSerializerDefaults.Web);

    private sealed record Actor(string UserId, string UserName);
}