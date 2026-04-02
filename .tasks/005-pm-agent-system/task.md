---
task: Design project-management agent system for 2026_01_VIP using mcouthon/agents
slug: pm-agent-system
created: 2026-03-18
status: in-progress
mode: full-execution
---

# PM Agent Coordination System for 2026_01_VIP

## Phases

| # | Phase | Status | Plan | Notes |
| --- | --- | --- | --- | --- |
| 1 | Baseline and Reuse Mapping | ✅ Done | [phase-1-baseline-reuse-mapping.md](plan/phase-1-baseline-reuse-mapping.md) | Confirm reusable BusinessAnalyst and Worker patterns, target paths, and constraints in agents-personal and 2026_01_VIP. Approved after governance clarifications and aligned with agents-personal guidance. Artifacts: [reuse-map](artifacts/phase-1/phase-1-reuse-map.md), [orchestration-guidelines](artifacts/phase-1/phase-1-orchestration-skill-invocation-guidelines.md), [interface-map](artifacts/phase-1/phase-1-interface-map.md). |
| 2 | Skill Template Set | ✅ Done | [phase-2-skill-template-set.md](plan/phase-2-skill-template-set.md) | Define 5 skills: resource-ingestion, stakeholder-feedback, requirements-cascade, backlog-management, diagram-generation. Plan enforces agents-personal README/ADR alignment for skills, orchestration, and invocation behavior. Approved: plan includes traceability matrix and canonical invocation examples. Artifacts: [skill-contracts](artifacts/phase-2/phase-2-skill-contracts.md), [template-specs](artifacts/phase-2/phase-2-template-specs.md), [orchestration-invocation-map](artifacts/phase-2/phase-2-orchestration-invocation-map.md), [source-traceability-matrix](artifacts/phase-2/phase-2-source-traceability-matrix.md). |
| 3 | Specialist Agent Templates | ✅ Done | [phase-3-specialist-agent-templates.md](plan/phase-3-specialist-agent-templates.md) | Specialist agent specs, template skeletons, permission matrix, and source traceability defined. Artifacts: [specialist-agent-specs](artifacts/phase-3/phase-3-specialist-agent-specs.md), [template-skeletons](artifacts/phase-3/phase-3-template-skeletons.md), [handoff-permission-matrix](artifacts/phase-3/phase-3-handoff-permission-matrix.md), [source-traceability-matrix](artifacts/phase-3/phase-3-source-traceability-matrix.md). |
| 4 | ProductOwner and Existing-Agent Integration | ✅ Done | [phase-4-productowner-existing-agent-integration.md](plan/phase-4-productowner-existing-agent-integration.md) | ProductOwner role charter, Tier W assignment, three explicit handoff contracts (→BA, →SM, →Worker), and Worker vs ProductOwner conversion boundary defined. Approved with gated reverse handoffs and explicit traceability schema. Artifacts: [productowner-spec](artifacts/phase-4/phase-4-productowner-spec.md), [handoff-contracts-matrix](artifacts/phase-4/phase-4-handoff-contracts-matrix.md), [template-skeleton](artifacts/phase-4/phase-4-template-skeleton.md), [existing-agent-handoff-stubs](artifacts/phase-4/phase-4-existing-agent-handoff-stubs.md), [worker-vs-po-conversion-matrix](artifacts/phase-4/phase-4-worker-vs-productowner-conversion-decision-matrix.md), [source-traceability-matrix](artifacts/phase-4/phase-4-source-traceability-matrix.md). |
| 5 | ProjectManager Orchestration Layer | ✅ Done | [phase-5-projectmanager-orchestration-layer.md](plan/phase-5-projectmanager-orchestration-layer.md) | Define read-only orchestrator with checkpoint gating, workflow routing, and delegation logic across six core workflows. Includes orchestration routing matrix, checkpoint table, delegation rules, and task-tracking coordination. Approved with unknown-workflow fallback, conductor pattern clarity, and deterministic routing validation rules. Artifacts: [projectmanager-spec](artifacts/phase-5/phase-5-projectmanager-spec.md), [orchestration-routing-matrix](artifacts/phase-5/phase-5-orchestration-routing-matrix.md), [comprehensive-checkpoint-table](artifacts/phase-5/phase-5-comprehensive-checkpoint-table.md), [delegation-rules](artifacts/phase-5/phase-5-delegation-rules.md), [task-tracking-coordination](artifacts/phase-5/phase-5-task-tracking-coordination.md), [specialist-agent-handoff-stubs](artifacts/phase-5/phase-5-specialist-agent-handoff-stubs.md), [projectmanager-template-skeleton](artifacts/phase-5/phase-5-projectmanager-template-skeleton.md), [source-traceability-matrix](artifacts/phase-5/phase-5-source-traceability-matrix.md). |
| 6 | Access and Permission Governance | ✅ Done | [phase-6-access-permission-governance.md](plan/phase-6-access-permission-governance.md) | Publish access matrix and enforcement rules for read, write, execute boundaries per agent. Approved with pre-selected docs/ partition, traceable drift floor, Worker Tier-F edge case. Artifacts: [permission-tier-definitions](artifacts/phase-6/phase-6-permission-tier-definitions.md), [agent-permission-tier-table](artifacts/phase-6/phase-6-agent-permission-tier-table.md), [tooling-boundary-matrix](artifacts/phase-6/phase-6-tooling-boundary-matrix.md), [execute-scope-boundary](artifacts/phase-6/phase-6-execute-scope-boundary.md), [enforcement-mechanisms](artifacts/phase-6/phase-6-enforcement-mechanisms.md), [cross-agent-consistency-check](artifacts/phase-6/phase-6-cross-agent-consistency-check.md), [drift-detection-checklist](artifacts/phase-6/phase-6-drift-detection-checklist.md), [source-traceability-matrix](artifacts/phase-6/phase-6-source-traceability-matrix.md). |
| 7 | Workflow Contracts and Planner Compatibility | ✅ Done | [phase-7-workflow-contracts-planner-compatibility.md](plan/phase-7-workflow-contracts-planner-compatibility.md) | Define end-to-end workflow contracts, artifact schemas, and planning/task tracking compatibility outputs. Approved with verified CSV schema step, provenance-as-file-record, CP-A* naming enforced. Artifacts: [workflow-contracts](artifacts/phase-7/phase-7-workflow-contracts.md), [handoff-document-template](artifacts/phase-7/phase-7-handoff-document-template.md), [io-format-spec](artifacts/phase-7/phase-7-io-format-spec.md), [compatibility-verification-matrix](artifacts/phase-7/phase-7-compatibility-verification-matrix.md), [source-traceability-matrix](artifacts/phase-7/phase-7-source-traceability-matrix.md). CSV schema audited: N=22 columns (2026-03-18). |
| 8 | Pilot Validation and Integration Testing | ✅ Done | [phase-8-pilot-validation-integration-testing.md](plan/phase-8-pilot-validation-integration-testing.md) | Execute scenario-based validation for the 2026_01_VIP pilot, including permission and handoff integrity tests. Approved with Worker Tier F fix, numeric go thresholds, advisor cascade scenarios added. Artifacts: [validation-plan](artifacts/phase-8/phase-8-validation-plan.md), [integration-test-matrix](artifacts/phase-8/phase-8-integration-test-matrix.md), [scenario-test-cases](artifacts/phase-8/phase-8-scenario-test-cases.md), [worker-tier-f-fix-verification](artifacts/phase-8/phase-8-worker-tier-f-fix-verification.md), [advisor-cascade-scenarios](artifacts/phase-8/phase-8-advisor-cascade-scenarios.md), [pilot-report-template](artifacts/phase-8/phase-8-pilot-report-template.md), [source-traceability-matrix](artifacts/phase-8/phase-8-source-traceability-matrix.md). |
| 9 | PR Creation and Merge Coordination | ✅ Done | [phase-9-pr-creation-merge-coordination.md](plan/phase-9-pr-creation-merge-coordination.md) | PR #1 merged to fullerharrison/agents-personal main branch (SHA: 03b2c0e, merge commit, 2026-03-19). Phase 12 (Pilot Operations) unblocked. Artifacts: [pr-merge-coordination-record](artifacts/phase-9/pr-merge-coordination-record.md), [source-traceability-matrix](artifacts/phase-9/phase-9-source-traceability-matrix.md). |
| 11 | Pilot Validation Execution | ✅ Done | [phase-11-pilot-validation-execution.md](plan/phase-11-pilot-validation-execution.md) | Execute all 39 test scenarios across five streams (S-E2E, S-PB, S-CS, S-QG, S-AC). Produce all seven mandatory evidence artifacts (E1–E7). Pilot readiness decision: **GO**. All Go thresholds met; 0 permission violations; 0 critical failures. Evidence package ready for Phase 9 consumption. Artifacts: [e2e-execution-log](artifacts/phase-11/e2e-execution-log.md), [permission-boundary-results](artifacts/phase-11/permission-boundary-results.md), [checkpoint-smoke-results](artifacts/phase-11/checkpoint-smoke-results.md), [quality-gate-pass-log](artifacts/phase-11/quality-gate-pass-log.md), [quality-gate-fail-log](artifacts/phase-11/quality-gate-fail-log.md), [artifact-compatibility-results](artifacts/phase-11/artifact-compatibility-results.md), [pilot-readiness-report](artifacts/phase-11/pilot-readiness-report.md). |
| 12 | Pilot Operations | ⬜ Not Started | — | Deploy and activate the PM agent system in the 2026_01_VIP pilot environment. Unblocked 2026-03-19 — Phase 9 merge complete (SHA: 03b2c0e). |

