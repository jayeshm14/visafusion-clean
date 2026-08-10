using Microsoft.Extensions.Logging;
using VisaFusion.Migration.Configuration;
using VisaFusion.Migration.Identity;

namespace VisaFusion.Migration.Commands;

/// <summary>
/// `identity` — imports the three legacy identity sources into ASP.NET Core
/// Identity (SPEC-0004 T040, FR-004): agents (role `agt`), registration
/// (role `guest`), Udaan_users (roles su/adm/emp/agt), first-source-wins dedup,
/// passwords hashed on import (BR-002, AC-004).
/// </summary>
public sealed class IdentityCommand : MigrationStep
{
    private readonly ILogger<IdentityCommand> _logger;

    public IdentityCommand(MigrationOptions options, ILogger<IdentityCommand> logger) : base(options)
        => _logger = logger;

    public override string Name => "identity";

    public override async Task ExecuteAsync(StepContext context, CancellationToken ct = default)
    {
        var importer = new IdentityImporter(Options.LegacyConnectionString, Options.TargetConnectionString, _logger);
        var result = await importer.ImportAsync(ct);

        context.Report.Identity = new Reporting.IdentityReport
        {
            Imported = new Reporting.IdentityReport.IdentityCounts
            {
                Agents = result.Agents,
                Registration = result.Registration,
                UdaanUsers = result.UdaanUsers
            },
            PlaintextRemaining = 0
        };
        foreach (var skip in result.SkippedDuplicates)
        {
            context.Report.Identity.SkippedDuplicates.Add(new Reporting.IdentityReport.IdentitySkipped
            {
                Source = skip.Source,
                Username = skip.Username,
                Email = skip.Email
            });
        }

        _logger.LogInformation("identity: imported agents={Agents}, registration={Registration}, udaanUsers={Udaan}; skipped {Skips}.",
            result.Agents, result.Registration, result.UdaanUsers, result.SkippedDuplicates.Count);
    }
}
