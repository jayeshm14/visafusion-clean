using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using VisaFusion.Core.Application;
using VisaFusion.Core.Options;

namespace VisaFusion.Jobs.Workers;

/// <summary>
/// SMS queue worker (SPEC-0008 T026, FR-001/FR-003/FR-006; contracts/
/// notifications-api.md §5).
///
/// Polls the SMS queue on an interval and drains a bounded batch through the
/// shared <see cref="ISmsService"/> — the drain writes the full 8-field
/// `smshistory` audit row and deletes the queue row transactionally (send-once
/// gate, research D-3). Failed rows are logged with status 'failed' and
/// retained for the next pass (§18 — no message loss, no silent drop); the
/// in-pass retry/backoff is a property of the dispatch provider (the v1
/// log-only provider never fails; a vendor provider implements its own retry
/// before returning failure, NFR-005).
///
/// Fault isolation (§18): a drain fault is caught and logged here — it never
/// fails request handling, and the next poll retries. Structured logs carry
/// the drain outcome (NFR-003).
/// </summary>
public sealed class SmsQueueWorker : BackgroundService
{
    private readonly ISmsService _smsService;
    private readonly ILogger<SmsQueueWorker> _logger;
    private readonly TimeSpan _pollInterval;

    public SmsQueueWorker(
        ISmsService smsService,
        ILogger<SmsQueueWorker> logger,
        IOptions<QueueWorkerOptions> options)
    {
        _smsService = smsService;
        _logger = logger;
        _pollInterval = TimeSpan.FromSeconds(options.Value.SmsPollIntervalSeconds);
    }

    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {
        _logger.LogInformation("SmsQueueWorker started (poll interval {PollIntervalSeconds}s).",
            _pollInterval.TotalSeconds);

        while (!stoppingToken.IsCancellationRequested)
        {
            try
            {
                var result = await _smsService.DrainNextBatchAsync(stoppingToken);
                if (result.Processed > 0 || result.Failed > 0)
                {
                    _logger.LogInformation(
                        "SMS queue drain: processed={Processed} failed={Failed} remaining={Remaining}",
                        result.Processed, result.Failed, result.Remaining);
                }
            }
            catch (OperationCanceledException) when (stoppingToken.IsCancellationRequested)
            {
                break;
            }
            catch (Exception ex)
            {
                // §18: worker faults are isolated to the worker; the next poll
                // retries the drain. Never silently swallowed (FR-006).
                _logger.LogError(ex, "SMS queue drain pass failed; will retry on the next poll.");
            }

            await Task.Delay(_pollInterval, stoppingToken);
        }

        _logger.LogInformation("SmsQueueWorker stopped.");
    }
}