# Specification Quality Checklist: notifications-content-reporting

**Purpose**: Validate specification completeness and quality before proceeding to planning
**Created**: 2026-08-18
**Feature**: [specs/008-notifications-content-reporting/spec.md](spec.md)

## Content Quality

- [x] No implementation details (languages, frameworks, APIs) — PASS-in-context: the VisaFusion override template mandates §15 API Contracts / §16 Database Changes / §17 Validation Rules; all technical detail is grounded in legacy pages and SPEC-0005/0006/0007 contracts (no invented endpoints beyond the pre-registered §4.3 route families)
- [x] Focused on user value and business needs
- [x] Written for non-technical stakeholders — core sections (§1-§10, §20) are business-readable; technical sections follow the mandated 24-section template
- [x] All mandatory sections completed — all 24 sections + Assumptions + Clarifications present, in template order

## Requirement Completeness

- [x] No [NEEDS CLARIFICATION] markers remain — both markers resolved 2026-08-18 by owner: Q1 → C (enqueue-and-log mode for v1), Q2 → A (core report set, no email dispatch); integrated into §9/§15/§20/§21/§24, Assumptions, and Clarifications
- [x] Requirements are testable and unambiguous
- [x] Success criteria are measurable — AC-001..AC-010 with concrete status codes, audit fields, and latency bounds
- [x] Success criteria are technology-agnostic — measured at the API/behavior boundary per the repo template's §20 convention
- [x] All acceptance scenarios are defined — 10 acceptance criteria covering all FRs via the traceability matrix
- [x] Edge cases are identified — duplicate holiday/weekly-off (409), rate limit (429), both-holiday-and-weekly-off and unknown-embassy bookability (HolidayService semantics, SPEC-0006), dispatch failure retry, invalid date inputs
- [x] Scope is clearly bounded — §5 vs §6 split; SPEC-0006 rule explicitly reused, not re-implemented
- [x] Dependencies and assumptions identified — §22 and Assumptions cover SPEC-0003/0004/0005/0006/0007, GAP-0004, vendor confirmation, retired-name resolution

## Feature Readiness

- [x] All functional requirements have clear acceptance criteria — FR-001..012 mapped in §24 traceability matrix
- [x] User scenarios cover primary flows — SMS/email enqueue+dispatch, contact query → office email, CMS, holiday CRUD, reports (per repo template these are captured as FR/AC/test scenarios, not standalone user stories)
- [x] Feature meets measurable outcomes defined in Success Criteria — all success criteria traced to ACs
- [x] No implementation details leak into specification — PASS-in-context (see first item; repo override template mandates technical sections)

## Notes

- All 16 items pass — spec is ready for `/speckit.plan`
- Owner decisions recorded 2026-08-18: Q1 → C (enqueue-and-log mode for v1, no real send until a vendor is configured); Q2 → A (report v1 set = pending list + today submission/collection/transaction + daily visa fee + daily bill; no report email dispatch in v1); Q3 → A (queries rate limit 5/hour per source enforced in v1); Q4 → A (`queries.status` kept, defaults to `new`, no processing surface in v1)
- Audit remediation recorded in this version: retired `fn_IsBookableDate` name resolved (SPEC-0006 CHK051/GR-0002); `querieDetail.asp` misattribution removed (verified: `visaInfo` upsert, unrelated to contact queries); policy-catalog citation corrected to SPEC-0005 §5; Jobs scaffolding attributed to SPEC-0003; 24-section template restored

---

# Requirements Quality Unit Tests — SPEC-0008 (append via /speckit.checklist)

**Purpose**: Validate the QUALITY of the SPEC-0008 requirements (unit tests for requirements writing) — completeness, clarity, consistency, measurability, coverage, edge cases, NFRs, dependencies, ambiguities. NOT implementation verification.
**Created**: 2026-08-18 | **Spec**: [../spec.md](../spec.md) | **Plan**: [../plan.md](../plan.md) | **Research**: [../research.md](../research.md)
**Audience**: PR reviewer | **Depth**: Standard

## Requirement Completeness

