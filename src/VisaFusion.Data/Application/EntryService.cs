using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using VisaFusion.Core.Application;
using VisaFusion.Data.Persistence;
using VisaFusion.Data.Persistence.Entities;

namespace VisaFusion.Data.Application;

/// <summary>
/// Entry-aggregate service (SPEC-0006 T009/T014/T017, US1/US2/US3, FR-001..FR-005,
/// BR-001/BR-002/BR-005, AC-002/AC-003/AC-004).
///
/// Placed in VisaFusion.Data (approved deviation, deviation log §5): the
/// interface is the shared Core rule, but the implementation queries
/// <c>VisaEntryDbContext</c> and calls the owner-supplied stored procedures,
/// which Core cannot reference (one-way Data → Core). Exact mirror of the
/// <c>SecurityGateService</c> precedent.
///
/// All SQL is parameterized (NFR-003) — stored procedures are invoked via
/// <see cref="SqlCommand"/> with <see cref="System.Data.CommandType.StoredProcedure"/>
/// and typed parameters; no string-concatenated SQL.
/// </summary>
public sealed class EntryService : IEntryService
{
    private readonly VisaEntryDbContext _db;

    public EntryService(VisaEntryDbContext db) => _db = db;

    public async Task<CreateEntryResult> CreateAsync(
        int refno, CreateEntryCommand command, EntryActor actor, CancellationToken ct = default)
    {
        // ≥ 1-passenger invariant (BR-005): the principal passenger is carried
        // at the entry level (legacy insertEntry.asp writes paxname/passportno
        // on the Mainentry row). A missing name or passport means no passenger.
        if (string.IsNullOrWhiteSpace(command.Paxname)
            || string.IsNullOrWhiteSpace(command.Passportno))
        {
            throw new EntryValidationException(
                "An entry must have at least one passenger with a name and passport number.");
        }

        // Valid refno (BR-001): the reference number is the business key and
        // must be positive.
        if (refno <= 0)
        {
            throw new EntryValidationException("refno must be a positive integer.");
        }

        // Duplicate refno → conflict (contracts/entries-api.md §1, 409).
        if (await _db.Entries.AnyAsync(e => e.Refno == refno, ct))
        {
            throw new EntryConflictException($"An entry with refno {refno} already exists.");
        }

        var entry = new Entry
        {
            Refno = refno,
            Paxname = command.Paxname,
            Passportno = command.Passportno,
            Dateofbirth = command.DateOfBirth,
            Category = command.Category,
            Totalpassengers = command.TotalPassengers,
            Traveldate = command.TravelDate,
            Externalremark = command.Remarks,
            AgentInstruction = command.AgentInstruction,
            // Status is free-form per legacy (clarification Q3): no status is
            // set on create; any status code is writable at any time.
        };

        // The principal passenger is materialized as the aggregate's child
        // (entryDetails row, refno FK) — BR-005.
        var passenger = new EntryPassenger
        {
            Refno = refno,
            Paxname = command.Paxname,
            Passportno = command.Passportno,
            DateOfBirth = command.DateOfBirth,
            Category = command.Category,
            Totalpax = command.TotalPassengers,
        };

        // Create-audit bighistory row (SPEC-0006 §19, T040; legacy
        // insertEntry.asp:233): refno, agent, timestamp, updatedby, remark.
        // The ratified create contract (contracts/entries-api.md §1) carries no
        // agent field, so the entry — and therefore its audit row — has no
        // owning agent on create (legacy read the agent from the form). The
        // remark is the external remark, exactly as legacy mapped
        // request("retrieveremark") → externalremark (insertEntry.asp:141/231).
        // Written in the SAME commit as the entry so a failed create never
        // leaves an entry without its audit row.
        _db.EntryAuditLogs.Add(new EntryAuditLog
        {
            Refno = refno,
            Agent = null,
            Date = DateTime.Now,
            UpdatedBy = ComposeUpdatedBy(actor),
            Remarks = command.Remarks,
        });

        _db.Entries.Add(entry);
        _db.EntryPassengers.Add(passenger);
        await _db.SaveChangesAsync(ct);

        var aggregate = await GetByRefnoAsync(refno, ct)
            ?? throw new EntryNotFoundException($"Entry {refno} was not found after create.");

        return new CreateEntryResult(refno, aggregate.RowVersion, aggregate);
    }

