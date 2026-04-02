---
phase: 3
title: Observable Ingestion Error Paths
template_files:
  - templates/agents/product-owner.template.md
  - templates/agents/business-analyst.template.md
root_causes: RC-003 (PATH-RESOLUTION)
adr: docs/architecture/ADR-008-pm-agent-coordination-patterns.md § "Observable Ingestion Error Paths"
created: 2026-03-26
---

# Phase 3: Observable Ingestion Error Paths

## Objective

Replace silent failure branches in the two intake-facing agent templates with structured
`INGESTION-DECISION` output blocks. Every ingestion or artefact-save operation must branch
to an observable decision block on failure — no unstructured "escalate if unable"; no
`Save Artefacts` table without a failure path.

**Root cause addressed:** RC-003 PATH-RESOLUTION — tool invocations reference paths that may
not exist, and failures are currently unobservable.

**Constraint:** All changes are additive. No existing content is removed from either template.

---

## INGESTION-DECISION Schema

Defined in ADR-008 §3 ("Observable Ingestion Error Paths"). Use verbatim in both templates.

~~~
INGESTION-DECISION:
  status: blocked | success | skipped
  reason: <human-readable description of what failed or was skipped>
  artifact: <path attempted, or "path undetermined" if unknown>
  next_action: <explicit single instruction to user or named downstream agent>
~~~

Field semantics:

| Field | Meaning |
|-------|---------|
| `status: blocked` | Path unresolvable, format unrecognised, or classification failed; downstream work cannot continue |
| `status: success` | Artefact written to expected path; downstream work may proceed |
| `status: skipped` | Step intentionally bypassed (e.g., binary already converted; doc already exists at path) |
| `reason` | One-sentence human-readable explanation — enough for the user to identify and correct the issue |
| `artifact` | Absolute or workspace-relative path attempted. Use `"path undetermined"` when the path could not be resolved at all |
| `next_action` | Exactly one instruction: either an explicit user action OR a named agent handoff with transfer content |

---

## Changes to `templates/agents/product-owner.template.md`

### Silent Failure Location

The `Skill 1: resource-ingestion` **Process** section ends with:

```
5. If binary format (.docx, .eml, .msg) → delegate to Worker with "Convert [resource] to markdown"
6. Once in markdown → validate path → file in learning_base

**Output**: Resource filed in learning_base with metadata header and classification tags

**Handoff**: Return to ProjectManager for Workflow A completion; escalate if unable to classify (unknown document type)
```

`escalate if unable to classify` has no defined output shape. Step 6 `validate path` has
no explicit failure branch. Both are silent failures under RC-003.

---

### Change PO-1: Insert INGESTION-DECISION failure block after step 6

**Insertion point:** Between step 6 and the `**Output**` line in the `resource-ingestion` Process section.

**Locate this exact text:**

```
5. If binary format (.docx, .eml, .msg) → delegate to Worker with "Convert [resource] to markdown"
6. Once in markdown → validate path → file in learning_base

**Output**: Resource filed in learning_base with metadata header and classification tags
```

**Insert the following block between step 6 and `**Output**` (no existing text removed):**

```markdown
**On any step failure, emit an INGESTION-DECISION block and stop:**

~~~
INGESTION-DECISION:
  status: blocked | success | skipped
  reason: <e.g. "path does not exist", "document type unrecognised", "binary conversion failed">
  artifact: <path attempted, or "path undetermined" if path could not be resolved>
  next_action: <one of: "Contact [stakeholder] to re-supply resource in a supported format" | "Escalate to ProjectManager: [reason]" | "Retry after Worker converts [filename]">
~~~

Do NOT proceed to the Output or Handoff steps when `status: blocked`. Emit the block and
surface it to the user before any further action.
```

**Resulting section after insertion:**

```
5. If binary format (.docx, .eml, .msg) → delegate to Worker with "Convert [resource] to markdown"
6. Once in markdown → validate path → file in learning_base

**On any step failure, emit an INGESTION-DECISION block and stop:**

~~~
INGESTION-DECISION:
  status: blocked | success | skipped
  reason: <e.g. "path does not exist", "document type unrecognised", "binary conversion failed">
  artifact: <path attempted, or "path undetermined" if path could not be resolved>
  next_action: <one of: "Contact [stakeholder] to re-supply resource in a supported format" | "Escalate to ProjectManager: [reason]" | "Retry after Worker converts [filename]">
~~~

Do NOT proceed to the Output or Handoff steps when `status: blocked`. Emit the block and
surface it to the user before any further action.

**Output**: Resource filed in learning_base with metadata header and classification tags

**Handoff**: Return to ProjectManager for Workflow A completion; escalate if unable to classify (unknown document type)
```

---

### Change PO-2: Annotate **Output** line to document both happy-path and failure-path outputs

**Locate this exact text:**

```
**Output**: Resource filed in learning_base with metadata header and classification tags
```

**Replace with (additive annotation — extends the Output description):**

