using Microsoft.EntityFrameworkCore;
using VisaFusion.Api.Contracts;
using VisaFusion.Data.Persistence;

namespace VisaFusion.Api.Endpoints;

/// <summary>
/// The seven operational report queries (SPEC-0008 T046, US6, FR-012, AC-008;
/// contracts/reports-api.md). Single source of truth for the report LINQ —
/// used by both <see cref="ReportsEndpoint"/> (API) and the Reporting Razor
/// pages so the API and UI can never diverge.
///
/// All data access is parameterized EF Core LINQ — no string-built SQL
/// (NFR-002; fixes the §6.6 SQLi finding). Every query has a fixed ORDER BY
/// for the same input range (NFR-006). The LINQ mirrors the legacy page
/// queries verbatim in shape: `pendinglist.asp`, `todaySubmission*.asp`,
/// `todayCollection*.asp`, `todayTransaction.asp`, `dailyVisaFee.asp`,
/// `dailybill.asp`, `todayAgentStatusalltemp.asp`.
/// </summary>
public static class ReportQueries
{
    /// <summary>
    /// Legacy <c>todayAgentStatusalltemp.asp</c>: per-pax-per-country status
    /// rows whose sent-back date is still open — <c>sentdate</c> is null or
    /// on/after the from-date (the legacy <c>sentdate &gt; stdate OR
    /// sentdate IS NULL</c> filter; <c>dateTo</c> bounds the sent-back date).
    /// <c>agentId</c> scopes to one agent (the legacy page looped per agent).
    /// Ordered by receivedate, refno (legacy).
    /// </summary>
    public static async Task<List<AgentStatusReportRow>> AgentStatusTodayAsync(
        VisaEntryDbContext db, ReportQueryParams p)
    {
        // Branching in C# on the captured p.To (null = open-ended) keeps the
        // EF translation a plain parameterized predicate — a runtime-null
        // captured value in the expression would break translation to SQL
        // (NFR-002). The where/orderby stay in query syntax so the nullable-FK
        // joins translate cleanly.
        if (p.To is { } to)
        {
            return await (
                from ps in db.PaxCountryStatuses.AsNoTracking()
                join ep in db.EntryPassengers.AsNoTracking() on ps.PaxId equals ep.Id
                join e in db.Entries.AsNoTracking() on ep.Refno equals e.Refno
                where (p.AgentId == null || e.Agent == p.AgentId)
                    && (ps.SentDate == null || (ps.SentDate >= p.From && ps.SentDate <= to))
                orderby e.Receivedate, e.Refno
                select new AgentStatusReportRow(
                    e.Refno, ps.PaxId, ep.Paxname, ps.Colcheck, ps.Coldate, ps.Subdate,
                    ps.CountryId, ps.StatusId, ps.Remarks, ps.SentDate, e.Receivedate,
                    e.Agent, e.Refferer, e.Companyname, e.Externalremark, e.Category,
                    e.AgentInstruction))
                .ToListAsync();
        }

        return await (
            from ps in db.PaxCountryStatuses.AsNoTracking()
            join ep in db.EntryPassengers.AsNoTracking() on ps.PaxId equals ep.Id
            join e in db.Entries.AsNoTracking() on ep.Refno equals e.Refno
            where (p.AgentId == null || e.Agent == p.AgentId)
                && (ps.SentDate == null || ps.SentDate >= p.From)
            orderby e.Receivedate, e.Refno
            select new AgentStatusReportRow(
                e.Refno, ps.PaxId, ep.Paxname, ps.Colcheck, ps.Coldate, ps.Subdate,
                ps.CountryId, ps.StatusId, ps.Remarks, ps.SentDate, e.Receivedate,
                e.Agent, e.Refferer, e.Companyname, e.Externalremark, e.Category,
                e.AgentInstruction))
            .ToListAsync();
    }

