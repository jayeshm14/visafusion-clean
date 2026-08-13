using Microsoft.EntityFrameworkCore;
using VisaFusion.Core.Application;
using VisaFusion.Data.Application;
using VisaFusion.Data.Persistence;
using VisaFusion.Data.Persistence.Entities;
using VisaFusion.Identity;

namespace VisaFusion.UnitTests;

/// <summary>
/// Day-gate evaluation unit tests (SPEC-0005 T016, US2, AC-011/TS-013, FR-018).
///
/// Exercises the real <see cref="SecurityGateService"/> (VisaFusion.Data) over
/// a hermetic EF InMemory <see cref="VisaEntryDbContext"/>:
///   - open day (row for the date with `closingtime IS NULL`) → Allowed,
///   - no row for the date → RejectedNotOpened (`rsn=O`),
///   - row with a closing time set → RejectedNotOpened — the SAME outcome as no
///     row, proving `rsn=C` is never produced (legacy dead code, AC-011),
///   - non-emp roles are never gated,
///   - the day match is exact (a row on another day does not open today).
/// </summary>
public class SecurityGateServiceTests
{
    private static readonly DateTime Date = new(2026, 8, 13);

    [Fact]
    public async Task Open_Day_Allows_Employee_Login()
    {
        var service = NewService(
            new SecurityDay { Date1 = Date, Openingtime = Date.AddHours(9), Openby = "demo" });

        var decision = await service.EvaluateAsync(EmployeeRoles, Date);

        Assert.Equal(SecurityGateDecision.Allowed, decision);
    }

    [Fact]
    public async Task No_Row_For_The_Date_Rejects_Employee_Login()
    {
        var service = NewService();

        var decision = await service.EvaluateAsync(EmployeeRoles, Date);

        Assert.Equal(SecurityGateDecision.RejectedNotOpened, decision);
    }

    [Fact]
    public async Task Closed_Row_Rejects_With_The_Same_Outcome_As_No_Row()
    {
        // AC-011/TS-013: a row whose closing time is set is excluded by the
        // legacy WHERE clause (`closingtime is null`), so it rejects with
        // rsn=O exactly like no row at all — rsn=C is never produced.
        var closed = NewService(
            new SecurityDay { Date1 = Date, Openingtime = Date.AddHours(9), Openby = "demo", Closingtime = Date.AddHours(18), Closedby = "demo" });
        var empty = NewService();

        var closedDecision = await closed.EvaluateAsync(EmployeeRoles, Date);
        var emptyDecision = await empty.EvaluateAsync(EmployeeRoles, Date);

        Assert.Equal(SecurityGateDecision.RejectedNotOpened, closedDecision);
        Assert.Equal(closedDecision, emptyDecision);
    }

    [Fact]
    public async Task Non_Employee_Roles_Are_Never_Gated()
    {
        var service = NewService(); // no security rows at all

        foreach (var roles in new[]
        {
            new[] { IdentityIntegration.Roles.Admin },
            new[] { IdentityIntegration.Roles.SuperUser },
            new[] { IdentityIntegration.Roles.Agent },
            new[] { IdentityIntegration.Roles.Guest },
        })
        {
            Assert.Equal(SecurityGateDecision.Allowed, await service.EvaluateAsync(roles, Date));
        }
    }

    [Fact]
    public async Task Employee_Role_Check_Is_Case_Insensitive()
    {
        var service = NewService();

        var decision = await service.EvaluateAsync(new[] { "EMP" }, Date);

        Assert.Equal(SecurityGateDecision.RejectedNotOpened, decision);
    }

    [Fact]
    public async Task Row_On_Another_Day_Does_Not_Open_Today()
    {
        var service = NewService(
            new SecurityDay { Date1 = Date.AddDays(1), Openingtime = Date.AddHours(9), Openby = "demo" });

        var decision = await service.EvaluateAsync(EmployeeRoles, Date);

        Assert.Equal(SecurityGateDecision.RejectedNotOpened, decision);
    }

    [Fact]
    public async Task Null_Roles_Are_Not_Gated()
    {
        var service = NewService();

        var decision = await service.EvaluateAsync(null!, Date);

        Assert.Equal(SecurityGateDecision.Allowed, decision);
    }

    private static SecurityGateService NewService(params SecurityDay[] days)
    {
        var options = new DbContextOptionsBuilder<VisaEntryDbContext>()
            .UseInMemoryDatabase($"security-gate-{Guid.NewGuid():N}")
            .Options;
        var db = new VisaEntryDbContext(options);
        db.SecurityDays.AddRange(days);
        db.SaveChanges();
        return new SecurityGateService(db);
    }

    private static readonly string[] EmployeeRoles = { IdentityIntegration.Roles.Employee };
}