**Status:** ⬜ Not Started → 📋 Planned → ⭐ Reviewed → 🔄 In Progress → ✅ Done

## Overview

Design a coordinated multi-agent project-management system for 2026_01_VIP using the mcouthon/agents template framework in C:/Users/s1058662/repos/agents-personal. The system must ingest stakeholder and developer inputs, maintain requirements alignment over time, generate and maintain diagrams, and keep backlog/sprint planning quality stable through explicit quality gates.

## Goal

Deliver a phased, implementation-ready architecture for a PM-led agent team with clear role boundaries, constrained permissions, reusable existing agents, and robust end-to-end workflow orchestration that remains compatible with current planning and task-tracking processes.

## Scope and Constraints

- Primary implementation target is the agents-personal template system, while 2026_01_VIP remains the domain repository and pilot validation target.
- ProjectManager remains read-only and orchestration-only.
- Most agents are constrained to search, research, planning, and review work.
- Write and execute permissions are granted only where explicitly required.
- Checkpoint-based orchestration is mandatory in all multi-agent workflows.
- This task record is planning-only and does not implement production template/code changes.

## Research Findings

### Core Reference Inputs

- Primary plan source defines architecture, required agents, skills, workflows, and sequencing: .tasks/005-pm-agent-system/pm_agent_coordination_system_implementation_plan.md.
- Documentation cascade dependencies and review obligations are defined in learning_base/REVIEW_WORKFLOW.md.
- Mermaid lifecycle requirements are defined in .github/copilot-instructions.md.
- Agent template and generation conventions are defined in C:/Users/s1058662/repos/agents-personal/templates/README.md.
- Orchestrator pattern baseline is defined in C:/Users/s1058662/repos/agents-personal/templates/agents/conductor.template.md.
- Existing role-agent conventions and write-limited pattern are defined in C:/Users/s1058662/repos/agents-personal/templates/agents/business-analyst.template.md.

