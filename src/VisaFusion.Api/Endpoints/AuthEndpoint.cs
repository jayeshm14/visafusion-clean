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
        IConfiguration config)
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
            || await userManager.IsLockedOutAsync(user)
            || !await userManager.CheckPasswordAsync(user, password))
        {
            // Single generic 401 (contracts/auth-api.md §1): the caller is never
            // told whether the account is locked out or the credentials are
            // wrong (no account-state disclosure). Inactive accounts
            // (LockoutEnabled + far-future LockoutEnd, FR-009) land here.
            await WriteProblemAsync(
                context, StatusCodes.Status401Unauthorized, "Invalid Credentials",
                "Invalid username or password.");
            return;
        }

        var roles = await userManager.GetRolesAsync(user);
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
