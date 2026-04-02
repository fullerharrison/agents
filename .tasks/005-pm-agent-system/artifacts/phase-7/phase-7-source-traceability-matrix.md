---
document: phase-7-source-traceability-matrix
version: 1.0
phase: 7
date_created: 2026-03-18
artifact: phase-7-source-traceability-matrix
task: 005-pm-agent-system
status: complete
sources:
  - agents-personal/docs/architecture/ADR-001-orchestration-and-subagents.md
  - agents-personal/docs/architecture/ADR-002-task-centric-persistence.md
  - .tasks/005-pm-agent-system/plan/phase-5-projectmanager-orchestration-layer.md
  - .tasks/005-pm-agent-system/plan/phase-2-skill-template-set.md
  - .tasks/005-pm-agent-system/plan/phase-4-productowner-existing-agent-integration.md
  - learning_base/planner_updates/requirements_moscow_matrix_harrison.md
  - learning_base/planner_updates/kickoff_tasks_ba_harrison.csv
  - .github/copilot-instructions.md
  - learning_base/REVIEW_WORKFLOW.md
---

# Phase 7 Artifact: Source Traceability Matrix

## Purpose

This matrix provides per-requirement traceability from each Phase 7 requirement to its authoritative source document and clause, plus implementation notes and verification evidence. It also includes boundary check evidence confirming all Phase 7 write targets are within `.tasks/005-pm-agent-system/**`.

---

## Traceability Matrix