### Required Agent Set

- ProjectManager (orchestrator, read-only, delegates work).
- ProductOwner (limited write, stakeholder intake and backlog).
- ScrumMaster (planning and execution cadence; reuse existing agent where possible).
- FrontendDev (read-only advisor).
- BackendDev (read-only advisor).
- QAEngineer (read plus test execution, no code edits).
- UIUXDesigner (write plus diagram generation).
- Reused agents where applicable: BusinessAnalyst and Worker.

### Workflow Coverage Required

- Resource ingestion from emails, chats, docs, and links into learning_base.
- Stakeholder feedback processing into structured Voice of Customer outputs.
- Requirements cascade updates across downstream dependent documents.
- Diagram lifecycle management for Mermaid and draw.io artifacts.
- Sprint/backlog planning with MoSCoW and phase alignment.
- Quality gate loops with checkpointed decisions and review outcomes.

## Phase Details

### Phase 1: Baseline and Reuse Mapping

Summary: establish canonical template sources, reusable agents, and repository interface boundaries.

Deliverables:
- Source map of reusable template patterns for orchestrator and role agents.
- Inventory of current 2026_01_VIP planning and documentation touchpoints.
- Confirmed interface map between agents-personal outputs and 2026_01_VIP workflow artifacts.

Exit criteria:
- Reuse points for BusinessAnalyst and Worker are explicitly mapped.
- Orchestrator constraints and checkpoint model are documented for PM adaptation.

### Phase 2: Skill Template Set

Summary: define skill contracts that power ingestion, feedback normalization, requirement cascade, backlog control, and diagram lifecycle.

Deliverables:
- Skill template outlines for resource-ingestion, stakeholder-feedback, requirements-cascade, backlog-management, diagram-generation.
- Input-output schemas per skill, including expected save locations and metadata.
- Trigger phrase catalog and handoff expectations per skill.

Exit criteria:
- Every required workflow has at least one mapped skill contract.
- Skill outputs map to concrete learning_base, docs, diagrams, and images locations.

### Phase 3: Specialist Agent Templates

