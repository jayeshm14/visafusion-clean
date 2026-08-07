using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using VisaFusion.Core.Application;

namespace VisaFusion.Jobs.Workers;

/// <summary>
/// Scheduled report worker placeholder (SPEC-0003 T052, FR-008).
///
/// Generates scheduled reports using the shared Core service surface. The actual
/// report scheduling/generation logic is implemented in the module feature specs;
/// this is the BackgroundService host placeholder.
/// </summary>
public sealed class ReportWorker : BackgroundService
{
    private readonly ILogger<ReportWorker> _logger;

    public ReportWorker(ILogger<ReportWorker> logger)
    {
        _logger = logger;
    }

    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {
        _logger.LogInformation("ReportWorker started (placeholder).");
        while (!stoppingToken.IsCancellationRequested)
        {
            await Task.Delay(TimeSpan.FromHours(1), stoppingToken);
        }
    }
}