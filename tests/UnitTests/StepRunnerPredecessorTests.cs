using VisaFusion.Migration.Commands;

namespace VisaFusion.UnitTests;

/// <summary>
/// Regression tests for the fixed-order guard (SPEC-0004 T009, TS-008;
/// contracts/migration-cli.md §2 "A step may not run before its predecessor
/// completes successfully").
///
/// Regression context: the predecessor check previously threw from outside the
/// runner's try block, so an out-of-order step exited 2 (StepFailure) with no
/// log output at all — the disposed static Serilog logger swallowed the
/// exception. The check is now a pure, unit-testable method
/// (<see cref="StepRunner.EnsureRequestedStepIsRunnable"/>) that raises
/// <see cref="PreflightException"/> (exit 1) with a precise message before any
/// step executes.
/// </summary>
public class StepRunnerPredecessorTests
{
    private static readonly string[] RegisteredSteps =
        ["preflight", "snapshot", "schema", "copy", "cleanse", "identity", "validate", "report"];

    private static RunState Completed(params string[] steps) =>
        new() { CompletedSteps = steps.ToList() };

    [Fact]
    public void Null_Requested_Step_Is_Always_Runnable()
    {
        // Full run: the fixed order itself is the guard.
        StepRunner.EnsureRequestedStepIsRunnable(null, Completed(), RegisteredSteps);
    }

    [Fact]
    public void Unknown_Step_Throws_Preflight_With_Contract_Reference()
    {
        var ex = Assert.Throws<PreflightException>(() =>
            StepRunner.EnsureRequestedStepIsRunnable("nosuchstep", Completed(), RegisteredSteps));

        Assert.Contains("Unknown step 'nosuchstep'", ex.Message);
        Assert.Contains("contracts/migration-cli.md", ex.Message);
    }

    [Theory]
    [InlineData("cleanse")]
    [InlineData("identity")]
    [InlineData("validate")]
    [InlineData("report")]
    public void Step_Requiring_Uncompleted_Predecessor_Throws_Preflight(string step)
    {
        // Only preflight+snapshot+schema completed → copy missing.
        var runState = Completed("preflight", "snapshot", "schema");

        var ex = Assert.Throws<PreflightException>(() =>
            StepRunner.EnsureRequestedStepIsRunnable(step, runState, RegisteredSteps));

        Assert.Contains($"Step '{step}' requires", ex.Message);
        Assert.Contains("to complete first (fixed order)", ex.Message);
        // The FIRST missing predecessor is named — copy is the immediate gap.
        Assert.Contains("'copy'", ex.Message);
    }

    [Fact]
    public void Step_With_All_Predecessors_Completed_Is_Runnable()
    {
        var runState = Completed("preflight", "snapshot", "schema", "copy", "cleanse", "identity");

        // validate requires all of preflight…identity — all present, no throw.
        StepRunner.EnsureRequestedStepIsRunnable("validate", runState, RegisteredSteps);
    }

    [Fact]
    public void First_Missing_Predecessor_Is_Reported_Not_The_Last()
    {
        // identity requires preflight…cleanse; only preflight+snapshot done.
        var runState = Completed("preflight", "snapshot");

        var ex = Assert.Throws<PreflightException>(() =>
            StepRunner.EnsureRequestedStepIsRunnable("identity", runState, RegisteredSteps));

        // 'schema' is the earliest gap in fixed order, not 'cleanse'.
        Assert.Contains("'schema'", ex.Message);
        Assert.DoesNotContain("'cleanse'", ex.Message);
    }
}