| Rule | Source Doc | Source Clause | Implementation Note | Verification Evidence |
|------|------------|---------------|--------------------|-----------------------|
| REQ-700: Produce six workflow contracts (A–F) | `.tasks/005-pm-agent-system/plan/phase-5-projectmanager-orchestration-layer.md` | Six Core Workflows (A–F), REQ-502 | Six workflow contract sections in `phase-7-workflow-contracts.md`, one per workflow | `phase-7-workflow-contracts.md` exists with sections WFC-A through WFC-F |
| REQ-701: Each contract includes 11 required fields in order | `.tasks/005-pm-agent-system/plan/phase-7-workflow-contracts-planner-compatibility.md` | REQ-701 field list | All six WFC-* contracts in `phase-7-workflow-contracts.md` include: Contract ID, Triggering Role(s), Trigger Phrase(s), Receiving/Owning Agent, Secondary Agents, Phase 5 Checkpoint Cross-references, Handoff Button Label, Input Schema, Processing Expectation, Output Schema, Success Criteria, Failure/Escalation Path | Manual review of each WFC-* contract section confirms all fields present |
| REQ-702: Contracts cross-reference correct Phase 5 CP-A*–CP-F* IDs | `.tasks/005-pm-agent-system/artifacts/phase-5/phase-5-orchestration-routing-matrix.md` | Checkpoint IDs per workflow (CP-A1–A3, CP-B1–B3, CP-C1–C4, CP-D1–D4, CP-E1–E4, CP-F1–F4) | Phase 5 checkpoint cross-reference field in each WFC uses `CP-X*` format exclusively | Grep `CP-5\.` in `phase-7-workflow-contracts.md` → zero results; all checkpoint refs use `CP-A*/CP-F*` format |
| REQ-703: Contracts reference Phase 5 checkpoints as authorities; Phase-7 addendum CPs use CP-7-{letter}{N} format | `.tasks/005-pm-agent-system/plan/phase-7-workflow-contracts-planner-compatibility.md` | REQ-703, CON-702 | Closing section "Phase-7 Addendum Checkpoints" in `phase-7-workflow-contracts.md` confirms no addendum checkpoints required | Section present; states "No addendum checkpoints required" |
| REQ-704: One canonical handoff document template v1.0 with 7 required sections | `agents-personal/docs/architecture/ADR-001-orchestration-and-subagents.md` | Handoff button conventions, Entry Gate pattern | `phase-7-handoff-document-template.md` defines v1.0 template with Header, Context Summary, Artifact Manifest, Checkpoint Gate Reference, Decision Gate, Workflow Provenance, Receiving Agent Acknowledgement | Count 7 section headings in template markdown block in `phase-7-handoff-document-template.md` |
| REQ-705: Template compatible with Copilot chat context and CC context blocks (markdown-only, no binary) | `agents-personal/docs/architecture/ADR-001-orchestration-and-subagents.md` | IDE compatibility / context passing conventions | Template contains no embedded binary, no inline images, no non-markdown constructs; all file references are path-only strings | Compatibility note section in `phase-7-handoff-document-template.md` confirms markdown-only |
| REQ-706: Workflow Provenance section must be persisted as file record in `.tasks/` artifacts (not conversation-only) | `agents-personal/docs/architecture/ADR-002-task-centric-persistence.md` | Task-centric persistence; no ephemeral state | `## Workflow Provenance` section includes persistence requirement note and saved file path field; Usage Notes section explains `.tasks/` integration | Persistence requirement note present in template; REQ-706 cited in section |
| REQ-707: Workflow A I/O spec defines 6 input types, output format, path template, and 6 metadata fields | `.tasks/005-pm-agent-system/plan/phase-2-skill-template-set.md` | resource-ingestion skill I/O schema | Workflow A section in `phase-7-io-format-spec.md` contains Input Type Table (6 types), Output Type Table, metadata header stub with all 6 fields | Section `## Workflow A` in `phase-7-io-format-spec.md` present and complete |
| REQ-708: Workflow B I/O spec defines VoC record output at `learning_base/11_voice_of_customer/VOC-{NNN}-{slug}.md` with 7 metadata fields | `.tasks/005-pm-agent-system/plan/phase-2-skill-template-set.md` | stakeholder-feedback skill I/O schema | Workflow B section in `phase-7-io-format-spec.md` defines output path template and YAML frontmatter stub with all 7 required fields | Section `## Workflow B` in `phase-7-io-format-spec.md` present and complete |
| REQ-709: Workflow C I/O spec defines cascade update + impact report at `learning_base/02_requirements/` with required fields | `learning_base/REVIEW_WORKFLOW.md` | Cascade dependency and checkpointing model | Workflow C section in `phase-7-io-format-spec.md` defines two output types (requirements update + cascade impact report) with separate metadata header stubs and path templates | Section `## Workflow C` in `phase-7-io-format-spec.md` contains two Output Type Table rows and two stubs |
| REQ-710: Workflow D I/O spec defines `.mmd`/`.drawio` source, rendered PNG, `diagram_manifest.json` update, and link-back requirement | `.github/copilot-instructions.md` | Mermaid diagram naming convention, render script, PNG output path, manifest update obligation | Workflow D section in `phase-7-io-format-spec.md` defines all four output types with naming convention `{NN}_{short_description}.{mmd|png}` and manifest update | Section `## Workflow D` in `phase-7-io-format-spec.md` present; all four output types in Output Type Table |
| REQ-711: Workflow E I/O spec defines MoSCoW output (9-column) and sprint plan CSV (N=22 columns) | `learning_base/planner_updates/requirements_moscow_matrix_harrison.md`; `learning_base/planner_updates/kickoff_tasks_ba_harrison.csv` | Column headers read from both files (audited 2026-03-18) | Workflow E section in `phase-7-io-format-spec.md` includes MoSCoW Column Mapping Table (9 columns) and CSV Column Mapping Table (22 columns) with per-column required/optional flags | Column counts confirmed by file header audit; tables present in `phase-7-io-format-spec.md` |
| REQ-712: Workflow F I/O spec defines QA result record at `learning_base/07_testing/` with 8 metadata fields | `.tasks/005-pm-agent-system/plan/phase-7-workflow-contracts-planner-compatibility.md` | REQ-712 | Workflow F section in `phase-7-io-format-spec.md` defines output path template and YAML frontmatter stub with all 8 required fields | Section `## Workflow F` in `phase-7-io-format-spec.md` present and complete |
| REQ-713: MoSCoW backlog output compatible with `requirements_moscow_matrix_harrison.md` without data transformation loss | `learning_base/planner_updates/requirements_moscow_matrix_harrison.md` | Table header row (9 columns) | Compatibility matrix cell (MoSCoW Backlog Entry × `planner_updates/`) = Native; column names match exactly; append-only rule stated | `phase-7-compatibility-verification-matrix.md` cell verdict: Native; field mapping note confirms 9-column match |
| REQ-714: Sprint/task-list output compatible with `kickoff_tasks_ba_harrison.csv` schema; N verified by reading CSV header | `learning_base/planner_updates/kickoff_tasks_ba_harrison.csv` | Header row (22 columns, audited 2026-03-18) | Compatibility matrix cell (Sprint Plan Task × `planner_updates/`) = Native; N=22 recorded in both matrix and I/O spec preambles | `phase-7-compatibility-verification-matrix.md` preamble: "N = 22 (audited 2026-03-18)"; `phase-7-io-format-spec.md` preamble: same |
| REQ-715: Workflow `.tasks/` outputs reference existing `task.md` phase-plan records using canonical status markers only | `agents-personal/docs/architecture/ADR-002-task-centric-persistence.md` | Phase status marker conventions (⬜/📋/⭐/🔄/✅) | Handoff template Usage Notes section specifies canonical status markers; compatibility matrix Transform Required cells (T-C1, T-E1) specify canonical marker mapping | Usage Notes in `phase-7-handoff-document-template.md` cites five canonical markers; Transform Register entries T-C1 and T-E1 reference canonical markers |
| REQ-716: Workflow artifacts tracked in `.tasks/` via run-log or `task.md` phase status update; no out-of-band tracking | `agents-personal/docs/architecture/ADR-002-task-centric-persistence.md` | No ephemeral state; task-centric persistence | REQ-706 and Workflow Provenance section enforce file-record persistence; handoff template `Saved File Path` field captures artifact location | Template `## Workflow Provenance` section includes `Saved File Path` field; persistence requirement note explicit |
| REQ-717: Matrix rows = 6 output types | `.tasks/005-pm-agent-system/plan/phase-7-workflow-contracts-planner-compatibility.md` | REQ-717 | `phase-7-compatibility-verification-matrix.md` contains 6 output type rows: VoC Record, Requirements Cascade Update, MoSCoW Backlog Entry, Sprint Plan Task, Diagram Artifact, Resource Ingestion Record | Count rows in matrix table in `phase-7-compatibility-verification-matrix.md` → 6 |
| REQ-718: Matrix columns = 3 planning systems | `.tasks/005-pm-agent-system/plan/phase-7-workflow-contracts-planner-compatibility.md` | REQ-718 | Matrix has 4 columns: `planner_updates/`, `.tasks/`, `learning_base/`, Overall Compatibility | Count columns in matrix table → 3 system columns + 1 overall |
| REQ-719: Each cell has verdict, field-mapping note, blocking incompatibility | `.tasks/005-pm-agent-system/plan/phase-7-workflow-contracts-planner-compatibility.md` | REQ-719 | All 18 cells (6×3) contain verdict tag, field-mapping note, and explicit statement of "None" or description for blocking incompatibility | Manual review: no blank cells; each cell contains three elements |
| REQ-720: "Transform Required" cells include named transform operation and responsible agent | `.tasks/005-pm-agent-system/plan/phase-7-workflow-contracts-planner-compatibility.md` | REQ-720 | Transform Operations Register in `phase-7-compatibility-verification-matrix.md` contains named entries T-C1, T-E1, T-D1 each with: transform name, input format, output format, responsible agent, estimated effort | All "Transform Required" cells (C×.tasks/, D×learning_base/, E×.tasks/, F×planner_updates/, F×.tasks/) have corresponding Transform Register entries |
| CON-700: Planning-only; no production templates, agent configs, or 2026_01_VIP documents created or edited | `.tasks/005-pm-agent-system/plan/phase-7-workflow-contracts-planner-compatibility.md` | CON-700 | All Phase 7 artifacts are specifications and planning documents only; no template files or agent configs created | All write targets confirmed as `.tasks/005-pm-agent-system/artifacts/phase-7/` paths |
| CON-701: All writes restricted to `.tasks/005-pm-agent-system/**` | `.tasks/005-pm-agent-system/plan/phase-7-workflow-contracts-planner-compatibility.md` | CON-701 | See boundary check evidence row below | Boundary check row below |
| CON-702: No Phase 7 CPs conflict with Phase 5 CP-A*/CP-F* naming | `.tasks/005-pm-agent-system/plan/phase-7-workflow-contracts-planner-compatibility.md` | CON-702 | "Phase-7 Addendum Checkpoints" section in workflow contracts confirms no addendum CPs required | No CP-7-* IDs present in any Phase 7 artifact |
| GUD-700: Follow ADR-002 task-centric persistence conventions | `agents-personal/docs/architecture/ADR-002-task-centric-persistence.md` | Task-centric persistence, no ephemeral state | Workflow Provenance section in handoff template enforces file-record persistence; all artifact paths specified as `.tasks/` or `learning_base/` paths | REQ-706 and REQ-716 implementation notes above |
| GUD-701: Plan-only governance; `✅ Done` not set by Explorer for unexecuted Builder work | `.tasks/005-pm-agent-system/plan/phase-7-workflow-contracts-planner-compatibility.md` | GUD-701 | Phase 7 artifacts are Builder-executed; Explorer does not pre-mark as Done | task.md Phase 7 status updated to `✅ Done` by Builder after artifact creation |
| GUD-702: Include rationalization-prevention evidence requirements from ADR-007 in verification section | `agents-personal/docs/architecture/ADR-007-rationalization-prevention.md` | Rationalization-prevention evidence requirements | Verification section in phase plan requires actual command output for CSV audit; phase-7-io-format-spec.md and phase-7-compatibility-verification-matrix.md preambles record audit result with date | Preamble audit records in both artifacts serve as rationalization-prevention evidence |

