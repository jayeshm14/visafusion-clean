using Microsoft.AspNetCore.Identity;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging.Abstractions;
using Microsoft.Extensions.Options;
using VisaFusion.Api.Application;
using VisaFusion.Core.Application;
using VisaFusion.Data.Persistence;
using VisaFusion.Data.Persistence.Entities;
using VisaFusion.Identity;
using VisaFusion.Identity.Persistence;

namespace VisaFusion.IntegrationTests;

/// <summary>
/// Agent portal integration tests (SPEC-0007 T028/T048, US4, FR-017..019,
/// FR-021, BR-007/BR-008, AC-012; contracts/agents-api.md §3/§3a/§4).
///
/// Exercises the REAL <see cref="AgentService"/> (VisaFusion.Api.Application)
/// over a real SQL Server — the same surface the production host resolves:
///   - entries list scoped to the agent's own <c>Mainentry</c> rows (FR-017),
///   - passenger statuses joined through <c>entryDetails</c>/<c>PaxStatus</c>
///     (FR-018),
///   - financial statement from the agent's <c>Ledger</c> rows with the
///     debit/credit/balance summary (FR-019, BR-008),
///   - the <c>?q=</c> keyword filter on entries and statuses (FR-021): paxname
///     substring or exact refno.
/// The HTTP-level scoping matrix (own vs other agent's {id} → 403, CHK026
/// unlinked agt → 403) is owned by the functional suite (the hermetic factory
/// mints the claim-bound tokens); this suite proves the data path the scoped
/// handlers serve. Test rows are deleted in a <c>finally</c> block (FK-safe
/// order: ledger, pax statuses, passengers, entries, audit, user roles, user,
/// agent, then the marker status row). Tests skip when SQL Server is
/// unreachable or the required tables do not exist (existing convention).
/// </summary>
public class AgentPortalIntegrationTests
{
    private const string DefaultTargetConnectionString =
        "Server=localhost;Database=VisaFusion;Trusted_Connection=True;TrustServerCertificate=True;MultipleActiveResultSets=true";

    private const string Password = "Str0ngPass!";

    private static string TargetConnectionString =>
        Environment.GetEnvironmentVariable("VISA_FUSION_TEST_CONNECTION") ?? DefaultTargetConnectionString;

    private static bool TargetReachable()
    {
        try
        {
            using var target = new SqlConnection(TargetConnectionString);
            target.Open();
            return true;
        }
        catch
        {
            return false;
        }
    }

