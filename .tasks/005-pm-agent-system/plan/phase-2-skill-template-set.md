---
goal: Phase 2 - Skill Template Set
phase: 2
date_created: 2026-03-18
last_updated: 2026-03-18
owner: Explorer
status: Planned
tags: [planning, skills, orchestration, invocation, governance]
---

# Phase 2 Plan: Skill Template Set

## Goal
Define five implementation-ready skill template specifications for the PM agent system with strict governance alignment to agents-personal orchestration, subagent invocation, and skill behavior rules.

## Scope
- In scope:
  - Produce skill contracts for:
    - `resource-ingestion`
    - `stakeholder-feedback`
    - `requirements-cascade`
    - `backlog-management`
    - `diagram-generation`
  - Define trigger phrases, required inputs, output schemas, and handoff contracts per skill.
  - Define template/frontmatter requirements for Copilot and CC generation compatibility.
  - Define verification gates and evidence requirements for plan-only handoff to Builder.
  - Create Phase 2 planning artifacts only under `.tasks/005-pm-agent-system/`.
- Out of scope:
  - Creating or editing skill templates in `C:/Users/s1058662/repos/agents-personal/templates/skills/`.
  - Running `make`, `install.sh`, or any generation workflow.
  - Modifying non-`.tasks/` files in `2026_01_VIP` or `agents-personal`.

## Checkpoints (Plan-Only Governance)
| Checkpoint | Owner | Required Evidence | Decision Options |
| --- | --- | --- | --- |
| CP-2.1 Skill Contract Coverage | Explorer | Five-skill contract table with triggers, IO schema, and handoff ownership | Proceed, Rework, Defer |
| CP-2.2 Source Alignment | Reviewer (human) | Source traceability matrix artifact at `.tasks/005-pm-agent-system/artifacts/phase-2/phase-2-source-traceability-matrix.md` with minimum columns: `skill rule`, `source doc`, `source clause`, `implementation note`, `verification evidence` | Approve, Request Changes |
| CP-2.3 Invocation and Orchestration Compliance | Reviewer (human) | Explicit subagent invocation + checkpoint compatibility statements per skill | Approve, Request Changes |
| CP-2.4 Plan-Only Boundary Check | Explorer + Reviewer | Evidence that all Phase 2 file writes are inside `.tasks/005-pm-agent-system/` | Approve, Request Changes, Defer |
| CP-2.5 Skill Intent Separation and Escalation Gate | Reviewer (human) | Acceptance record confirming all five skills have non-overlapping primary intent and exactly one escalation path each | Approve, Request Changes |

## Status Governance (Plan-Only Mode)
- `📋 Planned` is set when this phase plan is created and linked from task tracking.
- `⭐ Reviewed` is set after CP-2.2, CP-2.3, and CP-2.5 are accepted by reviewer.
- `✅ Done` is reserved for Builder execution plus verification evidence; Explorer does not set this during planning.

## Requirements and Constraints
- REQ-201: Define exactly five skill templates matching Phase 2 scope names.
- REQ-202: Each skill specification must include purpose, trigger phrases, input contract, output contract, and delegation/handoff contract.
- REQ-203: Each output contract must map to concrete `2026_01_VIP` target locations (for produced artifacts) and required metadata.
- REQ-204: Skill behavior must align with agents-personal skill methodology, including trigger-driven activation and no overlap ambiguity.
- REQ-205: Skill specifications must include orchestration compatibility rules for checkpointed workflows coordinated by ProjectManager/Conductor patterns.
- REQ-206: Skill specifications must include invocation behavior guidance compatible with both Copilot and CC styles.
- CON-201: This phase remains planning-only; no production template edits.
- CON-202: Writes are restricted to `.tasks/005-pm-agent-system/**`.
- GUD-201: Follow task-centric persistence and phase-linking conventions from ADR-002.
- GUD-202: Maintain subagent and orchestration constraints from ADR-001.
- GUD-203: Maintain skill-powered delegation semantics from ADR-004.
- GUD-204: Maintain IDE compatibility rules from ADR-005.
- GUD-205: Include rationalization-prevention evidence expectations from ADR-007.

## Source Guidelines to Incorporate (agents-personal)
Mandatory source set for this phase:
- `C:/Users/s1058662/repos/agents-personal/README.md`
- `C:/Users/s1058662/repos/agents-personal/templates/README.md`
- `C:/Users/s1058662/repos/agents-personal/docs/architecture/ADR-001-orchestration-and-subagents.md`
- `C:/Users/s1058662/repos/agents-personal/docs/architecture/ADR-002-task-centric-persistence.md`
- `C:/Users/s1058662/repos/agents-personal/docs/architecture/ADR-004-skill-powered-subagents.md`
- `C:/Users/s1058662/repos/agents-personal/docs/architecture/ADR-005-ide-compatibility.md`
- `C:/Users/s1058662/repos/agents-personal/docs/architecture/ADR-007-rationalization-prevention.md`
- `C:/Users/s1058662/repos/agents-personal/docs/synthesis/skills.md`

