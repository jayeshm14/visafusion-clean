using Microsoft.EntityFrameworkCore;
using VisaFusion.Core.Application;
using VisaFusion.Data.Application;
using VisaFusion.Data.Persistence;
using VisaFusion.Data.Persistence.Entities;

namespace VisaFusion.UnitTests;

/// <summary>
/// Create/update audit-row unit tests (SPEC-0006 §19, T040): the service
/// writes one <see cref="EntryAuditLog"/> (bighistory) row per successful
/// create/update, mirroring the legacy inserts at insertEntry.asp:233 and
/// editEntrySubmit.asp:189.
///
/// Exercises the real <see cref="EntryService"/> (VisaFusion.Data) over a
/// hermetic EF InMemory <see cref="VisaEntryDbContext"/>:
///   - create writes Refno, Agent = null (the modern create contract carries no
///     agent), Date, UpdatedBy = {role}:{username}, Remarks = the request remark,
///   - UpdatedBy role precedence is su &gt; adm &gt; emp &gt; agt (GR-0004,
///     script 08) — the highest-precedence effective role is attributed,
///   - update writes Agent = the entry's owning agent (never changed by this
///     endpoint) and Remarks = the update request's external remark (the modern
///     contract has no internal-remark field; deviation log T040),
///   - an actor that cannot be resolved (blank username, or no role claims)
///     is rejected with EntryValidationException and nothing is persisted.
/// </summary>
public class EntryAuditTests
{
    [Fact]
    public async Task Create_Writes_Audit_Row_With_Null_Agent_And_Request_Remark()
    {
        var (service, databaseName) = NewService();

        var result = await service.CreateAsync(7, ValidCommand("initial remark"), TestActor);

        Assert.Equal(7, result.Refno);
        await using var db = NewContext(databaseName);
        var audit = Assert.Single(await db.EntryAuditLogs.ToListAsync());
        Assert.Equal(7, audit.Refno);
        Assert.Null(audit.Agent);
        Assert.Equal("emp:tester", audit.UpdatedBy);
        Assert.Equal("initial remark", audit.Remarks);
        // Date is stamped at write time (legacy insertEntry.asp:233 passes now()).
        Assert.NotNull(audit.Date);
        Assert.True(audit.Date > DateTime.Now.AddMinutes(-1) && audit.Date <= DateTime.Now.AddSeconds(1),
            "audit Date should be stamped at create time");
    }

    [Fact]
    public async Task Create_Audit_UpdatedBy_Composes_Highest_Precedence_Role()
    {
        // GR-0004 (script 08): role precedence su > adm > emp > agt — the
        // highest-precedence effective role is attributed in UpdatedBy.
        var (service, databaseName) = NewService();

        await service.CreateAsync(1, ValidCommand(null), new EntryActor("sara", new[] { "agt", "emp" }));
        await service.CreateAsync(2, ValidCommand(null), new EntryActor("mina", new[] { "emp", "adm" }));
        await service.CreateAsync(3, ValidCommand(null), new EntryActor("reza", new[] { "adm", "su" }));

        var audits = await ReadAuditRows(databaseName);
        Assert.Equal(3, audits.Count);
        Assert.Equal("emp:sara", audits[0].UpdatedBy);
        Assert.Equal("adm:mina", audits[1].UpdatedBy);
        Assert.Equal("su:reza", audits[2].UpdatedBy);
    }

    [Fact]
    public async Task Update_Writes_Audit_Row_With_Entry_Agent_And_Request_Remark()
    {
        var (createService, databaseName) = NewService();
        await createService.CreateAsync(7, ValidCommand("created"), TestActor);

        // The owning agent is never set by the create/update endpoints; mutate
        // the stored row directly (pattern of EntryAggregateTests' free-form
        // status test) to prove update audits carry the entry's agent verbatim.
        // RowVersion is also seeded here: the EF InMemory provider does not
        // generate rowversion values (EntryAggregateTests note), and UpdateAsync
        // now compares the caller's token against the stored one (AC-011, T040).
        var storedRowVersion = new byte[] { 1, 2, 3, 4, 5, 6, 7, 8 };
        await using (var db = NewContext(databaseName))
        {
            var entry = await db.Entries.SingleAsync(e => e.Refno == 7);
            entry.Agent = 42;
            entry.RowVersion = storedRowVersion;
            await db.SaveChangesAsync();
        }

        // Update through a FRESH service context: the create service's context
        // still tracks the pre-mutation instance (InMemory returns tracked
        // entities without refreshing), while a new context loads the stored
        // Agent = 42 row — the same visibility the API has on a new request.
        var updateService = new EntryService(NewContext(databaseName));
        var result = await updateService.UpdateAsync(
            7, ValidCommand("updated remark"), storedRowVersion, TestActor);

        Assert.Equal(7, result.Refno);
        var audits = await ReadAuditRows(databaseName);
        Assert.Equal(2, audits.Count); // one create + one update
        var updateAudit = audits[1];
        Assert.Equal(7, updateAudit.Refno);
        Assert.Equal(42, updateAudit.Agent);
        Assert.Equal("emp:tester", updateAudit.UpdatedBy);
        Assert.Equal("updated remark", updateAudit.Remarks);
    }

    [Fact]
    public async Task Unattributed_Actor_Is_Rejected_And_Nothing_Is_Persisted()
    {
        var (service, databaseName) = NewService();

        var blankName = await Assert.ThrowsAsync<EntryValidationException>(() =>
            service.CreateAsync(1, ValidCommand(null), new EntryActor("", new[] { "emp" })));
        Assert.Contains("actor", blankName.Message, StringComparison.OrdinalIgnoreCase);

        var noRoles = await Assert.ThrowsAsync<EntryValidationException>(() =>
            service.CreateAsync(2, ValidCommand(null), new EntryActor("tester", Array.Empty<string>())));
        Assert.Contains("actor", noRoles.Message, StringComparison.OrdinalIgnoreCase);

        await using var db = NewContext(databaseName);
        Assert.Empty(await db.Entries.ToListAsync());
        Assert.Empty(await db.EntryAuditLogs.ToListAsync());
    }

    private static CreateEntryCommand ValidCommand(string? remarks) => new(
        Paxname: "John", Passportno: "P123", DateOfBirth: new DateTime(1990, 1, 1),
        Category: 1, TotalPassengers: 1, TravelDate: new DateTime(2026, 9, 1),
        Remarks: remarks, AgentInstruction: null);

    /// <summary>
    /// The acting user for the audit rows (SPEC-0006 §19, T040): an employee,
    /// so the composed <c>UpdatedBy</c> is <c>emp:tester</c>.
    /// </summary>
    private static readonly EntryActor TestActor = new("tester", new[] { "emp" });

    private static (EntryService Service, string DatabaseName) NewService()
    {
        var databaseName = $"entry-audit-{Guid.NewGuid():N}";
        return (new EntryService(NewContext(databaseName)), databaseName);
    }

    private static VisaEntryDbContext NewContext(string databaseName)
    {
        var options = new DbContextOptionsBuilder<VisaEntryDbContext>()
            .UseInMemoryDatabase(databaseName)
            .Options;
        return new VisaEntryDbContext(options);
    }

    private static async Task<List<EntryAuditLog>> ReadAuditRows(string databaseName)
    {
        await using var db = NewContext(databaseName);
        return await db.EntryAuditLogs
            .OrderBy(a => a.Id)
            .ToListAsync();
    }
}