    [Fact]
    public async Task Portal_Reads_Are_Scoped_To_The_Agents_Own_Data()
    {
        if (!TargetReachable()) return;

        await using var connection = new SqlConnection(TargetConnectionString);
        await connection.OpenAsync();
        if (!await TableExistsAsync(connection, "agents")) return;
        if (!await TableExistsAsync(connection, "Mainentry")) return;
        if (!await TableExistsAsync(connection, "entryDetails")) return;
        if (!await TableExistsAsync(connection, "PaxStatus")) return;
        if (!await TableExistsAsync(connection, "Ledger")) return;
        if (!await TableExistsAsync(connection, "status")) return;
        if (!await TableExistsAsync(connection, "AspNetUsers")) return;

        var marker = $"t028-{Guid.NewGuid():N}";
        var username = $"t028-agt-{Guid.NewGuid():N}";
        var actorUserId = $"u-{Guid.NewGuid():N}";
        var actorUserName = $"t028-admin-{Guid.NewGuid():N}";
        var agentId = 0;
        var userId = string.Empty;
        var statusId = 0;
        var refno = 0;

        try
        {
            var harness = new Harness(connection.ConnectionString);

            // ---- Seed: agent + linked agt login (BR-009) ----
            var agent = await harness.Service.CreateAsync(
                NewInput(marker), username, Password, actorUserId, actorUserName);
            agentId = agent.Id;
            var user = await harness.IdentityDb.Users.SingleAsync(u => u.UserName == username);
            userId = user.Id;

            // ---- Seed: a marker status lookup row (statusID natural key) ----
            var markerStatus = new Status
            {
                Description = "T028 Marker Status",
                Active = "Y",
            };
            harness.EntryDb.Statuses.Add(markerStatus);
            await harness.EntryDb.SaveChangesAsync();
            statusId = markerStatus.StatusId;

            // ---- Seed: two Mainentry rows owned by the agent (FR-017) ----
            refno = 900_000 + Random.Shared.Next(0, 99_999);
            var entry1 = new Entry
            {
                Refno = refno,
                Paxname = "T028 Pax Alpha",
                Agent = agentId,
                Traveldate = new DateTime(2026, 8, 1),
                Status = statusId,
                Subdate = new DateTime(2026, 7, 20),
            };
            var entry2 = new Entry
            {
                Refno = refno + 1,
                Paxname = "T028 Pax Beta",
                Agent = agentId,
                Traveldate = new DateTime(2026, 8, 2),
                Status = statusId,
                Subdate = new DateTime(2026, 7, 21),
            };
            harness.EntryDb.Entries.AddRange(entry1, entry2);
            await harness.EntryDb.SaveChangesAsync();

            // ---- Seed: one passenger + one PaxStatus row per entry (FR-018) ----
            var pax1 = new EntryPassenger { Refno = refno, Paxname = "T028 Pax Alpha" };
            var pax2 = new EntryPassenger { Refno = refno + 1, Paxname = "T028 Pax Beta" };
            harness.EntryDb.EntryPassengers.AddRange(pax1, pax2);
            await harness.EntryDb.SaveChangesAsync();

            harness.EntryDb.PaxCountryStatuses.AddRange(
                new PaxCountryStatus
                {
                    Refno = refno,
                    PaxId = pax1.Id,
                    CountryId = 1,
                    StatusId = statusId,
                    Subdate = new DateTime(2026, 7, 22),
                },
                new PaxCountryStatus
                {
                    Refno = refno + 1,
                    PaxId = pax2.Id,
                    CountryId = 2,
                    StatusId = statusId,
                    Subdate = new DateTime(2026, 7, 23),
                });
            await harness.EntryDb.SaveChangesAsync();

            // ---- Seed: two Ledger rows for the agent (FR-019) ----
            harness.EntryDb.LedgerHistory.AddRange(
                new LedgerHistory
                {
                    AgentId = agentId,
                    EntrydateTime = new DateTime(2026, 8, 1),
                    TransactionType = "SALES",
                    Bank = 1,
                    Refno = refno,
                    Paxname = "T028 Pax Alpha",
                    Reftype = "B",
                    Invno = 101,
                    Debit = 1000m,
                    Credit = null,
                    Balance = 1000m,
                },
                new LedgerHistory
                {
                    AgentId = agentId,
                    EntrydateTime = new DateTime(2026, 8, 2),
                    TransactionType = "RECEIPT",
                    Bank = 1,
                    Refno = refno,
                    Paxname = "T028 Pax Alpha",
                    Reftype = "P",
                    Invno = 201,
                    Debit = null,
                    Credit = 500m,
                    Balance = 500m,
                });
            await harness.EntryDb.SaveChangesAsync();

            // ---- Entries list (FR-017): scoped to the agent, status resolved ----
            var entries = await harness.Service.GetPortalEntriesAsync(
                agentId, page: 1, pageSize: 50, q: null);
            Assert.Equal(2, entries.Total);
            Assert.Contains(entries.Items, e => e.Refno == refno && e.Paxname == "T028 Pax Alpha");
            Assert.Contains(entries.Items, e => e.Refno == refno + 1 && e.Paxname == "T028 Pax Beta");
            Assert.All(entries.Items, e => Assert.Equal("T028 Marker Status", e.StatusDescription));

            // ---- ?q= keyword filter (FR-021): paxname substring ----
            var byPax = await harness.Service.GetPortalEntriesAsync(
                agentId, page: 1, pageSize: 50, q: "Alpha");
            Assert.Equal(1, byPax.Total);
            Assert.Equal(refno, byPax.Items[0].Refno);

            // ---- ?q= keyword filter (FR-021): exact refno ----
            var byRefno = await harness.Service.GetPortalEntriesAsync(
                agentId, page: 1, pageSize: 50, q: refno.ToString());
            Assert.Equal(1, byRefno.Total);
            Assert.Equal("T028 Pax Alpha", byRefno.Items[0].Paxname);

            // ---- Statuses (FR-018): joined through entryDetails/PaxStatus ----
            var statuses = await harness.Service.GetPortalStatusesAsync(agentId, q: null);
            Assert.Equal(2, statuses.Items.Count);
            Assert.Contains(statuses.Items, s => s.Refno == refno && s.Paxname == "T028 Pax Alpha");
            Assert.Contains(statuses.Items, s => s.Refno == refno + 1 && s.Paxname == "T028 Pax Beta");
            Assert.All(statuses.Items, s => Assert.Equal("T028 Marker Status", s.StatusDescription));
            Assert.All(statuses.Items, s => Assert.NotNull(s.Updated));

            // ---- Statuses ?q= filter (FR-021) ----
            var statusesByPax = await harness.Service.GetPortalStatusesAsync(agentId, q: "Beta");
            Assert.Single(statusesByPax.Items);
            Assert.Equal(refno + 1, statusesByPax.Items[0].Refno);

            // ---- Statement (FR-019, BR-008): ledger lines + summary ----
            var statement = await harness.Service.GetPortalStatementAsync(agentId);
            Assert.Equal(2, statement.Items.Count);
            Assert.Equal(1000m, statement.TotalDebits);
            Assert.Equal(500m, statement.TotalCredits);
            Assert.Equal(500m, statement.Balance); // running balance: last line
            Assert.Contains(statement.Items, l => l.Reftype == "B" && l.Invno == 101);
            Assert.Contains(statement.Items, l => l.Reftype == "P" && l.Invno == 201);

            // ---- Scoping: another agent's data is never returned ----
            var otherAgent = await harness.Service.CreateAsync(
                NewInput(marker + "-other"), $"t028-other-{Guid.NewGuid():N}",
                Password, actorUserId, actorUserName);
            var otherEntries = await harness.Service.GetPortalEntriesAsync(
                otherAgent.Id, page: 1, pageSize: 50, q: null);
            Assert.Equal(0, otherEntries.Total);
            var otherStatuses = await harness.Service.GetPortalStatusesAsync(otherAgent.Id, q: null);
            Assert.Empty(otherStatuses.Items);
            var otherStatement = await harness.Service.GetPortalStatementAsync(otherAgent.Id);
            Assert.Empty(otherStatement.Items);
        }
        finally
        {
            await CleanupAsync(connection, agentId, userId, actorUserName, statusId, refno);
        }
    }

