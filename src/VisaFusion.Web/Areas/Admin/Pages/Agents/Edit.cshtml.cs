using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using VisaFusion.Api.Authorization;
using VisaFusion.Core.Application;

namespace VisaFusion.Web.Areas.Admin.Pages.Agents;

/// <summary>
/// Agent edit page (SPEC-0007 T015/T016, US1, FR-003, AC-001; legacy
/// `editdoneagent1.asp`).
///
/// Thin Razor Pages wrapper over the shared <see cref="IAgentService"/> — the
/// same single implementation the `PUT /api/v1/agents/{id}` endpoint uses
/// (contracts/agents-api.md §1) — so the page and the API can never diverge.
/// Field-level validation mirrors the contract (at least one field required;
/// the lifecycle flag is not editable here) and the shared exceptions surface
/// as inline messages (spec §18). Only `adm`/`su` pass the <c>AdminPanel</c>
/// policy (AC-002).
/// </summary>
[Authorize(Policy = AuthorizationPolicies.AdminPanel)]
public class EditModel : PageModel
{
    private readonly IAgentService _agents;

    public EditModel(IAgentService agents)
    {
        _agents = agents;
    }

    [BindProperty(SupportsGet = true)]
    public int Id { get; set; }

    [BindProperty]
    public string? Companyname { get; set; }

    [BindProperty]
    public string? Description { get; set; }

    [BindProperty]
    public string? Street1 { get; set; }

    [BindProperty]
    public string? Street2 { get; set; }

    [BindProperty]
    public string? Area { get; set; }

    [BindProperty]
    public string? City { get; set; }

    [BindProperty]
    public string? Pincode { get; set; }

    [BindProperty]
    public string? Phoneno { get; set; }

    [BindProperty]
    public string? Faxno { get; set; }

    [BindProperty]
    public string? Emailid { get; set; }

    [BindProperty]
    public string? Smsno { get; set; }

    [BindProperty]
    public string? Directorname { get; set; }

    [BindProperty]
    public string? DirectorPH { get; set; }

    [BindProperty]
    public string? AcMgrPH { get; set; }

    [BindProperty]
    public string? VisaInchargeName { get; set; }

    [BindProperty]
    public string? VisaInchargePH { get; set; }

    [BindProperty]
    public string? Acno { get; set; }

    [BindProperty]
    public string? Payment { get; set; }

    [BindProperty]
    public string? TAAI { get; set; }

    [BindProperty]
    public string? TAFI { get; set; }

    [BindProperty]
    public string? Membership { get; set; }

    [BindProperty]
    public string? IATA { get; set; }

    public bool IsNotFound { get; private set; }

    public async Task OnGetAsync()
    {
        ViewData["Title"] = "Edit agent";
        ViewData["UseSidebar"] = true;

        var agent = await _agents.GetByIdAsync(Id);
        if (agent is null)
        {
            IsNotFound = true;
            return;
        }

        Companyname = agent.Companyname;
        Description = agent.Description;
        Street1 = agent.Street1;
        Street2 = agent.Street2;
        Area = agent.Area;
        City = agent.City;
        Pincode = agent.Pincode;
        Phoneno = agent.Phoneno;
        Faxno = agent.Faxno;
        Emailid = agent.Emailid;
        Smsno = agent.Smsno;
        Directorname = agent.Directorname;
        DirectorPH = agent.DirectorPH;
        AcMgrPH = agent.AcMgrPH;
        VisaInchargeName = agent.VisaInchargeName;
        VisaInchargePH = agent.VisaInchargePH;
        Acno = agent.Acno;
        Payment = agent.Payment;
        TAAI = agent.TAAI;
        TAFI = agent.TAFI;
        Membership = agent.Membership;
        IATA = agent.IATA;
    }

    public async Task<IActionResult> OnPostAsync()
    {
        ViewData["Title"] = "Edit agent";
        ViewData["UseSidebar"] = true;

        var patch = new AgentInput(
            Companyname?.Trim(), Description?.Trim(), Street1?.Trim(), Street2?.Trim(),
            Area?.Trim(), City?.Trim(), Pincode?.Trim(), Phoneno?.Trim(),
            Faxno?.Trim(), Emailid?.Trim(), Smsno?.Trim(), Directorname?.Trim(),
            DirectorPH?.Trim(), AcMgrPH?.Trim(), VisaInchargeName?.Trim(),
            VisaInchargePH?.Trim(), Acno?.Trim(), Payment?.Trim(), TAAI?.Trim(),
            TAFI?.Trim(), Membership?.Trim(), IATA?.Trim());

        try
        {
            var updated = await _agents.UpdateAsync(Id, patch);
            return RedirectToPage("Detail", new { id = updated.Id });
        }
        catch (AgentValidationException ex)
        {
            // Contract §1: at least one field required.
            ModelState.AddModelError(string.Empty, ex.Message);
            return Page();
        }
        catch (AgentNotFoundException)
        {
            IsNotFound = true;
            return Page();
        }
    }
}