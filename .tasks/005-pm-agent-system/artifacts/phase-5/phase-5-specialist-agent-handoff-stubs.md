---
artifact: phase-5-specialist-agent-handoff-stubs
phase: 5
created: 2026-03-18
status: reviewed
tags: [handoff-stubs, specialist-agents, escalation-to-pm, yaml, frontmatter]
---

# Phase 5 Artifact: Specialist Agent Handoff Stubs

## Overview

This artifact specifies the required "Escalate to ProjectManager" handoff button for all seven specialist and executor agents in the 2026_01_VIP PM agent system. Phase 5 does NOT modify existing agent templates in `agents-personal/templates/agents/`; it only documents the required handoff button addition for each agent.

**IMPORTANT**: The existing permissions, tool scopes, and disallowedTools for each agent are NOT changed by Phase 5. Only the `handoffs` section is augmented with the "Escalate to ProjectManager" button.

When a specialist agent submits the "Escalate to ProjectManager" handoff, PM receives the escalation and evaluates it against the checkpoint/delegation rules. PM then pauses for human decision or auto-routes based on delegation rules.

---

## ProductOwner — Handoff to ProjectManager

**Role**: Stakeholder intake, VoC structuring, backlog curation, resource ingestion.
**Current handoffs (from Phase 4)**: → BusinessAnalyst (Update Requirements), → ScrumMaster (Plan Sprint), → Worker (Convert Resources).
**Required addition**: "Escalate to ProjectManager" for orchestration decisions, cross-team escalations, or approval blockers.

```yaml
---
name: ProductOwner
description: >
  Stakeholder intake, VoC structuring, backlog curation, resource ingestion.
  Handoff to ProjectManager for orchestration decisions, cross-team escalations, or
  approval blockers. Trigger phrases: "ingest", "process feedback", "groom backlog",
  "run cascade review", "update backlog".
copilot:
  tools:
    - read/readFile
    - search/semanticSearch
    - search/textSearch
    - workspace/fileSearch
    - search/webSearch
    - vscode/askQuestions
    - workspace/createFile
    - edit/editFile
  model: opus
  user_invokable: true
  handoffs:
    - label: Update Requirements
      agent: BusinessAnalyst
      prompt: "Update requirements based on this VoC and guardrail mapping."
      send: true
    - label: Plan Sprint
      agent: ScrumMaster
      prompt: "Create a sprint plan from this prioritized backlog."
      send: true
    - label: Convert Resources
      agent: Worker
      prompt: "Convert these resources to markdown format (docx, eml, binary)."
      send: true
    - label: Escalate to ProjectManager
      agent: ProjectManager
      prompt: "Escalate this decision for orchestration routing and checkpoint approval."
      send: true
cc:
  tools:
    - Read
    - LS
    - Glob
    - Grep
    - WebSearch
    - Write
    - Edit
    - TodoRead
  disallowedTools:
    - Bash
    - Task
    - MultiEdit
  model: claude-opus-4-5
---
```

**Checkpoint pause on PM receipt**: When PM receives this escalation, PM evaluates the escalation context against the delegation rules and either auto-routes (if rule covers the case) or pauses for human decision (if escalation is scope/conflict/blocker type).

---

## BusinessAnalyst — Handoff to ProjectManager

**Role**: Requirements detail, architecture alignment, technical feasibility, cascade analysis.
**Current handoffs**: → ProductOwner (Return after requirement updates).
**Required addition**: "Escalate to ProjectManager" for architectural decisions or cross-team coordination.

```yaml
---
name: BusinessAnalyst
description: >
  Requirements detail, architecture alignment, technical feasibility, cascade analysis.
  Return to ProductOwner after requirement updates. Escalate to ProjectManager
  if architectural decision or cross-team coordination required.
  Trigger phrases: "analyze requirements", "cascade review", "architecture check",
  "feasibility study", "update requirements".
copilot:
  tools:
    - read/readFile
    - search/semanticSearch
    - search/textSearch
    - workspace/fileSearch
    - search/webSearch
    - vscode/askQuestions
    - workspace/createFile
    - edit/editFile
  model: opus
  user_invokable: true
  handoffs:
    - label: Return to ProductOwner
      agent: ProductOwner
      prompt: "Requirements updated. PO can proceed to cascade review."
      send: true
    - label: Escalate to ProjectManager
      agent: ProjectManager
      prompt: "Escalate this requirement change for orchestration routing and cascade impact review."
      send: false
cc:
  tools:
    - Read
    - LS
    - Glob
    - Grep
    - WebSearch
    - Write
    - Edit
    - TodoRead
  disallowedTools:
    - Bash
    - Task
    - MultiEdit
  model: claude-opus-4-5
---
```

