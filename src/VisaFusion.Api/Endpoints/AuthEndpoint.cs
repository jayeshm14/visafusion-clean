using System.Globalization;
using System.IdentityModel.Tokens.Jwt;
using System.Net.Http.Json;
using System.Security.Claims;
using System.Text;
using System.Text.Json;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using VisaFusion.Api.Authorization;
using VisaFusion.Api.Contracts;
using VisaFusion.Api.Errors;
using VisaFusion.Core.Application;
using VisaFusion.Identity;

namespace VisaFusion.Api.Endpoints;

/// <summary>
/// Auth endpoints (SPEC-0005 T011, US1, FR-017; contracts/auth-api.md §1–§2).
///
/// `POST /api/v1/auth/login` authenticates against the consolidated Identity
/// store and returns a JWT minted with the claim contract from
/// <see cref="IdentityClaims"/> (roles, claim-bound `AgentId`, `SuperUser`).
/// The day-gate for `emp` logins is wired by US2 (T019, FR-018).
///
/// `POST /api/v1/auth/logout` is bearer-authenticated: the API is a stateless
/// JWT surface, so the client discards the token (§2).
/// </summary>
public static class AuthEndpoint
{
    public static async Task LoginAsync(
        HttpContext context,
        UserManager<IdentityIntegration.VisaFusionUser> userManager,
        IConfiguration config,
        ISecurityGateService securityGateService)
    {
        var request = await TryReadJsonAsync<LoginRequest>(context);
        if (request is null) return;

        var userName = request.UserName?.Trim();
        var password = request.Password;

        if (string.IsNullOrEmpty(userName) || string.IsNullOrEmpty(password))
        {
            await WriteProblemAsync(
                context, StatusCodes.Status400BadRequest, "Validation Failed",
                "username and password are required");
            return;
        }

        var user = await userManager.FindByNameAsync(userName);
        if (user is null
            || !await userManager.CheckPasswordAsync(user, password)
            || await userManager.IsLockedOutAsync(user))
        {
            // Single generic 401 (contracts/auth-api.md §1): the caller is never
            // told whether the account is locked out or the credentials are
            // wrong (no account-state disclosure). Inactive accounts
            // (LockoutEnabled + far-future LockoutEnd, FR-009) land here.
            // The password hash is always computed before the lockout check so
            // the response timing does not reveal lockout state (review finding
            // 2026-08-13; deviation log §7).
            await WriteProblemAsync(
                context, StatusCodes.Status401Unauthorized, "Invalid Credentials",
                "Invalid username or password.");
            return;
        }

        var roles = await userManager.GetRolesAsync(user);

        // Day-gate (T019, FR-018, AC-011; contracts/auth-api.md §1): emp logins
        // require an open security day for today. Evaluated AFTER credential
        // validation (legacy authenticate.asp lines 62–79 checks the gate only
        // after the credential query matches), so 401 stays the generic
        // bad-credentials response and 403 is the day-gate rejection.
        if (await securityGateService.EvaluateAsync(roles, DateTime.Today)
            == SecurityGateDecision.RejectedNotOpened)
        {
            await WriteProblemAsync(
                context, StatusCodes.Status403Forbidden, "Day Not Opened",
                "The office has not been opened for today.",
                new Dictionary<string, object?> { ["rsn"] = "O" });
            return;
        }

        var claims = IdentityClaims.FromUser(user, roles);
        var token = CreateToken(config, claims);

        // The response agentId is claim-bound (FR-007): it is read from the
        // minted claim, exactly the value carried in the token.
        var agentId = claims
            .Where(c => c.Type == IdentityClaims.AgentIdClaimType)
            .Select(c => int.TryParse(c.Value, NumberStyles.Integer, CultureInfo.InvariantCulture, out var id)
                ? id
                : (int?)null)
            .FirstOrDefault();

        context.Response.StatusCode = StatusCodes.Status200OK;
        await context.Response.WriteAsJsonAsync(new LoginResponse(
            token,
            user.UserName ?? string.Empty,
            IdentityClaims.EffectiveRoles(roles),
            agentId));
    }

    public static Task LogoutAsync(HttpContext context)
    {
        // contracts/auth-api.md §2: stateless JWT — the client discards the
        // token; there is nothing server-side to revoke.
        context.Response.StatusCode = StatusCodes.Status204NoContent;
        return Task.CompletedTask;
    }

