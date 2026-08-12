using System.ComponentModel.DataAnnotations;

namespace VisaFusion.Api.Contracts;

/// <summary>
/// Request body for POST /api/v1/auth/change-password (SPEC-0005 §9 FR-019, §15).
/// NewPassword must meet the password policy (minimum 8 characters, no forced
/// complexity) and must equal ConfirmPassword.
/// </summary>
public sealed record ChangePasswordRequest
{
    [Required]
    public string? CurrentPassword { get; init; }

    [Required]
    public string? NewPassword { get; init; }

    [Required]
    public string? ConfirmPassword { get; init; }
}