    public async Task<EntryAggregate?> GetByRefnoAsync(int refno, CancellationToken ct = default)
    {
        var entry = await _db.Entries
            .AsNoTracking()
            .SingleOrDefaultAsync(e => e.Refno == refno, ct);
        if (entry is null)
        {
            return null;
        }

        var passengers = await _db.EntryPassengers
            .AsNoTracking()
            .Where(p => p.Refno == refno)
            .OrderBy(p => p.Id)
            .ToListAsync(ct);

        var paxStatuses = await _db.PaxCountryStatuses
            .AsNoTracking()
            .Where(p => p.Refno == refno)
            .OrderBy(p => p.Id)
            .ToListAsync(ct);

        return new EntryAggregate(
            entry.Refno!.Value,
            entry.Paxname,
            entry.Passportno,
            entry.Agent,
            entry.Status,
            entry.Traveldate,
            entry.Subdate,
            entry.Coldate,
            entry.Receivedate,
            entry.SentDate,
            entry.Totalpassengers,
            passengers.Select(p => new EntryPassengerData(
                p.Id, p.Paxname, p.Passportno, p.DateOfBirth, p.Category)).ToList(),
            paxStatuses.Select(p => new PaxStatusData(
                p.PaxId, p.CountryId, p.StatusId, p.Remarks,
                p.Visafee, p.Handlingfee, p.Ddcharges, p.Couriercharges,
                p.Misccharges, p.Total, p.VFSTTCharges)).ToList(),
            entry.RowVersion);
    }

    public async Task<CreateEntryResult> UpdateAsync(
        int refno, CreateEntryCommand command, byte[] expectedRowVersion,
        EntryActor actor, CancellationToken ct = default)
    {
        // Same ≥ 1-passenger invariant as create (BR-005).
        if (string.IsNullOrWhiteSpace(command.Paxname)
            || string.IsNullOrWhiteSpace(command.Passportno))
        {
            throw new EntryValidationException(
                "An entry must have at least one passenger with a name and passport number.");
        }

        var entry = await _db.Entries.SingleOrDefaultAsync(e => e.Refno == refno, ct);
        if (entry is null)
        {
            throw new EntryNotFoundException($"Entry {refno} was not found.");
        }

        // Optimistic concurrency (AC-011): the caller's If-Match ETag is the
        // expected rowversion. The check is performed EXPLICITLY against the
        // freshly-loaded value — assigning expectedRowVersion to the tracked
        // entity would not work: EF Core's UPDATE WHERE clause uses the token's
        // ORIGINAL (as-loaded) value, so overwriting it makes the check compare
        // the current rowversion against itself and always succeed (surfaced by
        // EntryAuditIntegrationTests, T040; see deviation log). A stale write
        // is rejected here, BEFORE any mutation — no audit row is written.
        if (expectedRowVersion is null
            || entry.RowVersion is null
            || !expectedRowVersion.SequenceEqual(entry.RowVersion))
        {
            throw new EntryConflictException(
                $"Entry {refno} was modified by another request; the If-Match ETag is stale.");
        }

        entry.Paxname = command.Paxname;
        entry.Passportno = command.Passportno;
        entry.Dateofbirth = command.DateOfBirth;
        entry.Category = command.Category;
        entry.Totalpassengers = command.TotalPassengers;
        entry.Traveldate = command.TravelDate;
        entry.Externalremark = command.Remarks;
        entry.AgentInstruction = command.AgentInstruction;

        // Update-audit bighistory row (SPEC-0006 §19 subject/endpoint/outcome,
        // T040; legacy editEntrySubmit.asp:189): refno, agent (the entry's
        // owning agent — never changed by this endpoint), timestamp, updatedby,
        // remark. The PUT contract (contracts/entries-api.md §3) carries no
        // internal-remark field, so the remark is the request's external remark
        // — the closest available value to the legacy `internalrem` (see
        // deviation log T040). Written in the SAME commit as the update: a
        // stale write (409) rolls the audit row back too — no audit row is
        // written for a rejected write.
        _db.EntryAuditLogs.Add(new EntryAuditLog
        {
            Refno = refno,
            Agent = entry.Agent,
            Date = DateTime.Now,
            UpdatedBy = ComposeUpdatedBy(actor),
            Remarks = command.Remarks,
        });

        try
        {
            await _db.SaveChangesAsync(ct);
        }
        catch (DbUpdateConcurrencyException)
        {
            throw new EntryConflictException(
                $"Entry {refno} was modified by another request; the If-Match ETag is stale.");
        }

        var aggregate = await GetByRefnoAsync(refno, ct)
            ?? throw new EntryNotFoundException($"Entry {refno} was not found after update.");

        return new CreateEntryResult(refno, aggregate.RowVersion, aggregate);
    }

