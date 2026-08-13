using VisaFusion.Web.Middleware;

namespace VisaFusion.UnitTests;

/// <summary>
/// Legacy URL rewrite mapping tests (SPEC-0005 T032, US5, AC-007/TS-007,
/// FR-003; contracts/web-ui.md §2).
///
/// Asserts the explicit, documented mapping table:
///   - `Default.asp` → `/`,
///   - `authenticate.asp`, `logon.asp` → `/Auth/Login`,
///   - `regsub*.asp` → `/Auth/Register`,
///   - any other `.asp` path → handled with no target (the middleware 404s it —
///     no wildcard forwarding, NFR-005),
///   - anything else passes through untouched.
/// Legacy IIS is case-insensitive, so matching is case-insensitive.
/// </summary>
public class LegacyUrlRewriteTests
{
    [Theory]
    [InlineData("/Default.asp", "/")]
    [InlineData("/DEFAULT.ASP", "/")]
    [InlineData("/authenticate.asp", "/Auth/Login")]
    [InlineData("/logon.asp", "/Auth/Login")]
    [InlineData("/regsub.asp", "/Auth/Register")]
    [InlineData("/regsubmit.asp", "/Auth/Register")]
    [InlineData("/regsubdone.asp", "/Auth/Register")]
    [InlineData("/auth/regsub.asp", "/Auth/Register")]
    public void Known_Entry_Url_Resolves_To_Its_Target(string path, string expectedTarget)
    {
        var (handled, target) = LegacyUrlRewriteMiddleware.Resolve(path);

        Assert.True(handled);
        Assert.Equal(expectedTarget, target);
    }

    [Theory]
    [InlineData("/unknownLegacyPage.asp")]
    [InlineData("/some/deep/path/page.asp")]
    public void Unknown_Asp_Url_Is_Handled_With_No_Target(string path)
    {
        // NFR-005: unknown/ambiguous legacy URLs must produce a clear 404,
        // never a silent redirect to an unrelated page — the middleware
        // responds itself (handled = true) with no redirect target.
        var (handled, target) = LegacyUrlRewriteMiddleware.Resolve(path);

        Assert.True(handled);
        Assert.Null(target);
    }

    [Theory]
    [InlineData("/")]
    [InlineData("/index.html")]
    [InlineData("/css/site.css")]
    [InlineData("/forms/embassy.pdf")]
    [InlineData("/api/v1/health")]
    [InlineData("/Default.aspx")]
    public void Non_Asp_Path_Passes_Through(string path)
    {
        var (handled, target) = LegacyUrlRewriteMiddleware.Resolve(path);

        Assert.False(handled);
        Assert.Null(target);
    }
}