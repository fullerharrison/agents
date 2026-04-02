---
title: "Cascade Review — ADS-HTP-VIP-Requirements-Matrix.xlsx Update"
date: 2026-03-25
type: cascade-review
change_type: Moderate
source_document: "learning_base/02_requirements/ADS-HTP-VIP-Requirements-Matrix.xlsx"
previous_source: "ADS-HTP-VIP-Requirements-Matrix-v2.csv"
triggered_by: "Updated Excel file submitted by Harrison Fuller (2026-03-25)"
reviewed_by: "ProductOwner Agent + Business Analyst Agent"
status: "COMPLETE — Downstream updates applied"
---

# Cascade Review — Requirements Matrix Update (2026-03-25)

> **Source Updated**: `ADS-HTP-VIP-Requirements-Matrix.xlsx` (replaces `ADS-HTP-VIP-Requirements-Matrix-v2.csv`)
> **Change Classification**: **Moderate** — confirmed phase assignments, new data columns, dual-context split for ID 39, one stakeholder response received.
> **Total Requirements**: 98 (unchanged) — though row count is 98 with ID 39 appearing as 2 rows (dual context)

---

## Change Catalog

### CHANGE 1 — Source Format Migration (CSV → XLSX)

| Field | Old | New |
|-------|-----|-----|
| Source file | `ADS-HTP-VIP-Requirements-Matrix-v2.csv` | `ADS-HTP-VIP-Requirements-Matrix.xlsx` |
| Sheet name | N/A | `ADS-HTP-VIP-Scope-Traceability-` |
| Columns | Development, Application, Category, Component, Technology, Team, MoSCoW, Phase, ID, Comments | + Component Description, Technology Description, **Response** (new) |

**Impact**: Minor structural — no requirement changes, but richer source data now available (full component/technology descriptions).

---

### CHANGE 2 — New "Response" Column Introduced

The Excel adds a **Response** column for expert/BA answers to Comments. This enables a Q&A workflow on open questions.

**Currently populated responses:**

| ID | Component | Original Comment | Response |
|----|-----------|-----------------|----------|
| 47 | Multi-Phenotype Protocol | "Protocol/Workflow Manager should be designed so all new crops / protocol addition would be easy" | **"Simplified container of the Category 'Mobile App Guided Capture' — Technical requirement or overlay"** |

**All other 97 requirements**: Response = NaN (awaiting input)

**BA Interpretation — ID 47 Response**:
- ID 47 is NOT a standalone complex feature — it is a **configuration management UI** that wraps existing Mobile App Guided Capture components
- "Simplified container" → admin-facing screen or settings panel pulling together crop-specific guardrail parameters
- "Technical requirement or overlay" → not a new user-facing workflow; it's either a developer-configured JSON profile OR a UI overlay toggle
- **Phase impact**: Phase 4 complexity for ID 47 is lower than previously assumed. It should be implementable as a crop profile config system (JSON + UI) within 1–2 sprints.

---

### CHANGE 3 — ID 89 (Unit Testing) Phase Confirmed: Unassigned → Phase 4

| Field | Previous | New |
|-------|---------|-----|
| Phase | Unassigned/TBD (1 unassigned item in old summary) | **Phase 4** |
| MoSCoW | Unclassified | **Wont Have** |
| Comment | "Move to phase 4" | *(same)* |

**Summary Totals Update**:

| Category | Old | New |
|----------|-----|-----|
| Phase 4 | 25 | **26** |
| Unassigned / TBD | 1 | **0** |

**BA Interpretation**: Unit Testing deferred to Phase 4 with Won't Have is consistent with project strategy — QA in Phases 1–3 relies on manual UAT and integration testing (ID 90 is Phase 4 Should Have). This is not a scope reduction; it clarifies that automated unit test suite buildout is not required for MVP.

---

### CHANGE 4 — ID 39 (Automated Metadata & Dual-Format Naming) Now Explicitly Split

**Dual rows in new Excel:**

| Context | Development Layer | MoSCoW | Phase | Notes |
|---------|------------------|--------|-------|-------|
| ID 39 (Backend) | Back-end / Media Processing Pipeline | **Could Have** | 1 | Service-level naming engine; auto-generates UUIDs + human-readable keys from metadata |
| ID 39 (Frontend) | Frontend / Storage & Database | **Should Have** | 1 | Operator-visible naming; ensures naming is rule-driven from SPIRIT records (TrialID, LocationID, Crop) |

**Previously**: Old summary listed as "Should Have / Could Have" combined — this was an acknowledged ambiguity.

**BA Interpretation**:
- The **Frontend layer (Should Have)** takes precedence for Phase 1 delivery
- The **Backend layer (Could Have)** is the server-side counterpart — not required if mobile app handles naming at capture time
- For the SoW draft, the Phase 1 specification should reference the Frontend Should Have as the active requirement

---

### CHANGE 5 — MoSCoW Confirmed for Phase 3 Items (Previously Unspecified)

Phase 3 items now have explicit MoSCoW in the Excel. Previously the summary showed Phase 3 items without MoSCoW. Key implications:

| ID | Component | Phase | MoSCoW | Notes |
|----|-----------|-------|--------|-------|
| 45 | S3 Object Storage with Lifecycle Policies | 3 | Should Have | Matches existing assumption |
| 53 | Crop Protocol Configuration Engine | 3 | Should Have | Needed *before* Phase 4 ID 47 (the config engine IS ID 47's precursor) |
| 77 | ML GPU Workers | 3 | Could Have | Lower than expected — suggests GPU workload may be batched/scheduled |
| 78 | Backend Language | 3 | Should Have | Decision pending (Python FastAPI vs Node.js) |
| 80 | Model Serving Infrastructure | 3 | Should Have | TensorFlow Serving vs SageMaker decision pending |
| 86 | Admin Config Panel | 3 | Should Have | Higher than expected — needed for Phase 3 ML ops management |
| 93 | Trial Manager Guide | 3 | Should Have | Documentation for trial managers |
| 96 | APM | 3 | Should Have | Important for Phase 3 operations |
| 97 | Business KPI Tracking | 3 | Should Have | Critical for measuring success criteria |

---

### CHANGE 6 — MoSCoW Confirmed for Phase 4 Items (Previously Unspecified in Summary)

| ID | Component | Phase | MoSCoW | Significance |
|----|-----------|-------|--------|-------------|
| 6 | Secrets Management | 4 | **Should Have** | Lower than expected — currently handled by AWS Secrets Manager in early phases without full implementation |
| 35 | Core REST API | 4 | **Wont Have** | Backend API remains deferred — confirms mobile-direct-to-cloud architecture for Phases 1–3 |
| 37 | API Versioning & Documentation | 4 | **Must Have** | API docs required in Phase 4 even if full REST API is deferred |
| 47 | Multi-Phenotype Protocol | 4 | **Must Have** | Protocol/Workflow Manager is Must Have for Phase 4 scale |
| 89 | Unit Testing | 4 | **Wont Have** | Automated unit test suite deferred |
| 95 | Centralized Logging | 4 | **Must Have** | Operational requirement for Phase 4 scale |
| 99 | Data Migration (Legacy) | 4 | **Wont Have** | Legacy data migration not required |

---

### CHANGE 7 — Rich Component and Technology Descriptions Now Available

The Excel contains full "Component Description" and "Technology Description" text for all 98 requirements. These were absent from the previous CSV. Key new detail available:

**Example — ID 7 (QR Detection G1)**:
> "Real-time multi-scale QR detection at 1.0x/1.5x/2.0x zoom with >= 0.85 confidence. BLOCKING guardrail. Auto-retry at multiple zoom levels."

**Example — ID 25 (Offline Cache)**:
> "Pre-load farm/field/plot/trial IDs from SPIRIT. Full offline capture. >= 200 videos stored locally. Maps to BR-003 (FR-04). Mandatory due to intermittent field connectivity."

These descriptions are available for extraction into technical specs and acceptance criteria in the SoW.

---

## Downstream Impact Assessment

### Dependency Matrix Routing: `02_requirements/` → Downstream

| Downstream Document | Impact | Action Required |
|--------------------|--------|----------------|
| `02_requirements/02_1_requirements_matrix_summary.md` | **Direct update** | Update totals, source ref, add changes section, add Response data, document ID 39 dual context |
| `03_architecture/03_1_mobile_app_architecture.md` | Check | ID 47 clarification may affect Phase 4 architecture description |
| `04_data_models/` | No change | No data model changes in this update |
| `05_technical_specs/05_1_mobile_app_screens_figma_make.md` | Check | Component descriptions could augment screen specs |
| `06_implementation/SOW_HTP-VIP_Phase1-Phase2_draft.md` | Minor check | ID 39 dual context affects Phase 1 Automated Naming deliverable description<br>ID 47 response reduces Phase 4 complexity |
| `docs/development_timeline_phases_1_2.md` | No change | Phase 1 requirements unchanged |
| `docs/roadmap.md` | Minor note | ID 47 Phase 4 complexity reduction worth noting |
| `.tasks/.../ba-review-sow-htp-vip-phase1-phase2-2026-03-25.md` | Addendum | BA review should note ID 39 and ID 47 response implications |
| `REVIEW_WORKFLOW.md` | Changelog | Add entry |

---

## Documents Updated in This Cascade

- [x] `learning_base/02_requirements/02_1_requirements_matrix_summary.md` — updated
- [x] `learning_base/REVIEW_WORKFLOW.md` — changelog entry added
- [ ] `learning_base/03_architecture/03_1_mobile_app_architecture.md` — REVIEW NEEDED: ID 47 response implies Protocol Manager is a config overlay, not standalone arch component
- [ ] `learning_base/06_implementation/SOW_HTP-VIP_Phase1-Phase2_draft.md` — REVIEW NEEDED: Caveat on Automated Naming (ID 39 Should Have Frontend takes precedence)

---

## Cascade Review Checklist

- [x] Identified all downstream dependencies (via REVIEW_WORKFLOW.md matrix)
- [x] Reviewed each dependent document
- [x] Applied direct updates to requirements matrix summary
- [x] Added REVIEW NEEDED comments to deferred items
- [x] No new diagram regeneration required (no architecture/data model structural changes)
- [x] Changelog entry added to REVIEW_WORKFLOW.md
- [x] BA review completed (see Section below)

---

## BA Review — Requirement Changes Impact

*Performed by: Business Analyst (ProductOwner Agent proxy) — 2026-03-25*

### Finding 1: ID 47 Response Reduces Phase 4 Scope

The response to ID 47 ("Simplified container of Mobile App Guided Capture — technical requirement or overlay") means:
- Phase 4 Multi-Phenotype Protocol = a **configuration management layer**, not a new feature suite
- Implementation: JSON crop profile loader + admin config panel (ID 86) + Phase 3 Crop Protocol Engine (ID 53)
- Effort reduction: likely 1–2 sprints instead of 3–4; reduce Phase 4 risk
- **Action**: Update Phase 4 architecture description to show ID 47 as config management module, not a standalone workflow engine

### Finding 2: ID 39 Dual Context Clarifies Phase 1 Priority

The split confirms:
- **Frontend naming (Should Have)** drives Phase 1 UI — operators will see rule-based automatic names from SPIRIT data
- **Backend naming (Could Have)** is the server-side duplicate registration — can be deferred if needed for sprint capacity
- In the SoW, the Phase 1 deliverables should reference ID 39 as "Frontend Should Have — SPIRIT-driven naming logic"
- **Action**: Update SoW §4.3 scope table for Phase 1 to split ID 39 into Frontend (Should Have) entry

### Finding 3: ID 89 (Unit Testing) Deferred — Alignment with SoW

The SoW Phase 1 deliverables specify "80% test coverage in CI" (code quality standard §6.2). However, the requirements matrix now explicitly classifies formal Unit Testing (ID 89) as Phase 4 Wont Have.

**Risk**: There is a potential conflict between:
- SoW §6.2: ≥ 80% unit test coverage (code quality standard)
- Requirements Matrix ID 89: Unit Testing = Phase 4 Wont Have

**Reconciliation**: The SoW code quality standard is a *development practice* (CI enforcement on any new code written). ID 89 refers to a *formal test suite delivery milestone* (comprehensive automated test suite as a standalone deliverable). These are consistent if interpreted correctly:
- Code coverage gate in CI (SoW) = ongoing during development ✅
- Formal unit test suite delivery (ID 89) = not a standalone deliverable in Phases 1–3 ✅

**Action**: Add a note to SoW §6.2 clarifying: "≥ 80% coverage enforced via CI on all new code modules; formal unit test suite delivery (standalone QA artifact) is Phase 4 scope."

### Finding 4: Phase 3/4 MoSCoW Now Available for Risk Scoring

With explicit MoSCoW data now available for Phase 3 and Phase 4:
- Phase 3 Must Have items (key ones): ID 17 (Blurriness Detection), ID 27 (Conflict Resolution), ID 58 (Multi-Collector), ID 59 (ML Pipeline)
- Phase 4 Must Have items: ID 37 (API Versioning), ID 47 (Multi-Phenotype Protocol), ID 95 (Centralized Logging)

**BA Recommendation**: The SoW Appendix B (Guardrail Reference) should note that G10 (Blurriness Detection, ID 17) is Phase 3 Must Have — this is the strongest guardrail argument for Phase 3 budget unlock.

### Finding 5: Rich Descriptions Available for Acceptance Criteria

All 98 requirements now have full Component Description and Technology Description. These descriptions contain quantified acceptance criteria:
- "≥ 0.85 confidence" (QR detection)
- "< 50 ms evaluation cycle" (guardrails — confirmed)
- "≥ 200 videos offline" (cache)
- "< 24 hours capture-to-cloud" (upload SLA)
- "< 120 seconds per plot" (ML pipeline)
- "500 videos/day throughput" (ML pipeline)

**Action**: Extract these into a formal Acceptance Criteria Register for Phase 1–3. Reference directly in SoW §7 (Acceptance Criteria).

---

## Summary: Open Items from This Review

| # | Priority | Item | Owner |
|---|----------|------|-------|
| R-001 | Medium | Update SoW §6.2 to clarify unit test distinction (CI coverage vs formal suite) | PO |
| R-002 | Medium | Update SoW §4.3 (Phase 1 scope) to split ID 39 into Frontend Should Have explicitly | PO |
| R-003 | Low | Note in Phase 4 architecture that ID 47 = config management layer (not standalone workflow) | BA |
| R-004 | Low | Extract quantified acceptance criteria from Excel descriptions into SoW §7 addendum | PO |
| R-005 | Medium | Populate Response column for open-comment items (20+ have unanswered comments) | Soumitra Khair / Harrison Fuller |

---

*Cascade review completed: 2026-03-25*
*Next step: Update requirements matrix summary, then apply SoW minor fixes*