    public async Task<int> AllocateRefnoAsync(CancellationToken ct = default)
    {
        // usp_AllocateNextRefno (script 01) returns @NewRefno BIGINT OUTPUT.
        // The proc is owner-supplied and applied verbatim (GR-0001); the result
        // is converted to int for Entry.Refno (data-model.md §2; deviation log §2).
        var connection = _db.Database.GetDbConnection();
        await using var cmd = connection.CreateCommand();
        cmd.CommandType = System.Data.CommandType.StoredProcedure;
        cmd.CommandText = "dbo.usp_AllocateNextRefno";

        var newRefno = cmd.CreateParameter();
        newRefno.ParameterName = "@NewRefno";
        newRefno.DbType = System.Data.DbType.Int64;
        newRefno.Direction = System.Data.ParameterDirection.Output;
        cmd.Parameters.Add(newRefno);

        await connection.OpenAsync(ct);
        try
        {
            await cmd.ExecuteNonQueryAsync(ct);
        }
        finally
        {
            await connection.CloseAsync();
        }

        var value = newRefno.Value;
        if (value is null || value is DBNull)
        {
            throw new EntryValidationException("usp_AllocateNextRefno returned no value.");
        }

        var big = Convert.ToInt64(value, System.Globalization.CultureInfo.InvariantCulture);
        if (big > int.MaxValue)
        {
            throw new EntryValidationException(
                $"Allocated refno {big} exceeds the int range of Entry.Refno.");
        }

        return (int)big;
    }

    public async Task<StatusChangeResult> RecordStatusChangeAsync(
        RecordStatusChangeCommand command, CancellationToken ct = default)
    {
        // Up-front validation (anti-spoofing GR-0004): the actor id is the
        // authenticated caller's AspNetUsers.Id, resolved server-side from the
        // JWT sub claim — never a caller-supplied or formatted actor string.
        // A missing actor is rejected before any proc call.
        if (string.IsNullOrWhiteSpace(command.ActorUserId))
        {
            throw new EntryValidationException(
                "ActorUserId is required and must be the authenticated caller's user id.");
        }

        // Valid keys (BR-001/BR-002): refno, pax id, country id and status id
        // are positive business keys.
        if (command.Refno <= 0 || command.PaxId <= 0 || command.CountryId <= 0 || command.NewStatusId <= 0)
        {
            throw new EntryValidationException(
                "refno, PaxId, CountryId and NewStatusId must be positive integers.");
        }

        // usp_RecordEntryStatusChange (script 08 — final, supersedes 06/07 per
        // GR-0004). @ActorUserId is the authenticated caller's AspNetUsers.Id
        // (resolved server-side from the JWT sub claim — never a formatted
        // actor string, anti-spoofing GR-0004). The proc atomically updates
        // PaxStatus.statusID and writes StatusHistory + bighistory in one
        // transaction (AC-004).
        var connection = _db.Database.GetDbConnection();
        await using var cmd = connection.CreateCommand();
        cmd.CommandType = System.Data.CommandType.StoredProcedure;
        cmd.CommandText = "dbo.usp_RecordEntryStatusChange";

        cmd.Parameters.Add(Param("@Refno", System.Data.DbType.Int64, (long)command.Refno));
        cmd.Parameters.Add(Param("@PaxID", System.Data.DbType.Int64, (long)command.PaxId));
        cmd.Parameters.Add(Param("@CountryId", System.Data.DbType.Int32, command.CountryId));
        cmd.Parameters.Add(Param("@NewStatusId", System.Data.DbType.Int32, command.NewStatusId));
        cmd.Parameters.Add(Param("@ActorUserId", System.Data.DbType.String, command.ActorUserId));
        cmd.Parameters.Add(Param("@Remarks", System.Data.DbType.String,
            (object?)command.Remarks ?? DBNull.Value));
        cmd.Parameters.Add(Param("@ChangeDate", System.Data.DbType.DateTime,
            (object?)command.ChangeDate ?? DBNull.Value));

        var newStatusHistoryId = cmd.CreateParameter();
        newStatusHistoryId.ParameterName = "@NewStatusHistoryId";
        newStatusHistoryId.DbType = System.Data.DbType.Int64;
        newStatusHistoryId.Direction = System.Data.ParameterDirection.Output;
        cmd.Parameters.Add(newStatusHistoryId);

        await connection.OpenAsync(ct);
        try
        {
            await cmd.ExecuteNonQueryAsync(ct);
        }
        catch (SqlException ex)
        {
            // The proc raises RAISERROR (severity 16) for its three rejection
            // paths (script 08:49-107). Translate to the typed exceptions the
            // API layer maps to problem-details responses (contracts/entries-api.md
            // §4): unknown refno → 404; unknown status / no PaxStatus row → 400.
            var message = ex.Message;
            if (message.Contains("refno", StringComparison.OrdinalIgnoreCase)
                && message.Contains("not found", StringComparison.OrdinalIgnoreCase))
            {
                throw new EntryNotFoundException(
                    $"Entry {command.Refno} was not found.");
            }

            if (message.Contains("StatusID", StringComparison.OrdinalIgnoreCase)
                && message.Contains("not found", StringComparison.OrdinalIgnoreCase))
            {
                throw new EntryValidationException(
                    $"Status id {command.NewStatusId} does not exist.");
            }

            if (message.Contains("no PaxStatus row", StringComparison.OrdinalIgnoreCase))
            {
                throw new EntryValidationException(
                    $"No PaxStatus row exists for refno {command.Refno} / PaxID {command.PaxId} / CountryID {command.CountryId}.");
            }

            throw;
        }
        finally
        {
            await connection.CloseAsync();
        }

        var historyId = newStatusHistoryId.Value;
        if (historyId is null || historyId is DBNull)
        {
            throw new EntryValidationException(
                "usp_RecordEntryStatusChange returned no StatusHistory id.");
        }

        // The proc composes UpdatedBy = {role}:{username} (GR-0004); the service
        // returns the id and the actor string for the API response. The actor
        // string is read back from the StatusHistory row the proc just wrote.
        var updatedBy = await _db.StatusHistory
            .AsNoTracking()
            .Where(s => s.Id == Convert.ToInt64(historyId, System.Globalization.CultureInfo.InvariantCulture))
            .Select(s => s.UpdatedBy)
            .SingleOrDefaultAsync(ct);

        return new StatusChangeResult(
            Convert.ToInt64(historyId, System.Globalization.CultureInfo.InvariantCulture),
            updatedBy ?? string.Empty);
    }

