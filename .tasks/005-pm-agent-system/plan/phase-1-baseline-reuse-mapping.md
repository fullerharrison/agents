---
goal: Phase 1 - Baseline and Reuse Mapping
phase: 1
date_created: 2026-03-18
last_updated: 2026-03-18
owner: Explorer
status: Planned
tags: [planning, agent-orchestration, reuse-mapping, compliance]
---

# Phase 1 Plan: Baseline and Reuse Mapping

## Goal
Establish a source-backed baseline for reusable agent patterns and repository interface boundaries so later phases can implement the PM agent system without violating orchestration, skill, or invocation constraints from the agents-personal framework.

## Scope
- In scope:
  - Identify and document reusable patterns for BusinessAnalyst and Worker reuse.
  - Capture required orchestration, skills, and invocation constraints from agents-personal README and docs.
  - Produce a Phase 1 interface map between agents-personal outputs and 2026_01_VIP artifacts.
  - Save all Phase 1 outputs in this task folder only.
- Out of scope:
  - Editing files in agents-personal templates or generated outputs.
  - Creating or modifying production agent templates for ProjectManager/ProductOwner/Specialists.
  - Running generation/install commands (`make`, `install.sh`).

## Checkpoints (Plan-Only Governance)
| Checkpoint | Owner | Required Evidence | Decision Options |
| --- | --- | --- | --- |
| CP-1 Source Baseline Complete | Explorer | Source checklist with citations to agents-personal README/docs/ADRs | Proceed, Rework, Defer |
| CP-2 Reuse Mapping Reviewed | Reviewer (human) | Reuse decision table with keep/adapt/defer and source references | Approve, Request Changes |
| CP-3 Compliance Matrix Reviewed | Reviewer (human) | Orchestration/skills/invocation matrix with citation coverage by category | Approve, Request Changes |
| CP-4 Interface Boundaries Confirmed | Explorer + Reviewer | Interface map plus boundary verification showing Phase 1 outputs listed only under `.tasks/`; this checkpoint gates `✅ Done` only (not `⭐ Reviewed`) | Approve, Request Changes, Defer |

## Status Governance (Plan-Only Mode)
- `📋 Planned` is set when this phase plan is complete and linked from `task.md`.
- `⭐ Reviewed` is set by the reviewer after CP-2 and CP-3 evidence is accepted; CP-4 is not required for this status transition.
- `✅ Done` is deferred in plan-only mode until Builder execution creates Phase 1 artifacts, verification evidence passes, and CP-4 is accepted.
- Explorer may update planning metadata/status notes, but must not mark `✅ Done` for unexecuted implementation work.

## Requirements and Constraints
- REQ-001: Reuse points for BusinessAnalyst and Worker must be explicitly mapped with source references.
- REQ-002: PM adaptation must preserve orchestration-only and read-only behavior for ProjectManager.
- REQ-003: Output must include a compatibility interface map for 2026_01_VIP planning/document artifacts.
- CON-001: Phase execution is read-only against repositories; writes are allowed only inside `.tasks/005-pm-agent-system/`.
- GUD-001: Follow agents-personal task-centric persistence pattern (`.tasks/[NNN-slug]/task.md` and `plan/phase-N-*.md`).
- GUD-002: Follow conductor checkpoint model with explicit pause points and approval gates.
- GUD-003: Enforce subagent scope control and invocation constraints (restricted `agents` lists / Task-based delegation semantics).
- GUD-004: Skills must be trigger-driven and, where delegated, follow skill-powered subagent behavior.
- GUD-005: Include rationalization-prevention checks for verification evidence quality.

## Source Guidelines to Incorporate (agents-personal)
These sources are mandatory inputs for this phase and must be explicitly cited in Phase 1 artifacts:
- `C:/Users/s1058662/repos/agents-personal/README.md`
- `C:/Users/s1058662/repos/agents-personal/templates/README.md`
- `C:/Users/s1058662/repos/agents-personal/docs/architecture/ADR-001-orchestration-and-subagents.md`
- `C:/Users/s1058662/repos/agents-personal/docs/architecture/ADR-002-task-centric-persistence.md`
- `C:/Users/s1058662/repos/agents-personal/docs/architecture/ADR-004-skill-powered-subagents.md`
- `C:/Users/s1058662/repos/agents-personal/docs/architecture/ADR-005-ide-compatibility.md`
- `C:/Users/s1058662/repos/agents-personal/docs/architecture/ADR-007-rationalization-prevention.md`
- `C:/Users/s1058662/repos/agents-personal/docs/synthesis/skills.md`

## Detailed File Changes (Phase 1 Deliverables)
All Phase 1 outputs are created under `.tasks/005-pm-agent-system/`.

1. Create `.tasks/005-pm-agent-system/artifacts/phase-1/phase-1-reuse-map.md`
- Content:
  - Canonical reusable patterns for BusinessAnalyst and Worker.
  - Reuse decision table: keep/adapt/defer for each identified pattern.
  - Explicit constraints for PM read-only orchestration adaptation.

2. Create `.tasks/005-pm-agent-system/artifacts/phase-1/phase-1-orchestration-skill-invocation-guidelines.md`
- Content:
  - Extracted rule set from README + ADRs for:
    - orchestration checkpoints,
    - subagent scope restrictions,
    - skill trigger and delegation behavior,
    - invocation patterns (VS Code and CC semantics),
    - rationalization-prevention expectations.
  - Requirement-to-source mapping table.

