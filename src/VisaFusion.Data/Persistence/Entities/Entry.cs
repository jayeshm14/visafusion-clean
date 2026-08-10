namespace VisaFusion.Data.Persistence.Entities;

/// <summary>
/// Maps the legacy `Mainentry` table (SPEC-0004 data-model.md §3.1, disposition M).
/// Master visa-entry record. PK is the legacy identity column `id` (values preserved,
/// FR-003). Column set matches the live schema dump (findings/modernization_plan.md §12).
/// </summary>
public class Entry
{
    /// <summary>Legacy `id` (numeric identity) — primary key, values preserved.</summary>
    public long Id { get; set; }

    public int? Refno { get; set; }
    public string? Paxname { get; set; }

    /// <summary>Legacy `agent` — nullable; 6,517 orphaned rows migrate with NULL (FR-005c).</summary>
    public int? Agent { get; set; }

    public string? Refferer { get; set; }
    public string? Companyname { get; set; }
    public string? Passportno { get; set; }
    public int? Totalpassengers { get; set; }
    public int? Entries { get; set; }
    public DateTime? Dateofbirth { get; set; }
    public DateTime? Subdate { get; set; }
    public DateTime? Coldate { get; set; }
    public DateTime? Receivedate { get; set; }
    public DateTime? Traveldate { get; set; }
    public DateTime? SentDate { get; set; }

    /// <summary>Legacy `entrytype` — 100% NULL in source; defaulted by cleansing rule (b) (FR-005b).</summary>
    public int? Entrytype { get; set; }

    public int? Category { get; set; }
    public int? Attestation { get; set; }
    public int? Poe { get; set; }
    public int? Status { get; set; }
    public string? Externalremark { get; set; }
    public string? Internalremark { get; set; }
    public string? AgentInstruction { get; set; }
    public string? Enteredby { get; set; }
    public DateTime? Entrydatetime { get; set; }
    public string? Bill { get; set; }
}