    public async Task RecordAwbAsync(int refno, RecordAwbCommand command, CancellationToken ct = default)
    {
        // Legacy guard (sendawbgo.asp:24): an empty awb is a validation failure.
        if (string.IsNullOrWhiteSpace(command.Awb))
        {
            throw new EntryValidationException("awb is required.");
        }

        // The owning agent id is resolved from the entry aggregate — never from
        // the request (the legacy page read request("agent"); the API contract
        // §5 carries no agent field, so the entry's own agent is authoritative).
        var entry = await _db.Entries
            .AsNoTracking()
            .SingleOrDefaultAsync(e => e.Refno == refno, ct);
        if (entry is null)
        {
            throw new EntryNotFoundException($"Entry {refno} was not found.");
        }

        // sentawb.agentsid is NOT NULL — an entry without an owning agent cannot
        // be attributed, so the AWB event is refused rather than written with a
        // fabricated 0 (the legacy flow always had an agent on this page).
        if (!entry.Agent.HasValue)
        {
            throw new EntryValidationException(
                $"Entry {refno} has no owning agent; the AWB event cannot be attributed.");
        }

        // Legacy dedupe (sendawbgo.asp:65-71): a duplicate (agentsid, awb) pair
        // is a no-op — the AWB was already recorded.
        var duplicate = await _db.AwbLogs.AnyAsync(
            a => a.Agentsid == entry.Agent && a.Awb == command.Awb, ct);
        if (duplicate)
        {
            return;
        }

        _db.AwbLogs.Add(new AwbLog
        {
            Agentsid = entry.Agent.Value,
            Date = DateTime.Now,
            Toemail = command.ToEmail,
            Remark = command.Remark,
            Awb = command.Awb,
        });
        await _db.SaveChangesAsync(ct);
    }

    /// <summary>
    /// Composes the bighistory <c>UpdatedBy</c> value <c>{role}:{username}</c>
    /// for the service-written create/update audit rows (SPEC-0006 §19, T040).
    /// The actor is resolved server-side from the JWT claims by the API layer —
    /// never a caller-supplied formatted string (anti-spoofing, GR-0004). The
    /// role is the HIGHEST-privilege effective role (su &gt; adm &gt; emp &gt;
    /// agt), the same precedence as <c>usp_RecordEntryStatusChange</c>
    /// (script 08:70-89), so the format is indistinguishable from proc-written
    /// rows. Throws when the actor cannot be resolved — an unattributed audit
    /// row is refused (mirrors the proc's RAISERROR for a user with no role).
    /// </summary>
    private static string ComposeUpdatedBy(EntryActor actor)
    {
        var role = actor.EffectiveRoles
            .OrderBy(r => (r ?? string.Empty).ToLowerInvariant() switch
            {
                "su" => 1,
                "adm" => 2,
                "emp" => 3,
                "agt" => 4,
                _ => 5,
            })
            .FirstOrDefault();

        if (string.IsNullOrWhiteSpace(actor.UserName) || role is null)
        {
            throw new EntryValidationException(
                "The authenticated actor could not be resolved; the audit row cannot be attributed.");
        }

        return $"{role}:{actor.UserName}";
    }

    private static SqlParameter Param(string name, System.Data.DbType type, object value)
    {
        var p = new SqlParameter(name, type) { Value = value };
        return p;
    }
}