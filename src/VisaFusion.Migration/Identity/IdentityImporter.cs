using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Logging;
using VisaFusion.Identity;
using VisaFusion.Migration.Configuration;

namespace VisaFusion.Migration.Identity;

/// <summary>One imported user record.</summary>
public sealed record ImportedUser(string Source, string? Username, string? Email, string Role);

/// <summary>Result of the identity import step.</summary>
public sealed class IdentityImportResult
{
    public int Agents { get; set; }
    public int Registration { get; set; }
    public int UdaanUsers { get; set; }
    public List<IdentityReportSkipped> SkippedDuplicates { get; } = new();
}

public sealed record IdentityReportSkipped(string Source, string? Username, string? Email);

/// <summary>
/// Identity import pipeline (SPEC-0004 T038, FR-004; SPEC-0005 T015, FR-009).
/// Reads the three legacy identity sources in priority order — `agents` →
/// `registration` → `Udaan_users` — and creates hashed ASP.NET Core Identity
/// users with the mapped roles. First-source-wins on duplicate username/email;
/// skipped duplicates are listed in the report. Passwords are hashed on import
/// (never plaintext, BR-002/AC-004).
///
/// Lockout alignment (SPEC-0005 T015, FR-009, spec §16): the legacy `active`
/// flag is read from all three sources via <see cref="IdentityActive"/> and an
/// inactive account (`active = 'N'`) is imported with `LockoutEnabled = 1` and
/// a FAR-FUTURE `LockoutEnd` — `IsLockedOutAsync` (installed 8.0.29 shared
/// framework) blocks only when `LockoutEnd >= UtcNow`, so a past date would
/// not block (corrected 2026-08-11; replaces the hardcoded `LockoutEnabled=1`
/// deviation). Active accounts import with `LockoutEnabled = 0`.
/// </summary>
public sealed class IdentityImporter
{
    private readonly string _legacyConnectionString;
    private readonly string _targetConnectionString;
    private readonly ILogger _logger;

    public IdentityImporter(string legacyConnectionString, string targetConnectionString, ILogger logger)
    {
        _legacyConnectionString = legacyConnectionString;
        _targetConnectionString = targetConnectionString;
        _logger = logger;
    }

    public async Task<IdentityImportResult> ImportAsync(CancellationToken ct = default)
    {
        var result = new IdentityImportResult();
        var seenUsernames = new HashSet<string>(StringComparer.OrdinalIgnoreCase);
        var seenEmails = new HashSet<string>(StringComparer.OrdinalIgnoreCase);

        await using var target = new SqlConnection(_targetConnectionString);
        await target.OpenAsync(ct);
        await EnsureIdentitySchemaAsync(target, ct);

        // Priority 1: agents (role agt). Username = agent Description.
        using (var legacy = new SqlConnection(_legacyConnectionString))
        {
            await legacy.OpenAsync(ct);
            await foreach (var row in ReadAgentsAsync(legacy, ct))
            {
                var (userName, email, agentId, inactive) = row;
                if (!TryTake(userName, email, seenUsernames, seenEmails))
                {
                    result.SkippedDuplicates.Add(new IdentityReportSkipped("agents", userName, email));
                    continue;
                }
                await InsertUserAsync(target, userName, email, null, IdentityIntegration.Roles.Agent, agentId, inactive, ct);
                result.Agents++;
            }
        }

        // Priority 2: registration (role guest). Username = uid (legacy login), email = emailid.
        using (var legacy = new SqlConnection(_legacyConnectionString))
        {
            await legacy.OpenAsync(ct);
            await foreach (var row in ReadRegistrationAsync(legacy, ct))
            {
                var (userName, email, password, inactive) = row;
                if (!TryTake(userName, email, seenUsernames, seenEmails))
                {
                    result.SkippedDuplicates.Add(new IdentityReportSkipped("registration", userName, email));
                    continue;
                }
                var hash = PasswordHasher.Hash(password);
                await InsertUserAsync(target, userName, email, hash, IdentityIntegration.Roles.Guest, null, inactive, ct);
                result.Registration++;
            }
        }

        // Priority 3: Udaan_users (roles su/adm/emp/agt). No numeric PK exists —
        // username is the key; `agt` rows link to Agent by username = agents.Description.
        using (var legacy = new SqlConnection(_legacyConnectionString))
        {
            await legacy.OpenAsync(ct);
            var agentByDescription = await LoadAgentByDescriptionAsync(legacy, ct);
            await foreach (var row in ReadUdaanUsersAsync(legacy, ct))
            {
                var (userName, email, password, role, udaanId, inactive) = row;
                int? agentId = role == IdentityIntegration.Roles.Agent
                    && !string.IsNullOrEmpty(userName)
                    && agentByDescription.TryGetValue(userName.Trim(), out var aid)
                    ? (int?)aid
                    : null;
                if (!TryTake(userName, email, seenUsernames, seenEmails))
                {
                    result.SkippedDuplicates.Add(new IdentityReportSkipped("Udaan_users", userName, email));
                    continue;
                }
                var hash = PasswordHasher.Hash(password);
                await InsertUserAsync(target, userName, email, hash, role, agentId, inactive, ct);
                result.UdaanUsers++;
            }
        }

        _logger.LogInformation("identity: imported agents={Agents}, registration={Registration}, udaanUsers={Udaan}",
            result.Agents, result.Registration, result.UdaanUsers);
        return result;
    }

