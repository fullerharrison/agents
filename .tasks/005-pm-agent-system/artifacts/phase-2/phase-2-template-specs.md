---
artifact: phase-2-template-specs
task: 005-pm-agent-system
phase: 2
created: 2026-03-18
status: complete
sources:
  - agents-personal/templates/README.md
  - agents-personal/docs/architecture/ADR-005-ide-compatibility.md
  - agents-personal/docs/architecture/ADR-007-rationalization-prevention.md
  - agents-personal/docs/synthesis/skills.md
  - phase-2-skill-contracts.md
---

# Phase 2 Template Specs

## Purpose

This document defines the per-skill template skeleton specifications for the five PM system skills. These specs describe what the skill template files (`templates/skills/{skill}/SKILL.template.md`) must contain when created in agents-personal during a future implementation phase. No template files are created in this document — this is planning-only specification.

> **Constraint (CON-201):** All Phase 2 writes are in `.tasks/`. Template file creation in `agents-personal/templates/skills/` is out of scope until an approved Phase 3+ implementation phase.

---

## Shared Template Requirements

All five skill templates must conform to the following rules derived from `agents-personal/templates/README.md` and `ADR-005-ide-compatibility.md`:

### Frontmatter Rules

| Rule | Source |
|------|--------|
| All skills must include `name` and `description` fields at minimum | templates/README.md §Skill Template Frontmatter |
| `description` must contain trigger keywords to support auto-activation | templates/README.md §Skill Template Frontmatter; skills.md §Quality Checklist |
| Optional `cc:` block with `context` and `allowed-tools` for CC platform enhancements | templates/README.md §Skill Template Frontmatter (CC enhancements) |
| Skills without CC enhancements omit `cc:` entirely (edge case E2) | templates/README.md §Edge Cases E2 |
| No `copilot:` section in skill templates — Copilot uses only `name` and `description` | templates/README.md §Generation Rules: "Copilot output: name, description only" |
| `cc.context` valid values: `fork` (isolated context) or omit for inline | templates/README.md §Skill Template Frontmatter |
| `cc.allowed-tools` restricts CC tool access to listed tools only | templates/README.md §Skill Template Frontmatter |

### Body Content Rules

| Rule | Source |
|------|--------|
| Content before any directive is SHARED by default | templates/README.md §Body Content Directives Rule 1 |
| Platform-specific blocks require both opening and closing tags | templates/README.md §Syntax (requires closing tags) |
| No nesting of directives | templates/README.md §Rules Rule 5: "No nesting" |
| Unknown directives are generator errors | templates/README.md §Validation Rules |
| Valid directives only: `SHARED`, `COPILOT-ONLY`, `/COPILOT-ONLY`, `CC-ONLY`, `/CC-ONLY` | templates/README.md §Syntax |
| Skills under 500 lines (progressive disclosure) | skills.md §What We Adopted: "Progressive disclosure (<500 lines)" |
| Must include rationalization prevention table (3-column format) | ADR-007-rationalization-prevention.md §Table Format |

### Rationalization Prevention Table Format (Required in All Skills)

```markdown
| Excuse | Reality | Required Action |
| ------ | ------- | --------------- |
| "The output looks fine" | You haven't verified artifact paths or checkpoint compliance | Check artifact_path, required metadata keys, and checkpoint conditions explicitly |
```

Each skill template must include a rationalization prevention table with at least 3 rows specific to its common failure modes.

---

## Skill 1: resource-ingestion — Template Spec

### File Path (when created)
```
agents-personal/templates/skills/resource-ingestion/SKILL.template.md
```

### Frontmatter Skeleton

```yaml
---
name: resource-ingestion
description: "Use when ingesting and classifying inbound resources into learning_base/.
  Triggers on: 'ingest this document', 'ingest this email', 'ingest this link',
  'process this resource', 'add this to the knowledge base', 'store this chat extract',
  'classify and save this material', 'log this reference document', 'record this meeting output'.
  Classifies resource_type and produces normalized ingestion summary with source attribution."

# CC enhancements
cc:
  context: fork
  allowed-tools: [Read, Grep, Glob, Write]
---
```

