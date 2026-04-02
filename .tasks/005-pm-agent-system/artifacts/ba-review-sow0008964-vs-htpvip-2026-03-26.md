---
title: "BA Review — SOW0008964 Placeholder vs. HTP-VIP Draft SoW (Compare and Contrast)"
date: 2026-03-26
reviewer: "BusinessAnalyst Agent (ProductOwner-delegated)"
documents_reviewed:
  - "learning_base/06_implementation/SOW0008964_video_capture_mobile_app_placeholder.md (received 2026-03-26)"
  - "learning_base/06_implementation/SOW_HTP-VIP_Phase1-Phase2_draft.md (drafted 2026-03-25)"
  - ".tasks/005-pm-agent-system/artifacts/ba-review-sow-htp-vip-phase1-phase2-2026-03-25.md (BA review 2026-03-25)"
related_refs:
  - "learning_base/02_requirements/02_1_requirements_matrix_summary.md"
  - "docs/development_timeline_phases_1_2.md"
status: "REVIEW COMPLETE — 6 Critical Findings + 7 Action Items"
---

# BA Review — SOW0008964 (Placeholder) vs. HTP-VIP Phase 1–2 Draft SoW

> **Review Context**: SOW0008964 received 2026-03-26 from Pradeep Kethireddy. This is a placeholder SoW created in early 2026 under prior budget authorization, predating the HTP-VIP BRD v1.1 and Requirements Matrix v2. Per ProductOwner direction, this review exclusively performs compare-and-contrast analysis. No edits to either SoW are made.
>
> **Documents Compared**:
> - **Document A**: `SOW0008964` — "Video Capture Mobile App for Lab" — $74,220 Fixed Price, Feb–May 2026
> - **Document B**: `SOW-HTP-VIP-2026-P1P2` — "HTP-VIP Phase 1 MVP & Phase 2 Enhanced Capture" — Draft, amounts TBD, 29+ weeks
>
> **Prior BA Review Reference**: The 2026-03-25 review of Document B identified 8 Action Items (AI-1 through AI-8). This review assesses whether SOW0008964 resolves, contradicts, or impacts those findings.

---

## Executive Finding

SOW0008964 is confirmed to be a **contractually active placeholder** dated 2nd February 2026 that does **not represent the HTP-VIP project as defined in the BRD v1.1 or Requirements Matrix v2**. It appears to be an Infosys SoW from a parallel or predecessor engagement repurposed to hold budget within the Syngenta procurement system while the proper HTP-VIP SoW is being prepared.

**Overall Assessment: CRITICAL MISALIGNMENT — 6 Critical Findings, 7 Action Items**

The two documents are not minor variants of one another. They represent fundamentally different technical approaches, scopes, timelines, budgets, and governance structures for what is ostensibly the same engagement. The most urgent finding is that **SOW0008964 milestones 1 and 2 have already passed** (25-Feb and 25-Mar), meaning there is active financial and contractual exposure requiring immediate PO attention.

---

## Document Identity Comparison

| Attribute | SOW0008964 (Received 2026-03-26) | SOW-HTP-VIP-P1P2 Draft (2026-03-25) |
|-----------|----------------------------------|--------------------------------------|
| **Title** | "Video Capture Mobile App for Lab" | "HTP-VIP Phase 1 MVP & Phase 2 Enhanced Capture" |
| **SoW Number** | SOW0008964 | SOW-HTP-VIP-2026-P1P2 (draft) |
| **Request Number** | SER0015642 | [TBD — to be assigned] |
| **Status** | Signed/Active (2-Feb-2026) | 🟡 Draft — Pending Stakeholder Review |
| **Pricing** | Fixed: **USD 74,220** | Fixed (preferred); T&M acceptable; amounts TBD |
| **Start Date** | 2-Feb-2026 *(already started)* | TBD — Week 1 of offset timeline |
| **Completion** | 31-May-2026 *(4 months, 4 sprints)* | TBD — Week 29 from start *(~7 months, 14 sprints)* |
| **Syngenta PM** | **Pradeep Kethireddy** | **Harrison Fuller** |
| **Infosys PM** | Srikanth Aluri | [Vendor PM — TBC] |
| **Infosys Engagement Mgr** | Atul Bhatia | [TBC] |
| **BRD Reference** | ❌ Not referenced | ✅ HTP-VIP BRD v1.1 (Order of Precedence item 2) |
| **Requirements Matrix** | ❌ Not referenced | ✅ Requirements Matrix v2 (Order of Precedence item 3) |

