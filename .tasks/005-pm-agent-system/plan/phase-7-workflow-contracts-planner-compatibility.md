---
goal: Phase 7 - Workflow Contracts and Planner Compatibility
phase: 7
date_created: 2026-03-18
last_updated: 2026-03-18
owner: Explorer
status: Planned
tags: [planning, workflow-contracts, handoff-documents, planner-compatibility, artifact-schemas, io-format, compatibility-matrix]
---

# Phase 7 Plan: Workflow Contracts and Planner Compatibility

## Goal

Define end-to-end workflow handoff contracts for all six core workflows (A–F), specify input/output artifact schemas per workflow, standardise the handoff document template, and produce a compatibility verification matrix confirming that all agent system outputs (VoC records, requirements cascade, MoSCoW backlog, diagram artifacts) are structurally and format-compatible with the three active task-tracking and knowledge workflows in 2026_01_VIP: `learning_base/planner_updates/`, `.tasks/`, and `learning_base/`.

## Scope

- In scope:
  - Six workflow contracts (Workflows A–F as defined in Phase 5 REQ-502), each as a self-contained handoff contract document.
  - Standard handoff document template governing the required sections of every agent-to-agent handoff.
  - Input/output format specification per workflow, covering: input schema (content type, metadata fields, file format), output schema (content type, metadata fields, file format), output path, and format-compatibility tag.
  - Compatibility verification matrix: all output types (VoC, requirements cascade, MoSCoW backlog, sprint plan, diagram artifact, resource ingestion record) × three planning systems (`planner_updates/`, `.tasks/`, `learning_base/`) with explicit match / gap / transform-required verdict per cell.
  - `planner_updates/` format compatibility: MoSCoW matrix must match `requirements_moscow_matrix_harrison.md` field structure; sprint/task lists must match `kickoff_tasks_ba_harrison.csv` column schema.
  - `.tasks/` directory compatibility: how agent workflow products reference or create `.tasks/` phase-plan entries, task IDs, and status markers.
  - `learning_base/` compatibility: VoC record template compliance, directory routing rules, and metadata header requirements for all ingested artifacts.
  - Creation of all Phase 7 artifacts under `.tasks/005-pm-agent-system/artifacts/phase-7/`.
  - Update of `task.md` Phase 7 row to `📋 Planned`.

- Out of scope:
  - Creating or editing any template in `C:/Users/s1058662/repos/agents-personal/`.
  - Modifying any file outside `.tasks/005-pm-agent-system/`.
  - Phase 6 access and permission governance (separate phase).
  - Phase 8 pilot validation and integration testing (separate phase).
  - Implementing any workflow logic, orchestration machinery, or agent code.
  - Running `make`, `install.sh`, PowerShell scripts, or any command that modifies state.

---

## Checkpoints (Plan-Only Governance)

> **Checkpoint Naming Disambiguation:** The `CP-7.x` identifiers in this table are **Phase 7 Plan Review Checkpoints** that govern the review and approval of Phase 7 planning artifacts only. They are entirely distinct from **Phase 5 Workflow Agent Checkpoints** (`CP-A1`–`CP-F4`), which govern PM agent system workflow execution at runtime. All references to Phase 5 workflow checkpoints within Phase 7 artifacts and workflow contracts **must** use the `CP-A*/CP-F*` format. `CP-5.x` plan-governance identifiers (e.g., `CP-5.3`) must not appear in workflow contract cross-reference fields — those are Phase 5 plan-review artifacts, not execution gates.

