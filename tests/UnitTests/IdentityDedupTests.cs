using System.Reflection;
using VisaFusion.Migration.Identity;

namespace VisaFusion.UnitTests;

/// <summary>
/// Identity import dedup + hashing unit tests (SPEC-0004 T036, TS-003, FR-004,
/// BR-002, AC-004).
///
/// First-source-wins dedup (priority order `agents` → `registration` →
/// `Udaan_users`) is implemented in the private static
/// <see cref="IdentityImporter"/> key-take logic; it is exercised here via
/// reflection so the priority semantics are unit-tested without a database.
/// Password hashing (never plaintext) is tested directly.
/// </summary>
public class IdentityDedupTests
{
    private static readonly MethodInfo TryTakeMethod = typeof(IdentityImporter)
        .GetMethod("TryTake", BindingFlags.NonPublic | BindingFlags.Static)
        ?? throw new InvalidOperationException("IdentityImporter.TryTake not found");

    private static bool TryTake(string? userName, string? email,
        HashSet<string> usernames, HashSet<string> emails)
        => (bool)TryTakeMethod.Invoke(null, new object?[] { userName, email, usernames, emails })!;

    private static (HashSet<string> Users, HashSet<string> Emails) FreshSets() => (
        new HashSet<string>(StringComparer.OrdinalIgnoreCase),
        new HashSet<string>(StringComparer.OrdinalIgnoreCase));

    [Fact]
    public void First_Occurrence_Of_Username_Is_Taken_And_Later_One_Skipped()
    {
        var (users, emails) = FreshSets();

        // agents (priority 1) takes "agent1".
        Assert.True(TryTake("agent1", "a@x.com", users, emails));
        // registration (priority 2) with the same username is skipped.
        Assert.False(TryTake("agent1", "b@x.com", users, emails));
    }

    [Fact]
    public void First_Occurrence_Of_Email_Is_Taken_And_Later_One_Skipped()
    {
        var (users, emails) = FreshSets();

        Assert.True(TryTake("agent1", "a@x.com", users, emails));
        // A later source with the same email but a different username is skipped.
        Assert.False(TryTake("agent2", "a@x.com", users, emails));
    }

    [Fact]
    public void Row_Rejected_For_Duplicate_Email_Does_Not_Claim_Its_Username()
    {
        // Review finding 2026-08-13 (deviation log §8): a row with a fresh
        // username but a duplicate email must not block a later row that
        // shares the username and has a fresh email — otherwise a legitimate
        // account is omitted from the import.
        var (users, emails) = FreshSets();

        Assert.True(TryTake("agent1", "a@x.com", users, emails));
        // Row A: fresh username "agent2", duplicate email → rejected.
        Assert.False(TryTake("agent2", "a@x.com", users, emails));
        // Row B: same username "agent2", fresh email → must be taken.
        Assert.True(TryTake("agent2", "b@x.com", users, emails));
    }

    [Fact]
    public void Dedup_Is_Case_Insensitive_And_Trims_Whitespace()
    {
        var (users, emails) = FreshSets();

        Assert.True(TryTake(" Agent1 ", " A@X.COM ", users, emails));
        // Same keys with different casing/whitespace are duplicates.
        Assert.False(TryTake("agent1", "a@x.com", users, emails));
    }

    [Fact]
    public void Null_Or_Empty_Keys_Do_Not_Block_Later_Rows()
    {
        var (users, emails) = FreshSets();

        // A row with no username and no email has no dedup key — always taken.
        Assert.True(TryTake(null, null, users, emails));
        Assert.True(TryTake(null, null, users, emails));

        // A row with only an email still dedups on the email.
        Assert.True(TryTake(null, "a@x.com", users, emails));
        Assert.False(TryTake(null, "a@x.com", users, emails));
    }

    [Fact]
    public void PasswordHasher_Never_Stores_Plaintext()
    {
        // BR-002 / AC-004: null/empty legacy passwords are stored as null
        // (unusable until reset) — never a fixed string, never plaintext.
        Assert.Null(PasswordHasher.Hash(null));
        Assert.Null(PasswordHasher.Hash(string.Empty));

        var hash = PasswordHasher.Hash("legacy-password");
        Assert.NotNull(hash);
        Assert.DoesNotContain("legacy-password", hash, StringComparison.Ordinal);
        // ASP.NET Core Identity PBKDF2 hashes start with the version marker, so
        // imported hashes are directly usable by the running application.
        Assert.StartsWith("AQAAAA", hash, StringComparison.Ordinal);
    }
}