    private static bool TryTake(string? userName, string? email,
        HashSet<string> usernames, HashSet<string> emails)
    {
        var u = userName?.Trim().ToLowerInvariant();
        var e = email?.Trim().ToLowerInvariant();
        if (!string.IsNullOrEmpty(u) && !usernames.Add(u)) return false;
        if (!string.IsNullOrEmpty(e) && !emails.Add(e)) return false;
        return true;
    }

    private static async Task EnsureIdentitySchemaAsync(SqlConnection target, CancellationToken ct)
    {
        var sql = @"
            IF OBJECT_ID('AspNetUsers', 'U') IS NULL
            BEGIN
                CREATE TABLE AspNetUsers (
                    Id                   nvarchar(450) NOT NULL PRIMARY KEY,
                    UserName             nvarchar(256) NULL,
                    NormalizedUserName   nvarchar(256) NULL,
                    Email                nvarchar(256) NULL,
                    NormalizedEmail      nvarchar(256) NULL,
                    EmailConfirmed       bit NOT NULL DEFAULT 0,
                    PasswordHash         nvarchar(max) NULL,
                    SecurityStamp        nvarchar(max) NULL,
                    ConcurrencyStamp     nvarchar(max) NULL,
                    PhoneNumber          nvarchar(max) NULL,
                    PhoneNumberConfirmed bit NOT NULL DEFAULT 0,
                    TwoFactorEnabled     bit NOT NULL DEFAULT 0,
                    LockoutEnd           datetimeoffset NULL,
                    LockoutEnabled       bit NOT NULL DEFAULT 0,
                    AccessFailedCount    int NOT NULL DEFAULT 0,
                    LegacyUdaanUserId    int NULL,
                    LegacyRegistrationId int NULL,
                    AgentId              int NULL
                );
                CREATE TABLE AspNetRoles (
                    Id               nvarchar(450) NOT NULL PRIMARY KEY,
                    Name             nvarchar(256) NULL,
                    NormalizedName   nvarchar(256) NULL,
                    ConcurrencyStamp nvarchar(max) NULL
                );
                INSERT INTO AspNetRoles (Id, Name, NormalizedName) VALUES
                    (N'su',    N'su',    N'SU'),
                    (N'adm',   N'adm',   N'ADM'),
                    (N'emp',   N'emp',   N'EMP'),
                    (N'agt',   N'agt',   N'AGT'),
                    (N'guest', N'guest', N'GUEST');
                CREATE TABLE AspNetUserRoles (
                    UserId nvarchar(450) NOT NULL,
                    RoleId nvarchar(450) NOT NULL,
                    PRIMARY KEY (UserId, RoleId),
                    FOREIGN KEY (UserId) REFERENCES AspNetUsers(Id) ON DELETE CASCADE,
                    FOREIGN KEY (RoleId) REFERENCES AspNetRoles(Id) ON DELETE CASCADE
                );
            END
            -- Four standard auxiliary Identity tables (SPEC-0005 T004) so the
            -- runtime store contract is complete; schema matches the shared
            -- framework's IdentityDbContext model. Each table has its OWN
            -- existence guard (not nested in the AspNetUsers guard): the
            -- identity step is re-runnable, and a target DB that already has
            -- AspNetUsers (e.g. from a pre-T004 run) must still get the
            -- auxiliary tables.
            IF OBJECT_ID('AspNetUserClaims', 'U') IS NULL
            BEGIN
                CREATE TABLE AspNetUserClaims (
                    Id         int IDENTITY(1,1) NOT NULL PRIMARY KEY,
                    UserId     nvarchar(450) NOT NULL,
                    ClaimType  nvarchar(max) NULL,
                    ClaimValue nvarchar(max) NULL,
                    FOREIGN KEY (UserId) REFERENCES AspNetUsers(Id) ON DELETE CASCADE
                );
            END
            IF OBJECT_ID('AspNetRoleClaims', 'U') IS NULL
            BEGIN
                CREATE TABLE AspNetRoleClaims (
                    Id         int IDENTITY(1,1) NOT NULL PRIMARY KEY,
                    RoleId     nvarchar(450) NOT NULL,
                    ClaimType  nvarchar(max) NULL,
                    ClaimValue nvarchar(max) NULL,
                    FOREIGN KEY (RoleId) REFERENCES AspNetRoles(Id) ON DELETE CASCADE
                );
            END
            IF OBJECT_ID('AspNetUserLogins', 'U') IS NULL
            BEGIN
                CREATE TABLE AspNetUserLogins (
                    LoginProvider        nvarchar(450) NOT NULL,
                    ProviderKey          nvarchar(450) NOT NULL,
                    ProviderDisplayName  nvarchar(max) NULL,
                    UserId               nvarchar(450) NOT NULL,
                    PRIMARY KEY (LoginProvider, ProviderKey),
                    FOREIGN KEY (UserId) REFERENCES AspNetUsers(Id) ON DELETE CASCADE
                );
            END
            IF OBJECT_ID('AspNetUserTokens', 'U') IS NULL
            BEGIN
                CREATE TABLE AspNetUserTokens (
                    UserId        nvarchar(450) NOT NULL,
                    LoginProvider nvarchar(450) NOT NULL,
                    Name          nvarchar(450) NOT NULL,
                    Value         nvarchar(max) NULL,
                    PRIMARY KEY (UserId, LoginProvider, Name),
                    FOREIGN KEY (UserId) REFERENCES AspNetUsers(Id) ON DELETE CASCADE
                );
            END";
        await using var cmd = target.CreateCommand();
        cmd.CommandText = sql;
        await cmd.ExecuteNonQueryAsync(ct);
    }

