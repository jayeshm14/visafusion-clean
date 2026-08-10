using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using Serilog;
using Serilog.Events;
using VisaFusion.Migration.Commands;
using VisaFusion.Migration.Configuration;

// VisaFusion.Migration — operator-run console for the VisaEntry → VisaFusion
// data migration (SPEC-0004). Fixed command order and exit codes per
// contracts/migration-cli.md. Usage:
//
//   dotnet run --project src/VisaFusion.Migration -- <command> [--step <name>]
//
// Commands (fixed order): preflight snapshot schema copy cleanse identity
// validate report. `--step <name>` runs a single step (must follow its
// predecessors); no argument runs all remaining steps.

Log.Logger = new LoggerConfiguration()
    .MinimumLevel.Information()
    .WriteTo.Console()
    .CreateLogger();

var builder = new ConfigurationBuilder()
    .SetBasePath(AppContext.BaseDirectory)
    .AddJsonFile("appsettings.json", optional: false, reloadOnChange: false)
    .AddUserSecrets<Program>(optional: true)
    .AddEnvironmentVariables();

var configuration = builder.Build();

// No secrets in source (NFR-004): connection strings are resolved from
// configuration; the placeholders in appsettings.json must be replaced by
// environment/user-secrets values before running.
var legacyConnection = configuration["Legacy:VisaEntry"];
var targetConnection = configuration["Target:VisaFusion"];

if (string.IsNullOrWhiteSpace(legacyConnection) || legacyConnection.Contains("__LEGACY_SERVER__"))
{
    Console.Error.WriteLine("Configuration error: Legacy:VisaEntry connection string is not configured (exit 5).");
    return ExitCodes.ConfigurationError;
}
if (string.IsNullOrWhiteSpace(targetConnection) || targetConnection.Contains("__TARGET_SERVER__"))
{
    Console.Error.WriteLine("Configuration error: Target:VisaFusion connection string is not configured (exit 5).");
    return ExitCodes.ConfigurationError;
}

var migrationOptions = new MigrationOptions
{
    LegacyConnectionString = legacyConnection,
    TargetConnectionString = targetConnection,
    BatchSize = configuration.GetValue("Migration:BatchSize", 10_000),
    MaintenanceWindowHours = configuration.GetValue("Migration:MaintenanceWindowHours", 4),
    ReportsDirectory = configuration["Migration:ReportsDirectory"] ?? "reports",
    LogsDirectory = configuration["Migration:LogsDirectory"] ?? "logs",
    Operator = configuration["Migration:Operator"] ?? Environment.UserName,
    BackupDirectory = configuration["Migration:BackupDirectory"] ?? "backups",
    SignOffs = new CleansingSignOffs
    {
        Status508 = ReadSignOff(configuration, "Status508"),
        EntryTypeDefault = ReadSignOff(configuration, "EntryTypeDefault"),
        OrphanAgent = ReadSignOff(configuration, "OrphanAgent"),
        JunkDateClamp = ReadSignOff(configuration, "JunkDateClamp"),
        Agents4114 = ReadSignOff(configuration, "Agents4114")
    }
};

// Structured logging: file sink + console (NFR-006). The SQL sink requires the
// target logging database; file + console are the default observability path.
var logFile = Path.Combine(migrationOptions.LogsDirectory, "migration-.log");
Log.Logger = new LoggerConfiguration()
    .MinimumLevel.Information()
    .MinimumLevel.Override("Microsoft", LogEventLevel.Warning)
    .WriteTo.Console()
    .WriteTo.File(logFile, rollingInterval: RollingInterval.Day)
    .CreateLogger();

try
{
    Log.Information("VisaFusion.Migration starting (run id {RunId}).", Guid.NewGuid().ToString("N"));

    var cliArgs = Environment.GetCommandLineArgs().Skip(1).ToArray();
    var command = cliArgs.FirstOrDefault() ?? string.Empty;
    string? requestedStep = null;

    for (var i = 0; i < cliArgs.Length; i++)
    {
        if (cliArgs[i] == "--step" && i + 1 < cliArgs.Length)
            requestedStep = cliArgs[i + 1];
    }

    // No command and no --step: run the full fixed sequence.
    if (command.Length == 0 && requestedStep is null)
        command = "run";

    var services = new ServiceCollection();
    // The static Serilog Log.Logger must remain usable in the outer
    // catch/finally even after the provider is disposed during stack
    // unwinding (e.g. a PreflightException from the StepRunner predecessor
    // check). dispose: false keeps Log.CloseAndFlush() (below) the single
    // lifecycle owner (NFR-006).
    services.AddLogging(b => b.AddSerilog(dispose: false));
    services.AddSingleton(migrationOptions);
    services.AddSingleton<PreflightCommand>();
    services.AddSingleton<SnapshotCommand>();
    services.AddSingleton<SchemaCommand>();
    services.AddSingleton<CopyCommand>();
    services.AddSingleton<CleanseCommand>();
    services.AddSingleton<IdentityCommand>();
    services.AddSingleton<ValidateCommand>();
    services.AddSingleton<ReportCommand>();
    services.AddSingleton(sp => new StepRunner(
        sp.GetRequiredService<MigrationOptions>(),
        sp.GetRequiredService<ILogger<StepRunner>>(),
        new MigrationStep[]
        {
            sp.GetRequiredService<PreflightCommand>(),
            sp.GetRequiredService<SnapshotCommand>(),
            sp.GetRequiredService<SchemaCommand>(),
            sp.GetRequiredService<CopyCommand>(),
            sp.GetRequiredService<CleanseCommand>(),
            sp.GetRequiredService<IdentityCommand>(),
            sp.GetRequiredService<ValidateCommand>(),
            sp.GetRequiredService<ReportCommand>()
        }));

    using var provider = services.BuildServiceProvider();
    var runner = provider.GetRequiredService<StepRunner>();

    Log.Information("Running migration command '{Command}' (step: {Step}).",
        command, requestedStep ?? "all-remaining");

    return await runner.RunAsync(requestedStep);
}
catch (Exception ex)
{
    Log.Fatal(ex, "Migration terminated unexpectedly.");
    return ExitCodes.StepFailure;
}
finally
{
    Log.CloseAndFlush();
}

static SignOff ReadSignOff(IConfiguration configuration, string key)
{
    var section = configuration.GetSection($"Migration:SignOffs:{key}");
    return new SignOff
    {
        By = section["By"] ?? string.Empty,
        Approver = section["Approver"] ?? string.Empty,
        Date = section["Date"] ?? string.Empty
    };
}