```
**Output**: Resource filed in learning_base with metadata header and classification tags; OR
INGESTION-DECISION block (`status: blocked`) if path unresolvable, format unrecognised, or
binary conversion failed.
```

> **Why:** The Output line currently describes only the happy path. Annotating it here
> keeps both branches visible in the same place, making the contract explicit to the
> agent, caller, and any future reader.

---

### Change PO-3: Annotate **Handoff** line to redirect classification failures through INGESTION-DECISION

**Locate this exact text:**

```
**Handoff**: Return to ProjectManager for Workflow A completion; escalate if unable to classify (unknown document type)
```

**Replace with (content-preserving — original Handoff instruction retained; classification failure path made explicit):**

```
**Handoff**: Return to ProjectManager for Workflow A completion; escalate if unable to classify (unknown document type) — classification failures MUST emit an INGESTION-DECISION block (see PO-1) before escalating; do NOT escalate via unstructured text.
```

> **Why:** The `escalate if unable to classify` phrase conflicts with the PO-1 INGESTION-DECISION guard. Without this annotation, an agent could bypass PO-1 and escalate directly, leaving the classification failure unobservable.

---

## Changes to `templates/agents/business-analyst.template.md`

### Silent Failure Location

**Step 4: Save Artefacts** provides a save-location table but no explicit failure handling.
If a target path does not exist (RC-003), the agent currently has no modelled output shape:

```
| Architecture blueprints | `docs/architecture/` or project root |

Always link new artefacts from the relevant roadmap section or BRD.
```

The `<!-- COPILOT-ONLY -->` section immediately follows (or the next section heading).
Nothing handles the case where the directory does not exist or the save conflicts with an
existing artefact.

---

### Change BA-1: Insert INGESTION-DECISION failure block after "Always link" line

**Insertion point:** Immediately after `Always link new artefacts from the relevant roadmap section or BRD.` and before the next section/comment.

**Locate this exact text:**

```
Always link new artefacts from the relevant roadmap section or BRD.
```

**Insert the following block immediately after it (no existing text removed):**

```markdown
**On any save failure, emit an INGESTION-DECISION block and stop:**

~~~
INGESTION-DECISION:
  status: blocked | success | skipped
  reason: <e.g. "target directory does not exist", "conflicting artefact already present at path", "path outside write scope">
  artifact: <path attempted>
  next_action: <one of: "Create missing directory [path] then retry" | "Confirm correct save location with ProjectManager" | "Resolve path conflict by renaming existing artefact at [path]">
~~~

Do NOT trigger downstream handoffs (Plan Sprint, Save Work) when `status: blocked`. Emit
the block and surface it to the user before any further action.
```

**Resulting section after insertion:**

```
| Architecture blueprints | `docs/architecture/` or project root |

Always link new artefacts from the relevant roadmap section or BRD.

**On any save failure, emit an INGESTION-DECISION block and stop:**

~~~
INGESTION-DECISION:
  status: blocked | success | skipped
  reason: <e.g. "target directory does not exist", "conflicting artefact already present at path", "path outside write scope">
  artifact: <path attempted>
  next_action: <one of: "Create missing directory [path] then retry" | "Confirm correct save location with ProjectManager" | "Resolve path conflict by renaming existing artefact at [path]">
~~~

Do NOT trigger downstream handoffs (Plan Sprint, Save Work) when `status: blocked`. Emit
the block and surface it to the user before any further action.

<!-- COPILOT-ONLY -->
...
```

---

## Summary of All Changes

| ID | File | Insertion Point | Change Type |
|----|------|----------------|-------------|
| PO-1 | `product-owner.template.md` | After resource-ingestion step 6, before `**Output**` | Insert INGESTION-DECISION block + do-not-proceed guard |
| PO-2 | `product-owner.template.md` | `**Output**` line in resource-ingestion | Replace (content-preserving) |
| PO-3 | `product-owner.template.md` | `**Handoff**` line in resource-ingestion | Replace (content-preserving) |
| BA-1 | `business-analyst.template.md` | After `Always link new artefacts...` line | Insert INGESTION-DECISION block + do-not-proceed guard |

PO-1 and BA-1 are **additive only** (pure insertions). PO-2 and PO-3 are **content-preserving replacements**: the original text is retained and extended in-place — this is the sole exception to the additive-only rule.

---

## Out of Scope

- Phase 3 does NOT add role boundary guards — that is Phase 5.
- Phase 3 does NOT add the Teams Planner output schema — that is Phase 4.
- Phase 3 does NOT regenerate output files — that is Phase 6.
- No changes to `conductor.template.md`, `project-manager.template.md`, or any other template.
- Read-path failures (BA failing to read Project Context docs) are out of scope. Phase 3
  targets write/save paths only, which are the primary RC-003 manifestation in these templates.
- Skill 2 (`stakeholder-feedback`) write-path error handling is out of scope. That skill owns
  its own error paths and is not modified by Phase 3; changes there belong in a separate phase.

---

## Tests

`INGESTION-DECISION` is an instruction-level pattern. Testing is via scenario simulation
(no compilation step). The following scenarios are the minimum acceptance bar.

