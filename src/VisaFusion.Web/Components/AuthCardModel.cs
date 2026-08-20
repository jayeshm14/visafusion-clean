using Microsoft.AspNetCore.Html;
using Microsoft.AspNetCore.Mvc.Rendering;
using System.Collections.Generic;

namespace VisaFusion.Web.Components;

/// <summary>
/// AuthCard social button definition
/// </summary>
public sealed class AuthCardSocialButton
{
    public string Title { get; init; } = string.Empty;
    public string Icon { get; init; } = string.Empty;
    public string Url { get; init; } = string.Empty;
    public string OnClick { get; init; } = string.Empty;
    public string CssClass { get; init; } = "btn-outline-secondary";
}

/// <summary>
/// AuthCard footer link definition
/// </summary>
public sealed class AuthCardFooterLink
{
    public string Text { get; init; } = string.Empty;
    public string Url { get; init; } = string.Empty;
    public string OnClick { get; init; } = string.Empty;
    public string CssClass { get; init; } = "text-decoration-none";
}

/// <summary>
/// AuthCard submit button definition
/// </summary>
public sealed class AuthCardSubmitButton
{
    public string Title { get; init; } = "Submit";
    public string Icon { get; init; } = string.Empty;
    public string CssClass { get; init; } = "btn-primary btn-lg";
    public bool Disabled { get; init; } = false;
}

/// <summary>
/// AuthCard model for the _AuthCard.cshtml component
/// </summary>
public sealed class AuthCardModel
{
    public string Id { get; init; } = "auth-card";
    public string Title { get; init; } = string.Empty;
    public string Subtitle { get; init; } = string.Empty;
    public string CardClass { get; init; } = "shadow-sm";
    public string HeaderClass { get; init; } = string.Empty;
    public string BodyClass { get; init; } = string.Empty;
    public string FooterClass { get; init; } = string.Empty;
    public string Illustration { get; init; } = string.Empty;
    public string? HeaderHtml { get; init; }
    public string? FooterHtml { get; init; }
    public IHtmlContent BodyContent { get; init; } = new HtmlString("");

    public AuthCardForm? Form { get; init; }
    public List<AuthCardField> Fields { get; init; } = new();

    /// <summary>
    /// Server-side validation summary rendered at the top of the form
    /// (ModelState errors, e.g. <c>Html.ValidationSummary(true)</c>). Empty by
    /// default so existing consumers are unaffected.
    /// </summary>
    public IHtmlContent ValidationSummary { get; init; } = new HtmlString("");
    public bool ShowPasswordToggle { get; init; } = true;
    public bool RememberMe { get; init; } = false;
    public AuthCardSubmitButton SubmitButton { get; init; } = new() { Title = "Sign in" };
    public List<AuthCardSocialButton> SocialButtons { get; init; } = new();
    public List<AuthCardFooterLink> FooterLinks { get; init; } = new();
}

/// <summary>
/// AuthCard form definition
/// </summary>
public sealed class AuthCardForm
{
    public string Id { get; init; } = string.Empty;
    public string Action { get; init; } = string.Empty;
    public string Method { get; init; } = "post";
    public string CssClass { get; init; } = string.Empty;
    public bool UseFloatingLabels { get; init; } = false;
    public IHtmlContent AntiForgeryToken { get; init; } = new HtmlString("");
}

/// <summary>
/// AuthCard field definition
/// </summary>
public sealed class AuthCardField
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
    public int? MaxLength { get; init; } = null;
}