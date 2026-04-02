---
document: phase-7-workflow-contracts
version: 1.0
phase: 7
date_created: 2026-03-18
artifact: phase-7-workflow-contracts
task: 005-pm-agent-system
workflows_covered: [A, B, C, D, E, F]
status: complete
sources:
  - .tasks/005-pm-agent-system/artifacts/phase-5/phase-5-orchestration-routing-matrix.md
  - .tasks/005-pm-agent-system/artifacts/phase-5/phase-5-comprehensive-checkpoint-table.md
  - .tasks/005-pm-agent-system/artifacts/phase-2/phase-2-skill-contracts.md
  - .tasks/005-pm-agent-system/artifacts/phase-4/phase-4-handoff-contracts-matrix.md
---

# Phase 7 Artifact: Workflow Contracts

## Purpose

This document defines six end-to-end workflow handoff contracts for the 2026_01_VIP PM agent system. Each contract is self-contained and specifies the triggering role, receiving agent, input/output schemas, Phase 5 checkpoint cross-references, success criteria, and failure/escalation paths. Contracts reference but do not redefine Phase 5 checkpoint logic.

> **Naming note:** All Phase 5 workflow checkpoint IDs use the `CP-A*/CP-F*` format. The `CP-5.x` identifiers are Phase 5 *plan-governance* checkpoints only and must not appear in workflow contract cross-reference fields.

---

## Workflow A: Resource Ingestion

| Field | Value |
|-------|-------|
| Contract ID | WFC-A |
| Triggering Role(s) | User, ProductOwner |
| Trigger Phrase(s) | "Ingest this document", "Add to learning_base", "Process resource", "Ingest this email", "Classify and save this material", "Log this reference document" |
| Receiving/Owning Agent | ProductOwner |
| Secondary Agents | Worker (binary conversion, conditional) |
| Phase 5 Checkpoint Cross-references | CP-A1, CP-A2, CP-A3 |
| Handoff Button Label | `[Ingest Resource →]` |

### Input Schema

| Input Type | Format | Required Metadata Fields | Pre-processing |
|------------|--------|--------------------------|----------------|
| Email | `.eml` or plain text | subject, sender, date, source | Worker: convert to markdown |
| Document | `.docx`, `.pdf` | title, author, date, source | Worker: convert to markdown |
| Web link | URL string | url, accessed_date, title | ProductOwner: fetch and render |
| Meeting notes | `.md` or plain text | meeting_date, attendees, source | None |
| Chat extract | Plain text | source_platform, date, participants | None |
| Raw resource | `.md` | title, date, source | None if already markdown |

### Processing Expectation

ProductOwner invokes the `resource-ingestion` skill to classify the inbound resource into the appropriate `learning_base/` subdirectory category, apply the canonical metadata header template, validate the target path, and confirm the artifact is ready for filing. When the input is a binary format (`.docx`, `.eml`, `.pdf`), Worker performs conversion to markdown before ProductOwner applies the metadata template.

### Output Schema

| Output Type | Format | Required Metadata Fields | Output Path Template |
|-------------|--------|--------------------------|----------------------|
| Ingestion record | Markdown (`.md`) | title, date, source, classification, tags, ingested_by | `learning_base/{classification-subdir}/{YYYY-MM-DD}_{slug}.md` |

### Success Criteria

1. Ingestion record file exists at the confirmed `learning_base/` path with all required metadata fields populated.
2. CP-A1 passed: resource classified with a valid `learning_base/` subdirectory target.
3. CP-A2 passed: metadata template applied with no missing required fields.
4. CP-A3 passed: target path validated as an existing `learning_base/` subdirectory.

### Failure / Escalation Path

- **Ambiguous classification (CP-A1 FAIL):** ProjectManager pauses workflow; prompts user/ProductOwner to select classification category. Workflow resumes after confirmation.
- **Template application error (CP-A2 FAIL):** ProductOwner reworks metadata header; CP-A2 re-evaluated.
- **Invalid path (CP-A3 FAIL):** ProjectManager pauses; prompts user for target directory. No file created outside `learning_base/`.
- **Binary conversion failure:** Worker logs conversion error; ProjectManager escalates to user for alternative source provision.

