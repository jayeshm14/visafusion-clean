namespace VisaFusion.Core.Application;

/// <summary>
/// Shared business-rule surface (SPEC-0003 T023, FR-003).
///
/// This is the scaffolding entry point that both the Web UI and the /api/v1
/// surface consume, proving that business rules live in VisaFusion.Core and are
/// shared by both entry points. Per-module services (EntryService, StatusService,
/// BillingService, SmsService, EmailService, SecurityGateService, HolidayService)
/// are defined in their module specs.
/// </summary>
public interface ISharedRuleService
{
    /// <summary>Returns the current Api surface version (scaffolding, spec §15).</summary>
    string GetApiVersion();
}

/// <summary>
/// Default implementation of <see cref="ISharedRuleService"/>.
/// </summary>
public sealed class SharedRuleService : ISharedRuleService
{
    public string GetApiVersion() => "1";
}