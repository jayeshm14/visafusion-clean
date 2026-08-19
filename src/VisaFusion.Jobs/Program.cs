using Microsoft.EntityFrameworkCore;
using Serilog;
using VisaFusion.Core;
using VisaFusion.Core.Application;
using VisaFusion.Core.Options;
using VisaFusion.Data.Application;
using VisaFusion.Data.Persistence;
using VisaFusion.Jobs.Workers;

var builder = Host.CreateApplicationBuilder(args);

// Shared Core service surface (T054, FR-003): the Jobs workers resolve the same
// ISmsService/IEmailService surface as the Web host.
builder.Services.AddVisaFusionCore();

// Queue worker options (SPEC-0008 T026/T031, §17/R7): configuration-driven
// poll intervals and batch sizes.
builder.Services.Configure<QueueWorkerOptions>(
    builder.Configuration.GetSection(QueueWorkerOptions.SectionName));
builder.Services.AddOptions<QueueWorkerOptions>()
    .ValidateDataAnnotations()
    .ValidateOnStart();

// SPEC-0008 (T016): Data-backed notification services + VisaEntryDbContext at the
// Jobs composition root (HolidayService precedent, research D-7). Dispatch
// providers default to log-only mode (owner Q1:C, research D-2).
builder.Services.AddScoped<ISmsService, SmsService>();
builder.Services.AddScoped<IEmailService, EmailService>();
builder.Services.AddScoped<ISmsDispatchProvider, LogOnlySmsDispatchProvider>();
builder.Services.AddScoped<IEmailDispatchProvider, LogOnlyEmailDispatchProvider>();
builder.Services.AddDbContext<VisaEntryDbContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));

// Serilog (NFR-006): console + rolling file; SQL sink in non-Testing environments.
var loggerConfiguration = new LoggerConfiguration()
    .ReadFrom.Configuration(builder.Configuration)
    .WriteTo.Console()
    .WriteTo.File(
        path: "logs/visafusion-jobs-.log",
        rollingInterval: RollingInterval.Day,
        retainedFileCountLimit: 30);
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
builder.Services.AddSerilog();

// Background workers (T053, FR-008): Jobs is a separate Worker process.
builder.Services.AddHostedService<SmsQueueWorker>();
builder.Services.AddHostedService<EmailQueueWorker>();
builder.Services.AddHostedService<ReportWorker>();

var host = builder.Build();
host.Run();
