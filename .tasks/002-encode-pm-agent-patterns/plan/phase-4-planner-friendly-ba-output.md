---
phase: 4
title: Planner-Friendly BA Output
template_files:
  - templates/agents/business-analyst.template.md
root_causes: RC-004 (FORMAT-CONTRACT)
adr: docs/architecture/ADR-008-pm-agent-coordination-patterns.md § "WS-004: Planner Output Schema"
created: 2026-03-26
---

# Phase 4: Planner-Friendly BA Output

## Objective

Add a `## Teams Planner Output` section to `business-analyst.template.md` so that every
work item produced in a sprint-planning, backlog-grooming, or task-breakdown context
emits a structured `PLANNER-OUTPUT` block whose fields map directly to the Microsoft Teams
Planner import schema.

**Root cause addressed:** RC-004 FORMAT-CONTRACT — BA output schema not matching Planner
import structure (ADR-008 §WS-004: Planner Output Schema).

**Constraint:** All changes are additive. No existing content is removed.

---

## PLANNER-OUTPUT Schema (BAS-SCHEMA-003 alignment)

> **Note:** ADR-008 labels this as BAS-SCHEMA-003. Task-001 research used BAS-SCHEMA-003 for PM recommendations; the PLANNER-OUTPUT field set below is authoritative.

The schema below is the normalized output block defined for this fix. It maps to the
five mandatory fields in the Microsoft Teams Planner task import surface:

```
PLANNER-OUTPUT:
  task_title:  <required: concise action-oriented title — recommended max 60 chars for readability (Planner limit is 255 chars)>
  bucket:      <required: Sprint name, Epic name, or delivery phase — e.g. "MVP", "Phase 2", "Sprint 3">
  assigned_to: <required: role or named person — e.g. "Field Operator", "Trial Manager">
  due_date:    <required: ISO 8601 date — e.g. "2026-04-15"; derive from roadmap if known, else "TBD">
  notes:       <required: one-paragraph summary of acceptance criteria and key dependencies>
  priority:    <optional: Urgent | Important | Medium | Low>
  labels:      <optional: list — e.g. ["backend", "offline", "SPIRIT-integration"]>
```

**Mandatory fields:** `task_title`, `bucket`, `assigned_to`, `due_date`, `notes` — all five
must be present in every emitted block. If any mandatory field cannot be determined from
context, use `"TBD"` and record the unfilled dependency in `notes`.

Emit `PLANNER-OUTPUT` only for discrete work items (user stories, tasks, enablers) that
map to a single Planner row. Do NOT emit it for document-level artefacts (PRDs, specs,
architecture blueprints), which have no direct Planner task representation.

---

## Change BA-4: Insert `## Teams Planner Output` Section

### Insertion Point

The new section is inserted **immediately after** the INGESTION-DECISION guard added by
Phase 3 (the `Do NOT trigger downstream handoffs...` line) and **immediately before** the
`<!-- COPILOT-ONLY -->` marker.

This location:
- Keeps Planner output logically adjacent to the Save Artefacts workflow step
- Remains platform-agnostic (outside both `COPILOT-ONLY` and `CC-ONLY` blocks)
- Preserves all existing content — pure insertion

**Locate this exact text** (lines 166–169 of the current template):

```
Do NOT trigger downstream handoffs (Plan Sprint, Save Work) when `status: blocked`. Emit
the block and surface it to the user before any further action.

<!-- COPILOT-ONLY -->
```

**Insert the following block between them** (no existing text removed):

```markdown

## Teams Planner Output

When producing work items in a sprint-planning, backlog-grooming, or task-breakdown
context, each discrete work item MUST be followed by a `PLANNER-OUTPUT` block. This aligns
BA artefacts with the Microsoft Teams Planner import schema and resolves RC-004
FORMAT-CONTRACT.

### Qualification Signals

Emit `PLANNER-OUTPUT` blocks when the user context contains any of the following:

| Signal category | Qualifying keywords / phrases |
|----------------|-------------------------------|
| Sprint planning | "sprint", "sprint planning", "capacity", "velocity", "sprint backlog" |
| Backlog grooming | "backlog grooming", "backlog refinement", "prioritise backlog", "rank backlog" |
| Task breakdown | "break down", "task breakdown", "user stories", "create tasks", "decompose" |

### No-Op Condition

When context is purely requirements documentation — writing or updating PRDs, specs,
architecture blueprints, or BRDs — with **no** sprint or planning intent explicitly stated,
suppress all `PLANNER-OUTPUT` blocks and it is **recommended** to emit:

~~~
PLANNER-OUTPUT: skipped — requirements-documentation context; no planning intent detected.
~~~

Absence of a `PLANNER-OUTPUT` block is a valid outcome, not a failure state.

**Precedence:** if qualifying planning signals AND requirements-documentation context both exist, planning intent takes precedence — emit PLANNER-OUTPUT blocks.

### PLANNER-OUTPUT Block Schema

Each qualifying work item must include the following immediately after its description:

~~~
PLANNER-OUTPUT:
  task_title:  <required: concise action-oriented title — recommended max 60 chars for readability (Planner limit is 255 chars)>
  bucket:      <required: Sprint name, Epic name, or delivery phase — e.g. "MVP", "Phase 2", "Sprint 3">
  assigned_to: <required: role or named person — e.g. "Field Operator", "Trial Manager">
  due_date:    <required: ISO 8601 date — e.g. "2026-04-15"; derive from roadmap if known, else "TBD">
  notes:       <required: one-paragraph summary of acceptance criteria and key dependencies>
  priority:    <optional: Urgent | Important | Medium | Low>
  labels:      <optional: list — e.g. ["backend", "offline", "SPIRIT-integration"]>
~~~

**Mandatory fields:** `task_title`, `bucket`, `assigned_to`, `due_date`, `notes`. All five
must be present in every emitted block. Use `"TBD"` for any mandatory field that cannot
be derived from context, and record the missing information in `notes`.

Do NOT emit `PLANNER-OUTPUT` blocks for document-level artefacts (PRDs, specs,
architecture blueprints) — only for individual work items that map to a discrete Planner
task row.
```

