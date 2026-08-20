using Microsoft.AspNetCore.Html;
using Microsoft.AspNetCore.Mvc.Rendering;
using System.Collections.Generic;

namespace VisaFusion.Web.Components;

/// <summary>
/// InfoPage card definition
/// </summary>
public sealed class InfoPageCard
{
    public string Title { get; init; } = string.Empty;
    public string Content { get; init; } = string.Empty;
    public string Icon { get; init; } = string.Empty;
    public string CardClass { get; init; } = string.Empty;
    public string ColClass { get; init; } = "col-md-6 col-lg-4";
    public List<InfoPageAction> Actions { get; init; } = new();
}

/// <summary>
/// InfoPage accordion item definition
/// </summary>
public sealed class InfoPageAccordionItem
{
    public string Title { get; init; } = string.Empty;
    public IHtmlContent Content { get; init; } = new HtmlString("");
    public bool IsOpen { get; init; } = false;
}

/// <summary>
/// InfoPage section definition
/// </summary>
public sealed class InfoPageSection
{
    public string Title { get; init; } = string.Empty;
    public IHtmlContent Content { get; init; } = new HtmlString("");
}

/// <summary>
/// InfoPage action definition
/// </summary>
public sealed class InfoPageAction
{
    public string Title { get; init; } = string.Empty;
    public string Url { get; init; } = string.Empty;
    public string Icon { get; init; } = string.Empty;
    public string CssClass { get; init; } = "btn-primary";
    public string OnClick { get; init; } = string.Empty;
}

/// <summary>
/// InfoPage model for the _InfoPage.cshtml component
/// </summary>
public sealed class InfoPageModel
{
    public string Id { get; init; } = "info-page";
    public string Title { get; init; } = string.Empty;
    public string Subtitle { get; init; } = string.Empty;
    public string Content { get; init; } = string.Empty;
    public string? HeaderHtml { get; init; }
    public string? BodyHtml { get; init; }
    public string? FooterHtml { get; init; }
    public string CardClass { get; init; } = "shadow-sm";
    public string HeaderClass { get; init; } = string.Empty;
    public string BodyClass { get; init; } = string.Empty;
    public string FooterClass { get; init; } = string.Empty;
    public List<InfoPageSection> Sections { get; init; } = new();
    public List<InfoPageCard> Cards { get; init; } = new();
    public List<InfoPageAccordionItem> AccordionItems { get; init; } = new();
    public DataTableModel? Table { get; init; }
    public List<InfoPageAction> Actions { get; init; } = new();
}