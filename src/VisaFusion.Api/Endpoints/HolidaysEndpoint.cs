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
/// Holiday/weekly-off management endpoints (SPEC-0008 T041, US5, FR-011,
/// BR-006, AC-007; contracts/content-api.md §3-§6). Backs the legacy pages
/// <c>holiday_entry.asp</c> (create), <c>holidayDeleteSubmit.asp</c> (delete)
/// and <c>WeeklyOffList.asp</c> (weekly-off).
///
/// Routes are gated by the <c>HolidayAdmin</c> policy (adm/su — DP-001) wired
/// in the host. Handlers follow the existing <c>ContentEndpoint</c> pattern:
/// <see cref="TryReadJsonAsync{T}"/> for the body,
/// <see cref="WriteProblemAsync"/> for standardized problem-details errors, and
/// the audit actor resolved from the validated JWT principal — never from the
/// request body (anti-spoofing, GR-0004; spec §19). The audit event is written
/// in the SAME commit as the change it records (spec §19).
///
/// Duplicate semantics (contract §3/§5): the legacy <c>holiday_entry.asp</c>
/// skipped an existing embassy+date row ("ALREADY EXISTS"); the modern contract
/// maps that to 409. The legacy weekly-off path replaced ALL rows for the
/// embassy; the modern contract creates one embassy+weekday row at a time and
/// rejects a duplicate with 409 (the replace-all flow is not reproduced — the
/// contract is the source of truth for the new surface).
/// </summary>
public static class HolidaysEndpoint
{
    /// <summary>
    /// POST /api/v1/holidays — create an embassy holiday (contract §3, FR-011).
    /// Duplicate embassy+date maps to 409; success is 201 Created. The row is
    /// immediately honored by <c>IHolidayService.IsEmbassyClosedAsync</c>
    /// (AC-007).
    /// </summary>
    public static async Task CreateHolidayAsync(
        HttpContext context, VisaEntryDbContext db,
        UserManager<IdentityIntegration.VisaFusionUser> userManager)
    {
        var request = await TryReadJsonAsync<HolidayCreateRequest>(context);
        if (request is null) return;

        if (!TryValidate(request, out var validationDetail))
        {
            await WriteProblemAsync(
                context, StatusCodes.Status400BadRequest, "Validation Failed", validationDetail);
            return;
        }

        var actor = await ResolveActorAsync(context, userManager);
        if (actor is null) return;

        var embassyId = request.EmbassyId!.Value;
        var holidayDate = request.HolidayDate!.Value.Date;

        var duplicate = await db.Holidays.AnyAsync(
            h => h.CountryId == embassyId && h.HolidayDate == holidayDate);
        if (duplicate)
        {
            await WriteProblemAsync(
                context, StatusCodes.Status409Conflict, "Conflict",
                $"a holiday for embassy {embassyId} on {holidayDate:yyyy-MM-dd} already exists");
            return;
        }

        db.Holidays.Add(new Holiday
        {
            CountryId = embassyId,
            HolidayDate = holidayDate,
            Description = request.Description?.Trim(),
        });
        db.AdminAuditLogs.Add(new AdminAuditLog
        {
            EventType = "HolidayCreated",
            ActorUserId = actor.UserId,
            ActorUserName = actor.UserName,
            Date = DateTime.Now,
            Detail = $"{embassyId}:{holidayDate:yyyy-MM-dd}",
        });
        await db.SaveChangesAsync();

        context.Response.StatusCode = StatusCodes.Status201Created;
    }

    /// <summary>
    /// DELETE /api/v1/holidays/{id} — delete an embassy holiday (contract §4,
    /// FR-011). 204 No Content on success; 404 when the id does not exist.
    /// </summary>
    public static async Task DeleteHolidayAsync(
        HttpContext context, VisaEntryDbContext db,
        UserManager<IdentityIntegration.VisaFusionUser> userManager, long id)
    {
        var actor = await ResolveActorAsync(context, userManager);
        if (actor is null) return;

        var existing = await db.Holidays.FindAsync(id);
        if (existing is null)
        {
            await WriteProblemAsync(
                context, StatusCodes.Status404NotFound, "Not Found",
                $"holiday {id} was not found.");
            return;
        }

        db.Holidays.Remove(existing);
        db.AdminAuditLogs.Add(new AdminAuditLog
        {
            EventType = "HolidayDeleted",
            ActorUserId = actor.UserId,
            ActorUserName = actor.UserName,
            Date = DateTime.Now,
            Detail = $"{existing.CountryId}:{existing.HolidayDate:yyyy-MM-dd}",
        });
        await db.SaveChangesAsync();

        context.Response.StatusCode = StatusCodes.Status204NoContent;
    }

