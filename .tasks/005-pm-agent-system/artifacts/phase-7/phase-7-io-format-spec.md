---
document: phase-7-io-format-spec
version: 1.0
phase: 7
date_created: 2026-03-18
artifact: phase-7-io-format-spec
task: 005-pm-agent-system
workflows_covered: [A, B, C, D, E, F]
status: complete
sources:
  - .tasks/005-pm-agent-system/artifacts/phase-2/phase-2-skill-contracts.md
  - learning_base/planner_updates/requirements_moscow_matrix_harrison.md
  - learning_base/planner_updates/kickoff_tasks_ba_harrison.csv
  - .github/copilot-instructions.md
  - learning_base/REVIEW_WORKFLOW.md
---

# Phase 7 Artifact: Input/Output Format Specification

## Preamble

> **CSV Schema Audit Record (Step 0 — Planning-Time Verification):**
> `kickoff_tasks_ba_harrison.csv` verified column count: **N = 22** (audited 2026-03-18)
>
> Verified columns (in order):
> `Task number`, `Outline number`, `Name`, `Assigned to`, `Start`, `Finish`, `Duration`, `Bucket`, `% complete`, `Priority`, `Labels`, `Depends on`, `Dependents`, `Effort`, `Effort completed`, `Effort remaining`, `Milestone`, `Notes`, `Completed`, `Checklist Items`, `Sprint`, `Goal`
>
> **MoSCoW Matrix Column Audit:**
> `requirements_moscow_matrix_harrison.md` verified columns: `Req ID`, `Category`, `Requirement Name`, `Description`, `MoSCoW`, `BRD Section`, `SME Clarif. Needed`, `Dependencies`, `Acceptance Criteria` (9 columns, audited 2026-03-18)
>
> All Phase 7 artifacts use N = 22 as the canonical CSV column count. This value was read directly from the file header and is not assumed or hard-coded.

---

## Purpose

This document specifies the input and output format requirements for each of the six core workflows (A–F) in the 2026_01_VIP PM agent system. Each section defines the input type table, output type table, required metadata fields, file format, save-path template, naming convention, compatibility tag, and a metadata header stub for the produced artifact.

**Compatibility Tag Legend:**
- **Native** — output is field-compatible with the target planning system without transformation.
- **Transform Required** — schema conversion is needed; named transform and responsible agent identified.
- **Not Applicable** — output does not flow to this planning system.

---

## Workflow A: Resource Ingestion

### Input Type Table

| Input Type | File Format | Required Metadata Fields | Pre-processing Required | Pre-processing Agent |
|------------|-------------|--------------------------|------------------------|----------------------|
| Email | `.eml` or plain text | subject, sender, date, source | Yes (binary → markdown) | Worker |
| Document | `.docx`, `.pdf` | title, author, date, source | Yes (binary → markdown) | Worker |
| Web link | URL string | url, accessed_date, title | No (ProductOwner fetches) | — |
| Meeting notes | `.md` or plain text | meeting_date, attendees, source | No | — |
| Chat extract | Plain text | source_platform, date, participants | No | — |
| Raw markdown resource | `.md` | title, date, source | No | — |

### Output Type Table

| Output Type | File Format | Required Metadata Fields | Output Path Template | Naming Convention |
|-------------|-------------|--------------------------|----------------------|-------------------|
| Ingestion record | Markdown (`.md`) | title, date, source, classification, tags, ingested_by | `learning_base/{classification-subdir}/{YYYY-MM-DD}_{slug}.md` | `{YYYY-MM-DD}_{descriptive-slug}.md` |

### Compatibility Tag

| Planning System | Tag |
|-----------------|-----|
| `planner_updates/` | Not Applicable |
| `.tasks/` | Not Applicable |
| `learning_base/` | **Native** |

### Metadata Header Stub

```yaml
---
title: <!-- Resource title or descriptive name -->
date: <!-- YYYY-MM-DD -->
source: <!-- Original source URI, file path, or sender -->
classification: <!-- learning_base subdirectory category -->
tags: [<!-- tag1 -->, <!-- tag2 -->]
ingested_by: <!-- agent role: ProductOwner | Worker -->
---
```

---

## Workflow B: Stakeholder Feedback (VoC Record)

### Input Type Table

| Input Type | File Format | Required Metadata Fields | Pre-processing Required | Pre-processing Agent |
|------------|-------------|--------------------------|------------------------|----------------------|
| Stakeholder interview notes | `.md` or plain text | stakeholder_name, date, session_type | No | — |
| Email transcript | `.eml` or plain text | sender, date, subject | Yes if `.eml` | Worker |
| Meeting summary | `.md` | meeting_date, attendees, agenda_items | No | — |
| Survey response | Plain text or `.md` | respondent_role, date, survey_name | No | — |

