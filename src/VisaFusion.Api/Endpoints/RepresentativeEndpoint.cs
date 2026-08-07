using Microsoft.AspNetCore.Http;

namespace VisaFusion.Api.Endpoints;

/// <summary>
/// Representative read-only list endpoint for an area (SPEC-0003 T045,
/// contracts/api-v1-scaffolding.md §2). Returns a minimal stub list + count.
/// </summary>
public static class RepresentativeEndpoint
{
    public static async Task Handle(HttpContext context)
    {
        var items = Array.Empty<object>();

        context.Response.StatusCode = StatusCodes.Status200OK;
        context.Response.ContentType = "application/json";
        await context.Response.WriteAsJsonAsync(new RepresentativeListDto(items, items.Length));
    }
}