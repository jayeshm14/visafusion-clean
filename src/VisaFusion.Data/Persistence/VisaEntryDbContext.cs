using Microsoft.EntityFrameworkCore;
using VisaFusion.Data.Persistence.Entities;

namespace VisaFusion.Data.Persistence;

/// <summary>
/// EF Core DbContext for the target `VisaFusion` database (SPEC-0004 FR-003).
///
/// The model maps the 38 migrated entities to their legacy table names with
/// reconstructed primary keys (identity-first with surrogate fallback, data-model.md
/// §2), foreign keys (data-model.md §4), and indexes for the high-volume tables.
///
/// The CountryID target-reference gap (data-model.md §4) is NOT resolved here:
/// no FK is invented for the `CountryID` columns. The columns are migrated as
/// plain columns; the mapping is a recorded open decision.
///
/// All queries are LINQ/parameterized (NFR-003) — no raw string-concatenated SQL.
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
    public DbSet<AwbLog> AwbLogs => Set<AwbLog>();
    public DbSet<SmsLog> SmsLogs => Set<SmsLog>();
    public DbSet<SmsQueue> SmsQueues => Set<SmsQueue>();
    public DbSet<Agent> Agents => Set<Agent>();
    public DbSet<SecurityDay> SecurityDays => Set<SecurityDay>();
    public DbSet<MasterBalance> MasterBalances => Set<MasterBalance>();
    public DbSet<Bank> Banks => Set<Bank>();
    public DbSet<Holiday> Holidays => Set<Holiday>();
    public DbSet<WeeklyOff> WeeklyOffs => Set<WeeklyOff>();
    public DbSet<Embassy> Embassies => Set<Embassy>();
    public DbSet<CountryInfo> CountryInfos => Set<CountryInfo>();
    public DbSet<VisaInfo> VisaInfos => Set<VisaInfo>();
    public DbSet<Status> Statuses => Set<Status>();
    public DbSet<Category> Categories => Set<Category>();
    public DbSet<EntryType> EntryTypes => Set<EntryType>();
    public DbSet<Poe> Poes => Set<Poe>();
    public DbSet<Attestation> Attestations => Set<Attestation>();
    public DbSet<Certificate> Certificates => Set<Certificate>();
    public DbSet<PaxAttestation> PaxAttestations => Set<PaxAttestation>();
    public DbSet<ContentUpdate> ContentUpdates => Set<ContentUpdate>();
    public DbSet<DeletedItemAudit> DeletedItemAudits => Set<DeletedItemAudit>();
    public DbSet<AgentStaging> AgentStagings => Set<AgentStaging>();
    public DbSet<LedgerHistory> LedgerHistory => Set<LedgerHistory>();
    public DbSet<Invoice> Invoices => Set<Invoice>();
    public DbSet<InvoiceDetail> InvoiceDetails => Set<InvoiceDetail>();
    public DbSet<Hotel> Hotels => Set<Hotel>();
    public DbSet<Cab> Cabs => Set<Cab>();
    public DbSet<PaxHotel> PaxHotels => Set<PaxHotel>();
    public DbSet<PaxCab> PaxCabs => Set<PaxCab>();
    public DbSet<Scheduler> Schedulers => Set<Scheduler>();
    public DbSet<PriWork> PriWorks => Set<PriWork>();
    public DbSet<Subscriber> Subscribers => Set<Subscriber>();

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);

        ConfigureEntry(modelBuilder);
        ConfigureEntryPassenger(modelBuilder);
        ConfigurePaxCountryStatus(modelBuilder);
        ConfigureStatusHistoryEntry(modelBuilder);
        ConfigureEntryAuditLog(modelBuilder);
        ConfigureEmailLog(modelBuilder);
        ConfigureAwbLog(modelBuilder);
        ConfigureSmsLog(modelBuilder);
        ConfigureSmsQueue(modelBuilder);
        ConfigureAgent(modelBuilder);
        ConfigureSecurityDay(modelBuilder);
        ConfigureMasterBalance(modelBuilder);
        ConfigureBank(modelBuilder);
        ConfigureHoliday(modelBuilder);
        ConfigureWeeklyOff(modelBuilder);
        ConfigureEmbassy(modelBuilder);
        ConfigureCountryInfo(modelBuilder);
        ConfigureVisaInfo(modelBuilder);
        ConfigureStatus(modelBuilder);
        ConfigureCategory(modelBuilder);
        ConfigureEntryType(modelBuilder);
        ConfigurePoe(modelBuilder);
        ConfigureAttestation(modelBuilder);
        ConfigureCertificate(modelBuilder);
        ConfigurePaxAttestation(modelBuilder);
        ConfigureContentUpdate(modelBuilder);
        ConfigureDeletedItemAudit(modelBuilder);
        ConfigureAgentStaging(modelBuilder);
        ConfigureLedgerHistory(modelBuilder);
        ConfigureInvoice(modelBuilder);
        ConfigureInvoiceDetail(modelBuilder);
        ConfigureHotel(modelBuilder);
        ConfigureCab(modelBuilder);
        ConfigurePaxHotel(modelBuilder);
        ConfigurePaxCab(modelBuilder);
        ConfigureScheduler(modelBuilder);
        ConfigurePriWork(modelBuilder);
        ConfigureSubscriber(modelBuilder);
    }

    private static void ConfigureEntry(ModelBuilder mb)
    {
        var e = mb.Entity<Entry>().ToTable("Mainentry");
        e.HasKey(x => x.Id);
        e.Property(x => x.Id).HasColumnName("id").ValueGeneratedOnAdd();
        e.Property(x => x.Refno).HasColumnName("refno");
        e.Property(x => x.Paxname).HasColumnName("paxname");
        e.Property(x => x.Agent).HasColumnName("agent");
        e.Property(x => x.Refferer).HasColumnName("refferer");
        e.Property(x => x.Companyname).HasColumnName("companyname");
        e.Property(x => x.Passportno).HasColumnName("passportno");
        e.Property(x => x.Totalpassengers).HasColumnName("totalpassengers");
        e.Property(x => x.Entries).HasColumnName("entries");
        e.Property(x => x.Dateofbirth).HasColumnName("dateofbirth");
        e.Property(x => x.Subdate).HasColumnName("subdate");
        e.Property(x => x.Coldate).HasColumnName("coldate");
        e.Property(x => x.Receivedate).HasColumnName("receivedate");
        e.Property(x => x.Traveldate).HasColumnName("traveldate");
        e.Property(x => x.SentDate).HasColumnName("sentDate");
        e.Property(x => x.Entrytype).HasColumnName("entrytype");
        e.Property(x => x.Category).HasColumnName("category");
        e.Property(x => x.Attestation).HasColumnName("attestation");
        e.Property(x => x.Poe).HasColumnName("poe");
        e.Property(x => x.Status).HasColumnName("status");
        e.Property(x => x.Externalremark).HasColumnName("externalremark");
        e.Property(x => x.Internalremark).HasColumnName("internalremark");
        e.Property(x => x.AgentInstruction).HasColumnName("AgentInstruction");
        e.Property(x => x.Enteredby).HasColumnName("enteredby");
        e.Property(x => x.Entrydatetime).HasColumnName("entrydatetime");
        e.Property(x => x.Bill).HasColumnName("Bill");

        // Optimistic-concurrency token (SPEC-0006 T006, AC-011): the rowversion
        // column is generated by SQL Server on every insert/update and surfaced
        // as the ETag for If-Match on PUT (contracts/entries-api.md §2–§3).
        e.Property(x => x.RowVersion).IsRowVersion().HasColumnName("rowversion");

        // FK: Entry.agent -> Agent.agentsID (nullable; 6,517 orphans migrate NULL, FR-005c)
        e.HasOne<Agent>().WithMany().HasForeignKey(x => x.Agent).OnDelete(DeleteBehavior.Restrict);
        // FK: Entry.entrytype -> EntryType.EntryTypeID (100% NULL in legacy; nullable FK, no data violation)
        e.HasOne<EntryType>().WithMany().HasForeignKey(x => x.Entrytype).OnDelete(DeleteBehavior.Restrict);
        // DEFERRED FKs (GAP-0001, verified 2026-08-09): Entry.category/attestation/poe/status contain the
        // legacy sentinel value 0 (271,692 / 30,176 / 3 / 3 rows) that has no row in the lookup tables,
        // and no cleansing rule was approved for it. FK constraints omitted; indexes retained below.

        // Indexes for the high-volume master table (FR-003)
        // Mainentry.refno is the FK principal for entryDetails.refno and PaxStatus.refno.
        // Verified against the live VisaEntry DB 2026-08-09: refno is unique in data
        // (0 duplicates, 0 NULLs) even though the legacy column is nullable. The
        // alternate key (unique index) is what allows the two FKs below to reference
        // it via HasPrincipalKey (EF requires the principal to be a declared key).
        e.HasAlternateKey(x => x.Refno).HasName("IX_Mainentry_refno");
        e.HasIndex(x => x.Agent).HasDatabaseName("IX_Mainentry_agent");
        e.HasIndex(x => x.Status).HasDatabaseName("IX_Mainentry_status");
        e.HasIndex(x => x.Category).HasDatabaseName("IX_Mainentry_category");
        e.HasIndex(x => x.Entrytype).HasDatabaseName("IX_Mainentry_entrytype");
    }

    private static void ConfigureEntryPassenger(ModelBuilder mb)
    {
        var e = mb.Entity<EntryPassenger>().ToTable("entryDetails");
        e.HasKey(x => x.Id);
        e.Property(x => x.Id).HasColumnName("PaxID").ValueGeneratedOnAdd();
        e.Property(x => x.Refno).HasColumnName("refno");
        e.Property(x => x.Paxname).HasColumnName("Paxname");
        e.Property(x => x.Passportno).HasColumnName("passportno");
        e.Property(x => x.DateOfBirth).HasColumnName("DateOfBirth");
        e.Property(x => x.Category).HasColumnName("Category");
        e.Property(x => x.Totalpax).HasColumnName("totalpax");

        // FK: entryDetails.refno -> Mainentry.refno (principal = the natural key,
        // NOT the surrogate Id; refno is unique in data per live check 2026-08-09)
        e.HasOne<Entry>().WithMany().HasForeignKey(x => x.Refno).HasPrincipalKey(x => x.Refno).OnDelete(DeleteBehavior.Restrict);

        e.HasIndex(x => x.Refno).HasDatabaseName("IX_entryDetails_refno");
        e.HasIndex(x => x.Paxname).HasDatabaseName("IX_entryDetails_Paxname");
    }

    private static void ConfigurePaxCountryStatus(ModelBuilder mb)
    {
        var e = mb.Entity<PaxCountryStatus>().ToTable("PaxStatus");
        e.HasKey(x => x.Id);
        e.Property(x => x.Id).HasColumnName("Id").ValueGeneratedOnAdd();
        e.Property(x => x.Refno).HasColumnName("refno");
        e.Property(x => x.PaxId).HasColumnName("PaxID");
        e.Property(x => x.CountryId).HasColumnName("CountryID");
        e.Property(x => x.Subdate).HasColumnName("subdate");
        e.Property(x => x.Coldate).HasColumnName("coldate");
        e.Property(x => x.Colcheck).HasColumnName("colcheck");
        e.Property(x => x.SentDate).HasColumnName("sentDate");
        e.Property(x => x.Category).HasColumnName("category");
        e.Property(x => x.Entrytype).HasColumnName("entrytype");
        e.Property(x => x.StatusId).HasColumnName("statusID");
        e.Property(x => x.Remarks).HasColumnName("remarks");
        // Money columns (legacy `money`, 4 decimal places) — decimal(19,4) so
        // values round-trip verbatim (FR-002). EF default decimal(18,2) would
        // silently round sub-cent amounts.
        e.Property(x => x.Visafee).HasColumnName("visafee").HasPrecision(19, 4);
        e.Property(x => x.Handlingfee).HasColumnName("handlingfee").HasPrecision(19, 4);
        e.Property(x => x.Ddcharges).HasColumnName("ddcharges").HasPrecision(19, 4);
        e.Property(x => x.Couriercharges).HasColumnName("couriercharges").HasPrecision(19, 4);
        e.Property(x => x.Misccharges).HasColumnName("Misccharges").HasPrecision(19, 4);
        e.Property(x => x.Total).HasColumnName("total").HasPrecision(19, 4);
        e.Property(x => x.Entrydatetime).HasColumnName("entrydatetime");
        e.Property(x => x.VFSTTCharges).HasColumnName("VFSTTCharges").HasPrecision(19, 4);

        // FK: PaxStatus.refno -> Mainentry.refno (principal = natural key refno, not surrogate Id)
        e.HasOne<Entry>().WithMany().HasForeignKey(x => x.Refno).HasPrincipalKey(x => x.Refno).OnDelete(DeleteBehavior.Restrict);
        // FK: PaxStatus.statusID -> status.statusID
        e.HasOne<Status>().WithMany().HasForeignKey(x => x.StatusId).OnDelete(DeleteBehavior.Restrict);
        // DEFERRED FKs (GAP-0001): PaxStatus.PaxID has 1 orphan; PaxStatus.category has 2,755 sentinel-0
        // rows; PaxStatus.entrytype has 67 sentinel-0 rows. Constraints omitted; indexes retained.

        e.HasIndex(x => x.Refno).HasDatabaseName("IX_PaxStatus_refno");
        e.HasIndex(x => x.PaxId).HasDatabaseName("IX_PaxStatus_PaxID");
        e.HasIndex(x => x.StatusId).HasDatabaseName("IX_PaxStatus_statusID");
    }

    private static void ConfigureStatusHistoryEntry(ModelBuilder mb)
    {
        var e = mb.Entity<StatusHistoryEntry>().ToTable("StatusHistory");
        e.HasKey(x => x.Id);
        e.Property(x => x.Id).HasColumnName("Id").ValueGeneratedOnAdd();
        e.Property(x => x.PaxId).HasColumnName("PaxID");
        e.Property(x => x.Date).HasColumnName("Date");
        e.Property(x => x.CountryId).HasColumnName("CountryID");
        e.Property(x => x.StatusId).HasColumnName("StatusID");
        e.Property(x => x.Remarks).HasColumnName("Remarks");
        e.Property(x => x.UpdatedBy).HasColumnName("UpdatedBy");

        // FK: StatusHistory.StatusID -> status.statusID
        e.HasOne<Status>().WithMany().HasForeignKey(x => x.StatusId).OnDelete(DeleteBehavior.Restrict);
        // DEFERRED FK (GAP-0001): StatusHistory.PaxID has 2,465 orphans (append-only audit history;
        // NULL-ing rows would lose audit data, and no cleansing rule was approved). Constraint omitted;
        // IX_StatusHistory_PaxID retained.

        e.HasIndex(x => x.PaxId).HasDatabaseName("IX_StatusHistory_PaxID");
        e.HasIndex(x => x.StatusId).HasDatabaseName("IX_StatusHistory_StatusID");
        e.HasIndex(x => x.Date).HasDatabaseName("IX_StatusHistory_Date");
    }

    private static void ConfigureEntryAuditLog(ModelBuilder mb)
    {
        var e = mb.Entity<EntryAuditLog>().ToTable("bighistory");
        e.HasKey(x => x.Id);
        e.Property(x => x.Id).HasColumnName("bighistoryid").ValueGeneratedOnAdd();
        e.Property(x => x.Refno).HasColumnName("refno");
        e.Property(x => x.Agent).HasColumnName("agent");
        e.Property(x => x.Date).HasColumnName("Date");
        e.Property(x => x.UpdatedBy).HasColumnName("UpdatedBy");
        e.Property(x => x.Remarks).HasColumnName("Remarks");

        e.HasIndex(x => x.Refno).HasDatabaseName("IX_bighistory_refno");
    }

    private static void ConfigureEmailLog(ModelBuilder mb)
    {
        var e = mb.Entity<EmailLog>().ToTable("sentmails");
        e.HasKey(x => x.Id);
        e.Property(x => x.Id).HasColumnName("id").ValueGeneratedOnAdd();
        e.Property(x => x.Agentsid).HasColumnName("agentsid");
        e.Property(x => x.Date).HasColumnName("date");
        e.Property(x => x.Toemail).HasColumnName("toemail");
        e.Property(x => x.Awb).HasColumnName("awb");

        // DEFERRED FK (GAP-0001): sentmails.agentsid has 9,661 orphans. Constraint omitted; index retained.
        e.HasIndex(x => x.Agentsid).HasDatabaseName("IX_sentmails_agentsid");
    }

    private static void ConfigureAwbLog(ModelBuilder mb)
    {
        var e = mb.Entity<AwbLog>().ToTable("sentawb");
        e.HasKey(x => x.Id);
        e.Property(x => x.Id).HasColumnName("id").ValueGeneratedOnAdd();
        e.Property(x => x.Agentsid).HasColumnName("agentsid");
        e.Property(x => x.Date).HasColumnName("date");
        e.Property(x => x.Toemail).HasColumnName("toemail");
        e.Property(x => x.Remark).HasColumnName("remark");
        e.Property(x => x.Awb).HasColumnName("awb");

        // DEFERRED FK (GAP-0001): sentawb.agentsid has 404 orphans. Constraint omitted; index retained.
        e.HasIndex(x => x.Agentsid).HasDatabaseName("IX_sentawb_agentsid");
    }

    private static void ConfigureSmsLog(ModelBuilder mb)
    {
        var e = mb.Entity<SmsLog>().ToTable("smshistory");
        e.HasKey(x => x.Id);
        e.Property(x => x.Id).HasColumnName("Id").ValueGeneratedOnAdd();
        e.Property(x => x.Cellno).HasColumnName("cellno");
        e.Property(x => x.Refno).HasColumnName("refno");
        e.Property(x => x.AgentId).HasColumnName("agentID");
        e.Property(x => x.Paxname).HasColumnName("paxname");
        e.Property(x => x.Status).HasColumnName("status");
        e.Property(x => x.Message).HasColumnName("message");
        e.Property(x => x.Sentby).HasColumnName("sentby");
        e.Property(x => x.Sentdate).HasColumnName("sentdate");

        // DEFERRED FK (GAP-0001): smshistory.agentID has 2,259 orphans. Constraint omitted; index retained.
        e.HasIndex(x => x.AgentId).HasDatabaseName("IX_smshistory_agentID");
        e.HasIndex(x => x.Refno).HasDatabaseName("IX_smshistory_refno");
    }

    private static void ConfigureSmsQueue(ModelBuilder mb)
    {
        var e = mb.Entity<SmsQueue>().ToTable("smsQueue");
        e.HasKey(x => x.Id);
        e.Property(x => x.Id).HasColumnName("Id").ValueGeneratedOnAdd();
        e.Property(x => x.Cellno).HasColumnName("cellno");
        e.Property(x => x.Refno).HasColumnName("refno");
        e.Property(x => x.AgentId).HasColumnName("agentID");
        e.Property(x => x.Paxname).HasColumnName("paxname");
        e.Property(x => x.Message).HasColumnName("Message");
        e.Property(x => x.Sentby).HasColumnName("sentby");
        e.Property(x => x.Sentdate).HasColumnName("sentdate");

        // FK: smsQueue.agentID -> agents.agentsID
        e.HasOne<Agent>().WithMany().HasForeignKey(x => x.AgentId).OnDelete(DeleteBehavior.Restrict);

        e.HasIndex(x => x.AgentId).HasDatabaseName("IX_smsQueue_agentID");
    }

    private static void ConfigureAgent(ModelBuilder mb)
    {
        var e = mb.Entity<Agent>().ToTable("agents");
        e.HasKey(x => x.Id);
        e.Property(x => x.Id).HasColumnName("agentsID").ValueGeneratedOnAdd();
        e.Property(x => x.Description).HasColumnName("Description");
        e.Property(x => x.Companyname).HasColumnName("companyname");
        e.Property(x => x.Complexname).HasColumnName("complexname");
        e.Property(x => x.Street1).HasColumnName("street1");
        e.Property(x => x.Street2).HasColumnName("street2");
        e.Property(x => x.Area).HasColumnName("area");
        e.Property(x => x.City).HasColumnName("city");
        e.Property(x => x.Pincode).HasColumnName("pincode");
        e.Property(x => x.Phoneno).HasColumnName("phoneno");
        e.Property(x => x.Faxno).HasColumnName("faxno");
        e.Property(x => x.Emailid).HasColumnName("emailid");
        e.Property(x => x.Directorname).HasColumnName("directorname");
        e.Property(x => x.Acno).HasColumnName("acno");
        e.Property(x => x.Payment).HasColumnName("payment");
        e.Property(x => x.Active).HasColumnName("active");
        e.Property(x => x.TAAI).HasColumnName("TAAI");
        e.Property(x => x.TAFI).HasColumnName("TAFI");
        e.Property(x => x.Membership).HasColumnName("MEMBERSHIP");
        e.Property(x => x.Creationdate).HasColumnName("CREATIONDATE");
        e.Property(x => x.IATA).HasColumnName("IATA");
        e.Property(x => x.DirectorPH).HasColumnName("DirectorPH");
        e.Property(x => x.AcMgrPH).HasColumnName("AcMgrPH");
        e.Property(x => x.VisaInchargeName).HasColumnName("VisaInchargeName");
        e.Property(x => x.VisaInchargePH).HasColumnName("VisaInchargePH");
        e.Property(x => x.Enteredby).HasColumnName("enteredby");
        e.Property(x => x.Smsno).HasColumnName("smsno");
    }

    private static void ConfigureSecurityDay(ModelBuilder mb)
    {
        var e = mb.Entity<SecurityDay>().ToTable("security");
        e.HasKey(x => x.Id);
        e.Property(x => x.Id).HasColumnName("Id").ValueGeneratedOnAdd();
        e.Property(x => x.Date1).HasColumnName("date1");
        e.Property(x => x.Openingtime).HasColumnName("openingtime");
        e.Property(x => x.Openby).HasColumnName("openby");
        e.Property(x => x.Closingtime).HasColumnName("closingtime");
        e.Property(x => x.Closedby).HasColumnName("closedby");
    }

    private static void ConfigureMasterBalance(ModelBuilder mb)
    {
        var e = mb.Entity<MasterBalance>().ToTable("masterbalance");
        e.HasKey(x => x.Id);
        e.Property(x => x.Id).HasColumnName("Id").ValueGeneratedOnAdd();
        e.Property(x => x.Agentid).HasColumnName("agentid");
        // Money column (legacy `money`) — decimal(19,4), verbatim round-trip (FR-002).
        e.Property(x => x.Masterbalance).HasColumnName("masterbalance").HasPrecision(19, 4);
        e.Property(x => x.Duedate).HasColumnName("duedate");

        // DEFERRED FK (GAP-0001): masterbalance.agentid has 117 orphans. Constraint omitted.
    }

    private static void ConfigureBank(ModelBuilder mb)
    {
        var e = mb.Entity<Bank>().ToTable("bank");
        e.HasKey(x => x.Bankid);
        e.Property(x => x.Bankid).HasColumnName("bankid");
        e.Property(x => x.Description).HasColumnName("description");
        e.Property(x => x.Active).HasColumnName("Active");
    }

    private static void ConfigureHoliday(ModelBuilder mb)
    {
        var e = mb.Entity<Holiday>().ToTable("holidaylist");
        e.HasKey(x => x.Id);
        e.Property(x => x.Id).HasColumnName("Id").ValueGeneratedOnAdd();
        e.Property(x => x.CountryId).HasColumnName("countryID");
        e.Property(x => x.HolidayDate).HasColumnName("holiday");
        e.Property(x => x.Description).HasColumnName("description");
    }

    private static void ConfigureWeeklyOff(ModelBuilder mb)
    {
        var e = mb.Entity<WeeklyOff>().ToTable("weeklyoff");
        e.HasKey(x => x.Id);
        e.Property(x => x.Id).HasColumnName("Id").ValueGeneratedOnAdd();
        e.Property(x => x.Embassyid).HasColumnName("embassyid");
        e.Property(x => x.Weekend).HasColumnName("weekend");
        e.Property(x => x.Description).HasColumnName("description");

        // FK: weeklyoff.embassyid -> embassy.EmbassyID
        e.HasOne<Embassy>().WithMany().HasForeignKey(x => x.Embassyid).OnDelete(DeleteBehavior.Restrict);
    }

    private static void ConfigureEmbassy(ModelBuilder mb)
    {
        var e = mb.Entity<Embassy>().ToTable("embassy");
        e.HasKey(x => x.Id);
        e.Property(x => x.Id).HasColumnName("EmbassyID").ValueGeneratedOnAdd();
        e.Property(x => x.Description).HasColumnName("Description");
        e.Property(x => x.Embassyname).HasColumnName("embassyname");
        e.Property(x => x.Street1).HasColumnName("street1");
        e.Property(x => x.Street2).HasColumnName("street2");
        e.Property(x => x.Area).HasColumnName("area");
        e.Property(x => x.City).HasColumnName("city");
        e.Property(x => x.Phoneno).HasColumnName("phoneno");
        e.Property(x => x.Faxno).HasColumnName("faxno");
        e.Property(x => x.Emailid).HasColumnName("emailid");
        e.Property(x => x.Workinghours).HasColumnName("workinghours");
        e.Property(x => x.Chancery).HasColumnName("chancery");
        e.Property(x => x.Chanceryphone).HasColumnName("chanceryphone");
        e.Property(x => x.Chanceryaddress).HasColumnName("chanceryaddress");
        e.Property(x => x.Active).HasColumnName("active");
    }

    private static void ConfigureCountryInfo(ModelBuilder mb)
    {
        var e = mb.Entity<CountryInfo>().ToTable("CountryInfo");
        e.HasKey(x => x.CountryId);
        e.Property(x => x.CountryId).HasColumnName("CountryID");
        e.Property(x => x.About).HasColumnName("About");
        e.Property(x => x.Climate).HasColumnName("Climate");
        e.Property(x => x.Language).HasColumnName("Language");
        e.Property(x => x.Religion).HasColumnName("Religion");
        e.Property(x => x.Curency).HasColumnName("Curency");
        e.Property(x => x.TimeZone).HasColumnName("TimeZone");
        e.Property(x => x.ContinentFile).HasColumnName("Continent_File");
        e.Property(x => x.FlagFile).HasColumnName("Flag_File");
        e.Property(x => x.VisaFile).HasColumnName("Visa_File");
    }

    private static void ConfigureVisaInfo(ModelBuilder mb)
    {
        var e = mb.Entity<VisaInfo>().ToTable("VisaInfo");
        e.HasKey(x => x.Id);
        e.Property(x => x.Id).HasColumnName("Id").ValueGeneratedOnAdd();
        e.Property(x => x.CountryId).HasColumnName("countryID");
        e.Property(x => x.CategoryId).HasColumnName("categoryID");
        e.Property(x => x.Information).HasColumnName("information");
        e.Property(x => x.CountryFor).HasColumnName("countryFor");

        // FK: VisaInfo.categoryID -> Category.CategoryID
        e.HasOne<Category>().WithMany().HasForeignKey(x => x.CategoryId).OnDelete(DeleteBehavior.Restrict);
    }

    private static void ConfigureStatus(ModelBuilder mb)
    {
        var e = mb.Entity<Status>().ToTable("status");
        e.HasKey(x => x.StatusId);
        e.Property(x => x.StatusId).HasColumnName("statusID");
        e.Property(x => x.Description).HasColumnName("Description");
        e.Property(x => x.Active).HasColumnName("Active");
    }

    private static void ConfigureCategory(ModelBuilder mb)
    {
        var e = mb.Entity<Category>().ToTable("Category");
        e.HasKey(x => x.CategoryId);
        e.Property(x => x.CategoryId).HasColumnName("CategoryID");
        e.Property(x => x.Description).HasColumnName("Description");
        e.Property(x => x.Active).HasColumnName("Active");
    }

    private static void ConfigureEntryType(ModelBuilder mb)
    {
        var e = mb.Entity<EntryType>().ToTable("EntryType");
        e.HasKey(x => x.EntryTypeId);
        e.Property(x => x.EntryTypeId).HasColumnName("EntryTypeID");
        e.Property(x => x.Description).HasColumnName("Description");
        e.Property(x => x.Active).HasColumnName("Active");
    }

    private static void ConfigurePoe(ModelBuilder mb)
    {
        var e = mb.Entity<Poe>().ToTable("Poe");
        e.HasKey(x => x.PoeId);
        e.Property(x => x.PoeId).HasColumnName("PoeID");
        e.Property(x => x.Description).HasColumnName("Description");
        e.Property(x => x.Active).HasColumnName("Active");
    }

    private static void ConfigureAttestation(ModelBuilder mb)
    {
        var e = mb.Entity<Attestation>().ToTable("Attestation");
        e.HasKey(x => x.AttestationId);
        e.Property(x => x.AttestationId).HasColumnName("AttestationID");
        e.Property(x => x.Description).HasColumnName("Description");
    }

    private static void ConfigureCertificate(ModelBuilder mb)
    {
        var e = mb.Entity<Certificate>().ToTable("certificate");
        e.HasKey(x => x.CertificateId);
        e.Property(x => x.CertificateId).HasColumnName("certificateID");
        e.Property(x => x.Description).HasColumnName("description");
    }

    private static void ConfigurePaxAttestation(ModelBuilder mb)
    {
        var e = mb.Entity<PaxAttestation>().ToTable("PaxAttestation");
        e.HasKey(x => x.Id);
        e.Property(x => x.Id).HasColumnName("Id").ValueGeneratedOnAdd();
        e.Property(x => x.PaxId).HasColumnName("PaxID");
        e.Property(x => x.CountryId).HasColumnName("CountryID");
        e.Property(x => x.AttestationId).HasColumnName("AttestationID");
        e.Property(x => x.CertificateId).HasColumnName("CertificateID");

        // FK: PaxAttestation.PaxID -> entryDetails.PaxID (junction)
        e.HasOne<EntryPassenger>().WithMany().HasForeignKey(x => x.PaxId).OnDelete(DeleteBehavior.Restrict);
        // FK: PaxAttestation.AttestationID -> Attestation.AttestationID
        e.HasOne<Attestation>().WithMany().HasForeignKey(x => x.AttestationId).OnDelete(DeleteBehavior.Restrict);
        // FK: PaxAttestation.CertificateID -> certificate.certificateID
        e.HasOne<Certificate>().WithMany().HasForeignKey(x => x.CertificateId).OnDelete(DeleteBehavior.Restrict);
    }

    private static void ConfigureContentUpdate(ModelBuilder mb)
    {
        var e = mb.Entity<ContentUpdate>().ToTable("dailyUpdate");
        e.HasKey(x => x.Id);
        e.Property(x => x.Id).HasColumnName("Id").ValueGeneratedOnAdd();
        e.Property(x => x.Entrydate).HasColumnName("entrydate");
        e.Property(x => x.Description).HasColumnName("Description");
    }

    private static void ConfigureDeletedItemAudit(ModelBuilder mb)
    {
        var e = mb.Entity<DeletedItemAudit>().ToTable("deleteditem");
        e.HasKey(x => x.Id);
        e.Property(x => x.Id).HasColumnName("Id").ValueGeneratedOnAdd();
        e.Property(x => x.Refno).HasColumnName("refno");
        e.Property(x => x.Paxid).HasColumnName("paxid");
        e.Property(x => x.Countryid).HasColumnName("countryid");
        e.Property(x => x.Deletedby).HasColumnName("deletedby");
        e.Property(x => x.Description).HasColumnName("description");
    }

    private static void ConfigureAgentStaging(ModelBuilder mb)
    {
        var e = mb.Entity<AgentStaging>().ToTable("newagents");
        e.HasKey(x => x.Id);
        e.Property(x => x.Id).HasColumnName("newagentsID").ValueGeneratedOnAdd();
        e.Property(x => x.Description).HasColumnName("Description");
        e.Property(x => x.Companyname).HasColumnName("companyname");
        e.Property(x => x.Complexname).HasColumnName("complexname");
        e.Property(x => x.Street1).HasColumnName("street1");
        e.Property(x => x.Street2).HasColumnName("street2");
        e.Property(x => x.Area).HasColumnName("area");
        e.Property(x => x.City).HasColumnName("city");
        e.Property(x => x.Pincode).HasColumnName("pincode");
        e.Property(x => x.Phoneno).HasColumnName("phoneno");
        e.Property(x => x.Faxno).HasColumnName("faxno");
        e.Property(x => x.Emailid).HasColumnName("emailid");
        e.Property(x => x.Directorname).HasColumnName("directorname");
        e.Property(x => x.Acno).HasColumnName("acno");
        e.Property(x => x.Payment).HasColumnName("payment");
    }

    private static void ConfigureLedgerHistory(ModelBuilder mb)
    {
        var e = mb.Entity<LedgerHistory>().ToTable("Ledger");
        e.HasKey(x => x.Id);
        e.Property(x => x.Id).HasColumnName("id").ValueGeneratedOnAdd();
        e.Property(x => x.AgentId).HasColumnName("agentID");
        e.Property(x => x.Transdate).HasColumnName("transdate");
        e.Property(x => x.TransactionType).HasColumnName("transactionType");
        e.Property(x => x.Bank).HasColumnName("bank");
        e.Property(x => x.Paidas).HasColumnName("paidas");
        e.Property(x => x.Ddno).HasColumnName("ddno");
        e.Property(x => x.Dddate).HasColumnName("dddate");
        e.Property(x => x.Paxname).HasColumnName("paxname");
        e.Property(x => x.Refno).HasColumnName("refno");
        e.Property(x => x.Reftype).HasColumnName("reftype");
        // Money columns (legacy `money`) — decimal(19,4), verbatim round-trip (FR-002).
        e.Property(x => x.Credit).HasColumnName("credit").HasPrecision(19, 4);
        e.Property(x => x.Debit).HasColumnName("Debit").HasPrecision(19, 4);
        e.Property(x => x.Balance).HasColumnName("balance").HasPrecision(19, 4);
        e.Property(x => x.Remark).HasColumnName("Remark");
        e.Property(x => x.EntrydateTime).HasColumnName("entrydateTime");
        e.Property(x => x.Updatedby).HasColumnName("updatedby");
        e.Property(x => x.Invno).HasColumnName("invno");

        // DEFERRED FKs (GAP-0001): Ledger.agentID has 525 orphans; Ledger.bank has 2 orphan values.
        // Constraints omitted (no approved cleansing rule covers these financial references).
    }

    private static void ConfigureInvoice(ModelBuilder mb)
    {
        var e = mb.Entity<Invoice>().ToTable("invoice");
        e.HasKey(x => x.Id);
        e.Property(x => x.Id).HasColumnName("Id").ValueGeneratedOnAdd();
        e.Property(x => x.Refno).HasColumnName("refno");
        e.Property(x => x.Invoiceno).HasColumnName("invoiceno");
        // Money columns (legacy `money`) — decimal(19,4), verbatim round-trip (FR-002).
        e.Property(x => x.Hotelfee).HasColumnName("hotelfee").HasPrecision(19, 4);
        e.Property(x => x.Cabfee).HasColumnName("cabfee").HasPrecision(19, 4);
        e.Property(x => x.Poeremark).HasColumnName("poeremark");
        e.Property(x => x.Poe).HasColumnName("poe").HasPrecision(19, 4);
        e.Property(x => x.Miscremark).HasColumnName("miscremark");
        e.Property(x => x.Misc).HasColumnName("misc").HasPrecision(19, 4);
        e.Property(x => x.Attestfee).HasColumnName("attestfee").HasPrecision(19, 4);
        e.Property(x => x.Attestremark).HasColumnName("attestremark");
        e.Property(x => x.Courierfee).HasColumnName("courierfee").HasPrecision(19, 4);
        e.Property(x => x.Grandtotal).HasColumnName("grandtotal").HasPrecision(19, 4);
        e.Property(x => x.Invoicedate).HasColumnName("invoicedate");
        e.Property(x => x.Remark).HasColumnName("remark");
        e.Property(x => x.Invtype).HasColumnName("invtype");

        // IX_invoice_invoiceno is the FK principal for invoicedetail.invoiceno.
        // Verified against the live VisaEntry DB 2026-08-09: invoiceno is unique in
        // data (0 duplicates, 0 NULLs) though the legacy column is nullable; the
        // alternate key lets the FK reference it via HasPrincipalKey.
        e.HasAlternateKey(x => x.Invoiceno).HasName("IX_invoice_invoiceno");
        e.HasIndex(x => x.Refno).HasDatabaseName("IX_invoice_refno");
    }

    private static void ConfigureInvoiceDetail(ModelBuilder mb)
    {
        var e = mb.Entity<InvoiceDetail>().ToTable("invoicedetail");
        e.HasKey(x => x.Id);
        e.Property(x => x.Id).HasColumnName("Id").ValueGeneratedOnAdd();
        e.Property(x => x.Invoiceno).HasColumnName("invoiceno");
        e.Property(x => x.Paxid).HasColumnName("paxid");
        e.Property(x => x.Countryid).HasColumnName("countryid");
        // Money columns (legacy `money`) — decimal(19,4), verbatim round-trip (FR-002).
        e.Property(x => x.Visafee).HasColumnName("visafee").HasPrecision(19, 4);
        e.Property(x => x.Handlingfee).HasColumnName("handlingfee").HasPrecision(19, 4);
        e.Property(x => x.Ddcharges).HasColumnName("ddcharges").HasPrecision(19, 4);
        e.Property(x => x.Invtype).HasColumnName("invtype");
        e.Property(x => x.VFSTTCharges).HasColumnName("VFSTTCharges").HasPrecision(19, 4);

        // FK: invoicedetail.invoiceno -> invoice.invoiceno (principal = natural key,
        // not the surrogate Id; unique in data per live check 2026-08-09)
        e.HasOne<Invoice>().WithMany().HasForeignKey(x => x.Invoiceno).HasPrincipalKey(x => x.Invoiceno).OnDelete(DeleteBehavior.Restrict);

        e.HasIndex(x => x.Invoiceno).HasDatabaseName("IX_invoicedetail_invoiceno");
    }

    private static void ConfigureHotel(ModelBuilder mb)
    {
        var e = mb.Entity<Hotel>().ToTable("hotel");
        e.HasKey(x => x.Hotelid);
        e.Property(x => x.Hotelid).HasColumnName("hotelid");
        e.Property(x => x.Description).HasColumnName("description");
    }

    private static void ConfigureCab(ModelBuilder mb)
    {
        var e = mb.Entity<Cab>().ToTable("cab");
        e.HasKey(x => x.Cabid);
        e.Property(x => x.Cabid).HasColumnName("cabid");
        e.Property(x => x.Description).HasColumnName("description");
    }

    private static void ConfigurePaxHotel(ModelBuilder mb)
    {
        var e = mb.Entity<PaxHotel>().ToTable("paxhotel");
        e.HasKey(x => x.Id);
        e.Property(x => x.Id).HasColumnName("Id").ValueGeneratedOnAdd();
        e.Property(x => x.Refno).HasColumnName("refno");
        e.Property(x => x.Name).HasColumnName("name");
        e.Property(x => x.Hotelname).HasColumnName("hotelname");
        e.Property(x => x.Arrivaltime).HasColumnName("arrivaltime");
        e.Property(x => x.Arrivaldate).HasColumnName("arrivaldate");
        e.Property(x => x.Departtime).HasColumnName("departtime");
        e.Property(x => x.Departdate).HasColumnName("departdate");
        e.Property(x => x.Nosofdays).HasColumnName("nosofdays");
        e.Property(x => x.Tariff).HasColumnName("tariff");
        e.Property(x => x.Transportation).HasColumnName("transportation");
        e.Property(x => x.Flightdetail).HasColumnName("flightdetail");
        e.Property(x => x.Flightstatus).HasColumnName("flightstatus");
        e.Property(x => x.Misccharges).HasColumnName("misccharges");
        e.Property(x => x.Total).HasColumnName("total");
        e.Property(x => x.Noofrooms).HasColumnName("noofrooms");
        e.Property(x => x.EntryDateTime).HasColumnName("entryDateTime");
    }

    private static void ConfigurePaxCab(ModelBuilder mb)
    {
        var e = mb.Entity<PaxCab>().ToTable("paxCab");
        e.HasKey(x => x.Id);
        e.Property(x => x.Id).HasColumnName("Id").ValueGeneratedOnAdd();
        e.Property(x => x.Refno).HasColumnName("refno");
        e.Property(x => x.Name).HasColumnName("name");
        e.Property(x => x.Cabowner).HasColumnName("cabowner");
        e.Property(x => x.Vehical).HasColumnName("vehical");
        e.Property(x => x.Cabno).HasColumnName("cabno");
        e.Property(x => x.Ac).HasColumnName("ac");
        e.Property(x => x.Sdate).HasColumnName("sdate");
        e.Property(x => x.Enddate).HasColumnName("enddate");
        e.Property(x => x.Startfrom).HasColumnName("startfrom");
        e.Property(x => x.Standeredkm).HasColumnName("standeredkm");
        e.Property(x => x.Standeredhour).HasColumnName("standeredhour");
        e.Property(x => x.Actualkm).HasColumnName("actualkm");
        e.Property(x => x.Actualhour).HasColumnName("actualhour");
        e.Property(x => x.Extrakm).HasColumnName("extrakm");
        e.Property(x => x.Extrahour).HasColumnName("extrahour");
        e.Property(x => x.Extrainfo).HasColumnName("extrainfo");
        e.Property(x => x.Extraamount).HasColumnName("extraamount");
        e.Property(x => x.Mode).HasColumnName("mode");
        e.Property(x => x.Dest).HasColumnName("dest");
        e.Property(x => x.Orderedby).HasColumnName("orderedby");
        e.Property(x => x.Ratesperday).HasColumnName("ratesperday");
        e.Property(x => x.Noofday).HasColumnName("noofday");
        e.Property(x => x.Total).HasColumnName("total");
        e.Property(x => x.EntryDateTime).HasColumnName("entryDateTime");
    }

    private static void ConfigureScheduler(ModelBuilder mb)
    {
        var e = mb.Entity<Scheduler>().ToTable("scheduler");
        e.HasKey(x => x.Id);
        e.Property(x => x.Id).HasColumnName("messageid").ValueGeneratedOnAdd();
        e.Property(x => x.Date).HasColumnName("date");
        e.Property(x => x.Messageto).HasColumnName("messageto");
        e.Property(x => x.Messagefrom).HasColumnName("messagefrom");
        e.Property(x => x.Subject).HasColumnName("subject");
        e.Property(x => x.Description).HasColumnName("description");
        e.Property(x => x.Messageread).HasColumnName("messageread");
        e.Property(x => x.Sentdate).HasColumnName("sentdate");
    }

    private static void ConfigurePriWork(ModelBuilder mb)
    {
        var e = mb.Entity<PriWork>().ToTable("priwork");
        e.HasKey(x => x.Id);
        e.Property(x => x.Id).HasColumnName("id").ValueGeneratedOnAdd();
        e.Property(x => x.Givenby).HasColumnName("givenby");
        e.Property(x => x.Date).HasColumnName("date");
        e.Property(x => x.Edate).HasColumnName("edate");
        e.Property(x => x.Work).HasColumnName("work");
        e.Property(x => x.Status).HasColumnName("status");
    }

    private static void ConfigureSubscriber(ModelBuilder mb)
    {
        var e = mb.Entity<Subscriber>().ToTable("subscriber");
        e.HasKey(x => x.Id);
        e.Property(x => x.Id).HasColumnName("id").ValueGeneratedOnAdd();
        e.Property(x => x.Name).HasColumnName("name");
        e.Property(x => x.Email).HasColumnName("email");
    }
}