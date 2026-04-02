---
title: "BA Review — SOW_HTP-VIP_Phase1-Phase2_draft.md"
date: 2026-03-25
reviewer: "ProductOwner Agent (acting as BA proxy)"
document_reviewed: "learning_base/06_implementation/SOW_HTP-VIP_Phase1-Phase2_draft.md"
version_reviewed: "v0.2 Draft"
related_refs:
  - "learning_base/02_requirements/02_1_requirements_matrix_summary.md"
  - "docs/development_timeline_phases_1_2.md"
  - "learning_base/06_implementation/SOW0008433_VegApp_AWS_Migration_Enhancements.md"
  - "learning_base/06_implementation/SOW0008867_S2S_Application_Scope_Changes.md"
status: "REVIEW COMPLETE — Action Items Identified"
---

# Business Analyst Review — HTP-VIP Phase 1 & 2 Draft SoW

> **Reviewed Against**: Requirements Matrix v2 (98 requirements), Development Timeline v2.0, Reference SoWs (SOW0008433 + SOW0008867)
> **Review Scope**: Completeness, requirements alignment, structural compliance, resource adequacy, contractual risks

---

## Executive Finding

The draft SoW `SOW_HTP-VIP_Phase1-Phase2_draft.md` is **substantially complete** and correctly follows the Syngenta/Infosys contracting pattern (Exhibit 3A + Attachment A structure). It contains all mandatory sections identified from the reference SoWs.

**Overall Assessment: PASS with 8 Action Items**

---

## Section 1: Structure & Compliance with Syngenta Contracting Pattern

### Comparison vs. Reference SoWs (SOW0008433 + SOW0008867)

| Required Section | Present in Draft | Compliant |
|-----------------|-----------------|-----------|
| Exhibit 3A — Cover page with SOW number, parties, pricing, signatories | ✅ | ✅ |
| Attachment A — Executive Summary | ✅ | ✅ |
| Attachment A — Order of Precedence (MSA link) | ✅ | ✅ |
| Attachment A — Definitions (Backlog, DoR, DoD, Sprint, UAT, etc.) | ✅ | ✅ |
| Section 4 — Scope (In + Out), Deliverables, Acceptance Criteria | ✅ | ✅ |
| DACI Matrix | ✅ | ✅ |
| Data Privacy clause | ✅ | ✅ |
| Section 5 — Execution (Key Staff, Resource Profile, Onboarding) | ✅ | ✅ |
| Assumptions | ✅ | ✅ |
| Project Management (Status Reporting, Sprint Cadence, Change Management) | ✅ | ✅ |
| Governance / Escalation Tables | ✅ | ✅ |
| Pricing + Payment Schedule | ✅ (TBD amounts) | ⚠️ Amounts not yet set |
| Transparency section | ✅ | ✅ |
| Bill To / Ship To | ✅ | ⚠️ Billing entity needs confirmation |
| Terms & Conditions | ✅ | ✅ |
| Appendix 2 — AI Tools Declaration | ✅ | ✅ |
| Supplier Engagement Manager signatory | ✅ | ✅ |

### 🟡 Action Item 1: Section 4 Internal Ordering

**Issue**: Current Section 4 ordering is: 4.1 Acceptance Criteria → 4.2 Supplier Deliverables → 4.3 In Scope → 4.4 Out of Scope → 4.5 DACI → 4.6 Data Privacy

**Expected ordering** (per reference SoWs and logical flow): In Scope → Out of Scope → Deliverables → Acceptance Criteria → DACI → Data Privacy

**Recommended Fix**: Reorder sub-sections within Section 4:
- 4.1 In Scope *(move from current 4.3)*
- 4.2 Out of Scope *(move from current 4.4)*
- 4.3 Supplier Deliverables *(move from current 4.2)*
- 4.4 Acceptance Criteria *(move from current 4.1)*
- 4.5 DACI Matrix *(keep)*
- 4.6 Data Privacy *(keep)*

