namespace VisaFusion.Migration.Catalog;

/// <summary>Disposition of a legacy table on the target (data-model.md §3).</summary>
public enum TableDisposition
{
    /// <summary>Live/writable entity — migrated with full target schema.</summary>
    M,
    /// <summary>Read-only/historical entity — migrated, never updated by the app.</summary>
    MRO,
    /// <summary>Archived until owner confirmation — schema present, data held back (BR-004).</summary>
    Cond,
    /// <summary>Archived with no live entity — reported, not migrated.</summary>
    Arch,
    /// <summary>Dropped — explicitly absent from the target (BR-001).</summary>
    Drop
}

    /// <summary>
    /// Immutable catalog of every legacy table and its target disposition
    /// (SPEC-0004 data-model.md §3, FR-001 52-table disposition). This is the single
    /// source of truth used by copy, cleanse, validate, and report so every table is
    /// accounted for (AC-001).
    /// </summary>
    public sealed record TableSpec(
        string LegacyTable,
        string? TargetTable,
        string? TargetEntity,
        TableDisposition Disposition,
        bool AppendOnly = false,
        string? IdentityColumn = null,
        bool SurrogateKey = false,
        bool HasRowCount = true,
        int RowDelta = 0)
    {
        /// <summary>Checksum is compared only for migrated (M/MRO) tables without cleansing.</summary>
        public bool IsMigrated => Disposition is TableDisposition.M or TableDisposition.MRO;

        /// <summary>
        /// Schema-conformant disposition label for the migration report
        /// (contracts/migration-report.schema.json §tables.disposition enum:
        /// M | M-RO | COND | ARCH | DROP). The enum value differs from the C#
        /// enum name for MRO ("M-RO" vs "MRO"), so the label is explicit.
        /// </summary>
        public string DispositionLabel => Disposition switch
        {
            TableDisposition.M => "M",
            TableDisposition.MRO => "M-RO",
            TableDisposition.Cond => "COND",
            TableDisposition.Arch => "ARCH",
            TableDisposition.Drop => "DROP",
            _ => Disposition.ToString().ToUpperInvariant()
        };
    }

/// <summary>Registry of all 52 legacy tables (count asserted by the runner).</summary>
public static class TableCatalog
{
    /// <summary>
    /// All 52 legacy tables in FK-dependency copy order (parents first).
    /// Reference data (lookup tables) come first so FK principals exist before
    /// children are bulk-loaded (FR-003, contracts/migration-cli.md §2 copy).
    /// </summary>
    public static IReadOnlyList<TableSpec> All { get; } = Build();

    /// <summary>Tables copied by the bulk-copy engine, in dependency order.</summary>
    public static IReadOnlyList<TableSpec> Migrated => All.Where(t => t.IsMigrated).ToArray();

    /// <summary>Drop-disposition tables that MUST be absent from the target (BR-001).</summary>
    public static IReadOnlyList<string> DropTables => All
        .Where(t => t.Disposition == TableDisposition.Drop)
        .Select(t => t.LegacyTable)
        .ToArray();

