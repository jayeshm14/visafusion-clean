using System.Collections.Generic;

namespace VisaFusion.Web.Components;

/// <summary>
/// PublicLanding hero section definition
/// </summary>
public sealed class PublicLandingHero
{
    public string Title { get; init; } = string.Empty;
    public string Subtitle { get; init; } = string.Empty;
    public string Icon { get; init; } = string.Empty;
    public List<PublicLandingAction> Actions { get; init; } = new();
}

/// <summary>
/// PublicLanding feature definition
/// </summary>
public sealed class PublicLandingFeature
{
    public string Title { get; init; } = string.Empty;
    public string Description { get; init; } = string.Empty;
    public string Icon { get; init; } = string.Empty;
    public string CardClass { get; init; } = "shadow-sm";
    public string ColClass { get; init; } = "col-md-6 col-lg-4";
    public List<PublicLandingAction> Actions { get; init; } = new();
}

/// <summary>
/// PublicLanding stat definition
/// </summary>
public sealed class PublicLandingStat
{
    public string Label { get; init; } = string.Empty;
    public string Value { get; init; } = string.Empty;
    public string Icon { get; init; } = string.Empty;
    public string CardClass { get; init; } = "shadow-sm";
    public string ColClass { get; init; } = "col-6 col-md-3";
    public string Description { get; init; } = string.Empty;
}

/// <summary>
/// PublicLanding action definition
/// </summary>
public sealed class PublicLandingAction
{
    public string Title { get; init; } = string.Empty;
    public string Url { get; init; } = string.Empty;
    public string Icon { get; init; } = string.Empty;
    public string CssClass { get; init; } = "btn-primary";
    public string OnClick { get; init; } = string.Empty;
}

/// <summary>
/// PublicLanding call-to-action section definition
/// </summary>
public sealed class PublicLandingCallToAction
{
    public string Title { get; init; } = string.Empty;
    public string Description { get; init; } = string.Empty;
    public string CardClass { get; init; } = "bg-primary text-white shadow-sm";
    public List<PublicLandingAction> Actions { get; init; } = new();
}

/// <summary>
/// PublicLanding model for the _PublicLanding.cshtml component
/// </summary>
public sealed class PublicLandingModel
{
    public string Title { get; init; } = "Welcome to VisaFusion";
    public string Subtitle { get; init; } = "Your trusted visa processing partner";
    public PublicLandingHero? Hero { get; init; }
    public List<PublicLandingFeature> Features { get; init; } = new();
    public List<PublicLandingStat> Stats { get; init; } = new();
    public string FeaturesTitle { get; init; } = "Our Services";
    public PublicLandingCallToAction? CallToAction { get; init; }
}