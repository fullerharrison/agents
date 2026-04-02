---
artifact: phase-5-source-traceability-matrix
phase: 5
created: 2026-03-18
status: reviewed
tags: [traceability, source-mapping, citations, compliance, verification]
---

# Phase 5 Artifact: Source Traceability Matrix

## Overview

This matrix traces every normative design decision in Phase 5 artifacts to the authoritative source document and clause. Minimum coverage requirements from the phase plan are all satisfied.

---

## Traceability Matrix

| PM Rule | Source Doc | Source Clause | Implementation Note | Verification Evidence |
| --- | --- | --- | --- | --- |
| ProjectManager role charter: orchestration-only, no direct edits/execution | `learning_base/ideas/pm_agent_coordination_system_implementation_plan.md` | Section 4: ProjectManager Responsibilities | PM is defined as read-only orchestrator in `phase-5-projectmanager-spec.md` Role Charter section. Non-goals explicitly listed: no architecture decisions, no code execution, no direct task work | Read `phase-5-projectmanager-spec.md` Role Charter; confirm "non-goals" paragraph is present and comprehensive |
| ProjectManager permission tier: Tier O (orchestration-only, read-only, no write/execute) | `learning_base/ideas/pm_agent_coordination_system_implementation_plan.md` | Section 8: Agent Access Summary | Tier O assigned in `phase-5-projectmanager-spec.md` Permission Tier section; also encoded in template skeleton `disallowedTools` | Check `phase-5-projectmanager-spec.md` Permission Tier table; confirm Tier O row; confirm write=None, execute=None |
| ProjectManager `disallowedTools` must include Bash, terminal/runInTerminal, Write, Edit, MultiEdit, Task | `learning_base/ideas/pm_agent_coordination_system_implementation_plan.md` | Section 8: Agent Access Summary + REQ-509 | Explicitly listed in `phase-5-projectmanager-template-skeleton.md` CC block `disallowedTools` array with per-tool rationale | Check template skeleton CC block; confirm all six tools present in `disallowedTools` |
| Entry Gate pattern: PM receives all workflow requests before routing | `agents-personal/templates/agents/conductor.template.md` | `## ⚠️ Entry Gate` section | PM Entry Gate section in template skeleton body; keyword matching per Entry Point Decision Matrix in `phase-5-delegation-rules.md` | Check template skeleton `## ⚠️ Entry Gate` section; confirm "read task state first" and "keyword match" instructions present |
| Conductor pattern inheritance: ProjectManager extends, does not replace, conductor archetype | `agents-personal/templates/agents/conductor.template.md` | Full template; conductor constraints | `## Relationship to Conductor Pattern` section in template skeleton explicitly states what is inherited unchanged and what is extended | Check template skeleton `## Relationship to Conductor Pattern`; confirm inherited vs. extended distinction is explicit |
| `user_invokable: false` for ProjectManager | `agents-personal/docs/architecture/ADR-001-orchestration-and-subagents.md` | Worker Subagent Pattern: `user-invokable: false` | PM template skeleton frontmatter includes `user_invokable: false` in copilot block | Check template skeleton frontmatter; confirm `user_invokable: false` is present |
| Handoff button keyword structure: `label`, `agent`, `prompt`, `send` | `agents-personal/templates/README.md` | Agent template frontmatter handoffs format | All specialist agent handoff stubs in `phase-5-specialist-agent-handoff-stubs.md` use required YAML fields | Check each handoff stub; confirm all four required fields (`label`, `agent`, `prompt`, `send`) are present |
| Specialist agents must have "Escalate to ProjectManager" handoff button | Phase 4 artifacts + ADR-001 (agent scope enforcement) | Phase 4 handoff contracts; ADR-001 scope enforcement pattern | All seven specialist agents have "Escalate to ProjectManager" handoff defined in `phase-5-specialist-agent-handoff-stubs.md` | Check `phase-5-specialist-agent-handoff-stubs.md`; count 7 agent stubs; confirm each has PM escalation handoff |
| Workflow A: Resource Ingestion — entry trigger, agent sequence, checkpoints, success/failure | `learning_base/ideas/pm_agent_coordination_system_implementation_plan.md` | Section 5.1: Workflow A Resource Ingestion | Workflow A detailed in `phase-5-projectmanager-spec.md` (summary), `phase-5-orchestration-routing-matrix.md` (full routing), `phase-5-comprehensive-checkpoint-table.md` (CP-A1 through CP-A3) | Check routing matrix Workflow A section; confirm entry trigger, step sequence, CP-A1/A2/A3, and success/failure paths |
| Workflow B: Stakeholder Feedback — entry trigger, agent sequence, checkpoints, success/failure | `learning_base/ideas/pm_agent_coordination_system_implementation_plan.md` | Section 5.2: Workflow B Stakeholder Feedback | Workflow B detailed across spec, routing matrix, and checkpoint table artifacts | Check routing matrix Workflow B section; confirm CP-B1/B2/B3, guardrail mapping, VoC output location |
| Workflow C: Requirements Cascade — entry trigger, agent sequence, checkpoints, success/failure | `learning_base/ideas/pm_agent_coordination_system_implementation_plan.md` | Section 5.3: Workflow C Requirements Cascade | Workflow C detailed with four checkpoints (CP-C1 through CP-C4) and stakeholder approval gate | Check routing matrix Workflow C; confirm four checkpoints; confirm BA + FE/BE advisory structure |
| Workflow D: Diagram Lifecycle — entry trigger, agent sequence, checkpoints, success/failure | `learning_base/ideas/pm_agent_coordination_system_implementation_plan.md` | Section 5.4: Workflow D Diagram Lifecycle | Workflow D detailed with UIUXDesigner as primary agent; Mermaid and draw.io format support; CP-D1 through CP-D4 | Check routing matrix Workflow D; confirm UIUX is the only writing agent; confirm manifest update at CP-D4 |
| Workflow E: Backlog Planning — entry trigger, agent sequence, checkpoints, success/failure | `learning_base/ideas/pm_agent_coordination_system_implementation_plan.md` | Section 5.5: Workflow E Backlog Planning | Workflow E detailed with PO (MoSCoW) → SM (breakdown) two-agent sequence; CP-E1 through CP-E4 | Check routing matrix Workflow E; confirm PO then SM sequence; confirm sprint plan output path |
| Workflow F: Quality Gate Review — entry trigger, agent sequence, checkpoints, success/failure | `learning_base/ideas/pm_agent_coordination_system_implementation_plan.md` | Section 5.6: Workflow F Quality Gate Review | Workflow F detailed with QAEngineer primary; blocker escalation path (Fix/Skip/Defer); CP-F1 through CP-F4 | Check routing matrix Workflow F; confirm CP-F3 blocker escalation with three PM decision options |
| ADR-001 checkpoint model application: automated vs. human-decision checkpoints | `agents-personal/docs/architecture/ADR-001-orchestration-and-subagents.md` | Section: Mandatory pause points + `askQuestions` / `AskUserQuestion` | Two checkpoint types (automated logical gate vs. human-decision checkpoint) defined in `phase-5-projectmanager-spec.md` Checkpoint Governance Model table and in template skeleton `## Checkpoint Model` section | Check checkpoint governance model table; confirm two checkpoint types with distinct PM actions |
| Read-only tool scope for ProjectManager (Copilot + CC) | `learning_base/ideas/pm_agent_coordination_system_implementation_plan.md` | Section 8: Agent Access Summary | Copilot tools (read/readFile, search, fileSearch, webSearch, askQuestions) and CC tools (Read, LS, Glob, Grep, WebSearch, TodoRead) defined in `phase-5-projectmanager-spec.md` and template skeleton | Check spec Permission Tier section and template skeleton frontmatter; confirm no write tools in included list |
| Task-tracking integration: checkpoint-to-planning trigger rules | `learning_base/ideas/pm_agent_coordination_system_implementation_plan.md` | Section 7: Task-Tracking Compatibility | Full IF-THEN trigger rules in `phase-5-task-tracking-coordination.md`; artifact path conventions; planning tool compatibility | Check `phase-5-task-tracking-coordination.md`; confirm IF-THEN rules for each workflow (A through F); confirm canonical paths table |
| Artifact handoff format: JSON checkpoint record, markdown frontmatter, or planning-tool native | `learning_base/ideas/pm_agent_coordination_system_implementation_plan.md` | Section 7: Task-Tracking Compatibility | Three artifact formats defined in `phase-5-task-tracking-coordination.md` with format selection rule | Check Artifact Handoff Format section; confirm three formats and selection rule |
| Unknown workflow fallback: PM prompts caller for clarification when no keyword matches | Review confirmation (user-confirmed requirement) + ADR-001 Entry Gate pattern | ADR-001 Entry Gate; reviewer approval notes for Phase 5 | Unknown workflow fallback defined in `phase-5-delegation-rules.md` Entry Point Decision Matrix + `phase-5-projectmanager-template-skeleton.md` Entry Gate section | Check `phase-5-delegation-rules.md` Unknown Workflow Fallback section; confirm PM prompts with workflow menu instead of routing |
| Deterministic routing validation: keyword mutual exclusivity, explicit permission guards, deterministic tie-breaking | Phase plan REQ-504, REQ-505 + review-confirmed validation rules | Phase plan Detailed File Changes §4 (Validation Rules) | Three validation rules confirmed in `phase-5-delegation-rules.md` Deterministic Routing Validation Rules section | Check delegation rules final section; confirm all three rules are stated with confirmation of compliance |
| Conditional branching in routing matrix (if X decision, route to Y) | `learning_base/ideas/pm_agent_coordination_system_implementation_plan.md` | Section 5: PM Orchestration Workflows (conditional paths) | Conditional branches documented in `phase-5-orchestration-routing-matrix.md` for Workflows C, E, and F | Check routing matrix; confirm at least one conditional branch per workflow for C, E, F |
| Agent scope enforcement: no peer-to-peer calls; all delegation via PM | `agents-personal/docs/architecture/ADR-001-orchestration-and-subagents.md` | Section: Scope Enforcement via `agents` restriction | `disallowedTools: Task` in specialist agents prevents subagent spawning; PM is sole routing node | Check handoff stubs; confirm `disallowedTools` includes Task for FE, BE, QA, UIUX; check template skeleton delegation rules section |
| Task-centric persistence: workflow logs persist checkpoint state | `agents-personal/docs/architecture/ADR-002-task-centric-persistence.md` | Persistent state model for checkpoints | Workflow log path conventions in `phase-5-task-tracking-coordination.md` follow `.tasks/` scoped persistence model | Check artifact path conventions; confirm all workflow logs under `.tasks/005-pm-agent-system/workflow-logs/` |
| IDE tool compatibility: platform divergence directives in template | `agents-personal/docs/architecture/ADR-005-ide-compatibility.md` | IDE tool constraints and platform divergence | Template skeleton uses `<!-- COPILOT-ONLY -->` and `<!-- CC-ONLY -->` directives for platform-divergent tool routing | Check template skeleton body; confirm COPILOT-ONLY and CC-ONLY directives are present with correct platform-specific guidance |
| Evidence-based verification: verification steps must be explicit | `agents-personal/docs/architecture/ADR-007-rationalization-prevention.md` | Evidence-based verification requirements | Each row in this traceability matrix includes a "Verification Evidence" column with a specific, executable check | Check traceability matrix; confirm every row has a non-empty verification evidence instruction |
| All Phase 5 write targets restricted to `.tasks/005-pm-agent-system/**` | Phase plan CON-501 + REQ-511 | Phase plan Scope + Constraints section | All artifact paths in this matrix start with `.tasks/005-pm-agent-system/artifacts/phase-5/`; no agents-personal template files created | Check git diff; confirm no files outside `.tasks/` were created or modified during Phase 5 |

