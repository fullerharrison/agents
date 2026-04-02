---
artifact: phase-8-integration-test-matrix
task: 005-pm-agent-system
phase: 8
created: 2026-03-18
status: complete
checkpoint: CP-8.3
sources:
  - .tasks/005-pm-agent-system/artifacts/phase-5/phase-5-orchestration-routing-matrix.md
  - .tasks/005-pm-agent-system/artifacts/phase-6/phase-6-agent-permission-tier-table.md
  - .tasks/005-pm-agent-system/artifacts/phase-7/phase-7-workflow-contracts.md
  - .tasks/005-pm-agent-system/plan/phase-8-pilot-validation-integration-testing.md
---

# Phase 8 Artifact: Integration Test Matrix

## Purpose

This document provides the integration test matrices covering the four critical cross-cutting integration dimensions: agent handoffs, checkpoint gating, requirements cascade updates, and diagram lifecycle. Each matrix maps specific test inputs, expected behaviours, and binary pass/fail signals. This is a planning document; execution produces evidence artifacts E1–E7.

---

## 1. Handoff Verification Matrix

Agent handoffs are the primary integration surface. The following matrix defines the expected handoff pattern, the contract source, and the test verification method for every critical handoff in the PM agent system.

| Handoff ID | From Agent | To Agent | Workflow | Trigger Mechanism | Expected Handoff Behaviour | Contract Source | Verification Method |
| --- | --- | --- | --- | --- | --- | --- | --- |
| HO-01 | ProjectManager | ProductOwner | A — Resource Ingestion | Keyword: "Ingest" / "Add to learning_base" | PM delegates to PO via `[Ingest Resource →]` handoff button; PM does not process the resource itself | WFC-A; Phase 5 Workflow A routing | Observe PM conversation for handoff button pattern; verify PO receives delegation instruction |
| HO-02 | ProductOwner | Worker | A — Resource Ingestion | Binary input detected (.docx, .eml, .pdf) | PO explicitly delegates conversion task to Worker naming target path and conversion task | Phase 6 Worker Tier-F edge case; Phase 4 PO→Worker conversion contract | Worker receives explicit instruction naming target path; PO conversation shows delegation, not Bash execution |
| HO-03 | Worker | ProductOwner | A — Resource Ingestion | Conversion complete | Worker surfaces converted markdown to PO for metadata template application and authorship acceptance | Phase 6 authorship accountability rule | PO receives output; PO accepts or rejects before output is authoritative |
| HO-04 | ProductOwner | BusinessAnalyst | B — Stakeholder Feedback | Cascade trigger condition at CP-B3 | PO hands off to BA with VoC record and cascade scope; BA receives input and confirms scope | WFC-B, WFC-C; Phase 4 PO→BA handoff contract | BA conversation shows receipt of VoC + cascade scope; BA invokes requirements-cascade skill |
| HO-05 | ProductOwner | BusinessAnalyst | C — Requirements Cascade | Explicit cascade trigger from PO | PO provides change description and affected doc list; BA accepts cascade scope | WFC-C; Phase 4 PO→BA handoff | BA cascade analysis begins with confirmed scope statement; no BA action before scope confirmed |
| HO-06 | BusinessAnalyst | FrontendDev | C — Requirements Cascade | Technical feasibility review needed (CP-C3) | BA requests advisory from FrontendDev with read-only brief; FrontendDev advisory output stays in conversation | WFC-C; Phase 6 Tier-R constraints | FrontendDev advisory appears in conversation only; no file writes; BA remains sole requirements doc writer |
| HO-07 | BusinessAnalyst | BackendDev | C — Requirements Cascade | Technical feasibility review needed (CP-C3) | BA requests advisory from BackendDev; BackendDev advisory output stays in conversation | WFC-C; Phase 6 Tier-R constraints | BackendDev advisory appears in conversation only; no file writes |
| HO-08 | ProjectManager | UIUXDesigner | D — Diagram Lifecycle | Keyword: "Create diagram" / "Publish diagram" | PM delegates to UIUXDesigner via `[Publish Diagram →]` handoff; PM does not edit any diagram file | WFC-D; Phase 5 Workflow D routing | PM conversation shows handoff button; UIUXDesigner receives design brief |
| HO-09 | ProductOwner | ScrumMaster | E — Backlog Planning | Groomed backlog with MoSCoW priorities confirmed (CP-E1) | PO hands off MoSCoW-complete backlog to SM for sprint breakdown | WFC-E; Phase 4 PO→SM handoff contract | SM receives phase-aligned backlog; SM conversation shows backlog received with MoSCoW labels |
| HO-10 | ScrumMaster | BusinessAnalyst | E — Backlog Planning | Backlog item has unclear requirements (CP-E2 FAIL) | SM delegates unclear item to BA for requirement clarification before breakdown | WFC-E failure path; Phase 4 SM←→BA coordination | BA receives specific item for clarification; item deferred from sprint breakdown until BA confirms |
| HO-11 | QAEngineer | ProjectManager | F — Quality Gate | Test execution complete; result report ready | QA submits result report to PM; PM gates on pass/fail threshold (zero critical failures, ≥80% coverage) | WFC-F; Phase 5 CP-F3 gate decision | PM receives QA report with numeric values; PM applies threshold check before routing |
| HO-12 | ProjectManager | FrontendDev + BackendDev | F — Quality Gate (FAIL path) | QA reports critical test failure at CP-F3 | PM delegates diagnostic advisory to FrontendDev and BackendDev (advisory-only; no write access) | WFC-F FAIL escalation; Phase 6 Tier-R under escalation | Both advisors respond in conversation; PM does not skip advisory step; neither advisor writes a file |
| HO-13 | FrontendDev / BackendDev | BusinessAnalyst | F — Quality Gate (FAIL path) | Advisory root-cause complete (QG-F-03) | PM routes advisory findings to BA for revised plan; BA produces updated requirement or revised sprint plan | WFC-F FAIL escalation QG-F-04 | BA receives advisory notes as input; BA produces updated artifact at expected path |

