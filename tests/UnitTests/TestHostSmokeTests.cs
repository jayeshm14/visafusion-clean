namespace VisaFusion.UnitTests;

/// <summary>
/// Smoke test proving the xUnit test host runs (SPEC-0003 T018).
/// Build validation of the full solution is covered by T019 (FunctionalTests).
/// </summary>
public class TestHostSmokeTests
{
    [Fact]
    public void TestHost_Is_Running()
    {
        Assert.True(true);
    }
}