### Output Type Table

| Output Type | File Format | Required Metadata Fields | Output Path Template | Naming Convention |
|-------------|-------------|--------------------------|----------------------|-------------------|
| VoC record | Markdown (`.md`) | stakeholder, date, session_type, guardrail_mappings, feature_requests, open_questions, status | `learning_base/11_voice_of_customer/VOC-{NNN}-{stakeholder_slug}.md` | `VOC-{NNN}-{stakeholder-slug}.md` (NNN: zero-padded sequence) |

### Compatibility Tag

| Planning System | Tag |
|-----------------|-----|
| `planner_updates/` | Not Applicable |
| `.tasks/` | Not Applicable |
| `learning_base/` | **Native** |

### Metadata Header Stub

```yaml
---
title: VoC Record — <!-- Stakeholder Name -->
stakeholder: <!-- Stakeholder full name or role -->
date: <!-- YYYY-MM-DD -->
session_type: <!-- interview | email | meeting | survey -->
guardrail_mappings:
  - req_id: <!-- REQ-NNN -->
    guardrail: <!-- constraint or boundary description -->
feature_requests:
  - <!-- feature request description -->
open_questions:
  - <!-- open question text -->
status: <!-- draft | reviewed | actioned -->
---
```

---

## Workflow C: Requirements Cascade

### Input Type Table

| Input Type | File Format | Required Metadata Fields | Pre-processing Required | Pre-processing Agent |
|------------|-------------|--------------------------|------------------------|----------------------|
| VoC record | `.md` | stakeholder, date, feature_requests, guardrail_mappings | No | — |
| Change request | `.md` | req_id, change_description, requestor, date | No | — |
| Requirements document | `.md` | req_id, version, section_references | No | — |

### Output Type Table

| Output Type | File Format | Required Metadata Fields | Output Path Template | Naming Convention |
|-------------|-------------|--------------------------|----------------------|-------------------|
| Requirements update | Markdown (`.md`) | req_id, version, changed_sections, updated_by, date | `learning_base/02_requirements/{existing-doc-name}.md` | Preserves existing document name; version bump in frontmatter |
| Cascade impact report | Markdown (`.md`) | changed_req_id, impacted_docs, impacted_sections, action_required, assigned_to, status | `learning_base/02_requirements/cascade_impact_{YYYY-MM-DD}.md` | `cascade_impact_{YYYY-MM-DD}.md` |

### Compatibility Tag

| Planning System | Tag |
|-----------------|-----|
| `planner_updates/` | Not Applicable |
| `.tasks/` | **Transform Required** — cascade impact report may require a `.tasks/` phase status update if impacts span a tracked planning task; transform: extract `action_required` items into `.tasks/{slug}/task.md` phase notes; responsible agent: ProjectManager |
| `learning_base/` | **Native** |

### Metadata Header Stub — Requirements Update

```yaml
---
title: <!-- Document title -->
req_id: <!-- REQ-NNN (primary changed requirement) -->
version: <!-- e.g., 2.2 -->
changed_sections:
  - <!-- section heading or ID -->
updated_by: <!-- BusinessAnalyst -->
date: <!-- YYYY-MM-DD -->
cascade_triggered_by: <!-- VoC record path or change request ID -->
---
```

### Metadata Header Stub — Cascade Impact Report

```yaml
---
title: Cascade Impact Report <!-- YYYY-MM-DD -->
changed_req_id: <!-- REQ-NNN -->
impacted_docs:
  - path: <!-- learning_base/... -->
    impacted_sections: <!-- section name or ID -->
action_required: <!-- update | review | defer | no-action -->
assigned_to: <!-- agent role -->
status: <!-- open | in-progress | closed -->
date: <!-- YYYY-MM-DD -->
---
```

---

## Workflow D: Diagram Lifecycle

### Input Type Table

| Input Type | File Format | Required Metadata Fields | Pre-processing Required | Pre-processing Agent |
|------------|-------------|--------------------------|------------------------|----------------------|
| Diagram source (Mermaid) | `.mmd` | diagram_id, title, owning_doc, author, date | No | — |
| Diagram source (draw.io) | `.drawio` | diagram_id, title, owning_doc, author, date | No | — |
| Diagram update request | `.md` or plain text | diagram_id, requested_change, requestor, date | No | — |

### Output Type Table

