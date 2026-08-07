using System.Text.RegularExpressions;

namespace VisaFusion.IntegrationTests;

/// <summary>
/// Static scan test (SPEC-0003 T032, NFR-003).
///
/// Asserts no string-concatenated SQL pattern exists in src/VisaFusion.Data/.
/// The Data project must use LINQ/parameterized queries only — never raw
/// string-concatenated SQL (the legacy `connection.asp`/inline-SQL backdoor is
/// not carried forward).
/// </summary>
public class NoStringConcatenatedSqlTests
{
    private static readonly string DataProjectRoot = Path.GetFullPath(
        Path.Combine(AppContext.BaseDirectory, "..", "..", "..", "..", "..", "src", "VisaFusion.Data"));

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
}