| Checkpoint | Owner | Required Evidence | Decision Options |
| --- | --- | --- | --- |
| CP-7.1 Workflow Contract Coverage | Explorer | Workflow contracts artifact at `.tasks/005-pm-agent-system/artifacts/phase-7/phase-7-workflow-contracts.md` with one contract section for each of six workflows (A–F); each contract contains: contract ID, triggering role, receiving role, input schema, processing expectation, output schema, output path, Phase-5 checkpoint cross-references, success criteria, failure/escalation path | Proceed, Rework, Defer |
| CP-7.2 Handoff Document Template Standard | Reviewer (human) | Handoff document template at `.tasks/005-pm-agent-system/artifacts/phase-7/phase-7-handoff-document-template.md` defining required sections for every agent-to-agent handoff: header block (workflow ID, from agent, to agent, trigger phrase), context summary, artifact list (with path and format), checkpoint gate reference, decision gate (Proceed / Return / Escalate), and receiving-agent acknowledgement stub | Approve, Request Changes |
| CP-7.3 Input/Output Format Spec Completeness | Reviewer (human) | I/O format spec artifact at `.tasks/005-pm-agent-system/artifacts/phase-7/phase-7-io-format-spec.md` covering all six workflows with per-workflow sections; each section includes: input type table, output type table, metadata field list, file format required, save-path template, and compatibility tag (native / transform-required / incompatible) | Approve, Request Changes |
| CP-7.4 planner_updates/ Format Compatibility | Reviewer (human) | Compatibility verification matrix artifact (see CP-7.5) confirms that MoSCoW backlog output columns map 1:1 to `requirements_moscow_matrix_harrison.md` fields and that sprint/task-list outputs match `kickoff_tasks_ba_harrison.csv` column schema; gaps or transform requirements are documented explicitly | Approve, Request Changes |
| CP-7.5 Compatibility Verification Matrix | Reviewer (human) | Compatibility verification matrix at `.tasks/005-pm-agent-system/artifacts/phase-7/phase-7-compatibility-verification-matrix.md` with rows = output types (VoC record, requirements-cascade update, MoSCoW backlog entry, sprint plan task, diagram artifact, resource ingestion record), columns = planning systems (`planner_updates/`, `.tasks/`, `learning_base/`), and each cell showing: format match verdict (Native / Transform Required / Not Applicable), specific field-mapping or path note, and any blocking incompatibility | Approve, Request Changes |
| CP-7.6 learning_base/ Routing and Metadata Compliance | Reviewer (human) | I/O format spec and workflow contracts confirm that all artifacts produced by agent workflows include the required metadata header (title, date, source, tags) and are routed to the correct `learning_base/` subdirectory (per the existing directory taxonomy); VoC records routed to `learning_base/11_voice_of_customer/`, ingested resources to the path derived from classification, requirements updates to `learning_base/02_requirements/` | Approve, Request Changes |
| CP-7.7 .tasks/ Directory Compatibility | Reviewer (human) | Workflow contracts and I/O format spec explicitly describe how agent outputs that result in new planning tasks use the `.tasks/` phase-plan structure (task.md status updates, artifact artifact paths, and phase status markers); no agent step silently produces `.tasks/` entries without a defined format conforming to the established `task.md` + `plan/phase-N-*.md` convention | Approve, Request Changes |
| CP-7.8 Source Alignment and Plan-Only Boundary Check | Explorer + Reviewer | Source traceability matrix at `.tasks/005-pm-agent-system/artifacts/phase-7/phase-7-source-traceability-matrix.md` with minimum columns: `rule`, `source doc`, `source clause`, `implementation note`, `verification evidence`. All Phase 7 file create/update targets verified as `.tasks/005-pm-agent-system/**` only. Cross-references to Phase 5 workflow definitions and Phase 2 skill I/O contracts confirmed | Approve, Request Changes, Defer |

---

## Status Governance (Plan-Only Mode)

- `📋 Planned` is set when this phase plan is created and linked from `task.md`.
- `⭐ Reviewed` is set by the reviewer after CP-7.2, CP-7.3, CP-7.5, and CP-7.6 evidence is accepted.
- `✅ Done` is reserved for Builder execution plus verification evidence; Explorer does not set this for unexecuted implementation work.

---

## Requirements and Constraints

### Workflow Contract Requirements

- REQ-700: Produce six workflow contracts, one per workflow defined in Phase 5 REQ-502 (Workflow A: Resource Ingestion, B: Stakeholder Feedback, C: Requirements Cascade, D: Diagram Lifecycle, E: Backlog Planning, F: Quality Gate Review Loop). Each contract is a self-contained document section that can be handed to the Builder or a receiving agent as a standalone reference.
- REQ-701: Each workflow contract must include, in this order: (a) Contract ID and Workflow name; (b) triggering role(s) and trigger phrase(s); (c) receiving/owning agent(s); (d) input schema (content type, format, required metadata fields); (e) processing expectation (what the owning agent does, not how); (f) output schema (content type, format, required metadata fields); (g) output path and naming convention; (h) Phase 5 checkpoint cross-references (which CP-* IDs govern this workflow); (i) handoff button label (for receiving agent); (j) success criteria; (k) failure/escalation path.
- REQ-702: All six workflow contracts must cross-reference the correct Phase-5 checkpoint IDs from the comprehensive checkpoint table (phase-5 CP-A*, CP-B*, CP-C*, CP-D*, CP-E*, CP-F* naming convention established in Phase 5).
- REQ-703: Workflow contracts must not redefine checkpoint logic — they reference Phase 5 checkpoints as authorities; any new gateway identified in Phase 7 is flagged as a Phase-7 addendum checkpoint (CP-7-Ax through CP-7-Fx).

