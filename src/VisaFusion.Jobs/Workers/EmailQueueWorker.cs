using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using VisaFusion.Core.Application;

namespace VisaFusion.Jobs.Workers;

/// <summary>
/// Email queue worker placeholder (SPEC-0003 T052, FR-008).
///
/// Processes the email queue using the shared Core EmailService. The actual queue
/// processing logic is implemented in the module feature specs; this is the
/// BackgroundService host placeholder.
/// </summary>
public sealed class EmailQueueWorker : BackgroundService
{
    private readonly IEmailService _emailService;
    private readonly ILogger<EmailQueueWorker> _logger;

    public EmailQueueWorker(IEmailService emailService, ILogger<EmailQueueWorker> logger)
    {
        _emailService = emailService;
        _logger = logger;
    }

    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {
        _logger.LogInformation("EmailQueueWorker started (placeholder).");
        while (!stoppingToken.IsCancellationRequested)
        {
            await Task.Delay(TimeSpan.FromSeconds(30), stoppingToken);
        }
    }
}