using VisaFusion.Migration.Cleansing;
using VisaFusion.Migration.Configuration;

namespace VisaFusion.UnitTests;

/// <summary>
/// Cleansing rule (c) — orphaned Mainentry.agent NULL + flag (SPEC-0004 T029,
/// TS-005, FR-005c). Unit tests for the rule contract: rule id and sign-off
/// gating (BR-005). The SQL application is exercised by the integration tests.
/// </summary>
public class CleansingOrphanTests
{
    private static MigrationOptions OptionsWith(SignOff signOff) => new()
    {
        SignOffs = new CleansingSignOffs { OrphanAgent = signOff }
    };

    [Fact]
    public void RuleId_Is_C()
    {
        var rule = new OrphanAgentRule(OptionsWith(new SignOff()));
        Assert.Equal("c", rule.RuleId);
    }

    [Fact]
    public void Rule_Is_Not_Approved_Without_Sign_Off()
    {
        // BR-005: no recorded sign-off → the rule must not be applied.
        var rule = new OrphanAgentRule(OptionsWith(new SignOff()));
        Assert.False(rule.IsApproved);
    }

    [Fact]
    public void Rule_Is_Approved_With_Approver_And_Date()
    {
        var rule = new OrphanAgentRule(OptionsWith(new SignOff { Approver = "owner", Date = "2026-08-09" }));
        Assert.True(rule.IsApproved);
    }

    [Fact]
    public void Rule_Is_Not_Approved_With_Date_But_No_Approver()
    {
        var rule = new OrphanAgentRule(OptionsWith(new SignOff { Date = "2026-08-09" }));
        Assert.False(rule.IsApproved);
    }
}