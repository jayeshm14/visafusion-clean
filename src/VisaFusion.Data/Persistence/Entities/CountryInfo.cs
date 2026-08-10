namespace VisaFusion.Data.Persistence.Entities;

/// <summary>
/// Maps the legacy `CountryInfo` table (SPEC-0004 data-model.md §3.1, M — content).
/// PK is the natural key `CountryID` (values preserved, FR-003). The legacy
/// `country` lookup table is empty and dropped; the country concept lives here
/// and in <see cref="Embassy"/> (data-model.md §3.5).
/// </summary>
public class CountryInfo
{
    /// <summary>Legacy `CountryID` (natural key) — primary key, values preserved.</summary>
    public int CountryId { get; set; }

    public string? About { get; set; }
    public string? Climate { get; set; }
    public string? Language { get; set; }
    public string? Religion { get; set; }
    public string? Curency { get; set; }
    public string? TimeZone { get; set; }
    public string? ContinentFile { get; set; }
    public string? FlagFile { get; set; }
    public string? VisaFile { get; set; }
}