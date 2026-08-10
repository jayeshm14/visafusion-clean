namespace VisaFusion.Data.Persistence.Entities;

/// <summary>
/// Maps the legacy `Attestation` table (SPEC-0004 data-model.md §3.1, M — lookup).
/// PK is the natural key `AttestationID` (referenced by <see cref="Entry.Attestation"/>,
/// <see cref="PaxAttestation.AttestationId"/>).
/// </summary>
public class Attestation
{
    /// <summary>Legacy `AttestationID` (natural key) — primary key, values preserved.</summary>
    public int AttestationId { get; set; }

    public string? Description { get; set; }
}