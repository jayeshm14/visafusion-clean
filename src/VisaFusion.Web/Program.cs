using System.Text;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.RateLimiting;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using OpenTelemetry.Metrics;
using OpenTelemetry.Resources;
using OpenTelemetry.Trace;
using Serilog;
using VisaFusion.Api;
using VisaFusion.Api.Authorization;
using VisaFusion.Api.Endpoints;
using VisaFusion.Api.Errors;
using VisaFusion.Core;
using VisaFusion.Core.Application;
using VisaFusion.Data.Application;
using VisaFusion.Data.Persistence;
using VisaFusion.Identity;
using VisaFusion.Identity.Persistence;
using VisaFusion.Web.Middleware;

namespace VisaFusion.Web;

/// <summary>
/// VisaFusion single-process host (FR-002): hosts the Razor Pages UI and the
/// /api/v1 controllers from VisaFusion.Api in one ASP.NET Core process.
/// Observability: Serilog (file + SQL sinks) and OpenTelemetry tracing/metrics
/// (NFR-006). Cross-cutting constants come from Directory.Build.targets (T017).
/// </summary>
public partial class Program
{
    public static void Main(string[] args)
    {
        var builder = WebApplication.CreateBuilder(args);

        ConfigureSerilog(builder);

        builder.Host.UseSerilog();

        // ---- OpenTelemetry (NFR-006, T013) ----
        // Service name is read from configuration (defaults to the value defined in
        // Directory.Build.targets, T017). MSBuild properties cannot be substituted
        // into C# source, so the value is surfaced via appsettings.json.
        var otelServiceName = builder.Configuration["Observability:ServiceName"] ?? "VisaFusion.Web";
        builder.Services.AddOpenTelemetry()
            .ConfigureResource(resource => resource.AddService(
                serviceName: otelServiceName,
                serviceVersion: typeof(Program).Assembly.GetName().Version?.ToString() ?? "unknown"))
            .WithTracing(tracing => tracing
                .AddAspNetCoreInstrumentation())
            .WithMetrics(metrics => metrics
                .AddAspNetCoreInstrumentation());

        // ---- Single-process hosting (T026, FR-002) ----
        // Razor Pages UI + Web API controllers from VisaFusion.Api in the same host.
        builder.Services
            .AddControllers()
            .AddApplicationPart(typeof(ApiMarker).Assembly);
        builder.Services.AddRazorPages();

        // ---- Authorization policy catalog (T031, US4, FR-010) ----
        // The 11 policies from the §4.2 module × role matrix
        // (src/VisaFusion.Api/Authorization/AuthorizationPolicies.cs) turn the
        // legacy display-only gates into hard server-side denials.
        builder.Services.AddAuthorization(options => AuthorizationPolicies.Register(options));

        // ---- ASP.NET Core Identity + cookie auth for the Web UI (T009, FR-017) ----
        // AddIdentityCore registers the consolidated store against the existing
        // AspNetUsers/AspNetRoles/AspNetUserRoles tables (SPEC-0005 T003/T004)
        // so UserManager/SignInManager authenticate the migrated credentials.
        // The password policy (spec §12/§17, CHK044): minimum 8 characters, no
        // forced complexity — applied to NEW credentials only; migrated legacy
        // hashes are unaffected.
        builder.Services
            .AddIdentityCore<IdentityIntegration.VisaFusionUser>(options =>
            {
                options.Password.RequiredLength = 8;
                options.Password.RequireDigit = false;
                options.Password.RequireLowercase = false;
                options.Password.RequireUppercase = false;
                options.Password.RequireNonAlphanumeric = false;
                options.User.RequireUniqueEmail = true;
            })
            .AddRoles<IdentityRole>()
            .AddEntityFrameworkStores<VisaFusionIdentityDbContext>()
            .AddSignInManager();

        // The identity store maps the migration-tool DDL (schema source of
        // truth, plan.md §Constraints); connection comes from configuration.
        builder.Services.AddDbContext<VisaFusionIdentityDbContext>(options =>
            options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));
        builder.Services.AddHttpContextAccessor();

