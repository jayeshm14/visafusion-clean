using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using VisaFusion.Core.Application;
using VisaFusion.Data.Persistence;
using VisaFusion.Data.Persistence.Entities;
using VisaFusion.Identity;

namespace VisaFusion.Api.Application;

/// <summary>
/// Agent lifecycle service (SPEC-0007 US1, FR-001..004, FR-022; AC-001,
/// AC-016, AC-017; contracts/agents-api.md §1/§6/§7).
///
/// Placed in VisaFusion.Api (approved deviation, deviation log §8): the atomic
/// create (BR-009) and the deactivate/reactivate lock (FR-004/FR-022) must
/// touch BOTH the legacy `agents` row (VisaEntryDbContext) AND the linked
/// Identity login (UserManager). VisaFusion.Data cannot reference
/// VisaFusion.Identity (Identity → Data is one-way; a reverse reference would
/// be a cycle), so the flow is hosted in the Api layer — the exact mirror of
/// the RegistrationFlow precedent (SPEC-0005 T040). The interface
/// (<see cref="IAgentService"/>) is the shared Core rule.
/// </summary>
public sealed class AgentService : IAgentService
{
    // The Active value convention (research.md R-007, verified against the live
    // database 2026-08-17): 'Y' = active, 'N' = deactivated. NULL rows (20 in
    // the live DB) are treated as active by the legacy app and are never
    // written by this service — only 'Y'/'N' are produced.
    private const string ActiveYes = "Y";
    private const string ActiveNo = "N";

    private readonly VisaEntryDbContext _db;
    private readonly UserManager<IdentityIntegration.VisaFusionUser> _userManager;

    public AgentService(
        VisaEntryDbContext db,
        UserManager<IdentityIntegration.VisaFusionUser> userManager)
    {
        _db = db;
        _userManager = userManager;
    }

