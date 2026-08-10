namespace VisaFusion.Data.Persistence.Entities;

/// <summary>
/// Maps the legacy `invoicedetail` table (SPEC-0004 data-model.md §3.2, same
/// disposition as <see cref="Invoice"/>). No identity column in the legacy
/// schema — surrogate `Id` (bigint identity) key added (FR-003).
/// </summary>
public class InvoiceDetail
{
    /// <summary>Surrogate key (bigint identity) — no legacy identity column exists.</summary>
    public long Id { get; set; }

    /// <summary>Legacy `invoiceno` — FK to <see cref="Invoice.Invoiceno"/>.</summary>
    public int? Invoiceno { get; set; }

    public int? Paxid { get; set; }
    public int? Countryid { get; set; }
    public decimal? Visafee { get; set; }
    public decimal? Handlingfee { get; set; }
    public decimal? Ddcharges { get; set; }
    public string? Invtype { get; set; }
    public decimal? VFSTTCharges { get; set; }
}