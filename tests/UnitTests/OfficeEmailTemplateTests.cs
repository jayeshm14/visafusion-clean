using VisaFusion.Core.Application;

namespace VisaFusion.UnitTests;

/// <summary>
/// Office-email golden-file tests (SPEC-0008 T021, FR-008, AC-002; spec §23
/// golden-file scenario).
///
/// The office notification email payload is compared verbatim against the
/// legacy `contactsendpre.asp` template (verified in the repository root): the
/// subject (line 10), and HTML body (line 21) are preserved exactly. The
/// recipient is now configuration-driven (Notifications:OfficeEmail) with no
/// fallback (BR-005 — no credentials/addresses hard-coded in source). The
/// modern public form (SPEC-0007 contract §1) captures only name/email/
/// subject/message, so the legacy company/phone/fax/city fields render empty
/// and the anonymous sender label (" A User", lines 13-19 else-branch) applies
/// — the endpoint is anonymous by design.
/// </summary>
public class OfficeEmailTemplateTests
{
    [Fact]
    public void Subject_Matches_The_Legacy_Value()
    {
        // contactsendpre.asp line 10: strSubject="Query form UdaanIndia.com"
        Assert.Equal("Query form UdaanIndia.com", OfficeEmailTemplate.Subject);
    }

    [Fact]
    public void Body_Matches_The_Legacy_Contactsendpre_Template_Verbatim()
    {
        // contactsendpre.asp line 21, with the modern form's empty company/
        // phone/fax/city fields and the anonymous sender label.
        var body = OfficeEmailTemplate.BuildHtmlBody("John Doe", "john@example.com", "Hello office");

        Assert.Equal(
            "This Mail Has sent by <b> A User</b> from udaanindia.com please find detail about sender below.<br><br>"
            + "Name : John Doe<br>Company Name : <br>Phone : <br>Fax : <br>Email : john@example.com<br>City : <br><br>"
            + "<b>Message :</b><br><br>Hello office<br><br>",
            body);
    }

    [Fact]
    public void Body_Interpolates_The_Sender_Detail_Fields()
    {
        var body = OfficeEmailTemplate.BuildHtmlBody("Jane Smith", "jane@example.com", "Visa question");

        Assert.Contains("Name : Jane Smith", body);
        Assert.Contains("Email : jane@example.com", body);
        Assert.Contains("<b>Message :</b><br><br>Visa question<br><br>", body);
    }

    [Fact]
    public void Message_Text_Is_Not_Html_Encoded_By_The_Template()
    {
        // The legacy template concatenates the raw request value (no
        // Server.HTMLEncode in contactsendpre.asp line 21); the template
        // preserves that behavior verbatim — encoding is the presentation
        // layer's concern, exactly as in the legacy flow.
        var body = OfficeEmailTemplate.BuildHtmlBody("N", "e@x.com", "a < b & c");

        Assert.Contains("a < b & c", body);
    }
}