    /// <summary>
    /// POST /api/v1/holidays/weekly-off — create an embassy weekly-off weekday
    /// (contract §5, FR-011, BR-006). Invalid weekday (outside 1–7) maps to 400;
    /// duplicate embassy+weekday maps to 409; success is 201 Created. The row is
    /// immediately honored by <c>IHolidayService.IsEmbassyClosedAsync</c>
    /// (AC-007).
    /// </summary>
    public static async Task CreateWeeklyOffAsync(
        HttpContext context, VisaEntryDbContext db,
        UserManager<IdentityIntegration.VisaFusionUser> userManager)
    {
        var request = await TryReadJsonAsync<WeeklyOffCreateRequest>(context);
        if (request is null) return;

        if (!TryValidate(request, out var validationDetail))
        {
            await WriteProblemAsync(
                context, StatusCodes.Status400BadRequest, "Validation Failed", validationDetail);
            return;
        }

        var actor = await ResolveActorAsync(context, userManager);
        if (actor is null) return;

        var embassyId = request.EmbassyId!.Value;
        var weekday = request.Weekday!.Value;

        var duplicate = await db.WeeklyOffs.AnyAsync(
            w => w.Embassyid == embassyId && w.Weekend == weekday);
        if (duplicate)
        {
            await WriteProblemAsync(
                context, StatusCodes.Status409Conflict, "Conflict",
                $"a weekly-off for embassy {embassyId} on weekday {weekday} already exists");
            return;
        }

        db.WeeklyOffs.Add(new WeeklyOff
        {
            Embassyid = embassyId,
            Weekend = weekday,
            Description = request.Description?.Trim(),
        });
        db.AdminAuditLogs.Add(new AdminAuditLog
        {
            EventType = "WeeklyOffCreated",
            ActorUserId = actor.UserId,
            ActorUserName = actor.UserName,
            Date = DateTime.Now,
            Detail = $"{embassyId}:{weekday}",
        });
        await db.SaveChangesAsync();

        context.Response.StatusCode = StatusCodes.Status201Created;
    }

    /// <summary>
    /// DELETE /api/v1/holidays/weekly-off/{id} — delete an embassy weekly-off
    /// weekday (contract §6, FR-011). 204 No Content on success; 404 when the id
    /// does not exist.
    /// </summary>
    public static async Task DeleteWeeklyOffAsync(
        HttpContext context, VisaEntryDbContext db,
        UserManager<IdentityIntegration.VisaFusionUser> userManager, long id)
    {
        var actor = await ResolveActorAsync(context, userManager);
        if (actor is null) return;

        var existing = await db.WeeklyOffs.FindAsync(id);
        if (existing is null)
        {
            await WriteProblemAsync(
                context, StatusCodes.Status404NotFound, "Not Found",
                $"weekly-off {id} was not found.");
            return;
        }

        db.WeeklyOffs.Remove(existing);
        db.AdminAuditLogs.Add(new AdminAuditLog
        {
            EventType = "WeeklyOffDeleted",
            ActorUserId = actor.UserId,
            ActorUserName = actor.UserName,
            Date = DateTime.Now,
            Detail = $"{existing.Embassyid}:{existing.Weekend}",
        });
        await db.SaveChangesAsync();

        context.Response.StatusCode = StatusCodes.Status204NoContent;
    }

    /// <summary>
    /// Runs the shared DataAnnotations validation over the request (spec §17:
    /// required fields; weekday 1–7 per BR-006). Returns the joined error detail
    /// on failure.
    /// </summary>
    private static bool TryValidate(object request, out string detail)
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
    /// spec §19). Mirrors <see cref="ContentEndpoint"/>'s actor resolution: a
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