    private static async Task InsertUserAsync(SqlConnection target, string? userName, string? email,
        string? passwordHash, string role, int? agentId, bool inactive, CancellationToken ct)
    {
        var userId = Guid.NewGuid().ToString("N");
        // FR-009 (SPEC-0005 T015): inactive accounts import with
        // LockoutEnabled = 1 and a FAR-FUTURE LockoutEnd — IsLockedOutAsync
        // blocks only when LockoutEnd >= UtcNow (verified against the installed
        // 8.0.29 shared framework; a past LockoutEnd would NOT block).
        var lockoutEnabled = inactive ? 1 : 0;
        var lockoutEnd = inactive ? (object)DateTimeOffset.UtcNow.AddYears(100) : DBNull.Value;
        var sql = @"
            INSERT INTO AspNetUsers (Id, UserName, NormalizedUserName, Email, NormalizedEmail,
                EmailConfirmed, PasswordHash, SecurityStamp, ConcurrencyStamp,
                PhoneNumber, PhoneNumberConfirmed, TwoFactorEnabled, LockoutEnd,
                LockoutEnabled, AccessFailedCount, LegacyUdaanUserId, LegacyRegistrationId, AgentId)
            VALUES (@id, @userName, @normUser, @email, @normEmail, 0, @hash,
                NEWID(), NEWID(), NULL, 0, 0, @lockoutEnd, @lockoutEnabled, 0, NULL, NULL, @agent);
            INSERT INTO AspNetUserRoles (UserId, RoleId) VALUES (@id, @role);";
        await using var cmd = target.CreateCommand();
        cmd.CommandText = sql;
        cmd.Parameters.AddWithValue("@id", userId);
        cmd.Parameters.AddWithValue("@userName", (object?)userName ?? DBNull.Value);
        cmd.Parameters.AddWithValue("@normUser", (object?)userName?.Trim().ToUpperInvariant() ?? DBNull.Value);
        cmd.Parameters.AddWithValue("@email", (object?)email ?? DBNull.Value);
        cmd.Parameters.AddWithValue("@normEmail", (object?)email?.Trim().ToUpperInvariant() ?? DBNull.Value);
        cmd.Parameters.AddWithValue("@hash", (object?)passwordHash ?? DBNull.Value);
        cmd.Parameters.AddWithValue("@lockoutEnd", lockoutEnd);
        cmd.Parameters.AddWithValue("@lockoutEnabled", lockoutEnabled);
        cmd.Parameters.AddWithValue("@agent", (object?)agentId ?? DBNull.Value);
        cmd.Parameters.AddWithValue("@role", role);
        await cmd.ExecuteNonQueryAsync(ct);
    }

