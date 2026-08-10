using System.Text.Json;
using VisaFusion.Migration.Catalog;
using VisaFusion.Migration.Reporting;

namespace VisaFusion.UnitTests;

/// <summary>
/// Migration report schema tests (SPEC-0004 T042, AC-007, TS-009).
///
/// Validates the serialized report JSON against the contract
/// (contracts/migration-report.schema.json): required properties present with
/// the correct types and enum values, and the schema's enums cross-checked
/// against the implementation's disposition labels and cleansing rule ids.
/// The schema file is read from the repo so the test is a live contract check.
/// </summary>
public class ReportSchemaTests
{
    private static readonly string SchemaPath = Path.GetFullPath(Path.Combine(
        AppContext.BaseDirectory, "..", "..", "..", "..", "..",
        "specs", "004-data-model-migration", "contracts", "migration-report.schema.json"));

    private static JsonElement ReadSchema()
    {
        Assert.True(File.Exists(SchemaPath), $"Schema contract not found: {SchemaPath}");
        return JsonDocument.Parse(File.ReadAllText(SchemaPath)).RootElement;
    }

    private static MigrationReport BuildFullReport() => new()
    {
        RunId = "test-run-0001",
        StartedAt = new DateTime(2026, 8, 9, 10, 0, 0, DateTimeKind.Utc),
        CompletedAt = new DateTime(2026, 8, 9, 10, 30, 0, DateTimeKind.Utc),
        Operator = "test-operator",
        OfflineWindow = new OfflineWindow
        {
            LegacyAppStopped = true,
            WindowStart = new DateTime(2026, 8, 9, 10, 0, 0, DateTimeKind.Utc),
            WindowEnd = new DateTime(2026, 8, 9, 14, 0, 0, DateTimeKind.Utc)
        },
        Tables = new List<TableReport>
        {
            new()
            {
                LegacyTable = "status",
                Disposition = "M",
                TargetEntity = "Status",
                SourceRowCount = 27,
                TargetRowCount = 26,
                Checksum = "12345",
                ChecksumMatch = false,
                CleansingApplied = new List<string> { "a" },
                Status = "migrated"
            },
            new()
            {
                LegacyTable = "country",
                Disposition = "DROP",
                TargetEntity = null,
                SourceRowCount = 0,
                TargetRowCount = 0,
                Checksum = null,
                ChecksumMatch = false,
                CleansingApplied = new List<string>(),
                Status = "dropped"
            }
        },
        Identity = new IdentityReport
        {
            Imported = new IdentityReport.IdentityCounts { Agents = 1, Registration = 2, UdaanUsers = 3 },
            PlaintextRemaining = 0,
            SkippedDuplicates = new List<IdentityReport.IdentitySkipped>
            {
                new() { Source = "registration", Username = "dup", Email = "dup@x.com" }
            }
        },
        Cleansing = new List<CleansingAction>
        {
            new()
            {
                Rule = "a",
                Table = "status",
                Action = "resolve statusID=508 duplicate description to a single value",
                RowsAffected = 1,
                Signoff = new CleansingAction.SignOffRecord { By = "op", Approver = "owner", Date = "2026-08-09" }
            }
        },
        Validation = new ValidationReport
        {
            Passed = true,
            ValidatedAtUtc = new DateTime(2026, 8, 9, 10, 29, 0, DateTimeKind.Utc),
            TablesCompared = 31,
            TablesWithCountMismatch = 0,
            TablesWithChecksumMismatch = 0,
            IntegrityViolations = 0
        },
        Discrepancies = new List<Discrepancy>(),
        DeferredForeignKeys = new List<DeferredForeignKey>
        {
            new() { ChildTable = "Mainentry", ChildColumn = "category", ParentTable = "Category", Reason = "GAP-0001" }
        },
        Summary = new SummaryReport
        {
            TablesMigrated = 31,
            RowsMigrated = 100,
            TablesArchived = 9,
            TablesDropped = 5,
            Errors = 0
        }
    };

    /// <summary>Serializes with the exact options the ReportWriter uses.</summary>
    private static JsonElement Serialize(MigrationReport report)
    {
        var json = JsonSerializer.Serialize(report, new JsonSerializerOptions
        {
            WriteIndented = true,
            PropertyNamingPolicy = JsonNamingPolicy.CamelCase
        });
        return JsonDocument.Parse(json).RootElement;
    }

