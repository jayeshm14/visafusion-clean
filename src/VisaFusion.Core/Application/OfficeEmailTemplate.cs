namespace VisaFusion.Core.Application;

/// <summary>
/// Office notification email for a persisted contact query (SPEC-0008 FR-008,
/// AC-002; legacy `contactus.asp` → `contactsendpre.asp`, §6.12).
///
/// The legacy template (contactsendpre.asp, verified verbatim) is preserved
/// exactly: subject, and the HTML body with the sender-details block
/// and the message text. The modern public form (SPEC-0007 contract
/// `public-api.md` §1) captures only name/email/subject/message, so the legacy
/// company/phone/fax/city fields render empty and the sender label is the
/// legacy anonymous fallback (" A User") — the endpoint is anonymous by design
/// (BR-004). The request subject is persisted to the `queries` table only; the
/// legacy email had no subject input and the office email keeps the legacy
/// subject verbatim.
///
/// The recipient address MUST be configured via `Notifications:OfficeEmail` in
/// appsettings / User Secrets / Key Vault (BR-005 — no credentials/addresses
/// hard-coded in source). There is no fallback; the application will fail to
/// start if the key is missing.
/// </summary>
public static class OfficeEmailTemplate
{
    /// <summary>Legacy email subject (contactsendpre.asp line 10).</summary>
    public const string Subject = "Query form UdaanIndia.com";

    /// <summary>
    /// Legacy anonymous sender label (contactsendpre.asp lines 13-19, else
    /// branch): the public queries endpoint carries no priv/uid, so the
    /// fallback label applies.
    /// </summary>
    public const string AnonymousSenderLabel = " A User";

    /// <summary>
    /// Builds the HTML body exactly as the legacy template does
    /// (contactsendpre.asp line 21). The modern form has no company/phone/fax/
    /// city inputs, so those fields are empty; the message text is the request
    /// message.
    /// </summary>
    public static string BuildHtmlBody(string name, string email, string message)
        => "This Mail Has sent by <b>" + AnonymousSenderLabel
           + "</b> from udaanindia.com please find detail about sender below.<br><br>"
           + "Name : " + name
           + "<br>Company Name : <br>Phone : <br>Fax : <br>Email : " + email
           + "<br>City : <br><br><b>Message :</b><br><br>" + message + "<br><br>";
}