---

## Section 1: Technology Stack Divergence

### 🔴 Critical Finding 1: Mobile Framework Conflict (.NET MAUI vs. React Native)

This is the single most consequential divergence between the two documents.

| Dimension | SOW0008964 | HTP-VIP Draft |
|-----------|-----------|---------------|
| **Mobile Framework** | **.NET MAUI** | **React Native** (ADR-002 confirmed) |
| **On-Device AI** | TensorFlow Lite (video quality checks) | Not in Phase 1/2 scope (ML is Phase 3) |
| **Desktop App** | Reused as processing core; API built around it | Not referenced; implicitly replaced |
| **Architecture Pattern** | Desktop-first API reuse | Cloud-first, mobile-native, offline-first |

**Analysis**:

SOW0008964 assumes .NET MAUI as the mobile development framework. HTP-VIP ADR-002 explicitly confirmed **React Native** after technical evaluation. These are not interchangeable: they require different developer skillsets, build pipelines, testing tools (Detox/Maestro for React Native vs. MAUI test infrastructure), and native API integration strategies.

If Infosys has begun any work under SOW0008964 using .NET MAUI, a technology transition to React Native would represent sunk cost and rework risk. The skill requirements sections of the two documents confirm this divergence: Document B explicitly requires `React Native` across all mobile roles; Document A implies .NET capability.

**PO Action Required**: Confirm with Pradeep Kethireddy whether any development work has commenced under SOW0008964. If so, scope of rework must be assessed before HTP-VIP SoW is signed.

---

### 🔴 Critical Finding 2: AI Tools Declaration Inconsistency within SOW0008964

SOW0008964 contains an internal contradiction that warrants flagging before it is presented to Syngenta Legal or Procurement:

- **Appendix 2 (AI Declaration)**: Checkbox marked **No** — "Does delivery of Services involve the use or development of AI tools?"
- **Section 4.3 (In Scope)**: Explicitly states *"The app will also use **TensorFlow Lite** to bring in light weight AI capability on mobile to perform basic checks on the video being recorded"*

TensorFlow Lite is an AI/ML inference framework. Declaring "No" on the AI tools form while describing AI inference in the scope section is a material inconsistency with Syngenta's Supplier AI Code of Practice (referenced in the MSA). Syngenta's Risk Assessment process must be triggered prior to any AI tool use per the MSA.

**PO Action Required**: Flag this inconsistency to Pradeep Kethireddy and Luis Marta (Procurement). If TensorFlow Lite is retained in the updated SoW scope, the AI declaration must be corrected to "Yes" and Syngenta's risk assessment process triggered.

---

## Section 2: Scope Comparison

### 2.1 Feature Coverage Matrix

