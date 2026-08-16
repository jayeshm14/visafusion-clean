using System.Text.Json;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using VisaFusion.Api.Contracts;
using VisaFusion.Api.Errors;
using VisaFusion.Core.Application;
using VisaFusion.Identity;

namespace VisaFusion.Api.Endpoints;

/// <summary>
/// Entries module endpoints (SPEC-0006 T027, US6, FR-008/FR-009, AC-007/AC-008/
/// AC-011; contracts/entries-api.md §1-§5). Backs the legacy pages
/// <c>makeEntry</c>, <c>insertEntry</c>, <c>editentry*</c>, <c>editdone</c>,
/// <c>sendawbgo</c>.
///
/// All five routes are gated by the <c>EntryOperations</c> policy (emp/adm/su)
/// wired in the host. Handlers follow the existing <c>AuthEndpoint</c> pattern:
/// <see cref="TryReadJsonAsync{T}"/> for the body, <see cref="WriteProblemAsync"/>
/// for standardized problem-details errors, and the shared Core
/// <see cref="IEntryService"/> for all business behavior (never the DbContext).
/// </summary>
public static class EntriesEndpoint
{
    /// <summary>POST /api/v1/entries — create entry (contract §1).</summary>
    public static async Task CreateAsync(HttpContext context, IEntryService entries)
    {
        var request = await TryReadJsonAsync<CreateEntryRequest>(context);
        if (request is null) return;

        try
        {
            // Allocate the refno atomically (US2), then create the aggregate (US1).
            var refno = await entries.AllocateRefnoAsync(context.RequestAborted);
            var result = await entries.CreateAsync(refno, ToCommand(request), context.RequestAborted);

            context.Response.StatusCode = StatusCodes.Status201Created;
            context.Response.ContentType = "application/json";
            await context.Response.WriteAsJsonAsync(new
            {
                refno = result.Refno,
                etag = Etag(result.RowVersion),
                entry = ToResponse(result.Entry),
            });
        }
        catch (EntryValidationException ex)
        {
            await WriteProblemAsync(context, StatusCodes.Status400BadRequest, "Validation Failed", ex.Message);
        }
        catch (EntryConflictException ex)
        {
            await WriteProblemAsync(context, StatusCodes.Status409Conflict, "Conflict", ex.Message);
        }
    }

    /// <summary>GET /api/v1/entries/{refno} — get entry (contract §2).</summary>
    public static async Task GetAsync(HttpContext context, IEntryService entries, int refno)
    {
        var aggregate = await entries.GetByRefnoAsync(refno, context.RequestAborted);
        if (aggregate is null)
        {
            await WriteProblemAsync(context, StatusCodes.Status404NotFound, "Not Found", $"Entry {refno} was not found.");
            return;
        }

        context.Response.StatusCode = StatusCodes.Status200OK;
        context.Response.ContentType = "application/json";
        await context.Response.WriteAsJsonAsync(ToResponse(aggregate));
    }

    /// <summary>PUT /api/v1/entries/{refno} — update entry with optimistic concurrency (contract §3).</summary>
    public static async Task UpdateAsync(HttpContext context, IEntryService entries, int refno)
    {
        var request = await TryReadJsonAsync<UpdateEntryRequest>(context);
        if (request is null) return;

        // If-Match is required (AC-011): the ETag is the current RowVersion as
        // base64, sent as an HTTP quoted-string (RFC 7232 §2.3.2).
        var ifMatch = context.Request.Headers.IfMatch.ToString();
        var expected = ParseEtag(ifMatch);
        if (expected is null)
        {
            await WriteProblemAsync(
                context, StatusCodes.Status400BadRequest, "Validation Failed",
                "If-Match header with the current ETag is required.");
            return;
        }

        try
        {
            var result = await entries.UpdateAsync(refno, ToCommand(request), expected, context.RequestAborted);

            context.Response.StatusCode = StatusCodes.Status200OK;
            context.Response.ContentType = "application/json";
            await context.Response.WriteAsJsonAsync(ToResponse(result.Entry));
        }
        catch (EntryValidationException ex)
        {
            await WriteProblemAsync(context, StatusCodes.Status400BadRequest, "Validation Failed", ex.Message);
        }
        catch (EntryNotFoundException ex)
        {
            await WriteProblemAsync(context, StatusCodes.Status404NotFound, "Not Found", ex.Message);
        }
        catch (EntryConflictException ex)
        {
            await WriteProblemAsync(context, StatusCodes.Status409Conflict, "Conflict", ex.Message);
        }
    }

    /// <summary>POST /api/v1/entries/{refno}/status — change entry status (contract §4).</summary>
    public static async Task ChangeStatusAsync(
        HttpContext context, IEntryService entries,
        UserManager<IdentityIntegration.VisaFusionUser> userManager, int refno)
    {
        var request = await TryReadJsonAsync<ChangeEntryStatusRequest>(context);
        if (request is null) return;

        // Resolve the authenticated caller's AspNetUsers.Id from the JWT `sub`
        // claim (which carries the username, IdentityClaims.cs:66) — never a
        // caller-supplied actor string (anti-spoofing, GR-0004).
        var userName = context.User.Identity?.Name;
        var user = string.IsNullOrEmpty(userName)
            ? null
            : await userManager.FindByNameAsync(userName);
        if (user is null)
        {
            await WriteProblemAsync(
                context, StatusCodes.Status401Unauthorized, "Unauthorized",
                "The authenticated principal does not resolve to a user.");
            return;
        }

        try
        {
            var result = await entries.RecordStatusChangeAsync(new RecordStatusChangeCommand(
                Refno: refno,
                PaxId: request.PaxId,
                CountryId: request.CountryId,
                NewStatusId: request.NewStatusId,
                Remarks: request.Remarks,
                ChangeDate: request.ChangeDate,
                ActorUserId: user.Id), context.RequestAborted);

            context.Response.StatusCode = StatusCodes.Status200OK;
            context.Response.ContentType = "application/json";
            await context.Response.WriteAsJsonAsync(new
            {
                statusHistoryId = result.StatusHistoryId,
                updatedBy = result.UpdatedBy,
            });
        }
        catch (EntryValidationException ex)
        {
            await WriteProblemAsync(context, StatusCodes.Status400BadRequest, "Validation Failed", ex.Message);
        }
        catch (EntryNotFoundException ex)
        {
            await WriteProblemAsync(context, StatusCodes.Status404NotFound, "Not Found", ex.Message);
        }
    }

