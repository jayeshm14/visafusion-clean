using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using VisaFusion.Api.Authorization;
using VisaFusion.Core.Application;

namespace VisaFusion.Web.Areas.Admin.Pages.Agents;

/// <summary>
/// Agent list page (SPEC-0007 T015/T016, US1, FR-002, AC-001; legacy
/// `viewagent.asp`).
///
/// Thin Razor Pages wrapper over the shared <see cref="IAgentService"/> — the
/// same single implementation the `GET /api/v1/agents` endpoint uses
/// (contracts/agents-api.md §5) — so the page and the API can never diverge.
/// Keyword filter (`?q=`) and pagination mirror the endpoint contract; the
/// empty state is explicit (CHK027, spec §14). Only `adm`/`su` pass the
/// <c>AdminPanel</c> policy (AC-002).
/// </summary>
[Authorize(Policy = AuthorizationPolicies.AdminPanel)]
public class ListModel : PageModel
{
    private readonly IAgentService _agents;

    public ListModel(IAgentService agents)
    {
        _agents = agents;
    }

    [BindProperty(SupportsGet = true)]
    public int PageNumber { get; set; } = 1;

    [BindProperty(SupportsGet = true)]
    public string? Q { get; set; }

    public AgentListResult Result { get; private set; } = new(Array.Empty<AgentDetail>(), 0);

    public async Task OnGetAsync()
    {
        ViewData["Title"] = "Agents";
        ViewData["UseSidebar"] = true;

        // Same pagination bounds as the endpoint (contract General: default 50,
        // max 200 — the service clamps).
        Result = await _agents.ListAsync(PageNumber, pageSize: 50, Q);
    }
}
