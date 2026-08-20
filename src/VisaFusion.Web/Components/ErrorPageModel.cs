using Microsoft.AspNetCore.Html;
using Microsoft.AspNetCore.Mvc.Rendering;
using System.Collections.Generic;

namespace VisaFusion.Web.Components;

/// <summary>
/// ErrorPage action definition
/// </summary>
public sealed class ErrorPageAction
{
    public string Title { get; init; } = string.Empty;
    public string Url { get; init; } = string.Empty;
    public string Icon { get; init; } = string.Empty;
    public string CssClass { get; init; } = "btn-primary";
    public string OnClick { get; init; } = string.Empty;
}

/// <summary>
/// ErrorPage model for the _ErrorPage.cshtml component
/// </summary>
public sealed class ErrorPageModel
{
    public int ErrorCode { get; init; } = 500;
    public string Title { get; init; } = string.Empty;
    public string Message { get; init; } = string.Empty;
    public string Description { get; init; } = string.Empty;
    public string Details { get; init; } = string.Empty;
    public bool ShowDetails { get; init; } = false;
    public string Illustration { get; init; } = string.Empty;
    public string FooterText { get; init; } = string.Empty;
    public IHtmlContent FooterHtml { get; init; } = new HtmlString("");
    public string CardClass { get; init; } = "shadow-sm";
    public List<ErrorPageAction> Actions { get; init; } = new();
}