3. Create `.tasks/005-pm-agent-system/artifacts/phase-1/phase-1-interface-map.md`
- Content:
  - Input/output contract map between agents-personal artifacts and 2026_01_VIP paths:
    - `learning_base/`, `docs/`, `diagrams/`, `images/diagrams/`, `specs/`, `.tasks/`.
  - Handoff compatibility matrix for later phases (skills, specialists, PM layer).

4. Update `.tasks/005-pm-agent-system/task.md`
- Changes during execution of this plan:
  - Keep Phase 1 status synchronized using plan-only governance (`📋 Planned` -> `⭐ Reviewed`; `✅ Done` deferred until Builder execution, evidence completion, and CP-4 acceptance).
  - Reviewer owns transition to `⭐ Reviewed`; Builder or designated implementer owns transition to `✅ Done`.
  - Add links to produced Phase 1 artifacts in notes or dedicated subsection.

## Implementation Steps
1. Baseline source capture
- Read required agents-personal README/docs sources and extract atomic constraints into a working checklist.
- Record each constraint with source file and heading reference.

2. Reuse mapping for existing roles
- Analyze reusable structures from BusinessAnalyst and Worker conventions.
- Classify each candidate as:
  - Reuse as-is
  - Reuse with adaptation for PM system
  - Out of scope for this project

3. Orchestration/skills/invocation compliance codification
- Build a consolidated guideline matrix covering:
  - Conductor-style checkpoints and pause decisions.
  - Subagent invocation boundaries and allowed agent lists.
  - Skill-trigger semantics and subagent skill invocation pattern.
  - IDE compatibility constraints where behavior differs by platform.

4. Repository interface mapping
- Map where PM-system outputs must land in 2026_01_VIP.
- Define expected artifact formats and handoff boundaries for later phases.

5. Artifact publication under `.tasks`
- Write three Phase 1 artifacts in `artifacts/phase-1/`.
- Update task tracking status and ensure cross-links exist.

## Dependencies
- DEP-001: Read access to `C:/Users/s1058662/repos/agents-personal`.
- DEP-002: Existing planning context in `.tasks/005-pm-agent-system/task.md`.
- DEP-003: 2026_01_VIP repository structure for interface mapping.

## Risks and Mitigations
- RISK-001: Guideline drift between README and ADR details.
- MIT-001: Resolve by source-priority note in artifacts (ADR + amended docs take precedence over older prose).

- RISK-002: Over-generalized mappings that miss PM-specific constraints.
- MIT-002: Require explicit PM read-only orchestration checks in each artifact.

- RISK-003: Incomplete invocation-behavior capture across VS Code/CC.
- MIT-003: Include dedicated platform-variance subsection and cite ADR-005.

## Success Criteria
- SC-001: Three artifacts are created under `.tasks/005-pm-agent-system/artifacts/phase-1/` with source-backed mappings.
- SC-002: Reuse decisions for BusinessAnalyst and Worker are explicit and actionable for Phase 2-5 implementation.
- SC-003: Orchestration/skill/invocation guideline matrix includes mandatory checkpoints, scope restrictions, and trigger rules.
- SC-004: Interface map aligns agents-personal outputs to concrete 2026_01_VIP directories and artifact expectations.
- SC-005: `task.md` reflects current Phase 1 state and links to this plan.
- SC-006: Traceability threshold met: each major guideline category (checkpoints, subagent scope, skill triggers, invocation patterns, IDE compatibility, rationalization prevention) maps to at least one source citation.
- SC-007: Every reuse decision row includes at least one source reference to agents-personal README/docs/ADRs.
- SC-008: Orchestration boundary threshold met: Phase 1 deliverables list only `.tasks/005-pm-agent-system/...` outputs and no non-`.tasks/` write targets.

## Verification
### Automated Checks
- Confirm plan and artifact paths exist:
  - `rg --files .tasks/005-pm-agent-system`
- Confirm mandatory guideline sources are referenced in artifacts:
  - `rg "agents-personal|ADR-001|ADR-002|ADR-004|ADR-005|ADR-007|templates/README" .tasks/005-pm-agent-system/artifacts/phase-1`
- Confirm task status row and plan link are present:
  - `rg "Baseline and Reuse Mapping|phase-1-baseline-reuse-mapping.md|📋 Planned|⭐ Reviewed|✅ Done" .tasks/005-pm-agent-system/task.md`
- Confirm Phase 1 write-target declarations remain `.tasks`-only:
  - `rg "^([0-9]+)\\. (Create|Update) " .tasks/005-pm-agent-system/plan/phase-1-baseline-reuse-mapping.md`
  - Reviewer check: each matched Create/Update path starts with `.tasks/005-pm-agent-system/`.

### Manual Verification Steps
1. Open `phase-1-orchestration-skill-invocation-guidelines.md` and verify each critical rule has at least one direct source citation.
2. Open `phase-1-reuse-map.md` and confirm BusinessAnalyst/Worker reuse decisions are not ambiguous.
3. Open `phase-1-interface-map.md` and verify every mapped output path exists in 2026_01_VIP or is clearly marked as future artifact location.
4. Confirm no files outside `.tasks/` were modified.
5. In this plan file, verify the Phase 1 deliverables section lists only `.tasks/005-pm-agent-system/...` outputs (no non-`.tasks/` write targets).

### Success Evidence
- The phase can be handed to Builder with no additional discovery needed for baseline/reuse/compliance mapping.
- A reviewer can trace every orchestration/skill/invocation rule back to agents-personal README/docs.

## Tests
Not applicable for this phase because it is planning/research-output work only and does not introduce executable behavior changes.
