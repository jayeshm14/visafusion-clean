using Microsoft.Data.SqlClient;
using VisaFusion.Migration.Configuration;

namespace VisaFusion.Migration.Cleansing;

/// <summary>
/// Cleansing rule (c) — migrate the 6,517 orphaned `Mainentry.agent` rows with
/// NULL agent and flag them (FR-005c). An orphan is an `agent` value that has no
/// row in `agents.agentsID`. NULL-ing is the approved action; the affected
/// refnos are recorded in the migration report so the flag is auditable.
/// Sign-off gated (BR-005).
/// </summary>
public sealed class OrphanAgentRule : CleansingRule
{
    public OrphanAgentRule(MigrationOptions options) : base(options) { }

    public override string RuleId => "c";

    protected override SignOff SignOff => Options.SignOffs.OrphanAgent;

    public override async Task<CleansingResult> ApplyAsync(CleansingContext context, CancellationToken ct = default)
    {
        var sql = @"
            UPDATE [Mainentry]
               SET [agent] = NULL
             WHERE [agent] IS NOT NULL
               AND [agent] NOT IN (SELECT [agentsID] FROM [agents]);";
        await using var cmd = context.Target.CreateCommand();
        cmd.CommandText = sql;
        var rows = await cmd.ExecuteNonQueryAsync(ct);
        return new CleansingResult(
            RuleId,
            "Mainentry",
            "orphaned agent values set to NULL and flagged in migration report (FR-005c)",
            rows);
    }
}