### Handoff Document Template Requirements

- REQ-704: Define one canonical handoff document template, versioned at v1.0, to be used for all agent-to-agent transitions in the PM system. The template must include: header block, context summary, artifact manifest (table of input/output files with path, format, status), checkpoint gate reference (CP-* ID and current decision state), decision gate block (Proceed / Return / Escalate with required fields per option), and receiving-agent acknowledgement stub.
- REQ-705: The handoff document template must be compatible with Copilot chat context passing (markdown only) and CC context block conventions (no binary attachments, path references only).
- REQ-706: The handoff document template must include a `## Workflow Provenance` section recording: originating workflow ID, trigger phrase used, timestamp or date, and caller role — enabling traceability without modifying source artifacts. Each completed handoff document containing a populated Workflow Provenance section must be persisted as a file record in the corresponding `.tasks/005-pm-agent-system/artifacts/` path (or the relevant `.tasks/` run-log); it must not exist solely in ephemeral conversation context, ensuring cross-session traceability and audit continuity per ADR-002.

### Input/Output Format Specification Requirements

- REQ-707: Workflow A (Resource Ingestion) I/O spec must define: input types (URL, .docx, .eml, .md, .pdf, plain text), required pre-processing for binary formats (Worker conversion step), output format (markdown with metadata header), output path template (`learning_base/{classification-subdir}/{date}_{slug}.md`), and required metadata fields (`title`, `date`, `source`, `classification`, `tags`, `ingested_by`).
- REQ-708: Workflow B (Stakeholder Feedback / VoC) I/O spec must define: input types (stakeholder interview notes, email transcript, meeting summary), output format (VoC record markdown), output path (`learning_base/11_voice_of_customer/VOC-{NNN}-{stakeholder_slug}.md`), and required metadata fields (`stakeholder`, `date`, `session_type`, `guardrail_mappings`, `feature_requests`, `open_questions`, `status`).
- REQ-709: Workflow C (Requirements Cascade) I/O spec must define: input (VoC record or change request referencing a requirement ID), output types (updated requirements document + cascade impact report), output path for requirements updates (`learning_base/02_requirements/`), cascade impact report path (`learning_base/02_requirements/cascade_impact_{date}.md`), and required fields in the impact report (`changed_req_id`, `impacted_docs`, `impacted_sections`, `action_required`, `assigned_to`, `status`).
- REQ-710: Workflow D (Diagram Lifecycle) I/O spec must define: input (diagram source file — `.mmd` or `.drawio`), output types (rendered PNG at `images/diagrams/`, `.mmd` source at `images/diagrams/`, `diagram_manifest.json` update), naming convention (`NN_short_description.{mmd|png}` per `.github/copilot-instructions.md`), and documentation link-back requirement (rendered image reference injected into owning document per copilot-instructions diagram workflow).
- REQ-711: Workflow E (Backlog Planning) I/O spec must define: input (backlog items list with MoSCoW assignments), output types (MoSCoW matrix document + sprint plan task list), MoSCoW output format (must match `requirements_moscow_matrix_harrison.md` column schema: `Req ID`, `Category`, `Requirement Name`, `Description`, `MoSCoW`, `BRD Section`, `SME Clarif. Needed`, `Dependencies`, `Acceptance Criteria`), and sprint plan output format (must match `kickoff_tasks_ba_harrison.csv` column schema: `Task number`, `Outline number`, `Name`, `Assigned to`, `Start`, `Finish`, `Duration`, `Bucket`, `% complete`, `Priority`, `Labels`, `Depends on`, `Dependents`, `Effort`, `Effort completed`, `Effort remaining`, `Milestone`, `Notes`, `Completed`, `Checklist Items`, `Sprint`, `Goal`).
- REQ-712: Workflow F (Quality Gate Review Loop) I/O spec must define: input (sprint task item + acceptance criteria), output types (QA result record + pass/fail decision), QA result path (`learning_base/07_testing/qa_result_{task_id}_{date}.md`), and required fields in QA result record (`task_id`, `sprint`, `criteria_tested`, `pass_fail`, `blockers`, `rework_items`, `decision`, `decided_by`).