---

## Workflow B: Stakeholder Feedback

| Field | Value |
|-------|-------|
| Contract ID | WFC-B |
| Triggering Role(s) | ProductOwner, Stakeholder |
| Trigger Phrase(s) | "Process feedback", "Create VoC record", "Extract insights from feedback", "Process feedback from [name]", "Log stakeholder input" |
| Receiving/Owning Agent | ProductOwner |
| Secondary Agents | BusinessAnalyst (conditional — guardrail clarification only) |
| Phase 5 Checkpoint Cross-references | CP-B1, CP-B2, CP-B3 |
| Handoff Button Label | `[Process Feedback →]` |

### Input Schema

| Input Type | Format | Required Metadata Fields | Pre-processing |
|------------|--------|--------------------------|----------------|
| Stakeholder interview notes | `.md` or plain text | stakeholder_name, date, session_type | None |
| Email transcript | `.eml` or plain text | sender, date, subject | Worker: convert if `.eml` |
| Meeting summary | `.md` | meeting_date, attendees, agenda_items | None |
| Survey response | Plain text or `.md` | respondent_role, date, survey_name | None |

### Processing Expectation

ProductOwner invokes the `stakeholder-feedback` skill to capture and structure the raw stakeholder input, map each insight to the VoC guardrail catalog, extract actionable items (feature requests, constraints, open questions), and produce a completed VoC record. If a guardrail mapping is ambiguous, BusinessAnalyst is invoked to clarify requirement boundaries before proceeding. Upon completion, if insights indicate requirements changes, ProductOwner triggers Workflow C.

### Output Schema

| Output Type | Format | Required Metadata Fields | Output Path Template |
|-------------|--------|--------------------------|----------------------|
| VoC record | Markdown (`.md`) | stakeholder, date, session_type, guardrail_mappings, feature_requests, open_questions, status | `learning_base/11_voice_of_customer/VOC-{NNN}-{stakeholder_slug}.md` |

### Success Criteria

1. VoC record file exists at `learning_base/11_voice_of_customer/VOC-{NNN}-{slug}.md`.
2. CP-B1 passed: feedback fully captured in structured format.
3. CP-B2 passed: all guardrail mappings completed or ambiguities resolved via BusinessAnalyst.
4. CP-B3 passed: actionable insights extracted; cascade trigger decision made (trigger Workflow C or confirm no cascade required).

### Failure / Escalation Path

- **Incomplete feedback (CP-B1 FAIL):** ProjectManager requests additional detail from stakeholder. Workflow B paused until feedback is complete.
- **Unresolvable guardrail ambiguity (CP-B2 FAIL after BA):** ProjectManager escalates to human reviewer; workflow paused.
- **Insight extraction unclear (CP-B3 FAIL):** ProductOwner reworks insight extraction; CP-B3 re-evaluated.

---

## Workflow C: Requirements Cascade

| Field | Value |
|-------|-------|
| Contract ID | WFC-C |
| Triggering Role(s) | ProductOwner, BusinessAnalyst |
| Trigger Phrase(s) | "Run cascade review", "Check what's impacted", "Update dependent docs", "Verify requirements alignment", "Cascade this change" |
| Receiving/Owning Agent | BusinessAnalyst |
| Secondary Agents | FrontendDev, BackendDev (conditional — technical review), ProductOwner (trigger role) |
| Phase 5 Checkpoint Cross-references | CP-C1, CP-C2, CP-C3, CP-C4 |
| Handoff Button Label | `[Run Cascade Review →]` |

### Input Schema

| Input Type | Format | Required Metadata Fields | Pre-processing |
|------------|--------|--------------------------|----------------|
| VoC record (from Workflow B) | Markdown (`.md`) | stakeholder, date, feature_requests, guardrail_mappings | None |
| Change request | `.md` | req_id, change_description, requestor, date | None |
| Requirements document | `.md` | req_id, version, section_references | None |

