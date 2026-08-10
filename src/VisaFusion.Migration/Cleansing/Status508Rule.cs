using Microsoft.Data.SqlClient;
using VisaFusion.Migration.Configuration;

namespace VisaFusion.Migration.Cleansing;

/// <summary>
/// Cleansing rule (a) — resolve the `statusID=508` duplicate description
/// (FR-005a). The legacy `status` table holds two rows with statusID=508 with
/// different descriptions ("Withdraw" and "Approval Awaited"); the target keeps
/// a single canonical row. The duplicate is merged: the surviving row keeps the
/// first description, and any referencing rows are unaffected (they reference
/// statusID=508). Sign-off gated (BR-005).
/// </summary>
public sealed class Status508Rule : CleansingRule
{
    public Status508Rule(MigrationOptions options) : base(options) { }

    public override string RuleId => "a";

    protected override SignOff SignOff => Options.SignOffs.Status508;

    public override async Task<CleansingResult> ApplyAsync(CleansingContext context, CancellationToken ct = default)
    {
        // Legacy duplicates (both descriptions) are collapsed on the target to
        // the first description (ordered by the legacy row order, preserved by
        // the copy). Any residual duplicates are corrected here.
        var sql = @"
            ;WITH ranked AS (
                SELECT [statusID], [Description],
                       ROW_NUMBER() OVER (PARTITION BY [statusID] ORDER BY [statusID]) AS rn
                  FROM [status]
            )
            UPDATE [status]
               SET [Description] = src.[Description]
              FROM [status] dst
              JOIN ranked src
                ON src.[statusID] = dst.[statusID]
             WHERE src.rn = 1
               AND dst.[statusID] = 508
               AND dst.[Description] <> src.[Description];";
        await using var cmd = context.Target.CreateCommand();
        cmd.CommandText = sql;
        var rows = await cmd.ExecuteNonQueryAsync(ct);
        return new CleansingResult(RuleId, "status", "resolve statusID=508 duplicate description to a single value", rows);
    }
}