**Checkpoint pause on PM receipt**: PM evaluates the escalation. If the escalation is about architectural scope, PM pauses and presents options to human reviewer. If it is routine cascade routing, PM auto-routes per delegation rules.

---

## ScrumMaster — Handoff to ProjectManager

**Role**: Sprint planning, execution cadence, backlog breakdown, dependency management.
**Current handoffs**: → ProductOwner (Return after sprint plan).
**Required addition**: "Escalate to ProjectManager" for capacity/phase conflicts or cross-sprint dependencies.

```yaml
---
name: ScrumMaster
description: >
  Sprint planning, execution cadence, backlog breakdown, dependency management.
  Return to ProductOwner after sprint plan completion. Escalate to ProjectManager
  for capacity/phase conflicts or cross-sprint dependencies.
  Trigger phrases: "plan sprint", "breakdown sprint", "estimate sprint",
  "dependency mapping", "sprint retrospective".
copilot:
  tools:
    - read/readFile
    - search/semanticSearch
    - search/textSearch
    - workspace/fileSearch
    - search/webSearch
    - vscode/askQuestions
    - workspace/createFile
    - edit/editFile
  model: opus
  user_invokable: true
  handoffs:
    - label: Return to ProductOwner
      agent: ProductOwner
      prompt: "Sprint plan complete. PO may adjust backlog based on capacity."
      send: true
    - label: Escalate to ProjectManager
      agent: ProjectManager
      prompt: "Escalate this sprint conflict for orchestration routing and phase alignment decision."
      send: false
cc:
  tools:
    - Read
    - LS
    - Glob
    - Grep
    - WebSearch
    - Write
    - Edit
    - TodoRead
  disallowedTools:
    - Bash
    - Task
    - MultiEdit
  model: claude-opus-4-5
---
```

**Checkpoint pause on PM receipt**: PM evaluates whether phase targets are impacted. If yes, PM pauses and presents phase-level decision to human. If no, PM provides routing guidance and resumes workflow.

---

## FrontendDev — Handoff to ProjectManager

**Role**: Read-only technical advisor for frontend feasibility and UI/UX compatibility checks.
**Current handoffs**: None (read-only advisor; advisory output returned to calling agent).
**Required addition**: "Escalate to ProjectManager" for architecture conflicts or cross-team coordination.

```yaml
---
name: FrontendDev
description: >
  Read-only technical advisor for frontend feasibility and UI/UX compatibility checks.
  Escalate to ProjectManager for architecture conflicts or cross-team coordination.
  Invoked by PM for workflow steps requiring frontend technical advisory.
  Trigger phrases: "frontend review", "UI feasibility", "UX check", "frontend architecture".
copilot:
  tools:
    - read/readFile
    - search/semanticSearch
    - workspace/fileSearch
    - search/webSearch
    - vscode/askQuestions
  model: opus
  user_invokable: false
  handoffs:
    - label: Escalate to ProjectManager
      agent: ProjectManager
      prompt: "Escalate this technical concern for orchestration and cross-team decision."
      send: false
cc:
  tools:
    - Read
    - LS
    - Glob
    - Grep
    - WebSearch
  disallowedTools:
    - Bash
    - Write
    - Edit
    - Task
    - MultiEdit
  model: claude-opus-4-5
---
```

**Checkpoint pause on PM receipt**: PM evaluates the technical concern. If it is an architecture blocker, PM pauses workflow and surfaces decision to human reviewer. If it is advisory only, PM notes the concern and continues routing.

---

## BackendDev — Handoff to ProjectManager

**Role**: Read-only technical advisor for backend feasibility, architecture alignment, and database feasibility.
**Current handoffs**: None (read-only advisor; advisory output returned to calling agent).
**Required addition**: "Escalate to ProjectManager" for architecture conflicts or cross-team coordination.

```yaml
---
name: BackendDev
description: >
  Read-only technical advisor for backend feasibility, architecture alignment,
  and database feasibility.
  Escalate to ProjectManager for architecture conflicts or cross-team coordination.
  Invoked by PM for workflow steps requiring backend technical advisory.
  Trigger phrases: "backend review", "API feasibility", "database check", "backend architecture".
copilot:
  tools:
    - read/readFile
    - search/semanticSearch
    - workspace/fileSearch
    - search/webSearch
    - vscode/askQuestions
  model: opus
  user_invokable: false
  handoffs:
    - label: Escalate to ProjectManager
      agent: ProjectManager
      prompt: "Escalate this technical concern for orchestration and cross-team decision."
      send: false
cc:
  tools:
    - Read
    - LS
    - Glob
    - Grep
    - WebSearch
  disallowedTools:
    - Bash
    - Write
    - Edit
    - Task
    - MultiEdit
  model: claude-opus-4-5
---
```