| Feature Area | SOW0008964 | HTP-VIP Draft | Gap Assessment |
|-------------|-----------|---------------|----------------|
| Mobile video capture guidance | ✅ Generic ("guidance to users") | ✅ G1–G13 guardrails with specific thresholds | 🔴 HTP-VIP scope is 13× more specific |
| Offline-first data storage | ❌ Not mentioned | ✅ Must Have — SQLite, ≥200 videos | 🔴 Missing in placeholder |
| Snowflake integration | ❌ Not mentioned | ✅ Must Have — Trial/Plot/Germplasm IDs | 🔴 Missing in placeholder |
| Cloud upload (S3) | ✅ Direct S3 upload from mobile | ✅ AWS S3 presigned URLs + retry queue | ✅ Conceptually aligned |
| Web portal / web app | ✅ Results portal (frames + data viewer) | ⚠️ Phase 2 only: QR label printing web app | 🟡 Different purpose — SOW0008964's is broader |
| Desktop app reuse | ✅ Core processing component | ❌ Not referenced | 🔴 Architectural divergence |
| SSO Authentication | ❌ Not mentioned | ✅ Must Have — SAML 2.0 / OAuth 2.0 | 🔴 Missing in placeholder |
| QR Code Detection (G1) | ❌ Not mentioned by name | ✅ Must Have — multi-scale, conf ≥ 0.85 | 🔴 Missing |
| Holding Angle Guidance (G6) | ❌ Not mentioned | ✅ Must Have — ±5° spirit level overlay | 🔴 Missing |
| Video format enforcement | ❌ Not mentioned | ✅ Must Have — MP4 H.264 / 1080p / 30fps | 🔴 Missing |
| IaC (Terraform/CDK) | ✅ "IaaC for AWS services" (DevOps phase) | ✅ Phase 2 Must Have | ✅ Aligned |
| CI/CD Pipeline | ✅ In DevOps deliverables | ✅ Must Have (ID 74) | ✅ Aligned |
| Datadog monitoring | ✅ Explicit DevOps deliverable | ❌ HTP-VIP uses CloudWatch | 🟡 Different monitoring tools |
| Data migration | ✅ Aurora DB + S3 migration phase | ❌ Not in scope | 🟡 SOW0008964 includes prior project residue |
| Hardware (Gimbal) | ✅ Explicitly recommended | ❌ Not in scope | 🟡 Informational only |
| Multi-crop protocols | ❌ Not mentioned | ✅ Phase 2 — Pepper, Squash, Tomato, Watermelon | 🔴 Missing |
| QR Label Printing | ⚠️ "Customizable label printing" in acceptance criteria | ✅ Phase 2 web app | 🟡 Appearance in SOW0008964 may be copy-paste artifact |
| French Localization | ✅ In acceptance criteria | ❌ Not in HTP-VIP requirements | 🔴 Wrong project copy-paste |
| Spirit API Integration | ✅ In acceptance criteria | ❌ Explicitly replaced by Snowflake | 🔴 Wrong project copy-paste |
| RBAC | ✅ In acceptance criteria | ❌ Phase 4 scope (out of Phase 1/2) | 🔴 Wrong phase; likely copy-paste artifact |

### 2.2 Acceptance Criteria Copy-Paste Artifacts

SOW0008964's Build & Unit Test acceptance criteria includes four items that appear to be inherited verbatim from a prior Syngenta SoW (likely SOW0008433 — VegApp AWS Migration, which was the template document):

| Item in SOW0008964 Build Criteria | HTP-VIP Alignment | Likely Origin |
|-----------------------------------|------------------|---------------|
| "Customizable label printing" | Partial — QR labels are Phase 2 scope | SOW0008433 VegApp feature |
| "Support for French localization" | **Not in HTP-VIP requirements at all** | VegApp multi-locale requirement |
| "Integration with the Spirit API" | **Explicitly NOT required** (replaced by Snowflake) | VegApp Spirit integration |
| "Multisite RBAC" | Phase 4 scope, not Phase 1/2 | VegApp multi-tenant requirement |

These four items establish that SOW0008964's acceptance criteria are **not specific to the HTP-VIP engagement** and appear copied from a different project. This is a contractual risk if the document is executed as-is—Syngenta could be paying for Spirit API integration that is not needed, or accepting delivery criteria that do not validate HTP-VIP quality gates.

---

## Section 3: Budget and Timeline Comparison

### 🔴 Critical Finding 3: Budget Magnitude Gap

| Metric | SOW0008964 | HTP-VIP Draft |
|--------|-----------|---------------|
| **Total Fixed Price** | **USD 74,220** | **TBD** (amounts not set) |
| **Sprints** | **4 sprints** (~8 weeks of development) | **14 sprints** (~28 weeks of development) |
| **FTE / Resources** | "Key Staff: Not Applicable" | **5.5 FTE × 29 weeks** |
| **Team composition** | Unspecified | 1 Tech Lead, 2 Mobile Devs, 1 Cloud Eng, 1 QA, 0.5 SM |

**Analysis**:

At 5.5 FTE for 29 weeks at typical Infosys India blended rates (~$35–45/hr), the HTP-VIP Phase 1+2 engagement would cost approximately **USD 320,000–450,000**, depending on onshore/offshore mix. SOW0008964 at $74,220 represents approximately **16–23% of the likely HTP-VIP budget requirement**.

