using Microsoft.Data.SqlClient;
using VisaFusion.Migration.Configuration;

namespace VisaFusion.Migration.Cleansing;

/// <summary>
/// Cleansing rule (e) — GAP-0002 resolution (Option A): keep the populated
/// `agents.agentsID = 4114` profile and drop the all-NULL ghost row (FR-005e).
/// The legacy `agents` table holds two rows with agentsID=4114: the populated
/// profile (CUSTOMER-UDAAN / CUSTOMER A/C / pankaj@udaanindia.com) and a ghost
/// row where every column except agentsID + Description is NULL. `agentsID` is an
/// identity column in legacy and the table is a heap, so the ghost row required
/// explicit IDENTITY_INSERT and is not reproducible by application flow.
///
/// The copy-time transform (CopyCommand, FR-005e) already collapses to one row
/// per agentsID; this rule is the post-copy safety net — if a ghost duplicate
/// ever appears on the target (e.g. a re-run without the transform), it is
/// removed and only the populated row remains. Sign-off gated (BR-005).
/// </summary>
public sealed class Agents4114Rule : CleansingRule
{
    public Agents4114Rule(MigrationOptions options) : base(options) { }

    public override string RuleId => "e";

    protected override SignOff SignOff => Options.SignOffs.Agents4114;

    public override async Task<CleansingResult> ApplyAsync(CleansingContext context, CancellationToken ct = default)
    {
        // The ghost row carries no populated profile columns; deleting it keeps
        // exactly the surviving populated row (the same survivor the copy-time
        // DeduplicateOn transform ranks first). Only the duplicate key is matched,
        // never the populated profile.
        var sql = @"
            DELETE [agents]
             WHERE [agentsID] = 4114
               AND [companyname] IS NULL
               AND [emailid] IS NULL
               AND [active] IS NULL
               AND [phoneno] IS NULL
               AND [smsno] IS NULL;";
        await using var cmd = context.Target.CreateCommand();
        cmd.CommandText = sql;
        var rows = await cmd.ExecuteNonQueryAsync(ct);
        return new CleansingResult(
            RuleId,
            "agents",
            "drop all-NULL ghost duplicate of agentsID=4114, keep populated profile (GAP-0002, FR-005e)",
            rows);
    }
}