    /// <summary>
    /// Legacy <c>pendinglist.asp</c>: pax status rows in the pending band
    /// (statusid 401..409) with agent and country names resolved. Ordered by
    /// country id then refno (legacy <c>order by paxstatus.countryid</c> plus a
    /// deterministic tiebreaker — NFR-006).
    /// </summary>
    public static async Task<List<PendingReportRow>> PendingAsync(
        VisaEntryDbContext db, ReportQueryParams p)
    {
        _ = p; // the pending list is a snapshot, not a date range (legacy)
        return await (
            from ps in db.PaxCountryStatuses.AsNoTracking()
            join ep in db.EntryPassengers.AsNoTracking() on ps.PaxId equals ep.Id
            join e in db.Entries.AsNoTracking() on ep.Refno equals e.Refno
            join a in db.Agents.AsNoTracking() on e.Agent equals a.Id
            join c in db.Embassies.AsNoTracking() on ps.CountryId equals c.Id
            where ps.StatusId > 400 && ps.StatusId < 410
            orderby ps.CountryId, e.Refno
            select new PendingReportRow(
                e.Refno, ep.Paxname, a.Description, ps.Subdate, c.Description, e.Externalremark))
            .ToListAsync();
    }

    /// <summary>
    /// Legacy <c>todaySubmission*.asp</c>: pax status rows submitted in the
    /// range (defaults to today). Ordered by paxname then refno (legacy
    /// <c>order by entryDetails.Paxname</c> plus a deterministic tiebreaker).
    /// </summary>
    public static async Task<List<SubmissionReportRow>> TodaySubmissionAsync(
        VisaEntryDbContext db, ReportQueryParams p)
    {
        var to = p.ResolvedTo;
        return await (
            from ps in db.PaxCountryStatuses.AsNoTracking()
            join ep in db.EntryPassengers.AsNoTracking() on ps.PaxId equals ep.Id
            join e in db.Entries.AsNoTracking() on ep.Refno equals e.Refno
            where ps.Subdate >= p.From && ps.Subdate <= to
            orderby ep.Paxname, e.Refno
            select new SubmissionReportRow(
                ep.Totalpax, e.Refno, ps.Colcheck, ps.PaxId, e.Internalremark,
                e.AgentInstruction, ep.Paxname, ps.Coldate, ps.Subdate, ps.CountryId,
                ps.StatusId, ps.Remarks, ps.SentDate, e.Receivedate, e.Agent))
            .ToListAsync();
    }

    /// <summary>
    /// Legacy <c>todayCollection*.asp</c>: pax status rows collected in the
    /// range (defaults to today), with country and agent names resolved.
    /// Ordered by refno then paxname (deterministic — the legacy query had no
    /// ORDER BY; NFR-006).
    /// </summary>
    public static async Task<List<CollectionReportRow>> TodayCollectionAsync(
        VisaEntryDbContext db, ReportQueryParams p)
    {
        var to = p.ResolvedTo;
        return await (
            from ps in db.PaxCountryStatuses.AsNoTracking()
            join ep in db.EntryPassengers.AsNoTracking() on ps.PaxId equals ep.Id
            join e in db.Entries.AsNoTracking() on ep.Refno equals e.Refno
            join c in db.Embassies.AsNoTracking() on ps.CountryId equals c.Id
            join a in db.Agents.AsNoTracking() on e.Agent equals a.Id
            where ps.Coldate >= p.From && ps.Coldate <= to
            orderby e.Refno, ep.Paxname
            select new CollectionReportRow(
                ep.Totalpax, e.Refno, ps.Colcheck, ps.PaxId, ep.Paxname, ps.Coldate,
                ps.Subdate, ps.CountryId, ps.StatusId, ps.Remarks, ps.SentDate,
                ps.Category, e.Receivedate, e.Agent, e.Internalremark, e.Poe,
                e.AgentInstruction, c.Description, a.Description))
            .ToListAsync();
    }

