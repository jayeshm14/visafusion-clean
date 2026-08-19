using System.ComponentModel.DataAnnotations;
using System.Globalization;
using System.Text.Json;
using Microsoft.AspNetCore.Http;
using VisaFusion.Api.Contracts;
using VisaFusion.Api.Errors;
using VisaFusion.Core.Application;

namespace VisaFusion.Api.Endpoints;

/// <summary>
/// Notification endpoints (SPEC-0008 T025, FR-001/FR-002/FR-004/FR-005;
/// contracts/notifications-api.md §1-§4).
///
/// Enqueue endpoints validate (spec §17), insert the durable queue row and
/// return 202 immediately — dispatch happens on the background worker, never
/// in the request path (NFR-001). History endpoints read the audit tables
/// (`smshistory`/`sentmails`) with the optional validated filters
/// `?dateFrom=&dateTo=&agentId=`. All routes are gated by the
/// `EntryOperations` policy (emp/adm/su, FR-009) in the host.
/// </summary>
public static class NotificationsEndpoint
{
    public static async Task EnqueueSmsAsync(HttpContext context, ISmsService smsService)
    {
        var request = await TryReadJsonAsync<SmsEnqueueRequest>(context);
        if (request is null) return;

        if (!TryValidate(request, out var detail))
        {
            await WriteProblemAsync(
                context, StatusCodes.Status400BadRequest, "Validation Failed", detail);
            return;
        }

        await smsService.EnqueueAsync(new SmsMessage(
            request.Mobile!.Trim(), request.Message!.Trim(), request.Refno, request.AgentId));

        context.Response.StatusCode = StatusCodes.Status202Accepted;
    }

    public static async Task GetSmsHistoryAsync(HttpContext context, ISmsService smsService)
    {
        if (!TryParseFilters(context, out var agentId, out var dateFrom, out var dateTo, out var detail))
        {
            await WriteProblemAsync(
                context, StatusCodes.Status400BadRequest, "Validation Failed", detail);
            return;
        }

        var history = await smsService.GetHistoryAsync(agentId: agentId, from: dateFrom, to: dateTo);
        await WriteJsonAsync(context, history);
    }

    public static async Task EnqueueEmailAsync(HttpContext context, IEmailService emailService)
    {
        var request = await TryReadJsonAsync<EmailEnqueueRequest>(context);
        if (request is null) return;

        if (!TryValidate(request, out var detail))
        {
            await WriteProblemAsync(
                context, StatusCodes.Status400BadRequest, "Validation Failed", detail);
            return;
        }

        await emailService.EnqueueAsync(new EmailMessage(
            request.To!.Trim(), request.Subject!.Trim(), request.Body!.Trim(),
            Agentsid: request.AgentId, Refno: request.Refno));

        context.Response.StatusCode = StatusCodes.Status202Accepted;
    }

    public static async Task GetEmailHistoryAsync(HttpContext context, IEmailService emailService)
    {
        if (!TryParseFilters(context, out var agentId, out var dateFrom, out var dateTo, out var detail))
        {
            await WriteProblemAsync(
                context, StatusCodes.Status400BadRequest, "Validation Failed", detail);
            return;
        }

        var history = await emailService.GetHistoryAsync(agentsid: agentId, from: dateFrom, to: dateTo);
        await WriteJsonAsync(context, history);
    }

    /// <summary>
    /// Parses the optional history filters (contracts/notifications-api.md §3/§4):
    /// `agentId` must be an integer, `dateFrom`/`dateTo` must be ISO dates
    /// (yyyy-MM-dd). Empty values mean "no filter"; invalid values are a 400.
    /// </summary>
    private static bool TryParseFilters(
        HttpContext context, out int? agentId, out DateTime? dateFrom, out DateTime? dateTo, out string detail)
    {
        agentId = null;
        dateFrom = null;
        dateTo = null;

        var agentIdRaw = context.Request.Query["agentId"].ToString();
        if (!string.IsNullOrEmpty(agentIdRaw))
        {
            if (!int.TryParse(agentIdRaw, out var parsed))
            {
                detail = "agentId must be an integer";
                return false;
            }
            agentId = parsed;
        }

        if (!TryParseDate(context.Request.Query["dateFrom"], out dateFrom, out detail)) return false;
        if (!TryParseDate(context.Request.Query["dateTo"], out dateTo, out detail)) return false;

        detail = "";
        return true;
    }

    private static bool TryParseDate(string? raw, out DateTime? value, out string detail)
    {
        value = null;
        if (string.IsNullOrEmpty(raw))
        {
            detail = "";
            return true;
        }

        if (DateTime.TryParseExact(
                raw, "yyyy-MM-dd", CultureInfo.InvariantCulture, DateTimeStyles.None, out var parsed))
        {
            value = parsed;
            detail = "";
            return true;
        }

        detail = "dateFrom/dateTo must be ISO dates (yyyy-MM-dd)";
        return false;
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

    private static bool TryValidate<T>(T request, out string detail)
        where T : class
    {
        var results = new List<ValidationResult>();
        var isValid = Validator.TryValidateObject(
            request, new ValidationContext(request), results, validateAllProperties: true);
        detail = isValid
            ? ""
            : string.Join("; ", results.Select(r => r.ErrorMessage));
        return isValid;
    }

    private static async Task WriteJsonAsync(HttpContext context, object payload)
    {
        context.Response.StatusCode = StatusCodes.Status200OK;
        context.Response.ContentType = "application/json";
        await context.Response.WriteAsync(JsonSerializer.Serialize(payload, JsonOptions));
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