using System.Text.Json;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using VisaFusion.Api.Contracts;
using VisaFusion.Api.Errors;
using VisaFusion.Core.Application;
using VisaFusion.Identity;

namespace VisaFusion.Api.Endpoints;

/// <summary>
/// Agents module endpoints — admin CRUD + lifecycle (SPEC-0007 T014, US1,
/// FR-001..004, FR-022; AC-001/AC-002/AC-016/AC-017; contracts/agents-api.md
/// §1/§5/§6/§7). Backs the legacy pages <c>addnewagents.asp</c>,
/// <c>newagent.asp</c>, <c>viewagent.asp</c>, <c>editdoneagent1.asp</c>,
/// <c>deleteUser.asp</c>.
///
/// All five routes are gated by the <c>AdminPanel</c> policy (adm/su) wired in
/// the host. Handlers follow the existing <c>EntriesEndpoint</c> pattern:
/// <see cref="TryReadJsonAsync{T}"/> for the body, <see cref="WriteProblemAsync"/>
/// for standardized problem-details errors, and the shared Core
/// <see cref="IAgentService"/> for all business behavior (never the DbContext).
/// The audit actor is resolved from the validated JWT claims — never from the
/// request body (anti-spoofing, GR-0004; spec §19).
/// </summary>
public static class AgentsEndpoint
{
    /// <summary>POST /api/v1/agents — create agent + linked agt login (contract §6).</summary>
    public static async Task CreateAsync(
        HttpContext context, IAgentService agents,
        UserManager<IdentityIntegration.VisaFusionUser> userManager)
    {
        var request = await TryReadJsonAsync<CreateAgentRequest>(context);
        if (request is null) return;

        var actor = await ResolveActorAsync(context, userManager);
        if (actor is null) return;

        try
        {
            var agent = await agents.CreateAsync(
                ToInput(request), request.Username ?? string.Empty,
                request.Password ?? string.Empty,
                actor.UserId, actor.UserName, context.RequestAborted);

            context.Response.StatusCode = StatusCodes.Status201Created;
            context.Response.ContentType = "application/json";
            await context.Response.WriteAsJsonAsync(new { id = agent.Id });
        }
        catch (AgentValidationException ex)
        {
            await WriteProblemAsync(context, StatusCodes.Status400BadRequest, "Validation Failed", ex.Message);
        }
        catch (AgentConflictException ex)
        {
            await WriteProblemAsync(context, StatusCodes.Status409Conflict, "Conflict", ex.Message);
        }
    }

    /// <summary>GET /api/v1/agents — paginated agent list (contract §5).</summary>
    public static async Task ListAsync(HttpContext context, IAgentService agents)
    {
        var page = TryParse(context.Request.Query["page"], 1);
        var pageSize = TryParse(context.Request.Query["pageSize"], 50);
        var q = context.Request.Query["q"].ToString();

        var result = await agents.ListAsync(page, pageSize, q, context.RequestAborted);

        context.Response.StatusCode = StatusCodes.Status200OK;
        context.Response.ContentType = "application/json";
        await context.Response.WriteAsJsonAsync(new AgentListResponse
        {
            Items = result.Items.Select(ToResponse).ToList(),
            Total = result.Total,
        });
    }

    /// <summary>PUT /api/v1/agents/{id} — update agent (contract §1).</summary>
    public static async Task UpdateAsync(HttpContext context, IAgentService agents, int id)
    {
        var request = await TryReadJsonAsync<UpdateAgentRequest>(context);
        if (request is null) return;

        try
        {
            var agent = await agents.UpdateAsync(id, ToInput(request), context.RequestAborted);

            context.Response.StatusCode = StatusCodes.Status200OK;
            context.Response.ContentType = "application/json";
            await context.Response.WriteAsJsonAsync(ToResponse(agent));
        }
        catch (AgentValidationException ex)
        {
            await WriteProblemAsync(context, StatusCodes.Status400BadRequest, "Validation Failed", ex.Message);
        }
        catch (AgentNotFoundException ex)
        {
            await WriteProblemAsync(context, StatusCodes.Status404NotFound, "Not Found", ex.Message);
        }
    }

    /// <summary>POST /api/v1/agents/{id}/deactivate — deactivate agent (contract §7, FR-004).</summary>
    public static async Task DeactivateAsync(
        HttpContext context, IAgentService agents,
        UserManager<IdentityIntegration.VisaFusionUser> userManager, int id)
    {
        var actor = await ResolveActorAsync(context, userManager);
        if (actor is null) return;

        try
        {
            var agent = await agents.DeactivateAsync(id, actor.UserId, actor.UserName, context.RequestAborted);

            context.Response.StatusCode = StatusCodes.Status200OK;
            context.Response.ContentType = "application/json";
            await context.Response.WriteAsJsonAsync(ToResponse(agent));
        }
        catch (AgentNotFoundException ex)
        {
            await WriteProblemAsync(context, StatusCodes.Status404NotFound, "Not Found", ex.Message);
        }
    }

