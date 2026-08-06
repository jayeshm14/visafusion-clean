# 00_Constitution — VisaFusion

**Status:** Ratified baseline for the modernization program.
**Effective:** 2026-08-06
**Scope:** Every engineering activity executed under the VisaFusion program.

This document is the supreme operating agreement. All other library
documents (`01_System_Role_and_Principles` … `15_Templates`,
`complete_migration_plan`) and all `findings/` snapshots are subordinate
and must be interpreted consistently with this constitution.

---

# 1. Project Identity

- **Project Name:** VisaFusion
- **Source system:** Legacy Classic ASP application in `G:\Projects\VisaEntry`
- **Target platform:** ASP.NET Core (EF Core, SQL Server, ASP.NET Core Identity)
- **Repository principle:** GitHub is the single source of truth.

---

# 2. Mission

1. Modernize the legacy Classic ASP Visa system into ASP.NET Core.
2. Follow Specification-Driven Development.
3. Never invent business features.
4. Preserve legacy business behaviour.
5. Preserve all production data.
6. Never drop business tables except `dtproperties`.
7. Normalize carefully.
8. Everything must be traceable.
9. Knowledge Graph must be updated after every completed task.
10. Every architectural decision requires an ADR.
11. Every module requires a SpecKit specification.
12. Every implementation must have automated tests.
13. Every change must update documentation.
14. Every task must keep the repository buildable.
15. Every task must keep the repository deployable.
16. Stop whenever information is missing.
17. Generate a Gap Report instead of assumptions.

---

# 3. Binding Rules

- **No guessing.** Missing information halts work and produces a Gap Report.
- **No feature invention.** The legacy application is the functional
  specification; ambiguous behaviour is escalated, not assumed.
- **No data loss.** Production data is preserved in full. Business tables are
  never dropped; only `dtproperties` may be removed.
- **No silent change.** Every change is traceable to a legacy artifact or a
  ratified decision (ADR / specification).
- **No unverified state.** Definition of Done requires specification,
  architecture, code, database validation, tests, security review,
  documentation, and traceability all satisfied.
- **Fixed execution order.** The OpenCode pipeline stages in
  `library/02` may not be skipped.
- **Security by default.** Plaintext passwords, query-string identity,
  string-concatenated SQL, anonymous write endpoints, and the
  `connection.asp` backdoor are removed in the target system.

---

# 4. Artifact Governance

Every work item produces the artifacts defined in
`library/01` §5 and `library/15` §8: specification, architecture update,
source code, database migration, tests, documentation, decision log,
risk assessment, traceability matrix, release notes.

Naming conventions per `library/15` §7:
`SPEC-XXXX`, `ADR-XXXX`, `DB-XXXX`, `TEST-XXXX`, `MIG-XXXX`.

---

# 5. Ratification

This constitution is accepted as the operating baseline. Amendments require
an ADR. No implementation stage begins until this constitution is satisfied
by the repository state.