**Generation output:**
- Copilot: `name` + `description` only (no `cc:` block)
- CC: `name` + `description` + `context: fork` + `allowed-tools: [Read, Grep, Glob, Write]`

### Required Body Blocks

| Block | Platform | Content |
|-------|----------|---------|
| Skill Objective | SHARED | Single paragraph stating objective and non-goals |
| Input Requirements | SHARED | Resource type, source attribution, date fields |
| Classification Rules | SHARED | Subdirectory selection table |
| Output Requirements | SHARED | Artifact path, naming convention, required metadata |
| Checkpoint Conditions | SHARED | CP-RI-1, CP-RI-2, CP-RI-3 conditions |
| Rationalization Prevention | SHARED | ≥3-row table |
| Handoff Instruction | SHARED | Escalation path to ProductOwner and `action_flags` routing |

### Platform-Specific Sections

| Section | Directive | Content |
|---------|-----------|---------|
| Checkpoint pause syntax | `<!-- COPILOT-ONLY -->` | Use `askQuestions` tool with options |
| Checkpoint pause syntax | `<!-- CC-ONLY -->` | Use `AskUserQuestion` tool with structured options |

### Rationalization Prevention Rows (minimum)

| Excuse | Reality | Required Action |
|--------|---------|-----------------|
| "The classification seems obvious, I'll skip the rationale" | Missing `classification_rationale` breaks downstream consumers | Always write `classification_rationale` even when target seems clear |
| "The source attribution is approximate, good enough" | Inaccurate attribution makes the ingestion untraceable | Preserve exact source text or mark explicitly as "unknown" |
| "No checkpoint needed for a simple email" | CP-RI-2 fires based on `action_flags`, not resource complexity | Always evaluate `action_flags` before finalizing; check every inbound for `potential_requirement` signals |

---

## Skill 2: stakeholder-feedback — Template Spec

### File Path (when created)
```
agents-personal/templates/skills/stakeholder-feedback/SKILL.template.md
```

### Frontmatter Skeleton

```yaml
---
name: stakeholder-feedback
description: "Use when processing stakeholder comments, meeting notes, or issue records
  into structured Voice of Customer records and requirement signals.
  Triggers on: 'process stakeholder feedback', 'structure this voice of customer',
  'capture stakeholder input', 'analyze this feedback', 'record stakeholder concerns',
  'extract requirement signals from this feedback', 'create a VoC record',
  'prioritize stakeholder issues', 'triage feedback into requirements'.
  Produces VoC artifact at learning_base/11_voice_of_customer/ with pain_points,
  requirement_signals, and escalation_flag."

# CC enhancements
cc:
  context: fork
  allowed-tools: [Read, Grep, Glob, Write]
---
```

**Generation output:**
- Copilot: `name` + `description` only
- CC: `name` + `description` + `context: fork` + `allowed-tools`

### Required Body Blocks

| Block | Platform | Content |
|-------|----------|---------|
| Skill Objective | SHARED | Objective and non-goals |
| VoC Sequence Number Rule | SHARED | How to determine next `voc_NNN` (scan `learning_base/11_voice_of_customer/`) |
| Input Requirements | SHARED | `feedback_content`, `stakeholder_id`, `feedback_channel`, etc. |
| Requirement Signal Extraction | SHARED | How to classify signals as `functional`\|`non_functional`\|`constraint` |
| MoSCoW Suggestion Rules | SHARED | Rules for non-binding `moscow_suggestion` field |
| Escalation Flag Rules | SHARED | When `escalation_flag: true` triggers CP-SF-1 |
| Output Requirements | SHARED | VoC artifact structure and naming |
| Checkpoint Conditions | SHARED | CP-SF-1, CP-SF-2, CP-SF-3 |
| Rationalization Prevention | SHARED | ≥3-row table |
| Handoff Instruction | SHARED | ProductOwner review → `backlog-management` or `requirements-cascade` |

