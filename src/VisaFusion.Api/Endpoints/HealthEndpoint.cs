using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;

namespace VisaFusion.Api.Endpoints;

/// <summary>
/// Health/version endpoint (SPEC-0003 T044, contracts/api-v1-scaffolding.md §1).
/// No auth required (health probe).
/// </summary>
public static class HealthEndpoint
{
    public static async Task Handle(HttpContext context, IWebHostEnvironment environment)
    {
        context.Response.StatusCode = StatusCodes.Status200OK;
        context.Response.ContentType = "application/json";
        await context.Response.WriteAsJsonAsync(new
        {
            status = "ok",
            version = "1",
            environment = environment.EnvironmentName,
        });
    }
}