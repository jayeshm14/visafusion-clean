using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Logging;
using VisaFusion.Migration.Configuration;

namespace VisaFusion.Migration.Commands;

/// <summary>
/// Step-runner enforcing the fixed command order and checkpoint rollback
/// (SPEC-0004 T009, contracts/migration-cli.md §2, spec §18). Steps execute in
/// the contract order; a completed step is a no-op on re-run (NFR-001). A step
/// failure rolls back to the last validated checkpoint (exit 2). Fail-fast
/// integrity violations abort with exit 4.
/// </summary>
public sealed class StepRunner
{
    private readonly MigrationOptions _options;
    private readonly ILogger<StepRunner> _logger;
    private readonly IReadOnlyDictionary<string, MigrationStep> _steps;
    private readonly string _targetConnectionString;

    public StepRunner(MigrationOptions options, ILogger<StepRunner> logger, IEnumerable<MigrationStep> steps)
    {
        _options = options;
        _logger = logger;
        _steps = steps.ToDictionary(s => s.Name, StringComparer.Ordinal);
        _targetConnectionString = options.TargetConnectionString;

        // Enforce the contract: every step in the fixed order must be registered.
        foreach (var name in RunState.OrderedSteps)
        {
            if (!_steps.ContainsKey(name))
                throw new InvalidOperationException($"Step '{name}' is required by contracts/migration-cli.md but not registered.");
        }
    }

    /// <summary>
    /// Runs the requested step (or all remaining steps in order).
    /// Returns the process exit code (contracts/migration-cli.md §4).
    /// </summary>
    public async Task<int> RunAsync(string? requestedStep, CancellationToken ct = default)
    {
        await using var target = new SqlConnection(_options.TargetConnectionString);
        await target.OpenAsync(ct);

        var runState = await RunState.LoadLatestAsync(target, ct) ?? new RunState();
        var report = new Reporting.MigrationReport
        {
            RunId = runState.RunId,
            Operator = _options.Operator,
            StartedAt = runState.StartedAtUtc
        };
        var context = new StepContext { RunState = runState, Baseline = new Snapshot.SnapshotBaseline(), Report = report };

        // Resolve the steps to execute: only the requested one, or the whole
        // fixed order minus already-completed steps.
        var toRun = requestedStep is null
            ? RunState.OrderedSteps.Where(s => !runState.IsCompleted(s)).ToArray()
            : new[] { requestedStep };

        if (requestedStep is null && toRun.Length == 0)
        {
            _logger.LogInformation("All steps already completed for run {RunId}; no-op (NFR-001).", runState.RunId);
            return ExitCodes.Success;
        }

        try
        {
            EnsureRequestedStepIsRunnable(requestedStep, runState, _steps.Keys);

            foreach (var stepName in toRun)
            {
                var step = _steps[stepName];
                _logger.LogInformation("=== STEP {Step} (run {RunId}) ===", stepName, runState.RunId);
                runState.CurrentStep = stepName;
                await runState.SaveAsync(target, ct);

                try
                {
                    await step.ExecuteAsync(context, ct);
                }
                catch (PreflightException)
                {
                    throw; // exit 1 — handled below
                }
                catch (IntegrityException)
                {
                    throw; // exit 4 — handled below
                }
                catch (ValidationDiscrepancyException)
                {
                    throw; // exit 3 — handled below
                }
                catch (Exception ex)
                {
                    _logger.LogError(ex, "Step {Step} failed; rolling back to last validated checkpoint.", stepName);
                    context.Baseline = new Snapshot.SnapshotBaseline(); // invalidate in-memory checkpoint
                    runState.CurrentStep = string.Empty;
                    await runState.SaveAsync(target, ct);
                    return ExitCodes.StepFailure;
                }

                runState.MarkCompleted(stepName);
                await runState.SaveAsync(target, ct);
                _logger.LogInformation("Step {Step} completed.", stepName);
            }

            // Only a fully-completed run writes the final report timestamp.
            if (requestedStep is null)
            {
                runState.CompletedAtUtc = DateTime.UtcNow;
                await runState.SaveAsync(target, ct);
            }
            return ExitCodes.Success;
        }
        catch (PreflightException ex)
        {
            _logger.LogError("Preflight failure: {Message}", ex.Message);
            return ExitCodes.PreflightFailure;
        }
        catch (ValidationDiscrepancyException ex)
        {
            _logger.LogError("Validation failure: {Message}", ex.Message);
            return ExitCodes.ValidationFailure;
        }
        catch (IntegrityException ex)
        {
            _logger.LogError("Integrity violation (fail-fast): {Message}", ex.Message);
            return ExitCodes.IntegrityViolation;
        }
        catch (ConfigurationException ex)
        {
            _logger.LogError("Configuration error: {Message}", ex.Message);
            return ExitCodes.ConfigurationError;
        }
    }

    /// <summary>
    /// Validates a single-step request against the fixed order
    /// (contracts/migration-cli.md §2) BEFORE any step runs. Throws
    /// <see cref="PreflightException"/> (exit 1) when the step is unknown or a
    /// predecessor has not completed — the deterministic "step may not run
    /// before its predecessor completes successfully" contract. Pure logic so
    /// it is unit-testable without a database (SPEC-0004 T009, TS-008).
    /// </summary>
    public static void EnsureRequestedStepIsRunnable(
        string? requestedStep, RunState runState, IEnumerable<string> registeredSteps)
    {
        if (requestedStep is null) return; // full run: the fixed order handles it

        if (!registeredSteps.Contains(requestedStep, StringComparer.Ordinal))
        {
            throw new PreflightException($"Unknown step '{requestedStep}' (contracts/migration-cli.md §2).");
        }

        var idx = Array.IndexOf(RunState.OrderedSteps, requestedStep);
        for (var i = 0; i < idx; i++)
        {
            if (!runState.IsCompleted(RunState.OrderedSteps[i]))
            {
                throw new PreflightException(
                    $"Step '{requestedStep}' requires '{RunState.OrderedSteps[i]}' to complete first (fixed order).");
            }
        }
    }
}

/// <summary>Thrown when configuration is invalid (exit 5).</summary>
public sealed class ConfigurationException : Exception
{
    public ConfigurationException(string message) : base(message) { }
}
