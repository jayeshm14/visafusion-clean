using System.ComponentModel.DataAnnotations;

namespace VisaFusion.Api.Contracts;

/// <summary>
/// Request body for POST /api/v1/public/register (SPEC-0005 §9 FR-012, §15). The role
/// is fixed server-side to "guest"; a privileged role in the payload is ignored or
/// rejected — never assigned.
/// </summary>
public sealed record RegisterRequest
{
    [Required, MaxLength(256)]
    public string? UserName { get; init; }

    [Required, MaxLength(256)]
    public string? Email { get; init; }

    [Required]
    public string? Password { get; init; }
}
