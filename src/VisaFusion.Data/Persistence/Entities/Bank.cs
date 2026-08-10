namespace VisaFusion.Data.Persistence.Entities;

/// <summary>
/// Maps the legacy `bank` table (SPEC-0004 data-model.md §3.1, M — reference
/// table for <see cref="LedgerHistory"/>). PK is the natural key `bankid`
/// (referenced by <see cref="LedgerHistory.Bank"/>, values preserved, FR-003).
/// </summary>
public class Bank
{
    /// <summary>Legacy `bankid` (natural key) — primary key, values preserved.</summary>
    public int Bankid { get; set; }

    public string? Description { get; set; }
    public string? Active { get; set; }
}