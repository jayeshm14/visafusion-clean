namespace VisaFusion.Web.Components;

/// <summary>
/// ToastHost model for the _ToastHost.cshtml component
/// </summary>
public sealed class ToastHostModel
{
    public string ContainerId { get; init; } = "toast-container";
    public string Position { get; init; } = "top-end"; // top-start, top-center, top-end, bottom-start, bottom-center, bottom-end
    public bool AutoHide { get; init; } = true;
    public int Delay { get; init; } = 5000;
    public bool Animation { get; init; } = true;
    public int MaxToasts { get; init; } = 5;
}