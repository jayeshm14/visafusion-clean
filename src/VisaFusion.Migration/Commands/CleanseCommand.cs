using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Logging;
using VisaFusion.Migration.Cleansing;
using VisaFusion.Migration.Configuration;

namespace VisaFusion.Migration.Commands;

/// <summary>
/// `cleanse` — applies the four approved cleansing rules (a–d), each gated by a
/// recorded sign-off (SPEC-0004 T035, FR-005, BR-005). A rule whose sign-off is
/// missing is skipped and recorded in the report (never guessed). Only the
/// approved rules exist; nothing else is repaired (spec §18).
/// </summary>
public sealed class CleanseCommand : MigrationStep
{
    private readonly ILogger<CleanseCommand> _logger;

    public CleanseCommand(MigrationOptions options, ILogger<CleanseCommand> logger) : base(options)
        => _logger = logger;

    public override string Name => "cleanse";

    public override async Task ExecuteAsync(StepContext context, CancellationToken ct = default)
    {
        var rules = new CleansingRule[]
        {
            new Status508Rule(Options),
            new EntryTypeDefaultRule(Options),
            new OrphanAgentRule(Options),
            new JunkDateRule(Options),
            new Agents4114Rule(Options)
        };

        await using var target = new SqlConnection(Options.TargetConnectionString);
        await target.OpenAsync(ct);
        var cleansingContext = new CleansingContext { Target = target, Baseline = context.Baseline };

        foreach (var rule in rules)
        {
            if (!rule.IsApproved)
            {
                _logger.LogWarning("cleanse: rule ({Rule}) has no recorded sign-off; skipped (BR-005).", rule.RuleId);
                continue;
            }

            var result = await rule.ApplyAsync(cleansingContext, ct);
            _logger.LogInformation("cleanse: rule ({Rule}) applied: {Rows} rows affected ({Action}).",
                result.Rule, result.RowsAffected, result.Action);

            context.Report.Cleansing.Add(new Reporting.CleansingAction
            {
                Rule = result.Rule,
                Table = result.Table,
                Action = result.Action,
                RowsAffected = result.RowsAffected,
                Signoff = new Reporting.CleansingAction.SignOffRecord
                {
                    By = Options.Operator,
                    Approver = rule switch
                    {
                        Status508Rule => Options.SignOffs.Status508.Approver,
                        EntryTypeDefaultRule => Options.SignOffs.EntryTypeDefault.Approver,
                        OrphanAgentRule => Options.SignOffs.OrphanAgent.Approver,
                        JunkDateRule => Options.SignOffs.JunkDateClamp.Approver,
                        Agents4114Rule => Options.SignOffs.Agents4114.Approver,
                        _ => string.Empty
                    },
                    Date = rule switch
                    {
                        Status508Rule => Options.SignOffs.Status508.Date,
                        EntryTypeDefaultRule => Options.SignOffs.EntryTypeDefault.Date,
                        OrphanAgentRule => Options.SignOffs.OrphanAgent.Date,
                        JunkDateRule => Options.SignOffs.JunkDateClamp.Date,
                        Agents4114Rule => Options.SignOffs.Agents4114.Date,
                        _ => string.Empty
                    }
                }
            });

            // Tag the table report so validate skips checksum comparison for it.
            foreach (var t in context.Report.Tables.Where(t =>
                         string.Equals(t.LegacyTable, result.Table, StringComparison.OrdinalIgnoreCase)))
            {
                if (!t.CleansingApplied.Contains(result.Rule))
                    t.CleansingApplied.Add(result.Rule);
            }
        }

        _logger.LogInformation("cleanse: completed; {Count} actions recorded.", context.Report.Cleansing.Count);
    }
}