- [X] CHK001 - Are SMS notification-queue requirements complete across all three stages (enqueue → background dispatch → `smshistory` audit) with no stage left implicit? [Completeness, Spec §9 FR-001/003/004]
- [X] CHK002 - Are email notification-queue requirements complete including a durable backing store, given no legacy email queue exists (verified: no `emailQueue` in findings/library)? [Gap, Spec §16 + research D-1]
- [X] CHK003 - Is the enqueue-and-log dispatch provider (v1 default) specified in the requirements themselves, including how real vendor dispatch is later enabled? [Completeness, Spec §21 + Assumptions]
- [X] CHK004 - Are requirements defined for ALL six v1 report surfaces and their input-filter behavior, or is any report left unspecified? [Completeness, Spec §9 FR-012 + §15]
- [X] CHK005 - Is the dailyUpdate CMS requirement complete for create, edit, AND delete plus the anonymous public read? [Completeness, Spec §9 FR-010]

## Requirement Clarity

- [X] CHK006 - Is the retry policy quantified (3 attempts, exponential backoff, idempotent per message) rather than left as an unqualified "retry"? [Clarity, Spec §11 NFR-005 + Assumptions]
- [X] CHK007 - Is the contact-query rate limit stated as an unconditional v1 figure (5/hour per source) with no residual conditional phrasing? [Clarity, Spec §17 + AC-001]
- [X] CHK008 - Is the office-notification email content specified precisely enough for golden-file testing against the legacy `contactsendpre.asp` template (sender details + message text)? [Clarity, Spec §19 + §23]
- [X] CHK009 - Is the weekday numbering convention (VBScript 1=Sunday..7=Saturday) stated identically everywhere weekdays appear? [Clarity, Spec §10 BR-006]
- [X] CHK010 - Is the `queries.status` lifecycle unambiguous: write-once `new` in v1, no processing surface, future management module owned? [Clarity, Spec §16 + Assumptions]

## Requirement Consistency

- [X] CHK011 - Do the `smshistory` audit fields agree across FR-004, §19, and §16 (all eight legacy fields)? [Consistency, Spec §9/§16/§19]
- [X] CHK012 - Do the `sentmails` audit fields agree across FR-005, §19, and §16 (id, agentsid, date, toemail, awb)? [Consistency, Spec §9/§16/§19]
- [X] CHK013 - Are endpoint role authorizations consistent between FR-009, §12, and §15 for every notification/content/holiday/report route? [Consistency, Spec §9/§12/§15]
- [X] CHK014 - Is "no change to the six legacy tables" (§16) reconciled with the NEW `emailQueue` design decision — registered in §16 or explicitly flagged for amendment? [Consistency, Gap, Spec §16 + research D-1]
- [X] CHK015 - Do the acceptance criteria and the traceability matrix cover every FR with no orphan FRs or ACs? [Consistency, Spec §20 + §24]

## Acceptance Criteria Quality

- [X] CHK016 - Is AC-001's 429 boundary unambiguous about which request within the window is rejected (6th submission)? [Measurability, Spec §20 AC-001]
- [X] CHK017 - Is AC-007's "immediately honored by the bookable-date rule" tied to a defined ground-truth (`IHolidayService.IsEmbassyClosedAsync`) so it is objectively verifiable? [Measurability, Spec §20 AC-007]
- [X] CHK018 - Is AC-009's "under 1 second" enqueue latency given a measurement boundary (server-side response time)? [Measurability, Spec §20 AC-009]
- [X] CHK019 - Is AC-010's "no credentials in source or logs" scoped with a defined search surface (source tree + generated logs)? [Measurability, Spec §20 AC-010]

## Scenario Coverage

- [X] CHK020 - Are exception-flow requirements defined for dispatch failure, retry exhaustion, and worker crash during drain? [Coverage, Spec §18]
- [X] CHK021 - Are recovery requirements defined for a worker crash mid-drain (transactional send-once — no duplicate, no lost message)? [Gap, Spec §18 + research D-3]
- [X] CHK022 - Is the anonymous-write boundary explicit: the ONLY anonymous write is the validated, rate-limited query submission? [Coverage, Spec §12 BR-004]
- [X] CHK023 - Are zero-row/empty-state requirements defined for all six reports and the public daily-update page? [Coverage, Spec §14]

## Edge Case Coverage