**Priority**: Low — structural only; does not affect contractual completeness

---

## Section 2: Requirements Coverage Alignment

### Phase 1 Must-Have Requirements (23 per Matrix)

| Requirement | Matrix ID | In Scope | In Deliverables | Notes |
|------------|---------|----------|-----------------|-------|
| SSO (SAML 2.0 / OAuth 2.0) | 1 | ✅ Phase 0-1 | Sprint 1 | |
| QR Code Detection (G1) | 7 | ✅ | D-P1-004 | |
| Holding Angle (G6) | 13 | ✅ | D-P1-004 | |
| Reverse Block (G9) | 16 | ✅ | D-P1-004 | |
| Plot Detection Feedback (G13) | 19 | ✅ | D-P1-004 | |
| Start/Stop Direction UX | 20 | ✅ | D-P1-004 | |
| Video Format Enforcement | 24 | ✅ | D-P1-004 (implicit) | |
| Offline Data Cache | 25 | ✅ | D-P1-005 | |
| Cloud Upload Service | 26 | ✅ | D-P1-006 | |
| Upload Progress Tracking | 28 | ✅ | D-P1-006 (implicit) | Add explicitly |
| Snowflake API Integration | 30 | ✅ | D-P1-005 (partial) | |
| CI/CD Pipeline | 74 | ✅ | D-P1-002 | |
| Mobile Framework | 79 | ✅ | 4.3 In Scope | Deferred to Sprint 0 decision (correct) |
| State Management | 81 | ✅ | Implicit in scaffold | |
| **Blurriness Detection G10** | 17 | ⚠️ | **Out of Scope** | Matrix says "Must Have (Phase 3)" — SoW correctly defers |
| **Direction Indicator G8** | 15 | ✅ | Appendix 3 (Should Have) | OK |

**All 23 Phase 1 Must-Have requirements are covered or correctly deferred.** ✅

### 🟡 Action Item 2: Camera Parameter Controls (ID 100) Missing from Phase 1 Deliverables

**Issue**: Requirements matrix includes Camera Parameter Controls (ISO/Temperature/Aperture, Should Have, Phase 1, ID 100) — mapped to Screen 7 (Settings). This is not explicitly listed in the Phase 1 scope table or delivery items.

**Recommendation**: Add to Phase 1 scope table as "Should Have — Camera Parameter Controls (ID 100)" and add to Phase 1 deliverables as part of D-P1-003 (Mobile App Scaffold) expanded scope or as a new item.

### 🟡 Action Item 3: Home Dashboard / Plot Tracking View Gap

**Issue**: The requirements matrix explicitly identifies two open gaps without requirement IDs:
- Home Dashboard (trial assignment list view) — no requirement ID
- Plot Tracking View — no explicit requirement ID

Both appear in the Figma screens. They'll be built in Phase 1, but if they're not in the requirements matrix, they're not billable scope items under standard contract management.

**Recommendation**: Create two new requirements in the requirements matrix before contract signature:
- REQ-NEW-001: Trial Assignment Home Dashboard (Phase 1, Must Have)
- REQ-NEW-002: Per-Plot Status Tracking View (Phase 1, Should Have)

Then add these to the SoW's Phase 1 In Scope table.

### ✅ Phase 2 Requirements — All Covered

| Requirement | Matrix ID | In Draft | Notes |
|------------|---------|----------|-------|
| Smart Trial/Stage Selection | 21 | ✅ D-P2-001 | |
| Snowflake Sync Scheduler | 31 | ✅ D-P2-003 | |
| Tomato Conveyor Protocol | 52 | ✅ D-P2-006 | |
| IaC | 75 | ✅ D-P2-004 | |
| Developer/API Documentation | 94 | ✅ D-P2-007 | |
| Operator Error Flagging | 23 | ⚠️ Not in Phase 2 deliverables | In 4.3 scope table (Sprint 9); needs its own deliverable ID |
| QR Label Printing (web app) | 55 | ✅ D-P2-002 | Matrix has Won't Have for in-app; web app version is acceptable |

