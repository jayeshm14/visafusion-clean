namespace VisaFusion.Data.Persistence.Entities;

/// <summary>
/// Maps the legacy `Ledger` table (SPEC-0004 data-model.md §3.2, M-RO — historical
/// archive; 26,563/26,565 rows have NULL `transdate`). PK is the identity column
/// `id` (values preserved, FR-003).
/// </summary>
public class LedgerHistory
{
    /// <summary>Legacy `id` (identity) — primary key, values preserved.</summary>
    public int Id { get; set; }

    /// <summary>Legacy `agentID` — FK to <see cref="Agent.Id"/>.</summary>
    public int? AgentId { get; set; }

    public DateTime? Transdate { get; set; }
    public string? TransactionType { get; set; }

    /// <summary>Legacy `bank` — FK to <see cref="Bank.Bankid"/>.</summary>
    public int? Bank { get; set; }

    public string? Paidas { get; set; }
    public string? Ddno { get; set; }
    public string? Dddate { get; set; }
    public string? Paxname { get; set; }
    public int? Refno { get; set; }
    public string? Reftype { get; set; }
    public decimal? Credit { get; set; }
    public decimal? Debit { get; set; }
    public decimal? Balance { get; set; }
    public string? Remark { get; set; }
    public DateTime? EntrydateTime { get; set; }
    public string? Updatedby { get; set; }
    public int? Invno { get; set; }
}