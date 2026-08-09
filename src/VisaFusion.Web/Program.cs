using System.Text;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using OpenTelemetry.Metrics;
using OpenTelemetry.Resources;
using OpenTelemetry.Trace;
using Serilog;
using VisaFusion.Api;
using VisaFusion.Api.Endpoints;
using VisaFusion.Api.Errors;
using VisaFusion.Core;
using VisaFusion.Core.Application;
using VisaFusion.Data.Persistence;
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

        // ---- Cookie authentication for the Web UI (T029, FR-010) ----
        builder.Services
            .AddAuthentication(CookieAuthenticationDefaults.AuthenticationScheme)
            .AddCookie(options =>
            {
                options.LoginPath = "/Auth/Login";
                options.AccessDeniedPath = "/Auth/AccessDenied";
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

                // Standardized problem-details JSON for 401 (T042, T073,
                // contracts/api-v1-scaffolding.md "Error Format"). The shared
                // factory (VisaFusion.Api.Errors.ApiError) is the single source
                // of truth for the /api/v1 error shape.
                options.Events = new JwtBearerEvents
                {
                    OnChallenge = async context =>
                    {
                        context.HandleResponse();
                        context.Response.StatusCode = StatusCodes.Status401Unauthorized;
                        context.Response.ContentType = "application/problem+json";
                        var payload = System.Text.Json.JsonSerializer.Serialize(
                            ApiError.Create(StatusCodes.Status401Unauthorized, "Unauthorized", context.HttpContext));
                        await context.Response.WriteAsync(payload);
                    },
                };
            });

        // Shared business-rule surface (T023, FR-003): both Web and Api resolve
        // VisaFusion.Core services through this single registration.
        builder.Services.AddVisaFusionCore();

        // ---- EF Core over the legacy VisaEntry database (T035, FR-006) ----
        builder.Services.AddDbContext<VisaEntryDbContext>(options =>
            options.UseSqlServer(
                builder.Configuration.GetConnectionString("DefaultConnection")));

        var app = builder.Build();

        // Centralized exception handling (T015, spec §18) before any other middleware
        // so no exception is swallowed and API errors are problem-details JSON.
        app.UseMiddleware<ExceptionHandlingMiddleware>();

        app.UseSerilogRequestLogging();

        app.UseHttpsRedirection();

        // Self-hosted static assets (T030, spec §14): forms/, updateimg/, images/,
        // css/, js/, fonts/ under wwwroot/ (no CDN).
        app.UseStaticFiles();

        app.UseRouting();

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

        // Representative endpoints per area (T045, FR-004). Authorized per the
        // migration plan §4.2 role matrix (T047). The employee endpoint invokes
        // the shared Canada DOB rule (AC-003).
        // AuthenticationSchemes must be explicitly JwtBearer so API requests
        // challenge with a 401 (problem-details) instead of a cookie redirect
        // (the default cookie scheme would redirect to /Auth/Login).
        app.MapGet("/api/v1/employee", (HttpContext ctx, ICanadaDobRule rule) =>
            EmployeeEndpoint.Handle(ctx, rule))
            .RequireAuthorization(new AuthorizeAttribute
            {
                Roles = "emp,adm,su",
                AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme,
            });

        app.MapGet("/api/v1/agent", (HttpContext ctx) => RepresentativeEndpoint.Handle(ctx))
            .RequireAuthorization(new AuthorizeAttribute
            {
                Roles = "agt,emp,adm,su",
                AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme,
            });
        app.MapGet("/api/v1/admin", (HttpContext ctx) => RepresentativeEndpoint.Handle(ctx))
            .RequireAuthorization(new AuthorizeAttribute
            {
                Roles = "adm,su",
                AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme,
            });
        app.MapGet("/api/v1/billing", (HttpContext ctx) => RepresentativeEndpoint.Handle(ctx))
            .RequireAuthorization(new AuthorizeAttribute
            {
                Roles = "emp,adm,su",
                AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme,
            });
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

        // Auth area is anonymous-allowed by design (T070, HG-1): the legacy Auth
        // module is the anonymous login/registration entry point, so requiring a
        // token to reach the auth representative contradicts its purpose.
        app.MapGet("/api/v1/auth", (HttpContext ctx) => AuthEndpoint.Handle(ctx));

        app.Run();
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