    /// <summary>
    /// Legacy <c>todayTransaction.asp</c>: one row per distinct reference
    /// number whose status rows were entered in the range (defaults to today),
    /// with the per-refno fee totals — visa fee (<c>paxstatus.total</c> where
    /// the collection date is in range), hotel (<c>paxhotel.total</c>) and cab
    /// (<c>paxCab.total</c>), the latter two unbounded per the legacy query.
    /// Ordered by refno.
    /// Single query with left joins to avoid N+1 (SPEC-0008 FR-010, AC-006).
    /// </summary>
    public static async Task<List<TransactionReportRow>> TodayTransactionAsync(
        VisaEntryDbContext db, ReportQueryParams p)
    {
        var to = p.ResolvedTo;

        // Base refnos from PaxCountryStatuses in the entry date range
        var baseQuery = db.PaxCountryStatuses.AsNoTracking()
            .Where(ps => ps.Refno != null && ps.Entrydatetime >= p.From && ps.Entrydatetime <= to)
            .Select(ps => ps.Refno!.Value)
            .Distinct();

        // Single query with left joins for visa fees, hotels, cabs
        var result = await (
            from r in baseQuery
            join vf in (
                from ps in db.PaxCountryStatuses.AsNoTracking()
                where ps.Refno != null && ps.Coldate >= p.From && ps.Coldate <= to
                group ps by ps.Refno!.Value into g
                select new { Refno = g.Key, Total = g.Sum(ps => (decimal?)ps.Total) }
            ) on r equals vf.Refno into vfJoin
            from vf in vfJoin.DefaultIfEmpty()
            join h in (
                from ht in db.PaxHotels.AsNoTracking()
                where ht.Refno != null
                group ht by ht.Refno!.Value into g
                select new { Refno = g.Key, Total = g.Sum(ht => (int?)ht.Total) }
            ) on r equals h.Refno into hJoin
            from h in hJoin.DefaultIfEmpty()
            join c in (
                from cb in db.PaxCabs.AsNoTracking()
                where cb.Refno != null
                group cb by cb.Refno!.Value into g
                select new { Refno = g.Key, Total = g.Sum(cb => (int?)cb.Total) }
            ) on r equals c.Refno into cJoin
            from c in cJoin.DefaultIfEmpty()
            orderby r
            select new TransactionReportRow(r, vf.Total, h.Total, c.Total)
        ).ToListAsync();

        return result;
    }

    /// <summary>
    /// Legacy <c>dailyVisaFee.asp</c>: pax status rows submitted in the range
    /// (defaults to today), joined to the invoice via the legacy outer join on
    /// <c>refno</c> (the legacy <c>a.refno*=d.refno</c>). Ordered by refno
    /// descending (legacy).
    /// </summary>
    public static async Task<List<VisaFeeReportRow>> DailyVisaFeeAsync(
        VisaEntryDbContext db, ReportQueryParams p)
    {
        var to = p.ResolvedTo;
        return await (
            from ps in db.PaxCountryStatuses.AsNoTracking()
            join ep in db.EntryPassengers.AsNoTracking() on ps.PaxId equals ep.Id
            join c in db.Embassies.AsNoTracking() on ps.CountryId equals c.Id
            join i in db.Invoices.AsNoTracking() on ps.Refno equals i.Refno into invoiceJoin
            from i in invoiceJoin.DefaultIfEmpty()
            where ps.Subdate >= p.From && ps.Subdate <= to
            orderby ps.Refno descending
            select new VisaFeeReportRow(
                ps.Refno, i.Invoiceno, i.Invtype, ps.PaxId, ep.Paxname, ps.CountryId,
                c.Description, ps.Subdate, ps.Visafee))
            .ToListAsync();
    }

    /// <summary>
    /// Legacy <c>dailybill.asp</c>: invoices dated in the range (defaults to
    /// today). Ordered by refno descending (legacy).
    /// </summary>
    public static async Task<List<DailyBillRow>> DailyBillAsync(
        VisaEntryDbContext db, ReportQueryParams p)
    {
        var to = p.ResolvedTo;
        return await (
            from i in db.Invoices.AsNoTracking()
            where i.Invoicedate >= p.From && i.Invoicedate <= to
            orderby i.Refno descending
            select new DailyBillRow(
                i.Refno, i.Invoiceno, i.Invoicedate, i.Invtype, i.Hotelfee, i.Cabfee,
                i.Poe, i.Misc, i.Attestfee, i.Courierfee, i.Grandtotal, i.Remark))
            .ToListAsync();
    }

    /// <summary>
    /// Legacy <c>sum(grandtotal)</c> for the daily-bill day.
    /// </summary>
    public static async Task<decimal?> DailyBillGrandTotalAsync(
        VisaEntryDbContext db, ReportQueryParams p)
    {
        var to = p.ResolvedTo;
        return await db.Invoices.AsNoTracking()
            .Where(i => i.Invoicedate >= p.From && i.Invoicedate <= to)
            .SumAsync(i => (decimal?)i.Grandtotal);
    }
}