### 🟡 Action Item 4: Operator Error Flagging (ID 23) Missing Deliverable

**Issue**: Operator Error Flagging (Phase 2, Could Have, ID 23) appears in the Phase 2A scope table (Sprint 9) but does not have a corresponding entry in the Phase 2 Supplier Deliverables table (D-P2-XXX).

**Recommendation**: Add D-P2-002a or relabel D-P2-002 to cover operator error flagging, or add it as a new deliverable D-P2-002b: _Operator Error Flagging — QA annotation workflow with 5 quality gates_.

### ⚠️ Pepper + Squash — Not in Requirements Matrix

**Issue**: Phase 2 deliverables include D-P2-005 (Pepper + Squash Protocols). However, the requirements matrix does not have explicit requirement IDs for Pepper and Squash crop protocols. Only Tomato Conveyor has an explicit ID (52).

**Recommended Action**: Confirm with Soumitra Khair whether Pepper/Squash protocols require new requirement IDs before including as formal deliverables. If Syngenta confirms, add:
- REQ-NEW-003: Pepper Crop Protocol (Phase 2, Should Have)
- REQ-NEW-004: Squash Crop Protocol (Phase 2, Should Have)

---

## Section 3: Resource Profile Adequacy

### Finding

5.5 FTE across 29 weeks is assessed as **adequate for the defined scope**, with one risk caveat.

| Phase | Weeks | Must + Should Deliverables | FTE Required | Assessment |
|-------|-------|---------------------------|-------------|------------|
| Phase 0 | 1–3 | Setup only | 2.5 FTE (TL + Cloud + SM) | ✅ OK |
| Phase 1 | 4–15 | 9 deliverables; 23 Must Have | 5.0 FTE | ✅ Adequate |
| Phase 2A | 16–21 | Smart Select, QR, Error Flagging | 5.0 FTE | ✅ Adequate |
| Phase 2B + Cross-cutting | 22–29 | Crop protocols, IaC, Docs, UAT | 5.0 FTE | ⚠️ **Tight** — IaC is parallel to crop work |

### 🔴 Action Item 5: Phase 2B Capacity Risk — IaC + Crops Parallel

**Issue**: Phase 2B (Sprints 10–13) requires simultaneous delivery of:
- Pepper + Squash + Tomato Conveyor crop protocols (mobile development)
- IaC full environment provisioning (cloud engineering)
- Developer documentation (TL/BA task)
- Phase 2 UAT and stabilization

The Cloud Engineer will own both IaC (Terraform/CDK) and may be pulled into UAT support at the same time. This is a real capacity risk.

**Recommendation**: 
1. Explicitly state "If IaC delivery risks Phase 2 UAT, a 0.5 FTE Cloud Engineer surge will be considered via CR"
2. Or plan IaC (D-P2-004) delivery in Sprint 12 specifically before UAT begins in Sprint 13

---

## Section 4: Pricing Model Risk

### 🔴 Action Item 6: T&M vs. Fixed Price Misalignment with Syngenta Contracting Pattern

**Issue**: The SoW draft recommends T&M for Phase 1 and milestone-based hybrid for Phase 2. However, **both reference SoWs** (SOW0008433: $112,500 and SOW0008867: $153,460) use **Fixed Price** with milestone-based billing. Syngenta/Procurement preference is clearly Fixed Price.

**Risk**: T&M for Phase 1 is a financial control risk for Syngenta (no cost cap until Sprint 0 scope is locked). Procurement is unlikely to approve an open-ended T&M for a 15-sprint engagement.

**Recommendation**: 
- Update Section 9.1 pricing preference to **Fixed Price (preferred), milestone-based payment schedule**
- Acceptable fallback: T&M for Sprint 0 only (framework decision period), converting to Fixed Price after Sprint 0 scope lock

