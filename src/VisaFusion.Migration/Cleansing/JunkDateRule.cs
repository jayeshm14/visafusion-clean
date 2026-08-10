using Microsoft.Data.SqlClient;
using VisaFusion.Migration.Configuration;

namespace VisaFusion.Migration.Cleansing;

/// <summary>
/// Cleansing rule (d) — clamp junk dates (1970/2207) in `Mainentry` date
/// columns to a valid range (FR-005d). Only the approved clamp range is applied:
/// dates before 2000-01-01 (the junk 1970 sentinel) and after 2100-12-31 (the
/// junk 2207 sentinel) are clamped to the nearest valid bound. Sign-off gated
/// (BR-005).
/// </summary>
public sealed class JunkDateRule : CleansingRule
{
    public JunkDateRule(MigrationOptions options) : base(options) { }

    public override string RuleId => "d";

    protected override SignOff SignOff => Options.SignOffs.JunkDateClamp;

    // Approved clamp range (FR-005d, recorded sign-off).
    private static readonly DateTime MinBound = new(2000, 1, 1);
    private static readonly DateTime MaxBound = new(2100, 12, 31);

    public override async Task<CleansingResult> ApplyAsync(CleansingContext context, CancellationToken ct = default)
    {
        // Date columns on Mainentry that carry the junk sentinel (verified live:
        // subdate, coldate, receivedate, traveldate, sentDate, entrydatetime).
        string[] dateColumns = ["subdate", "coldate", "receivedate", "traveldate", "sentDate", "entrydatetime"];

        int total = 0;
        foreach (var col in dateColumns)
        {
            var sql = $"""
                UPDATE [Mainentry]
                   SET [{col}] = CASE
                                     WHEN [{col}] < @minBound THEN @minBound
                                     WHEN [{col}] > @maxBound THEN @maxBound
                                     ELSE [{col}]
                                 END
                 WHERE [{col}] IS NOT NULL
                   AND ([{col}] < @minBound OR [{col}] > @maxBound);
                """;
            await using var cmd = context.Target.CreateCommand();
            cmd.CommandText = sql;
            cmd.Parameters.AddWithValue("@minBound", MinBound);
            cmd.Parameters.AddWithValue("@maxBound", MaxBound);
            total += await cmd.ExecuteNonQueryAsync(ct);
        }

        return new CleansingResult(
            RuleId,
            "Mainentry",
            $"junk dates clamped to [{MinBound:yyyy-MM-dd}, {MaxBound:yyyy-MM-dd}]",
            total);
    }
}
