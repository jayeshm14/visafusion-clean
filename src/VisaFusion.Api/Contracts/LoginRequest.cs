using System.ComponentModel.DataAnnotations;

namespace VisaFusion.Api.Contracts;

/// <summary>Request body for POST /api/v1/auth/login (SPEC-0005 §15, contracts/auth-api.md §1).</summary>
public sealed record LoginRequest
{
    [Required]
    public string? UserName { get; init; }

    [Required]
    public string? Password { get; init; }
}
