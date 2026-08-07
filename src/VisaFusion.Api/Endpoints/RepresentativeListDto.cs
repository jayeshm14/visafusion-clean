namespace VisaFusion.Api.Endpoints;

/// <summary>
/// Representative read-only list DTO (SPEC-0003 T045,
/// contracts/api-v1-scaffolding.md §2).
/// </summary>
public sealed record RepresentativeListDto(object[] Items, int Count);