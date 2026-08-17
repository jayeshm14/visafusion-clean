namespace VisaFusion.Api.Contracts;

/// <summary>
/// One entry row of the agent portal entries list (SPEC-0007 US4, FR-017,
/// AC-012; contracts/agents-api.md §3). Backs the legacy <c>listforagents.asp</c>.
/// <c>Status</c> is the raw <c>Mainentry.status</c> id; <c>StatusDescription</c>
/// is the description the legacy page renders via
/// <c>writeIDDescription("status", statusid)</c>.
/// </summary>
public sealed record AgentEntryResponse
{
    public int Refno { get; init; }
    public string? Paxname { get; init; }
    public DateTime? Traveldate { get; init; }
    public int? Status { get; init; }
    public string? StatusDescription { get; init; }
}

/// <summary>
/// Paginated agent entries list (SPEC-0007 US4, FR-017; contracts/agents-api.md
/// §3). Default page size 50, max 200 (contract General).
/// </summary>
public sealed record AgentEntriesResponse
{
    public IReadOnlyList<AgentEntryResponse> Items { get; init; } = Array.Empty<AgentEntryResponse>();
    public int Total { get; init; }
}

/// <summary>
/// One passenger status row of the agent portal statuses list (SPEC-0007 US4,
/// FR-018, AC-012; contracts/agents-api.md §3a). Backs the legacy
/// <c>agentpaxStatus.asp</c>. <c>Updated</c> is the current status row's
/// submission date (<c>PaxStatus.Subdate</c>).
/// </summary>
public sealed record AgentStatusResponse
{
    public string? Paxname { get; init; }
    public int Refno { get; init; }
    public int? CountryId { get; init; }
    public int? StatusId { get; init; }
    public string? StatusDescription { get; init; }
    public DateTime? Updated { get; init; }
}

/// <summary>
/// The agent's passenger statuses list (SPEC-0007 US4, FR-018;
/// contracts/agents-api.md §3a).
/// </summary>
public sealed record AgentStatusesResponse
{
    public IReadOnlyList<AgentStatusResponse> Items { get; init; } = Array.Empty<AgentStatusResponse>();
}

/// <summary>
/// One ledger line of the agent's financial statement (SPEC-0007 US4, FR-019,
/// BR-008; contracts/agents-api.md §4). Backs the legacy <c>agentStatement*</c>.
/// The voucher type/no. pair (<c>Reftype</c>/<c>Invno</c>) is the pair the
/// legacy page derives as SALES/CR.NOTE/RECEIPT + inv.no-/cn.no-/rec.no.-.
/// </summary>
public sealed record AgentStatementLineResponse
{
    public int Id { get; init; }
    public DateTime? Date { get; init; }
    public int? Bank { get; init; }
    public string? TransactionType { get; init; }
    public int? Refno { get; init; }
    public string? Paxname { get; init; }
    public string? Reftype { get; init; }
    public int? Invno { get; init; }
    public decimal? Debit { get; init; }
    public decimal? Credit { get; init; }
    public decimal? Balance { get; init; }
}

/// <summary>
/// The agent's financial statement (SPEC-0007 US4, FR-019, BR-008;
/// contracts/agents-api.md §4): the ledger lines plus the summary totals
/// (total debits, total credits, and the running balance — the last line's
/// balance, the closing figure the legacy page's final row shows).
/// </summary>
public sealed record AgentStatementResponse
{
    public IReadOnlyList<AgentStatementLineResponse> Items { get; init; } = Array.Empty<AgentStatementLineResponse>();
    public decimal? TotalDebits { get; init; }
    public decimal? TotalCredits { get; init; }
    public decimal? Balance { get; init; }
}