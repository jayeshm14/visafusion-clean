using Microsoft.Data.SqlClient;

namespace VisaFusion.Migration.Commands;

/// <summary>
/// Run-state / idempotency record stored in the target database
/// (SPEC-0004 T007, NFR-001). A completed step is recorded; re-running it is a
/// no-op. `validate` and `report` are always safe to re-run
/// (contracts/migration-cli.md §3).
/// </summary>
public sealed class RunState
{
    public const string TableName = "MigrationRunState";

    public string RunId { get; set; } = Guid.NewGuid().ToString("N");

    /// <summary>Step names that completed successfully, in order.</summary>
    public List<string> CompletedSteps { get; set; } = new();

    /// <summary>The step currently executing (empty when idle).</summary>
    public string CurrentStep { get; set; } = string.Empty;

    public DateTime StartedAtUtc { get; set; } = DateTime.UtcNow;

    public DateTime? CompletedAtUtc { get; set; }

    /// <summary>True when a prior run left the target in a partial state.</summary>
    public bool PartialFromPreviousRun { get; set; }

    public static string[] OrderedSteps { get; } =
        ["preflight", "snapshot", "schema", "copy", "cleanse", "identity", "validate", "report"];

    /// <summary>Ensures the run-state table exists in the target database.</summary>
    public static async Task EnsureTableAsync(SqlConnection connection, CancellationToken ct = default)
    {
        var sql = $"""
            IF OBJECT_ID('{TableName}', 'U') IS NULL
            BEGIN
                CREATE TABLE [{TableName}] (
                    [Id]          int IDENTITY(1,1) NOT NULL PRIMARY KEY,
                    [RunId]       nvarchar(64)  NOT NULL,
                    [CurrentStep] nvarchar(64)  NOT NULL,
                    [CompletedSteps] nvarchar(max) NOT NULL,
                    [StartedAtUtc] datetime2 NOT NULL,
                    [CompletedAtUtc] datetime2 NULL,
                    [UpdatedAtUtc] datetime2 NOT NULL DEFAULT SYSUTCDATETIME()
                );
            END
            """;
        await using var cmd = connection.CreateCommand();
        cmd.CommandText = sql;
        await cmd.ExecuteNonQueryAsync(ct);
    }

    /// <summary>Loads the most recent run-state row, or null when none exists.</summary>
    public static async Task<RunState?> LoadLatestAsync(SqlConnection connection, CancellationToken ct = default)
    {
        await EnsureTableAsync(connection, ct);
        var sql = $"""
            SELECT TOP 1 [RunId], [CurrentStep], [CompletedSteps], [StartedAtUtc], [CompletedAtUtc]
              FROM [{TableName}]
             ORDER BY [Id] DESC
            """;
        await using var cmd = connection.CreateCommand();
        cmd.CommandText = sql;
        await using var r = await cmd.ExecuteReaderAsync(ct);
        if (!await r.ReadAsync(ct)) return null;
        return new RunState
        {
            RunId = r.GetString(0),
            CurrentStep = r.GetString(1),
            CompletedSteps = Deserialize(r.GetString(2)),
            StartedAtUtc = r.GetDateTime(3),
            CompletedAtUtc = r.IsDBNull(4) ? null : r.GetDateTime(4)
        };
    }

    /// <summary>Persists (upserts) the run-state row.</summary>
    public async Task SaveAsync(SqlConnection connection, CancellationToken ct = default)
    {
        await EnsureTableAsync(connection, ct);
        var sql = $"""
            UPDATE [{TableName}]
               SET [CurrentStep] = @step,
                   [CompletedSteps] = @steps,
                   [CompletedAtUtc] = @completedAt,
                   [UpdatedAtUtc] = SYSUTCDATETIME()
             WHERE [RunId] = @runId;
            IF @@ROWCOUNT = 0
            BEGIN
                INSERT INTO [{TableName}] ([RunId], [CurrentStep], [CompletedSteps], [StartedAtUtc], [CompletedAtUtc], [UpdatedAtUtc])
                VALUES (@runId, @step, @steps, @startedAt, @completedAt, SYSUTCDATETIME());
            END
            """;
        await using var cmd = connection.CreateCommand();
        cmd.CommandText = sql;
        cmd.Parameters.AddWithValue("@runId", RunId);
        cmd.Parameters.AddWithValue("@step", CurrentStep);
        cmd.Parameters.AddWithValue("@steps", Serialize(CompletedSteps));
        cmd.Parameters.AddWithValue("@startedAt", StartedAtUtc);
        cmd.Parameters.AddWithValue("@completedAt", (object?)CompletedAtUtc ?? DBNull.Value);
        await cmd.ExecuteNonQueryAsync(ct);
    }

    /// <summary>True when the given step already completed in this run.</summary>
    public bool IsCompleted(string step) => CompletedSteps.Contains(step, StringComparer.Ordinal);

    public void MarkCompleted(string step)
    {
        if (!IsCompleted(step)) CompletedSteps.Add(step);
        CurrentStep = string.Empty;
    }

    private static string Serialize(IEnumerable<string> steps) => string.Join(';', steps);

    private static List<string> Deserialize(string value) =>
        string.IsNullOrWhiteSpace(value) ? new List<string>() : value.Split(';').ToList();
}