### Processing Expectation

BusinessAnalyst invokes the `requirements-cascade` skill to perform an impact analysis on all downstream documents referencing the changed requirement, update the relevant requirements document sections, produce a cascade impact report identifying impacted documents and required actions, and assign review tasks for FrontendDev or BackendDev when technical feasibility review is required. The cascade verify step confirms all dependent documents are either updated or explicitly deferred.

### Output Schema

| Output Type | Format | Required Metadata Fields | Output Path Template |
|-------------|--------|--------------------------|----------------------|
| Requirements update | Markdown (`.md`) | req_id, version, changed_sections, updated_by, date | `learning_base/02_requirements/{existing-doc-name}.md` |
| Cascade impact report | Markdown (`.md`) | changed_req_id, impacted_docs, impacted_sections, action_required, assigned_to, status | `learning_base/02_requirements/cascade_impact_{YYYY-MM-DD}.md` |

### Success Criteria

1. Cascade impact report created at `learning_base/02_requirements/cascade_impact_{date}.md`.
2. CP-C1 passed: trigger accepted and change scope confirmed.
3. CP-C2 passed: impact analysis complete; all impacted documents identified.
4. CP-C3 passed: requirements document(s) updated or deferral explicitly recorded.
5. CP-C4 passed: cascade verify confirms all dependent docs addressed; cascade impact report finalized.

### Failure / Escalation Path

- **Scope creep detected (CP-C2 FAIL):** BusinessAnalyst flags scope creep; ProjectManager escalates to human reviewer for rework or defer decision.
- **Technical feasibility unclear (CP-C3 FAIL):** FrontendDev/BackendDev invoked for advisory review; CP-C3 re-evaluated after input.
- **Cascade verify fails (CP-C4 FAIL):** BusinessAnalyst produces updated impact report; project manager notified.

---

## Workflow D: Diagram Lifecycle

| Field | Value |
|-------|-------|
| Contract ID | WFC-D |
| Triggering Role(s) | ProductOwner, UIUXDesigner |
| Trigger Phrase(s) | "Create diagram", "Update diagram", "Publish diagram", "Render Mermaid", "Add diagram to docs" |
| Receiving/Owning Agent | UIUXDesigner |
| Secondary Agents | None (UIUXDesigner owns full lifecycle) |
| Phase 5 Checkpoint Cross-references | CP-D1, CP-D2, CP-D3, CP-D4 |
| Handoff Button Label | `[Publish Diagram →]` |

### Input Schema

| Input Type | Format | Required Metadata Fields | Pre-processing |
|------------|--------|--------------------------|----------------|
| Diagram source (Mermaid) | `.mmd` | diagram_id, title, owning_doc, author, date | None |
| Diagram source (draw.io) | `.drawio` | diagram_id, title, owning_doc, author, date | None |
| Diagram update request | `.md` or plain text | diagram_id, requested_change, requestor, date | None |

### Processing Expectation

UIUXDesigner invokes the `diagram-generation` skill to design or update the diagram source file, render it to PNG using the project render script, validate the source file conforms to `.github/copilot-instructions.md` naming convention (`NN_short_description.{mmd|png}`), publish the rendered PNG to `images/diagrams/`, update `diagram_manifest.json`, and inject the rendered image reference back into the owning documentation file. All diagram artifacts must comply with the Mermaid lifecycle rules in `.github/copilot-instructions.md`.

### Output Schema

| Output Type | Format | Required Metadata Fields | Output Path Template |
|-------------|--------|--------------------------|----------------------|
| Diagram source | `.mmd` or `.drawio` | diagram_id, title, version, owning_doc | `images/diagrams/{NN}_{short_description}.mmd` |
| Rendered PNG | `.png` | diagram_id, title, generated_date | `images/diagrams/{NN}_{short_description}.png` |
| Manifest update | `diagram_manifest.json` | diagram_id, source_path, png_path, owning_doc, last_updated | `images/diagrams/diagram_manifest.json` |
| Documentation link-back | Markdown image reference | diagram_id, alt_text | Injected into `{owning_doc}` |

