using Microsoft.AspNetCore.Identity;
using VisaFusion.Identity;

namespace VisaFusion.Migration.Identity;

/// <summary>
/// Password hashing on import — never plaintext (SPEC-0004 T039, BR-002,
/// AC-004). Uses ASP.NET Core Identity's PBKDF2 hasher so imported hashes are
/// directly usable by the running application. Legacy plaintext passwords are
/// read, hashed, and never written in plaintext.
/// </summary>
public static class PasswordHasher
{
    private static readonly PasswordHasher<IdentityIntegration.VisaFusionUser> Hasher = new();

    /// <summary>
    /// Hashes a legacy password for storage. A null/empty password (legacy
    /// accounts without one) is stored as null — the account is unusable until
    /// reset; never stored as a fixed string (no invented credentials).
    /// </summary>
    public static string? Hash(string? legacyPassword)
    {
        if (string.IsNullOrEmpty(legacyPassword)) return null;
        return Hasher.HashPassword(new IdentityIntegration.VisaFusionUser(), legacyPassword);
    }
}
