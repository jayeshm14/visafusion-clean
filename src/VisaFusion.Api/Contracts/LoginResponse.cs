namespace VisaFusion.Api.Contracts;

/// <summary>
/// Response body for POST /api/v1/auth/login (SPEC-0005 §15, FR-007/FR-008;
/// contracts/auth-api.md §1). Carries the JWT plus the claims it was minted
/// with: `token`, `username`, `roles` (the effective role set — `su` expands
/// to `su` + `adm`, FR-008), and the claim-bound `AgentId` (present only for
/// `agt` principals, FR-007).
/// </summary>
public sealed record LoginResponse(
    string Token,
    string UserName,
    IReadOnlyList<string> Roles,
    int? AgentId);