    /// <summary>POST /api/v1/agents/{id}/reactivate — reactivate agent (contract §7, FR-022).</summary>
    public static async Task ReactivateAsync(
        HttpContext context, IAgentService agents,
        UserManager<IdentityIntegration.VisaFusionUser> userManager, int id)
    {
        var actor = await ResolveActorAsync(context, userManager);
        if (actor is null) return;

        try
        {
            var agent = await agents.ReactivateAsync(id, actor.UserId, actor.UserName, context.RequestAborted);

            context.Response.StatusCode = StatusCodes.Status200OK;
            context.Response.ContentType = "application/json";
            await context.Response.WriteAsJsonAsync(ToResponse(agent));
        }
        catch (AgentNotFoundException ex)
        {
            await WriteProblemAsync(context, StatusCodes.Status404NotFound, "Not Found", ex.Message);
        }
    }

    /// <summary>
    /// Resolves the audit actor (AspNetUsers.Id + username) from the validated
    /// JWT principal — never from the request body (anti-spoofing, GR-0004;
    /// spec §19). Mirrors <see cref="EntriesEndpoint.ChangeStatusAsync"/>'s user
    /// resolution: a principal with no resolvable username or user row is
    /// answered with a defensive 401 (unreachable for <c>AdminPanel</c>-secured
    /// routes, where a policy pass implies an authenticated principal).
    /// </summary>
    private static async Task<Actor?> ResolveActorAsync(
        HttpContext context, UserManager<IdentityIntegration.VisaFusionUser> userManager)
    {
        var userName = context.User.Identity?.Name;
        var user = string.IsNullOrEmpty(userName)
            ? null
            : await userManager.FindByNameAsync(userName);
        if (user is null)
        {
            await WriteProblemAsync(
                context, StatusCodes.Status401Unauthorized, "Unauthorized",
                "The authenticated principal does not resolve to a user.");
            return null;
        }

        return new Actor(user.Id, user.UserName ?? string.Empty);
    }

    private static AgentInput ToInput(CreateAgentRequest r) => new(
        r.Companyname, r.Description, r.Street1, r.Street2, r.Area, r.City,
        r.Pincode, r.Phoneno, r.Faxno, r.Emailid, r.Smsno, r.Directorname,
        r.DirectorPH, r.AcMgrPH, r.VisaInchargeName, r.VisaInchargePH, r.Acno,
        r.Payment, r.TAAI, r.TAFI, r.Membership, r.IATA);

    private static AgentInput ToInput(UpdateAgentRequest r) => new(
        r.Companyname, r.Description, r.Street1, r.Street2, r.Area, r.City,
        r.Pincode, r.Phoneno, r.Faxno, r.Emailid, r.Smsno, r.Directorname,
        r.DirectorPH, r.AcMgrPH, r.VisaInchargeName, r.VisaInchargePH, r.Acno,
        r.Payment, r.TAAI, r.TAFI, r.Membership, r.IATA);

    private static AgentResponse ToResponse(AgentDetail a) => new()
    {
        Id = a.Id,
        Companyname = a.Companyname,
        Description = a.Description,
        Street1 = a.Street1,
        Street2 = a.Street2,
        Area = a.Area,
        City = a.City,
        Pincode = a.Pincode,
        Phoneno = a.Phoneno,
        Faxno = a.Faxno,
        Emailid = a.Emailid,
        Smsno = a.Smsno,
        Directorname = a.Directorname,
        DirectorPH = a.DirectorPH,
        AcMgrPH = a.AcMgrPH,
        VisaInchargeName = a.VisaInchargeName,
        VisaInchargePH = a.VisaInchargePH,
        Acno = a.Acno,
        Payment = a.Payment,
        TAAI = a.TAAI,
        TAFI = a.TAFI,
        Membership = a.Membership,
        IATA = a.IATA,
        Active = a.Active,
        Creationdate = a.Creationdate,
        Enteredby = a.Enteredby,
    };

    private static int TryParse(Microsoft.Extensions.Primitives.StringValues value, int fallback)
        => int.TryParse(value.ToString(), out var parsed) ? parsed : fallback;

    private static async Task<T?> TryReadJsonAsync<T>(HttpContext context)
        where T : class
    {
        try
        {
            return await context.Request.ReadFromJsonAsync<T>();
        }
        catch (JsonException)
        {
            await WriteProblemAsync(
                context, StatusCodes.Status400BadRequest, "Validation Failed",
                "request body must be valid JSON");
            return null;
        }
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

    private static readonly JsonSerializerOptions JsonOptions = new(JsonSerializerDefaults.Web);

    private sealed record Actor(string UserId, string UserName);
}