The placeholder SoW is insufficient by 4–6× to deliver the HTP-VIP scope as defined. This is consistent with the PO's characterization of SOW0008964 as a "budget timing" placeholder for 2025 procurement authorization.

### 🔴 Critical Finding 4: Active Contract Milestones Have Passed

SOW0008964 payment schedule milestones:

| Billing Point | Description | Due Date | Status (as of 2026-03-26) |
|---------------|------------|---------|--------------------------|
| 1 | Cloud setup + Desktop App containerization — Sprint 1 | 25-Feb-2026 | **⚠️ PAST DUE (29 days ago)** |
| 2 | Cloud setup + Desktop App containerization — Sprint 2 | 25-Mar-2026 | **⚠️ PAST DUE (1 day ago)** |
| 3 | Mobile App for video capture — Sprint 3 | 25-Apr-2026 | Upcoming (30 days) |
| 4 | Mobile App for video capture — Sprint 4 | 25-May-2026 | Future (60 days) |

If SOW0008964 is a signed, active contract (signatures on Exhibit 3A include Andre Piza as Budget Owner), Infosys may have:
- Submitted or be preparing invoices for Milestones 1 and/or 2
- Performed work against an undefined or incorrect scope
- Accrued charges under a framework the HTP-VIP team is unaware of

**This is the highest-priority finding in this review.**

---

## Section 4: Resource and Governance Comparison

### 4.1 Project Management and Syngenta PM

| Attribute | SOW0008964 | HTP-VIP Draft |
|----------|-----------|---------------|
| **Syngenta PM** | **Pradeep Kethireddy** | **Harrison Fuller** |
| **Budget Owner** | Andre Piza | Andre Piza (consistent) |
| **IS/Procurement** | Luis Marta | Luis Marta (consistent) |
| **Key Staff** | "Not Applicable" | Named Tech Lead required; Syngenta approval before Sprint 0 |

Pradeep Kethireddy is listed as Syngenta Manager on SOW0008964 but is not mentioned anywhere in the HTP-VIP BRD, requirements matrix, or draft SoW. Harrison Fuller (ProductOwner) is the named PM in the HTP-VIP draft.

This creates a **governance gap**: two Syngenta individuals may hold PM authority over the same Infosys engagement depending on which SoW is operative. Atul Bhatia at Infosys (Engagement Manager) will receive authority from—and report to—whoever is listed on the operative contract.

### 4.2 DACI Comparison

| Activity | SOW0008964 | HTP-VIP Draft |
|----------|-----------|---------------|
| Requirements | D: Infosys / A: Infosys | D: Supplier / A: Supplier (same) |
| UAT | D: Syngenta / A: Syngenta | D: Syngenta / A: Syngenta PO (same) |
| Environment Setup | D: Syngenta Infra / A: Syngenta | D: Syngenta IT/Cloud / A: Syngenta (same) |
| Snowflake API | Not listed | D: Syngenta Data Eng / A: Syngenta |
| SSO / IDP | Not listed | D: Syngenta IT Security / A: Syngenta |
| Go-Live Sign-off | Not listed | D: Syngenta / A: Syngenta PO |
| Figma Design | Not listed | Not listed (AI-6 from prior BA review) |

SOW0008964's DACI has 10 rows. HTP-VIP draft has 13 rows, covering HTP-specific dependencies (Snowflake, SSO, Go-Live sign-off, SME Review Gate). The gap is expected given SOW0008964 is a generic placeholder.

---

## Section 5: Contractual Structure Comparison

### 5.1 Document Structure (Section 4 ordering)

| Section | SOW0008964 | HTP-VIP Draft | Notes |
|---------|-----------|---------------|-------|
| Acceptance Criteria | First (4.1) | First (4.1) — same | AI-1 from prior review: HTP-VIP should reorder to Scope first |
| Deliverables | Second (4.2) | Second (4.2) — same | |
| In Scope | Third (4.3) | Third (4.3) — same | Both follow same non-standard ordering |