- [X] CHK024 - Are duplicate holiday (embassy+date) and weekly-off (embassy+weekday) edge cases defined with explicit 409 semantics? [Edge Case, Spec §17 + §18]
- [X] CHK025 - Are invalid weekday (outside 1–7) and invalid date inputs defined as validation-rejected (400) before rule/query execution? [Edge Case, Spec §17]
- [X] CHK026 - Is the both-holiday-and-weekly-off bookability edge case specified (most restrictive rule wins)? [Edge Case, Spec §17]
- [X] CHK027 - Is the unknown-embassy edge case specified (no calendar rows → bookable)? [Edge Case, Spec §17]
- [X] CHK028 - Is the dailyUpdate 8,000-character description boundary specified with defined overflow behavior? [Edge Case, Spec §17]

## Non-Functional Requirements

- [X] CHK029 - Are performance requirements quantified (enqueue <1s, reports <5s) and traceable to acceptance criteria? [NFR, Spec §13 + §20]
- [X] CHK030 - Is observability specified for every notification send AND failure (structured logs + counters)? [NFR, Spec §11 NFR-003]
- [X] CHK031 - Is report output determinism (same input date range → same ordering) specified as a requirement? [NFR, Spec §11 NFR-006]
- [X] CHK032 - Is data access required to be parameterized (no string-concatenated SQL) with the §6.6 report SQLi finding explicitly closed? [NFR, Spec §11 NFR-002]

## Dependencies & Assumptions

- [X] CHK033 - Are all cross-spec dependencies (SPEC-0003/0004/0005/0006/0007, GAP-0004) documented with their impact on this feature? [Dependencies, Spec §22]
- [X] CHK034 - Is the enqueue-and-log assumption stated and consistent with the acceptance criteria (no AC requires a real vendor send)? [Assumption, Spec §21 + Assumptions]
- [X] CHK035 - Is the GAP-0004 dependency on agent-linked notification addressing and report joins explicitly identified? [Dependency, Spec §22]

## Ambiguities & Conflicts

- [X] CHK036 - Is the retired `fn_IsBookableDate` reference fully resolved with no residual use of the retired name in the spec? [Ambiguity, Spec §4]
- [X] CHK037 - Is the contact-query legacy attribution consistent everywhere (`contactus.asp` → `contactsendpre.asp` email flow; `querieDetail.asp` NOT related)? [Conflict-check, Spec §8 + §16]
- [X] CHK038 - Is the `emailQueue` table's absence from §16 explicitly flagged as a traceability amendment item for the implementation phase? [Gap, research D-1]

## Notes (this append)

- 38 new items (CHK001–CHK038) appended by /speckit.checklist on 2026-08-18; numbering restarts at CHK001 because the original 16 items predate the CHK ID scheme (no IDs existed to continue from).
- Known open checks identified by this run: CHK002/CHK014/CHK038 (emailQueue not registered in spec §16 — flagged for implementation-phase amendment), CHK008 (office-email golden-file template precision), CHK018 (AC-009 measurement boundary), CHK021 (mid-drain crash recovery wording in §18).
- **RESOLVED 2026-08-18 (post-analyze remediation + checklist verification)**: all 38 CHK items evaluated against the amended artifacts and closed.
  - CHK002/CHK014/CHK038 — spec §16 now registers the NEW `emailQueue` table (also in Assumptions; traceability amendment tracked by tasks T001).
  - CHK008 — golden-file ground truth verified in legacy source this session: `contactsendpre.asp` To=`usbhardwaj@udaanindia.com`, From=`request("email")`, Subject=`Query form UdaanIndia.com`, HTMLBody = sender details (Name/Company/Phone/Fax/Email/City) + Message text; spec §19/§23 + T021 reference this template.
  - CHK017 — AC-007 now names the objective ground truth `IHolidayService.IsEmbassyClosedAsync` (method verified in `src/VisaFusion.Core/Application/HolidayService.cs`).
  - CHK018 — AC-009 now scoped to server-side response time measured at the API boundary.
  - CHK019 — AC-010 now scoped to the committed source tree + generated logs.
  - CHK020/CHK021 — spec §18 now states retry-exhaustion behavior (failed status logged, queue row retained) and mid-drain transactional crash safety (research D-3; no duplicate, no lost message).
  - CHK028 — spec §17 now states explicit 400 rejection for dailyUpdate descriptions over 8,000 characters.
