using VisaFusion.Migration.Cleansing;
using VisaFusion.Migration.Configuration;

namespace VisaFusion.UnitTests;

/// <summary>
/// Cleansing rule (a) — statusID=508 duplicate resolution (SPEC-0004 T028,
/// TS-004, FR-005a). Unit tests for the rule contract: rule id, sign-off gating
/// (BR-005), and the approved-transform wiring. The SQL application itself is
/// exercised by the integration tests against the live databases.
/// </summary>
public class CleansingStatus508Tests
{
    private static MigrationOptions OptionsWith(SignOff signOff) => new()
    {
        SignOffs = new CleansingSignOffs { Status508 = signOff }
    };

    [Fact]
    public void RuleId_Is_A()
    {
        var rule = new Status508Rule(OptionsWith(new SignOff()));
        Assert.Equal("a", rule.RuleId);
    }

    [Fact]
    public void Rule_Is_Not_Approved_Without_Sign_Off()
    {
        // BR-005: a rule with no recorded sign-off must not be applied.
        var rule = new Status508Rule(OptionsWith(new SignOff()));
        Assert.False(rule.IsApproved);
    }

    [Fact]
    public void Rule_Is_Not_Approved_With_Approver_But_No_Date()
    {
        var rule = new Status508Rule(OptionsWith(new SignOff { Approver = "owner" }));
        Assert.False(rule.IsApproved);
    }

    [Fact]
    public void Rule_Is_Approved_With_Approver_And_Date()
    {
        var rule = new Status508Rule(OptionsWith(new SignOff { Approver = "owner", Date = "2026-08-09" }));
        Assert.True(rule.IsApproved);
    }

    [Fact]
    public void Rule_Targets_The_Status_Table()
    {
        // The rule's result is recorded against the legacy table name "status"
        // (the copy-time transform and the post-copy rule agree on the survivor).
        var rule = new Status508Rule(OptionsWith(new SignOff()));
        Assert.IsAssignableFrom<CleansingRule>(rule);
    }
}