### 🟡 Action Item 7: Billing Entity Confirmation

**Issue**: Section 11 (Bill To/Ship To) defaults to "Syngenta Crop Protection AG" — but HTP-VIP may fall under **Syngenta Seeds LLC** (US) or a different Syngenta legal entity depending on budget center.

**Recommendation**: Confirm with Andre Piza (Budget Owner) and Procurement whether:
- Entity: Syngenta Crop Protection AG, Basel OR Syngenta Seeds LLC OR other
- Budget code and SAP Cost Center to record on invoice
- VAT registration for applicable jurisdiction

---

## Section 5: Assumptions Completeness

The 14 assumptions in Section 6 are appropriate and largely match the Infosys SoW pattern.

### 🟡 Action Item 8: Add Figma Design Freeze Assumption

**Issue**: A critical dependency is that Figma designs are finalized and version-locked before Sprint 1. This is implicit in the onboarding checklist but not stated as a formal assumption.

**Recommendation**: Add explicit assumption:
> _"Figma designs are version-locked (agreed freeze) before Sprint 1 Day 1. No new screen additions after freeze without a change request. Minor UX updates may be incorporated if raised before Sprint Planning."_

This aligns with VoC-003 (SME feedback incorporated into designs before development begins).

---

## Section 6: DACI Matrix — Minor Gap

The DACI matrix is comprehensive. One minor gap:

| Activity | Current DACI | Issue |
|---------|-------------|-------|
| Figma Design Ownership | Not listed | Should be: Doer = Syngenta UX; Accountable = PO; Consulted = Supplier Tech Lead |
| QR Label Design (Phase 2) | Not listed | Should be: Doer = Supplier; Accountable = Supplier; Consulted = Syngenta Lab Ops |

These are minor but relevant for Phase 2 label printing UAT coordination.

---

## Summary: Action Items Register

| # | Priority | Item | Owner | Section Affected |
|---|----------|------|-------|-----------------|
| 1 | Low | Reorder Section 4 sub-sections (Scope → Deliverables → Acceptance) | PO | Section 4 structure |
| 2 | Medium | Add Camera Parameter Controls (ID 100) to Phase 1 scope and deliverables | PO + BA | 4.3, 4.2 |
| 3 | Medium | Create requirement IDs for Home Dashboard and Plot Tracking view | PO | Requirements Matrix + 4.3 |
| 4 | Medium | Add Operator Error Flagging as explicit Phase 2 deliverable (D-P2-002b) | PO + BA | 4.2 Phase 2 Deliverables |
| 5 | **High** | Flag Phase 2B IaC + Crops parallelism as capacity risk; add CR clause | PO | Section 6 Assumptions + Section 10.2 Risks |
| 6 | **High** | Change pricing model preference to Fixed Price (align with Syngenta contracting) | PO + Procurement | Section 9 Pricing |
| 7 | Medium | Confirm billing entity (Syngenta Crop Protection AG vs Seeds LLC) | PO + Andre Piza | Section 11 Bill To/Ship To |
| 8 | Medium | Add Figma design freeze as explicit assumption | PO | Section 6 Assumptions |

---

## Handoff to ProductOwner

BA review complete. Recommended next steps:

1. **Update draft SoW** with Action Items 1, 2, 4, 5, 6, 8 before sending to Procurement
2. **Confirm with Soumitra Khair**: Pepper + Squash requirement IDs (Action Item 3 extension)
3. **Confirm with Andre Piza**: Billing entity (Action Item 7)
4. **Requirements Matrix Update**: Create REQ-NEW-001 through REQ-NEW-004 before contract signature
5. **Trigger cascade review** if pricing model changes from T&M → Fixed Price (affects timeline and milestone gate documents)

---

*Review completed by: ProductOwner Agent (BA proxy role) — 2026-03-25*
*Status: COMPLETE — Awaiting PO action on 8 items above*