### Handoff Pass/Fail Criteria

**PASS:** Handoff trigger is observed in agent conversation; receiving agent acknowledges scope and input; no agent acts before receiving a formal handoff; no write actions occur on handoffs that are advisory-only.

**FAIL:** Any of the following — sending agent performs work intended for the receiving agent; receiving agent acts on out-of-scope information; advisory handoff results in file write; handoff button pattern absent from PM delegation.

---

## 2. Checkpoint Gating Verification Matrix

This matrix maps each Phase 5 workflow checkpoint to its expected gating behaviour during integration testing.

| Gate ID | Workflow | Checkpoint ID | Precondition for Gate | Gate Action | Expected Outcome When Gate PASSES | Expected Outcome When Gate FAILS or Bypassed |
| --- | --- | --- | --- | --- | --- | --- |
| CG-01 | A — Resource Ingestion | CP-A1 | Resource submitted to PO | PO classifies resource; PM confirms category before template application | ProductOwner applies metadata template; resource moves to CP-A2 | PM pauses; user/PO prompted for classification; no template applied until confirmed |
| CG-02 | A — Resource Ingestion | CP-A2 | Metadata template applied | PM verifies all required metadata fields are populated | Resource advances to path validation (CP-A3) | PO reworks metadata header; CP-A2 re-evaluated |
| CG-03 | A — Resource Ingestion | CP-A3 | Target path identified | PM validates `learning_base/` subdirectory exists | Binary file routed to Worker for conversion (if needed); resource filed | PM pauses; user prompted for valid target directory; no file created outside `learning_base/` |
| CG-04 | B — Stakeholder Feedback | CP-B1 | Feedback submitted | PO confirms full feedback capture | PO maps feedback to guardrail catalog | PM requests additional detail from stakeholder; workflow paused |
| CG-05 | B — Stakeholder Feedback | CP-B2 | Guardrail mapping attempted | PO maps all feedback to guardrails; ambiguities trigger BA advisory | All guardrail mappings are complete (or explicitly deferred with BA input) | PO reworks mapping or BA clarifies; CP-B2 re-evaluated |
| CG-06 | B — Stakeholder Feedback | CP-B3 | Insights extracted | PO confirms actionable insights extracted; cascade trigger decision made | VoC record filed; Workflow C triggered if cascade needed, or success logged | PO reworks insight extraction |
| CG-07 | C — Requirements Cascade | CP-C1 | Cascade scope defined | BA confirms impacted docs identified | BA updates requirements documents | BA expands dependency search; no updates until confirmed |
| CG-08 | C — Requirements Cascade | CP-C2 | Requirements updated | BA confirms all impacted docs updated | FE/BE advisory requested if technical impact | BA reworks requirement update; scope creep escalated to PM |
| CG-09 | C — Requirements Cascade | CP-C3 | Secondary impact check | FE/BE advisory (if triggered) reviewed | Stakeholder approval checked or cascade completed | FE/BE advisory re-requested; architecture conflict escalated to PM |
| CG-10 | D — Diagram Lifecycle | CP-D1 | Design request received | UIUXDesigner confirms diagram design complete | Source file (.mmd or .drawio) saved to `images/diagrams/` | UIUXDesigner revises design; CP-D1 re-evaluated |
| CG-11 | D — Diagram Lifecycle | CP-D2 | Source file saved | UIUXDesigner confirms source at correct path | Render script invoked to produce PNG | UIUXDesigner re-saves source to correct path before rendering |
| CG-12 | D — Diagram Lifecycle | CP-D3 | Render attempted | Rendered PNG exists and is valid | Documentation link-back inserted | UIUXDesigner corrects source; render retried; unsupported format escalated to PM |
| CG-13 | D — Diagram Lifecycle | CP-D4 | Documentation link-back | Link injected into owning doc | `diagram_manifest.json` updated; PM notified of completion | UIUXDesigner adds missing link; manifest update retried |
| CG-14 | E — Backlog Planning | CP-E1 | Backlog submitted | PO confirms MoSCoW assignments complete | SM receives phase-aligned backlog for breakdown | PO reworks prioritisation; blocked items routed to BA |
| CG-15 | E — Backlog Planning | CP-E2 | Backlog phase-aligned | SM confirms breakdown and estimates complete | Dependencies resolved; sprint scope confirmed | SM reworks breakdown; undefined requirements routed to BA |
| CG-16 | E — Backlog Planning | CP-E3 | Sprint plan drafted | SM confirms sprint plan created with all items | Capacity check performed | SM reworks sprint plan; CP-E3 re-evaluated |
| CG-17 | E — Backlog Planning | CP-E4 | Capacity check | SM confirms capacity not exceeded | Sprint plan published at `planner_updates/` | PO re-prioritises or defers items; return to CP-E1 |
| CG-18 | F — Quality Gate | CP-F1 | Test suite submitted | QA confirms test execution complete | Results reviewed against acceptance criteria | QA logs execution blocker; PM notified; FE/BE invoked if technical |
| CG-19 | F — Quality Gate | CP-F2 | Results received | QA reviews all results against acceptance criteria | Pass/fail decision made | QA completes result review; criteria not testable → PO clarification |
| CG-20 | F — Quality Gate | CP-F3 | Pass/fail decision | QA classifies failures as blocker or non-blocker | PASS: CP-F4; FAIL-non-blocker: rework task; FAIL-blocker: PM escalation | PASS: planning update proceeds; FAIL: rework task issued |
| CG-21 | F — Quality Gate | CP-F4 | Acceptance criteria check | PM confirms all acceptance criteria met for sprint task | Sprint item marked "Done"; QA result record filed | PM reviews criteria; may trigger Workflow C for requirement revision |