    /// <summary>POST /api/v1/entries/{refno}/awb — record sent-AWB (contract §5).</summary>
    public static async Task RecordAwbAsync(HttpContext context, IEntryService entries, int refno)
    {
        var request = await TryReadJsonAsync<RecordAwbRequest>(context);
        if (request is null) return;

        try
        {
            await entries.RecordAwbAsync(refno, new RecordAwbCommand(
                Awb: request.Awb ?? string.Empty,
                ToEmail: request.ToEmail,
                Remark: request.Remark), context.RequestAborted);

            context.Response.StatusCode = StatusCodes.Status204NoContent;
        }
        catch (EntryValidationException ex)
        {
            await WriteProblemAsync(context, StatusCodes.Status400BadRequest, "Validation Failed", ex.Message);
        }
        catch (EntryNotFoundException ex)
        {
            await WriteProblemAsync(context, StatusCodes.Status404NotFound, "Not Found", ex.Message);
        }
    }

    private static CreateEntryCommand ToCommand(CreateEntryRequest r) => new(
        r.Paxname, r.Passportno, r.DateOfBirth, r.Category, r.TotalPassengers,
        r.TravelDate, r.Remarks, r.AgentInstruction);

    private static CreateEntryCommand ToCommand(UpdateEntryRequest r) => new(
        r.Paxname, r.Passportno, r.DateOfBirth, r.Category, r.TotalPassengers,
        r.TravelDate, r.Remarks, r.AgentInstruction);

    private static EntryResponse ToResponse(EntryAggregate a) => new()
    {
        Refno = a.Refno,
        Paxname = a.Paxname,
        Passportno = a.Passportno,
        Agent = a.Agent,
        Status = a.Status,
        TravelDate = a.TravelDate,
        Subdate = a.Subdate,
        Coldate = a.Coldate,
        Receivedate = a.Receivedate,
        SentDate = a.SentDate,
        TotalPassengers = a.TotalPassengers,
        Passengers = a.Passengers
            .Select(p => new EntryPassengerResponse
            {
                Id = p.Id, Paxname = p.Paxname, Passportno = p.Passportno,
                DateOfBirth = p.DateOfBirth, Category = p.Category,
            })
            .ToList(),
        PaxStatuses = a.PaxStatuses
            .Select(p => new PaxStatusResponse
            {
                PaxId = p.PaxId, CountryId = p.CountryId, StatusId = p.StatusId,
                Remarks = p.Remarks, Visafee = p.Visafee, Handlingfee = p.Handlingfee,
                Ddcharges = p.Ddcharges, Couriercharges = p.Couriercharges,
                Misccharges = p.Misccharges, Total = p.Total, VFSTTCharges = p.VFSTTCharges,
            })
            .ToList(),
        Etag = Etag(a.RowVersion),
    };

    /// <summary>RowVersion → base64 ETag (AC-011; contract §2 wire format).</summary>
    private static string Etag(byte[]? rowVersion)
        => rowVersion is null ? string.Empty : Convert.ToBase64String(rowVersion);

    /// <summary>
    /// Parses the If-Match header (an HTTP quoted-string, RFC 7232 §2.3.2) into
    /// the expected RowVersion bytes; null when absent or malformed.
    /// </summary>
    private static byte[]? ParseEtag(string ifMatch)
    {
        var value = ifMatch.Trim();
        if (value.Length >= 2 && value[0] == '"' && value[^1] == '"')
        {
            value = value[1..^1];
        }

        if (string.IsNullOrEmpty(value))
        {
            return null;
        }

        try
        {
            return Convert.FromBase64String(value);
        }
        catch (FormatException)
        {
            return null;
        }
    }

    private static async Task<T?> TryReadJsonAsync<T>(HttpContext context)
        where T : class
    {
        try
        {
            return await context.Request.ReadFromJsonAsync<T>();
        }
        catch (JsonException)
        {
            await WriteProblemAsync(
                context, StatusCodes.Status400BadRequest, "Validation Failed",
                "request body must be valid JSON");
            return null;
        }
    }

    private static async Task WriteProblemAsync(
        HttpContext context, int statusCode, string title, string detail)
    {
        context.Response.StatusCode = statusCode;
        context.Response.ContentType = "application/problem+json";
        var problem = ApiError.Create(statusCode, title, context);
        problem.Detail = detail;
        await context.Response.WriteAsync(JsonSerializer.Serialize(problem, JsonOptions));
    }

    private static readonly JsonSerializerOptions JsonOptions = new(JsonSerializerDefaults.Web);
}