using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using VisaFusion.Core;
using VisaFusion.Core.Application;
using VisaFusion.Data.Application;
using VisaFusion.Data.Persistence;
using VisaFusion.Jobs.Workers;

namespace VisaFusion.FunctionalTests;

/// <summary>
/// Jobs host test (SPEC-0003 T048, User Story 5, FR-008; updated SPEC-0008 T016).
///
/// Asserts the Jobs workers register and start with the Jobs host (a separate
/// Worker process). The host is composed exactly like the production Jobs
/// composition root (VisaFusion.Jobs/Program.cs): shared Core surface +
/// Data-backed notification services (ISmsService/IEmailService + log-only
/// dispatch providers, owner Q1:C) + VisaEntryDbContext + the three workers.
/// The workers are resolved from the host's DI container and started/stopped to
/// prove they are valid BackgroundService registrations.
/// </summary>
public class JobsHostTests
{
    private const string TestConnectionString =
        "Server=localhost;Database=VisaFusion;Trusted_Connection=True;TrustServerCertificate=True;MultipleActiveResultSets=true";

    private static HostApplicationBuilder CreateJobsHostBuilder()
    {
        var builder = Host.CreateApplicationBuilder();
        builder.Services.AddVisaFusionCore();

        // Mirrors VisaFusion.Jobs/Program.cs (SPEC-0008 T016, research D-7).
        builder.Services.AddScoped<ISmsService, SmsService>();
        builder.Services.AddScoped<IEmailService, EmailService>();
        builder.Services.AddScoped<ISmsDispatchProvider, LogOnlySmsDispatchProvider>();
        builder.Services.AddScoped<IEmailDispatchProvider, LogOnlyEmailDispatchProvider>();
        builder.Services.AddDbContext<VisaEntryDbContext>(options =>
            options.UseSqlServer(TestConnectionString));

        builder.Services.AddHostedService<SmsQueueWorker>();
        builder.Services.AddHostedService<EmailQueueWorker>();
        builder.Services.AddHostedService<ReportWorker>();
        return builder;
    }

    [Fact]
    public Task Jobs_Host_Registers_All_Workers()
    {
        using var host = CreateJobsHostBuilder().Build();

        var hostedServices = host.Services
            .GetServices<IHostedService>()
            .ToList();

        Assert.Contains(hostedServices, s => s is SmsQueueWorker);
        Assert.Contains(hostedServices, s => s is EmailQueueWorker);
        Assert.Contains(hostedServices, s => s is ReportWorker);

        return Task.CompletedTask;
    }

    [Fact]
    public async Task Workers_Start_And_Stop_With_The_Host()
    {
        using var host = CreateJobsHostBuilder().Build();
        await host.StartAsync();
        await host.StopAsync();

        Assert.True(true); // reached without exception => workers started/stopped cleanly
    }
}