**Resulting section context after insertion:**

```
Do NOT trigger downstream handoffs (Plan Sprint, Save Work) when `status: blocked`. Emit
the block and surface it to the user before any further action.

## Teams Planner Output

When producing work items in a sprint-planning, backlog-grooming, or task-breakdown
context, each discrete work item MUST be followed by a `PLANNER-OUTPUT` block. This aligns
BA artefacts with the Microsoft Teams Planner import schema and resolves RC-004
FORMAT-CONTRACT.

### Qualification Signals

Emit `PLANNER-OUTPUT` blocks when the user context contains any of the following:

| Signal category | Qualifying keywords / phrases |
|----------------|-------------------------------|
| Sprint planning | "sprint", "sprint planning", "capacity", "velocity", "sprint backlog" |
| Backlog grooming | "backlog grooming", "backlog refinement", "prioritise backlog", "rank backlog" |
| Task breakdown | "break down", "task breakdown", "user stories", "create tasks", "decompose" |

### No-Op Condition

When context is purely requirements documentation — writing or updating PRDs, specs,
architecture blueprints, or BRDs — with **no** sprint or planning intent explicitly stated,
suppress all `PLANNER-OUTPUT` blocks and it is **recommended** to emit:

~~~
PLANNER-OUTPUT: skipped — requirements-documentation context; no planning intent detected.
~~~

Absence of a `PLANNER-OUTPUT` block is a valid outcome, not a failure state.

**Precedence:** if qualifying planning signals AND requirements-documentation context both exist, planning intent takes precedence — emit PLANNER-OUTPUT blocks.

### PLANNER-OUTPUT Block Schema

Each qualifying work item must include the following immediately after its description:

~~~
PLANNER-OUTPUT:
  task_title:  <required: concise action-oriented title — recommended max 60 chars for readability (Planner limit is 255 chars)>
  bucket:      <required: Sprint name, Epic name, or delivery phase — e.g. "MVP", "Phase 2", "Sprint 3">
  assigned_to: <required: role or named person — e.g. "Field Operator", "Trial Manager">
  due_date:    <required: ISO 8601 date — e.g. "2026-04-15"; derive from roadmap if known, else "TBD">
  notes:       <required: one-paragraph summary of acceptance criteria and key dependencies>
  priority:    <optional: Urgent | Important | Medium | Low>
  labels:      <optional: list — e.g. ["backend", "offline", "SPIRIT-integration"]>
~~~

**Mandatory fields:** `task_title`, `bucket`, `assigned_to`, `due_date`, `notes`. All five
must be present in every emitted block. Use `"TBD"` for any mandatory field that cannot
be derived from context, and record the missing information in `notes`.

Do NOT emit `PLANNER-OUTPUT` blocks for document-level artefacts (PRDs, specs,
architecture blueprints) — only for individual work items that map to a discrete Planner
task row.

<!-- COPILOT-ONLY -->
```

---

## Summary of Changes

| ID | File | Insertion Point | Change Type |
|----|------|----------------|-------------|
| BA-4 | `templates/agents/business-analyst.template.md` | After `Do NOT trigger downstream handoffs...` line; before `<!-- COPILOT-ONLY -->` | Pure additive insertion — new `## Teams Planner Output` section |

No existing text is removed or altered. BA-4 is a single insertion.

---

## Out of Scope

- Phase 4 does NOT add role boundary guards — that is Phase 5.
- Phase 4 does NOT regenerate output files — that is Phase 6.
- No changes to any other template file.
- The `PLANNER-OUTPUT` schema does not validate at generation time; conformance is
  enforced by the agent instructions at runtime.
