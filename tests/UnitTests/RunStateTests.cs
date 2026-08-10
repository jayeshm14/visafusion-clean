using VisaFusion.Migration.Commands;

namespace VisaFusion.UnitTests;

/// <summary>
/// Run-state / idempotency unit tests (SPEC-0004 T014, TS-008, NFR-001).
///
/// The run-state record guards re-runs as no-ops: a completed step is recorded
/// and re-running it is a no-op. The pure logic (<see cref="RunState.IsCompleted"/>,
/// <see cref="RunState.MarkCompleted"/>, <see cref="RunState.OrderedSteps"/>) is
/// unit-tested here without a database; the persistence round-trip is exercised
/// by the integration tests against the target database.
/// </summary>
public class RunStateTests
{
    [Fact]
    public void OrderedSteps_Is_The_Fixed_Contract_Order()
    {
        // contracts/migration-cli.md §2 — the fixed command order.
        Assert.Equal(
            ["preflight", "snapshot", "schema", "copy", "cleanse", "identity", "validate", "report"],
            RunState.OrderedSteps);
    }

    [Fact]
    public void New_RunState_Has_No_Completed_Steps()
    {
        var state = new RunState();
        Assert.Empty(state.CompletedSteps);
        Assert.Equal(string.Empty, state.CurrentStep);
        Assert.False(state.IsCompleted("copy"));
    }

    [Fact]
    public void MarkCompleted_Adds_Step_And_Clears_CurrentStep()
    {
        var state = new RunState { CurrentStep = "copy" };
        state.MarkCompleted("copy");

        Assert.True(state.IsCompleted("copy"));
        Assert.Equal(string.Empty, state.CurrentStep);
    }

    [Fact]
    public void MarkCompleted_On_Already_Completed_Step_Is_A_No_Op()
    {
        // NFR-001: re-running a completed step is a no-op — the completed list
        // must not grow duplicates.
        var state = new RunState();
        state.MarkCompleted("schema");
        state.MarkCompleted("schema");

        Assert.Single(state.CompletedSteps);
        Assert.Equal(["schema"], state.CompletedSteps);
    }

    [Fact]
    public void CompletedSteps_Preserve_Completion_Order()
    {
        var state = new RunState();
        state.MarkCompleted("preflight");
        state.MarkCompleted("snapshot");
        state.MarkCompleted("schema");

        Assert.Equal(["preflight", "snapshot", "schema"], state.CompletedSteps);
    }

    [Fact]
    public void IsCompleted_Is_Ordinal_Case_Sensitive()
    {
        // Step names are contract literals; matching is ordinal (no case folding).
        var state = new RunState();
        state.MarkCompleted("copy");
        Assert.False(state.IsCompleted("COPY"));
    }
}