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
/// Result of opening the working day (SPEC-0007 FR-008, BR-003, CHK022).
/// </summary>
public enum SecurityDayOpenResult
{
    /// <summary>A new open row was created for the date.</summary>
    Opened,
    /// <summary>The day is already open — caller maps to 409 Conflict.</summary>
    AlreadyOpen,
}

/// <summary>
/// Result of closing the working day (SPEC-0007 FR-008, BR-003, CHK022).
/// </summary>
public enum SecurityDayCloseResult
{
    /// <summary>The open row was closed.</summary>
    Closed,
    /// <summary>No open row exists for the date — caller maps to 404 Not Found.</summary>
    NotFound,
}

/// <summary>
/// Core-level view of a security-day row (SPEC-0007 FR-008). Defined in Core
/// because Core must not reference Data entities (one-way Data → Core).
/// </summary>
public sealed record SecurityDayStatus(
    DateTime Date,
    DateTime? OpeningTime,
    string? OpenedBy,
    DateTime? ClosingTime,
    string? ClosedBy);

/// <summary>
/// Shared day-gate business rule (SPEC-0005 T018, FR-018, AC-011/TS-013;
/// legacy `authenticate.asp` lines 62–79). `emp` logins are allowed only when a
/// `security` row exists for the given date with `closingtime IS NULL`;
/// otherwise the login is rejected with `rsn=O`. All non-emp roles pass
/// unconditionally (the gate applies to `emp` logins only).
///
/// SPEC-0007 (FR-008, BR-003) adds the write side: <see cref="OpenDayAsync"/>,
/// <see cref="CloseDayAsync"/> and <see cref="GetTodayAsync"/> back the
/// `adm`/`su`-only open/close surface (legacy `openForDay.asp`/`closeForDay.asp`
/// were anonymous — deepanalysis §2.4 findings 10-11).
///
/// The interface lives in Core as the single-source rule shared by the Web UI
/// and the API (CHK045); the implementation lives in VisaFusion.Data because
/// the rule reads/writes `SecurityDay` via `VisaEntryDbContext` and Core must
/// not reference Data (one-way Data → Core; approved deviation, deviation log §5).
/// </summary>
public interface ISecurityGateService
{
    /// <summary>
    /// Evaluates the day-gate for a login carrying the given roles on the given
    /// date. Callers pass the server-local today for real logins; tests pass a
    /// controlled date.
    /// </summary>
    Task<SecurityGateDecision> EvaluateAsync(IEnumerable<string> roles, DateTime date);

    /// <summary>
    /// Opens the working day for the given date (SPEC-0007 FR-008, BR-003).
    /// Inserts a <c>security</c> row with <c>openingtime</c>/<c>openby</c>.
    /// Atomic per date: the unique <c>date1</c> index makes concurrent opens
    /// resolve to a single winner — the loser receives
    /// <see cref="SecurityDayOpenResult.AlreadyOpen"/> (CHK022).
    /// </summary>
    Task<SecurityDayOpenResult> OpenDayAsync(DateTime date, string openedBy);

    /// <summary>
    /// Closes the working day for the given date (SPEC-0007 FR-008, BR-003).
    /// Sets <c>closingtime</c>/<c>closedby</c> on the open row. Returns
    /// <see cref="SecurityDayCloseResult.NotFound"/> when no open row exists
    /// (CHK021). A close racing an open either closes the row or returns
    /// NotFound — never a partial state (CHK022).
    /// </summary>
    Task<SecurityDayCloseResult> CloseDayAsync(DateTime date, string closedBy);

    /// <summary>
    /// Returns the security-day row for the given date, or <c>null</c> when
    /// none exists (SPEC-0007 FR-008; legacy `securityHome.asp`).
    /// </summary>
    Task<SecurityDayStatus?> GetTodayAsync(DateTime date);
}