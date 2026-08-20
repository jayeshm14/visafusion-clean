using Microsoft.AspNetCore.Mvc.Rendering;

namespace VisaFusion.Web.Components;

/// <summary>
/// ConfirmModal model for the _ConfirmModal.cshtml component
/// </summary>
public sealed class ConfirmModalModel
{
    public string Id { get; init; } = "confirm-modal";
    public string Title { get; init; } = "Confirm Action";
    public string Message { get; init; } = "Are you sure you want to proceed?";
    public string Description { get; init; } = string.Empty;
    public string Icon { get; init; } = "M8 12a4 4 0 1 0 0-8 4 4 0 0 0 0 8zm0 1a5 5 0 1 0 0-10 5 5 0 0 0 0 10z"; // warning triangle
    public string IconColor { get; init; } = "text-warning";
    public string ConfirmText { get; init; } = "Confirm";
    public string CancelText { get; init; } = "Cancel";
    public string ConfirmCssClass { get; init; } = "btn-danger";
    public string CancelCssClass { get; init; } = "btn-secondary";
    public string Size { get; init; } = "modal-md";
    public bool Centered { get; init; } = false;
    public bool Scrollable { get; init; } = false;
    public bool StaticBackdrop { get; init; } = false;
    public bool Keyboard { get; init; } = true;
    public string ConfirmOnClick { get; init; } = string.Empty;
    public string BodyHtml { get; init; } = string.Empty;
}