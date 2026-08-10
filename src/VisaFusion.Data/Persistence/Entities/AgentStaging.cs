namespace VisaFusion.Data.Persistence.Entities;

/// <summary>
/// Maps the legacy `newagents` table (SPEC-0004 data-model.md §3.2, M-RO —
/// registration staging). PK is the identity column `newagentsID` (values
/// preserved, FR-003). Same address/profile column set as <see cref="Agent"/>.
/// </summary>
public class AgentStaging
{
    /// <summary>Legacy `newagentsID` (identity) — primary key, values preserved.</summary>
    public int Id { get; set; }

    public string? Description { get; set; }
    public string? Companyname { get; set; }
    public string? Complexname { get; set; }
    public string? Street1 { get; set; }
    public string? Street2 { get; set; }
    public string? Area { get; set; }
    public string? City { get; set; }
    public string? Pincode { get; set; }
    public string? Phoneno { get; set; }
    public string? Faxno { get; set; }
    public string? Emailid { get; set; }
    public string? Directorname { get; set; }
    public string? Acno { get; set; }
    public string? Payment { get; set; }
}