### Scenario PO-ING-001 — Unrecognised document type

| Field | Value |
|-------|-------|
| Input | ProductOwner receives a `.pptx` file not in the supported binary list |
| Expected output | INGESTION-DECISION block: `status: blocked`, `reason: "document type unrecognised"`, `next_action: "Contact [stakeholder] to re-supply resource in a supported format"` |
| Pass condition | No unstructured "escalate if unable" text; a well-formed INGESTION-DECISION block is the only output |

### Scenario PO-ING-002 — Target path does not exist

| Field | Value |
|-------|-------|
| Input | ProductOwner attempts to file a resource at `learning_base/05_technical_specs/` but that directory does not exist |
| Expected output | INGESTION-DECISION block: `status: blocked`, `reason: "path does not exist"`, `next_action` pointing to directory creation or PM escalation |
| Pass condition | No silent write attempt emitted before INGESTION-DECISION block |

### Scenario BA-ING-001 — Save path outside defined scope

| Field | Value |
|-------|-------|
| Input | BusinessAnalyst attempts to save a PRD to a path not listed in the Save Artefacts table |
| Expected output | INGESTION-DECISION block: `status: blocked`, `reason: "path outside write scope"` |
| Pass condition | Block emitted before any handoff trigger fires |

### Scenario BA-ING-002 — Target directory missing

| Field | Value |
|-------|-------|
| Input | BusinessAnalyst saves a feature spec to `docs/ways-of-work/plan/{epic-name}/` and that directory doesn't exist |
| Expected output | INGESTION-DECISION block: `status: blocked`, `reason: "target directory does not exist"`, `next_action: "Create missing directory [path] then retry"` |
| Pass condition | No silent write failure; block surfaced before Plan Sprint handoff |

---

## Verification

### Automated Checks

After editing templates, run linting:

```bash
make validate
```

Expected: exits 0, no template validation errors.

After `make && ./install.sh`, verify propagation (bash/zsh):

```bash
grep -n "INGESTION-DECISION" generated/copilot/agents/product-owner.agent.md
grep -n "INGESTION-DECISION" generated/copilot/agents/business-analyst.agent.md
```

Expected: at least **two** line matches in the ProductOwner file (PO-1 block + PO-2 Output annotation) and at least **one** line match in the BusinessAnalyst file (BA-1 block).

Cross-shell (PowerShell — for Windows environments):

```powershell
Select-String -Path "generated/copilot/agents/product-owner.agent.md" -Pattern "INGESTION-DECISION"
Select-String -Path "generated/copilot/agents/business-analyst.agent.md" -Pattern "INGESTION-DECISION"
```

Expected: at least one match per file, each showing `status: blocked | success | skipped`.

Additive-only check (confirms no existing content was removed):

> **Important:** Capture baseline counts **before** running Builder. Phase 3 includes
> content-preserving replacements (PO-2, PO-3); baseline must reflect the pre-edit state.

```bash
# Run BEFORE Builder to record baseline:
wc -l generated/copilot/agents/product-owner.agent.md
wc -l generated/copilot/agents/business-analyst.agent.md
```

PowerShell equivalent (Windows):

```powershell
# Run BEFORE Builder to record baseline:
(Get-Content "generated/copilot/agents/product-owner.agent.md").Count
(Get-Content "generated/copilot/agents/business-analyst.agent.md").Count
```

After Builder completes, run the same commands again. Both counts must increase.

### Manual Verification Steps

1. Open `generated/copilot/agents/product-owner.agent.md`. Locate the `resource-ingestion`
   section. Confirm:
   - INGESTION-DECISION block appears **between** step 6 and the `**Output**` line (PO-1).
   - `**Output**` line mentions both the happy-path artefact AND the `status: blocked` path (PO-2).

2. Open `generated/copilot/agents/business-analyst.agent.md`. Locate `Step 4: Save Artefacts`.
   Confirm:
   - INGESTION-DECISION block appears **after** `Always link new artefacts from the relevant roadmap section or BRD.` (BA-1).
   - `Do NOT trigger downstream handoffs` guard is present.

3. Verify no existing content was deleted by running a diff of template vs any prior commit:
   ```bash
   git diff templates/agents/product-owner.template.md
   git diff templates/agents/business-analyst.template.md
   ```
   Diff should show **only additions** (lines beginning with `+`). Zero lines beginning with `-` (excluding frontmatter metadata).

### Success Criteria

| Criterion | Observable Signal |
|-----------|------------------|
| INGESTION-DECISION present in ProductOwner agent | `grep` returns ≥ 2 matches in generated ProductOwner file |
| INGESTION-DECISION present in BusinessAnalyst agent | `grep` returns ≥ 1 match in generated BusinessAnalyst file |
| `status` field with full enum visible in both files | `grep -E "blocked|success|skipped"` matches both files (PowerShell: `Select-String -Pattern "blocked"`) |
| No content removed | `git diff` on both templates shows only `+` lines |
| Build passes | `make validate` exits 0 |
