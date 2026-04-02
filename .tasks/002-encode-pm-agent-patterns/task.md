---
task: Encode ADR-008 PM agent coordination patterns into shared agent templates
slug: encode-pm-agent-patterns
created: 2026-03-23
status: consolidated
---

# Encode PM Agent Coordination Patterns into Templates

## Phases

| #   | Phase                                      | Status         | Plan | Notes                                                                      |
| --- | ------------------------------------------ | -------------- | ---- | -------------------------------------------------------------------------- |
| 1   | Conductor gate pattern                     | ✅ Done        | [phase-1-conductor-gate-pattern.md](plan/phase-1-conductor-gate-pattern.md) | Completed: gate enforcement added to conductor and project-manager templates |
| 2   | PM-tool recommendations skill + wiring     | ✅ Done        | [phase-2-pm-tool-recommendations-skill-wiring.md](plan/phase-2-pm-tool-recommendations-skill-wiring.md) | `pm-tool-recommendations` skill created and wired into 4 PM agent templates |
| 3   | Observable ingestion error paths           | ✅ Done        | [phase-3-observable-ingestion-error-paths.md](plan/phase-3-observable-ingestion-error-paths.md) | PO-1/PO-2/PO-3 + BA-1 applied; INGESTION-DECISION blocks in both templates |
| 4   | Planner-friendly BA output                 | ✅ Done        | [phase-4-planner-friendly-ba-output.md](plan/phase-4-planner-friendly-ba-output.md) | `## Teams Planner Output` section inserted; PLANNER-OUTPUT schema, qualification signals, no-op condition added |
| 5   | Role boundary guards                       | ✅ Done        | [phase-5-role-boundary-guards.md](plan/phase-5-role-boundary-guards.md) | Role Boundaries (Must Do/Must Not Do/ROLE-BOUNDARY YAML) added to PM, PO, BA, SM templates. |
| 6   | Regenerate + validate                      | ✅ Done        | [phase-6-regenerate-validate.md](plan/phase-6-regenerate-validate.md) | Generator exit 0 (96 files, 0 updated). 39/39 pattern checks passed. CHANGELOG updated. `scripts/validate-pm-patterns.ps1` created. |

**Status:** ⬜ Not Started → 📋 Planned → ⭐ Reviewed → 🔄 In Progress → ✅ Done

## Overview

ADR-008 (`docs/architecture/ADR-008-pm-agent-coordination-patterns.md`) documents 7 root-cause fixes for PM agent coordination failures diagnosed in task `001-pm-agent-gap-analysis`. The patterns must now be encoded into the shared agent templates in `templates/agents/` and `templates/skills/` so that all future generated agent files automatically carry these coordination behaviours.

## Goal

After this task, any project that installs these agents via `make && ./install.sh` will get PM agents that:
- Enforce Conductor checkpoints with pass/fail conditions and fail-fast escalation
- Proactively recommend PM frameworks (RACI, RAID, Fishbone/Ishikawa, RAPID/DACI, BCG, Stakeholder Analysis, Project Charter) when qualifying context signals are detected
- Emit structured `INGESTION-DECISION` blocks on ingestion failures instead of silently failing
- Produce Teams Planner-aligned output from the Business Analyst
- Enforce must-do/must-not-do role boundaries with explicit rejection messages

## Source Reference

- ADR: `docs/architecture/ADR-008-pm-agent-coordination-patterns.md`
- Root cause taxonomy: RC-001 GATE-MISSING, RC-002 TRIGGER-MISSING, RC-003 PATH-RESOLUTION, RC-004 FORMAT-CONTRACT, RC-005 PM-TOOL-LOGIC, RC-006 ROLE-BOUNDARY, RC-007 CONFIG-DRIFT
- Evidence package: `docs/research/pm-agent-gap-analysis/`

---

## Research Findings

### Template files and their current state