### Planner Compatibility Requirements

- REQ-713: MoSCoW backlog output (Workflow E) must be compatible with `planner_updates/requirements_moscow_matrix_harrison.md` without data transformation loss — all existing column headers must be preserved and any new columns appended, not substituted.
- REQ-714: Sprint/task-list output (Workflow E) must be compatible with `planner_updates/kickoff_tasks_ba_harrison.csv` column schema — the columns defined in that file are the canonical column set; the Builder must verify the actual column count by reading the CSV header row at planning time (Step 0) and record the verified count as **N** in all artifacts (expected: 22 columns based on last inspection March 2026, but N must not be hard-coded without verification); generated task lists must include all N verified columns (with empty string for unused optional fields), supporting direct CSV append without schema migration.
- REQ-715: When an agent workflow produces a planning output that should be tracked in `.tasks/`, it must reference the existing `.tasks/{task-slug}/task.md` phase-plan record using the phase status marker conventions (⬜ Not Started → 📋 Planned → ⭐ Reviewed → 🔄 In Progress → ✅ Done); no custom status values are permitted.
- REQ-716: When a workflow produces an artifact that must be tracked by ProjectManager across sessions, the artifact path and status must be recorded in the relevant `.tasks/` run-log or as a `task.md` phase status update — no out-of-band tracking systems.

### Compatibility Verification Matrix Requirements

- REQ-717: The compatibility verification matrix must cover six output types as rows: (1) VoC Record, (2) Requirements Cascade Update, (3) MoSCoW Backlog Entry, (4) Sprint Plan Task, (5) Diagram Artifact, (6) Resource Ingestion Record.
- REQ-718: The matrix must cover three planning systems as columns: (A) `planner_updates/` (CSV + markdown matrix format), (B) `.tasks/` (task.md + phase plan markdown), (C) `learning_base/` (subdirectory structure + metadata header standard).
- REQ-719: Each matrix cell must state: (a) compatibility verdict (Native / Transform Required / Not Applicable); (b) the specific format or field mapping note enabling the verdict; (c) any blocking incompatibility or gap requiring resolution before the Builder phase.
- REQ-720: Any cell verdict of "Transform Required" must include a named transform operation (e.g., "convert MoSCoW markdown table to CSV with 22-column schema") and the agent responsible for executing the transform.

### Constraints

- CON-700: This phase is planning-only; no production template files, agent configurations, or 2026_01_VIP documents are created or edited.
- CON-701: All writes are restricted to `.tasks/005-pm-agent-system/**`.
- CON-702: Workflow contracts must not introduce new checkpoint IDs that conflict with Phase 5 checkpoint naming; any Phase-7 addendum checkpoints must use the naming pattern `CP-7-{workflow-letter}{N}`. Workflow contract cross-reference fields (field: "Phase 5 Checkpoint Cross-references") must cite Phase 5 *workflow* checkpoint IDs in `CP-A*/CP-F*` format exclusively; `CP-5.x` plan-governance identifiers must not appear in workflow contract content — see Checkpoints disambiguation note above.
- CON-703: I/O format specs must be grounded in existing artifact formats observed in `planner_updates/`, `learning_base/`, and `.github/copilot-instructions.md` — do not invent new canonical formats.
- GUD-700: Follow task-centric persistence conventions from ADR-002.
- GUD-701: Maintain plan-only governance: `✅ Done` is never set by Explorer for unexecuted Builder work.
- GUD-702: Include rationalization-prevention evidence requirements from ADR-007 in verification section.

---

## Source Guidelines to Incorporate

Mandatory source traceability inputs for Phase 7:

