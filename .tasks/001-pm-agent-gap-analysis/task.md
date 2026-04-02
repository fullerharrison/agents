---
task: Investigate PM custom-agent coordination failures vs known-good baseline
slug: pm-agent-gap-analysis
created: 2026-03-19
status: done
---

# PM Agent Coordination Gap Analysis

## Phases

| # | Phase | Status | Plan | Notes |
| --- | --- | --- | --- | --- |
| 1 | Evidence Collection and Repro Mapping | ✅ Done | [phase-1-evidence-collection-and-repro-mapping.md](plan/phase-1-evidence-collection-and-repro-mapping.md) | Completed; committed evidence: `docs/research/pm-agent-gap-analysis/phase-1`. |
| 2 | Baseline Orchestration Mapping (Known-Good) | ✅ Done | [phase-2-baseline-orchestration-mapping-known-good.md](plan/phase-2-baseline-orchestration-mapping-known-good.md) | Baseline evidence package committed with 8 artifacts; all BAS-* families populated; Phase 1 crosswalk complete. |
| 3 | Gap Analysis and Root-Cause Isolation | ✅ Done | [phase-3-gap-analysis-and-root-cause-isolation.md](plan/phase-3-gap-analysis-and-root-cause-isolation.md) | 6 evidence artifacts produced; 7 GAP-* rows (one per BAS-XREF), 7 RC-* rows (all categories observed), 15 LINK-* rows, 4 COV-* rows fully populated; no blockers detected. |
| 4 | Remediation Options and Decision Package | ✅ Done | [phase-4-remediation-options-and-decision-package.md](plan/phase-4-remediation-options-and-decision-package.md) | Completion note: remediation decision package with REMOPT-A and REMOPT-B options, 7 evidence artifacts produced, REMOPT-B recommended. |
| 5 | Implementation Planning by Workstream | ✅ Done | [phase-5-implementation-planning-by-workstream.md](plan/phase-5-implementation-planning-by-workstream.md) | Phase 5 evidence artifacts completed: 5 deliverables (workstream specs, critical path, handoff matrix, scenario list, fail-fast criteria). |
| 6 | Validation and Conductor Checkpoints | ✅ Done | [phase-6-validation-and-conductor-checkpoints.md](plan/phase-6-validation-and-conductor-checkpoints.md) | Completed with PH6-SCN-001..004 repeatability evidence, domain adjudication, conductor checkpoint package, defect/risk ledgers, and final sign-off artifacts in VIP phase-11 evidence path. |

**Status:** ⬜ Not Started → 📋 Planned → ⭐ Reviewed → 🔄 In Progress → ✅ Done

## Overview

Investigate why custom agents under `C:\Users\s1058662\OneDrive - Syngenta\workspace\Projects\2026_01_VIP\.tasks\005-pm-agent-system` are not coordinating as expected compared to the known-good behavior in `C:\Users\s1058662\repos\agents`.

## Goal

Produce a complete, implementation-ready diagnosis and remediation plan that restores reliable multi-agent coordination and ensures PM workflow outputs are operationally useful (learning-base ingestion, Planner-ready BA outputs, and proactive PM-framework recommendations).

## Research Scope

### Primary investigation targets

- External PM agent task path: `C:\Users\s1058662\OneDrive - Syngenta\workspace\Projects\2026_01_VIP\.tasks\005-pm-agent-system`
- Known-good baseline path: `C:\Users\s1058662\repos\agents`
- Chat-history evidence path: `C:\Users\s1058662\OneDrive - Syngenta\workspace\Projects\2026_01_VIP\learning_base\ideas\chat_logs\pm_agent_improvements`
- Planner example source: `C:\Users\s1058662\Downloads\Test - agent planner (3).xlsx`

### Optional idea/reference scan

- https://github.com/mattpocock/skills
- https://github.com/github/awesome-copilot

### Required behavior domains

