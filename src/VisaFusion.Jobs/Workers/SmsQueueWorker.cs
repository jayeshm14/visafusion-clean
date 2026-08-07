using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using VisaFusion.Core.Application;

namespace VisaFusion.Jobs.Workers;

/// <summary>
/// SMS queue worker placeholder (SPEC-0003 T052, FR-008).
///
/// Processes the SMS queue using the shared Core SmsService. The concrete queue
/// polling/processing logic is defined in the module feature specs; this is the
/// BackgroundService host placeholder.
/// </summary>
public sealed class SmsQueueWorker : BackgroundService
{
    private readonly ISmsService _smsService;
    private readonly ILogger<SmsQueueWorker> _logger;

    public SmsQueueWorker(ISmsService smsService, ILogger<SmsQueueWorker> logger)
    {
        _smsService = smsService;
        _logger = logger;
    }

    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {
        _logger.LogInformation("SmsQueueWorker started (placeholder).");
        while (!stoppingToken.IsCancellationRequested)
        {
            await Task.Delay(TimeSpan.FromSeconds(30), stoppingToken);
        }
    }
}