using System.Globalization;
using Microsoft.AspNetCore.Http;

namespace VisaFusion.Api.Endpoints;

/// <summary>
/// Parsed report query parameters (SPEC-0008 T046, US6; contracts/reports-api.md).
/// Shared by <see cref="ReportsEndpoint"/> (which maps a parse error to a 400
/// problem-details response) and the Reporting Razor pages (which render the
/// same validation message inline) so the API and the UI can never diverge.
///
/// Rules (spec §17): <c>dateFrom</c>/<c>dateTo</c> must be ISO-8601 dates
/// (yyyy-MM-dd); <c>dateTo</c> must be on or after <c>dateFrom</c> when both are
/// present; <c>agentId</c> must be an integer. When neither date is given the
/// range defaults to today; when only one is given the range is that single
/// day (<see cref="ResolvedTo"/> = end of the to-day).
/// </summary>
public sealed record ReportQueryParams(DateTime From, DateTime? To, int? AgentId)
{
    /// <summary>End of the to-day; the single-day range when dateTo was absent.</summary>
    public DateTime ResolvedTo => To ?? From.AddDays(1).AddTicks(-1);

    /// <summary>
    /// Parses and validates the common report query parameters. Returns true on
    /// success (parameters populated); false with a user-facing <paramref name="error"/>
    /// when a value is invalid — validation happens BEFORE any query runs.
    /// </summary>
    public static bool TryParse(IQueryCollection query, out ReportQueryParams? parameters, out string? error)
    {
        var dateFromRaw = query["dateFrom"].ToString();
        var dateToRaw = query["dateTo"].ToString();
        var agentIdRaw = query["agentId"].ToString();

        DateTime? from = null;
        if (!string.IsNullOrWhiteSpace(dateFromRaw))
        {
            if (!DateTime.TryParseExact(dateFromRaw, "yyyy-MM-dd", CultureInfo.InvariantCulture,
                    DateTimeStyles.None, out var parsed))
            {
                parameters = null;
                error = "dateFrom must be a valid ISO-8601 date (yyyy-MM-dd).";
                return false;
            }

            from = parsed;
        }

        DateTime? to = null;
        if (!string.IsNullOrWhiteSpace(dateToRaw))
        {
            if (!DateTime.TryParseExact(dateToRaw, "yyyy-MM-dd", CultureInfo.InvariantCulture,
                    DateTimeStyles.None, out var parsed))
            {
                parameters = null;
                error = "dateTo must be a valid ISO-8601 date (yyyy-MM-dd).";
                return false;
            }

            to = parsed;
        }

        if (from is not null && to is not null && to < from)
        {
            parameters = null;
            error = "dateTo must be on or after dateFrom.";
            return false;
        }

        int? agentId = null;
        if (!string.IsNullOrWhiteSpace(agentIdRaw))
        {
            if (!int.TryParse(agentIdRaw, out var parsedAgent))
            {
                parameters = null;
                error = "agentId must be an integer.";
                return false;
            }

            agentId = parsedAgent;
        }

        var fromDay = (from ?? to ?? DateTime.Today).Date;
        var toDay = (to ?? from ?? DateTime.Today).Date;
        parameters = new ReportQueryParams(fromDay, toDay.AddDays(1).AddTicks(-1), agentId);
        error = null;
        return true;
    }
}