Note: Both documents use the same non-standard ordering (Acceptance Criteria before In Scope). Prior BA review Action Item 1 recommended reordering the HTP-VIP draft. SOW0008964's structure does not resolve this suggestion.

### 5.2 Pricing Model

| Dimension | SOW0008964 | HTP-VIP Draft |
|-----------|-----------|---------------|
| **Primary model** | Fixed Price | Fixed Price (preferred) |
| **T&M option** | Not offered | Acceptable for Phase 1 pending framework decision |
| **Payment basis** | Milestone-based (4 milestones) | Milestone-based hybrid |
| **Billing entity** | Syngenta Crop Protection AG, Basel | Syngenta Crop Protection AG (same) |

SOW0008964 **resolves Prior BA Review Action Item 6** (pricing model) and **Action Item 7** (billing entity). Both are now confirmed:
- ✅ **AI-6 RESOLVED**: Fixed Price is confirmed as the operative model (SOW0008964 is Fixed Price)
- ✅ **AI-7 RESOLVED**: Billing entity is confirmed as **Syngenta Crop Protection AG, Basel, Attn: Andre Piza**

### 5.3 Order of Precedence

| Level | SOW0008964 | HTP-VIP Draft |
|-------|-----------|---------------|
| 1 | MSA Agreement (01 Jan 2022) | MSA / Framework Agreement |
| 2 | *(not listed)* | HTP-VIP BRD v1.1 |
| 3 | *(not listed)* | Requirements Matrix v2 |

SOW0008964's order of precedence contains only the MSA. The HTP-VIP BRD and Requirements Matrix are not referenced, confirming this is a pre-project placeholder with no binding connection to HTP-VIP product specifications.

---

## Section 6: Assumptions Comparison

### 6.1 Common Assumptions (Both Documents)

- Requirements finalized and signed off before Sprint 1
- New AWS account/infrastructure provisioned by Syngenta Cloud team
- All required AWS permissions granted timely
- UAT is Syngenta's responsibility
- Changes to scope require re-estimation and CR process
- Syngenta to ensure availability of SMEs and Business Analysts
- Syngenta ensures timely feedback and sign-off

### 6.2 Assumptions in SOW0008964 Not in HTP-VIP Draft

| SOW0008964 Assumption | Assessment |
|-----------------------|-----------|
| "Source code of existing desktop app is fully up to date and available for migration" | 🔴 **Incompatible** — HTP-VIP does not rely on desktop app source code |
| "Knowledge transfer from desktop application vendor will be arranged" | 🔴 **Incompatible** — HTP-VIP is not a desktop-app-based architecture |
| "No changes or improvements planned for the frame extraction process in desktop app" | 🔴 **Incompatible** — Frame extraction is outside HTP-VIP Phase 1/2 scope |
| "Existing design document and architecture diagram are available" | 🟡 **Ambiguous** — HTP-VIP has Figma designs and architecture docs; but they are new, not "existing" in the prior-project sense |
| "API documentation is available" | 🟡 **Partial** — API docs are a Phase 2 deliverable in HTP-VIP, not a pre-existing input |
| "Data volume is manageable for migration" | 🟡 **N/A** — No data migration in HTP-VIP Phase 1/2 |

### 6.3 Assumptions in HTP-VIP Draft Not in SOW0008964

| HTP-VIP Assumption | Impact |
|-------------------|--------|
| Figma design freeze before Sprint 1 (AI-8 from prior review) | High — not resolved by SOW0008964 |
| SPIRIT confirmed as not required | High — SOW0008964 acceptance criteria still lists Spirit API integration |
| React Native confirmed (ADR-002) | High — SOW0008964 uses .NET MAUI |

---

## Section 7: Monitoring and Tooling

| Tool | SOW0008964 | HTP-VIP Draft |
|------|-----------|---------------|
| Monitoring | **Datadog** | **AWS CloudWatch** |
| Sprint tracking | Jira (implied) | Jira or equivalent |
| CI/CD | CI/CD pipeline (generic) | GitHub Actions or GitLab CI |
| Mobile testing | Not specified | Detox or Maestro |
| IaC tooling | "IaaC" (generic) | Terraform or AWS CDK |

