using Microsoft.Extensions.Logging;
using VisaFusion.Migration.Configuration;
using VisaFusion.Migration.Validation;

namespace VisaFusion.Migration.Commands;

/// <summary>
/// `validate` — runs the validation engine and maps outcomes to exit codes
/// (SPEC-0004 T044, FR-009; spec §18): fail-fast integrity violations abort
/// (exit 4); other discrepancies are reported, not corrected (exit 3).
/// </summary>
public sealed class ValidateCommand : MigrationStep
{
    private readonly ILogger<ValidateCommand> _logger;

    public ValidateCommand(MigrationOptions options, ILogger<ValidateCommand> logger) : base(options)
        => _logger = logger;

    public override string Name => "validate";

    public override async Task ExecuteAsync(StepContext context, CancellationToken ct = default)
    {
        // Tables that had approved cleansing applied are excluded from checksum
        // comparison (their values intentionally differ, FR-005).
        var cleansingTables = context.Report.Cleansing
            .Select(c => c.Table)
            .Distinct(StringComparer.OrdinalIgnoreCase)
            .ToArray();
        var cleansingRules = context.Report.Cleansing.Select(c => c.Rule).Distinct().ToArray();

        var engine = new ValidationEngine(Options.LegacyConnectionString, Options.TargetConnectionString, _logger);
        var outcome = await engine.ValidateAsync(context.Baseline, cleansingTables, cleansingRules, ct);

        context.Report.Validation = outcome.Report;
        context.Report.Discrepancies.AddRange(outcome.Discrepancies);

        if (outcome.HasIntegrityViolation)
        {
            _logger.LogError("validate: referential-integrity violations found — fail-fast abort (exit 4).");
            throw new IntegrityException(
                "Referential-integrity violations detected on the target. See migration report for details.");
        }

        if (outcome.Discrepancies.Count > 0)
        {
            _logger.LogError("validate: {Count} discrepancies found (reported, not corrected).",
                outcome.Discrepancies.Count);
            throw new ValidationDiscrepancyException(
                $"{outcome.Discrepancies.Count} discrepancies found (row-count/checksum). " +
                "See migration report for details.");
        }

        _logger.LogInformation("validate: PASSED — {Tables} tables compared, no discrepancies.",
            outcome.Report.TablesCompared);
    }
}

/// <summary>Thrown when validation finds discrepancies (mapped to exit 3).</summary>
public sealed class ValidationDiscrepancyException : Exception
{
    public ValidationDiscrepancyException(string message) : base(message) { }
}
