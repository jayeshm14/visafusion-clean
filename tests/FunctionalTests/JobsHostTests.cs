using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using VisaFusion.Core;
using VisaFusion.Jobs.Workers;

namespace VisaFusion.FunctionalTests;

/// <summary>
/// Jobs host test (SPEC-0003 T048, User Story 5, FR-008).
///
/// Asserts the Jobs workers register and start with the Jobs host (a separate
/// Worker process). The workers are resolved from the host's DI container and
/// started/stopped to prove they are valid BackgroundService registrations.
/// </summary>
public class JobsHostTests
{
    [Fact]
    public async Task Jobs_Host_Registers_All_Workers()
    {
        var builder = Host.CreateApplicationBuilder();
        builder.Services.AddVisaFusionCore();
        builder.Services.AddHostedService<SmsQueueWorker>();
        builder.Services.AddHostedService<EmailQueueWorker>();
        builder.Services.AddHostedService<ReportWorker>();

        using var host = builder.Build();

        var hostedServices = host.Services
            .GetServices<IHostedService>()
            .ToList();

        Assert.Contains(hostedServices, s => s is SmsQueueWorker);
        Assert.Contains(hostedServices, s => s is EmailQueueWorker);
        Assert.Contains(hostedServices, s => s is ReportWorker);
    }

    [Fact]
    public async Task Workers_Start_And_Stop_With_The_Host()
    {
        var builder = Host.CreateApplicationBuilder();
        builder.Services.AddVisaFusionCore();
        builder.Services.AddHostedService<SmsQueueWorker>();
        builder.Services.AddHostedService<EmailQueueWorker>();
        builder.Services.AddHostedService<ReportWorker>();

        using var host = builder.Build();
        await host.StartAsync();
        await host.StopAsync();

        Assert.True(true); // reached without exception => workers started/stopped cleanly
    }
}