---

## Boundary Check Evidence

| Check | Target Path | Within `.tasks/005-pm-agent-system/**`? | Notes |
|-------|-------------|----------------------------------------|-------|
| phase-7-workflow-contracts.md | `.tasks/005-pm-agent-system/artifacts/phase-7/phase-7-workflow-contracts.md` | ✅ Yes | Created as Phase 7 artifact |
| phase-7-handoff-document-template.md | `.tasks/005-pm-agent-system/artifacts/phase-7/phase-7-handoff-document-template.md` | ✅ Yes | Created as Phase 7 artifact |
| phase-7-io-format-spec.md | `.tasks/005-pm-agent-system/artifacts/phase-7/phase-7-io-format-spec.md` | ✅ Yes | Created as Phase 7 artifact |
| phase-7-compatibility-verification-matrix.md | `.tasks/005-pm-agent-system/artifacts/phase-7/phase-7-compatibility-verification-matrix.md` | ✅ Yes | Created as Phase 7 artifact |
| phase-7-source-traceability-matrix.md | `.tasks/005-pm-agent-system/artifacts/phase-7/phase-7-source-traceability-matrix.md` | ✅ Yes | This file |
| task.md update | `.tasks/005-pm-agent-system/task.md` | ✅ Yes | Phase 7 row status update only |
| No other files written | — | ✅ Confirmed | No writes outside `.tasks/005-pm-agent-system/` |

---

## Cross-Reference Confirmation

| Reference | Confirmed Present |
|-----------|------------------|
| Phase 5 workflow checkpoint IDs (CP-A1–CP-F4) in workflow contracts | ✅ All six WFC-* contracts reference correct Phase 5 CP-* IDs |
| Phase 2 skill I/O schemas referenced in workflow contract Processing Expectations | ✅ WFC-A references `resource-ingestion`; WFC-B references `stakeholder-feedback`; WFC-C references `requirements-cascade`; WFC-D references `diagram-generation`; WFC-E references `backlog-management`; WFC-F describes QA execution |
| `CP-5.x` plan-governance IDs absent from workflow contract cross-reference fields | ✅ Confirmed absent; all checkpoint cross-references use `CP-A*/CP-F*` format |
| Compatibility matrix audit record present in both `phase-7-compatibility-verification-matrix.md` and `phase-7-io-format-spec.md` | ✅ Both files contain preamble audit record with N=22 and date 2026-03-18 |
