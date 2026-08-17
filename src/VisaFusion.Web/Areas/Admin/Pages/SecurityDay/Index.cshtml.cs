using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using VisaFusion.Api.Authorization;
using VisaFusion.Core.Application;

namespace VisaFusion.Web.Areas.Admin.Pages.SecurityDay;

/// <summary>
/// Security-day page (SPEC-0007 T026, US3, FR-008, AC-004; legacy
/// `securityHome.asp` + `openForDay.asp`/`closeForDay.asp` parity).
///
/// Thin Razor Pages wrapper over the shared <see cref="ISecurityGateService"/>
/// — the same single implementation the `POST /api/v1/admin/security-day/open`
/// /`close` and `GET /api/v1/admin/security-day/today` endpoints use
/// (contracts/admin-api.md §1-§3) — so the page and the API can never diverge.
/// Shows the open/closed state for the server-local today and offers the
/// open/close actions; the AlreadyOpen (409) and NotFound (404) outcomes
/// surface as inline messages (spec §18), exactly as on the API surface. The
/// audit actor is the authenticated cookie principal's username — never from
/// the request body (GR-0004). Only `adm`/`su` pass the <c>SecurityGate</c>
/// policy (AC-004).
/// </summary>
[Authorize(Policy = AuthorizationPolicies.SecurityGate)]
public class IndexModel : PageModel
{
    private readonly ISecurityGateService _securityGate;

    public IndexModel(ISecurityGateService securityGate)
    {
        _securityGate = securityGate;
    }

    /// <summary>Current security-day state for today; null when never opened.</summary>
    public SecurityDayStatus? Today { get; private set; }

    /// <summary>Inline outcome message mirroring the endpoint problem-details.</summary>
    public string? OutcomeMessage { get; private set; }

    public string? OutcomeError { get; private set; }

    public async Task OnGetAsync()
    {
        ViewData["Title"] = "Security day";
        ViewData["UseSidebar"] = true;

        Today = await _securityGate.GetTodayAsync(DateTime.Now);
    }

    public async Task<IActionResult> OnPostOpenAsync()
    {
        ViewData["Title"] = "Security day";
        ViewData["UseSidebar"] = true;

        var actorName = User.Identity?.Name;
        if (string.IsNullOrEmpty(actorName))
        {
            return RedirectToPage("/Auth/Login");
        }

        var result = await _securityGate.OpenDayAsync(DateTime.Now, actorName);
        if (result == SecurityDayOpenResult.AlreadyOpen)
        {
            OutcomeError = "The working day is already open.";
        }
        else
        {
            OutcomeMessage = "The working day is open.";
        }

        Today = await _securityGate.GetTodayAsync(DateTime.Now);
        return Page();
    }

    public async Task<IActionResult> OnPostCloseAsync()
    {
        ViewData["Title"] = "Security day";
        ViewData["UseSidebar"] = true;

        var actorName = User.Identity?.Name;
        if (string.IsNullOrEmpty(actorName))
        {
            return RedirectToPage("/Auth/Login");
        }

        var result = await _securityGate.CloseDayAsync(DateTime.Now, actorName);
        if (result == SecurityDayCloseResult.NotFound)
        {
            OutcomeError = "No open working day exists to close.";
        }
        else
        {
            OutcomeMessage = "The working day is closed.";
        }

        Today = await _securityGate.GetTodayAsync(DateTime.Now);
        return Page();
    }
}