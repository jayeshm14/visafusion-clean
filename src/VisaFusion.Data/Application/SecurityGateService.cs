using Microsoft.EntityFrameworkCore;
using VisaFusion.Core.Application;
using VisaFusion.Data.Persistence;

namespace VisaFusion.Data.Application;

/// <summary>
/// Day-gate evaluation over the legacy `security` table (SPEC-0005 T018,
/// FR-018; data-model.md §2.1). Read-only (constitution Principle III): the
/// gate only queries <see cref="SecurityDay"/> via
/// <see cref="VisaEntryDbContext"/> — it never writes.
///
/// Placed in VisaFusion.Data (approved deviation, deviation log §5): the
/// interface is the shared Core rule, but the query needs VisaEntryDbContext,
/// which Core cannot reference (one-way Data → Core).
/// </summary>
public sealed class SecurityGateService : ISecurityGateService
{
    // "emp" is carried over verbatim from `Udaan_users.privilege`. The literal
    // is duplicated here because VisaFusion.Data cannot reference
    // VisaFusion.Identity (Identity → Data is one-way; a reverse reference
    // would be a cycle) — `IdentityIntegration.Roles.Employee` is the canonical
    // definition.
    private const string EmployeeRole = "emp";

    private readonly VisaEntryDbContext _db;

    public SecurityGateService(VisaEntryDbContext db) => _db = db;

    public async Task<SecurityGateDecision> EvaluateAsync(IEnumerable<string> roles, DateTime date)
    {
        // The gate applies to emp logins only (authenticate.asp lines 62–79).
        if (roles?.Contains(EmployeeRole, StringComparer.OrdinalIgnoreCase) != true)
        {
            return SecurityGateDecision.Allowed;
        }

        // Legacy query (authenticate.asp line 68): a row for today where
        // `closingtime is null`. Rows with a closing time set are excluded by
        // the WHERE clause, so a closed row yields the same rejection (rsn=O)
        // as no row at all — rsn=C is never produced (AC-011/TS-013).
        var openDay = await _db.SecurityDays.AnyAsync(s =>
            s.Date1 != null
            && s.Date1.Value.Year == date.Year
            && s.Date1.Value.Month == date.Month
            && s.Date1.Value.Day == date.Day
            && s.Closingtime == null);

        return openDay ? SecurityGateDecision.Allowed : SecurityGateDecision.RejectedNotOpened;
    }
}