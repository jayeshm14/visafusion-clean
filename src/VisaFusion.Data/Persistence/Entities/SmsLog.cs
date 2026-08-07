namespace VisaFusion.Data.Persistence.Entities;

/// <summary>
/// Maps the legacy `smshistory` table (data-model.md §1). Append-only (spec §19).
/// Scaffolding entity only.
/// </summary>
public class SmsLog
{
    public long Id { get; set; }
}