## Detailed File Changes (Phase 2 Deliverables)
All writes in this phase are limited to `.tasks/005-pm-agent-system/`.

1. Create `.tasks/005-pm-agent-system/artifacts/phase-2/phase-2-skill-contracts.md`
- Content:
  - One section per skill with:
    - Objective and non-goals.
    - Trigger phrase catalog (minimum 5 phrase variants per skill).
    - Input schema (required/optional fields, accepted sources).
    - Output schema (artifact paths, required metadata keys, naming conventions).
    - Handoff contract (upstream caller, downstream consumers, checkpoint interaction).
  - Cross-skill overlap table and disambiguation rules.

2. Create `.tasks/005-pm-agent-system/artifacts/phase-2/phase-2-template-specs.md`
- Content:
  - Per-skill template skeleton spec for `templates/skills/{skill}/SKILL.template.md`.
  - Required frontmatter fields (`name`, `description`, optional `cc` additions).
  - Required shared body blocks and any platform-specific directive needs.
  - Explicit prohibition of nested/invalid directives per templates README validation rules.

3. Create `.tasks/005-pm-agent-system/artifacts/phase-2/phase-2-orchestration-invocation-map.md`
- Content:
  - Skill-to-agent invocation matrix:
    - direct activation by user prompt,
    - activation via subagent prompt containing trigger keywords,
    - disallowed invocation contexts.
    - allowed caller role and disallowed caller role per skill.
  - Copilot vs CC invocation notation requirements.
  - Canonical invocation examples:
    - At least one canonical invocation example per skill for Copilot and one for CC.
    - Each canonical example must state allowed caller role, disallowed caller role, and expected checkpoint pause behavior.
  - Checkpoint compatibility statements for each workflow that consumes these skills.

4. Create `.tasks/005-pm-agent-system/artifacts/phase-2/phase-2-source-traceability-matrix.md`
- Content:
  - One row per normative skill rule in Phase 2 artifacts.
  - Required minimum columns:
    - `skill rule`
    - `source doc`
    - `source clause`
    - `implementation note`
    - `verification evidence`
  - Source coverage must reference agents-personal README/docs/templates materials listed in this plan.

5. Update `.tasks/005-pm-agent-system/task.md`
- Keep Phase 2 status synchronized using plan-only governance:
  - `⬜ Not Started` -> `📋 Planned` with plan link.
  - `⭐ Reviewed`/`✅ Done` deferred until reviewer/builder stages.
- Add Phase 2 note indicating governance alignment requirement to agents-personal README/ADRs.

## Implementation Steps
1. Build skill contract backbone
- Define common contract schema used by all five skills:
  - `Skill ID`
  - `Intent`
  - `Trigger Catalog`
  - `Inputs`
  - `Outputs`
  - `Checkpoint Touchpoints`
  - `Invocation Patterns`
  - `Failure/Escalation Conditions`

2. Specify each skill in detail
- `resource-ingestion`:
  - Inputs: links, documents, raw notes, email/chat extracts.
  - Outputs: normalized ingestion summaries with source attribution for `learning_base` placement.
  - Handoffs: ProductOwner and BusinessAnalyst intake support.
- `stakeholder-feedback`:
  - Inputs: stakeholder comments, issue notes, meeting notes.
  - Outputs: structured VoC records and prioritized requirement signals.
  - Handoffs: ProductOwner backlog grooming and requirements-cascade kickoff.
- `requirements-cascade`:
  - Inputs: changed requirements + impacted-document registry.
  - Outputs: ordered update plans by dependency sequence (without applying edits in plan-only mode).
  - Handoffs: Worker/Builder execution queues and review obligations.
- `backlog-management`:
  - Inputs: candidate stories, constraints, priorities, phase targets.
  - Outputs: prioritized backlog slices with MoSCoW and phase mapping metadata.
  - Handoffs: ScrumMaster planning flow.
- `diagram-generation`:
  - Inputs: workflow/content deltas requiring visual update.
  - Outputs: diagram change specifications, required `.mmd`/`.drawio` and render steps, manifest touchpoints.
  - Handoffs: UIUXDesigner execution with Mermaid lifecycle compliance.

3. Encode template-generation constraints
- For each planned skill template, define:
  - Copilot-compatible frontmatter fields.
  - CC optional additions in `cc:` block where needed.
  - Directive usage constraints (`COPILOT-ONLY`, `CC-ONLY`, `SHARED`) only when platform content differs.
  - Trigger phrase coverage in `description` to support auto-activation behavior.