    public async Task<AgentDetail> CreateAsync(
        AgentInput input, string username, string password,
        string actorUserId, string actorUserName, CancellationToken ct = default)
    {
        // Required fields (contracts/agents-api.md §6): companyname, username,
        // password. The username is the login identity — it must be present and
        // unique (CHK025).
        if (string.IsNullOrWhiteSpace(input.Companyname))
        {
            throw new AgentValidationException("companyname is required.");
        }

        username = username?.Trim() ?? string.Empty;
        if (string.IsNullOrWhiteSpace(username))
        {
            throw new AgentValidationException("username is required.");
        }

        if (string.IsNullOrWhiteSpace(password))
        {
            throw new AgentValidationException("password is required.");
        }

        // Duplicate username → 409 (contracts/agents-api.md §6, CHK025). The
        // check runs against the Identity store — the single source of truth
        // for login usernames.
        if (await _userManager.FindByNameAsync(username) is not null)
        {
            throw new AgentConflictException($"username '{username}' already exists.");
        }

        // 1. Agent row (Active = 'Y', R-007). The row is inserted and saved
        // FIRST so the Identity user can carry the AgentId claim link (BR-009).
        var agent = new Agent
        {
            Companyname = input.Companyname,
            Description = input.Description,
            Street1 = input.Street1,
            Street2 = input.Street2,
            Area = input.Area,
            City = input.City,
            Pincode = input.Pincode,
            Phoneno = input.Phoneno,
            Faxno = input.Faxno,
            Emailid = input.Emailid,
            Smsno = input.Smsno,
            Directorname = input.Directorname,
            DirectorPH = input.DirectorPH,
            AcMgrPH = input.AcMgrPH,
            VisaInchargeName = input.VisaInchargeName,
            VisaInchargePH = input.VisaInchargePH,
            Acno = input.Acno,
            Payment = input.Payment,
            TAAI = input.TAAI,
            TAFI = input.TAFI,
            Membership = input.Membership,
            IATA = input.IATA,
            Active = ActiveYes,
            Creationdate = DateTime.Now,
            Enteredby = actorUserName,
        };

        _db.Agents.Add(agent);
        await _db.SaveChangesAsync(ct);

        try
        {
            // 2. Linked agt login with the AgentId claim link (BR-009). The
            // password is hashed by the Identity store — never stored in
            // plaintext; delivered out-of-band (CHK002).
            var user = new IdentityIntegration.VisaFusionUser
            {
                UserName = username,
                Email = input.Emailid,
                AgentId = agent.Id,
            };

            var createResult = await _userManager.CreateAsync(user, password);
            if (!createResult.Succeeded)
            {
                var isDuplicate = createResult.Errors.Any(e => e.Code is "DuplicateUserName" or "DuplicateEmail");
                throw isDuplicate
                    ? new AgentConflictException($"username '{username}' already exists.")
                    : new AgentValidationException(
                        string.Join("; ", createResult.Errors.Select(e => e.Description)));
            }

            // 3. Role is fixed server-side to `agt` (BR-004) — no caller input
            // influences it.
            var roleResult = await _userManager.AddToRoleAsync(user, IdentityIntegration.Roles.Agent);
            if (!roleResult.Succeeded)
            {
                // Roll back the created user (RegistrationFlow precedent) so a
                // half-created login never blocks re-creation with a 409.
                await _userManager.DeleteAsync(user);
                throw new AgentValidationException(
                    string.Join("; ", roleResult.Errors.Select(e => e.Description)));
            }

            // 4. User-creation audit event (spec §19), same commit as the agent
            // row — the agent row is already saved, so the audit row is written
            // in its own commit; a failed audit write is logged, not fatal (the
            // agent + login are the business outcome).
            _db.AdminAuditLogs.Add(new AdminAuditLog
            {
                EventType = "UserCreated",
                ActorUserId = actorUserId,
                ActorUserName = actorUserName,
                TargetUserId = user.Id,
                TargetUserName = user.UserName,
                Role = IdentityIntegration.Roles.Agent,
                Date = DateTime.Now,
                Detail = $"agent {agent.Id} created with linked agt login",
            });
            await _db.SaveChangesAsync(ct);
        }
        catch
        {
            // Roll back the fresh unreferenced agent row (FR-004 allows deleting
            // unreferenced records): a failed create must never leave an agent
            // without its linked login (BR-009).
            _db.Agents.Remove(agent);
            await _db.SaveChangesAsync(ct);
            throw;
        }

        return ToDetail(agent);
    }