- `VIP/learning_base/planner_updates/requirements_moscow_matrix_harrison.md` — canonical MoSCoW matrix field structure for Workflow E output compatibility.
- `VIP/learning_base/planner_updates/kickoff_tasks_ba_harrison.csv` — canonical sprint/task CSV column schema for Workflow E task-list output compatibility; column count must be confirmed by reading the file header at planning time (Step 0) and recorded as the verified N in compatibility artifacts (expected: 22 columns as of March 2026 — treat as input to verification, not as a hard-coded constant).
- `VIP/.tasks/005-pm-agent-system/plan/phase-5-projectmanager-orchestration-layer.md` sections: Six Core Workflows (A–F), Comprehensive Checkpoint Table (CP-A* through CP-F*), Task-Tracking Coordination Specification — baseline for all workflow contract definitions.
- `VIP/.tasks/005-pm-agent-system/plan/phase-2-skill-template-set.md` — skill I/O schemas for resource-ingestion, stakeholder-feedback, requirements-cascade, backlog-management, diagram-generation; authoritative source for workflow input and output type definitions.
- `VIP/.tasks/005-pm-agent-system/plan/phase-4-productowner-existing-agent-integration.md` — ProductOwner handoff contract patterns (REQ-404 through REQ-408); baseline for handoff document template design.
- `VIP/.github/copilot-instructions.md` — Mermaid diagram naming convention, render script, PNG output path, and `diagram_manifest.json` update obligation for Workflow D I/O spec.
- `VIP/learning_base/REVIEW_WORKFLOW.md` — cascade dependency and checkpointing model for Workflow C review obligations.
- `C:/Users/s1058662/repos/agents-personal/docs/architecture/ADR-002-task-centric-persistence.md` — `.tasks/` phase-plan and status marker conventions; authoritative for `.tasks/` compatibility specification.
- `C:/Users/s1058662/repos/agents-personal/docs/architecture/ADR-001-orchestration-and-subagents.md` — checkpoint gating, handoff button structure, and Entry Gate conventions; authoritative for the handoff document template.

---

## Detailed File Changes (Phase 7 Deliverables)

All writes are limited to `.tasks/005-pm-agent-system/`.

### 0. Verify `kickoff_tasks_ba_harrison.csv` Column Schema (Planning-Time Audit)

Before creating any compatibility artifacts, the Builder must:

1. Open `VIP/learning_base/planner_updates/kickoff_tasks_ba_harrison.csv` and read the header row.
2. Count the actual number of columns and record the verified count as **N** (the canonical column count for this execution).
3. Note N alongside a date stamp in the preamble of both `phase-7-compatibility-verification-matrix.md` and `phase-7-io-format-spec.md` — e.g., `kickoff_tasks_ba_harrison.csv verified column count: N (audited YYYY-MM-DD)`.
4. Use N throughout all Phase 7 artifacts in place of any hard-coded value. If N ≠ 22, update REQ-714 commentary accordingly and flag the discrepancy as a blocking note for the reviewer.

> **Rationale:** REQ-714 references 22 columns based on the state of the file as of the last known inspection (March 2026). The actual CSV header is the authoritative source; the compatibility matrix must reflect the verified state, not an assumed constant.

### 1. Create `.tasks/005-pm-agent-system/artifacts/phase-7/phase-7-workflow-contracts.md`

Content:
- Frontmatter header: `document: phase-7-workflow-contracts`, `version: 1.0`, `phase: 7`, `date_created`, `workflows_covered: [A, B, C, D, E, F]`.
- One section per workflow (six sections), each containing the full REQ-701 contract schema.
- Workflow A — Resource Ingestion contract (triggering role: User/ProductOwner, receiving: ProductOwner/Worker, output: classified markdown at `learning_base/{subdir}/`, checkpoints: CP-A1–CP-A3 from Phase 5, success/failure paths).
- Workflow B — Stakeholder Feedback contract (triggering role: ProductOwner/Stakeholder, receiving: ProductOwner, output: VoC record at `learning_base/11_voice_of_customer/`, checkpoints: CP-B1–CP-B3).
- Workflow C — Requirements Cascade contract (triggering role: ProductOwner/BusinessAnalyst, receiving: BusinessAnalyst, output: requirements update + cascade impact report at `learning_base/02_requirements/`, checkpoints: CP-C1–CP-C4).
- Workflow D — Diagram Lifecycle contract (triggering role: ProductOwner/UIUXDesigner, receiving: UIUXDesigner, output: diagram source + rendered PNG at `images/diagrams/`, `diagram_manifest.json` update, documentation link-back, checkpoints: CP-D1–CP-D4).
- Workflow E — Backlog Planning contract (triggering role: ProductOwner/ScrumMaster/User, receiving: ProductOwner then ScrumMaster, output: MoSCoW matrix at `planner_updates/` + sprint plan CSV at `planner_updates/`, checkpoints: CP-E1–CP-E4).
- Workflow F — Quality Gate Review Loop contract (triggering role: QAEngineer/ProductOwner, receiving: QAEngineer, output: QA result record at `learning_base/07_testing/`, checkpoints: CP-F1–CP-F4, escalation path to ProjectManager on blocker).
- Closing section: "Phase-7 Addendum Checkpoints" listing any new CP-7-* gates identified during contract specification (if none, state explicitly "No addendum checkpoints required").

