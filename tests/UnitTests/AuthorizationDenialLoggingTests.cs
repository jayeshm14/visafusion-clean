using System.Text.RegularExpressions;

namespace VisaFusion.UnitTests;

/// <summary>
/// Authorization-denial logging tests (SPEC-0005 rigorous-testing pass, spec §19,
/// NFR-006).
///
/// spec §19: "Authorization denials are logged (subject, endpoint, outcome)
/// without any password material." The denial log call lives in
/// `VisaFusion.Web/Program.cs` (`LogAuthorizationDenial`, wired into the
/// JwtBearer OnChallenge/OnForbidden events). These tests pin the contract at
/// the source level (the same static-scan pattern the SecuritySpotCheckTests
/// doc comment claims but does not actually assert):
///   - the denial template carries the subject/endpoint/outcome placeholders,
///   - no `Log*` call anywhere in src/ has a password placeholder in its
///     template (a password value must never be logged, NFR-006/BR-002).
/// </summary>
public class AuthorizationDenialLoggingTests
{
    private static readonly string WebProjectRoot = Path.GetFullPath(
        Path.Combine(AppContext.BaseDirectory, "..", "..", "..", "..", "..", "src", "VisaFusion.Web"));
    private static readonly string SrcRoot = Path.GetFullPath(
        Path.Combine(AppContext.BaseDirectory, "..", "..", "..", "..", "..", "src"));

    [Fact]
    public void Denial_Log_Template_Carries_Subject_Endpoint_And_Outcome()
    {
        var program = File.ReadAllText(Path.Combine(WebProjectRoot, "Program.cs"));

        // spec §19/NFR-006: the denial log must record subject, endpoint, and
        // outcome — the exact template wired into OnChallenge/OnForbidden.
        Assert.Contains(
            "Authorization denial: subject={Subject} endpoint={Endpoint} outcome={Outcome}",
            program);
    }

    [Fact]
    public void No_Log_Call_Anywhere_In_Src_Has_A_Password_Placeholder_In_Its_Template()
    {
        // NFR-006/BR-002: a password value must never be logged. Scan every
        // Log* call in src/ for a template placeholder that could carry a
        // password (the request body is never logged either — the denial log
        // logs only subject/endpoint/outcome).
        var offenders = new List<string>();
        foreach (var file in Directory.EnumerateFiles(SrcRoot, "*.cs", SearchOption.AllDirectories))
        {
            var lines = File.ReadAllLines(file);
            for (var i = 0; i < lines.Length; i++)
            {
                var line = lines[i];
                if (!line.Contains("Log", StringComparison.Ordinal)) continue;
                if (!line.Contains('{')) continue;
                if (Regex.IsMatch(line, @"Log(?:Warning|Information|Error|Debug|Verbose|Critical)?\s*\(")
                    && Regex.IsMatch(line, @"\{\s*(?:[Pp]assword|[Nn]ewPassword|[Cc]urrentPassword|[Cc]onfirmPassword)\s*\}"))
                {
                    offenders.Add($"{file}:{i + 1}: {line.Trim()}");
                }
            }
        }

        Assert.True(offenders.Count == 0,
            "Password placeholders found in log templates:\n" + string.Join("\n", offenders));
    }
}