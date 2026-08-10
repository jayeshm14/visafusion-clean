namespace VisaFusion.Data.Persistence.Entities;

/// <summary>
/// Maps the legacy `embassy` table (SPEC-0004 data-model.md §3.1, M — reference).
/// PK is the identity column `EmbassyID` (values preserved, FR-003).
/// </summary>
public class Embassy
{
    /// <summary>Legacy `EmbassyID` (identity) — primary key, values preserved.</summary>
    public int Id { get; set; }

    public string Description { get; set; } = string.Empty;
    public string? Embassyname { get; set; }
    public string? Street1 { get; set; }
    public string? Street2 { get; set; }
    public string? Area { get; set; }
    public string? City { get; set; }
    public string? Phoneno { get; set; }
    public string? Faxno { get; set; }
    public string? Emailid { get; set; }
    public string? Workinghours { get; set; }
    public string? Chancery { get; set; }
    public string? Chanceryphone { get; set; }
    public string? Chanceryaddress { get; set; }
    public string? Active { get; set; }
}