    public async Task<AgentDetail> UpdateAsync(int agentId, AgentInput patch, CancellationToken ct = default)
    {
        // At least one field required (contracts/agents-api.md §1).
        if (patch is null
            || string.IsNullOrWhiteSpace(patch.Companyname)
            && string.IsNullOrWhiteSpace(patch.Description)
            && string.IsNullOrWhiteSpace(patch.Street1)
            && string.IsNullOrWhiteSpace(patch.Street2)
            && string.IsNullOrWhiteSpace(patch.Area)
            && string.IsNullOrWhiteSpace(patch.City)
            && string.IsNullOrWhiteSpace(patch.Pincode)
            && string.IsNullOrWhiteSpace(patch.Phoneno)
            && string.IsNullOrWhiteSpace(patch.Faxno)
            && string.IsNullOrWhiteSpace(patch.Emailid)
            && string.IsNullOrWhiteSpace(patch.Smsno)
            && string.IsNullOrWhiteSpace(patch.Directorname)
            && string.IsNullOrWhiteSpace(patch.DirectorPH)
            && string.IsNullOrWhiteSpace(patch.AcMgrPH)
            && string.IsNullOrWhiteSpace(patch.VisaInchargeName)
            && string.IsNullOrWhiteSpace(patch.VisaInchargePH)
            && string.IsNullOrWhiteSpace(patch.Acno)
            && string.IsNullOrWhiteSpace(patch.Payment)
            && string.IsNullOrWhiteSpace(patch.TAAI)
            && string.IsNullOrWhiteSpace(patch.TAFI)
            && string.IsNullOrWhiteSpace(patch.Membership)
            && string.IsNullOrWhiteSpace(patch.IATA))
        {
            throw new AgentValidationException("at least one field is required.");
        }

        var agent = await _db.Agents.SingleOrDefaultAsync(a => a.Id == agentId, ct)
            ?? throw new AgentNotFoundException($"Agent {agentId} was not found.");

        // The lifecycle flag Active is NOT updatable here (contract §1) — it is
        // managed exclusively by DeactivateAsync/ReactivateAsync.
        agent.Companyname = patch.Companyname;
        agent.Description = patch.Description;
        agent.Street1 = patch.Street1;
        agent.Street2 = patch.Street2;
        agent.Area = patch.Area;
        agent.City = patch.City;
        agent.Pincode = patch.Pincode;
        agent.Phoneno = patch.Phoneno;
        agent.Faxno = patch.Faxno;
        agent.Emailid = patch.Emailid;
        agent.Smsno = patch.Smsno;
        agent.Directorname = patch.Directorname;
        agent.DirectorPH = patch.DirectorPH;
        agent.AcMgrPH = patch.AcMgrPH;
        agent.VisaInchargeName = patch.VisaInchargeName;
        agent.VisaInchargePH = patch.VisaInchargePH;
        agent.Acno = patch.Acno;
        agent.Payment = patch.Payment;
        agent.TAAI = patch.TAAI;
        agent.TAFI = patch.TAFI;
        agent.Membership = patch.Membership;
        agent.IATA = patch.IATA;

        await _db.SaveChangesAsync(ct);
        return ToDetail(agent);
    }

    public async Task<AgentDetail> DeactivateAsync(
        int agentId, string actorUserId, string actorUserName, CancellationToken ct = default)
    {
        var agent = await _db.Agents.SingleOrDefaultAsync(a => a.Id == agentId, ct)
            ?? throw new AgentNotFoundException($"Agent {agentId} was not found.");

        // Lock the linked login FIRST (FR-004): authentication must be rejected
        // the moment the deactivation is committed. The lock lives in the
        // Identity store (one source of truth for authentication); the Active
        // flag lives in the agent record (one source of truth for business
        // state) — both updated by this operation (spec §12).
        var user = await FindLinkedUserAsync(agentId, ct);
        if (user is not null)
        {
            user.LockoutEnabled = true;
            user.LockoutEnd = DateTimeOffset.MaxValue;
            await _userManager.UpdateAsync(user);
        }

        agent.Active = ActiveNo;
        _db.AdminAuditLogs.Add(new AdminAuditLog
        {
            EventType = "UserDeactivated",
            ActorUserId = actorUserId,
            ActorUserName = actorUserName,
            TargetUserId = user?.Id,
            TargetUserName = user?.UserName,
            Role = IdentityIntegration.Roles.Agent,
            Date = DateTime.Now,
            Detail = $"agent {agentId} deactivated",
        });
        await _db.SaveChangesAsync(ct);

        return ToDetail(agent);
    }

    public async Task<AgentDetail> ReactivateAsync(
        int agentId, string actorUserId, string actorUserName, CancellationToken ct = default)
    {
        var agent = await _db.Agents.SingleOrDefaultAsync(a => a.Id == agentId, ct)
            ?? throw new AgentNotFoundException($"Agent {agentId} was not found.");

        // Unlock the linked login FIRST (FR-022): authentication must be
        // restored the moment the reactivation is committed.
        var user = await FindLinkedUserAsync(agentId, ct);
        if (user is not null)
        {
            user.LockoutEnd = null;
            await _userManager.UpdateAsync(user);
        }

        agent.Active = ActiveYes;
        _db.AdminAuditLogs.Add(new AdminAuditLog
        {
            EventType = "UserReactivated",
            ActorUserId = actorUserId,
            ActorUserName = actorUserName,
            TargetUserId = user?.Id,
            TargetUserName = user?.UserName,
            Role = IdentityIntegration.Roles.Agent,
            Date = DateTime.Now,
            Detail = $"agent {agentId} reactivated",
        });
        await _db.SaveChangesAsync(ct);

        return ToDetail(agent);
    }

