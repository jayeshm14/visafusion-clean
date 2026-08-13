using System.Text.Json;
using Microsoft.AspNetCore.Http;
using VisaFusion.Api.Errors;

namespace VisaFusion.Api.Authorization;

/// <summary>
/// Shared placeholder handler for the re-secured §4.3 write routes (SPEC-0005
/// T029, US4, FR-011; spec §15, contracts/secured-write-routes.md §1).
///
/// Each route enforces authentication + its §4.2 minimum role (wired in the
/// host) and returns the standardized 501 problem-details body — no fake
/// payloads — until the module feature delivers the business payload.
/// Anonymous → 401 (bearer challenge); wrong role → 403 (authorization
/// middleware); correct role → 501 (this handler).
///
/// <see cref="HandleOwnAgent"/> additionally enforces the FR-016 own-record
/// rule for `PUT /api/v1/agents/{id}/self`: the route id must equal the
/// caller's claim-bound <see cref="IdentityClaims.AgentIdClaimType"/>; a
/// mismatch yields 403, never another agent's data (spec §17).
/// </summary>
public static class SecuredPlaceholderEndpoint
{
    public static async Task Handle(HttpContext context)
    {
        await WriteProblemAsync(
            context, StatusCodes.Status501NotImplemented, "Not Implemented",
            "This route enforces authentication and role authorization; the business payload is delivered by its module feature (SPEC-0005 §15).");
    }

    public static async Task HandleOwnAgent(HttpContext context, int id)
    {
        // FR-016/§17: the own-record route validates that the target id equals
        // the caller's claim-bound AgentId. A missing or mismatched claim is a
        // denial — the caller's bound identity is never re-derived from a
        // request parameter.
        var claimAgentId = IdentityClaims.GetAgentId(context.User);
        if (!claimAgentId.HasValue || claimAgentId.Value != id)
        {
            await WriteProblemAsync(
                context, StatusCodes.Status403Forbidden, "Forbidden",
                "Agents may only access their own record.");
            return;
        }

        await Handle(context);
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