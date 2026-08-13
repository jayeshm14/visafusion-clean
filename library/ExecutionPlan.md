Phase 0 — Foundations

Scaffold VisaFusion.Web/.Api/.Core/.Data/.Identity/.Jobs per §2 target architecture, EF Core DbContext skeleton, URL rewrite, static asset copy per §9
Identity consolidation: Udaan_users + agents + registration → AspNetUsers per §7, hash-on-migration, never store plaintext (§5.4.4 finding)
RBAC matrix: implement §4 full endpoint × role matrix, all 13 anonymous write endpoints re-secured per §4.3

Phase 1 — Core entry workflow
4. Data model: migrate §3's 52-table disposition (M/M-RO/COND/ARCH), Mainentry→Entry aggregate, entryDetails→EntryPassenger, PaxStatus chain
5. Stored procs/functions from §15: RefnoSequence, usp_AllocateNextRefno, usp_RecordEntryStatusChange, fn_IsBookableDate, usp_ProvisionSuperUser
6. Web API layer per §5, one controller set per module, reusing Phase-0 authorization policies

Phase 2 — Notifications, content, reporting
7. SmsService/EmailService/Jobs background queues per §6.7, holiday/weeklyoff/Sunday rule via fn_IsBookableDate, dailyUpdate CMS

Phase 3 — Admin/agent CRUD, security gate, public site, theme
8. Agent/admin CRUD, security-day gate admin-only (§4.2), public site parity
9. Professional UI theme per §14: replace AdminLTE, design-token system, WCAG-AA baseline, UTF-8 fix

Phase 4 — Cleansing, normalization, cutover, decommission
10. Data cleansing per §6 ordered remediation script list (statusID 508 dup, junk dates, orphaned agents)
11. Additive normalization per §16: Country entity, FKs, OrganizationProfile, emailid/emaild1 archive view
12. Decommission checklist per §9: archive Demo/r&d/udaanuma-dev, delete _vti_cnf/*_bak, cutover to maintenance URL

Cross-cutting, run once implement is underway
13. Brand rename per §13: VisaFusion everywhere except excluded literal artifacts
14. Infra/ops per §11: secrets to Key Vault/User Secrets, dedicated SQL login, TLS/HSTS, Serilog, health checks, backups, CI/CD with xUnit + golden-file comparison from §8