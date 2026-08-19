using System.ComponentModel.DataAnnotations;
using VisaFusion.Api.Endpoints;

namespace VisaFusion.UnitTests;

/// <summary>
/// Contact-query validation tests (SPEC-0008 T019, §17; SPEC-0007 contract
/// `public-api.md` §1). Runs the same shared DataAnnotations validation the
/// endpoint uses (PublicEndpoint.TryValidate) over the request shape: name,
/// email (valid format), subject, and message are all required with length
/// limits. The endpoint applies the result as a 400 problem-details response
/// (proven by QueriesEndpointTests).
/// </summary>
public class QueriesValidationTests
{
    private static bool TryValidate(QueriesRequest request, out string detail)
    {
        var results = new List<ValidationResult>();
        var isValid = Validator.TryValidateObject(
            request, new ValidationContext(request), results, validateAllProperties: true);
        detail = isValid
            ? ""
            : string.Join("; ", results.Select(r => r.ErrorMessage));
        return isValid;
    }

    [Fact]
    public void Valid_Request_Passes()
    {
        Assert.True(TryValidate(ValidRequest(), out _));
    }

    [Theory]
    [InlineData(null)]
    [InlineData("")]
    [InlineData("   ")]
    public void Missing_Or_Blank_Name_Fails(string? name)
    {
        var request = ValidRequest() with { Name = name };
        Assert.False(TryValidate(request, out _));
    }

    [Theory]
    [InlineData(null)]
    [InlineData("")]
    [InlineData("   ")]
    public void Missing_Or_Blank_Email_Fails(string? email)
    {
        var request = ValidRequest() with { Email = email };
        Assert.False(TryValidate(request, out _));
    }

    [Theory]
    [InlineData("not-an-email")]
    [InlineData("user@")]
    [InlineData("@example.com")]
    public void Invalid_Email_Format_Fails(string email)
    {
        var request = ValidRequest() with { Email = email };
        Assert.False(TryValidate(request, out _));
    }

    [Theory]
    [InlineData(null)]
    [InlineData("")]
    [InlineData("   ")]
    public void Missing_Or_Blank_Subject_Fails(string? subject)
    {
        var request = ValidRequest() with { Subject = subject };
        Assert.False(TryValidate(request, out _));
    }

    [Theory]
    [InlineData(null)]
    [InlineData("")]
    [InlineData("   ")]
    public void Missing_Or_Blank_Message_Fails(string? message)
    {
        var request = ValidRequest() with { Message = message };
        Assert.False(TryValidate(request, out _));
    }

    [Fact]
    public void Name_Over_256_Characters_Fails()
    {
        // The `queries.name` column caps at 256 (ConfigureContactQuery).
        var request = ValidRequest() with { Name = new string('x', 257) };
        Assert.False(TryValidate(request, out _));
    }

    [Fact]
    public void Email_Over_256_Characters_Fails()
    {
        // The `queries.email` column caps at 256 (ConfigureContactQuery).
        var request = ValidRequest() with { Email = $"{new string('x', 250)}@test.local" };
        Assert.False(TryValidate(request, out _));
    }

    [Fact]
    public void Subject_Over_256_Characters_Fails()
    {
        // The `queries.subject` column caps at 256 (ConfigureContactQuery).
        var request = ValidRequest() with { Subject = new string('s', 257) };
        Assert.False(TryValidate(request, out _));
    }

    [Fact]
    public void Message_Over_4000_Characters_Fails()
    {
        // Documented validation bound (message column is nvarchar(max); spec
        // §17 requires a length limit — 4000 per data-model.md §1).
        var request = ValidRequest() with { Message = new string('m', 4001) };
        Assert.False(TryValidate(request, out _));
    }

    [Fact]
    public void Message_At_4000_Characters_Passes()
    {
        var request = ValidRequest() with { Message = new string('m', 4000) };
        Assert.True(TryValidate(request, out _));
    }

    private static QueriesRequest ValidRequest() => new()
    {
        Name = "Test User",
        Email = "test@example.com",
        Subject = "Test subject",
        Message = "Test message",
    };
}