namespace VisaFusion.Data.Persistence.Entities;

/// <summary>
/// Maps the legacy `certificate` table (SPEC-0004 data-model.md §3.1, M — lookup).
/// PK is the natural key `certificateID` (referenced by
/// <see cref="PaxAttestation.CertificateId"/>).
/// </summary>
public class Certificate
{
    /// <summary>Legacy `certificateID` (natural key) — primary key, values preserved.</summary>
    public int CertificateId { get; set; }

    public string? Description { get; set; }
}