| Output Type | File Format | Required Metadata Fields | Output Path Template | Naming Convention |
|-------------|-------------|--------------------------|----------------------|-------------------|
| Diagram source | `.mmd` or `.drawio` | diagram_id, title, version, owning_doc | `images/diagrams/{NN}_{short_description}.mmd` | `{NN}_{short_description}.{mmd\|drawio}` per `.github/copilot-instructions.md` |
| Rendered PNG | `.png` | diagram_id, title, generated_date | `images/diagrams/{NN}_{short_description}.png` | Mirrors source file name with `.png` extension |
| Manifest update | `.json` | diagram_id, source_path, png_path, owning_doc, last_updated | `images/diagrams/diagram_manifest.json` | Fixed filename; updated in-place |
| Documentation link-back | Markdown image reference (inline) | diagram_id, alt_text | Injected into `{owning_doc}` | `![{alt_text}](images/diagrams/{NN}_{short_description}.png)` |

### Compatibility Tag

| Planning System | Tag |
|-----------------|-----|
| `planner_updates/` | Not Applicable |
| `.tasks/` | Not Applicable |
| `learning_base/` | **Transform Required** — diagram artifacts are stored in `images/diagrams/`, not `learning_base/`; documentation link-back bridges the two; transform: inject markdown image reference into owning `learning_base/` or `docs/` document; responsible agent: UIUXDesigner |

### Metadata Header Stub — Diagram Source

```yaml
---
diagram_id: <!-- NN_short_description -->
title: <!-- Human-readable diagram title -->
version: <!-- e.g., 1.0 -->
owning_doc: <!-- path to documentation file that embeds this diagram -->
author: <!-- UIUXDesigner -->
date: <!-- YYYY-MM-DD -->
---
```

---

## Workflow E: Backlog Planning

### Input Type Table

| Input Type | File Format | Required Metadata Fields | Pre-processing Required | Pre-processing Agent |
|------------|-------------|--------------------------|------------------------|----------------------|
| Backlog items list | `.md` or plain text | req_id, requirement_name, category, description | No | — |
| Existing MoSCoW matrix | `.md` | version, sprint, req_id column | No | — |
| Requirements document | `.md` | req_id, section_references | No | — |

### Output Type Table

| Output Type | File Format | Required Metadata Fields | Output Path Template | Naming Convention |
|-------------|-------------|--------------------------|----------------------|-------------------|
| MoSCoW backlog matrix | Markdown table in `.md` | See MoSCoW Column Mapping Table below | `learning_base/planner_updates/requirements_moscow_matrix_{slug}.md` | `requirements_moscow_matrix_{sprint-or-date}.md` |
| Sprint plan task list | CSV (`.csv`) | See CSV Column Mapping Table below | `learning_base/planner_updates/sprint_{NN}_{slug}.csv` | `sprint_{NN}_{slug}.csv` |

### Compatibility Tag

| Planning System | Tag |
|-----------------|-----|
| `planner_updates/` | **Native** — MoSCoW markdown column schema matches `requirements_moscow_matrix_harrison.md`; CSV column schema matches `kickoff_tasks_ba_harrison.csv` exactly (N = 22 verified) |
| `.tasks/` | **Transform Required** — sprint task items that correspond to `.tasks/` phase milestones require a phase status update in `task.md`; transform: map sprint task name and status to `.tasks/{slug}/task.md` phase row using canonical status markers; responsible agent: ProjectManager |
| `learning_base/` | **Native** — MoSCoW matrix documents routed to `learning_base/planner_updates/` |

### MoSCoW Column Mapping Table

The MoSCoW backlog matrix output must use the following 9 columns in this exact order, matching the `requirements_moscow_matrix_harrison.md` canonical schema:

| # | Column Name | Source / Notes |
|---|-------------|----------------|
| 1 | `Req ID` | Requirement identifier (REQ-NNN format) |
| 2 | `Category` | Functional / Non-Functional / Constraint |
| 3 | `Requirement Name` | Short descriptive name |
| 4 | `Description` | Full requirement description |
| 5 | `MoSCoW` | Must Have / Should Have / Could Have / Won't Have |
| 6 | `BRD Section` | Section reference in the BRD |
| 7 | `SME Clarif. Needed` | Yes / No |
| 8 | `Dependencies` | Comma-separated REQ-IDs or "None" |
| 9 | `Acceptance Criteria` | Observable, verifiable condition |

> Append-only rule: New columns may only be appended after column 9. Existing column names must not be renamed or reordered.

### Sprint Plan CSV Column Mapping Table

> **Verified column count: N = 22** (audited 2026-03-18 from `kickoff_tasks_ba_harrison.csv` header row)

