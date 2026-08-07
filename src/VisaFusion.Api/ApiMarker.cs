namespace VisaFusion.Api;

/// <summary>
/// Marker type for the VisaFusion.Api assembly. Used to register the Api
/// controllers with the single Web host (FR-002, T026): the Web process hosts
/// the /api/v1 controllers from VisaFusion.Api via AddApplicationPart.
/// </summary>
public static class ApiMarker
{
}
