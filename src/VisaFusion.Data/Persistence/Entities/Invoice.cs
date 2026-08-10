namespace VisaFusion.Data.Persistence.Entities;

/// <summary>
/// Maps the legacy `invoice` table (SPEC-0004 data-model.md §3.2, M-RO for
/// pre-2009 data; M if the owner revives billing, migration plan §12 #1).
/// No identity column in the legacy schema — surrogate `Id` (bigint identity)
/// key added (FR-003). Oversized values (e.g. `grandtotal` 4.5×10¹⁴) are
/// migrated verbatim where representable (FR-002).
/// </summary>
public class Invoice
{
    /// <summary>Surrogate key (bigint identity) — no legacy identity column exists.</summary>
    public long Id { get; set; }

    public int? Refno { get; set; }

    /// <summary>Legacy `invoiceno` — referenced by <see cref="InvoiceDetail.Invoiceno"/>.</summary>
    public int? Invoiceno { get; set; }

    public decimal? Hotelfee { get; set; }
    public decimal? Cabfee { get; set; }
    public string? Poeremark { get; set; }
    public decimal? Poe { get; set; }
    public string? Miscremark { get; set; }
    public decimal? Misc { get; set; }
    public decimal? Attestfee { get; set; }
    public string? Attestremark { get; set; }
    public decimal? Courierfee { get; set; }
    public decimal? Grandtotal { get; set; }
    public DateTime? Invoicedate { get; set; }
    public string? Remark { get; set; }
    public string? Invtype { get; set; }
}