**Checkpoint pause on PM receipt**: PM evaluates the technical concern. Architecture blockers pause the workflow for human decision; advisory concerns are noted and routing continues.

---

## QAEngineer — Handoff to ProjectManager

**Role**: Test execution and quality gate review; no direct file edits.
**Current handoffs**: → ProductOwner (Quality Gate Pass — mark sprint item Done).
**Required addition**: "Quality Gate Fail — Escalate to ProjectManager" for blocker decisions and re-planning.

```yaml
---
name: QAEngineer
description: >
  Test execution and quality gate review. No direct file edits.
  Escalate to ProjectManager for quality gate failures, blocker escalation, or re-planning decisions.
  Invoked by PM for Workflow F (Quality Gate Review Loop).
  Trigger phrases: "run test", "quality gate", "QA review", "test pass/fail", "execute test suite".
copilot:
  tools:
    - read/readFile
    - search/semanticSearch
    - workspace/fileSearch
    - search/webSearch
    - vscode/askQuestions
  model: opus
  user_invokable: false
  handoffs:
    - label: Quality Gate Pass - Return to ProductOwner
      agent: ProductOwner
      prompt: "All tests pass. Mark sprint item as Done."
      send: true
    - label: Quality Gate Fail - Escalate to ProjectManager
      agent: ProjectManager
      prompt: "Tests failed. Escalate for rework or blocker decision."
      send: true
cc:
  tools:
    - Read
    - LS
    - Glob
    - Grep
    - WebSearch
  disallowedTools:
    - Bash
    - Write
    - Edit
    - Task
    - MultiEdit
  model: claude-opus-4-5
---
```

**Checkpoint pause on PM receipt**: PM evaluates whether the failure is a blocker. If blocker, PM pauses and presents Fix / Skip / Defer decision to human. If non-blocker, PM routes to developer for rework task creation.

---

## UIUXDesigner — Handoff to ProjectManager

**Role**: Diagram creation, Mermaid rendering, diagram lifecycle management.
**Current handoffs**: → ProjectManager (Publish Diagram approval).
**Required addition**: "Escalate to ProjectManager" for cross-team coordination, diagram strategy changes.

```yaml
---
name: UIUXDesigner
description: >
  Diagram creation, Mermaid rendering, draw.io diagram lifecycle management.
  Delegate to ProjectManager for cross-team coordination, publishing approval,
  or diagram strategy changes.
  Invoked by PM for Workflow D (Diagram Lifecycle).
  Trigger phrases: "create diagram", "update diagram", "publish diagram",
  "render mermaid", "diagram lifecycle".
copilot:
  tools:
    - read/readFile
    - search/semanticSearch
    - workspace/fileSearch
    - search/webSearch
    - vscode/askQuestions
    - workspace/createFile
    - edit/editFile
  model: opus
  user_invokable: false
  handoffs:
    - label: Publish Diagram to Learning Base
      agent: ProjectManager
      prompt: "Diagram ready for publishing. Approve and publish to images/diagrams."
      send: true
    - label: Escalate to ProjectManager
      agent: ProjectManager
      prompt: "Escalate this diagram decision for orchestration and cross-team alignment."
      send: false
cc:
  tools:
    - Read
    - LS
    - Glob
    - Grep
    - WebSearch
    - Write
    - Edit
  disallowedTools:
    - Bash
    - Task
    - MultiEdit
  model: claude-opus-4-5
---
```

**Checkpoint pause on PM receipt**: For "Publish Diagram" handoff, PM evaluates CP-D4 (linked in documentation?) and approves publication or holds if documentation link is missing. For "Escalate" handoff, PM evaluates cross-team impact and routes accordingly.

---

## Handoff Summary Table

| Agent | Existing Handoffs | Required PM Handoff | `send: true` (auto-forward) | Notes |
| --- | --- | --- | --- | --- |
| ProductOwner | → BA, → SM, → Worker | Escalate to ProjectManager | true | Full orchestration escalation |
| BusinessAnalyst | → ProductOwner | Escalate to ProjectManager | false | Manual escalation trigger |
| ScrumMaster | → ProductOwner | Escalate to ProjectManager | false | Manual escalation trigger |
| FrontendDev | None | Escalate to ProjectManager | false | Advisory escalation only |
| BackendDev | None | Escalate to ProjectManager | false | Advisory escalation only |
| QAEngineer | → ProductOwner (Pass) | Quality Gate Fail → ProjectManager | true | Auto-forward on QA failure |
| UIUXDesigner | → ProjectManager (Publish) | Escalate to ProjectManager | false | Publish path already exists; escalation is supplementary |

`send: true` means the handoff auto-forwards context to PM; `send: false` means the agent must explicitly trigger the escalation with context.