### 2. Create `.tasks/005-pm-agent-system/artifacts/phase-7/phase-7-handoff-document-template.md`

Content:
- Frontmatter header: `document: phase-7-handoff-document-template`, `version: 1.0`, `phase: 7`, `date_created`.
- Template preamble: purpose statement, scope (all agent-to-agent handoffs in the PM system), and relationship to ADR-001 handoff button conventions.
- Template sections (with `<!-- placeholder -->` stubs for each variable field):
  1. `## Header` — Workflow ID, From Agent, To Agent, Trigger Phrase Used, Date.
  2. `## Context Summary` — one-paragraph summary of what was processed, key decisions made, and outstanding open questions.
  3. `## Artifact Manifest` — table with columns: Artifact Name, File Path, Format, Status (Ready / Needs Review / Blocked).
  4. `## Checkpoint Gate Reference` — CP-* ID from Phase 5 governing this handoff, current state (Awaiting Decision / Passed / Rework Required), and decision authority (PM / Human Reviewer).
  5. `## Decision Gate` — three standardised subsections:
     - `### Proceed` — required fields to confirm clean handoff.
     - `### Return` — required fields to send back (reason, rework scope, estimated rework effort).
     - `### Escalate` — required fields to escalate (blocker description, escalation target role, urgency level).
  6. `## Workflow Provenance` — originating workflow ID, trigger phrase, date/timestamp, caller role. **Persistence requirement:** when an agent completes a handoff step, the populated Workflow Provenance section must be saved as part of a file artifact in `.tasks/005-pm-agent-system/artifacts/` (or the relevant `.tasks/` run-log path), not retained solely in ephemeral conversation context — see REQ-706 and ADR-002.
  7. `## Receiving Agent Acknowledgement` — stub for receiving agent to confirm receipt (required before proceeding past checkpoint gate).
- Usage notes section: when to use each decision gate option, how to populate the artifact manifest, and how this template integrates with `.tasks/` phase status updates.
- Compatibility note: confirm template is markdown-only (no embedded binary content) and compatible with both Copilot chat context passing and CC context block conventions per REQ-705.

### 3. Create `.tasks/005-pm-agent-system/artifacts/phase-7/phase-7-io-format-spec.md`

Content:
- Frontmatter header: `document: phase-7-io-format-spec`, `version: 1.0`, `phase: 7`, `date_created`, `workflows_covered: [A, B, C, D, E, F]`.
- One section per workflow with heading `## Workflow {X}: {Name}`.
- Each section contains:
  - **Input Type Table**: columns — Input Type, File Format, Required Metadata Fields, Pre-processing Required (Y/N), Pre-processing Agent.
  - **Output Type Table**: columns — Output Type, File Format, Required Metadata Fields, Output Path Template, Naming Convention.
  - **Compatibility Tag**: one of `Native` (field-compatible with target planning system without transformation), `Transform Required` (schema conversion needed — named transform and responsible agent), `Not Applicable` (output does not flow to this planning system).
  - **Metadata Header Stub**: a markdown code block showing the exact required YAML/markdown metadata header for the produced artifact, referencing the fields from REQ-707 through REQ-712.
- Workflow A: resource ingestion I/O spec (per REQ-707).
- Workflow B: VoC record I/O spec (per REQ-708).
- Workflow C: cascade update + impact report I/O spec (per REQ-709).
- Workflow D: diagram artifact I/O spec (per REQ-710).
- Workflow E: MoSCoW backlog + sprint plan task-list I/O spec (per REQ-711, with explicit column mapping table for both the MoSCoW markdown format and the 22-column CSV schema).
- Workflow F: QA result record I/O spec (per REQ-712).

### 4. Create `.tasks/005-pm-agent-system/artifacts/phase-7/phase-7-compatibility-verification-matrix.md`