        // Cookie scheme = IdentityConstants.ApplicationScheme so SignInManager
        // issues the Web login cookie; the /api/v1 surface keeps JWT bearer
        // (SPEC-0003 FR-010). Cookie lifetime is read from configuration ONLY
        // (CHK040, spec §15) — no hard-coded value; the owner confirms before
        // go-live.
        builder.Services
            .AddAuthentication(IdentityConstants.ApplicationScheme)
            .AddCookie(IdentityConstants.ApplicationScheme, options =>
            {
                options.LoginPath = "/Auth/Login";
                options.AccessDeniedPath = "/Auth/AccessDenied";
                if (double.TryParse(builder.Configuration["Auth:Cookie:ExpireMinutes"], out var cookieMinutes)
                    && cookieMinutes > 0)
                {
                    options.ExpireTimeSpan = TimeSpan.FromMinutes(cookieMinutes);
                }
            });

        // ---- JWT bearer authentication for the /api/v1 surface (T043, FR-010) ----
        // Issuer/audience/key come from configuration (NOT source, NFR-004). The
        // key in appsettings.json is a development placeholder; production uses
        // User Secrets / Key Vault / environment variables.
        var jwtIssuer = builder.Configuration["Jwt:Issuer"]!;
        var jwtAudience = builder.Configuration["Jwt:Audience"]!;
        var jwtKey = builder.Configuration["Jwt:Key"]!;

