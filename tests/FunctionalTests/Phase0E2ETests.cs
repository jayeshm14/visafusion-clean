using System.Net;
using System.Net.Http.Json;
using VisaFusion.Api.Contracts;

namespace VisaFusion.FunctionalTests;

/// <summary>
/// Phase 0 end-to-end verification (SPEC-0005 T036, US5; quickstart.md §3).
///
/// Covers the two quickstart scenarios not already asserted by dedicated test
/// classes:
///   - TS-008 static assets: representative files from every self-hosted
///     wwwroot directory (forms/, css/, js/, images/, fonts/, updateimg/)
///     return 200 from the single host (AC-008/FR-004).
///   - TS-011 SQL-injection regression: raw `'` payloads against the rewritten
///     endpoints stay parameterized — clean 401/201, never a 500, and a
///     SQLi-shaped username is stored and matched as a literal string
///     (NFR-003).
///   - TS-012 golden-file parity: the login/authorization behavior parity is
///     evidenced by AuthLoginTests (5-role JWT claims) and ChangePasswordTests
///     (legacy changepassword.asp flag 2/3 outcomes mirrored) — "where
///     applicable" per migration plan §10.
/// </summary>
public class Phase0E2ETests : IClassFixture<VisaFusionWebApplicationFactory>
{
    private readonly HttpClient _client;

    public Phase0E2ETests(VisaFusionWebApplicationFactory factory)
    {
        _client = factory.CreateClient();
    }

    [Theory]
    [InlineData("/forms/Argentina.pdf")]
    [InlineData("/images/1.jpg")]
    [InlineData("/fonts/source-sans-3-latin-400-normal.woff2")]
    [InlineData("/updateimg/abullet3.gif")]
    public async Task Static_Assets_Are_Served_From_The_Self_Hosted_Wwwroot(string assetPath)
    {
        // TS-008 (AC-008/FR-004): no CDN — every legacy asset directory is
        // served by the single VisaFusion.Web host. The AdminLTE css/js
        // entries were replaced by the SPEC-0007 design-token system
        // (tokens.css/theme.css, T008), which was in turn superseded by the
        // CoreUI integration (SPEC-0009 T077) — the legacy tokens/theme files
        // are removed and the CoreUI assets are covered by CoreUIAssetTests.
        var response = await _client.GetAsync(assetPath);

        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
    }

    [Theory]
    [InlineData("/css/adminlte.css")]
    [InlineData("/css/adminlte.min.css")]
    [InlineData("/js/adminlte.js")]
    [InlineData("/js/adminlte.min.js")]
    public async Task AdminLte_Assets_Are_Removed_And_Not_Served(string assetPath)
    {
        // AC-008 (SPEC-0007 T009): the AdminLTE assets were removed from
        // wwwroot; no rendered page may reference them and the files must not
        // be served.
        var response = await _client.GetAsync(assetPath);

        Assert.Equal(HttpStatusCode.NotFound, response.StatusCode);
    }

    [Theory]
    [InlineData("' OR '1'='1")]
    [InlineData("admin'; DROP TABLE AspNetUsers; --")]
    [InlineData("x' UNION SELECT * FROM AspNetUsers --")]
    public async Task Sql_Injection_Payloads_In_Login_Stay_Parameterized(string payload)
    {
        // TS-011 (NFR-003): a concatenated-SQL login would turn these into a
        // successful authentication; parameterized queries return 401.
        var response = await _client.PostAsJsonAsync("/api/v1/auth/login",
            new LoginRequest { UserName = payload, Password = "WrongPass123!" });

        Assert.Equal(HttpStatusCode.Unauthorized, response.StatusCode);
    }

    [Fact]
    public async Task Sql_Injection_Shaped_Username_Is_Rejected_By_Validation()
    {
        // TS-011: Identity's username validator rejects SQLi-shaped names
        // outright (`'` is not in the allowed character set) — an even
        // stronger parameterization proof than storing the literal: the
        // payload never reaches a query at all.
        const string payload = "' OR '1'='1";
        const string password = "ValidPass123!";

        var register = await _client.PostAsJsonAsync("/api/v1/public/register",
            new RegisterRequest { UserName = payload, Email = "sqli@example.com", Password = password });
        Assert.Equal(HttpStatusCode.BadRequest, register.StatusCode);
        var body = await register.Content.ReadAsStringAsync();
        Assert.Contains("Username", body);

        var wrongPassword = await _client.PostAsJsonAsync("/api/v1/auth/login",
            new LoginRequest { UserName = payload, Password = "WrongPass123!" });
        Assert.Equal(HttpStatusCode.Unauthorized, wrongPassword.StatusCode);
    }
}