Content:
- Frontmatter header: `document: phase-7-compatibility-verification-matrix`, `version: 1.0`, `phase: 7`, `date_created`.
- Preamble: purpose statement, three planning system definitions (with canonical file references for each).
- Matrix table:
  - **Rows** (six output types): VoC Record, Requirements Cascade Update, MoSCoW Backlog Entry, Sprint Plan Task, Diagram Artifact, Resource Ingestion Record.
  - **Columns** (three planning systems + verdict): `planner_updates/`, `.tasks/`, `learning_base/`, Overall Compatibility.
  - **Cell content**: verdict tag (Native / Transform Required / Not Applicable), specific field-mapping note, and blocking incompatibility if any.
- Transform operations register (new section): for each "Transform Required" cell, a named transform operation entry with: transform name, input format, output format, responsible agent, estimated effort (Low/Medium/High).
- Blocking incompatibilities register (new section): any cell verdict of incompatible or requiring unresolved design decisions — listed as items for Phase 8 pilot validation.
- Sign-off stub (per plan-only governance): `Reviewed by: ___ | Date: ___ | Status: Pending Review`.

### 5. Create `.tasks/005-pm-agent-system/artifacts/phase-7/phase-7-source-traceability-matrix.md`

Content:
- Standard source traceability matrix with columns: `rule`, `source doc`, `source clause`, `implementation note`, `verification evidence`.
- One row per REQ-7XX requirement, cross-referencing the mandatory source set listed above.
- Boundary check evidence row: confirming all Phase 7 write targets are within `.tasks/005-pm-agent-system/**`.

### 6. Update `.tasks/005-pm-agent-system/task.md`

- Update Phase 7 row status from `⬜ Not Started` to `📋 Planned`.
- Update Phase 7 Plan column to `[phase-7-workflow-contracts-planner-compatibility.md](plan/phase-7-workflow-contracts-planner-compatibility.md)`.

---

## Workflow Contract Schema Reference

The following schema is normalised from REQ-701 and must be applied to all six workflow contract sections in the Phase 7 deliverable:

```markdown
### Workflow {X}: {Workflow Name}

| Field | Value |
|-------|-------|
| Contract ID | WFC-{X} |
| Triggering Role(s) | {roles} |
| Trigger Phrase(s) | {phrases} |
| Receiving/Owning Agent | {agent} |
| Secondary Agents | {agents, if any} |
| Phase 5 Checkpoint Cross-references | {CP-X1, CP-X2, ...} — use `CP-A*/CP-F*` format only; `CP-5.x` plan-governance IDs must not appear here |
| Handoff Button Label | {label} |

#### Input Schema

| Input Type | Format | Required Metadata Fields | Pre-processing |
|------------|--------|--------------------------|----------------|
| ...        | ...    | ...                      | ...            |

#### Processing Expectation

{One paragraph: what the owning agent does (not how). Reference the applicable Phase 2 skill name.}

#### Output Schema

| Output Type | Format | Required Metadata Fields | Output Path Template |
|-------------|--------|--------------------------|----------------------|
| ...         | ...    | ...                      | ...                  |

#### Success Criteria

{Numbered list; observable, measurable outcomes.}

#### Failure / Escalation Path

{Decision fork: what triggers failure, who decides next action, escalation target if unresolvable.}
```

---

## Handoff Document Template Schema Reference

The following section headers are required in every instance of the standard handoff document template (REQ-704):

| Section | Required | Populated By |
|---------|----------|--------------|
| `## Header` | Yes | Sending agent |
| `## Context Summary` | Yes | Sending agent |
| `## Artifact Manifest` | Yes | Sending agent |
| `## Checkpoint Gate Reference` | Yes | Sending agent |
| `## Decision Gate` | Yes | Receiving agent or reviewer |
| `## Workflow Provenance` | Yes | Sending agent — **must persist as file record in `.tasks/` artifact** (not conversation-only; see REQ-706) |
| `## Receiving Agent Acknowledgement` | Yes | Receiving agent |

---

## Compatibility Verification Matrix: Design Reference

The following table structure defines the expected matrix layout for `phase-7-compatibility-verification-matrix.md`. Builder fills in verdict cells from the I/O format spec:

| Output Type | `planner_updates/` | `.tasks/` | `learning_base/` | Overall |
|-------------|-------------------|-----------|-----------------|---------|
| VoC Record | — | — | — | — |
| Requirements Cascade Update | — | — | — | — |
| MoSCoW Backlog Entry | — | — | — | — |
| Sprint Plan Task | — | — | — | — |
| Diagram Artifact | — | — | — | — |
| Resource Ingestion Record | — | — | — | — |

