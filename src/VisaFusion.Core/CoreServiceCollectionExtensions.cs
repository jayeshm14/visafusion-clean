using Microsoft.Extensions.DependencyInjection;
using VisaFusion.Core.Application;

namespace VisaFusion.Core;

/// <summary>
/// Dependency-injection registration for the VisaFusion.Core business-rule surface
/// (SPEC-0003 T023, FR-003). Both the Web UI and the /api/v1 controllers resolve
/// Core services through this single registration point.
/// </summary>
public static class CoreServiceCollectionExtensions
{
    public static IServiceCollection AddVisaFusionCore(this IServiceCollection services)
    {
        services.AddScoped<ISharedRuleService, SharedRuleService>();

        // Representative shared business rule (T038, AC-003).
        services.AddScoped<ICanadaDobRule, CanadaDobRule>();

        // Placeholder domain services (T036/T037, FR-003). Scoped lifetimes.
        services.AddScoped<IEntryService, EntryService>();
        services.AddScoped<IStatusService, StatusService>();
        services.AddScoped<IBillingService, BillingService>();
        services.AddScoped<ISmsService, SmsService>();
        services.AddScoped<IEmailService, EmailService>();
        // ISecurityGateService is NOT registered here: its implementation
        // queries VisaEntryDbContext and therefore lives in VisaFusion.Data
        // (approved deviation, deviation log §5). It is registered at the
        // composition root in VisaFusion.Web/Program.cs.
        services.AddScoped<IHolidayService, HolidayService>();

        return services;
    }
}