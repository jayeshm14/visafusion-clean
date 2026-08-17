using System.Text.Json;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using VisaFusion.Api.Contracts;
using VisaFusion.Api.Errors;
using VisaFusion.Core.Application;
using VisaFusion.Identity;

namespace VisaFusion.Api.Endpoints;

/// <summary>
/// Admin module endpoints — security-day + user management (SPEC-0007 T020/
/// T025, US2/US3, FR-005..008/FR-023, BR-003/BR-004; AC-003/AC-004/AC-018;
/// contracts/admin-api.md §1-§6). Backs the legacy pages
/// <c>openForDay.asp</c>, <c>closeForDay.asp</c>, <c>securityHome.asp</c>,
/// <c>addNewUser.asp</c>, <c>editdonetest.asp</c>,
/// <c>deleteUser.asp</c>/<c>deleteSubmit.asp</c>.
///
/// Routes are gated by the policies wired in the host (<c>SecurityGate</c> =
/// adm/su; <c>UserManagement</c> = adm/emp — DP-001; <c>SuperUserOnly</c> =
/// claim-based su). Handlers follow the existing <c>AgentsEndpoint</c> pattern:
/// <see cref="TryReadJsonAsync{T}"/> for the body, <see cref="WriteProblemAsync"/>
/// for standardized problem-details errors, and the shared Core services
/// (<see cref="ISecurityGateService"/>, <see cref="IUserManagementService"/>)
/// for all business behavior (never the DbContext). The audit actor AND the
/// actor's effective roles are resolved from the validated JWT principal —
/// never from the request body (anti-spoofing, GR-0004; spec §19). The su-role
/// rules (FR-006/FR-007) are enforced by the policy and re-checked by the
/// service.
/// </summary>
public static class AdminEndpoint
{
    /// <summary>
    /// POST /api/v1/admin/security-day/open — open the working day (contract
    /// §1, FR-008, BR-003, CHK022). The date defaults to the server-local
    /// today; the day being already open maps to 409.
    /// </summary>
    public static async Task OpenDayAsync(
        HttpContext context, ISecurityGateService securityGate)
    {
        var request = await TryReadJsonAsync<OpenDayRequest>(context);
        if (request is null) return;

        var actorName = await ResolveActorNameAsync(context);
        if (actorName is null) return;

        var date = request.Date ?? DateTime.Now;

        var result = await securityGate.OpenDayAsync(date, actorName);
        if (result == SecurityDayOpenResult.AlreadyOpen)
        {
            await WriteProblemAsync(
                context, StatusCodes.Status409Conflict, "Conflict",
                $"the working day {date:yyyy-MM-dd} is already open");
            return;
        }

        await WriteDayAsync(context, securityGate, date);
    }

    /// <summary>
    /// POST /api/v1/admin/security-day/close — close the working day (contract
    /// §2, FR-008, BR-003, CHK021). The date defaults to the server-local
    /// today; no open row for the date maps to 404.
    /// </summary>
    public static async Task CloseDayAsync(
        HttpContext context, ISecurityGateService securityGate)
    {
        var request = await TryReadJsonAsync<CloseDayRequest>(context);
        if (request is null) return;

        var actorName = await ResolveActorNameAsync(context);
        if (actorName is null) return;

        var date = request.Date ?? DateTime.Now;

        var result = await securityGate.CloseDayAsync(date, actorName);
        if (result == SecurityDayCloseResult.NotFound)
        {
            await WriteProblemAsync(
                context, StatusCodes.Status404NotFound, "Not Found",
                $"no open working day exists for {date:yyyy-MM-dd}");
            return;
        }

        await WriteDayAsync(context, securityGate, date);
    }

    /// <summary>
    /// GET /api/v1/admin/security-day/today — current day status (contract §3,
    /// FR-008; legacy <c>securityHome.asp</c>). 200 with the open/closed state
    /// for the server-local today.
    /// </summary>
    public static async Task GetTodayAsync(
        HttpContext context, ISecurityGateService securityGate)
    {
        await WriteDayAsync(context, securityGate, DateTime.Now);
    }

    /// <summary>POST /api/v1/admin/users — create user with a whitelisted role (contract §4).</summary>
    public static async Task CreateUserAsync(
        HttpContext context, IUserManagementService users,
        UserManager<IdentityIntegration.VisaFusionUser> userManager)
    {
        var request = await TryReadJsonAsync<CreateUserRequest>(context);
        if (request is null) return;

        var actor = await ResolveActorAsync(context, userManager);
        if (actor is null) return;

        try
        {
            var user = await users.CreateAsync(
                new CreateUserInput(
                    request.Username ?? string.Empty,
                    request.Password ?? string.Empty,
                    request.Email,
                    request.Role ?? string.Empty,
                    request.AgentId),
                actor.UserId, actor.UserName, context.RequestAborted);

            context.Response.StatusCode = StatusCodes.Status201Created;
            context.Response.ContentType = "application/json";
            await context.Response.WriteAsJsonAsync(ToResponse(user));
        }
        catch (UserManagementValidationException ex)
        {
            await WriteProblemAsync(context, StatusCodes.Status400BadRequest, "Validation Failed", ex.Message);
        }
        catch (UserManagementConflictException ex)
        {
            await WriteProblemAsync(context, StatusCodes.Status409Conflict, "Conflict", ex.Message);
        }
    }

