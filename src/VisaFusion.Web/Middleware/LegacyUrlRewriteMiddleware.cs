using Microsoft.AspNetCore.Http.HttpResults;

namespace VisaFusion.Web.Middleware;

/// <summary>
/// Legacy Classic ASP URL rewrite middleware (SPEC-0005 T034, US5, AC-007/
/// TS-007, FR-003; contracts/web-ui.md §2).
///
/// After cutover the legacy IIS entry URLs must keep working. This middleware
/// maps the documented legacy entry pages to their modern counterparts with a
/// permanent (301) redirect — legacy IIS is case-insensitive, so matching is
/// case-insensitive — and responds with a clear 404 to any other legacy `.asp`
/// URL instead of silently forwarding it somewhere unrelated (NFR-005).
///
/// Resolution is a pure, testable static function (<see cref="Resolve"/>);
/// only the I/O sits in the middleware. The mapping is the only dependency
/// graph web-ui.md §2 calls for:
///   `Default.asp` → `/`
///   `authenticate.asp`, `logon.asp` → `/Auth/Login`
///   `regsub*.asp` (regsub, regsubmit, regsubdone) → `/Auth/Register`
///   any other `*.asp` → handled with no target (respond 404)
///   everything else → pass through unchanged
/// </summary>
public sealed class LegacyUrlRewriteMiddleware
{
    private static readonly string[] LoginPages = { "authenticate.asp", "logon.asp" };
    private const string RegisterPrefix = "regsub";
    private const string RegisterSuffix = ".asp";
    private const string DefaultPage = "Default.asp";

    private readonly RequestDelegate _next;

    public LegacyUrlRewriteMiddleware(RequestDelegate next) => _next = next;

    /// <summary>
    /// Resolves a request path against the legacy mapping table.
    /// </summary>
    /// <param name="path">The request path (no query string).</param>
    /// <returns>
    /// <c>(Handled: false, Target: null)</c> for non-legacy paths (pass through);
    /// <c>(Handled: true, Target: target)</c> for a mapped redirect;
    /// <c>(Handled: true, Target: null)</c> for a legacy path with no mapping
    /// (the middleware responds 404 itself).
    /// </returns>
    public static (bool Handled, string? Target) Resolve(string path)
    {
        if (string.IsNullOrEmpty(path) || !path.StartsWith("/", StringComparison.Ordinal))
        {
            return (false, null);
        }

        var lastSegment = path[(path.LastIndexOf('/') + 1)..];
        if (!lastSegment.EndsWith(".asp", StringComparison.OrdinalIgnoreCase))
        {
            return (false, null);
        }

        if (string.Equals(lastSegment, DefaultPage, StringComparison.OrdinalIgnoreCase))
        {
            return (true, "/");
        }

        if (LoginPages.Any(p => string.Equals(lastSegment, p, StringComparison.OrdinalIgnoreCase)))
        {
            return (true, "/Auth/Login");
        }

        if (lastSegment.StartsWith(RegisterPrefix, StringComparison.OrdinalIgnoreCase) &&
            lastSegment.EndsWith(RegisterSuffix, StringComparison.OrdinalIgnoreCase))
        {
            return (true, "/Auth/Register");
        }

        // Any other legacy .asp URL is handled with no target: explicit 404.
        return (true, null);
    }

    public async Task InvokeAsync(HttpContext context)
    {
        var (handled, target) = Resolve(context.Request.Path.Value ?? "/");
        if (!handled)
        {
            await _next(context);
            return;
        }

        if (target is null)
        {
            // NFR-005: unknown legacy .asp URLs get a clear 404 rather than a
            // silent redirect to an unrelated modern page.
            var response = TypedResults.NotFound("No page found at this URL.");
            await response.ExecuteAsync(context);
            return;
        }

        var query = context.Request.QueryString.Value;
        var location = target + query;
        var redirect = TypedResults.Redirect(location, permanent: true);
        await redirect.ExecuteAsync(context);
    }
}