### Success Criteria

1. Diagram source file exists at `images/diagrams/{NN}_{short_description}.mmd` (or `.drawio`).
2. Rendered PNG exists at `images/diagrams/{NN}_{short_description}.png`.
3. CP-D1 passed: diagram designed or updated and source file saved.
4. CP-D2 passed: PNG rendered successfully without errors.
5. CP-D3 passed: source file naming validated against copilot-instructions convention.
6. CP-D4 passed: `diagram_manifest.json` updated; documentation link-back injected.

### Failure / Escalation Path

- **Render failure (CP-D2 FAIL):** UIUXDesigner corrects source file; CP-D2 re-evaluated.
- **Unsupported format:** ProjectManager escalates to user; format conversion route identified before re-triggering workflow.
- **Manifest update fails (CP-D4 FAIL):** UIUXDesigner retries manifest update; if system error, ProjectManager notified.

---

## Workflow E: Backlog Planning

| Field | Value |
|-------|-------|
| Contract ID | WFC-E |
| Triggering Role(s) | ProductOwner, ScrumMaster, User |
| Trigger Phrase(s) | "Groom backlog", "Plan sprint", "Prioritize items", "Sprint planning", "Assign phase", "Run backlog grooming" |
| Receiving/Owning Agent | ProductOwner (MoSCoW prioritization), ScrumMaster (sprint breakdown) |
| Secondary Agents | BusinessAnalyst (conditional — requirement clarification) |
| Phase 5 Checkpoint Cross-references | CP-E1, CP-E2, CP-E3, CP-E4 |
| Handoff Button Label | `[Publish Sprint Plan →]` |

### Input Schema

| Input Type | Format | Required Metadata Fields | Pre-processing |
|------------|--------|--------------------------|----------------|
| Backlog items list | `.md` or plain text | req_id, requirement_name, category, description | None |
| Existing MoSCoW matrix | `.md` | version, sprint, req_id column | None |
| Requirements document | `.md` | req_id, section_references | None |

### Processing Expectation

ProductOwner invokes the `backlog-management` skill to assign MoSCoW priorities to each backlog item and produce the MoSCoW backlog matrix in the `requirements_moscow_matrix_harrison.md` compatible format. ScrumMaster then breaks down sprint tasks, estimates effort, resolves dependencies, and publishes the sprint plan task list in the `kickoff_tasks_ba_harrison.csv` compatible column schema. If any backlog item has unclear requirements, BusinessAnalyst is invoked for clarification before prioritization.

### Output Schema

| Output Type | Format | Required Metadata Fields | Output Path Template |
|-------------|--------|--------------------------|----------------------|
| MoSCoW backlog matrix | Markdown table (`.md`) | Req ID, Category, Requirement Name, Description, MoSCoW, BRD Section, SME Clarif. Needed, Dependencies, Acceptance Criteria | `learning_base/planner_updates/requirements_moscow_matrix_{slug}.md` |
| Sprint plan task list | CSV (`.csv`) | Task number, Outline number, Name, Assigned to, Start, Finish, Duration, Bucket, % complete, Priority, Labels, Depends on, Dependents, Effort, Effort completed, Effort remaining, Milestone, Notes, Completed, Checklist Items, Sprint, Goal | `learning_base/planner_updates/sprint_{NN}_{slug}.csv` |

### Success Criteria

1. MoSCoW matrix document created with all nine canonical columns matching `requirements_moscow_matrix_harrison.md` schema.
2. Sprint plan CSV created with all 22 verified columns matching `kickoff_tasks_ba_harrison.csv` schema.
3. CP-E1 passed: backlog items reviewed and MoSCoW assignments confirmed by ProductOwner.
4. CP-E2 passed: task breakdown and effort estimates completed by ScrumMaster.
5. CP-E3 passed: dependencies resolved and sprint scope confirmed.
6. CP-E4 passed: sprint plan published and accessible at confirmed `planner_updates/` path.

