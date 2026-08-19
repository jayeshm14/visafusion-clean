using System.Text.Json;
using Microsoft.AspNetCore.Http;
using VisaFusion.Api.Contracts;
using VisaFusion.Api.Errors;
using VisaFusion.Data.Persistence;

namespace VisaFusion.Api.Endpoints;

/// <summary>
/// Reporting module endpoints — operational reports (SPEC-0008 T046, US6,
/// FR-012, AC-008; contracts/reports-api.md). Backs the legacy pages
/// <c>todayAgentStatusalltemp.asp</c>, <c>pendinglist.asp</c>,
/// <c>todaySubmission*.asp</c>, <c>todayCollection*.asp</c>,
/// <c>todayTransaction.asp</c>, <c>dailyVisaFee.asp</c> and <c>dailybill.asp</c>.
///
/// Routes are gated by the <c>EntryOperations</c> policy (emp/adm/su — DP-001)
/// wired in the host. All data access is parameterized EF Core LINQ in
/// <see cref="ReportQueries"/> — no string-built SQL (NFR-002; fixes the §6.6
/// SQLi finding); the same queries feed the Reporting Razor pages so API and UI
/// can never diverge (AC-008). Query parameters are parsed and validated by
/// <see cref="ReportQueryParams"/>; invalid inputs produce 400 BEFORE any query
/// runs (spec §17).
/// </summary>
public static class ReportsEndpoint
{
    private static readonly JsonSerializerOptions JsonOptions = new(JsonSerializerDefaults.Web);

    /// <summary>GET /api/v1/reports/agent-status/today — agent status snapshot (contracts/reports-api.md).</summary>
    public static async Task AgentStatusTodayAsync(HttpContext context, VisaEntryDbContext db)
    {
        var p = await TryResolveParamsAsync(context);
        if (p is null) return;
        await WriteJsonAsync(context, await ReportQueries.AgentStatusTodayAsync(db, p));
    }

    /// <summary>GET /api/v1/reports/pending — pending entries (legacy <c>pendinglist.asp</c>).</summary>
    public static async Task PendingAsync(HttpContext context, VisaEntryDbContext db)
    {
        var p = await TryResolveParamsAsync(context);
        if (p is null) return;
        await WriteJsonAsync(context, await ReportQueries.PendingAsync(db, p));
    }

    /// <summary>GET /api/v1/reports/today-submission — entries submitted in the range (legacy <c>todaySubmission*.asp</c>).</summary>
    public static async Task TodaySubmissionAsync(HttpContext context, VisaEntryDbContext db)
    {
        var p = await TryResolveParamsAsync(context);
        if (p is null) return;
        await WriteJsonAsync(context, await ReportQueries.TodaySubmissionAsync(db, p));
    }

    /// <summary>GET /api/v1/reports/today-collection — collections received in the range (legacy <c>todayCollection*.asp</c>).</summary>
    public static async Task TodayCollectionAsync(HttpContext context, VisaEntryDbContext db)
    {
        var p = await TryResolveParamsAsync(context);
        if (p is null) return;
        await WriteJsonAsync(context, await ReportQueries.TodayCollectionAsync(db, p));
    }

    /// <summary>GET /api/v1/reports/today-transaction — today's transactions (legacy <c>todayTransaction.asp</c>).</summary>
    public static async Task TodayTransactionAsync(HttpContext context, VisaEntryDbContext db)
    {
        var p = await TryResolveParamsAsync(context);
        if (p is null) return;
        await WriteJsonAsync(context, await ReportQueries.TodayTransactionAsync(db, p));
    }

    /// <summary>GET /api/v1/reports/daily-visa-fee — visa fees by country/day (legacy <c>dailyVisaFee.asp</c>).</summary>
    public static async Task DailyVisaFeeAsync(HttpContext context, VisaEntryDbContext db)
    {
        var p = await TryResolveParamsAsync(context);
        if (p is null) return;
        await WriteJsonAsync(context, await ReportQueries.DailyVisaFeeAsync(db, p));
    }

    /// <summary>GET /api/v1/reports/daily-bill — daily bills + day total (legacy <c>dailybill.asp</c>).</summary>
    public static async Task DailyBillAsync(HttpContext context, VisaEntryDbContext db)
    {
        var p = await TryResolveParamsAsync(context);
        if (p is null) return;
        var report = new DailyBillReport(
            await ReportQueries.DailyBillGrandTotalAsync(db, p),
            await ReportQueries.DailyBillAsync(db, p));
        await WriteJsonAsync(context, report);
    }

    /// <summary>
    /// Parses and validates the common query parameters, mapping a validation
    /// failure to the standardized 400 problem-details response (spec §17).
    /// Returns null after writing the 400.
    /// </summary>
    private static async Task<ReportQueryParams?> TryResolveParamsAsync(HttpContext context)
    {
        if (ReportQueryParams.TryParse(context.Request.Query, out var parameters, out var error))
        {
            return parameters;
        }

        await WriteProblemAsync(context, StatusCodes.Status400BadRequest, "Validation Failed", error!);
        return null;
    }

    private static async Task WriteJsonAsync(HttpContext context, object payload)
    {
        context.Response.StatusCode = StatusCodes.Status200OK;
        context.Response.ContentType = "application/json; charset=utf-8";
        await context.Response.WriteAsync(JsonSerializer.Serialize(payload, JsonOptions));
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
}