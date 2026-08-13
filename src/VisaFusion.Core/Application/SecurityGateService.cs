namespace VisaFusion.Core.Application;

/// <summary>
/// Outcome of the employee day-gate evaluation (SPEC-0005 T018, FR-018). The
/// legacy `rsn` reason codes (deepanalysis §1.2) map as follows:
///   - <see cref="Allowed"/> — no rejection (login proceeds);
///   - <see cref="RejectedNotOpened"/> — `rsn=O` (day not opened).
/// `rsn=C` (day closed) is legacy dead code (`authenticate.asp` line 72) and is
/// NEVER produced: a row whose closing time is set is treated the same as no
/// row at all (AC-011/TS-013).
/// </summary>
public enum SecurityGateDecision
{
    Allowed,
    RejectedNotOpened,
}

/// <summary>
/// Shared day-gate business rule (SPEC-0005 T018, FR-018, AC-011/TS-013;
/// legacy `authenticate.asp` lines 62–79). `emp` logins are allowed only when a
/// `security` row exists for the given date with `closingtime IS NULL`;
/// otherwise the login is rejected with `rsn=O`. All non-emp roles pass
/// unconditionally (the gate applies to `emp` logins only).
///
/// The interface lives in Core as the single-source rule shared by the Web UI
/// and the API (CHK045); the implementation lives in VisaFusion.Data because
/// the rule reads `SecurityDay` via `VisaEntryDbContext` and Core must not
/// reference Data (one-way Data → Core; approved deviation, deviation log §5).
/// </summary>
public interface ISecurityGateService
{
    /// <summary>
    /// Evaluates the day-gate for a login carrying the given roles on the given
    /// date. Callers pass the server-local today for real logins; tests pass a
    /// controlled date.
    /// </summary>
    Task<SecurityGateDecision> EvaluateAsync(IEnumerable<string> roles, DateTime date);
}