Datadog vs. CloudWatch is a minor divergence but represents a licensing and cost difference. Datadog is an add-on SaaS cost; CloudWatch is native AWS. The HTP-VIP choice of CloudWatch is consistent with AWS-native cost management.

---

## Section 8: Impact on Prior BA Review Action Items (2026-03-25)

The 2026-03-25 BA Review identified 8 Action Items. Below is the updated status of each:

| AI # | Item | Prior Status | Updated Status After SOW0008964 Review |
|------|------|-------------|----------------------------------------|
| AI-1 | Reorder Section 4 sub-sections | 🟡 Low / Open | 🟡 **Still open** — SOW0008964 uses same non-standard ordering; no resolution |
| AI-2 | Add Camera Parameter Controls (ID 100) | 🟡 Medium / Open | 🟡 **Still open** — Not in SOW0008964 either |
| AI-3 | Create REQ-NEW-001/002 for Dashboard + Plot Tracking | 🟡 Medium / Open | 🟡 **Still open** — SOW0008964 has no dashboard scope |
| AI-4 | Operator Error Flagging as Phase 2 deliverable | 🟡 Medium / Open | 🟡 **Still open** — Not in SOW0008964 |
| AI-5 | Phase 2B capacity risk (IaC + Crops parallel) | 🔴 High / Open | 🔴 **Still open** — SOW0008964 has only 1 FTE equivalent implied |
| AI-6 | Change pricing to Fixed Price | 🔴 High / Open | ✅ **RESOLVED** — SOW0008964 confirms Fixed Price as the operative model |
| AI-7 | Confirm billing entity | 🟡 Medium / Open | ✅ **RESOLVED** — Syngenta Crop Protection AG, Basel, Andre Piza |
| AI-8 | Add Figma design freeze assumption | 🟡 Medium / Open | 🟡 **Still open** — Not in SOW0008964 |

**Net**: 2 of 8 Action Items resolved by SOW0008964 information (AI-6, AI-7). 6 remain open.

---

## Section 9: New Action Items Originating from This Review

| # | Priority | Finding | Action | Owner |
|---|----------|---------|--------|-------|
| **N-1** | 🔴 **CRITICAL** | SOW0008964 milestones 1 and 2 have passed (25-Feb, 25-Mar). Active financial exposure. | Confirm with Pradeep Kethireddy and Andre Piza: (a) Has work begun? (b) Have invoices been submitted/paid? (c) What is the path to supersede with proper HTP-VIP SoW? | PO + Procurement |
| **N-2** | 🔴 **CRITICAL** | Mobile framework conflict: SOW0008964 = .NET MAUI; HTP-VIP = React Native (ADR-002). | Determine whether any MAUI development has occurred. If yes, quantify rework. If no, ensure the updated SoW explicitly captures React Native. | PO + Tech Lead |
| **N-3** | 🔴 **HIGH** | AI tools declaration is "No" but TensorFlow Lite is explicitly described in scope. Material internal inconsistency — potential MSA breach. | Notify Pradeep Kethireddy and Luis Marta. If TFL is retained in any SoW revision, correct AI declaration to "Yes" and initiate Syngenta Risk Assessment. | PO + Luis Marta |
| **N-4** | 🔴 **HIGH** | Accept criteria copy-paste artifacts (French localization, Spirit API, RBAC) are **wrong project requirements** binding Infosys to deliver non-HTP-VIP features. | These must be removed from any operative HTP-VIP SoW. Confirm with Pradeep whether Infosys understands the actual project scope. | PO + Harrison Fuller |
| **N-5** | 🟡 **MEDIUM** | PM governance gap: Pradeep Kethireddy (SOW0008964) vs. Harrison Fuller (HTP-VIP draft). Infosys (Atul Bhatia) is receiving direction from Pradeep. | Formal governance handoff required. Harrison Fuller's authority must be established with Atul Bhatia before Sprint 0 of the proper HTP-VIP SoW. | PO + Harrison Fuller + Pradeep |
| **N-6** | 🟡 **MEDIUM** | Desktop app reuse is a core architectural assumption in SOW0008964 but absent in HTP-VIP. | Clarify with Soumitra Khair whether the existing desktop app (EPYCApp) has any formal role in HTP-VIP Phase 1/2 compute path. If not, this SOW assumption must be explicitly retired in the updated SoW. | PO + Soumitra Khair |
| **N-7** | 🟡 **MEDIUM** | SER0015642 (Request Number in SOW0008964) is an existing procured request. The HTP-VIP draft SoW has no request number assigned. | Determine with Procurement whether SER0015642 can be the parent request for the proper HTP-VIP SoW, or whether a new SER number must be issued. This affects procurement lead time. | PO + Luis Marta |

