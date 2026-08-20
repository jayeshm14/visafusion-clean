using Microsoft.AspNetCore.Mvc.Rendering;
using System.Collections.Generic;

namespace VisaFusion.Web.Components;

/// <summary>
/// RoleDashboard KPI card definition
/// </summary>
public sealed class RoleDashboardKpiCard
{
    public string Label { get; init; } = string.Empty;
    public string Value { get; init; } = string.Empty;
    public string Icon { get; init; } = string.Empty;
    public string IconColor { get; init; } = "text-primary";
    public string Trend { get; init; } = string.Empty;
    public string CardClass { get; init; } = "shadow-sm";
    public string ColClass { get; init; } = "col-sm-6 col-xl-3";

    public bool TrendStartsWith(string prefix) => Trend?.StartsWith(prefix) == true;
}

/// <summary>
/// RoleDashboard chart definition
/// </summary>
public sealed class RoleDashboardChart
{
    public string Id { get; init; } = string.Empty;
    public string Title { get; init; } = string.Empty;
    public string Type { get; init; } = "line"; // line, bar, doughnut, radar, pie, polarArea
    public object Data { get; init; } = new { };
    public object Options { get; init; } = new { };
    public string CardClass { get; init; } = "shadow-sm";
    public string ColClass { get; init; } = "col-lg-6";
    public int Height { get; init; } = 300;
}

/// <summary>
/// RoleDashboard progress group definition
/// </summary>
public sealed class RoleDashboardProgressGroup
{
    public string Label { get; init; } = string.Empty;
    public int Value { get; init; } = 0;
    public int Max { get; init; } = 100;
    public string SubLabel { get; init; } = string.Empty;
    public bool Thin { get; init; } = true;
    public int Height { get; init; } = 8;
    public string ColorClass { get; init; } = "bg-primary";

    public int Percentage => Max > 0 ? (int)Math.Round((double)Value / Max * 100) : 0;
}

/// <summary>
/// RoleDashboard table definition
/// </summary>
public sealed class RoleDashboardTable
{
    public DataTableModel Table { get; init; } = new();
}

/// <summary>
/// RoleDashboard model for the _RoleDashboard.cshtml component
/// </summary>
public sealed class RoleDashboardModel
{
    public string Title { get; init; } = "Dashboard";
    public string Subtitle { get; init; } = string.Empty;

    /// <summary>
    /// Auto-encoded by Razor (rendered via <c>@Model.HeaderHtml</c>); plain
    /// text only — do not pass markup here. For raw markup use
    /// <see cref="BodyHtml"/> (which is rendered via <c>@Html.Raw</c> and
    /// therefore requires callers to pre-encode data values).
    /// </summary>
    public string HeaderHtml { get; init; } = string.Empty;

    /// <summary>
    /// Raw HTML rendered verbatim into the card body via <c>@Html.Raw</c>
    /// (see <c>_RoleDashboard.cshtml</c>). Callers MUST pre-encode every
    /// data value with <see cref="System.Net.WebUtility.HtmlEncode"/> before
    /// assignment — Razor will NOT encode this property. By contrast
    /// <c>HeaderHtml</c> and <c>FooterHtml</c> are auto-encoded by Razor and
    /// are therefore not suitable for arbitrary markup.
    /// </summary>
    public string BodyHtml { get; init; } = string.Empty;
    public string FooterHtml { get; init; } = string.Empty;
    public string CardClass { get; init; } = "shadow-sm";
    public string HeaderClass { get; init; } = string.Empty;
    public string BodyClass { get; init; } = string.Empty;
    public string FooterClass { get; init; } = string.Empty;
    public List<RoleDashboardKpiCard> KpiCards { get; init; } = new();
    public List<RoleDashboardChart> Charts { get; init; } = new();
    public List<RoleDashboardProgressGroup> ProgressGroups { get; init; } = new();
    public List<RoleDashboardTable> Tables { get; init; } = new();
}