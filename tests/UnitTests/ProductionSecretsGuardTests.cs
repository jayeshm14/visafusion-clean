using System.Text.RegularExpressions;
using VisaFusion.Web;

namespace VisaFusion.UnitTests;

/// <summary>
/// Unit tests for the production secrets guard (SPEC-0003 T075, MD-3, NFR-004).
///
/// The guard must fail fast when a Production host starts with the committed
/// development JWT key or a localhost/Windows-integrated connection string, and
/// must not interfere with non-Production environments.
/// </summary>
public class ProductionSecretsGuardTests
{
    [Fact]
    public void Production_With_Placeholder_Jwt_Key_Throws()
    {
        var ex = Assert.Throws<InvalidOperationException>(() =>
            ProductionSecretsGuard.Validate(
                "Production",
                "CHANGE_ME_development_only_do_not_use_in_production_0123456789",
                "Server=prod.example.com;Database=VisaFusion;User Id=app;Password=real;"));

        Assert.Contains("Jwt:Key", ex.Message);
    }

    [Fact]
    public void Production_With_Localhost_Connection_String_Throws()
    {
        var ex = Assert.Throws<InvalidOperationException>(() =>
            ProductionSecretsGuard.Validate(
                "Production",
                "a-real-production-signing-key-that-is-long-enough-0123456789",
                "Server=localhost;Database=VisaFusion;Trusted_Connection=True;TrustServerCertificate=True"));

        Assert.Contains("DefaultConnection", ex.Message);
    }

    [Fact]
    public void Production_With_Trusted_Connection_Throws()
    {
        var ex = Assert.Throws<InvalidOperationException>(() =>
            ProductionSecretsGuard.Validate(
                "Production",
                "a-real-production-signing-key-that-is-long-enough-0123456789",
                "Server=sql.internal;Database=VisaFusion;Trusted_Connection=True;"));

        Assert.Contains("DefaultConnection", ex.Message);
    }

    [Fact]
    public void Production_With_Real_Secrets_Does_Not_Throw()
    {
        ProductionSecretsGuard.Validate(
            "Production",
            "a-real-production-signing-key-that-is-long-enough-0123456789",
            "Server=sql.internal;Database=VisaFusion;User Id=app;Password=***;");
    }

    [Fact]
    public void Development_With_Placeholder_Secrets_Does_Not_Throw()
    {
        // Dev/Testing environments are allowed to use the committed placeholders.
        ProductionSecretsGuard.Validate(
            "Development",
            "CHANGE_ME_development_only_do_not_use_in_production_0123456789",
            "Server=localhost;Database=VisaFusion;Trusted_Connection=True;TrustServerCertificate=True");
    }

    /// <summary>
    /// AC-010 (SPEC-0008 T049): no SMS/SMTP credentials appear in the committed
    /// source tree or in committed logs. The real SMS/SMTP dispatch providers
    /// are configuration-driven (User Secrets / Key Vault, spec §12) and are not
    /// yet implemented (the workers use log-only providers), so this scan is the
    /// guard that a credential never gets committed: it walks every committed
    /// text file and fails on any SMTP/SMS credential assignment whose value is
    /// not a placeholder.
    /// </summary>
    [Fact]
    public void Committed_Source_Tree_Contains_No_Sms_Smtp_Credentials()
    {
        var repoRoot = FindRepoRoot();
        var offenders = new List<string>();

        foreach (var file in Directory.EnumerateFiles(repoRoot, "*", SearchOption.AllDirectories))
        {
            if (IsExcluded(file)) continue;
            if (!IsTextFile(file)) continue;

            foreach (var line in File.ReadLines(file))
            {
                foreach (var pattern in CredentialPatterns)
                {
                    var match = pattern.Match(line);
                    if (match.Success && !IsPlaceholder(match.Groups[^1].Value))
                    {
                        offenders.Add($"{Path.GetRelativePath(repoRoot, file)}: {match.Value}");
                    }
                }
            }
        }

        Assert.True(offenders.Count == 0,
            "SMS/SMTP credentials must never be committed (AC-010). Found:\n"
            + string.Join("\n", offenders.Take(20)));
    }

    private static readonly Regex[] CredentialPatterns =
    {
        new(@"smtp[^""'\r\n]{0,40}(password|passwd|pwd|apikey|api[_-]?key|token|secret)\s*[:=]\s*([^\s""']+)",
            RegexOptions.IgnoreCase),
        new(@"(sms|gateway|twilio|msg91|textlocal|nexmo|vonage|way2sms)[^""'\r\n]{0,40}(password|passwd|pwd|apikey|api[_-]?key|token|secret)\s*[:=]\s*([^\s""']+)",
            RegexOptions.IgnoreCase),
        new(@"mail[^""'\r\n]{0,40}password\s*[:=]\s*([^\s""']+)",
            RegexOptions.IgnoreCase),
    };

    private static bool IsPlaceholder(string value)
        => string.IsNullOrWhiteSpace(value)
            || value.Contains("CHANGE_ME", StringComparison.OrdinalIgnoreCase)
            || value.Contains("placeholder", StringComparison.OrdinalIgnoreCase)
            || value.Contains("[REDACTED]", StringComparison.OrdinalIgnoreCase)
            || value.Contains("***", StringComparison.Ordinal);

    private static bool IsExcluded(string path)
    {
        var segments = path.Split(Path.DirectorySeparatorChar, Path.AltDirectorySeparatorChar);
        return segments.Any(s => s is ".git" or "bin" or "obj" or "node_modules" or ".vs" or "TestResults" or "artifacts" or ".codegraph" or ".opencode");
    }

    private static bool IsTextFile(string path)
    {
        var extension = Path.GetExtension(path).ToLowerInvariant();
        return extension is ".cs" or ".cshtml" or ".json" or ".md" or ".txt" or ".config" or ".xml" or ".yml" or ".yaml" or ".ps1" or ".sql" or ".log";
    }

    private static string FindRepoRoot()
    {
        var directory = new DirectoryInfo(AppContext.BaseDirectory);
        while (directory is not null)
        {
            if (Directory.Exists(Path.Combine(directory.FullName, ".git"))
                || File.Exists(Path.Combine(directory.FullName, "VisaFusion.sln")))
            {
                return directory.FullName;
            }

            directory = directory.Parent;
        }

        throw new InvalidOperationException("Could not locate the repository root from the test assembly.");
    }
}