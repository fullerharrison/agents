---
artifact: phase-2-orchestration-invocation-map
task: 005-pm-agent-system
phase: 2
created: 2026-03-18
status: complete
sources:
  - agents-personal/docs/architecture/ADR-001-orchestration-and-subagents.md
  - agents-personal/docs/architecture/ADR-004-skill-powered-subagents.md
  - agents-personal/docs/architecture/ADR-005-ide-compatibility.md
  - phase-1-orchestration-skill-invocation-guidelines.md
  - phase-1-reuse-map.md
  - phase-2-skill-contracts.md
---

# Phase 2 Orchestration and Invocation Map

## Purpose

This document defines the skill-to-agent invocation matrix, canonical invocation examples for both Copilot and CC, checkpoint compatibility statements, and disallowed invocation contexts for all five PM system skills.

> **Source-priority note:** Where README prose and ADR text differ, ADR takes precedence (RISK-001 mitigation per Phase 1 guidelines).

---

## 1. Skill-to-Agent Invocation Matrix

This table defines which agents may invoke each skill, via which mechanism, and under what conditions.

| Skill | Direct User Activation | Subagent Invocation (agent-to-agent) | Disallowed Callers | Notes |
|-------|----------------------|-------------------------------------|-------------------|-------|
| `resource-ingestion` | ✅ ProductOwner | ✅ Worker (from ProductOwner or BusinessAnalyst) | ❌ ProjectManager, FrontendDev, BackendDev, QAEngineer | PM routes intake through ProductOwner only |
| `stakeholder-feedback` | ✅ ProductOwner | ✅ Worker (from ProductOwner or BusinessAnalyst) | ❌ ProjectManager, FrontendDev, BackendDev, QAEngineer | PM receives escalation summary only |
| `requirements-cascade` | ✅ BusinessAnalyst | ✅ Worker (from BusinessAnalyst or ProductOwner) | ❌ ProjectManager, FrontendDev, BackendDev, QAEngineer | No recursive cascade (Worker executing cascade cannot re-invoke) |
| `backlog-management` | ✅ ProductOwner, ScrumMaster | ✅ Worker (from ProductOwner or ScrumMaster) | ❌ ProjectManager, FrontendDev, BackendDev, QAEngineer | Both PO and SM may invoke; SM owns sprint commitment |
| `diagram-generation` | ✅ UIUXDesigner | ✅ Worker (from UIUXDesigner or BusinessAnalyst) | ❌ ProjectManager, FrontendDev, BackendDev, QAEngineer | New diagram creation requires CP-DG-1 approval |

### Allowed Caller Role Summary

| Skill | Allowed Caller Role(s) | Disallowed Caller Role(s) |
|-------|----------------------|--------------------------|
| `resource-ingestion` | ProductOwner (primary), BusinessAnalyst (secondary) | ProjectManager, all technical advisors, QAEngineer |
| `stakeholder-feedback` | ProductOwner (primary), BusinessAnalyst (secondary) | ProjectManager, all technical advisors, QAEngineer |
| `requirements-cascade` | BusinessAnalyst (primary), ProductOwner (secondary via subagent) | ProjectManager, all technical advisors, QAEngineer |
| `backlog-management` | ProductOwner, ScrumMaster | ProjectManager, all technical advisors, QAEngineer |
| `diagram-generation` | UIUXDesigner (primary), BusinessAnalyst (secondary via subagent) | ProjectManager, FrontendDev, BackendDev, QAEngineer |

### Invocation Mechanism Summary

| Mechanism | Platform Support | When to Use |
|-----------|----------------|-------------|
| Direct user prompt → agent | Copilot + CC | User addresses agent directly with trigger phrase |
| Agent → subagent with skill trigger keywords | Copilot + CC | Parent agent needs skill output in isolated context |
| Inline skill activation | Copilot + CC | User prompt contains trigger keyword in conversation with skill-enabled agent |

---

## 2. Checkpoint Compatibility Statements

Each skill integrates with the checkpoint model defined in ADR-001 §Mandatory Pause Points and Phase 1 `ORC-001` through `ORC-010` rules.

### resource-ingestion Checkpoint Compatibility

| Checkpoint | Trigger | Pause Behavior | Resume Condition |
|------------|---------|---------------|-----------------|
| CP-RI-1 | Classification target differs from user-indicated | Present rationale and proposed path; await approval | User approves path OR provides override |
| CP-RI-2 | `action_flags` includes `potential_requirement` or `decision_signal` | Surface flag to ProductOwner; do not write artifact | ProductOwner acknowledges and routes to next skill |
| CP-RI-3 | Duplicate slug detected | Present both files for merge or overwrite decision | User selects merge, overwrite, or skip |

