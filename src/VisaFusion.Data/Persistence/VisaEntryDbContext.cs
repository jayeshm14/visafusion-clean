using Microsoft.EntityFrameworkCore;
using VisaFusion.Data.Persistence.Entities;

namespace VisaFusion.Data.Persistence;

/// <summary>
/// EF Core DbContext over the existing legacy `VisaEntry` database
/// (SPEC-0003 T033, FR-006). Architecture scaffolding only: no schema changes,
/// no new tables, no drops (spec §16, BR-003).
///
/// The model maps the core tables from data-model.md §1 to their scaffolded
/// entities; full column-level mapping is defined in the module feature specs
/// and the Data Remediation feature. All queries are LINQ/parameterized
/// (NFR-003) — no raw string-concatenated SQL.
/// </summary>
public sealed class VisaEntryDbContext : DbContext
{
    public VisaEntryDbContext(DbContextOptions<VisaEntryDbContext> options)
        : base(options)
    {
    }

    public DbSet<Entry> Entries => Set<Entry>();
    public DbSet<EntryPassenger> EntryPassengers => Set<EntryPassenger>();
    public DbSet<PaxCountryStatus> PaxCountryStatuses => Set<PaxCountryStatus>();
    public DbSet<StatusHistoryEntry> StatusHistory => Set<StatusHistoryEntry>();
    public DbSet<EntryAuditLog> EntryAuditLogs => Set<EntryAuditLog>();
    public DbSet<EmailLog> EmailLogs => Set<EmailLog>();
    public DbSet<SmsLog> SmsLogs => Set<SmsLog>();
    public DbSet<Agent> Agents => Set<Agent>();
    public DbSet<SecurityDay> SecurityDays => Set<SecurityDay>();
    public DbSet<Holiday> Holidays => Set<Holiday>();
    public DbSet<WeeklyOff> WeeklyOffs => Set<WeeklyOff>();
    public DbSet<Embassy> Embassies => Set<Embassy>();
    public DbSet<CountryInfo> CountryInfos => Set<CountryInfo>();
    public DbSet<VisaInfo> VisaInfos => Set<VisaInfo>();

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);

        // Scaffolding table mapping (data-model.md §1). Column mapping is minimal
        // (single key column); the Data Remediation feature defines full columns,
        // indexes, and relationships.
        modelBuilder.Entity<Entry>().ToTable("Mainentry").HasKey(e => e.Id);
        modelBuilder.Entity<EntryPassenger>().ToTable("entryDetails").HasKey(e => e.Id);
        modelBuilder.Entity<PaxCountryStatus>().ToTable("PaxStatus").HasKey(e => e.Id);
        modelBuilder.Entity<StatusHistoryEntry>().ToTable("StatusHistory").HasKey(e => e.Id);
        modelBuilder.Entity<EntryAuditLog>().ToTable("bighistory").HasKey(e => e.Id);
        modelBuilder.Entity<EmailLog>().ToTable("sentmails").HasKey(e => e.Id);
        modelBuilder.Entity<SmsLog>().ToTable("smshistory").HasKey(e => e.Id);
        modelBuilder.Entity<Agent>().ToTable("agents").HasKey(e => e.Id);
        modelBuilder.Entity<SecurityDay>().ToTable("security").HasKey(e => e.Id);
        modelBuilder.Entity<Holiday>().ToTable("holidaylist").HasKey(e => e.Id);
        modelBuilder.Entity<WeeklyOff>().ToTable("weeklyoff").HasKey(e => e.Id);
        modelBuilder.Entity<Embassy>().ToTable("embassy").HasKey(e => e.Id);
        modelBuilder.Entity<CountryInfo>().ToTable("CountryInfo").HasKey(e => e.Id);
        modelBuilder.Entity<VisaInfo>().ToTable("VisaInfo").HasKey(e => e.Id);
    }
}