**Verdict key:**
- **Native** — output format is field-compatible with the target system without transformation.
- **Transform Required** — schema conversion is needed; transform operation must be named and agent assigned.
- **Not Applicable** — output type does not flow to this planning system.

---

## Verification

### Automated Checks (Plan-Only)

- Verify all five artifact files exist under `.tasks/005-pm-agent-system/artifacts/phase-7/`.
- Verify `task.md` Phase 7 row reflects `📋 Planned` and a valid plan link.
- Run file-existence check: `phase-7-workflow-contracts.md`, `phase-7-handoff-document-template.md`, `phase-7-io-format-spec.md`, `phase-7-compatibility-verification-matrix.md`, `phase-7-source-traceability-matrix.md` — all present.

### Manual Verification Steps

1. Open `phase-7-workflow-contracts.md` — confirm six workflow sections (A–F) each contain the Contract ID, Trigger Phrases, Input Schema table, Output Schema table, Phase-5 checkpoint cross-references, and failure path.
2. Open `phase-7-handoff-document-template.md` — confirm all seven required sections are present as template stubs, with `<!-- placeholder -->` markers; confirm Workflow Provenance section is present.
3. Open `phase-7-compatibility-verification-matrix.md` — confirm all 18 matrix cells (6 output types × 3 planning systems) have a verdict tag, a field-mapping note, and that any "Transform Required" cells have a corresponding entry in the transform operations register.
4. Open `phase-7-io-format-spec.md` — confirm Workflow E section contains an explicit column mapping table reflecting the verified column count N from `kickoff_tasks_ba_harrison.csv` (confirmed by Step 0 planning-time audit, not assumed as 22) and a column mapping confirming compatibility with `requirements_moscow_matrix_harrison.md` field names; confirm the preamble records the audited N and audit date.
5. Confirm no files outside `.tasks/005-pm-agent-system/` were created or modified.

### Success Criteria

- All six workflows have a complete, self-contained contract document section passing the REQ-701 schema.
- The handoff document template is a usable stub that any agent or Builder can populate without additional schema research.
- The compatibility verification matrix has zero blank cells — every cell has a verdict, with "Not Applicable" used explicitly rather than left empty.
- Workflow E output formats are confirmed compatible (Native or Transform Required with named transform) with both `planner_updates/requirements_moscow_matrix_harrison.md` and `planner_updates/kickoff_tasks_ba_harrison.csv` schemas.
- All Phase 7 artifacts are scoped to `.tasks/005-pm-agent-system/artifacts/phase-7/` — no external files created or modified.

---

## Tests

Phase 7 is plan-only and produces no executable code. However, the following schema-compliance checks constitute the equivalent of behavioral verification for the Builder executing this phase:

- **Workflow contract schema test**: All six WFC-* contracts include every field defined in the schema reference table (Contract ID through Failure/Escalation Path). Missing field = violation.
- **Handoff template section test**: All seven template sections listed in the "Handoff Document Template Schema Reference" table are present in the generated template. Missing section = violation.
- **Compatibility matrix completeness test**: 18 cells (6 × 3) all populated with a non-blank verdict. Any blank cell = violation.
- **Transform register coverage test**: Every "Transform Required" cell in the compatibility matrix has a corresponding row in the transform operations register. Orphaned transform verdict = violation.
- **Boundary check**: No write operations target paths outside `.tasks/005-pm-agent-system/`. Path outside `.tasks/` = violation.
- **Checkpoint naming consistency test**: All Phase 5 checkpoint cross-references in WFC-* contracts use `CP-A*/CP-F*` format. Any occurrence of a `CP-5.x` identifier in a workflow contract cross-reference field = violation.
- **Workflow Provenance persistence test**: Each completed handoff document artifact saved under `.tasks/005-pm-agent-system/artifacts/` includes a populated `## Workflow Provenance` section as a file record. A handoff with provenance data stored only in conversation context with no corresponding saved file = violation.
- **CSV schema audit evidence test**: `phase-7-compatibility-verification-matrix.md` and `phase-7-io-format-spec.md` preambles each contain a `kickoff_tasks_ba_harrison.csv verified column count: N (audited YYYY-MM-DD)` line. Missing audit record = violation.