**Checkpoint pause mechanism:**
- Copilot: `askQuestions` tool with structured options
- CC: `AskUserQuestion` tool with structured options

**ORC-002 compliance:** All checkpoints fire unconditionally. Even if agent says "just ingest it", CP-RI-2 still fires when `action_flags` criteria are met.

### stakeholder-feedback Checkpoint Compatibility

| Checkpoint | Trigger | Pause Behavior | Resume Condition |
|------------|---------|---------------|-----------------|
| CP-SF-1 | `escalation_flag: true` | Surface to ProductOwner before writing VoC artifact | ProductOwner acknowledges and provides routing decision |
| CP-SF-2 | `requirement_signals` list is non-empty | Pause for ProductOwner review | ProductOwner approves routing to `requirements-cascade` |
| CP-SF-3 | `moscow_suggestion: must` for new requirement | Pause for ProductOwner confirmation | ProductOwner confirms or adjusts MoSCoW classification |

**ORC-003 compliance:** Checkpoint headers must be visually distinct (`### 🛑 CHECKPOINT`) and appear as discrete workflow steps in the template body.

### requirements-cascade Checkpoint Compatibility

| Checkpoint | Trigger | Pause Behavior | Resume Condition |
|------------|---------|---------------|-----------------|
| CP-RC-1 | ≥5 files in dependency sequence | Present scope summary for review | BusinessAnalyst or ProjectManager approves scope |
| CP-RC-2 | `change_type: remove` or `deprecate` | Mandatory pause; requires human sign-off | Human reviewer confirms removal intent |
| CP-RC-3 | Circular dependency detected | Surface dependency graph; halt execution queue | Cycle resolved before execution_queue is published |
| CP-RC-4 | `priority: urgent` | Escalate to ProjectManager checkpoint | ProjectManager decision before execution begins |

**Integration with PM Workflow:** CP-RC-4 feeds into the "Requirements Cascade Review" checkpoint mapped to Phase Plan Ready equivalent in Phase 1 guidelines.

### backlog-management Checkpoint Compatibility

| Checkpoint | Trigger | Pause Behavior | Resume Condition |
|------------|---------|---------------|-----------------|
| CP-BM-1 | `must_items` conflict with prior `wont_items` | Surface conflict for ProductOwner decision | ProductOwner resolves conflict |
| CP-BM-2 | `must_items` count exceeds capacity | ScrumMaster scope review | ScrumMaster reduces scope or increases capacity estimate |
| CP-BM-3 | `stakeholder_weight_applied: true` + VoC `escalation_flag: true` | Escalate to ProductOwner sign-off | ProductOwner signs off before publishing backlog |
| CP-BM-4 | Stories rolling over from prior phase | Surface rollover list for ScrumMaster confirmation | ScrumMaster confirms rollover items |

**Integration with PM Workflow:** CP-BM-2 feeds into the "Sprint Plan Approved" checkpoint (Phase Implemented equivalent) from Phase 1 guidelines.

### diagram-generation Checkpoint Compatibility

| Checkpoint | Trigger | Pause Behavior | Resume Condition |
|------------|---------|---------------|-----------------|
| CP-DG-1 | `new_diagram_flag: true` | Pause for UIUXDesigner + ProjectManager confirmation | Both approve scope of new diagram |
| CP-DG-2 | `manifest_touchpoints` non-empty | Review touchpoints before delegating render | Reviewer acknowledges manifest |
| CP-DG-3 | `lifecycle_compliance_check` finds exceptions | Halt; surface exceptions | Human reviews Mermaid lifecycle violations |
| CP-DG-4 | Render commands would overwrite existing file | Pause for UIUXDesigner confirmation | UIUXDesigner explicitly approves overwrite |

---

## 3. Copilot vs CC Invocation Notation Requirements

### Direct Invocation Syntax