### Checkpoint Gating Pass/Fail Criteria

**PASS:** Gate reached at the correct workflow step; decision options match the phase contract; downstream action triggered matches the gate resolution outcome.

**FAIL:** Gate bypassed without explicit resolution; downstream action triggered before gate resolved; wrong downstream path taken after gate resolution.

---

## 3. Requirements Cascade Integration Test

The requirements cascade workflow (Workflow C) is the most complex multi-agent coordination in the system. This table provides targeted integration test cases.

| Test ID | Test Name | Input State | Agent Sequence | Integration Point Tested | Pass Condition | Fail Condition |
| --- | --- | --- | --- | --- | --- | --- |
| RC-01 | PO-to-BA cascade handoff | PO submits requirement change with change description and affected doc list | PO → PM (gate CP-C1) → BA (impact analysis) | PO→BA handoff with scope statement; PM gate at CP-C1 | BA receives confirmed scope; no BA action before PM gate resolves; impacted docs identified | BA begins analysis before PM gate; PO edits requirements directly |
| RC-02 | BA impact analysis completeness | BA receives scope statement for cascade | BA (requirements-cascade skill) → CG-07 | BA cascade analysis skill; CP-C1 gate | All impacted docs identified; cascade impact report created with required fields | Any impacted doc missed; cascade impact report missing required fields |
| RC-03 | FrontendDev advisory in cascade | Technical impact detected; BA requests FE advisory | BA → FrontendDev (advisory) → BA | BA→FrontendDev advisory handoff; Tier-R read-only constraint under cascade | FrontendDev advisory in conversation only; BA uses advisory to update requirements; FrontendDev writes nothing | FrontendDev writes to any file during advisory step |
| RC-04 | BackendDev advisory in cascade | Technical impact detected; BA requests BE advisory | BA → BackendDev (advisory) → BA | BA→BackendDev advisory handoff; Tier-R read-only constraint under cascade | BackendDev advisory in conversation only; no file writes; BA remains sole doc writer | BackendDev writes to any file during advisory step |
| RC-05 | Cascade verify completeness | All impacted docs updated or explicitly deferred | BA (cascade verify step) → PM (CP-C4) | CP-C4 cascade verify gate; all dependent docs addressed | Cascade impact report confirms all docs updated or deferred with reason; PM notified of completion | Any impacted doc not addressed; CP-C4 resolves before cascade verify complete |
| RC-06 | Scope creep escalation | BA detects out-of-scope change during cascade analysis | BA → PM (escalation) | PM escalation path from BA on scope creep | PM receives scope-creep alert; PM presents rework/accept/escalate options; no cascade proceeds without resolution | BA proceeds with out-of-scope change without PM escalation |

