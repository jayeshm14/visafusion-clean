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
}