### Failure / Escalation Path

- **Backlog item blocked (CP-E1 FAIL):** BusinessAnalyst invoked for requirement clarification; item deferred until resolved.
- **Estimation incomplete (CP-E2 FAIL):** ScrumMaster reworks breakdown; CP-E2 re-evaluated.
- **Dependency conflict (CP-E3 FAIL):** ProductOwner and ScrumMaster resolve conflict or defer items to next sprint.
- **Sprint publish fails (CP-E4 FAIL):** ProjectManager notified; path or format error investigated.

---

## Workflow F: Quality Gate Review Loop

| Field | Value |
|-------|-------|
| Contract ID | WFC-F |
| Triggering Role(s) | QAEngineer, ProductOwner |
| Trigger Phrase(s) | "Run test", "Quality gate", "QA review", "Test pass/fail decision", "Execute test suite", "Run quality gate for sprint item" |
| Receiving/Owning Agent | QAEngineer |
| Secondary Agents | FrontendDev, BackendDev (conditional — technical failure investigation) |
| Phase 5 Checkpoint Cross-references | CP-F1, CP-F2, CP-F3, CP-F4 |
| Handoff Button Label | `[Quality Gate Decision →]` |

### Input Schema

| Input Type | Format | Required Metadata Fields | Pre-processing |
|------------|--------|--------------------------|----------------|
| Sprint task item | `.md` or reference ID | task_id, sprint, acceptance_criteria, assigned_to | None |
| Acceptance criteria | Embedded in task item | criteria_id, description, verifiable_condition | None |
| Test execution results | Plain text or `.md` | task_id, test_run_date, results_summary | None |

### Processing Expectation

QAEngineer executes the test suite or review against the sprint task acceptance criteria (test execution only — no code edits), reviews results, and makes a pass/fail determination. On PASS, sprint task status is updated and the QA result record is filed. On FAIL, a rework item list is produced and escalated: FrontendDev or BackendDev may be invoked for technical failure investigation if the blocker is architectural. ProjectManager is notified of any blocker that cannot be resolved within the sprint.

### Output Schema

| Output Type | Format | Required Metadata Fields | Output Path Template |
|-------------|--------|--------------------------|----------------------|
| QA result record | Markdown (`.md`) | task_id, sprint, criteria_tested, pass_fail, blockers, rework_items, decision, decided_by | `learning_base/07_testing/qa_result_{task_id}_{YYYY-MM-DD}.md` |

### Success Criteria

1. QA result record exists at `learning_base/07_testing/qa_result_{task_id}_{date}.md`.
2. CP-F1 passed: test execution completed; results documented.
3. CP-F2 passed: results reviewed against acceptance criteria.
4. CP-F3 passed: pass/fail decision made and recorded in QA result record.
5. CP-F4 passed: sprint task status updated (PASS: "Done"; FAIL: rework list issued); ProjectManager notified of outcome.

### Failure / Escalation Path

- **Test execution blocked (CP-F1 FAIL):** QAEngineer logs blocker; ProjectManager notified; FrontendDev or BackendDev invoked if technical.
- **Criteria not testable (CP-F2 FAIL):** QAEngineer escalates to ProductOwner for acceptance criteria clarification; CP-F2 re-evaluated.
- **FAIL decision with blocker (CP-F3 PASS but blocker present):** Rework task issued; FrontendDev/BackendDev assigned; CP-F4 waits for rework resolution.
- **Persistent blocker across sprint:** ProjectManager escalates to human reviewer; sprint plan revised.

---

## Phase-7 Addendum Checkpoints

No addendum checkpoints required. All workflow governance gates are covered by the Phase 5 CP-A* through CP-F* checkpoint set. No Phase 7 workflows introduce new routing logic or decision points that require additional checkpoint IDs beyond the Phase 5 baseline.