4. Encode orchestration and invocation compatibility
- Map each skill to valid call paths:
  - User prompt -> direct agent response.
  - Agent -> subagent prompt with skill trigger keywords (ADR-004 pattern).
  - Prohibited direct execution contexts (where role boundaries deny action).
- For each skill, define canonical invocation examples for Copilot and CC that include:
  - allowed caller role,
  - disallowed caller role,
  - expected checkpoint pause behavior.
- Define checkpoint insertion points where skill outputs must pause for approval before downstream execution.

5. Publish artifacts and update phase tracking
- Write all Phase 2 artifacts into `.tasks/005-pm-agent-system/artifacts/phase-2/`.
- Update `task.md` Phase 2 row and notes to indicate `📋 Planned` state.

## Dependencies
- DEP-201: Phase 1 baseline plan and governance decisions.
- DEP-202: Read access to required agents-personal README/templates/ADR/synthesis sources.
- DEP-203: Existing 2026_01_VIP artifact locations (`learning_base`, `docs`, `diagrams`, `images/diagrams`, `specs`, `.tasks`).

## Risks and Mitigations
- RISK-201: Skill boundaries overlap and cause ambiguous activation.
- MIT-201: Include overlap matrix with explicit disambiguation priority and trigger exclusions.

- RISK-202: Platform-specific invocation guidance drifts between Copilot and CC.
- MIT-202: Maintain side-by-side invocation mapping and directive usage checks against templates README and ADR-005.

- RISK-203: Phase plan omits orchestration checkpoint integration.
- MIT-203: Require checkpoint touchpoint field for each skill and verify in CP-2.3.

- RISK-204: Planning artifacts accidentally prescribe out-of-scope writes.
- MIT-204: Enforce explicit write-target audit where all create/update paths are `.tasks/005-pm-agent-system/**`.

## Success Criteria
- SC-201: A complete five-skill contract set exists with triggers, IO, and handoff contracts.
- SC-202: Each skill output schema explicitly maps outputs to `learning_base`, `docs`, `diagrams`, and `images/` target locations where applicable, or records a justified exception with rationale in the source traceability matrix.
- SC-203: Template specs are generation-ready and aligned with templates README validation constraints.
- SC-204: Orchestration/invocation map demonstrates compatibility with checkpointed delegation patterns.
- SC-205: Phase 2 is marked `📋 Planned` in `task.md` and linked to this plan.
- SC-206: Traceability threshold met: each skill section contains at least one reference to the mandatory source set.
- SC-207: Boundary threshold met: all defined Phase 2 write actions are `.tasks`-only.
- SC-208: Acceptance gate passed: reviewer confirms all five skills have non-overlapping primary intent and exactly one escalation path each.

## Verification
### Automated Checks
- Confirm Phase 2 plan and task link exist:
  - `rg "Skill Template Set|phase-2-skill-template-set.md|📋 Planned" .tasks/005-pm-agent-system`
- Confirm mandatory source references are present in this plan:
  - `rg "agents-personal|ADR-001|ADR-002|ADR-004|ADR-005|ADR-007|templates/README|docs/synthesis/skills" .tasks/005-pm-agent-system/plan/phase-2-skill-template-set.md`
- Confirm traceability matrix file and required columns are declared:
  - `rg "phase-2-source-traceability-matrix.md|skill rule|source doc|source clause|implementation note|verification evidence" .tasks/005-pm-agent-system/plan/phase-2-skill-template-set.md`
- Confirm canonical invocation example requirements for both platforms are declared:
  - `rg "canonical invocation|Copilot|CC|allowed caller role|disallowed caller role|checkpoint pause behavior" .tasks/005-pm-agent-system/plan/phase-2-skill-template-set.md`
- Confirm all declared file create/update targets are `.tasks`-scoped:
  - `rg "^([0-9]+)\. (Create|Update) " .tasks/005-pm-agent-system/plan/phase-2-skill-template-set.md`
  - reviewer check: each matched path starts with `.tasks/005-pm-agent-system/`.

### Manual Verification Steps
1. Review `phase-2-skill-template-set.md` and verify all five required skills are explicitly defined with non-overlapping scope.
2. Confirm each skill includes trigger catalog, input/output schema, and handoff contract.
3. Confirm invocation guidance includes both direct trigger usage and subagent skill-trigger pattern.
4. Confirm orchestration checkpoint compatibility is explicitly described for downstream workflows.
5. Confirm no files outside `.tasks/` were modified while preparing this phase plan.
6. Confirm reviewer acceptance gate evidence exists for non-overlapping primary intent and one escalation path per skill.

### Success Evidence
- Builder can implement Phase 2 without additional discovery on skills/orchestration/invocation rules.
- Reviewer can trace Phase 2 guidance back to required agents-personal sources.

## Tests
Not applicable for this phase because it is planning-only documentation work and introduces no executable behavior.
