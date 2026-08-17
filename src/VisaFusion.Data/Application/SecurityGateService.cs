using Microsoft.EntityFrameworkCore;
using VisaFusion.Core.Application;
using VisaFusion.Data.Persistence;
using VisaFusion.Data.Persistence.Entities;

namespace VisaFusion.Data.Application;

/// <summary>
/// Day-gate evaluation over the legacy `security` table (SPEC-0005 T018,
/// FR-018; data-model.md §2.1). Read-only (constitution Principle III): the
/// gate only queries <see cref="SecurityDay"/> via
/// <see cref="VisaEntryDbContext"/> — it never writes.
///
/// SPEC-0007 (FR-008, BR-003, CHK022) adds the write side: open/close/today
/// back the `adm`/`su`-only surface (legacy `openForDay.asp`/`closeForDay.asp`
/// were anonymous — deepanalysis §2.4 findings 10-11). Open is atomic per date
/// via the unique `date1` index: concurrent opens resolve to a single winner,
/// the loser gets <see cref="SecurityDayOpenResult.AlreadyOpen"/>.
///
/// Placed in VisaFusion.Data (approved deviation, deviation log §5): the
/// interface is the shared Core rule, but the query needs VisaEntryDbContext,
/// which Core cannot reference (one-way Data → Core).
/// </summary>
public sealed class SecurityGateService : ISecurityGateService
{
    // "emp" is carried over verbatim from `Udaan_users.privilege`. The literal
    // is duplicated here because VisaFusion.Data cannot reference
    // VisaFusion.Identity (Identity → Data is one-way; a reverse reference
    // would be a cycle) — `IdentityIntegration.Roles.Employee` is the canonical
    // definition.
    private const string EmployeeRole = "emp";

    private readonly VisaEntryDbContext _db;

    public SecurityGateService(VisaEntryDbContext db) => _db = db;

    public async Task<SecurityGateDecision> EvaluateAsync(IEnumerable<string> roles, DateTime date)
    {
        // The gate applies to emp logins only (authenticate.asp lines 62–79).
        if (roles?.Contains(EmployeeRole, StringComparer.OrdinalIgnoreCase) != true)
        {
            return SecurityGateDecision.Allowed;
        }

        // Legacy query (authenticate.asp line 68): a row for today where
        // `closingtime is null`. Rows with a closing time set are excluded by
        // the WHERE clause, so a closed row yields the same rejection (rsn=O)
        // as no row at all — rsn=C is never produced (AC-011/TS-013).
        var openDay = await _db.SecurityDays.AnyAsync(s =>
            s.Date1 != null
            && s.Date1.Value.Year == date.Year
            && s.Date1.Value.Month == date.Month
            && s.Date1.Value.Day == date.Day
            && s.Closingtime == null);

        return openDay ? SecurityGateDecision.Allowed : SecurityGateDecision.RejectedNotOpened;
    }

    public async Task<SecurityDayOpenResult> OpenDayAsync(DateTime date, string openedBy)
    {
        // Already-open check (contracts/admin-api.md §1): a row for the date
        // with closingtime IS NULL means the day is open → 409.
        var alreadyOpen = await _db.SecurityDays.AnyAsync(s =>
            s.Date1 != null
            && s.Date1.Value.Year == date.Year
            && s.Date1.Value.Month == date.Month
            && s.Date1.Value.Day == date.Day
            && s.Closingtime == null);

        if (alreadyOpen)
        {
            return SecurityDayOpenResult.AlreadyOpen;
        }

        _db.SecurityDays.Add(new SecurityDay
        {
            Date1 = date.Date,
            Openingtime = DateTime.Now,
            Openby = openedBy,
        });

        // Security-day open audit event (SPEC-0007 §19), written in the SAME
        // commit as the open row: a failed open never leaves an audit gap.
        _db.AdminAuditLogs.Add(new AdminAuditLog
        {
            EventType = "SecurityDayOpened",
            ActorUserId = string.Empty,
            ActorUserName = openedBy,
            Date = DateTime.Now,
            Detail = date.Date.ToString("yyyy-MM-dd", System.Globalization.CultureInfo.InvariantCulture),
        });

        try
        {
            await _db.SaveChangesAsync();
        }
        catch (DbUpdateException)
        {
            // Unique date1 index (CHK022): a concurrent open won the race —
            // the loser maps to 409, never a partial state.
            return SecurityDayOpenResult.AlreadyOpen;
        }

        return SecurityDayOpenResult.Opened;
    }

    public async Task<SecurityDayCloseResult> CloseDayAsync(DateTime date, string closedBy)
    {
        // The open row for the date (contracts/admin-api.md §2): closingtime
        // IS NULL. No such row → 404.
        var openRow = await _db.SecurityDays.FirstOrDefaultAsync(s =>
            s.Date1 != null
            && s.Date1.Value.Year == date.Year
            && s.Date1.Value.Month == date.Month
            && s.Date1.Value.Day == date.Day
            && s.Closingtime == null);

        if (openRow is null)
        {
            return SecurityDayCloseResult.NotFound;
        }

        openRow.Closingtime = DateTime.Now;
        openRow.Closedby = closedBy;

        // Security-day close audit event (SPEC-0007 §19), written in the SAME
        // commit as the close: a failed close never leaves an audit gap.
        _db.AdminAuditLogs.Add(new AdminAuditLog
        {
            EventType = "SecurityDayClosed",
            ActorUserId = string.Empty,
            ActorUserName = closedBy,
            Date = DateTime.Now,
            Detail = date.Date.ToString("yyyy-MM-dd", System.Globalization.CultureInfo.InvariantCulture),
        });

        await _db.SaveChangesAsync();

        return SecurityDayCloseResult.Closed;
    }

    public async Task<SecurityDayStatus?> GetTodayAsync(DateTime date)
    {
        var row = await _db.SecurityDays.FirstOrDefaultAsync(s =>
            s.Date1 != null
            && s.Date1.Value.Year == date.Year
            && s.Date1.Value.Month == date.Month
            && s.Date1.Value.Day == date.Day);

        return row is null
            ? null
            : new SecurityDayStatus(
                row.Date1!.Value,
                row.Openingtime,
                row.Openby,
                row.Closingtime,
                row.Closedby);
    }
}