The sprint plan task list CSV must include all 22 columns in this exact order. Use empty string (`""`) for optional unused columns.

| # | Column Name | Required / Optional | Notes |
|---|-------------|--------------------|----|
| 1 | `Task number` | Required | Sequential integer |
| 2 | `Outline number` | Required | Hierarchical outline (e.g., 1.1, 1.2) |
| 3 | `Name` | Required | Task name |
| 4 | `Assigned to` | Required | Agent role or person name |
| 5 | `Start` | Required | YYYY-MM-DD |
| 6 | `Finish` | Required | YYYY-MM-DD |
| 7 | `Duration` | Required | e.g., "3 days" |
| 8 | `Bucket` | Optional | Planner bucket label |
| 9 | `% complete` | Required | 0–100 |
| 10 | `Priority` | Required | Low / Medium / High / Urgent |
| 11 | `Labels` | Optional | Comma-separated labels |
| 12 | `Depends on` | Optional | Task number(s) this task depends on |
| 13 | `Dependents` | Optional | Task number(s) depending on this task |
| 14 | `Effort` | Optional | Hours or story points |
| 15 | `Effort completed` | Optional | Numeric |
| 16 | `Effort remaining` | Optional | Numeric |
| 17 | `Milestone` | Optional | Milestone name or empty |
| 18 | `Notes` | Optional | Free text |
| 19 | `Completed` | Required | Yes / No |
| 20 | `Checklist Items` | Optional | Semicolon-separated checklist items |
| 21 | `Sprint` | Required | Sprint identifier (e.g., Sprint 1) |
| 22 | `Goal` | Optional | Sprint goal text |

### Metadata Header Stub — MoSCoW Matrix Document

```yaml
---
title: HTP-VIP — Requirements MoSCoW Matrix <!-- Sprint or Date -->
version: <!-- e.g., 1.1 -->
date: <!-- YYYY-MM-DD -->
sprint: <!-- Sprint N or Kick-off -->
goal: <!-- Sprint goal -->
prepared_by: <!-- ProductOwner -->
brd_reference: <!-- path to BRD document -->
---
```

---

## Workflow F: Quality Gate Review Loop

### Input Type Table

| Input Type | File Format | Required Metadata Fields | Pre-processing Required | Pre-processing Agent |
|------------|-------------|--------------------------|------------------------|----------------------|
| Sprint task item | `.md` or reference ID | task_id, sprint, acceptance_criteria, assigned_to | No | — |
| Acceptance criteria | Embedded in task `.md` | criteria_id, description, verifiable_condition | No | — |
| Test execution results | Plain text or `.md` | task_id, test_run_date, results_summary | No | — |

### Output Type Table

| Output Type | File Format | Required Metadata Fields | Output Path Template | Naming Convention |
|-------------|-------------|--------------------------|----------------------|-------------------|
| QA result record | Markdown (`.md`) | task_id, sprint, criteria_tested, pass_fail, blockers, rework_items, decision, decided_by | `learning_base/07_testing/qa_result_{task_id}_{YYYY-MM-DD}.md` | `qa_result_{task-id}_{YYYY-MM-DD}.md` |

### Compatibility Tag

| Planning System | Tag |
|-----------------|-----|
| `planner_updates/` | **Transform Required** — QA PASS outcome requires sprint task CSV status update (`% complete` → 100, `Completed` → Yes); transform: locate task row in sprint CSV by `Task number` or `Name`, update `% complete` and `Completed` columns; responsible agent: ScrumMaster (on ProjectManager instruction) |
| `.tasks/` | **Transform Required** — QA PASS/FAIL outcome may require `.tasks/` phase status update if the sprint task maps to a tracked planning phase; transform: update relevant `task.md` phase row status using canonical markers; responsible agent: ProjectManager |
| `learning_base/` | **Native** — QA result records routed to `learning_base/07_testing/` |

### Metadata Header Stub

```yaml
---
title: QA Result Record — <!-- task_id --> — <!-- YYYY-MM-DD -->
task_id: <!-- Sprint task number or name slug -->
sprint: <!-- Sprint identifier -->
criteria_tested:
  - criteria_id: <!-- ID or short name -->
    description: <!-- Acceptance criteria text -->
pass_fail: <!-- PASS | FAIL -->
blockers:
  - <!-- blocker description or "None" -->
rework_items:
  - <!-- rework description or "None" -->
decision: <!-- Done | Rework Required | Blocked -->
decided_by: <!-- QAEngineer -->
date: <!-- YYYY-MM-DD -->
---
```
