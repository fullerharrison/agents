---
artifact: phase-6-agent-permission-tier-table
task: 005-pm-agent-system
phase: 6
created: 2026-03-18
status: complete
checkpoint: CP-6.2
sources:
  - phase-6-permission-tier-definitions.md (this phase)
  - agents-personal/templates/agents/conductor.template.md
  - agents-personal/templates/agents/business-analyst.template.md
  - agents-personal/templates/agents/scrum-master.template.md
  - agents-personal/templates/agents/worker.template.md
  - phase-3-plan (REQ-303, REQ-304, REQ-305)
  - phase-4-plan (REQ-402, REQ-410)
  - phase-5-plan (REQ-501, REQ-509)
  - VIP/learning_base/ideas/pm_agent_coordination_system_implementation_plan.md Section 8
---

# Phase 6 Artifact: Nine-Agent Permission Tier Table

## Purpose

This document is the master permission table for all nine agents in the 2026_01_VIP PM agent system. It records the tier assignment, read/write/execute paths, disallowed tools (both Copilot and CC namespaces), agent status (new vs. existing), and the prior-phase decision that established each assignment.

The Write-Path Partition Table and the Worker Tier-F edge case rule are embedded as supplementary sections below the master table.

---

## Master Permission Tier Table

| Agent | Tier | Code | Read Scope | Write Paths | Execute | Copilot `disallowedTools` | CC `disallowedTools` | Status | Phase Established |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| **ProjectManager** | Orchestration-Only | O | `.tasks/`, `learning_base/` | None | None | `terminal/runInTerminal`, `edit/createFile`, `edit/editFiles`, `edit/createDirectory`, `Task` | `Bash`, `Write`, `Edit`, `MultiEdit`, `TodoWrite` | New | Phase 5 (REQ-501) |
| **ProductOwner** | Read + Write | W | All paths | `learning_base/11_voice_of_customer/`, `learning_base/_inbox/`, `docs/` (VoC/intake only) | None | `terminal/runInTerminal` | `Bash`, `Task` | New | Phase 4 (REQ-402) |
| **BusinessAnalyst** | Read + Write | W | All paths | `docs/`, `learning_base/02_requirements/`, `learning_base/09_decisions/`, `specs/` | None | `terminal/runInTerminal` | `Bash`, `Task` | Existing | Phase 4 (REQ-402) |
| **ScrumMaster** | Read + Write | W | All paths | `docs/ways-of-work/` | None | `terminal/runInTerminal` | `Bash`, `Task` | Existing | Phase 4 (REQ-402) |
| **FrontendDev** | Read-Only | R | All paths | None | None | `terminal/runInTerminal`, `edit/createFile`, `edit/editFiles`, `edit/createDirectory` | `Bash`, `Write`, `Edit`, `MultiEdit`, `Task` | New | Phase 3 (REQ-303) |
| **BackendDev** | Read-Only | R | All paths | None | None | `terminal/runInTerminal`, `edit/createFile`, `edit/editFiles`, `edit/createDirectory` | `Bash`, `Write`, `Edit`, `MultiEdit`, `Task` | New | Phase 3 (REQ-303) |
| **QAEngineer** | Read + Execute | RE | All paths | None | Test execution only (`pytest`, `jest`, `npm test`, `dotnet test`, coverage scripts) | `edit/createFile`, `edit/editFiles`, `edit/createDirectory` | `Write`, `Edit`, `MultiEdit`, `Task` | New | Phase 3 (REQ-303) |
| **UIUXDesigner** | Read + Write Diagrams | RW-D | All paths | `diagrams/`, `images/diagrams/`, `docs/` (image refs only) | `mmdc` render only (`execute/runInTerminal`) | `terminal/runInTerminal` (non-mmdc; body-enforced) | `Bash`, `MultiEdit`, `Task` | New | Phase 3 (REQ-303) |
| **Worker** | Full Access | F | All paths | All paths (conversion context only) | All (Bash, `runInTerminal`, conversion scripts) | None formally | None formally | Existing | Source plan Section 8 |

---

## Special Flags

| Agent | Flag | Value | Source |
| --- | --- | --- | --- |
| ProjectManager | `disable-model-invocation` | `true` | `conductor.template.md`; prevents orchestration loops |
| ProjectManager | `permissionMode` (CC) | `plan` | ADR-001 conductor pattern |

---

## Write-Path Partition Table

This table resolves the `docs/` overlap between three Tier W agents (ProductOwner, BusinessAnalyst, ScrumMaster) and UIUXDesigner. The conflict resolution strategy is pre-selected per REQ-603 and CP-6.4: **Step 1 — sub-path partition by content type; Step 2 — caller-workflow context as tie-breaker.**