    [Fact]
    public void Report_Serializes_With_All_Required_Top_Level_Properties()
    {
        var root = Serialize(BuildFullReport());

        foreach (var prop in new[]
                 {
                     "schemaVersion", "runId", "startedAt", "completedAt", "operator",
                     "sourceDatabase", "targetDatabase", "offlineWindow", "tables",
                     "identity", "cleansing", "validation", "discrepancies"
                 })
        {
            Assert.True(root.TryGetProperty(prop, out _), $"missing required top-level property '{prop}'");
        }

        Assert.Equal("1.0", root.GetProperty("schemaVersion").GetString());
        Assert.Equal("VisaEntry", root.GetProperty("sourceDatabase").GetString());
        Assert.Equal("VisaFusion", root.GetProperty("targetDatabase").GetString());
    }

    [Fact]
    public void OfflineWindow_Requires_LegacyAppStopped_True()
    {
        var offline = Serialize(BuildFullReport()).GetProperty("offlineWindow");
        Assert.True(offline.GetProperty("legacyAppStopped").GetBoolean());
        Assert.True(offline.TryGetProperty("windowStart", out _));
        Assert.True(offline.TryGetProperty("windowEnd", out _));
    }

    [Fact]
    public void Table_Entries_Carry_The_Schema_Required_Properties_Even_When_Null()
    {
        var tables = Serialize(BuildFullReport()).GetProperty("tables");
        Assert.Equal(2, tables.GetArrayLength());

        foreach (var table in tables.EnumerateArray())
        {
            foreach (var prop in new[]
                     {
                         "legacyTable", "disposition", "targetEntity", "sourceRowCount",
                         "targetRowCount", "checksumMatch", "cleansingApplied", "status"
                     })
            {
                Assert.True(table.TryGetProperty(prop, out _), $"missing required table property '{prop}'");
            }
        }

        // The DROP table entry carries a null targetEntity (schema: ["string","null"]).
        var dropped = tables.EnumerateArray().Single(t => t.GetProperty("legacyTable").GetString() == "country");
        Assert.Equal(JsonValueKind.Null, dropped.GetProperty("targetEntity").ValueKind);
        Assert.Equal("DROP", dropped.GetProperty("disposition").GetString());
        Assert.Equal("dropped", dropped.GetProperty("status").GetString());
    }

    [Fact]
    public void Identity_Report_Carries_Counts_And_Skipped_Duplicates()
    {
        var identity = Serialize(BuildFullReport()).GetProperty("identity");

        Assert.True(identity.TryGetProperty("imported", out var imported));
        Assert.True(imported.TryGetProperty("agents", out _));
        Assert.True(imported.TryGetProperty("registration", out _));
        Assert.True(imported.TryGetProperty("udaanUsers", out _));

        Assert.True(identity.TryGetProperty("skippedDuplicates", out var skipped));
        Assert.Single(skipped.EnumerateArray());
        Assert.Equal("registration", skipped[0].GetProperty("source").GetString());

        Assert.Equal(0, identity.GetProperty("plaintextRemaining").GetInt32());
    }

    [Fact]
    public void Cleansing_Entries_Carry_Sign_Off_Record()
    {
        var cleansing = Serialize(BuildFullReport()).GetProperty("cleansing");
        Assert.Single(cleansing.EnumerateArray());

        var entry = cleansing[0];
        foreach (var prop in new[] { "rule", "table", "action", "rowsAffected", "signoff" })
            Assert.True(entry.TryGetProperty(prop, out _), $"missing required cleansing property '{prop}'");

        var signoff = entry.GetProperty("signoff");
        Assert.True(signoff.TryGetProperty("by", out _));
        Assert.True(signoff.TryGetProperty("approver", out _));
        Assert.True(signoff.TryGetProperty("date", out _));
    }

    [Fact]
    public void Validation_Report_Carries_All_Counters()
    {
        var validation = Serialize(BuildFullReport()).GetProperty("validation");
        foreach (var prop in new[]
                 {
                     "passed", "validatedAtUtc", "tablesCompared",
                     "tablesWithCountMismatch", "tablesWithChecksumMismatch", "integrityViolations"
                 })
        {
            Assert.True(validation.TryGetProperty(prop, out _), $"missing required validation property '{prop}'");
        }
        Assert.True(validation.GetProperty("passed").GetBoolean());
    }