    /// <summary>POST /api/v1/admin/superusers — elevate an existing account to su (contract §5, FR-006).</summary>
    public static async Task ProvisionSuperUserAsync(
        HttpContext context, IUserManagementService users,
        UserManager<IdentityIntegration.VisaFusionUser> userManager)
    {
        var request = await TryReadJsonAsync<ProvisionSuperUserRequest>(context);
        if (request is null) return;

        var actor = await ResolveActorAsync(context, userManager);
        if (actor is null) return;

        // The contract names an EXISTING account by username; the service takes
        // the user id, so the target is resolved here (404 when it does not
        // exist — the legacy deleteUser.asp naming).
        var username = request.Username?.Trim();
        var target = string.IsNullOrEmpty(username)
            ? null
            : await userManager.FindByNameAsync(username);
        if (target is null)
        {
            await WriteProblemAsync(
                context, StatusCodes.Status404NotFound, "Not Found",
                $"User '{username}' was not found.");
            return;
        }

        try
        {
            var user = await users.ProvisionSuperUserAsync(
                target.Id, actor.UserId, actor.UserName, actor.Roles, context.RequestAborted);

            context.Response.StatusCode = StatusCodes.Status200OK;
            context.Response.ContentType = "application/json";
            await context.Response.WriteAsJsonAsync(ToResponse(user));
        }
        catch (UserManagementValidationException ex)
        {
            await WriteProblemAsync(context, StatusCodes.Status400BadRequest, "Validation Failed", ex.Message);
        }
    }

    /// <summary>POST /api/v1/admin/users/{id}/deactivate — deactivate a user (contract §6, FR-023).</summary>
    public static async Task DeactivateUserAsync(
        HttpContext context, IUserManagementService users,
        UserManager<IdentityIntegration.VisaFusionUser> userManager, string id)
    {
        var actor = await ResolveActorAsync(context, userManager);
        if (actor is null) return;

        try
        {
            var user = await users.DeactivateAsync(
                id, actor.UserId, actor.UserName, actor.Roles, context.RequestAborted);

            context.Response.StatusCode = StatusCodes.Status200OK;
            context.Response.ContentType = "application/json";
            await context.Response.WriteAsJsonAsync(ToResponse(user));
        }
        catch (UserManagementValidationException ex)
        {
            await WriteProblemAsync(context, StatusCodes.Status400BadRequest, "Validation Failed", ex.Message);
        }
        catch (UserManagementNotFoundException ex)
        {
            await WriteProblemAsync(context, StatusCodes.Status404NotFound, "Not Found", ex.Message);
        }
    }

    /// <summary>
    /// Resolves the audit actor (AspNetUsers.Id + username) and the actor's DB
    /// roles from the validated JWT principal — never from the request body
    /// (anti-spoofing, GR-0004; spec §19). The roles feed the service-level su
    /// re-checks (FR-006/FR-007). Mirrors <see cref="AgentsEndpoint"/>'s actor
    /// resolution: a principal with no resolvable user row is answered with a
    /// defensive 401 (unreachable for policy-secured routes).
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

        var roles = await userManager.GetRolesAsync(user);
        return new Actor(user.Id, user.UserName ?? string.Empty, roles.ToList());
    }

    private static UserResponse ToResponse(UserSummary u) => new()
    {
        Id = u.Id,
        UserName = u.UserName,
        Email = u.Email,
        Roles = u.Roles,
        Active = u.Active,
    };

    /// <summary>
    /// Writes the current security-day state for the date as the 200 response
    /// (contract §1-§3). A day with no row serializes as a null body — the
    /// caller (page or client) renders the "not opened" state.
    /// </summary>
    private static async Task WriteDayAsync(
        HttpContext context, ISecurityGateService securityGate, DateTime date)
    {
        var status = await securityGate.GetTodayAsync(date);
        context.Response.StatusCode = StatusCodes.Status200OK;
        context.Response.ContentType = "application/json";
        await context.Response.WriteAsJsonAsync(status is null
            ? null
            : new SecurityDayResponse
            {
                Date = status.Date,
                OpeningTime = status.OpeningTime,
                OpenedBy = status.OpenedBy,
                ClosingTime = status.ClosingTime,
                ClosedBy = status.ClosedBy,
            });
    }

    /// <summary>
    /// Resolves the actor username from the validated JWT principal — never
    /// from the request body (anti-spoofing, GR-0004). The security-day audit
    /// events record the actor username only (the service writes
    /// <c>ActorUserId = string.Empty</c>), so no UserManager lookup is needed.
    /// A principal with no name is answered with a defensive 401 (unreachable
    /// for policy-secured routes).
    /// </summary>
    private static async Task<string?> ResolveActorNameAsync(HttpContext context)
    {
        var actorName = context.User.Identity?.Name;
        if (string.IsNullOrEmpty(actorName))
        {
            await WriteProblemAsync(
                context, StatusCodes.Status401Unauthorized, "Unauthorized",
                "The authenticated principal does not resolve to a user.");
            return null;
        }

        return actorName;
    }

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

    private sealed record Actor(string UserId, string UserName, IReadOnlyList<string> Roles);
}