    public async Task<AgentDetail?> GetByIdAsync(int agentId, CancellationToken ct = default)
    {
        var agent = await _db.Agents.AsNoTracking()
            .SingleOrDefaultAsync(a => a.Id == agentId, ct);
        return agent is null ? null : ToDetail(agent);
    }

    public async Task<AgentListResult> ListAsync(
        int page, int pageSize, string? q, CancellationToken ct = default)
    {
        // Pagination bounds (contracts/agents-api.md General): default 50, max 200.
        if (page < 1) page = 1;
        if (pageSize < 1) pageSize = 50;
        if (pageSize > 200) pageSize = 200;

        var query = _db.Agents.AsNoTracking();
        if (!string.IsNullOrWhiteSpace(q))
        {
            // Keyword filter on name/company (contracts/agents-api.md §5).
            var needle = q.Trim();
            query = query.Where(a =>
                (a.Companyname != null && a.Companyname.Contains(needle))
                || (a.Description != null && a.Description.Contains(needle)));
        }

        var total = await query.CountAsync(ct);
        var items = await query
            .OrderBy(a => a.Companyname)
            .Skip((page - 1) * pageSize)
            .Take(pageSize)
            .ToListAsync(ct);

        return new AgentListResult(items.Select(ToDetail).ToList(), total);
    }

    public async Task<AgentPortalEntriesResult> GetPortalEntriesAsync(
        int agentId, int page, int pageSize, string? q, CancellationToken ct = default)
    {
        // Pagination bounds (contracts/agents-api.md General): default 50, max 200.
        if (page < 1) page = 1;
        if (pageSize < 1) pageSize = 50;
        if (pageSize > 200) pageSize = 200;

        // Own-agent scope only: Mainentry rows owned by the agent
        // (contracts/agents-api.md §3; legacy listforagents.asp joins
        // Mainentry x EntryDetails x Paxstatus on Mainentry.Agent = agentID).
        var query = _db.Entries.AsNoTracking().Where(e => e.Agent == agentId);
        if (!string.IsNullOrWhiteSpace(q))
        {
            var needle = q.Trim();
            // Keyword filter (FR-021, contracts/agents-api.md §3): paxname
            // substring (the legacy `Paxname LIKE '%q%'` filter) or an exact
            // refno when the keyword parses as an integer.
            if (int.TryParse(needle, out var refno))
            {
                query = query.Where(e => e.Refno == refno
                    || (e.Paxname != null && e.Paxname.Contains(needle)));
            }
            else
            {
                query = query.Where(e => e.Paxname != null && e.Paxname.Contains(needle));
            }
        }

        var total = await query.CountAsync(ct);
        var rows = await query
            .OrderByDescending(e => e.Refno) // legacy order by entryDetails.refno desc
            .Skip((page - 1) * pageSize)
            .Take(pageSize)
            .ToListAsync(ct);

        var descriptions = await StatusDescriptionsAsync(ct);
        return new AgentPortalEntriesResult(
            rows.Select(e => new AgentPortalEntry(
                e.Refno ?? 0,
                e.Paxname,
                e.Traveldate,
                e.Status,
                e.Status.HasValue && descriptions.TryGetValue(e.Status.Value, out var d) ? d : null))
            .ToList(),
            total);
    }

