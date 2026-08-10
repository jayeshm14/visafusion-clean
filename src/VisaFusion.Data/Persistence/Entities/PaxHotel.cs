namespace VisaFusion.Data.Persistence.Entities;

/// <summary>
/// Maps the legacy `paxhotel` table (SPEC-0004 data-model.md §3.3, COND — child
/// of <see cref="Hotel"/>, archived until owner approval, BR-004). No identity
/// column in the legacy schema — surrogate `Id` (bigint identity) key added.
/// </summary>
public class PaxHotel
{
    /// <summary>Surrogate key (bigint identity) — no legacy identity column exists.</summary>
    public long Id { get; set; }

    public int? Refno { get; set; }
    public string? Name { get; set; }
    public int? Hotelname { get; set; }
    public string? Arrivaltime { get; set; }
    public DateTime? Arrivaldate { get; set; }
    public string? Departtime { get; set; }
    public DateTime? Departdate { get; set; }
    public int? Nosofdays { get; set; }
    public int? Tariff { get; set; }
    public string? Transportation { get; set; }
    public string? Flightdetail { get; set; }
    public string? Flightstatus { get; set; }
    public int? Misccharges { get; set; }
    public int? Total { get; set; }
    public int? Noofrooms { get; set; }
    public DateTime? EntryDateTime { get; set; }
}