### Platform-Specific Sections

| Section | Directive | Content |
|---------|-----------|---------|
| Checkpoint pause syntax | `<!-- COPILOT-ONLY -->` | Use `askQuestions` with escalation options |
| Checkpoint pause syntax | `<!-- CC-ONLY -->` | Use `AskUserQuestion` with escalation options |

### Rationalization Prevention Rows (minimum)

| Excuse | Reality | Required Action |
|--------|---------|-----------------|
| "The stakeholder was informal, no requirement signals here" | Informal feedback often contains the most actionable signals | Always evaluate for `requirement_signals` even in casual language |
| "escalation_flag seems unlikely, I'll leave it false" | Missing `escalation_flag: true` suppresses mandatory CP-SF-1 | Explicitly check every safety, regulatory, or urgent signal; set flag conservatively |
| "The VoC sequence number doesn't matter much" | Duplicate or out-of-sequence VoC IDs break traceability | Always scan `learning_base/11_voice_of_customer/` for the highest existing NNN before writing |

---

## Skill 3: requirements-cascade — Template Spec

### File Path (when created)
```
agents-personal/templates/skills/requirements-cascade/SKILL.template.md
```

### Frontmatter Skeleton

```yaml
---
name: requirements-cascade
description: "Use when a requirement change must be propagated across downstream documents.
  Triggers on: 'cascade this requirement change', 'propagate this update across documents',
  'which documents need updating after this change', 'requirement cascade',
  'impact analysis for requirement change', 'update propagation plan',
  'map downstream impacts of this requirement', 'trace dependencies for this specification change',
  'what needs to change when this requirement changes'.
  Produces ordered dependency_sequence and execution_queue for Worker/Builder.
  Plan-only mode: never applies edits directly."

# CC enhancements
cc:
  context: fork
  allowed-tools: [Read, Grep, Glob]
---
```

**Note on `allowed-tools`:** `Write` is intentionally excluded. This skill is plan-only — it produces a cascade plan but does NOT write updated documents. Write permissions are held by Worker/Builder executing the plan.

**Generation output:**
- Copilot: `name` + `description` only
- CC: `name` + `description` + `context: fork` + `allowed-tools: [Read, Grep, Glob]`

### Required Body Blocks

| Block | Platform | Content |
|-------|----------|---------|
| Skill Objective and Plan-Only Mode | SHARED | Objective, explicit prohibition on direct edits |
| Dependency Scan Defaults | SHARED | Default scan locations when `impacted_document_registry` is not provided |
| Dependency Sequencing Rules | SHARED | How to order files; circular dependency detection |
| Review Obligation Assignment | SHARED | Default reviewer when `reviewer_override` is absent |
| Execution Queue Format | SHARED | `{task_description, target_file, dependencies}` structure |
| Checkpoint Conditions | SHARED | CP-RC-1 (≥5 files), CP-RC-2 (remove/deprecate), CP-RC-3 (circular), CP-RC-4 (urgent) |
| Rationalization Prevention | SHARED | ≥3-row table |
| Handoff Instruction | SHARED | Execution queue → Worker/Builder; review obligations → Reviewer |

### Platform-Specific Sections

| Section | Directive | Content |
|---------|-----------|---------|
| Execution queue delegation | `<!-- COPILOT-ONLY -->` | "Run the Worker agent as a subagent: ..." pattern |
| Execution queue delegation | `<!-- CC-ONLY -->` | `Task(Worker, "Execute cascade step...")` pattern |

### Rationalization Prevention Rows (minimum)

| Excuse | Reality | Required Action |
|--------|---------|-----------------|
| "Only a few files changed, no need for a full cascade plan" | Missing downstream documents cause silent inconsistency | Always generate complete `dependency_sequence`; let CP-RC-1 gate large scope |
| "The cascade plan is clear, I'll skip review_obligations" | Unassigned review obligations are never fulfilled | Always populate `review_obligations` even when `reviewer_override` is not provided |
| "This is just a minor wording change, no checkpoint needed" | CP-RC-2 fires on `change_type: remove` regardless of perceived impact | Always check `change_type`; never suppress checkpoints based on subjective severity |