        // Fail fast in Production with placeholder/dev-only configuration
        // (T075, MD-3, NFR-004): never run a production host with the committed
        // development JWT key or a localhost/Trusted_Connection connection string.
        ProductionSecretsGuard.Validate(
            builder.Environment.EnvironmentName,
            jwtKey,
            builder.Configuration.GetConnectionString("DefaultConnection") ?? string.Empty);
        builder.Services
            .AddAuthentication()
            .AddJwtBearer(options =>
            {
                options.TokenValidationParameters = new TokenValidationParameters
                {
                    ValidateIssuer = true,
                    ValidIssuer = jwtIssuer,
                    ValidateAudience = true,
                    ValidAudience = jwtAudience,
                    ValidateIssuerSigningKey = true,
                    IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(jwtKey)),
                    ValidateLifetime = true,
                    ClockSkew = TimeSpan.FromMinutes(1),
                };

                // Standardized problem-details JSON for 401/403 (T042, T073,
                // contracts/api-v1-scaffolding.md "Error Format"). The shared
                // factory (VisaFusion.Api.Errors.ApiError) is the single source
                // of truth for the /api/v1 error shape.
                options.Events = new JwtBearerEvents
                {
                    OnChallenge = async context =>
                    {
                        // spec §19/NFR-006: authorization denials are logged
                        // (subject, endpoint, outcome) without any password
                        // material — the request body is never logged.
                        LogAuthorizationDenial(context.HttpContext, context.HttpContext.User.Identity?.Name, "401");
                        context.HandleResponse();
                        context.Response.StatusCode = StatusCodes.Status401Unauthorized;
                        context.Response.ContentType = "application/problem+json";
                        var payload = System.Text.Json.JsonSerializer.Serialize(
                            ApiError.Create(StatusCodes.Status401Unauthorized, "Unauthorized", context.HttpContext));
                        await context.Response.WriteAsync(payload);
                    },
                    OnForbidden = context =>
                    {
                        // Policy/role denial: standardized problem-details 403
                        // (spec §15) + denial log (spec §19/NFR-006). The
                        // AuthorizationMiddleware forbits through the policy's
                        // schemes (JwtBearer on /api/v1), so this event fires
                        // for API role denials. The response is written here;
                        // the default handler's 403 status-set is idempotent.
                        LogAuthorizationDenial(context.HttpContext, context.HttpContext.User.Identity?.Name, "403");
                        context.Response.StatusCode = StatusCodes.Status403Forbidden;
                        context.Response.ContentType = "application/problem+json";
                        var payload = System.Text.Json.JsonSerializer.Serialize(
                            ApiError.Create(StatusCodes.Status403Forbidden, "Forbidden", context.HttpContext));
                        return context.Response.WriteAsync(payload);
                    },
                };
            });

        // Shared business-rule surface (T023, FR-003): both Web and Api resolve
        // VisaFusion.Core services through this single registration.
        builder.Services.AddVisaFusionCore();

        // Day-gate rule implementation (T018, FR-018; deviation log §5): the
        // shared ISecurityGateService interface lives in Core, but the
        // implementation queries VisaEntryDbContext (Data), so it is registered
        // here at the composition root instead of in CoreServiceCollectionExtensions.
        builder.Services.AddScoped<ISecurityGateService, SecurityGateService>();

        // ---- EF Core over the legacy VisaEntry database (T035, FR-006) ----
        builder.Services.AddDbContext<VisaEntryDbContext>(options =>
            options.UseSqlServer(
                builder.Configuration.GetConnectionString("DefaultConnection")));

        // ---- Public-write rate limiting (spec §17, Risk R7, CHK026) ----
        // The built-in fixed-window limiter is registered for the register and
        // queries routes ONLY when the owner supplies configuration values
        // (`RateLimiting:Register:PermitLimit` / `:WindowSeconds`,
        // `RateLimiting:Queries:PermitLimit` / `:WindowSeconds`) — no threshold
        // is hard-coded or invented; the owner confirms before go-live.
        var registerPermitLimit = builder.Configuration["RateLimiting:Register:PermitLimit"];
        var registerWindowSeconds = builder.Configuration["RateLimiting:Register:WindowSeconds"];
        int registerPermit = 0;
        int registerWindow = 0;
        var registerLimiterConfigured = int.TryParse(registerPermitLimit, out registerPermit)
            && int.TryParse(registerWindowSeconds, out registerWindow)
            && registerPermit > 0 && registerWindow > 0;

        var queriesPermitLimit = builder.Configuration["RateLimiting:Queries:PermitLimit"];
        var queriesWindowSeconds = builder.Configuration["RateLimiting:Queries:WindowSeconds"];
        int queriesPermit = 0;
        int queriesWindow = 0;
        var queriesLimiterConfigured = int.TryParse(queriesPermitLimit, out queriesPermit)
            && int.TryParse(queriesWindowSeconds, out queriesWindow)
            && queriesPermit > 0 && queriesWindow > 0;

        if (registerLimiterConfigured || queriesLimiterConfigured)
        {
            builder.Services.AddRateLimiter(options =>
            {
                options.RejectionStatusCode = StatusCodes.Status429TooManyRequests;
                if (registerLimiterConfigured)
                {
                    options.AddFixedWindowLimiter("register", limiter =>
                    {
                        limiter.PermitLimit = registerPermit;
                        limiter.Window = TimeSpan.FromSeconds(registerWindow);
                        limiter.QueueLimit = 0;
                    });
                }

                if (queriesLimiterConfigured)
                {
                    options.AddFixedWindowLimiter("queries", limiter =>
                    {
                        limiter.PermitLimit = queriesPermit;
                        limiter.Window = TimeSpan.FromSeconds(queriesWindow);
                        limiter.QueueLimit = 0;
                    });
                }
            });
        }

        var app = builder.Build();

        // Centralized exception handling (T015, spec §18) before any other middleware
        // so no exception is swallowed and API errors are problem-details JSON.
        app.UseMiddleware<ExceptionHandlingMiddleware>();

        app.UseSerilogRequestLogging();

        // Legacy Classic ASP URL rewrite (T035, US5, AC-007/TS-007, FR-003;
        // contracts/web-ui.md §2): maps the documented legacy entry pages
        // (Default.asp, authenticate.asp, logon.asp, regsub*.asp) to their
        // modern counterparts with a 301 and 404s any other legacy .asp URL
        // (NFR-005). Placed before HttpsRedirection so the redirect Location
        // is built from the already-normalized scheme.
        app.UseMiddleware<LegacyUrlRewriteMiddleware>();

        app.UseHttpsRedirection();

        // Self-hosted static assets (T030, spec §14): forms/, updateimg/, images/,
        // css/, js/, fonts/ under wwwroot/ (no CDN).
        app.UseStaticFiles();

        app.UseRouting();

        // Rate limiting (spec §17, Risk R7, CHK026): the middleware is only
        // added when the owner supplied the register thresholds (the limiter
        // registration above is conditional); without this call the
        // RequireRateLimiting metadata on the register route would never be
        // enforced. Placed after UseRouting (needs endpoint metadata) and
        // before auth so anonymous endpoints are throttled too. Conditional
        // because UseRateLimiter throws if AddRateLimiter was not registered.
        if (registerLimiterConfigured || queriesLimiterConfigured)
        {
            app.UseRateLimiter();
        }

        app.UseAuthentication();
        app.UseAuthorization();

        // ---- Area routing (T028, FR-005) ----
        app.MapControllerRoute(
            name: "areas",
            pattern: "{area:exists}/{controller=Home}/{action=Index}/{id?}");

        app.MapRazorPages();
        app.MapControllers();

        // ---- /api/v1 versioned surface (T046, FR-004) ----
        // Health is unauthenticated (contracts/api-v1-scaffolding.md §1). The
        // version is resolved from the shared Core surface (T074, MD-2).
        app.MapGet("/api/v1/health", (HttpContext ctx, IWebHostEnvironment env, ISharedRuleService sharedRuleService) =>
            HealthEndpoint.Handle(ctx, env, sharedRuleService));

        // Representative endpoints per area (T045, FR-004). Authorized via the
        // §4.2 policy catalog (T031, FR-010) — the legacy display-only gates
        // are now hard server-side denials. The employee endpoint invokes the
        // shared Canada DOB rule (AC-003).
        // AuthenticationSchemes must be explicitly JwtBearer so API requests
        // challenge with a 401 (problem-details) instead of a cookie redirect
        // (the default cookie scheme would redirect to /Auth/Login).
        app.MapGet("/api/v1/employee", (HttpContext ctx, ICanadaDobRule rule) =>
            EmployeeEndpoint.Handle(ctx, rule))
            .RequireAuthorization(new AuthorizeAttribute
            {
                Policy = AuthorizationPolicies.EntryOperations,
                AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme,
            });

        app.MapGet("/api/v1/agent", (HttpContext ctx) => RepresentativeEndpoint.Handle(ctx))
            .RequireAuthorization(new AuthorizeAttribute
            {
                Policy = AuthorizationPolicies.AgentSelf,
                AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme,
            });
        app.MapGet("/api/v1/admin", (HttpContext ctx) => RepresentativeEndpoint.Handle(ctx))
            .RequireAuthorization(new AuthorizeAttribute
            {
                Policy = AuthorizationPolicies.AdminPanel,
                AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme,
            });
        app.MapGet("/api/v1/billing", (HttpContext ctx) => RepresentativeEndpoint.Handle(ctx))
            .RequireAuthorization(new AuthorizeAttribute
            {
                Policy = AuthorizationPolicies.BillingOperations,
                AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme,
            });
        // Reporting and notifications have no §4.2 module row (the §4.2 matrix
        // names 11 modules; these two areas are not among them), so their
        // minimum roles stay inline per the §4.3 reports row (emp,adm,su).
        app.MapGet("/api/v1/reporting", (HttpContext ctx) => RepresentativeEndpoint.Handle(ctx))
            .RequireAuthorization(new AuthorizeAttribute
            {
                Roles = "emp,adm,su",
                AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme,
            });
        app.MapGet("/api/v1/notifications", (HttpContext ctx) => RepresentativeEndpoint.Handle(ctx))
            .RequireAuthorization(new AuthorizeAttribute
            {
                Roles = "emp,adm,su",
                AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme,
            });

        // Public area is anonymous-allowed by design (migration plan §4.2).
        app.MapGet("/api/v1/public", (HttpContext ctx) => RepresentativeEndpoint.Handle(ctx));

        // ---- Auth + public write surface (T011/T012, FR-017/FR-012, contracts/auth-api.md) ----
        // Login is anonymous — the legacy Auth module is the anonymous
        // login/registration entry point; logout is bearer-authenticated
        // (stateless JWT — the client discards the token, §2). The old GET
        // representative stub is superseded by the POST login/logout contract.
        app.MapPost("/api/v1/auth/login", (HttpContext ctx, UserManager<IdentityIntegration.VisaFusionUser> userManager, IConfiguration config, ISecurityGateService securityGateService) =>
            AuthEndpoint.LoginAsync(ctx, userManager, config, securityGateService));

        app.MapPost("/api/v1/auth/logout", (HttpContext ctx) => AuthEndpoint.LogoutAsync(ctx))
            .RequireAuthorization(new AuthorizeAttribute
            {
                AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme,
            });

        // Self-service change-password (T023, FR-019, contracts/auth-api.md §3):
        // authenticated, any role. The current user resolves from the bearer
        // principal's name claim; the new password is stored hashed via
        // UserManager.ChangePasswordAsync (no legacy lowercasing).
        app.MapPost("/api/v1/auth/change-password", (HttpContext ctx, UserManager<IdentityIntegration.VisaFusionUser> userManager) =>
            AuthEndpoint.ChangePasswordAsync(ctx, userManager))
            .RequireAuthorization(new AuthorizeAttribute
            {
                AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme,
            });

        // Public registration (FR-012): anonymous by design, role fixed
        // server-side to `guest`; rate-limited per the R7 configuration when
        // the owner supplies thresholds (no invented values).
        var registerRoute = app.MapPost("/api/v1/public/register", (HttpContext ctx, UserManager<IdentityIntegration.VisaFusionUser> userManager) =>
            PublicEndpoint.RegisterAsync(ctx, userManager));
        if (registerLimiterConfigured)
        {
            registerRoute.RequireRateLimiting("register");
        }

        // ---- Re-secured §4.3 write routes (T030, US4, FR-011; contracts/secured-write-routes.md §1) ----
        // Each route enforces authentication + the §4.2 minimum role (verbatim
        // from the §4.3 table) and returns the standardized 501 problem-details
        // body via SecuredPlaceholderEndpoint until its module feature delivers
        // the business payload. Anonymous → 401; wrong role → 403; correct role
        // → 501. AuthenticationSchemes must be explicitly JwtBearer so API
        // requests challenge with a 401 (problem-details) instead of a cookie
        // redirect (the default cookie scheme would redirect to /Auth/Login).
        app.MapPut("/api/v1/agents/{id:int}", (HttpContext ctx, int id) => SecuredPlaceholderEndpoint.Handle(ctx))
            .RequireAuthorization(new AuthorizeAttribute
            {
                Roles = "adm,su",
                AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme,
            });

        // FR-016 own-record rule: the handler validates the route id against
        // the caller's claim-bound AgentId (mismatch → 403).
        app.MapPut("/api/v1/agents/{id:int}/self", (HttpContext ctx, int id) => SecuredPlaceholderEndpoint.HandleOwnAgent(ctx, id))
            .RequireAuthorization(new AuthorizeAttribute
            {
                Roles = "agt",
                AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme,
            });

        app.MapPost("/api/v1/entries", (HttpContext ctx) => SecuredPlaceholderEndpoint.Handle(ctx))
            .RequireAuthorization(new AuthorizeAttribute
            {
                Roles = "emp,adm,su",
                AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme,
            });

        app.MapPost("/api/v1/entries/{refno}/status", (HttpContext ctx) => SecuredPlaceholderEndpoint.Handle(ctx))
            .RequireAuthorization(new AuthorizeAttribute
            {
                Roles = "emp,adm,su",
                AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme,
            });

        app.MapPost("/api/v1/entries/{refno}/awb", (HttpContext ctx) => SecuredPlaceholderEndpoint.Handle(ctx))
            .RequireAuthorization(new AuthorizeAttribute
            {
                Roles = "emp,adm,su,agt",
                AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme,
            });

        app.MapPost("/api/v1/billing/entries", (HttpContext ctx) => SecuredPlaceholderEndpoint.Handle(ctx))
            .RequireAuthorization(new AuthorizeAttribute
            {
                Roles = "emp,adm,su",
                AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme,
            });

        app.MapPost("/api/v1/holidays", (HttpContext ctx) => SecuredPlaceholderEndpoint.Handle(ctx))
            .RequireAuthorization(new AuthorizeAttribute
            {
                Roles = "adm,su",
                AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme,
            });

        app.MapDelete("/api/v1/holidays/{id:int}", (HttpContext ctx, int id) => SecuredPlaceholderEndpoint.Handle(ctx))
            .RequireAuthorization(new AuthorizeAttribute
            {
                Roles = "adm,su",
                AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme,
            });

        app.MapPost("/api/v1/reports/agent-status/today", (HttpContext ctx) => SecuredPlaceholderEndpoint.Handle(ctx))
            .RequireAuthorization(new AuthorizeAttribute
            {
                Roles = "emp,adm,su",
                AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme,
            });

        app.MapPost("/api/v1/admin/security-day/open", (HttpContext ctx) => SecuredPlaceholderEndpoint.Handle(ctx))
            .RequireAuthorization(new AuthorizeAttribute
            {
                Roles = "adm,su",
                AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme,
            });

        app.MapPost("/api/v1/admin/security-day/close", (HttpContext ctx) => SecuredPlaceholderEndpoint.Handle(ctx))
            .RequireAuthorization(new AuthorizeAttribute
            {
                Roles = "adm,su",
                AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme,
            });

        // Public-by-design write (T030, §4.3): anonymous, validated and
        // rate-limited per §17/R7 — the limiter is wired above when the owner
        // supplies the queries thresholds (no invented values). The payload
        // lands with the Public/Contact module feature (501 placeholder).
        var queriesRoute = app.MapPost("/api/v1/public/queries", (HttpContext ctx) => SecuredPlaceholderEndpoint.Handle(ctx));
        if (queriesLimiterConfigured)
        {
            queriesRoute.RequireRateLimiting("queries");
        }

        app.Run();
    }

    /// <summary>
    /// Logs an authorization denial (spec §19/NFR-006): subject, endpoint,
    /// outcome — never any password material (the request body is not logged).
    /// </summary>
    private static void LogAuthorizationDenial(HttpContext context, string? subject, string outcome)
    {
        var logger = context.RequestServices.GetService<ILoggerFactory>()?.CreateLogger("VisaFusion.Authorization");
        logger?.LogWarning(
            "Authorization denial: subject={Subject} endpoint={Endpoint} outcome={Outcome}",
            string.IsNullOrEmpty(subject) ? "anonymous" : subject,
            context.Request.Path,
            outcome);
    }

    private static void ConfigureSerilog(WebApplicationBuilder builder)
    {
        var loggerConfiguration = new LoggerConfiguration()
            .ReadFrom.Configuration(builder.Configuration)
            .WriteTo.Console()
            .WriteTo.File(
                path: "logs/visafusion-.log",
                rollingInterval: RollingInterval.Day,
                retainedFileCountLimit: 30);

        // The SQL sink requires a live SQL Server. Functional tests (WebApplicationFactory)
        // run in the "Testing" environment and must be hermetic, so the SQL sink is only
        // attached in real hosting environments (NFR-006 is exercised there).
        if (!string.Equals(builder.Environment.EnvironmentName, "Testing", StringComparison.OrdinalIgnoreCase))
        {
            loggerConfiguration.WriteTo.MSSqlServer(
                connectionString: builder.Configuration.GetConnectionString("DefaultConnection")!,
                sinkOptions: new Serilog.Sinks.MSSqlServer.MSSqlServerSinkOptions
                {
                    TableName = "Logs",
                    AutoCreateSqlTable = true,
                });
        }

        Log.Logger = loggerConfiguration.CreateLogger();
    }
}