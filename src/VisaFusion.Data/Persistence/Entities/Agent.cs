namespace VisaFusion.Data.Persistence.Entities;

/// <summary>
/// Maps the legacy `agents` table (SPEC-0004 data-model.md §3.1, M). Travel-agent
/// business partner record. PK is the identity column `agentsID` (values preserved,
/// FR-003). Also the highest-priority identity source (FR-004).
/// </summary>
public class Agent
{
    /// <summary>Legacy `agentsID` (identity) — primary key, values preserved.</summary>
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
    public string? Active { get; set; }
    public string? TAAI { get; set; }
    public string? TAFI { get; set; }
    public string? Membership { get; set; }
    public DateTime? Creationdate { get; set; }
    public string? IATA { get; set; }
    public string? DirectorPH { get; set; }
    public string? AcMgrPH { get; set; }
    public string? VisaInchargeName { get; set; }
    public string? VisaInchargePH { get; set; }
    public string? Enteredby { get; set; }
    public string? Smsno { get; set; }
}