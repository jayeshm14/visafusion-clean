using System.Diagnostics;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace VisaFusion.Api.Errors;

/// <summary>
/// Standardized problem-details error factory for the /api/v1 surface
/// (SPEC-0003 T016, contracts/api-v1-scaffolding.md "Error Format").
///
/// All endpoints return RFC 9110 problem-details JSON:
///   400 validation, 401 unauthenticated, 403 unauthorized, 404 not found,
///   500 unhandled (logged via Serilog, traced via OpenTelemetry).
/// </summary>
public static class ApiError
{
    public static ProblemDetails Create(int statusCode, string title, HttpContext? httpContext = null)
    {
        var details = new ProblemDetails
        {
            Type = "https://tools.ietf.org/html/rfc9110#section-15.6.1",
            Title = title,
            Status = statusCode,
        };

        if (httpContext is not null)
        {
            details.Extensions["traceId"] =
                Activity.Current?.TraceId.ToString() ?? httpContext.TraceIdentifier;
        }

        return details;
    }
}