    private static List<TableSpec> Build()
    {
        // Copy order: lookup/reference first, then agents/embassy, then
        // Mainentry, then child tables, then history/audit last.
        return
        [
            // Reference / lookup tables (FK principals).
            // status: FR-005a — legacy statusID=508 has a duplicate row (physloc
            // (1:255:19) "Withdraw" and (1:255:22) "Approval Awaited"); the approved
            // cleansing keeps the first description (Withdraw), collapsing 27 → 26
            // rows at copy time, so validation expects source + RowDelta (-1).
            new("status", "status", "Status", TableDisposition.M, RowDelta: -1),
            new("Category", "Category", "Category", TableDisposition.M),
            new("EntryType", "EntryType", "EntryType", TableDisposition.M),
            new("Poe", "Poe", "Poe", TableDisposition.M),
            new("Attestation", "Attestation", "Attestation", TableDisposition.M),
            new("certificate", "certificate", "Certificate", TableDisposition.M),
            new("bank", "bank", "Bank", TableDisposition.M),
            new("embassy", "embassy", "Embassy", TableDisposition.M, IdentityColumn: "EmbassyID"),
            new("CountryInfo", "CountryInfo", "CountryInfo", TableDisposition.M),
            new("VisaInfo", "VisaInfo", "VisaInfo", TableDisposition.M, SurrogateKey: true),
            new("holidaylist", "holidaylist", "Holiday", TableDisposition.M, SurrogateKey: true),
            new("weeklyoff", "weeklyoff", "WeeklyOff", TableDisposition.M, SurrogateKey: true),
            // COND — archived until owner confirmation (BR-004): the target
            // schema creates the table (data-model.md §3.3), but data is held
            // back. TargetTable is set so schema tests cover them; copy skips
            // Cond disposition explicitly (CopyCommand).
            new("hotel", "hotel", "Hotel", TableDisposition.Cond),
            new("cab", "cab", "Cab", TableDisposition.Cond),

            // Business partners (FK principals for Mainentry.agent)
            // agents: FR-005e — legacy agentsID=4114 has a duplicate row (GAP-0002,
            // populated profile + all-NULL ghost; agentsID is identity in legacy and
            // the table is a heap, so the ghost required IDENTITY_INSERT). The
            // approved cleansing keeps the populated row, collapsing 4218 → 4217
            // rows at copy time, so validation expects source + RowDelta (-1).
            new("agents", "agents", "Agent", TableDisposition.M, IdentityColumn: "agentsID", RowDelta: -1),
            new("newagents", "newagents", "AgentStaging", TableDisposition.MRO, IdentityColumn: "newagentsID"),

            // Master entry
            new("Mainentry", "Mainentry", "Entry", TableDisposition.M, IdentityColumn: "id"),

            // Children of Mainentry
            new("entryDetails", "entryDetails", "EntryPassenger", TableDisposition.M, IdentityColumn: "PaxID"),
            new("PaxStatus", "PaxStatus", "PaxCountryStatus", TableDisposition.M, SurrogateKey: true),
            new("invoice", "invoice", "Invoice", TableDisposition.MRO, SurrogateKey: true),
            new("invoicedetail", "invoicedetail", "InvoiceDetail", TableDisposition.MRO, SurrogateKey: true),
            new("PaxAttestation", "PaxAttestation", "PaxAttestation", TableDisposition.M, SurrogateKey: true),
            new("paxhotel", "paxhotel", "PaxHotel", TableDisposition.Cond, SurrogateKey: true),
            new("paxCab", "paxCab", "PaxCab", TableDisposition.Cond, SurrogateKey: true),
            new("masterbalance", "masterbalance", "MasterBalance", TableDisposition.M, SurrogateKey: true),
            new("Ledger", "Ledger", "LedgerHistory", TableDisposition.MRO, IdentityColumn: "id"),
            new("security", "security", "SecurityDay", TableDisposition.M, SurrogateKey: true),

            // Communication / audit history (append-only)
            new("sentmails", "sentmails", "EmailLog", TableDisposition.M, AppendOnly: true, IdentityColumn: "id"),
            new("sentawb", "sentawb", "AwbLog", TableDisposition.M, AppendOnly: true, IdentityColumn: "id"),
            new("smshistory", "smshistory", "SmsLog", TableDisposition.M, AppendOnly: true, SurrogateKey: true),
            new("smsQueue", "smsQueue", "SmsQueue", TableDisposition.M, AppendOnly: true, SurrogateKey: true),
            new("StatusHistory", "StatusHistory", "StatusHistoryEntry", TableDisposition.M, AppendOnly: true, SurrogateKey: true),
            new("bighistory", "bighistory", "EntryAuditLog", TableDisposition.M, AppendOnly: true, IdentityColumn: "bighistoryid"),
            new("deleteditem", "deleteditem", "DeletedItemAudit", TableDisposition.MRO, AppendOnly: true, SurrogateKey: true),
            new("dailyUpdate", "dailyUpdate", "ContentUpdate", TableDisposition.M, AppendOnly: true, SurrogateKey: true),
            new("scheduler", "scheduler", "Scheduler", TableDisposition.Cond, IdentityColumn: "messageid"),
            new("priwork", "priwork", "PriWork", TableDisposition.Cond, IdentityColumn: "id"),
            new("subscriber", "subscriber", "Subscriber", TableDisposition.Cond, IdentityColumn: "id"),

            // Identity sources — consumed by the `identity` command (FR-004),
            // not bulk-copied; counted by snapshot/report for AC-001.
            new("registration", null, null, TableDisposition.Arch, HasRowCount: true),
            new("Udaan_users", null, null, TableDisposition.Arch, HasRowCount: true),

            // ARCH — archived, no live entity (reported, not migrated)
            new("invno", null, null, TableDisposition.Arch, HasRowCount: false),
            new("quote", null, null, TableDisposition.Arch, HasRowCount: false),
            new("diary", null, null, TableDisposition.Arch, HasRowCount: false),
            new("emailid", null, null, TableDisposition.Arch, HasRowCount: false),
            new("emaild1", null, null, TableDisposition.Arch, HasRowCount: false),
            new("changes", null, null, TableDisposition.Arch, HasRowCount: false),
            new("changesbill", null, null, TableDisposition.Arch, HasRowCount: false),

            // DROP — must be absent from target (BR-001)
            new("dtproperties", null, null, TableDisposition.Drop, HasRowCount: false),
            new("country", null, null, TableDisposition.Drop, HasRowCount: false),
            new("Results", null, null, TableDisposition.Drop, HasRowCount: false),
            new("hits", null, null, TableDisposition.Drop, HasRowCount: false),
            new("adcount", null, null, TableDisposition.Drop, HasRowCount: false),
        ];
    }
}