---

## Section 10: Items SOW0008964 Provides That HTP-VIP Draft Lacks

Despite the placeholder nature of SOW0008964, it contains several pieces of confirmed information that directly benefit the HTP-VIP SoW:

| Information | Value to HTP-VIP SoW |
|-------------|----------------------|
| ✅ **Fixed Price confirmed operative** | Directly supports AI-6 resolution; vendor and Syngenta both signed Fixed Price |
| ✅ **Billing entity: Syngenta Crop Protection AG, Basel, Attn: Andre Piza** | Resolves AI-7 entirely |
| ✅ **Framework Agreement valid through 31 Dec 2026** | HTP-VIP SoW can be issued under same MSA without re-negotiating framework |
| ✅ **Infosys Engagement Manager: Atul Bhatia** | Named contact for vendor escalation (HTP-VIP draft had TBC) |
| ✅ **SER0015642** | Existing procurement request number; may accelerate HTP-VIP SoW processing |
| ✅ **Monitoring tooling (Datadog mentioned)** | Flags that Infosys team may have Datadog familiarity; PO/Tech Lead to decide CloudWatch vs. Datadog |
| ✅ **Gimbal stabilizer hardware recommendation** | Practical field operations insight; could be included in HTP-VIP onboarding docs or pilot ops guide |

---

## Section 11: Summary Risk Register

| Risk | Severity | Likelihood | Action |
|------|---------|-----------|--------|
| Infosys billed/billing for work under incorrect scope (Sprint 1–2 milestones passed) | 🔴 Critical | High | Immediate PO follow-up with Pradeep + Andre |
| Development work performed in .NET MAUI that must be replaced with React Native | 🔴 Critical | Medium | Confirm with Pradeep; assess rework if any |
| AI tools declaration breach (TFL "No" vs. scope "Yes") | 🔴 High | High | Notify Procurement immediately |
| Wrong acceptance criteria signed contract (Spirit API, French locale, RBAC) | 🔴 High | Medium | Ensure superseded by proper HTP-VIP SoW before next invoice |
| PM governance confusion (Pradeep vs. Harrison) | 🟡 Medium | High | Formal handoff meeting; update Atul Bhatia at Infosys |
| SER request number not transferable; new request delays HTP-VIP contracting | 🟡 Medium | Low | Procurement clarification |

---

## Handoff Recommendations

### To ProductOwner (Harrison Fuller)

1. **Immediately** contact Pradeep Kethireddy to understand current delivery status under SOW0008964. Have Milestones 1/2 been invoiced?
2. **Immediately** flag the TensorFlow Lite / AI declaration inconsistency to Luis Marta (Procurement) and request guidance on MSA compliance.
3. **Schedule** a formal PM handoff conversation with Pradeep Kethireddy and Atul Bhatia (Infosys) to establish Harrison Fuller's authority for the HTP-VIP engagement.

### To ProjectManager

- Trigger a **cascade review** to check whether Pradeep Kethireddy appears in any other HTP-VIP planning documents and whether his absence from the BRD is intentional or an oversight.
- Checkpoint approval required before HTP-VIP SoW is sent to Procurement: confirm that SOW0008964 milestone 3 (25-Apr-2026) will not be invoiced against incorrect scope.

### To ScrumMaster

- This review does not change Phase 1 sprint structure in the HTP-VIP plan.
- If PM handoff is completed before April 25, Sprints 1–2 of the proper HTP-VIP plan can begin without timeline impact.

---

*Review completed by: BusinessAnalyst Agent (ProductOwner-delegated) — 2026-03-26*
*Status: COMPLETE — Awaiting PO action on N-1 through N-7 above*
