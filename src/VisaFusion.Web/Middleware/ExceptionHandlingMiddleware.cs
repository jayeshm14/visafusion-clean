using System.Diagnostics;
using System.Text.Json;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Logging;
using VisaFusion.Api.Errors;

namespace VisaFusion.Web.Middleware;

/// <summary>
/// Centralized exception-handling middleware (SPEC-0003 T015, spec §18).
///
/// Rules:
/// - No swallowed exceptions (legacy `on error resume next` behavior is NOT carried forward).
/// - Unhandled exceptions are logged through the host logger (Serilog) and traced via
///   OpenTelemetry; the trace id is propagated into the error payload.
/// - API requests (path starts with /api) receive a standardized problem-details JSON
///   payload (400/401/403/404/500 per contracts/api-v1-scaffolding.md).
/// - Non-API requests receive a generic error page; startup and migration failures fail
///   fast with a clear, logged error and a non-zero exit (spec §18 recovery/rollback).
/// </summary>
public sealed class ExceptionHandlingMiddleware
{
    private static readonly JsonSerializerOptions JsonOptions = new(JsonSerializerDefaults.Web);

    private readonly RequestDelegate _next;
    private readonly ILogger<ExceptionHandlingMiddleware> _logger;

    public ExceptionHandlingMiddleware(RequestDelegate next, ILogger<ExceptionHandlingMiddleware> logger)
    {
        _next = next;
        _logger = logger;
    }

    public async Task InvokeAsync(HttpContext context)
    {
        try
        {
            await _next(context);
        }
        catch (Exception ex)
        {
            // Never swallow: always log the full exception (Serilog request logging is active).
            _logger.LogError(ex, "Unhandled exception while processing {Method} {Path}",
                context.Request.Method, context.Request.Path);

            var traceId = Activity.Current?.TraceId.ToString() ?? context.TraceIdentifier;

            if (context.Request.Path.StartsWithSegments("/api"))
            {
                await WriteProblemDetailsAsync(context, StatusCodes.Status500InternalServerError,
                    "An error occurred while processing the request.", traceId);
            }
            else
            {
                // Non-API: re-execute the pipeline to the CoreUI ErrorPage
                // component (SPEC-0009 T031). The 500 status and the trace id
                // are preserved by the Error page (HttpContext.TraceIdentifier).
                context.Response.Clear();
                context.Response.StatusCode = StatusCodes.Status500InternalServerError;
                context.Request.Path = "/Error/500";
                context.Request.QueryString = QueryString.Empty;
                try
                {
                    await _next(context);
                }
                catch (Exception errorPageEx)
                {
                    // The Error page itself failed during re-execution. Fall
                    // back to a static generic body so the client always
                    // receives a response (review finding 2026-08-20 — the
                    // previous WriteGenericErrorPageAsync could not fail).
                    _logger.LogError(errorPageEx,
                        "Error page failed while handling {Method} {Path}",
                        context.Request.Method, context.Request.Path);
                    if (!context.Response.HasStarted)
                    {
                        await WriteGenericErrorPageAsync(context, traceId);
                    }
                }
            }
        }
    }

    private static async Task WriteProblemDetailsAsync(HttpContext context, int statusCode, string title, string traceId)
    {
        context.Response.Clear();
        context.Response.StatusCode = statusCode;
        context.Response.ContentType = "application/problem+json";

        // Standardized problem-details factory (T016, T073): single source of
        // truth for the /api/v1 error shape (contracts/api-v1-scaffolding.md).
        var problem = ApiError.Create(statusCode, title, context);

        await context.Response.WriteAsync(JsonSerializer.Serialize(problem, JsonOptions));
    }

    private static async Task WriteGenericErrorPageAsync(HttpContext context, string traceId)
    {
        context.Response.Clear();
        context.Response.StatusCode = StatusCodes.Status500InternalServerError;
        context.Response.ContentType = "text/html; charset=utf-8";

        var html = $"""
            <!DOCTYPE html>
            <html lang="en">
            <head><meta charset="utf-8" /><title>Error - VisaFusion</title></head>
            <body>
                <h1>An error occurred while processing your request.</h1>
                <p>Reference: {System.Net.WebUtility.HtmlEncode(traceId)}</p>
            </body>
            </html>
            """;

        await context.Response.WriteAsync(html);
    }
}