Summary: define specialist advisor and executor agents with strict role boundaries.

Deliverables:
- FrontendDev template design (read-only advisory scope).
- BackendDev template design (read-only advisory scope).
- QAEngineer template design (read plus test execution, no edit scope).
- UIUXDesigner template design (write plus diagram generation scope).

Exit criteria:
- Role charters, tool scopes, and output contracts are explicit and non-overlapping.
- Diagram responsibilities are isolated to UIUXDesigner with required workflow compliance.

### Phase 4: ProductOwner and Existing-Agent Integration

Summary: define ProductOwner capabilities and explicit delegation contracts to BusinessAnalyst, ScrumMaster, and Worker.

Deliverables:
- ProductOwner template design for intake triage, VoC structuring, and backlog maintenance.
- Handoff matrix covering ProductOwner → BusinessAnalyst, ProductOwner → ScrumMaster, ProductOwner → Worker.
- Rules for when Worker handles conversion versus ProductOwner direct processing.

Exit criteria:
- Stakeholder intake and backlog grooming flow is end-to-end defined.
- Existing-agent reuse is explicit, with no duplicated responsibilities.

### Phase 5: ProjectManager Orchestration Layer

Summary: define PM orchestration contracts, workflow routing, and checkpoint controls across all agents.

Deliverables:
- ProjectManager template design based on conductor-style entry gate and checkpoint enforcement.
- Workflow definitions for all core operations (ingestion, feedback, cascade, diagrams, sprint planning, quality gate).
- Decision-state model for pause, approval, continue, and escalation.

Exit criteria:
- Each workflow has checkpointed handoffs and explicit termination/success conditions.
- PM is fully orchestration-only with no direct edit/execute authority.

### Phase 6: Access and Permission Governance

Summary: formalize and verify the permission model that enforces role boundaries.

Deliverables:
- Per-agent access/permission matrix (read, write, execute, delegated tools).
- Boundary rules for disallowed actions by role.
- Governance checklist for permission drift detection.

Exit criteria:
- Every required agent has an approved permission profile.
- Enforcement points are documented for template, generation, and runtime usage.

### Phase 7: Workflow Contracts and Planner Compatibility

Summary: define durable workflow artifacts compatible with planning and tracking processes.

Deliverables:
- End-to-end workflow definitions and handoff contracts.
- Structured output schema for backlog/sprint artifacts with MoSCoW and phase mapping.
- Compatibility specification for planner/task tracking exports used in 2026_01_VIP processes.

Exit criteria:
- Workflow artifacts are traceable from intake to planning outputs.
- Sprint/backlog outputs remain consumable by existing planning workflows.

### Phase 8: Pilot Validation and Integration Testing

Summary: validate the full agent system in the 2026_01_VIP pilot using scenario-driven integration tests.

Deliverables:
- Validation plan spanning happy path, permission boundaries, and failure escalation.
- Integration test matrix covering handoffs, checkpoint gating, cascade updates, and diagram lifecycle.
- Pilot report template for readiness and rollout decision.

Exit criteria:
- All critical workflows demonstrate successful end-to-end execution.
- Permission constraints and checkpoint controls are proven in test evidence.
- Pilot recommendation is documented: go, conditional-go, or hold.

## Validation and Integration Test Plan (Pilot)

### Test Streams

1. Workflow E2E tests:
- Ingest mixed resources into learning_base, classify, and trigger cascade checks.
- Process stakeholder feedback into VoC, then verify requirements update routing.
- Run sprint planning flow from backlog prioritization through QA test-plan generation.

2. Permission boundary tests:
- Verify read-only advisors cannot write.
- Verify QA can execute tests but cannot edit files.
- Verify PM cannot edit or execute and only delegates.
- Verify UIUXDesigner can run allowed diagram generation workflow.

3. Quality gate tests:
- PASS path: QA pass updates planning state.
- FAIL path: escalation to technical advisors and revised plan checkpoint.

4. Artifact compatibility tests:
- Verify backlog and sprint outputs align with existing planning/task-tracking formats.
- Verify outputs map to expected repository paths and naming conventions.

### Evidence Required

- Handoff logs per workflow stage.
- Checkpoint approvals with decision outcomes.
- Permission-denied evidence for disallowed actions.
- Generated artifact samples for VoC, backlog, sprint plan, and diagram lifecycle updates.

## Out of Scope

- Implementing agent templates, skills, or generated outputs in this planning step.
- Running make/install/generation commands in agents-personal during this planning step.
- Modifying non-.tasks files in 2026_01_VIP during this planning step.