    private static async Task<Dictionary<string, int>> LoadAgentByDescriptionAsync(
        SqlConnection legacy, CancellationToken ct)
    {
        var map = new Dictionary<string, int>(StringComparer.OrdinalIgnoreCase);
        await using var cmd = legacy.CreateCommand();
        cmd.CommandText = "SELECT [Description], [agentsID] FROM [agents] WHERE [Description] IS NOT NULL";
        await using var r = await cmd.ExecuteReaderAsync(ct);
        while (await r.ReadAsync(ct))
            map.TryAdd(r.GetString(0).Trim(), r.GetInt32(1));
        return map;
    }

    private static async IAsyncEnumerable<(string? UserName, string? Email, int? AgentId, bool Inactive)> ReadAgentsAsync(
        SqlConnection legacy, [System.Runtime.CompilerServices.EnumeratorCancellation] CancellationToken ct)
    {
        await using var cmd = legacy.CreateCommand();
        cmd.CommandText = "SELECT [Description], [Emailid], [agentsID], [active] FROM [agents] ORDER BY [agentsID]";
        await using var r = await cmd.ExecuteReaderAsync(ct);
        while (await r.ReadAsync(ct))
        {
            var name = r.IsDBNull(0) ? null : r.GetString(0);
            var email = r.IsDBNull(1) ? null : r.GetString(1);
            int? agentId = r.IsDBNull(2) ? (int?)null : r.GetInt32(2);
            var inactive = IdentityActive.IsInactive(r.IsDBNull(3) ? null : r.GetString(3));
            yield return (name, email, agentId, inactive);
        }
    }

    private static async IAsyncEnumerable<(string? UserName, string? Email, string? Password, bool Inactive)> ReadRegistrationAsync(
        SqlConnection legacy, [System.Runtime.CompilerServices.EnumeratorCancellation] CancellationToken ct)
    {
        await using var cmd = legacy.CreateCommand();
        cmd.CommandText = "SELECT [uid], [emailid], [pwd], [active] FROM [registration] ORDER BY [registID]";
        await using var r = await cmd.ExecuteReaderAsync(ct);
        while (await r.ReadAsync(ct))
        {
            var name = r.IsDBNull(0) ? null : r.GetString(0);
            var email = r.IsDBNull(1) ? null : r.GetString(1);
            var pwd = r.IsDBNull(2) ? null : r.GetString(2);
            var inactive = IdentityActive.IsInactive(r.IsDBNull(3) ? null : r.GetString(3));
            yield return (name, email, pwd, inactive);
        }
    }

    private static async IAsyncEnumerable<(string? UserName, string? Email, string? Password, string Role, int? UdaanId, bool Inactive)> ReadUdaanUsersAsync(
        SqlConnection legacy, [System.Runtime.CompilerServices.EnumeratorCancellation] CancellationToken ct)
    {
        await using var cmd = legacy.CreateCommand();
        cmd.CommandText = """
            SELECT [username], [emailid], [Password], [privilege], [active]
              FROM [Udaan_users]
             ORDER BY [username]
            """;
        await using var r = await cmd.ExecuteReaderAsync(ct);
        while (await r.ReadAsync(ct))
        {
            var name = r.IsDBNull(0) ? null : r.GetString(0);
            var email = r.IsDBNull(1) ? null : r.GetString(1);
            var pwd = r.IsDBNull(2) ? null : r.GetString(2);
            var privilege = r.IsDBNull(3) ? "emp" : r.GetString(3).Trim();
            var role = privilege.ToLowerInvariant() switch
            {
                "su" => IdentityIntegration.Roles.SuperUser,
                "adm" or "admin" => IdentityIntegration.Roles.Admin,
                "agt" => IdentityIntegration.Roles.Agent,
                _ => IdentityIntegration.Roles.Employee
            };
            var inactive = IdentityActive.IsInactive(r.IsDBNull(4) ? null : r.GetString(4));
            yield return (name, email, pwd, role, null, inactive);
        }
    }
}