| Agent | Primary Write Paths | `docs/` Content-Type Partition | Step 2 — Caller-Workflow Tie-Breaker |
| --- | --- | --- | --- |
| **ProductOwner** | `learning_base/11_voice_of_customer/`, `learning_base/_inbox/`, `docs/` (VoC/intake artifacts) | Writes VoC records, stakeholder intake summaries, and feedback digests. Does **not** write requirements, specs, ADRs, sprint plans, or technical documentation. | Stakeholder Feedback Workflow → PO writes VoC; if overlap with BA occurs (both could write `docs/requirements/`), BA writes. |
| **BusinessAnalyst** | `docs/`, `learning_base/02_requirements/`, `learning_base/09_decisions/`, `specs/` | Writes requirements documents, ADRs, feature specs, and technical decision records. Does **not** write sprint plans, VoC records, or diagram references. | Requirements Cascade Workflow → BA writes all updated docs. BA has broader `docs/` authority than PO; for direct conflicts, PM routes to BA for structured documentation. |
| **ScrumMaster** | `docs/ways-of-work/` | Writes sprint plans, task schemas, ways-of-work documentation **only**. Does **not** write to root `docs/`, `specs/`, VoC paths, or diagram paths. | Sprint Planning Workflow → SM writes sprint plan into `docs/ways-of-work/sprint_NN.md`. SM write scope is the narrowest of the three; no conflict with BA or PO for sprint artifacts. |
| **UIUXDesigner** | `diagrams/`, `images/diagrams/`, `docs/` (image refs only) | Inserts `![Figure N](...)` image references into **existing** markdown files in `docs/` as part of Mermaid lifecycle. Does **not** create new `docs/` documents or write any non-image-reference content. | Diagram Lifecycle Workflow → UIUXDesigner inserts image references only. Any other `docs/` edit is out of scope and must be escalated to ProjectManager. |

### `docs/` Overlap Resolution Summary

When a `docs/` write action is ambiguous between multiple agents, the following workflow-context rules apply:

| Trigger Workflow | `docs/` Writer | Rule |
| --- | --- | --- |
| Stakeholder Feedback | ProductOwner | PO writes VoC; BA writes requirements updates if triggered |
| Requirements Cascade | BusinessAnalyst | BA writes all updated requirement and decision docs |
| Sprint Planning | ScrumMaster | SM writes sprint plans to `docs/ways-of-work/` only |
| Diagram Lifecycle | UIUXDesigner | UIUXDesigner inserts image references only |
| Multi-workflow overlap | BusinessAnalyst (default) | For unresolved ambiguity, PM routes to BA as broader `docs/` authority holder |

---

## Worker Tier-F Edge Case

Worker (Tier F) carries no path restrictions at the tier level. This section defines the governance rules that prevent Tier F from overriding Tier W write-path partitions.

### Edge Case Rule

Worker may write to Tier W–owned paths (`docs/`, `learning_base/`, `specs/`) only when **all three** of the following conditions are met:

1. **Explicit invocation:** Worker is explicitly invoked by a Tier W agent (ProductOwner, BusinessAnalyst, or ScrumMaster) or by ProjectManager.
2. **Explicit instruction:** The invocation instruction names the target path and conversion task (e.g., "Convert `learning_base/_inbox/raw.docx` to `learning_base/02_requirements/REQ-042.md`").
3. **Conversion context:** The task is a mechanical conversion or transformation, not a content authoring or decision-making task.

### Authorship Accountability Rule

- The invoking Tier W agent retains authorship and content accountability for all Worker-produced output on Tier W–owned paths.
- Worker acts solely as a mechanical executor.
- Worker-produced files on Tier W–owned paths require the invoking agent to accept or reject the output before it is considered authoritative.

### Scope Violation Trigger

If Worker produces output on a Tier W–owned path without an explicit invocation instruction referencing the target path and conversion task, this constitutes a **Tier F scope violation**. Required response: Worker must surface the output and escalate to ProjectManager. ProjectManager must route the decision to the appropriate Tier W agent for authorship decision.

### Worker Permitted Paths by Invocation Context

| Invocation Source | Permitted Write Paths | Example Task |
| --- | --- | --- |
| ProductOwner → Worker | `learning_base/11_voice_of_customer/`, `learning_base/_inbox/` | Convert inbox `.docx` resource to markdown |
| BusinessAnalyst → Worker | `docs/`, `learning_base/02_requirements/`, `specs/` | Convert requirement template draft to formatted spec |
| ScrumMaster → Worker | `docs/ways-of-work/` | Reformat sprint plan template |
| ProjectManager → Worker | Any path explicitly named in invocation | Cross-agent orchestrated conversion |
| Autonomous (uninvoked) | **None — scope violation** | Any uninstructed write is a violation |
