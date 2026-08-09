using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using VisaFusion.Core.Application;

namespace VisaFusion.Api.Endpoints;

/// <summary>
/// Health/version endpoint (SPEC-0003 T044, contracts/api-v1-scaffolding.md §1).
/// No auth required (health probe).
///
/// The version comes from the shared Core surface (ISharedRuleService, T023/FR-003)
/// so the Api and Web entry points report the same value (T074, MD-2).
/// </summary>
public static class HealthEndpoint
{
    public static async Task Handle(HttpContext context, IWebHostEnvironment environment, ISharedRuleService sharedRuleService)
    {
        context.Response.StatusCode = StatusCodes.Status200OK;
        context.Response.ContentType = "application/json";
        await context.Response.WriteAsJsonAsync(new
        {
            status = "ok",
            version = sharedRuleService.GetApiVersion(),
            environment = environment.EnvironmentName,
        });
    }
}