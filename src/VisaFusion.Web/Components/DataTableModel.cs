using Microsoft.AspNetCore.Html;
using System.Collections.Generic;

namespace VisaFusion.Web.Components;

/// <summary>
/// DataTable column definition
/// </summary>
public sealed class DataTableColumn
{
    public string Key { get; init; } = string.Empty;
    public string Title { get; init; } = string.Empty;
    public string Width { get; init; } = "auto";
    public bool Sortable { get; init; } = true;
    public string HeaderClass { get; init; } = string.Empty;
    public string CellClass { get; init; } = string.Empty;
    public Func<object, string>? Formatter { get; init; }
    public Func<object, Dictionary<string, object>, IHtmlContent>? Template { get; init; }
}

/// <summary>
/// DataTable row action definition
/// </summary>
public sealed class DataTableAction
{
    public string Name { get; init; } = string.Empty;
    public string Title { get; init; } = string.Empty;
    public string Icon { get; init; } = string.Empty;
    public string UrlTemplate { get; init; } = string.Empty;
    public string OnClick { get; init; } = string.Empty;
    public string CssClass { get; init; } = string.Empty;
}

/// <summary>
/// DataTable model for the _DataTable.cshtml component
/// </summary>
public sealed class DataTableModel
{
    public string Id { get; init; } = "data-table";
    public string AriaLabel { get; init; } = "Data table";
    public List<DataTableColumn> Columns { get; init; } = new();
    public List<Dictionary<string, object>> Rows { get; init; } = new();
    public bool ShowPagination { get; init; } = true;
    public int PageSize { get; init; } = 25;
    public int CurrentPage { get; init; } = 1;
    public int TotalRows { get; init; } = 0;
    public bool Sortable { get; init; } = true;
    public bool Searchable { get; init; } = true;
    public List<DataTableAction> RowActions { get; init; } = new();
    public string EmptyMessage { get; init; } = "No data available";
    public bool Striped { get; init; } = true;
    public bool Hover { get; init; } = true;
    public bool Bordered { get; init; } = false;
    public bool Small { get; init; } = false;
    public bool Responsive { get; init; } = true;
}