    private static AgentInput NewInput(string companyname) => new(
        Companyname: companyname,
        Description: "t028 portal integration agent",
        Street1: "1 Test St",
        Street2: null,
        Area: "Downtown",
        City: "Mumbai",
        Pincode: "400001",
        Phoneno: "022-5555",
        Faxno: null,
        Emailid: null,
        Smsno: null,
        Directorname: "T028 Owner",
        DirectorPH: "9000000000",
        AcMgrPH: null,
        VisaInchargeName: null,
        VisaInchargePH: null,
        Acno: null,
        Payment: null,
        TAAI: null,
        TAFI: null,
        Membership: null,
        IATA: null);

    private static async Task<bool> TableExistsAsync(SqlConnection connection, string table)
    {
        await using var cmd = connection.CreateCommand();
        cmd.CommandText = "SELECT COUNT(*) FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = @table";
        cmd.Parameters.AddWithValue("@table", table);
        return Convert.ToInt32(await cmd.ExecuteScalarAsync()) > 0;
    }

    private static async Task CleanupAsync(
        SqlConnection connection, int agentId, string userId, string actorUserName,
        int statusId, int refno)
    {
        // Deletes only the rows this test created (marker agent / test user /
        // test entries / test status), never real data. FK-safe order: ledger,
        // pax statuses, passengers, entries, audit, user roles, user, agent,
        // then the marker status row.
        await using var cmd = connection.CreateCommand();
        cmd.CommandText = """
            DELETE FROM dbo.Ledger WHERE AgentId = @agentId;
            DELETE FROM dbo.PaxStatus WHERE Refno = @refno OR Refno = @refno + 1;
            DELETE FROM dbo.entryDetails WHERE Refno = @refno OR Refno = @refno + 1;
            DELETE FROM dbo.Mainentry WHERE Refno = @refno OR Refno = @refno + 1;
            DELETE FROM dbo.adminauditlog WHERE ActorUserName = @actor;
            DELETE FROM dbo.AspNetUserRoles WHERE UserId = @userId;
            DELETE FROM dbo.AspNetUsers WHERE Id = @userId;
            DELETE FROM dbo.agents WHERE agentsID = @agentId AND Enteredby = @actor;
            DELETE FROM dbo.status WHERE statusID = @statusId;
            """;
        cmd.Parameters.AddWithValue("@agentId", agentId);
        cmd.Parameters.AddWithValue("@userId", userId);
        cmd.Parameters.AddWithValue("@actor", actorUserName);
        cmd.Parameters.AddWithValue("@statusId", statusId);
        cmd.Parameters.AddWithValue("@refno", refno);
        await cmd.ExecuteNonQueryAsync();
    }

    private sealed class Harness
    {
        public Harness(string connectionString)
        {
            EntryDb = new VisaEntryDbContext(
                new DbContextOptionsBuilder<VisaEntryDbContext>()
                    .UseSqlServer(connectionString)
                    .Options);

            IdentityDb = new VisaFusionIdentityDbContext(
                new DbContextOptionsBuilder<VisaFusionIdentityDbContext>()
                    .UseSqlServer(connectionString)
                    .Options);

            UserManager = BuildUserManager(IdentityDb);
            Service = new AgentService(EntryDb, UserManager);
        }

        public VisaEntryDbContext EntryDb { get; }

        public VisaFusionIdentityDbContext IdentityDb { get; }

        public UserManager<IdentityIntegration.VisaFusionUser> UserManager { get; }

        public AgentService Service { get; }

        private static UserManager<IdentityIntegration.VisaFusionUser> BuildUserManager(
            VisaFusionIdentityDbContext db)
        {
            var store = new Microsoft.AspNetCore.Identity.EntityFrameworkCore
                .UserStore<IdentityIntegration.VisaFusionUser, IdentityRole,
                    VisaFusionIdentityDbContext, string>(db);
            return new UserManager<IdentityIntegration.VisaFusionUser>(
                store,
                Options.Create(new IdentityOptions()),
                new PasswordHasher<IdentityIntegration.VisaFusionUser>(),
                new[] { new UserValidator<IdentityIntegration.VisaFusionUser>() },
                new[] { new PasswordValidator<IdentityIntegration.VisaFusionUser>() },
                new UpperInvariantLookupNormalizer(),
                new IdentityErrorDescriber(),
                services: null!,
                new NullLogger<UserManager<IdentityIntegration.VisaFusionUser>>());
        }
    }
}