- Planner import tooling, API integration, or CSV export logic are out of scope.

---

## Tests

`PLANNER-OUTPUT` is an instruction-level pattern. Testing is via scenario simulation.
The following four scenarios are the minimum acceptance bar.

### Scenario BA-PL-001 — Sprint backlog keyword triggers Planner block

| Field | Value |
|-------|-------|
| Input | BA is asked to "break down the QR scanning epic into user stories for Sprint 3" |
| Expected output | Each user story ends with a well-formed `PLANNER-OUTPUT` block; all five mandatory fields populated; `bucket: "Sprint 3"` |
| Pass condition | No user story emitted without a corresponding `PLANNER-OUTPUT` block; no partial blocks |

### Scenario BA-PL-002 — Mandatory fields all present

| Field | Value |
|-------|-------|
| Input | Any qualifying task breakdown request |
| Expected output | `PLANNER-OUTPUT` blocks contain `task_title`, `bucket`, `assigned_to`, `due_date`, `notes` |
| Pass condition | Zero missing mandatory fields; `"TBD"` used where value cannot be derived, with explanation in `notes` |

### Scenario BA-PL-003 — PRD context triggers no-op

| Field | Value |
|-------|-------|
| Input | BA is asked to "write a PRD for the offline capture feature" (no planning keywords) |
| Expected output | No `PLANNER-OUTPUT` blocks emitted; optionally a single suppression notice |
| Pass condition | No `PLANNER-OUTPUT:` YAML in the output except the optional `skipped` notice |

### Scenario BA-PL-004 — Unknown `due_date` uses TBD

| Field | Value |
|-------|-------|
| Input | BA produces a task item for a feature not yet scheduled on the roadmap |
| Expected output | `due_date: "TBD"` with `notes` explaining the dependency (e.g., "Due date pending Phase 2 scheduling") |
| Pass condition | Block is well-formed; `due_date` is not omitted or left blank |

---

## Verification

### Automated Checks

After editing the template, verify the file is structurally valid:

```bash
make validate
```

> **Windows note:** `make validate` requires WSL or Git Bash on Windows.

Expected: exits 0, no template validation errors.

After `make && ./install.sh`, confirm the section propagated into generated output (bash/zsh):

```bash
grep -c "PLANNER-OUTPUT" generated/copilot/agents/business-analyst.agent.md
```

Expected: output ≥ 1 (at least one occurrence in the schema block).

For PowerShell (Windows):

```powershell
(Select-String -Path "generated\copilot\agents\business-analyst.agent.md" -Pattern "PLANNER-OUTPUT").Count
```

Expected: ≥ 1.

Verify the `## Teams Planner Output` heading exists:

```bash
grep -c "## Teams Planner Output" generated/copilot/agents/business-analyst.agent.md
```

For PowerShell (Windows):

```powershell
(Select-String -Path "generated\copilot\agents\business-analyst.agent.md" -Pattern "## Teams Planner Output").Count
```

Expected: 1.

Verify the three qualification-signal categories are present:

```bash
grep -cE "Sprint planning|Backlog grooming|Task breakdown" generated/copilot/agents/business-analyst.agent.md
```
For PowerShell (Windows):

```powershell
(Select-String -Path "generated\copilot\agents\business-analyst.agent.md" -Pattern "Sprint planning|Backlog grooming|Task breakdown").Count
```
Expected: 3.

Verify no-op condition language propagated:

```bash
grep -c "no planning intent detected" generated/copilot/agents/business-analyst.agent.md
```

For PowerShell (Windows):

```powershell
(Select-String -Path "generated\copilot\agents\business-analyst.agent.md" -Pattern "no planning intent detected").Count
```

Expected: 1.

### Manual Verification Steps

1. Open `generated/copilot/agents/business-analyst.agent.md` and confirm the `## Teams Planner Output` section appears **after** the INGESTION-DECISION guard block and **before** `## Working in VS Code`.
2. Confirm all five mandatory field lines (`task_title`, `bucket`, `assigned_to`, `due_date`, `notes`) appear in the schema block.
3. Confirm the no-op suppression line (`PLANNER-OUTPUT: skipped — requirements-documentation context`) is present.

### Success Criteria

| Criterion | Observable Evidence | Pass Threshold |
|-----------|--------------------|-|
| `## Teams Planner Output` section present in generated agent | `grep -c "## Teams Planner Output"` on generated file | Returns 1 |
| All five mandatory fields documented | `PLANNER-OUTPUT` schema block contains all five field names | All present |
| Qualification signals table present | Three signal-category rows visible in generated file | 3 rows |
| No-op condition documented | `PLANNER-OUTPUT: skipped` pattern in generated file | Present |
| Template validates cleanly | `make validate` exit code | 0 |
| Section position correct | Section appears after INGESTION-DECISION guard, before COPILOT-ONLY | Visual inspection |
