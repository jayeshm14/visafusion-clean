namespace VisaFusion.Data.Persistence.Entities;

/// <summary>
/// Durable email notification queue (SPEC-0008 FR-002, research D-1). NEW additive
/// table <c>emailQueue</c> mirroring the legacy <c>smsQueue</c> shape so the drain
/// logic is uniform. Rows are deleted only by the successful drain commit (send-once
/// gate, research D-3).
/// </summary>
public class EmailQueue
{
    public long Id { get; set; }
    public string Toemail { get; set; } = "";
    public string Subject { get; set; } = "";
    public string Body { get; set; } = "";
    public int? Agentsid { get; set; }
    public int? Refno { get; set; }
    public string? Awb { get; set; }
    public string? Sentby { get; set; }
    public DateTime? Sentdate { get; set; }
}
