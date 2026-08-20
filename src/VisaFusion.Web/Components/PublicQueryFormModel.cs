using Microsoft.AspNetCore.Html;
using Microsoft.AspNetCore.Mvc.Rendering;
using System.Collections.Generic;

namespace VisaFusion.Web.Components;

/// <summary>
/// PublicQueryForm model for the _PublicQueryForm.cshtml component
/// </summary>
public sealed class PublicQueryFormModel
{
    public string Title { get; init; } = "Contact Us";
    public string Subtitle { get; init; } = "Send us your query and we'll get back to you";
    public string HeaderHtml { get; init; } = string.Empty;
    public string FooterHtml { get; init; } = string.Empty;
    public string CardClass { get; init; } = "shadow-sm";
    public string HeaderClass { get; init; } = string.Empty;
    public string BodyClass { get; init; } = string.Empty;
    public string FooterClass { get; init; } = string.Empty;

    public PublicQueryFormForm? Form { get; init; }
    public List<PublicQueryFormField> Fields { get; init; } = new();
    public PublicQueryFormSubmitButton SubmitButton { get; init; } = new() { Title = "Submit Query" };
    public string? BodyContent { get; init; }
}

/// <summary>
/// PublicQueryForm form definition
/// </summary>
public sealed class PublicQueryFormForm
{
    public string Id { get; init; } = "public-query-form";
    public string Action { get; init; } = "/api/v1/public/queries";
    public string Method { get; init; } = "post";
    public string CssClass { get; init; } = string.Empty;
    public bool UseFloatingLabels { get; init; } = false;
    public IHtmlContent AntiForgeryToken { get; init; } = new HtmlString("");
}

/// <summary>
/// PublicQueryForm field definition
/// </summary>
public sealed class PublicQueryFormField
{
    public string Name { get; init; } = string.Empty;
    public string Label { get; init; } = string.Empty;
    public FormFieldType Type { get; init; } = FormFieldType.Text;
    public string InputType { get; init; } = "text";
    public string Value { get; init; } = string.Empty;
    public string Placeholder { get; init; } = string.Empty;
    public string HelpText { get; init; } = string.Empty;
    public string CssClass { get; init; } = string.Empty;
    public string Autocomplete { get; init; } = string.Empty;
    public bool Required { get; init; } = false;
    public bool Disabled { get; init; } = false;
    public bool Multiple { get; init; } = false;
    public int? Rows { get; init; } = null;
    public int? MaxLength { get; init; } = null;
    public string Min { get; init; } = string.Empty;
    public string Max { get; init; } = string.Empty;
    public string Step { get; init; } = string.Empty;
    public string Pattern { get; init; } = string.Empty;
    public bool UseFloatingLabel { get; init; } = false;
    public List<FormFieldOption> Options { get; init; } = new();
}

/// <summary>
/// PublicQueryForm submit button definition
/// </summary>
public sealed class PublicQueryFormSubmitButton
{
    public string Title { get; init; } = "Submit Query";
    public string Icon { get; init; } = string.Empty;
    public string CssClass { get; init; } = "btn-primary btn-lg";
    public bool Disabled { get; init; } = false;
}