using System.Text.RegularExpressions;

namespace VisaFusion.IntegrationTests;

/// <summary>
/// Static scan test (SPEC-0003 T032, SPEC-0004 T049, NFR-003).
///
/// Asserts no string-concatenated SQL pattern exists in src/VisaFusion.Data/
/// and src/VisaFusion.Migration/. Both projects must use LINQ/parameterized
/// queries only — never raw string-concatenated SQL (the legacy
/// `connection.asp`/inline-SQL backdoor is not carried forward). The migration
/// project's identifier-quoting interpolations (e.g. `[{table}]`) are
/// parameterized/escaped, not value concatenation, and do not match the scan.
/// </summary>
public class NoStringConcatenatedSqlTests
{
    private static readonly string DataProjectRoot = Path.GetFullPath(
        Path.Combine(AppContext.BaseDirectory, "..", "..", "..", "..", "..", "src", "VisaFusion.Data"));

    private static readonly string MigrationProjectRoot = Path.GetFullPath(
        Path.Combine(AppContext.BaseDirectory, "..", "..", "..", "..", "..", "src", "VisaFusion.Migration"));

    // Matches string concatenation feeding a SQL command: e.g. "SELECT ... " + id
    private static readonly Regex ConcatenatedSqlPattern = new(
        @"(SELECT|INSERT|UPDATE|DELETE|FROM|WHERE)\s+.*""\s*\+\s*",
        RegexOptions.IgnoreCase | RegexOptions.Compiled);

    [Fact]
    public void Data_Project_Contains_No_String_Concatenated_Sql()
    {
        Assert.True(Directory.Exists(DataProjectRoot),
            $"Data project root not found: {DataProjectRoot}");

        var offenders = new List<string>();
        foreach (var file in Directory.EnumerateFiles(DataProjectRoot, "*.cs", SearchOption.AllDirectories))
        {
            var content = File.ReadAllText(file);
            if (ConcatenatedSqlPattern.IsMatch(content))
            {
                offenders.Add(file);
            }
        }

        Assert.True(offenders.Count == 0,
            $"String-concatenated SQL detected in: {string.Join(", ", offenders)}");
    }

    [Fact]
    public void Migration_Project_Contains_No_String_Concatenated_Sql()
    {
        Assert.True(Directory.Exists(MigrationProjectRoot),
            $"Migration project root not found: {MigrationProjectRoot}");

        var offenders = new List<string>();
        foreach (var file in Directory.EnumerateFiles(MigrationProjectRoot, "*.cs", SearchOption.AllDirectories))
        {
            var content = File.ReadAllText(file);
            if (ConcatenatedSqlPattern.IsMatch(content))
            {
                offenders.Add(file);
            }
        }

        Assert.True(offenders.Count == 0,
            $"String-concatenated SQL detected in: {string.Join(", ", offenders)}");
    }
}