    /// <summary>
    /// Self-service change-password (SPEC-0005 T023, US3, FR-019, AC-012/TS-014;
    /// contracts/auth-api.md §3). Authenticated (any role).
    ///
    /// The current user is resolved from the bearer principal's `name` claim
    /// (the JWT carries `name`/`sub` = username, IdentityClaims.FromUser) —
    /// never from a request parameter. The new password is stored hashed via
    /// UserManager.ChangePasswordAsync with NO legacy lowercasing; the single
    /// shared Identity password validator (RequiredLength = 8, registered in
    /// Program.cs) enforces the policy — the same rule the Web UI uses
    /// (spec §17/CHK044).
    ///
    /// Outcomes: 204 success; 400 wrong current password (mirrors legacy
    /// changepassword.asp?flag=3), new ≠ confirm (flag=2), or policy violation
    /// (new password under 8 characters); 401 unauthenticated.
    /// </summary>
    public static async Task ChangePasswordAsync(
        HttpContext context,
        UserManager<IdentityIntegration.VisaFusionUser> userManager)
    {
        var request = await TryReadJsonAsync<ChangePasswordRequest>(context);
        if (request is null) return;

        var currentPassword = request.CurrentPassword;
        var newPassword = request.NewPassword;
        var confirmPassword = request.ConfirmPassword;

        if (string.IsNullOrEmpty(currentPassword)
            || string.IsNullOrEmpty(newPassword)
            || string.IsNullOrEmpty(confirmPassword))
        {
            await WriteProblemAsync(
                context, StatusCodes.Status400BadRequest, "Validation Failed",
                "currentPassword, newPassword and confirmPassword are required");
            return;
        }

        // The bearer principal's name claim is the username (IdentityClaims
        // mints `name` = username); the user row is resolved from it.
        var userName = context.User.Identity?.Name;
        var user = string.IsNullOrEmpty(userName)
            ? null
            : await userManager.FindByNameAsync(userName);
        if (user is null)
        {
            // No resolvable identity on an authenticated route: treat as
            // unauthenticated (the token is valid but names no store user).
            await WriteProblemAsync(
                context, StatusCodes.Status401Unauthorized, "Unauthorized",
                "The authenticated principal does not resolve to a user.");
            return;
        }

        // flag=2: "PLEASE ENTER THE SAME VALUES FOR NEW AND CONFIRM PASSWORD."
        if (!string.Equals(newPassword, confirmPassword, StringComparison.Ordinal))
        {
            await WriteProblemAsync(
                context, StatusCodes.Status400BadRequest, "Validation Failed",
                "newPassword and confirmPassword must match");
            return;
        }

        // flag=3: "PLEASE CHECK USERNAME OR PASSWORD." — the current password
        // must verify before any change is attempted.
        if (!await userManager.CheckPasswordAsync(user, currentPassword))
        {
            await WriteProblemAsync(
                context, StatusCodes.Status400BadRequest, "Validation Failed",
                "currentPassword is incorrect");
            return;
        }

        // Policy + storage: ChangePasswordAsync runs the shared Identity
        // password validators (RequiredLength = 8) and stores the hash.
        var result = await userManager.ChangePasswordAsync(user, currentPassword, newPassword);
        if (!result.Succeeded)
        {
            await WriteProblemAsync(
                context, StatusCodes.Status400BadRequest, "Validation Failed",
                string.Join("; ", result.Errors.Select(e => e.Description)));
            return;
        }

        context.Response.StatusCode = StatusCodes.Status204NoContent;
    }

    /// <summary>
    /// Mints the JWT. Issuer/audience/key/expiry are read from configuration
    /// only (CHK040, spec §15) — no hard-coded values; missing config fails
    /// fast, and ProductionSecretsGuard already blocks dev-only keys there.
    /// </summary>
    private static string CreateToken(IConfiguration config, IEnumerable<Claim> claims)
    {
        var issuer = config["Jwt:Issuer"] ?? throw new InvalidOperationException("Jwt:Issuer is not configured.");
        var audience = config["Jwt:Audience"] ?? throw new InvalidOperationException("Jwt:Audience is not configured.");
        var key = config["Jwt:Key"] ?? throw new InvalidOperationException("Jwt:Key is not configured.");
        var expiryMinutes = config["Jwt:ExpiryMinutes"]
            ?? throw new InvalidOperationException("Jwt:ExpiryMinutes is not configured.");
        if (!double.TryParse(expiryMinutes, NumberStyles.Float, CultureInfo.InvariantCulture, out var minutes)
            || minutes <= 0)
        {
            throw new InvalidOperationException("Jwt:ExpiryMinutes must be a positive number.");
        }

        var token = new JwtSecurityToken(
            issuer: issuer,
            audience: audience,
            claims: claims,
            notBefore: DateTime.UtcNow,
            expires: DateTime.UtcNow.AddMinutes(minutes),
            signingCredentials: new SigningCredentials(
                new SymmetricSecurityKey(Encoding.UTF8.GetBytes(key)),
                SecurityAlgorithms.HmacSha256));

        return new JwtSecurityTokenHandler().WriteToken(token);
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
            // Malformed/non-JSON body on the anonymous login endpoint must be a
            // 400 validation problem-details response, not a 500 (the
            // ExceptionHandlingMiddleware would otherwise surface it as 500).
            await WriteProblemAsync(
                context, StatusCodes.Status400BadRequest, "Validation Failed",
                "request body must be valid JSON");
            return null;
        }
    }

    private static async Task WriteProblemAsync(
        HttpContext context, int statusCode, string title, string detail,
        IDictionary<string, object?>? extensions = null)
    {
        context.Response.StatusCode = statusCode;
        context.Response.ContentType = "application/problem+json";
        var problem = ApiError.Create(statusCode, title, context);
        problem.Detail = detail;
        if (extensions is not null)
        {
            foreach (var (key, value) in extensions)
            {
                problem.Extensions[key] = value;
            }
        }

        await context.Response.WriteAsync(JsonSerializer.Serialize(problem, JsonOptions));
    }

    private static readonly JsonSerializerOptions JsonOptions = new(JsonSerializerDefaults.Web);
}