---

## Skill 4: backlog-management — Template Spec

### File Path (when created)
```
agents-personal/templates/skills/backlog-management/SKILL.template.md
```

### Frontmatter Skeleton

```yaml
---
name: backlog-management
description: "Use when prioritizing candidate stories, applying MoSCoW classification,
  or creating backlog slices for sprint planning.
  Triggers on: 'prioritize the backlog', 'manage backlog items', 'apply MoSCoW to these stories',
  'create a backlog slice for this sprint', 'rank these user stories', 'groom the backlog',
  'assign phase targets to these items', 'sprint backlog planning', 'backlog triage',
  'map stories to phases'.
  Produces MoSCoW-classified backlog slice at learning_base/planner_updates/ with
  phase mapping metadata for ScrumMaster sprint planning."

# CC enhancements
cc:
  context: fork
  allowed-tools: [Read, Grep, Glob, Write]
---
```

**Generation output:**
- Copilot: `name` + `description` only
- CC: `name` + `description` + `context: fork` + `allowed-tools`

### Required Body Blocks

| Block | Platform | Content |
|-------|----------|---------|
| Skill Objective | SHARED | Objective, non-goals (sprint execution is ScrumMaster's job) |
| MoSCoW Classification Rules | SHARED | Rules for must/should/could/wont assignment |
| Phase Target Lookup | SHARED | How to read phase boundaries from `docs/roadmap.md` |
| Capacity Constraint Handling | SHARED | How to apply `constraints` to filter `must_items` |
| VoC Weighting | SHARED | How `stakeholder_priorities` from VoC IDs influence ranking |
| Conflict Detection | SHARED | Cross-backlog consistency rules (CP-BM-1) |
| Output Requirements | SHARED | Artifact structure and naming convention |
| Checkpoint Conditions | SHARED | CP-BM-1, CP-BM-2, CP-BM-3, CP-BM-4 |
| Rationalization Prevention | SHARED | ≥3-row table |
| Handoff Instruction | SHARED | ScrumMaster sprint commitment flow |

### Platform-Specific Sections

| Section | Directive | Content |
|---------|-----------|---------|
| Checkpoint pause syntax | `<!-- COPILOT-ONLY -->` | `askQuestions` with options |
| Checkpoint pause syntax | `<!-- CC-ONLY -->` | `AskUserQuestion` with options |

### Rationalization Prevention Rows (minimum)

| Excuse | Reality | Required Action |
|--------|---------|-----------------|
| "The MoSCoW assignment is obvious for these stories" | Undocumented rationale cannot be reviewed or challenged | Always include `rationale` in each must/should/could/wont item |
| "Capacity constraints are rough estimates, I'll skip them" | Missing `capacity_note` means CP-BM-2 cannot fire correctly | Always populate `capacity_note` even with uncertainty; include estimate_flag |
| "This VoC item is low priority, no need to link it" | Unlinked VoC signals are invisible to future backlog reviewers | Always populate `stakeholder_weight_applied` and reference VoC IDs when used |

---

## Skill 5: diagram-generation — Template Spec

### File Path (when created)
```
agents-personal/templates/skills/diagram-generation/SKILL.template.md
```

### Frontmatter Skeleton

```yaml
---
name: diagram-generation
description: "Use when workflow or content changes require diagram updates or new diagram creation.
  Triggers on: 'generate a diagram', 'update the Mermaid diagram', 'update the draw.io diagram',
  'add this flow to the diagram', 'diagram this workflow', 'update the architecture diagram',
  'create a visual for this process', 'render this as a Mermaid chart',
  'update diagrams/ after this change', 'diagram lifecycle update'.
  Produces diagram change specification (change_spec), render_commands, and manifest_touchpoints
  for UIUXDesigner execution. Plan-only for new diagrams (requires CP-DG-1 approval)."

# CC enhancements
cc:
  context: fork
  allowed-tools: [Read, Grep, Glob]
---
```

**Note on `allowed-tools`:** `Write` is intentionally excluded. This skill specifies diagram changes but does not write source files. Write operations are delegated to UIUXDesigner/Worker executing the `render_commands`.

**Generation output:**
- Copilot: `name` + `description` only
- CC: `name` + `description` + `context: fork` + `allowed-tools: [Read, Grep, Glob]`

### Required Body Blocks

| Block | Platform | Content |
|-------|----------|---------|
| Skill Objective and Spec-Only Mode | SHARED | Objective, explicit prohibition on executing render commands |
| Mermaid Lifecycle Compliance | SHARED | Reference to `.github/copilot-instructions.md`; compliance check requirement |
| Change Spec Format | SHARED | How to mark `# ADD:`, `# REMOVE:`, `# MODIFY:` in `.mmd` blocks |
| Render Command Format | SHARED | `mmdc` command structure and required flags |
| Manifest Touchpoint Scan | SHARED | How to find files referencing `diagrams/{slug}.mmd` |
| New Diagram Flag Rules | SHARED | When `new_diagram_flag: true` triggers CP-DG-1 |
| Checkpoint Conditions | SHARED | CP-DG-1, CP-DG-2, CP-DG-3, CP-DG-4 |
| Rationalization Prevention | SHARED | ≥3-row table |
| Handoff Instruction | SHARED | UIUXDesigner/Worker execution; Reviewer validation |

### Platform-Specific Sections

| Section | Directive | Content |
|---------|-----------|---------|
| Render command delegation | `<!-- COPILOT-ONLY -->` | "Run the Worker agent as a subagent to execute render commands" |
| Render command delegation | `<!-- CC-ONLY -->` | `Task(Worker, "Execute diagram render commands: ...")` |
| New diagram approval | `<!-- COPILOT-ONLY -->` | Use `askQuestions` for CP-DG-1 |
| New diagram approval | `<!-- CC-ONLY -->` | Use `AskUserQuestion` for CP-DG-1 |

### Rationalization Prevention Rows (minimum)

| Excuse | Reality | Required Action |
|--------|---------|-----------------|
| "The diagram change is small, I can just update the file directly" | Diagram source files must go through spec → render pipeline for lifecycle compliance | Always produce `change_spec` and `render_commands`; never write `.mmd` files directly |
| "manifest_touchpoints are rarely important for small updates" | Silent broken links appear in docs/ and specs/ after diagram renames | Always scan for references before finalizing; populate `manifest_touchpoints` |
| "The lifecycle compliance check adds overhead for obvious changes" | Non-compliant Mermaid syntax causes render failures and broken exports | Always run `lifecycle_compliance_check` against `.github/copilot-instructions.md` |

---

## Template Generation Constraints Summary

| Constraint | Applies To | Source |
|------------|------------|--------|
| Copilot output: `name` + `description` only | All 5 skills | templates/README.md §Skill Template Frontmatter |
| CC output: `name` + `description` + `cc:` fields flattened | All 5 skills with `cc:` | templates/README.md §Generation Rules |
| `allowed-tools` limits CC tool access | Skills 1, 2, 4 (Write); Skills 3, 5 (no Write) | templates/README.md §CC enhancements |
| `context: fork` for isolated execution | All 5 skills | templates/README.md §cc.context |
| No nesting of conditional directives | All 5 skills | templates/README.md §Rules Rule 5 |
| Closing tags required for all platform blocks | All 5 skills | templates/README.md §Rules Rule 3 |
| Template body ≤ 500 lines | All 5 skills | skills.md §What We Adopted |
| Rationalization prevention table ≥ 3 rows | All 5 skills | ADR-007 §Table Format |
| Trigger keywords embedded in `description` | All 5 skills | skills.md §Quality Checklist |
| Plan-only for Skills 3 and 5 (`Write` excluded from `allowed-tools`) | Skills 3, 5 | Phase 2 plan REQ-202, REQ-204 |