---

## Source Coverage Summary

| Coverage Target | Source | Artifact(s) Covering It |
| --- | --- | --- |
| ProjectManager role charter (Tier O, orchestration-only) | pm_impl_plan.md §4 | phase-5-projectmanager-spec.md |
| Workflow A: Resource Ingestion | pm_impl_plan.md §5.1 | spec, routing-matrix, checkpoint-table, delegation-rules |
| Workflow B: Stakeholder Feedback | pm_impl_plan.md §5.2 | spec, routing-matrix, checkpoint-table, delegation-rules |
| Workflow C: Requirements Cascade | pm_impl_plan.md §5.3 | spec, routing-matrix, checkpoint-table, delegation-rules |
| Workflow D: Diagram Lifecycle | pm_impl_plan.md §5.4 | spec, routing-matrix, checkpoint-table, delegation-rules |
| Workflow E: Backlog Planning | pm_impl_plan.md §5.5 | spec, routing-matrix, checkpoint-table, delegation-rules |
| Workflow F: Quality Gate Review | pm_impl_plan.md §5.6 | spec, routing-matrix, checkpoint-table, delegation-rules |
| ADR-001 checkpoint model application | ADR-001 | spec, routing-matrix, checkpoint-table, template-skeleton |
| Entry Gate pattern | conductor.template.md | template-skeleton (## Entry Gate + ## Relationship to Conductor Pattern) |
| Handoff button keyword structure | templates/README.md + ADR-001 | specialist-agent-handoff-stubs |
| Read-only tool scope specification | pm_impl_plan.md §8 | spec, template-skeleton |
| Seven specialist agents' handoff-to-PM requirement | Phase 4 artifacts + ADR-001 | specialist-agent-handoff-stubs |
| Task-tracking integration compatibility | pm_impl_plan.md §7 | task-tracking-coordination |
| Unknown workflow fallback | Review-confirmed + ADR-001 | delegation-rules (Unknown Workflow Fallback section) |
| Deterministic routing validation rules | Phase plan REQ-504/505 | delegation-rules (Validation Rules section) |
| IDE platform divergence directives | ADR-005 | template-skeleton (COPILOT-ONLY/CC-ONLY directives) |
| Task-centric persistence for workflow logs | ADR-002 | task-tracking-coordination (artifact path conventions) |
| Rationalization-prevention evidence expectations | ADR-007 | This traceability matrix (Verification Evidence column) |