- Agent coordination/orchestration reliability
- ProjectOwner ingestion and enrichment behavior into learning base
- Business Analyst Planner-import-friendly output formatting
- Proactive PM toolkit recommendation behavior (RACI, Fishbone/Ishikawa, RAPID or DACI, BCG matrix, RAID logs, Stakeholder Analysis, Project Charters)

## Phase Details

### Phase 1: Evidence Collection and Repro Mapping

- Inventory all relevant artifacts in VIP project path and chat logs.
- Build a timeline of expected vs observed agent handoffs.
- Identify concrete failed outcomes:
  - ProjectOwner not processing/adding information to learning base
  - Business Analyst not updating tasks in Planner-friendly shape
- Produce a reproducible minimal scenario for each failure mode.

### Phase 2: Baseline Orchestration Mapping (Known-Good)

- Extract orchestration design and handoff contracts from baseline (`C:\Users\s1058662\repos\agents`).
- Document baseline expectations for:
  - Trigger conditions
  - Agent role boundaries
  - Memory/learning-base write paths
  - Output schema and formatting contracts
- Capture baseline checkpoints suitable for Conductor gating.

### Phase 3: Gap Analysis and Root-Cause Isolation

- Compare each VIP behavior against baseline contract-by-contract.
- Trace mismatches across instructions, skills, prompts, workflow gates, and output templates.
- Classify root causes by category:
  - Configuration drift
  - Missing/incorrect trigger conditions
  - Tooling or path-resolution issues
  - Output-format contract mismatch
  - Missing PM-tool recommendation logic

### Phase 4: Remediation Options and Decision Package

- Define at least 2 concrete remediation options (minimum):
  - Option A: minimal/risk-contained patch path
  - Option B: structural realignment with baseline patterns
- For each option provide:
  - Files/systems impacted
  - Delivery effort estimate
  - Risk and rollback approach
  - Impact on coordination, ingestion, Planner output, and PM-tool behavior
- Include recommendation criteria for selecting option.

### Phase 5: Implementation Planning by Workstream

- Break selected remediation into independently implementable workstreams:
  - Orchestration contracts and handoff sequencing
  - Learning-base ingestion pipeline behavior
  - BA Planner output schema/template updates
  - PM-tool recommendation and prompting policy
- Define explicit sequencing, dependencies, and Conductor checkpoint criteria.
- Add test plan outline for each workstream.

### Phase 6: Validation and Conductor Checkpoints

- Define execution checklist for post-fix verification.
- Define pass/fail gates per requirement domain.
- Prepare final sign-off package with evidence snapshots and residual risks.

## Acceptance Criteria

1. Reliable agent coordination/orchestration
- In repeated runs of defined scenarios, agent handoffs occur in expected order with no dropped transitions.
- Conductor checkpoints show each phase gate passing with evidence linked to artifacts.

2. Learning-base ingestion behavior
- ProjectOwner consistently processes relevant input and writes structured additions to learning base in the expected location and format.
- No silent failures: ingestion errors are observable and attributable.

3. Planner-friendly BA output format
- BA output maps cleanly to a Teams Planner-import-capable structure aligned with the sample workbook constraints from `Test - agent planner (3).xlsx`.
- Output includes all required task fields and stable formatting suitable for repeated import workflows.

4. PM-tool recommendation behavior
- PM agents proactively recommend and/or apply relevant PM frameworks where context supports it.
- Recommendations include at least one justified framework choice when uncertainty, role clarity, root-cause analysis, prioritization, or governance needs are detected.

## Verification Outline

- Validate against a scripted set of representative PM scenarios.
- Capture run logs and artifact diffs for each scenario.
- Confirm all four acceptance domains pass before marking the task ready for Builder execution.

## Out of Scope

- Implementing production code changes in this task file.
- Replacing external toolchains beyond what is required to restore expected PM-agent behavior.
- Major redesign not justified by root-cause findings.
