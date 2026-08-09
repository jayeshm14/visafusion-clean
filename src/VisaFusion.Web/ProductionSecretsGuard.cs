namespace VisaFusion.Web;

/// <summary>
/// Fail-fast guard against running a Production host with development-only
/// secrets (SPEC-0003 T075, MD-3, NFR-004).
///
/// The committed appsettings.json contains a development JWT key placeholder and
/// a localhost/Windows-integrated connection string. If a Production host starts
/// with either value, any attacker can forge tokens or the app connects to the
/// wrong database. This guard throws before the host starts.
///
/// Extracted as a static class so the behavior is unit-testable without booting
/// the full host.
/// </summary>
public static class ProductionSecretsGuard
{
    private const string PlaceholderJwtKey = "CHANGE_ME_development_only_do_not_use_in_production_0123456789";

    public static void Validate(string environmentName, string jwtKey, string connectionString)
    {
        if (!string.Equals(environmentName, "Production", StringComparison.OrdinalIgnoreCase))
        {
            return;
        }

        if (string.Equals(jwtKey, PlaceholderJwtKey, StringComparison.Ordinal))
        {
            throw new InvalidOperationException(
                "Refusing to start in Production: the Jwt:Key is the committed development " +
                "placeholder. Override Jwt:Key via environment variables / User Secrets / Key Vault (NFR-004).");
        }

        if (connectionString.Contains("localhost", StringComparison.OrdinalIgnoreCase)
            || connectionString.Contains("Trusted_Connection=True", StringComparison.OrdinalIgnoreCase))
        {
            throw new InvalidOperationException(
                "Refusing to start in Production: ConnectionStrings:DefaultConnection points at a " +
                "local/Windows-integrated SQL Server. Provide a production connection string via " +
                "environment variables / User Secrets / Key Vault (NFR-004).");
        }
    }
}