| Aspect | Copilot | CC |
|--------|---------|-----|
| Agent selection | `@ProductOwner` in chat | `claude --agent ProductOwner` or `@"ProductOwner (agent)"` in CC |
| Skill activation | Automatic via trigger keywords in user prompt | Automatic via trigger keywords (skill in agent's `skills:` list) |
| Checkpoint pause | `askQuestions` tool call with structured options | `AskUserQuestion` tool call with structured options |

### Subagent Invocation Syntax

| Aspect | Copilot | CC |
|--------|---------|-----|
| Subagent invocation | "Run the Worker agent as a subagent: [skill trigger phrase]. [Task]. Return: [summary spec]." | `Task(Worker, "[skill trigger phrase]. [Task]. Return: [summary spec].")` |
| Skill trigger in subagent | Include skill name or trigger phrases in the subagent prompt body | Same — trigger keywords in `Task()` prompt body activate skill |
| Return spec | "Return: [what parent needs]" at end of prompt | Same format inside `Task()` |

### Handoff Buttons (Copilot-Only)

Copilot's handoff buttons (defined in agent `copilot.handoffs`) provide one-click transition to the next agent. CC has no equivalent UI button — instructions guide the next step.

| Workflow Transition | Copilot | CC |
|--------------------|---------|-----|
| ProductOwner → ScrumMaster | Handoff button: "Plan Sprint" | Instruction: "Type `@\"ScrumMaster (agent)\"` to proceed with sprint planning" |
| BusinessAnalyst → ProjectManager | Handoff button: "Review Checkpoint" | Instruction: "Type `@\"ProjectManager (agent)\"` to present review checkpoint" |
| UIUXDesigner → Worker | Handoff button: "Execute Render" | Instruction: `Task(Worker, "Execute render commands: ...")` |

---

## 4. Canonical Invocation Examples

Each example states: allowed caller role, disallowed caller role, expected checkpoint pause behavior.

---

### Skill 1: resource-ingestion

#### Example 1A — Copilot, Direct Invocation

```
User → @ProductOwner:
"Ingest this document: [attached email thread from Zakaria about video processing].
Source: Email from Zakaria, 2026-03-15. Resource type: email."
```

**Allowed caller role:** ProductOwner  
**Disallowed caller role:** ProjectManager (read-only; must route through ProductOwner)  
**Expected checkpoint pause behavior:**  
- If email contains stakeholder concerns → CP-RI-2 fires → ProductOwner presented with `action_flags` options before artifact is written.  
- Copilot pause mechanism: `askQuestions` tool with options: `[Route to stakeholder-feedback]`, `[File as-is]`, `[Defer]`.

#### Example 1B — CC, Subagent Invocation

```
ProductOwner agent invokes:
Task(Worker, "Use resource-ingestion mode to classify and normalize this document.
Content: [document text]
Resource type: document
Source: Architecture review PDF, 2026-03-10
Domain context: technical
Return: ingestion summary with artifact_path, key_themes, action_flags.")
```

**Allowed caller role:** ProductOwner (invoking Worker with skill trigger)  
**Disallowed caller role:** ProjectManager (cannot invoke Worker directly per SCP-007; read-only)  
**Expected checkpoint pause behavior:**  
- Worker returns ingestion summary to ProductOwner.  
- If `action_flags: potential_requirement` → ProductOwner must route to `requirements-cascade` at next turn.  
- No in-Worker checkpoint — checkpoint fires in ProductOwner context after receiving summary.

---

### Skill 2: stakeholder-feedback

#### Example 2A — Copilot, Direct Invocation

```
User → @ProductOwner:
"Process this stakeholder feedback from Ling's session notes.
Stakeholder: Ling (Video Collector). Channel: meeting. Date: 2026-03-12.
[Feedback text: 'The video collection form needs batch upload. Individual uploads waste time.']"
```

**Allowed caller role:** ProductOwner  
**Disallowed caller role:** ProjectManager (delegates through ProductOwner; cannot invoke directly)  
**Expected checkpoint pause behavior:**  
- If requirement signal extracted: `must_have batch_upload` → CP-SF-3 fires → `askQuestions` with options: `[Confirm must]`, `[Reclassify as should]`, `[Flag for backlog review]`.  
- VoC artifact written only after ProductOwner confirmation.

#### Example 2B — CC, Subagent Invocation

```
ProductOwner agent invokes:
Task(Worker, "Use stakeholder-feedback mode to extract VoC record from this feedback.
Stakeholder: Ling (Video Collector)
Channel: meeting
Date: 2026-03-12
Content: 'The video collection form needs batch upload. Individual uploads waste time.'
Return: VoC record summary with pain_points, requirement_signals, moscow_suggestion, escalation_flag.")
```

**Allowed caller role:** ProductOwner  
**Disallowed caller role:** QAEngineer (test scope; cannot invoke this skill)  
**Expected checkpoint pause behavior:**  
- Worker returns VoC summary. Escalation_flag evaluated in ProductOwner context.  
- If `escalation_flag: true` → ProductOwner triggers CP-SF-1 via `AskUserQuestion` before writing VoC file.

---

### Skill 3: requirements-cascade

#### Example 3A — Copilot, Direct Invocation

```
User → @BusinessAnalyst:
"Cascade this requirement change across the documentation.
Changed requirement: REQ-042 — 'All germplasm data must include GPS coordinates.'
Change type: modify (was: optional, now: required).
Scan defaults for impacted documents."
```

**Allowed caller role:** BusinessAnalyst  
**Disallowed caller role:** ProjectManager (read-only; receives cascade summary at CP-RC-4 only)  
**Expected checkpoint pause behavior:**  
- If ≥5 files identified: CP-RC-1 fires → `askQuestions` with scope summary: `[Approve full cascade]`, `[Reduce scope]`, `[Defer items]`.  
- After CP-RC-1 approval: execution_queue published and Worker delegation begins.

#### Example 3B — CC, Subagent Invocation

```
BusinessAnalyst agent invokes:
Task(Worker, "Use requirements-cascade mode to plan the update propagation.
Changed requirement: REQ-042 modified (GPS coordinates now required).
Change type: modify
Scan these paths: docs/, specs/, learning_base/02_requirements/, learning_base/05_technical_specs/
Return: dependency_sequence, review_obligations, execution_queue summary.")
```

**Allowed caller role:** BusinessAnalyst  
**Disallowed caller role:** Worker (executing cascade cannot recursively invoke this skill)  
**Expected checkpoint pause behavior:**  
- Worker returns plan. CP-RC-1 through CP-RC-4 evaluated in BusinessAnalyst context.  
- For CP-RC-2 (`change_type: remove/deprecate`): `AskUserQuestion` with: `[Approve removal]`, `[Reclassify as deprecate]`, `[Hold for review]`.

---

### Skill 4: backlog-management

#### Example 4A — Copilot, ProductOwner Invocation

```
User → @ProductOwner:
"Prioritize these backlog items for Phase 2 MVP.
Stories: [list of 12 user story texts].
Constraints: 2-week sprint, 3 developers.
Phase target: Phase 2 MVP (see docs/roadmap.md).
Apply MoSCoW classification."
```

**Allowed caller role:** ProductOwner  
**Disallowed caller role:** ProjectManager (read-only; reads backlog artifacts but cannot invoke skill)  
**Expected checkpoint pause behavior:**  
- If any `must_items` exceed capacity: CP-BM-2 fires → `askQuestions`: `[Reduce must scope]`, `[Increase capacity]`, `[Proceed as-is]`.  
- Backlog artifact written only after checkpoint resolution.

#### Example 4B — CC, ScrumMaster Invocation

```
ScrumMaster agent invokes:
Task(Worker, "Use backlog-management mode to create a sprint backlog slice.
Stories: [story list from ProductOwner intake]
Phase target: Phase 2 MVP
Constraints: 10 story points capacity, must include authentication epic
Stakeholder priorities: voc_001, voc_002
Return: MoSCoW backlog slice with must/should/could/wont, artifact_path, dependency_map.")
```

**Allowed caller role:** ScrumMaster  
**Disallowed caller role:** FrontendDev (advisory role; cannot drive backlog decisions)  
**Expected checkpoint pause behavior:**  
- Worker returns slice. ScrumMaster evaluates CP-BM-1 through CP-BM-4.  
- For CP-BM-3 (VoC escalation active): `AskUserQuestion` routes to ProductOwner sign-off.

---

### Skill 5: diagram-generation

#### Example 5A — Copilot, Direct Invocation

```
User → @UIUXDesigner:
"Update the Mermaid diagram to add the new germplasm import flow.
Existing diagram: diagrams/data_flow.mmd.
Change: Add a new node 'Germplasm Import Service' between 'API Gateway' and 'Database'."
```

**Allowed caller role:** UIUXDesigner  
**Disallowed caller role:** ProjectManager (read-only; receives manifest_touchpoints summary only)  
**Expected checkpoint pause behavior:**  
- `manifest_touchpoints` scan finds 3 files referencing `data_flow.mmd` → CP-DG-2 fires → `askQuestions`: `[Update all references]`, `[List touchpoints only]`, `[Defer reference updates]`.  
- Render commands only executed after checkpoint resolution.

#### Example 5B — CC, Subagent via BusinessAnalyst

```
BusinessAnalyst agent invokes:
Task(Worker, "Use diagram-generation mode to specify a diagram update for the architecture change.
Change: Add 'Germplasm Import Service' node to data flow diagram.
Diagram type: mermaid
Existing diagram: diagrams/data_flow.mmd
Return: change_spec, render_commands, manifest_touchpoints, lifecycle_compliance_check.")
```

**Allowed caller role:** BusinessAnalyst (architecture change triggers diagram update)  
**Disallowed caller role:** BackendDev (advisory only; must request update through UIUXDesigner)  
**Expected checkpoint pause behavior:**  
- Worker returns spec. CP-DG-2 evaluated in BusinessAnalyst context.  
- BusinessAnalyst delegates render execution to UIUXDesigner, who confirms via `AskUserQuestion` before executing Worker render subagent.

---

## 5. Cross-Workflow Checkpoint Integration

This section maps skills to the multi-agent workflow checkpoint model from Phase 1 guidelines.

### PM Checkpoint ↔ Skill Checkpoint Mapping

| PM Workflow Stage | PM Checkpoint (Phase 1) | Skill Checkpoint(s) | Resolution |
|------------------|------------------------|--------------------|-----------| 
| Stakeholder intake confirmed | "Task Created" equivalent | CP-RI-2, CP-SF-1 | ProductOwner approves ingestion; escalation flags resolved |
| Requirements cascade review | "Phase Plan Ready" equivalent | CP-RC-1, CP-RC-2, CP-RC-4 | BusinessAnalyst + ProjectManager approve cascade scope |
| Sprint plan approved | "Phase Implemented" equivalent | CP-BM-2, CP-BM-3 | ScrumMaster + ProductOwner resolve capacity and VoC conflicts |
| Quality gate outcome | Abort/Continue decision | CP-DG-3 (diagram lifecycle) | ProjectManager routes based on compliance check result |

### Workflow Sequencing with Skills

```
Resource Ingest (skill 1)
    ↓ [action_flags: stakeholder_input]
Stakeholder Feedback (skill 2)
    ↓ [requirement_signals non-empty]
Requirements Cascade (skill 3)
    ↓ [execution_queue published to Worker]
    ↓ [dependency_sequence affects diagrams]
Diagram Generation (skill 5)
    ↓ [cascade + diagrams stable]
Backlog Management (skill 4)
    ↓ [backlog slice published]
ScrumMaster Sprint Planning
    ↓ [sprint commitment checkpoint]
ProjectManager Orchestration Review
```

### Orchestrator Routing Rules (ProjectManager)

ProjectManager routes between skills exclusively through delegation. The following routing rules apply:

| Incoming Signal | Route To | Mechanism |
|----------------|----------|-----------|
| New stakeholder resource arrives | ProductOwner → `resource-ingestion` | PM tells ProductOwner to process incoming resource |
| `action_flags: stakeholder_input` from ingestion | ProductOwner → `stakeholder-feedback` | PM routes after reviewing ingestion summary |
| `requirement_signals` found in VoC | BusinessAnalyst → `requirements-cascade` | PM routes when ProductOwner surfaces signals |
| `priority: urgent` cascade (CP-RC-4) | PM direct decision → BusinessAnalyst proceed or hold | PM holds cascade until decision made |
| Sprint planning needed | ScrumMaster → `backlog-management` | PM delegates sprint planning to ScrumMaster |
| Architecture change requires visual | UIUXDesigner → `diagram-generation` | PM routes when BusinessAnalyst surfaces architecture delta |

**ORC-008 compliance:** ProjectManager NEVER directly invokes skills. All routing is through `Task()` delegation (CC) or handoff button (Copilot) to the appropriate specialist agent.

---

## 6. Disallowed Invocation Contexts

| Context | Reason | Rule Source |
|---------|--------|------------|
| ProjectManager invoking any skill directly | PM is read-only; all skill work delegated to specialists | SCP-007, ORC-008, ORC-009 (Phase 1 guidelines) |
| Worker recursively invoking `requirements-cascade` while executing a cascade plan | Circular cascade prevention; execution must complete before re-analysis | Phase 2 skill contract non-goal |
| Subagent spawning sub-subagents to invoke additional skills | CC platform constraint | SCP-008 (ADR-001 §CC constraint) |
| FrontendDev or BackendDev invoking any write-producing skill | Advisory roles; no write authority | Phase 1 reuse-map advisor role definitions |
| QAEngineer invoking skills outside test-execution scope | Test scope only; no stakeholder/backlog/diagram authority | Phase 1 reuse-map QAEngineer definition |
| Any agent bypassing CP-RI-2 / CP-SF-1 / CP-RC-2 / CP-DG-1 checkpoints | Unconditional checkpoint rule | ORC-002 (ADR-001 §Checkpoint Enforcement) |
