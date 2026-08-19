using Xunit;

// The integration tests share a live SQL Server (legacy VisaEntry + target
// VisaFusion) and several tests write to the same tables (audit tables,
// queues, holiday/weekly-off rows). xUnit's default per-class parallelism lets
// those writes collide — e.g. the SPEC-0004 byte-identical audit checksum
// (AuditTableTests) can be computed while a SPEC-0008 drain test holds rows in
// smshistory/sentmails, producing a spurious checksum mismatch. Serialize the
// assembly: DB integration tests must not run concurrently.
[assembly: CollectionBehavior(DisableTestParallelization = true)]