---

## 4. Diagram Lifecycle Integration Test

The diagram lifecycle (Workflow D) requires all four steps to be executed in sequence. This table tests the integration of each step and the boundary enforcement for UIUXDesigner.

| Test ID | Test Name | Input | Step Under Test | Integration Point Tested | Pass Condition | Fail Condition |
| --- | --- | --- | --- | --- | --- | --- |
| DL-01 | Source file creation in correct path | New diagram brief (Mermaid) | Step 1: design + save `.mmd` | UIUXDesigner write boundary: `images/diagrams/` only | `.mmd` file created at `images/diagrams/NN_description.mmd`; naming convention followed | File created outside `images/diagrams/`; naming convention violated (missing `NN_` prefix) |
| DL-02 | Render script invocation | Valid `.mmd` source file | Step 2: render PNG via `render_mermaid_diagrams.ps1` | UIUXDesigner execute boundary: render script only | PNG rendered at `images/diagrams/NN_description.png`; render script was the execution tool; no general Bash | General Bash used; PNG not created; render attempted without Step 1 source file |
| DL-03 | Documentation link-back injection | Rendered PNG at expected path | Step 3: inject image reference into owning doc | UIUXDesigner write in `docs/`: image-ref insertion only | `![...]` reference inserted into owning document only; no other `docs/` content changed | UIUXDesigner creates a new `docs/` file; UIUXDesigner modifies non-image-reference content |
| DL-04 | Manifest update | All three previous steps complete | Step 4: update `diagram_manifest.json` | `diagram_manifest.json` write; all four lifecycle steps logged | Manifest entry updated with diagram_id, source_path, png_path, owning_doc, last_updated | Manifest not updated; PM not notified after manifest update |
| DL-05 | Lifecycle step sequencing enforcement | Out-of-order step attempt (render before save) | All four steps | Step sequencing gate: CP-D1 before CP-D2 before CP-D3 before CP-D4 | PM enforces step order; out-of-order action at any step causes PM to block progression | Any step executed out of sequence; manifest updated before documentation link-back inserted |
| DL-06 | Render failure recovery | Malformed `.mmd` source | Step 2: render fails | CP-D2 FAIL path: UIUXDesigner corrects source and retries | UIUXDesigner corrects Mermaid syntax in source file; render retried; new PNG produced | UIUXDesigner escalates without correcting source; render retried without source fix |
| DL-07 | Unsupported format escalation | `.visio` or other unsupported source format | Step 1: format check | PM escalation for unsupported format (not UIUXDesigner) | PM receives format-unsupported alert; PM routes to user for alternative source provision; UIUXDesigner does not attempt conversion | UIUXDesigner attempts to handle unsupported format without PM escalation |

---

## 5. Integration Failure Escalation Map

This table maps integration failure conditions to their required escalation paths.

| Failure Condition | Detected By | Immediate Escalation Target | Escalation Action | Resolution Required Before |
| --- | --- | --- | --- | --- |
| Binary conversion failure (Worker) | ProjectManager | User / ProductOwner | PM alerts user; requests alternative source provision | Workflow A can continue |
| Guardrail mapping unresolvable (BA input exhausted) | ProjectManager | Human reviewer | PM pauses; workflow B held | Human resolution received |
| Cascade scope creep detected | BusinessAnalyst → PM | Human reviewer | PM presents rework/accept/escalate options | PM decision received |
| Architecture conflict in cascade | FrontendDev or BackendDev advisory | ProjectManager | PM offers: rework requirements, accept constraint, escalate to human | Architecture decision received |
| QA test execution blocked (technical blocker) | ProjectManager | FrontendDev + BackendDev (advisory) | PM delegates diagnostic advisory; BA revises plan | BA revised plan accepted |
| QA persistent blocker across sprint | ProjectManager | Human reviewer | Sprint plan revised; human approves revised scope | Human sign-off received |
| Diagram render failure (all retries exhausted) | UIUXDesigner → PM | User | PM requests alternative source format from user | Valid source provided |
| Unsupported diagram format | ProjectManager | User | PM alerts; format conversion route identified | Format conversion complete |
| Sprint capacity exceeded | ScrumMaster → ProductOwner | ProductOwner | PO re-prioritises (defer Must-Have → Should-Have) or SM splits story | PO confirms revised scope |
| Permission boundary violation (any agent) | Audit review | Human reviewer | Hard stop; Hold decision automatically triggered | Root cause documented and remediated |