    public async Task<AgentPortalStatusesResult> GetPortalStatusesAsync(
        int agentId, string? q, CancellationToken ct = default)
    {
        // Legacy agentpaxStatus.asp: Paxstatus x EntryDetails x Mainentry on
        // paxid + refno, scoped to the agent's entries (Mainentry.Agent =
        // agentID). One row per pax-per-country status chain entry.
        var query =
            from ps in _db.PaxCountryStatuses.AsNoTracking()
            join p in _db.EntryPassengers.AsNoTracking() on ps.PaxId equals p.Id
            join e in _db.Entries.AsNoTracking() on p.Refno equals e.Refno
            where e.Agent == agentId
            select new
            {
                ps,
                e.Refno,
                Paxname = p.Paxname,
            };

        if (!string.IsNullOrWhiteSpace(q))
        {
            var needle = q.Trim();
            // Keyword filter (FR-021, contracts/agents-api.md §3a): paxname
            // substring or an exact refno when the keyword parses as an integer.
            if (int.TryParse(needle, out var refno))
            {
                query = query.Where(x => x.Refno == refno
                    || (x.Paxname != null && x.Paxname.Contains(needle)));
            }
            else
            {
                query = query.Where(x => x.Paxname != null && x.Paxname.Contains(needle));
            }
        }

        var rows = await query.ToListAsync(ct);
        var descriptions = await StatusDescriptionsAsync(ct);

        return new AgentPortalStatusesResult(rows.Select(x => new AgentPortalStatus(
            x.Paxname,
            x.Refno ?? 0,
            x.ps.CountryId,
            x.ps.StatusId,
            x.ps.StatusId.HasValue && descriptions.TryGetValue(x.ps.StatusId.Value, out var d) ? d : null,
            // Updated = the current status row's submission date (the date the
            // legacy page's row displays alongside the status).
            x.ps.Subdate))
        .ToList());
    }

    public async Task<AgentStatementResult> GetPortalStatementAsync(
        int agentId, CancellationToken ct = default)
    {
        // The agent's ledger (contracts/agents-api.md §4; legacy
        // agentStatement.asp reads `select * from ledger where agentid = ...`).
        // Ordered by entry date — the running `balance` column is meaningful
        // only in chronological order (the legacy page renders rows in the
        // same sequence the ledger stores them).
        var rows = await _db.LedgerHistory.AsNoTracking()
            .Where(l => l.AgentId == agentId)
            .OrderBy(l => l.EntrydateTime).ThenBy(l => l.Id)
            .ToListAsync(ct);

        return new AgentStatementResult(
            rows.Select(l => new AgentStatementLine(
                l.Id,
                l.EntrydateTime,
                l.Bank,
                l.TransactionType,
                l.Refno,
                l.Paxname,
                l.Reftype,
                l.Invno,
                l.Debit,
                l.Credit,
                l.Balance))
            .ToList(),
            rows.Sum(l => l.Debit),
            rows.Sum(l => l.Credit),
            // Running balance: the last line's balance (the closing figure the
            // legacy page's final row shows).
            rows.LastOrDefault()?.Balance);
    }

    /// <summary>statusID → description lookup for the status column rendering.</summary>
    private async Task<Dictionary<int, string>> StatusDescriptionsAsync(CancellationToken ct)
        => await _db.Statuses.AsNoTracking()
            .Where(s => s.Description != null)
            .ToDictionaryAsync(s => s.StatusId, s => s.Description!, ct);

    private async Task<IdentityIntegration.VisaFusionUser?> FindLinkedUserAsync(
        int agentId, CancellationToken ct)
    {
        // The AgentId claim link (BR-009): the agt login carries AgentId = the
        // agent's id. At most one agt user per agent is expected.
        return await _userManager.Users
            .SingleOrDefaultAsync(u => u.AgentId == agentId, ct);
    }

    private static AgentDetail ToDetail(Agent a) => new(
        a.Id,
        a.Companyname,
        a.Description,
        a.Street1,
        a.Street2,
        a.Area,
        a.City,
        a.Pincode,
        a.Phoneno,
        a.Faxno,
        a.Emailid,
        a.Smsno,
        a.Directorname,
        a.DirectorPH,
        a.AcMgrPH,
        a.VisaInchargeName,
        a.VisaInchargePH,
        a.Acno,
        a.Payment,
        a.TAAI,
        a.TAFI,
        a.Membership,
        a.IATA,
        a.Active,
        a.Creationdate,
        a.Enteredby);
}