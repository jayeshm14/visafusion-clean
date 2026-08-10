using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using VisaFusion.Data.Persistence;
using VisaFusion.Migration.Configuration;

namespace VisaFusion.Migration.Commands;

/// <summary>
/// `schema` — applies EF Core migrations to create the target `VisaFusion`
/// schema (PKs, FKs, indexes) (SPEC-0004 T022, FR-003). The initial migration
/// is created by `dotnet ef migrations add InitialCreate` (T021) against the
/// VisaEntryDbContext model; this command runs `Database.Migrate()` on the
/// target. Drop-disposition tables are never created by the model (BR-001).
/// </summary>
public sealed class SchemaCommand : MigrationStep
{
    private readonly ILogger<SchemaCommand> _logger;

    public SchemaCommand(MigrationOptions options, ILogger<SchemaCommand> logger) : base(options)
        => _logger = logger;

    public override string Name => "schema";

    public override async Task ExecuteAsync(StepContext context, CancellationToken ct = default)
    {
        var options = new DbContextOptionsBuilder<VisaEntryDbContext>()
            .UseSqlServer(Options.TargetConnectionString)
            .Options;

        await using var db = new VisaEntryDbContext(options);
        _logger.LogInformation("schema: applying EF Core migrations to target database.");

        // Database.Migrate is synchronous; run on the thread pool for cancellation.
        await Task.Run(() => db.Database.Migrate(), ct);

        var tables = await db.Database.SqlQueryRaw<string>(
            "SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE = 'BASE TABLE' ORDER BY TABLE_NAME")
            .ToListAsync(ct);
        _logger.LogInformation("schema: target schema ready; {Count} tables present.", tables.Count);

        foreach (var t in tables)
            _logger.LogDebug("schema: table {Table}", t);
    }
}
