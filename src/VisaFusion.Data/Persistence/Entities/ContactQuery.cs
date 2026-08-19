namespace VisaFusion.Data.Persistence.Entities;

/// <summary>
/// Contact query persisted from POST /api/v1/public/queries (SPEC-0008 §16).
/// NEW additive table <c>queries</c>. Status defaults to 'new' on insert and never
/// transitions in v1 (owner Q4:A — read-only audit trail).
/// </summary>
public class ContactQuery
{
    public long Id { get; set; }
    public string Name { get; set; } = "";
    public string Email { get; set; } = "";
    public string Subject { get; set; } = "";
    public string Message { get; set; } = "";
    public DateTime Subdate { get; set; }
    public string Status { get; set; } = "new";
    public string IpAddress { get; set; } = "";
}
