using VisaFusion.Core;
using VisaFusion.Jobs.Workers;

var builder = Host.CreateApplicationBuilder(args);

// Shared Core service surface (T054, FR-003): the Jobs workers resolve the same
// SmsService/EmailService placeholders as the Web host.
builder.Services.AddVisaFusionCore();

// Background workers (T053, FR-008): Jobs is a separate Worker process.
builder.Services.AddHostedService<SmsQueueWorker>();
builder.Services.AddHostedService<EmailQueueWorker>();
builder.Services.AddHostedService<ReportWorker>();

var host = builder.Build();
host.Run();