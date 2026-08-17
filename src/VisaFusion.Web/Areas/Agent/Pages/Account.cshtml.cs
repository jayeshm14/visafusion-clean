using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using VisaFusion.Core.Application;
using VisaFusion.Identity;

namespace VisaFusion.Web.Areas.Agent.Pages;

/// <summary>
/// Agent self-service account page (SPEC-0007 T031, US4, FR-020/FR-003,
/// AC-014; legacy `AgentAccount.asp`/`editdonebyagent1.asp`).
///
/// Thin Razor Pages wrapper over the shared <see cref="IAgentService"/>
/// <see cref="IAgentService.UpdateAsync"/> scoped to the claim-bound agent id —
/// the same single implementation the `PUT /api/v1/agents/{id}/self` endpoint
/// uses (contracts/agents-api.md §2) — so the page and the API can never
/// diverge. The route id is the claim-bound id resolved from the authenticated
/// user row (<see cref="AgentPortalPageModel"/>), never a query string
/// (GR-0004); there is no id field to tamper with, so an agent can only ever
/// update their OWN record (BR-007, AC-014). At least one field is required
/// (contract §1) and the lifecycle flag is not editable here, mirroring the
/// admin edit page.
/// </summary>
public class AccountModel : AgentPortalPageModel
{
    private readonly IAgentService _agents;

    public AccountModel(
        IAgentService agents,
        UserManager<IdentityIntegration.VisaFusionUser> userManager)
        : base(userManager)
    {
        _agents = agents;
    }

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

    public string? OutcomeMessage { get; private set; }

    public string? OutcomeError { get; private set; }

    public async Task OnGetAsync()
    {
        ViewData["Title"] = "My account";
        ViewData["UseSidebar"] = true;

        await ResolveAgentIdAsync();
        if (HasNoLinkedAgent) return;

        var agent = await _agents.GetByIdAsync(AgentId!.Value);
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
        ViewData["Title"] = "My account";
        ViewData["UseSidebar"] = true;

        await ResolveAgentIdAsync();
        if (HasNoLinkedAgent)
        {
            // CHK026: no claim-bound agent — never let the form touch any agent.
            return Page();
        }

        var patch = new AgentInput(
            Companyname?.Trim(), Description?.Trim(), Street1?.Trim(), Street2?.Trim(),
            Area?.Trim(), City?.Trim(), Pincode?.Trim(), Phoneno?.Trim(),
            Faxno?.Trim(), Emailid?.Trim(), Smsno?.Trim(), Directorname?.Trim(),
            DirectorPH?.Trim(), AcMgrPH?.Trim(), VisaInchargeName?.Trim(),
            VisaInchargePH?.Trim(), Acno?.Trim(), Payment?.Trim(), TAAI?.Trim(),
            TAFI?.Trim(), Membership?.Trim(), IATA?.Trim());

        try
        {
            await _agents.UpdateAsync(AgentId!.Value, patch);
            OutcomeMessage = "Your details have been saved.";

            // Reload the saved values so the form shows what was persisted.
            var agent = await _agents.GetByIdAsync(AgentId.Value);
            if (agent is not null)
            {
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

            return Page();
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
