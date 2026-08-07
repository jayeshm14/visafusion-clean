using VisaFusion.Identity;

namespace VisaFusion.UnitTests;

/// <summary>
/// Identity store contract test (SPEC-0003 T049, User Story 5, FR-007).
///
/// Asserts VisaFusion.Identity compiles against the ASP.NET Core Identity store
/// contract: the integration point exposes the user type and the legacy role
/// names carried over from `Udaan_users.privilege` (migration plan §4.1).
/// </summary>
public class IdentityIntegrationTests
{
    [Fact]
    public void Identity_User_Type_Is_An_IdentityUser()
    {
        var user = new IdentityIntegration.VisaFusionUser();

        // IdentityUser auto-generates a GUID id on instantiation.
        Assert.IsAssignableFrom<Microsoft.AspNetCore.Identity.IdentityUser>(user);
        Assert.False(string.IsNullOrEmpty(user.Id));
    }

    [Fact]
    public void Legacy_Roles_Are_Carried_Over()
    {
        Assert.Equal("su", IdentityIntegration.Roles.SuperUser);
        Assert.Equal("adm", IdentityIntegration.Roles.Admin);
        Assert.Equal("emp", IdentityIntegration.Roles.Employee);
        Assert.Equal("agt", IdentityIntegration.Roles.Agent);
        Assert.Equal("guest", IdentityIntegration.Roles.Guest);
    }
}