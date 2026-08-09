using Microsoft.AspNetCore.Http;

namespace VisaFusion.Api.Endpoints;

/// <summary>
/// Auth representative endpoint (SPEC-0003 T045/T070, FR-004, AC-002).
///
/// `GET /api/v1/auth` returns the standard stub list + count. It is
/// anonymous-allowed (mirrors `/api/v1/public`): the legacy Auth module
/// (`authenticate.asp`, `logon.asp`, `regsub*.asp`, migration plan §5
/// `AuthController`) is the anonymous login/registration entry point —
/// requiring a token to reach the auth representative contradicts the
/// module's purpose.
/// </summary>
public static class AuthEndpoint
{
    public static async Task Handle(HttpContext context)
    {
        var items = Array.Empty<object>();

        context.Response.StatusCode = StatusCodes.Status200OK;
        context.Response.ContentType = "application/json";
        await context.Response.WriteAsJsonAsync(new RepresentativeListDto(items, items.Length));
    }
}