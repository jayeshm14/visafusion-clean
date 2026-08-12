using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;

namespace VisaFusion.Identity.Persistence;

/// <summary>
/// Identity store DbContext for the consolidated identity tables (SPEC-0005 FR-017).
/// Maps the migration tool's idempotent DDL (AspNetUsers/AspNetRoles/AspNetUserRoles
/// plus the four standard auxiliary tables created by EnsureIdentitySchemaAsync) and
/// the custom VisaFusionUser columns LegacyUdaanUserId/LegacyRegistrationId/AgentId.
/// The migration-tool DDL is the schema source of truth (plan.md §Constraints) — this
/// DbContext is used for reads/writes at runtime, not for schema creation.
/// </summary>
public sealed class VisaFusionIdentityDbContext :
    IdentityDbContext<IdentityIntegration.VisaFusionUser, IdentityRole, string>
{
    public VisaFusionIdentityDbContext(DbContextOptions<VisaFusionIdentityDbContext> options)
        : base(options)
    {
    }

    protected override void OnModelCreating(ModelBuilder builder)
    {
        base.OnModelCreating(builder);
        // IdentityDbContext maps all eight AspNet* tables to the standard schema
        // produced by EnsureIdentitySchemaAsync (fixed role Ids = role names, which
        // the importer's AspNetUserRoles inserts match). The three custom nullable
        // int columns on VisaFusionUser map to the DDL's LegacyUdaanUserId/
        // LegacyRegistrationId/AgentId columns; no further configuration is required.
    }
}
