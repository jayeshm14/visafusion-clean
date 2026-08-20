using Microsoft.AspNetCore.Html;
using Microsoft.AspNetCore.Mvc.Rendering;
using System.Collections.Generic;

namespace VisaFusion.Web.Components;

/// <summary>
/// FormCard action types
/// </summary>
public enum FormCardActionType
{
    Submit,
    Button,
    Link
}

/// <summary>
/// FormCard action definition
/// </summary>
public sealed class FormCardAction
{
    public string Title { get; init; } = string.Empty;
    public string Icon { get; init; } = string.Empty;
    public string Url { get; init; } = string.Empty;
    public string OnClick { get; init; } = string.Empty;
    public string CssClass { get; init; } = string.Empty;
    public bool Disabled { get; init; } = false;
    public FormCardActionType Type { get; init; } = FormCardActionType.Button;
}

/// <summary>
/// Form field types
/// </summary>
public enum FormFieldType
{
    Text,
    Email,
    Password,
    Number,
    Date,
    DateTime,
    Time,
    Hidden,
    Checkbox,
    Switch,
    Radio,
    CheckboxList,
    Select,
    TextArea,
    File
}

/// <summary>
/// Form field option for select/radio/checkbox
/// </summary>
public sealed class FormFieldOption
{
    public string Value { get; init; } = string.Empty;
    public string Text { get; init; } = string.Empty;
}

/// <summary>
/// Form field definition
/// </summary>
public sealed class FormField
{
    public string Name { get; init; } = string.Empty;
    public string Label { get; init; } = string.Empty;
    public FormFieldType Type { get; init; } = FormFieldType.Text;
    public string InputType { get; init; } = "text";
    public string Value { get; init; } = string.Empty;
    public string Placeholder { get; init; } = string.Empty;
    public string HelpText { get; init; } = string.Empty;
    public string CssClass { get; init; } = string.Empty;
    public string ColClass { get; init; } = "col-md-6";
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
    public List<string> SelectedValues { get; init; } = new();
}

/// <summary>
/// FormCard section definition
/// </summary>
public sealed class FormCardSection
{
    public string Title { get; init; } = string.Empty;
    public string CssClass { get; init; } = string.Empty;
    public List<FormField> Fields { get; init; } = new();
}

/// <summary>
/// Form definition for FormCard
/// </summary>
public sealed class FormCardForm
{
    public string Id { get; init; } = string.Empty;
    public string Action { get; init; } = string.Empty;
    public string Method { get; init; } = "post";
    public string CssClass { get; init; } = string.Empty;
    public bool UseFloatingLabels { get; init; } = false;
    public IHtmlContent AntiForgeryToken { get; init; } = new HtmlString("");
}

/// <summary>
/// FormCard model for the _FormCard.cshtml component
/// </summary>
public sealed class FormCardModel
{
    public string Id { get; init; } = "form-card";
    public string Title { get; init; } = string.Empty;
    public string Subtitle { get; init; } = string.Empty;
    public string CardClass { get; init; } = string.Empty;
    public string HeaderClass { get; init; } = string.Empty;
    public string BodyClass { get; init; } = string.Empty;
    public string FooterClass { get; init; } = string.Empty;
    public List<FormCardAction> HeaderActions { get; init; } = new();
    public List<FormCardSection> Sections { get; init; } = new();
    public List<FormCardAction> FooterActions { get; init; } = new();
    public FormCardForm? Form { get; init; }
    public IHtmlContent BodyContent { get; init; } = new HtmlString("");
}