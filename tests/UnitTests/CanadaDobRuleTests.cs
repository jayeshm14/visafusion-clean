using VisaFusion.Core.Application;

namespace VisaFusion.UnitTests;

/// <summary>
/// Unit tests for the representative shared business rule (SPEC-0003 T038,
/// Canada DOB validation).
/// </summary>
public class CanadaDobRuleTests
{
    private readonly CanadaDobRule _rule = new();

    [Fact]
    public void Adult_On_Reference_Date_Is_Valid()
    {
        var dob = new DateOnly(1990, 1, 1);
        var onDate = new DateOnly(2026, 1, 1);

        Assert.True(_rule.IsAdultForCanadaVisa(dob, onDate));
    }

    [Fact]
    public void Exactly_18_Is_Valid()
    {
        var dob = new DateOnly(2008, 1, 1);
        var onDate = new DateOnly(2026, 1, 1);

        Assert.True(_rule.IsAdultForCanadaVisa(dob, onDate));
    }

    [Fact]
    public void Under_18_Is_Invalid()
    {
        var dob = new DateOnly(2010, 1, 1);
        var onDate = new DateOnly(2026, 1, 1);

        Assert.False(_rule.IsAdultForCanadaVisa(dob, onDate));
    }

    [Fact]
    public void Birthday_Not_Yet_Reached_Counts_As_Under_18()
    {
        // Turns 18 on 2026-12-31; on 2026-01-01 they are still 17.
        var dob = new DateOnly(2008, 12, 31);
        var onDate = new DateOnly(2026, 1, 1);

        Assert.False(_rule.IsAdultForCanadaVisa(dob, onDate));
    }
}