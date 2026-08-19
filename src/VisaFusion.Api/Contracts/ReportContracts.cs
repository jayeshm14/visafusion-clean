namespace VisaFusion.Api.Contracts;

// Report DTOs (SPEC-0008 T046, US6, FR-012, AC-008; contracts/reports-api.md).
// Row field names mirror the legacy columns the report pages render
// (pendinglist.asp, todaySubmission*.asp, todayCollection*.asp,
// todayTransaction.asp, dailyVisaFee.asp, dailybill.asp,
// todayAgentStatusalltemp.asp). All values are nullable like the legacy
// columns — the reports are read-only projections of the source tables.

/// <summary>
/// Row for `GET /api/v1/reports/agent-status/today` (legacy
/// `todayAgentStatusalltemp.asp`): per-pax-per-country status rows whose
/// sent-back date is still open — `sentdate` is null or on/after the
/// from-date (the legacy `sentdate &gt; stdate OR sentdate IS NULL` filter).
/// </summary>
public sealed record AgentStatusReportRow(
    int? Refno,
    int? PaxId,
    string? Paxname,
    string? Colcheck,
    DateTime? Coldate,
    DateTime? Subdate,
    int? CountryId,
    int? StatusId,
    string? Remarks,
    DateTime? SentDate,
    DateTime? Receivedate,
    int? Agent,
    string? Refferer,
    string? Companyname,
    string? ExternalRemark,
    int? Category,
    string? AgentInstruction);

/// <summary>
/// Row for `GET /api/v1/reports/pending` (legacy `pendinglist.asp`): entries
/// in the pending status band (statusid 401..409) with agent and country names
/// resolved.
/// </summary>
public sealed record PendingReportRow(
    int? Refno,
    string? Paxname,
    string? Agentname,
    DateTime? Subdate,
    string? Countryname,
    string? Externalremark);

/// <summary>
/// Row for `GET /api/v1/reports/today-submission` (legacy `todaySubmission*.asp`):
/// pax status rows whose submission date falls in the requested range (defaults
/// to today).
/// </summary>
public sealed record SubmissionReportRow(
    int? Totalpax,
    int? Refno,
    string? Colcheck,
    int? PaxId,
    string? Internalremark,
    string? Agentinstruction,
    string? Paxname,
    DateTime? Coldate,
    DateTime? Subdate,
    int? CountryId,
    int? StatusId,
    string? Remarks,
    DateTime? SentDate,
    DateTime? Receivedate,
    int? Agent);

/// <summary>
/// Row for `GET /api/v1/reports/today-collection` (legacy `todayCollection*.asp`):
/// pax status rows whose collection date falls in the requested range (defaults
/// to today), with country and agent names resolved.
/// </summary>
public sealed record CollectionReportRow(
    int? Totalpax,
    int? Refno,
    string? Colcheck,
    int? PaxId,
    string? Paxname,
    DateTime? Coldate,
    DateTime? Subdate,
    int? CountryId,
    int? StatusId,
    string? Remarks,
    DateTime? SentDate,
    int? Category,
    DateTime? Receivedate,
    int? Agent,
    string? Internalremark,
    int? Poe,
    string? Agentinstruction,
    string? Countryname,
    string? Agentname);

/// <summary>
/// Row for `GET /api/v1/reports/today-transaction` (legacy `todayTransaction.asp`):
/// one row per distinct reference number whose status rows were entered in the
/// range (defaults to today), with the per-refno fee totals: visa fee
/// (`paxstatus.total` where the collection date is in range), hotel
/// (`paxhotel.total`) and cab (`paxCab.total`) — the latter two unbounded per
/// the legacy query.
/// </summary>
public sealed record TransactionReportRow(
    int? Refno,
    decimal? VisafeeTotal,
    int? HotelTotal,
    int? CabTotal);

/// <summary>
/// Row for `GET /api/v1/reports/daily-visa-fee` (legacy `dailyVisaFee.asp`):
/// pax status rows whose submission date falls in the range (defaults to
/// today), joined to the invoice via the legacy outer join (`refno`).
/// </summary>
public sealed record VisaFeeReportRow(
    int? Refno,
    int? Invoiceno,
    string? Invtype,
    int? PaxId,
    string? Paxname,
    int? CountryId,
    string? Countryname,
    DateTime? Subdate,
    decimal? Visafee);

/// <summary>
/// Row for `GET /api/v1/reports/daily-bill` (legacy `dailybill.asp`): one row
/// per invoice whose invoice date falls in the range (defaults to today).
/// </summary>
public sealed record DailyBillRow(
    int? Refno,
    int? Invoiceno,
    DateTime? Invoicedate,
    string? Invtype,
    decimal? Hotelfee,
    decimal? Cabfee,
    decimal? Poe,
    decimal? Misc,
    decimal? Attestfee,
    decimal? Courierfee,
    decimal? Grandtotal,
    string? Remark);

/// <summary>
/// Response envelope for `GET /api/v1/reports/daily-bill`: the invoice rows
/// plus the day's grand total (legacy `sum(grandtotal)`).
/// </summary>
public sealed record DailyBillReport(decimal? GrandTotal, IReadOnlyList<DailyBillRow> Invoices);