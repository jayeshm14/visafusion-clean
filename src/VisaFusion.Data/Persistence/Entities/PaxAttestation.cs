namespace VisaFusion.Data.Persistence.Entities;

/// <summary>
/// Maps the legacy `PaxAttestation` table (SPEC-0004 data-model.md §3.1, M —
/// junction entity). No identity column in the legacy schema — surrogate `Id`
/// (bigint identity) key added (FR-003).
/// </summary>
public class PaxAttestation
{
    /// <summary>Surrogate key (bigint identity) — no legacy identity column exists.</summary>
    public long Id { get; set; }

    /// <summary>Legacy `PaxID` — FK to <see cref="EntryPassenger.Id"/>.</summary>
    public int? PaxId { get; set; }

    /// <summary>Legacy `CountryID` — no target FK (open gap, data-model.md §4).</summary>
    public int? CountryId { get; set; }

    /// <summary>Legacy `AttestationID` — FK to <see cref="Attestation.AttestationId"/>.</summary>
    public int? AttestationId { get; set; }

    /// <summary>Legacy `CertificateID` — FK to <see cref="Certificate.CertificateId"/>.</summary>
    public int? CertificateId { get; set; }
}