| Template | RC addressed | Pattern(s) to add |
|----------|-------------|-------------------|
| `templates/agents/conductor.template.md` | RC-001 GATE-MISSING | Phase 1: Explicit PM-workflow gate preconditions with pass/fail criteria, fail-fast escalation levels (L1 retry → L2 Conductor re-plan → L3 halt + user surface) |
| `templates/agents/project-manager.template.md` | RC-001 GATE-MISSING, RC-006 ROLE-BOUNDARY | Phase 1: Gate enforcement section referencing BAS-GATE-001/002/003 structure; Phase 5: Role matrix, must-not-do guards |
| `templates/agents/product-owner.template.md` | RC-003 PATH-RESOLUTION, RC-006 ROLE-BOUNDARY | Phase 3: INGESTION-DECISION structured block on ingestion failures; Phase 5: must-not-do role guards with explicit rejection messages |
| `templates/agents/business-analyst.template.md` | RC-004 FORMAT-CONTRACT, RC-003 PATH-RESOLUTION, RC-006 ROLE-BOUNDARY | Phase 3: INGESTION-DECISION block; Phase 4: Teams Planner-aligned output block (mandatory fields, qualification signals, no-op condition); Phase 5: must-not-do guards |
| `templates/agents/scrum-master.template.md` | RC-006 ROLE-BOUNDARY | Phase 5: must-not-do role guards |
| `templates/skills/pm-tool-recommendations/SKILL.template.md` | RC-005 PM-TOOL-LOGIC | Phase 2: New skill — context signals → framework recommendation table; deterministic ranking; conflict resolution |

### Current gaps confirmed

1. **Conductor** has no PM-specific gate precondition language; gate enforcement exists only as checkpoint labels in workflow steps, with no fail-fast logic or escalation path definitions.
2. **ProjectManager** checkpoints (CP-A1 through CP-F4) correctly list pass/fail decision options but have no fail-fast escalation levels or halt conditions.
3. **ProductOwner** ingestion process steps end with `Handoff: Return to ProjectManager`; there is no explicit branch for classification failure emitting a structured error block.
4. **BusinessAnalyst** has no Planner output schema section; only implicitly produces markdown artefacts with no Teams Planner field mapping.
5. No PM-tool recommendation logic exists in any template; the frameworks (RACI, RAID, etc.) are referenced only in the ADR, not in agent instructions or skills.
6. No must-do/must-not-do role boundary sections exist in any PM agent template; role constraints are described descriptively but carry no explicit rejection message for violations.

### Generated output shape

Generated files in `generated/copilot/agents/` are plain Copilot `.agent.md` files — the `copilot:` YAML block from the template is flattened into a simple frontmatter (tools, agents, model, etc.). Template body markdown passes through unchanged. Changes to template bodies therefore appear verbatim in generated agents.

### Skill template shape

Skills in `templates/skills/{name}/SKILL.template.md` contain a YAML frontmatter with `name` and `description`, followed by markdown body. Generated output lands in `generated/copilot/skills/{name}/SKILL.md` and `generated/claude/skills/{name}/SKILL.md`. A new skill needs only the `SKILL.template.md` file in a new subdirectory.

### Templates NOT needing changes

`builder.template.md`, `committer.template.md`, `explorer.template.md`, `researcher.template.md`, `reviewer.template.md`, `worker.template.md`, `frontend-dev.template.md`, `backend-dev.template.md`, `qa-engineer.template.md`, `uiux-designer.template.md` — none are PM orchestration agents and don't carry PM coordination pattern requirements.

---

## Phase Detail

### Phase 1 — Conductor gate pattern

**Files:** `templates/agents/conductor.template.md`, `templates/agents/project-manager.template.md`

**What to add to `conductor.template.md`:**
- A new `## PM Workflow Gate Enforcement` subsection under rationalization prevention (or after the agent capabilities table)
- Gate precondition schema: each phase/workstream boundary requires an explicit named gate (`BAS-GATE-NNN`) with pass condition, fail condition, and fail-fast escalation path
- Escalation levels: Level 1 (workstream owner retry) → Level 2 (Conductor re-plan) → Level 3 (halt and surface to user)
- Wave sequencing rule: Wave 2 may not begin until all Wave 1 gates pass

