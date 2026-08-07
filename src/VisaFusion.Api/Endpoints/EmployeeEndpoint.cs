using Microsoft.AspNetCore.Http;
using VisaFusion.Core.Application;

namespace VisaFusion.Api.Endpoints;

/// <summary>
/// Employee representative endpoint (SPEC-0003 T045, FR-004, AC-003).
///
/// `GET /api/v1/employee` returns a minimal stub list AND invokes the shared
/// Canada DOB rule (T038) to prove shared-Core wiring end-to-end: the same rule
/// resolves from the employee endpoint as from the Web service (TS-003).
///
/// Authorized for the employee role (emp/adm/su per migration plan §4.2).
/// </summary>
public static class EmployeeEndpoint
{
    public static async Task Handle(HttpContext context, ICanadaDobRule canadaDobRule)
    {
        // Invoke the shared business rule to prove shared-Core wiring (AC-003).
        var ruleResult = canadaDobRule.IsAdultForCanadaVisa(new DateOnly(1990, 1, 1));

        var items = new object[]
        {
            new { refno = 1, name = "stub", canadaAdultEligible = ruleResult },
        };

        context.Response.StatusCode = StatusCodes.Status200OK;
        context.Response.ContentType = "application/json";
        await context.Response.WriteAsJsonAsync(new RepresentativeListDto(items, items.Length));
    }
}