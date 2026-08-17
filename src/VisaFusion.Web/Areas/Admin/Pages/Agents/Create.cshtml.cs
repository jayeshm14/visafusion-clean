using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using VisaFusion.Api.Authorization;
using VisaFusion.Core.Application;
using VisaFusion.Identity;

namespace VisaFusion.Web.Areas.Admin.Pages.Agents;

/// <summary>
/// Agent create page (SPEC-0007 T015/T016, US1, FR-001, BR-009, AC-017;
/// legacy `addnewagents.asp`/`newagent.asp`).
///
/// Thin Razor Pages wrapper over the shared <see cref="IAgentService"/> — the
/// same single implementation the `POST /api/v1/agents` endpoint uses
/// (contracts/agents-api.md §6) — so the page and the API can never diverge.
/// Field-level validation mirrors the contract (companyname, username and
/// password required; password policy = the shared Identity validator, spec
/// §17) and the shared exceptions surface as inline messages (spec §18). The
/// audit actor is resolved from the authenticated cookie principal, never the
/// request body (GR-0004). Only `adm`/`su` pass the <c>AdminPanel</c> policy
/// (AC-002).
/// </summary>
[Authorize(Policy = AuthorizationPolicies.AdminPanel)]
public class CreateModel : PageModel
{
    private readonly IAgentService _agents;
    private readonly UserManager<IdentityIntegration.VisaFusionUser> _userManager;

    public CreateModel(IAgentService agents, UserManager<IdentityIntegration.VisaFusionUser> userManager)
    {
        _agents = agents;
        _userManager = userManager;
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

    [BindProperty]
    public string? Username { get; set; }

    [BindProperty]
    public string? Password { get; set; }

    public void OnGet()
    {
        ViewData["Title"] = "New agent";
        ViewData["UseSidebar"] = true;
    }

    public async Task<IActionResult> OnPostAsync()
    {
        ViewData["Title"] = "New agent";
        ViewData["UseSidebar"] = true;

        var companyname = Companyname?.Trim();
        var username = Username?.Trim();

        // Field-level validation mirroring contracts/agents-api.md §6 (spec §17):
        // companyname, username and password are required on create.
        if (string.IsNullOrEmpty(companyname))
        {
            ModelState.AddModelError(nameof(Companyname), "Company name is required.");
        }

        if (string.IsNullOrEmpty(username))
        {
            ModelState.AddModelError(nameof(Username), "Login username is required.");
        }

        if (string.IsNullOrEmpty(Password))
        {
            ModelState.AddModelError(nameof(Password), "Initial password is required.");
        }
        else if (Password.Length < 8)
        {
            // The shared Identity password validator (RequiredLength = 8,
            // registered in Program.cs) enforces the policy — the same rule the
            // API surface uses (spec §17/CHK044).
            ModelState.AddModelError(nameof(Password), "Password must be at least 8 characters.");
        }

        if (!ModelState.IsValid)
        {
            return Page();
        }

        var actor = await ResolveActorAsync();
        if (actor is null)
        {
            return RedirectToPage("/Auth/Login");
        }

        var input = new AgentInput(
            companyname, Description?.Trim(), Street1?.Trim(), Street2?.Trim(),
            Area?.Trim(), City?.Trim(), Pincode?.Trim(), Phoneno?.Trim(),
            Faxno?.Trim(), Emailid?.Trim(), Smsno?.Trim(), Directorname?.Trim(),
            DirectorPH?.Trim(), AcMgrPH?.Trim(), VisaInchargeName?.Trim(),
            VisaInchargePH?.Trim(), Acno?.Trim(), Payment?.Trim(), TAAI?.Trim(),
            TAFI?.Trim(), Membership?.Trim(), IATA?.Trim());

        try
        {
            var created = await _agents.CreateAsync(
                input, username!, Password!, actor.Value.UserId, actor.Value.UserName);
            return RedirectToPage("Detail", new { id = created.Id });
        }
        catch (AgentValidationException ex)
        {
            ModelState.AddModelError(string.Empty, ex.Message);
            return Page();
        }
        catch (AgentConflictException ex)
        {
            // 409 — duplicate login username (CHK025).
            ModelState.AddModelError(nameof(Username), ex.Message);
            return Page();
        }
    }

    /// <summary>
    /// Resolves the audit actor from the authenticated cookie principal — the
    /// same source the API endpoints use (JWT `name`/`nameidentifier` claims).
    /// </summary>
    private async Task<(string UserId, string UserName)?> ResolveActorAsync()
    {
        var user = await _userManager.GetUserAsync(User);
        return user is null ? null : (user.Id, user.UserName ?? string.Empty);
    }
}