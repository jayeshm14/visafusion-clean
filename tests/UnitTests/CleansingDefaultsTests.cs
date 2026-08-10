using Microsoft.Data.SqlClient;
using VisaFusion.Migration.Cleansing;
using VisaFusion.Migration.Configuration;
using VisaFusion.Migration.Snapshot;

namespace VisaFusion.UnitTests;

/// <summary>
/// Cleansing rules (b) and (d) — entrytype default and junk-date clamp
/// (SPEC-0004 T030, FR-005b/FR-005d). Unit tests for the rule contracts:
/// rule ids, sign-off gating (BR-005), the documented no-op behavior of rule
/// (b) (GAP-0001 §4.2 — no default value was recorded in the approval, so the
/// rule must not invent one), and the CleansingSignOffs.AllApproved gate used
/// by preflight.
/// </summary>
public class CleansingDefaultsTests
{
    [Fact]
    public void EntryTypeDefault_RuleId_Is_B()
    {
        var rule = new EntryTypeDefaultRule(new MigrationOptions());
        Assert.Equal("b", rule.RuleId);
    }

    [Fact]
    public async Task EntryTypeDefault_Is_A_Recorded_No_Op_When_No_Default_Value_Recorded()
    {
        // FR-005b is approved as "default the 100%-NULL column", but the default
        // VALUE was not recorded in the approval (GAP-0001 §4.2). Per the
        // deterministic rule, no value is invented: the rule is a documented
        // no-op that preserves NULL verbatim (FR-002). The rule never touches
        // the database, so it is fully unit-testable.
        var rule = new EntryTypeDefaultRule(new MigrationOptions());
        var context = new CleansingContext
        {
            Target = new SqlConnection(), // never opened — the rule is a no-op
            Baseline = new SnapshotBaseline()
        };

        var result = await rule.ApplyAsync(context);

        Assert.Equal("b", result.Rule);
        Assert.Equal("Mainentry", result.Table);
        Assert.Equal(0, result.RowsAffected);
        Assert.Contains("no value recorded", result.Action);
    }

    [Fact]
    public void JunkDate_RuleId_Is_D()
    {
        var rule = new JunkDateRule(new MigrationOptions());
        Assert.Equal("d", rule.RuleId);
    }

    [Fact]
    public void JunkDate_Rule_Requires_Sign_Off()
    {
        var rule = new JunkDateRule(new MigrationOptions());
        Assert.False(rule.IsApproved);
    }

    [Fact]
    public void JunkDate_Rule_Is_Approved_With_Sign_Off()
    {
        var options = new MigrationOptions
        {
            SignOffs = new CleansingSignOffs { JunkDateClamp = new SignOff { Approver = "owner", Date = "2026-08-09" } }
        };
        var rule = new JunkDateRule(options);
        Assert.True(rule.IsApproved);
    }

    [Fact]
    public void AllApproved_Requires_Every_Rule_Signed_Off()
    {
        var all = new CleansingSignOffs
        {
            Status508 = new SignOff { Approver = "o", Date = "2026-08-09" },
            EntryTypeDefault = new SignOff { Approver = "o", Date = "2026-08-09" },
            OrphanAgent = new SignOff { Approver = "o", Date = "2026-08-09" },
            JunkDateClamp = new SignOff { Approver = "o", Date = "2026-08-09" },
            Agents4114 = new SignOff { Approver = "o", Date = "2026-08-09" }
        };
        Assert.True(all.AllApproved);

        // One missing sign-off (FR-005e, GAP-0002) fails the preflight gate.
        all.Agents4114 = new SignOff();
        Assert.False(all.AllApproved);
    }
}