**What to add to `project-manager.template.md`:**
- Explicit `## Gate Enforcement` section with pass/fail conditions per workflow checkpoint (extend the existing CP-X checkpoint entries)
- Fail-fast conditions per checkpoint: what constitutes an unrecoverable failure vs. rework
- Escalation path (L1 → L2 → L3) per checkpoint

---

### Phase 2 — PM-tool recommendations skill

**Files:** New `templates/skills/pm-tool-recommendations/SKILL.template.md`; add skill reference to `project-manager.template.md`, `product-owner.template.md`, `business-analyst.template.md`, `scrum-master.template.md`

**Skill content:**
- Context signal → framework trigger table from ADR-008 §Key Architectural Patterns §1:
  - Unresolved blocker / root-cause needed → Fishbone (Ishikawa)
  - Role ambiguity / accountability unclear → RACI
  - Risks, assumptions, issues, dependencies → RAID log
  - Prioritization / portfolio decisions → BCG matrix
  - Governance / decision rights unclear → RAPID / DACI
  - Stakeholder landscape unclear → Stakeholder Analysis
  - New initiative kickoff → Project Charter
- Ranking rule: signal strength-based; highest-confidence match surfaced first when multiple contexts qualify
- False-positive guard: only recommend when a qualifying signal is explicitly present in user context; do not recommend speculatively

**Wiring into agent templates:**
- Add `pm-tool-recommendations` to the `skills:` list in `cc:` block for project-manager, product-owner, business-analyst, scrum-master
- Add a `## PM Framework Recommendations` section in each template body describing when to invoke the skill

---

### Phase 3 — Observable ingestion error paths

**Files:** `templates/agents/product-owner.template.md`, `templates/agents/business-analyst.template.md`

**What to add:**
- After each ingestion step that can fail (classification, path validation, template application), add a branch: `INGESTION-DECISION` structured block:
  ```
  INGESTION-DECISION:
    status: blocked | success | skipped
    reason: <human-readable>
    artifact: <path attempted>
    next_action: <explicit instruction to user or downstream agent>
  ```
- Replace implicit `Handoff: Return to ProjectManager` on failure with the explicit `INGESTION-DECISION` block
- Applies to: ProductOwner Skill 1 (resource-ingestion) failure branches; BusinessAnalyst specification-update failure branches

---

### Phase 4 — Planner-friendly BA output

**Files:** `templates/agents/business-analyst.template.md`

**What to add:**
- A new `## Teams Planner Output` section (or extend the available skills table) that maps BA output fields to Teams Planner import schema fields
- Mandatory fields: Task title, Bucket, Assigned to, Due date, Notes/description
- Qualification signal: output Planner block only when context includes sprint planning, backlog grooming, or task breakdown keywords
- No-op condition: if context is purely requirements documentation (no planning intent), suppress Planner block

---

### Phase 5 — Role boundary guards

**Files:** `templates/agents/project-manager.template.md`, `templates/agents/product-owner.template.md`, `templates/agents/business-analyst.template.md`, `templates/agents/scrum-master.template.md`

**What to add to each:**
- A `## Role Boundaries` section with two subsections:
  - **Must do** (3–5 bullets): confirmed responsibilities
  - **Must NOT do** (3–5 bullets): out-of-scope actions with explicit rejection message pattern
- Rejection message pattern:
  ```
  ❌ Out of scope: [action]. This is [Role X]'s responsibility.
     → Redirect to [Role X] via handoff button.
  ```
- Role matrix (table) listing which agent owns each cross-cutting concern (ingestion, requirements, sprint planning, gate enforcement, code changes, test execution)

---

### Phase 6 — Regenerate and validate

**Commands:** `make && ./install.sh`  
**Validation:** Diff generated files against templates to confirm all 5 pattern categories appear in the appropriate generated agent files; no template-only-comment markers (`<!-- COPILOT-ONLY -->` etc.) are leaked into wrong platform outputs.
