using System.ComponentModel.DataAnnotations;

namespace VisaFusion.Core.Options;

/// <summary>
/// Configuration options for queue workers (SPEC-0008 T026/T031, §17/R7).
/// Rate limiting and polling intervals are configuration-driven per spec.
/// </summary>
public sealed class QueueWorkerOptions
{
    public const string SectionName = "QueueWorkers";

    /// <summary>Poll interval for the email queue worker (default: 30 seconds).</summary>
    [Range(1, 3600)]
    public int EmailPollIntervalSeconds { get; set; } = 30;

    /// <summary>Poll interval for the SMS queue worker (default: 30 seconds).</summary>
    [Range(1, 3600)]
    public int SmsPollIntervalSeconds { get; set; } = 30;

    /// <summary>Batch size for email queue drain (default: 100).</summary>
    [Range(1, 1000)]
    public int EmailBatchSize { get; set; } = 100;

    /// <summary>Batch size for SMS queue drain (default: 100).</summary>
    [Range(1, 1000)]
    public int SmsBatchSize { get; set; } = 100;
}