    [Fact]
    public void Summary_Carries_All_Counters()
    {
        var summary = Serialize(BuildFullReport()).GetProperty("summary");
        foreach (var prop in new[] { "tablesMigrated", "rowsMigrated", "tablesArchived", "tablesDropped", "errors" })
            Assert.True(summary.TryGetProperty(prop, out _), $"missing required summary property '{prop}'");
    }

    [Fact]
    public void Discrepancy_Entries_Carry_Table_Kind_Detail()
    {
        var report = BuildFullReport();
        report.Discrepancies.Add(new Discrepancy { Table = "status", Kind = "row-count", Detail = "source=27, target=26" });

        var discrepancy = Serialize(report).GetProperty("discrepancies")[0];
        Assert.True(discrepancy.TryGetProperty("table", out _));
        Assert.True(discrepancy.TryGetProperty("kind", out _));
        Assert.True(discrepancy.TryGetProperty("detail", out _));
        Assert.Equal("row-count", discrepancy.GetProperty("kind").GetString());
    }

    [Fact]
    public void Deferred_Foreign_Keys_Carry_Child_Column_Parent_Reason()
    {
        var fk = Serialize(BuildFullReport()).GetProperty("deferredForeignKeys")[0];
        Assert.True(fk.TryGetProperty("childTable", out _));
        Assert.True(fk.TryGetProperty("childColumn", out _));
        Assert.True(fk.TryGetProperty("parentTable", out _));
        Assert.True(fk.TryGetProperty("reason", out _));
        Assert.Contains("GAP-0001", fk.GetProperty("reason").GetString());
    }

    [Fact]
    public void Disposition_Labels_Conform_To_The_Schema_Enum()
    {
        // The implementation's disposition labels must be a subset of the
        // schema's tables.disposition enum (M | M-RO | COND | ARCH | DROP).
        var schema = ReadSchema();
        var enumValues = schema.GetProperty("properties").GetProperty("tables")
            .GetProperty("items").GetProperty("properties").GetProperty("disposition")
            .GetProperty("enum").EnumerateArray().Select(e => e.GetString()!).ToArray();

        foreach (var disposition in Enum.GetValues<TableDisposition>())
        {
            var spec = new TableSpec("t", "t", "T", disposition);
            Assert.Contains(spec.DispositionLabel, enumValues);
        }
    }

    [Fact]
    public void Cleansing_Rule_Enum_Includes_FR005e()
    {
        // FR-005e (GAP-0002, agents 4114) is a documented cleansing rule; the
        // schema's cleansing.rule enum must include it.
        var schema = ReadSchema();
        var enumValues = schema.GetProperty("properties").GetProperty("cleansing")
            .GetProperty("items").GetProperty("properties").GetProperty("rule")
            .GetProperty("enum").EnumerateArray().Select(e => e.GetString()!).ToArray();

        Assert.Contains("e", enumValues);
    }

    [Fact]
    public void ReportWriter_Renders_Human_Summary_With_All_Sections()
    {
        var summary = ReportWriter.RenderSummary(BuildFullReport());

        Assert.Contains("# Migration Report", summary);
        Assert.Contains("## Summary", summary);
        Assert.Contains("## Tables", summary);
        Assert.Contains("## Cleansing (approved, BR-005)", summary);
        Assert.Contains("## Identity", summary);
        Assert.Contains("## Deferred foreign keys (GAP-0001)", summary);
        Assert.Contains("## Validation: PASSED", summary);
    }

    [Fact]
    public async Task ReportWriter_Writes_Json_And_Summary_Files()
    {
        var dir = Path.Combine(Path.GetTempPath(), "visafusion-report-tests", Guid.NewGuid().ToString("N"));
        try
        {
            var writer = new ReportWriter(dir);
            await writer.WriteAsync(BuildFullReport());

            var jsonPath = Path.Combine(dir, "migration-test-run-0001.json");
            var summaryPath = Path.Combine(dir, "migration-test-run-0001.summary.md");
            Assert.True(File.Exists(jsonPath));
            Assert.True(File.Exists(summaryPath));

            // The written JSON parses and carries the schema version.
            var root = JsonDocument.Parse(await File.ReadAllTextAsync(jsonPath)).RootElement;
            Assert.Equal("1.0", root.GetProperty("schemaVersion").GetString());
        }
        finally
        {
            if (Directory.Exists(dir)) Directory.Delete(dir, recursive: true);
        }
    }
}