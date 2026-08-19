using Microsoft.Extensions.Logging;
using VisaFusion.Core.Application;

namespace VisaFusion.Data.Application;

/// <summary>Outcome of one dispatch-provider attempt (research D-2).</summary>
public sealed record DispatchResult(bool Success, string? Detail = null);

/// <summary>
/// Vendor-facing SMS dispatch seam (SPEC-0008 FR-006, research D-2). The v1 default
/// is <see cref="LogOnlySmsDispatchProvider"/> (owner Q1:C); a real gateway provider
/// is registered only when configuration supplies vendor settings (enqueue-and-log
/// mode, research D-2).
/// </summary>
public interface ISmsDispatchProvider
{
    Task<DispatchResult> SendAsync(SmsMessage message, CancellationToken ct = default);
}

/// <summary>Vendor-facing email dispatch seam (research D-2).</summary>
public interface IEmailDispatchProvider
{
    Task<DispatchResult> SendAsync(EmailMessage message, CancellationToken ct = default);
}

/// <summary>
/// Enqueue-and-log SMS provider (owner Q1:C): records the dispatch attempt and
/// succeeds without contacting any vendor. Audit continuity works from day one; the
/// provider seam keeps the queue/audit machinery unchanged when a vendor is later
/// configured.
/// </summary>
public sealed class LogOnlySmsDispatchProvider : ISmsDispatchProvider
{
    private readonly ILogger<LogOnlySmsDispatchProvider> _logger;

    public LogOnlySmsDispatchProvider(ILogger<LogOnlySmsDispatchProvider> logger) => _logger = logger;

    public Task<DispatchResult> SendAsync(SmsMessage message, CancellationToken ct = default)
    {
        _logger.LogInformation(
            "SMS dispatch (log-only mode, owner Q1:C): cellno={Cellno} refno={Refno} agentId={AgentId} paxname={Paxname}",
            message.Cellno, message.Refno, message.AgentId, message.Paxname);
        return Task.FromResult(new DispatchResult(true, "logonly"));
    }
}

/// <summary>Enqueue-and-log email provider (owner Q1:C).</summary>
public sealed class LogOnlyEmailDispatchProvider : IEmailDispatchProvider
{
    private readonly ILogger<LogOnlyEmailDispatchProvider> _logger;

    public LogOnlyEmailDispatchProvider(ILogger<LogOnlyEmailDispatchProvider> logger) => _logger = logger;

    public Task<DispatchResult> SendAsync(EmailMessage message, CancellationToken ct = default)
    {
        _logger.LogInformation(
            "Email dispatch (log-only mode, owner Q1:C): to={Toemail} subject={Subject} agentsid={Agentsid} refno={Refno}",
            message.Toemail, message.Subject, message.Agentsid, message.Refno);
        return Task.FromResult(new DispatchResult(true, "logonly"));
    }
}
