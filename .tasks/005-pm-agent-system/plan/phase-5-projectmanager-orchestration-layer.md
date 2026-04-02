---
goal: Phase 5 - ProjectManager Orchestration Layer
phase: 5
date_created: 2026-03-18
last_updated: 2026-03-18
owner: Explorer
status: Planned
tags: [planning, orchestration, project-manager, checkpoints, workflow-routing, delegation, governance]
---

# Phase 5 Plan: ProjectManager Orchestration Layer

## Goal

Define implementation-ready ProjectManager template specification as read-only orchestra tor with checkpoint-based gating, workflow routing logic, and explicit delegation contracts across all six core workflows (resource ingestion, stakeholder feedback, requirements cascade, diagram lifecycle, backlog planning, quality gate review loop). Establish orchestration routing matrix, comprehensive checkpoint table, and delegation rules that coordinate task-tracking workflows while maintaining plan-only governance.

## Scope

- In scope:
  - ProjectManager role charter with orchestration-only authority and explicit read-only constraint.
  - ProjectManager permission tier assignment (Tier O: orchestration-only, read, no write/execute).
  - ProjectManager Copilot and CC tool scopes (read-heavy, search, delegation via handoffs, no modifications).
  - ProjectManager skill integrations: trigger patterns and orchestration context from Phases 2-4.
  - Six workflow definitions (resource ingestion, stakeholder feedback, requirements cascade, diagram lifecycle, backlog planning, quality gate review):
    - Workflow entry triggers and caller roles.
    - Orchestration routing logic (which agent handles which step).
    - Checkpoint decision gates with pause conditions.
    - Explicit success and failure termination paths.
  - Orchestration routing matrix (all workflows × agents × checkpoints) with explicit step sequencing.
  - Comprehensive checkpoint table (all checkpoints across six workflows) with:
    - Checkpoint ID and owner.
    - Decision options (Proceed, Rework, Escalate).
    - Pause condition and pause owner (PM vs. human reviewer).
    - Downstream workflows triggered or blocked per decision.
  - Delegation rules document specifying:
    - Entry point routing (which caller role triggers which workflow).
    - Agent assignment per workflow step (explicit decision matrix).
    - Handoff button structure and required keyword conventions (ADR-001 compliance).
    - Permission guard rails (which agents can write where, execute what).
    - Tie-breaking rules for ambiguous workflow decision forks.
  - Coordination mechanism for task-tracking compatibility:
    - How ProjectManager workflows map to planning/backlog/sprint artifacts.
    - Artifact handoff format between PM orchestration and planning-tool persistence.
    - Checkpoint approval triggers in planning integration (e.g., "approval required" → creates planning task or artifact update pause).
  - Workflow termination contracts (success path, failure escalation path, who gets final decision authority).
  - ProjectManager template skeleton conforming to `agents-personal/templates/README.md` agent template format.
  - Source traceability matrix for all orchestration design decisions.
  - Frontmatter stubs for ProductOwner, BusinessAnalyst, ScrumMaster, FrontendDev, BackendDev, QAEngineer, UIUXDesigner showing explicit handoff buttons to ProjectManager with required keyword structure.
  - Invocation patterns: user-delegatable workflows, PM as entry gate per ADR-001, subagent coordination via Conductor-style checkpoints.
  - Planning-tool integration specification (artifact format, metadata, handoff conventions).
  - Creation of all Phase 5 artifacts under `.tasks/005-pm-agent-system/`.
  - Update of `task.md` Phase 5 row to `📋 Planned`.

- Out of scope:
  - Creating or editing ProjectManager template in `C:/Users/s1058662/repos/agents-personal/templates/agents/`.
  - Creating or editing existing specialist agent templates in `agents-personal` (only clarify handoff buttons to PM).
  - Implementing workflow orchestration logic or checkpoint enforcement machinery (Builder phase).
  - Running `make`, `install.sh`, or any template-generation workflow.
  - Modifying non-`.tasks/` files in `2026_01_VIP` or `agents-personal`.
  - Phase 6 access-permission governance matrix — that is separate layer.

---

## Checkpoints (Plan-Only Governance)

| Checkpoint | Owner | Required Evidence | Decision Options |
| --- | --- | --- | --- |
| CP-5.1 ProjectManager Role Charter | Explorer | ProjectManager role charter with primary responsibility (orchestration, delegation, checkpointing) and explicit read-only constraint confirmed via REQ-500 mapping | Proceed, Rework, Defer |
| CP-5.2 Orchestration Routing Matrix Completeness | Reviewer (human) | Orchestration routing matrix at `.tasks/005-pm-agent-system/artifacts/phase-5/phase-5-orchestration-routing-matrix.md` with all six workflows, all agent types, checkpoints, step sequence, conditional branching per workflow | Approve, Request Changes |
| CP-5.3 Comprehensive Checkpoint Table | Reviewer (human) | Checkpoint table at `.tasks/005-pm-agent-system/artifacts/phase-5/phase-5-comprehensive-checkpoint-table.md` covering all checkpoints across six workflows; each checkpoint specifies ID, owner, decision options, pause condition, pause-owner (PM vs. human reviewer), impact on downstream workflows | Approve, Request Changes |
| CP-5.4 Delegation Rules and Agent Assignment Matrix | Reviewer (human) | Delegation rules document at `.tasks/005-pm-agent-system/artifacts/phase-5/phase-5-delegation-rules.md` with explicit decision matrix for entry routing, agent assignment per workflow step, permission guard rails, and tie-breaking rules for fork decisions | Approve, Request Changes |
| CP-5.5 Task-Tracking Coordination Specification | Reviewer (human) | Task-tracking coordination document at `.tasks/005-pm-agent-system/artifacts/phase-5/phase-5-task-tracking-coordination.md` specifying artifact handoff format, checkpoint-to-planning mapping, approval trigger conventions, and integration point validation | Approve, Request Changes |
| CP-5.6 Specialist-Agent Handoff Stubs to ProjectManager | Reviewer (human) | Frontmatter stubs for all seven specialist and executor agents (ProductOwner, BusinessAnalyst, ScrumMaster, FrontendDev, BackendDev, QAEngineer, UIUXDesigner) showing explicit "Escalate to ProjectManager" or "Return to ProjectManager" handoff buttons with required YAML keyword structure | Approve, Request Changes |
| CP-5.7 ProjectManager Template Skeleton | Reviewer (human) | ProjectManager template frontmatter skeleton at `.tasks/005-pm-agent-system/artifacts/phase-5/phase-5-projectmanager-template-skeleton.md` with required `name`, `description`, `copilot:` (read-only tool list), `cc:` (read-only tool list), `disallowedTools: ["terminal/runInTerminal", "Bash", "Write", "Edit", "Task", "MultiEdit"]` (explicit enforcement of orchestration-only boundary) | Approve, Request Changes |
| CP-5.8 Source Alignment and Plan-Only Boundary Check | Explorer + Reviewer | Source traceability matrix artifact at `.tasks/005-pm-agent-system/artifacts/phase-5/phase-5-source-traceability-matrix.md` with minimum columns: `pm rule`, `source doc`, `source clause`, `implementation note`, `verification evidence`. All Phase 5 file targets verified as `.tasks/005-pm-agent-system/**` only. Comprehensive coverage of conductor.template.md orchestration pattern, ADR-001 checkpoint/handoff model, and pm_agent_coordination_system_implementation_plan.md Sections 4-5 (PM Orchestration Workflows) | Approve, Request Changes, Defer |

---

## Status Governance (Plan-Only Mode)

- `📋 Planned` is set when this phase plan is created and linked from `task.md`.
- `⭐ Reviewed` is set by the reviewer after CP-5.2, CP-5.3, CP-5.4, and CP-5.5 evidence is accepted.
- `✅ Done` is reserved for Builder execution plus verification evidence; Explorer does not set this for unexecuted implementation work.

---

## Requirements and Constraints

- REQ-500: Define ProjectManager role with explicit primary responsibility (orchestration, checkpoint enforcement, multi-agent delegation, workflow routing) and non-goals (no direct edits, no architectural decisions, no code execution, no specialized task work).
- REQ-501: ProjectManager must be assigned Tier O (orchestration-only) permission tier: read access only, no write/execute, with explicit `disallowedTools` preventing terminal access, file edits, and subagent spawning outside orchestration context, per pm_agent_coordination_system_implementation_plan.md Section 8 Agent Access Summary.
- REQ-502: ProjectManager template must define entry-gate routing for all six core workflows:
  - Workflow A: Resource Ingestion (User/ProductOwner → retrieve resources, classify, route to learning_base).
  - Workflow B: Stakeholder Feedback (ProductOwner/Stakeholder → VoC creation, guardrail mapping, cascade trigger).
  - Workflow C: Requirements Cascade (ProductOwner/BusinessAnalyst → requirement changes → impact analysis → dependent doc updates).
  - Workflow D: Diagram Lifecycle (UIUXDesigner → diagram creation → review → publish to learning_base/images).
  - Workflow E: Backlog Planning (ProductOwner/ScrumMaster → prioritization → sprint planning → execution assignment).
  - Workflow F: Quality Gate Review Loop (QAEngineer → test execution → pass/fail decision → escalation if fail → re-plan if blockers).
- REQ-503: Each workflow must include explicit checkpoints with pause conditions:
  - PM checkpoints are automated logical gates (e.g., "if diagram review incomplete, block publish").
  - Human reviewer checkpoints require explicit PM pause for human decision (e.g., "reviewer approval required before cascade proceeds").
  - Each checkpoint must define decision options (Proceed, Rework, Escalate).
- REQ-504: Orchestration routing matrix must specify for each workflow:
  - Entry trigger (user role, keyword phrase, upstream workflow completion).
  - Step sequence (ordered list of agent assignments).
  - Conditional branches (e.g., "if QA fails, route to Developer; if pass, route to Backlog").
  - Checkpoint gates and pause conditions.
  - Termination paths (success and failure).
- REQ-505: Delegation rules must include:
  - Entry point decision matrix: incoming caller role → workflow assignment.
  - Agent assignment matrix: workflow step → agent + required skill.
  - Permission guard rails: explicit "read at [path]", "write at [path]", "cannot execute [tool]" rules per agent.
  - Tie-breaking rules for fork decisions (e.g., "if requirement fails architecture check AND scope check, escalate to PM for decision").
- REQ-506: Task-tracking coordination must specify:
  - Artifact format for checkpoint approval decisions (JSON, markdown metadata, or planning-tool format compatibility).
  - Handoff interface between ProjectManager orchestration output and planning-tool backlog/sprint artifacts.
  - Approval-trigger conventions (e.g., "QA_PASS checkpoint → mark planning item status 'Done'"; "QA_FAIL checkpoint → create planning item 'Fix requirement'").
  - Integration validation rules (e.g., "sprint plan output must include task IDs traceable back to backlog item IDs").
- REQ-507: ProjectManager template spec must include exactly eight skill-trigger integrations (one per Phase 2 skill × workflow association):
  - resource-ingestion skill trigger in Workflow A.
  - stakeholder-feedback skill trigger in Workflow B.
  - requirements-cascade skill trigger in Workflow C.
  - diagram-generation skill trigger in Workflow D (via UIUXDesigner).
  - backlog-management skill trigger in Workflow E.
  - quality-gate-review skill trigger in Workflow F.
  - (Two additional: breakdown-plan for SM integration in Workflow E; deep-research for BA integration in Workflow C.)
- REQ-508: All specialist agents (ProductOwner, BA, ScrumMaster, FrontendDev, BackendDev, QAEngineer, UIUXDesigner) must have explicit handoff buttons to ProjectManager with required keyword structure: `label: "Escalate to ProjectManager"` and `agent: ProjectManager`.
- REQ-509: ProjectManager `disallowedTools` must explicitly exclude: `terminal/runInTerminal` (no Bash access), `Write`, `Edit`, `MultiEdit` (no direct file modifications), `Task` (orchestration-only, no subagent spawning), `Bash` (equivalent of terminal for CC). This enforces read-only + orchestration-only boundary.
- REQ-510: ProjectManager template skeleton must conform to `agents-personal/templates/README.md` agent template frontmatter format with correct `name`, `description` (with orchestration-context trigger phrases), `copilot:` block (read-only tools, no write), and `cc:` block (read-only tools).
- REQ-511: ProjectManager must NOT be user-invokable directly (user_invokable: false); all workflows must be entry-routed through ProjectManager via caller role + keyword trigger, per ADR-001 orchestration pattern.
- REQ-512: Workflow success/failure termination contracts must be explicit:
  - Success: artifact produced, documented in learning_base or task-tracking system (where applicable), next workflow triggered or user notified.
  - Failure: decision nodes (Rework, Escalate) mapped to alternative workflows (return to upstream agent for revision, or escalate to PM for manual intervention).
  - Escalation: ProjectManager pause for human decision (e.g., "QA found critical blocker; PM chooses: fix requirement, skip feature, or defer phase").
- CON-500: This phase is planning-only; no production template files are created or edited.
- CON-501: All writes are restricted to `.tasks/005-pm-agent-system/**`.
- CON-502: ProjectManager specification must not contradict or override specialist agent templates — Phase 5 only clarifies orchestration contracts and handoff buttons.
- CON-503: Orchestration routing and checkpoints must remain compatible with existing planning/task-tracking tools used in 2026_01_VIP (no custom workflow engine assumption).
- GUD-500: Follow task-centric persistence conventions from ADR-002.
- GUD-501: Enforce orchestration constraints and subagent scope control from ADR-001.
- GUD-502: Maintain conductor-template checkpoint and handoff semantics from conductor.template.md.
- GUD-503: Maintain IDE compatibility rules from ADR-005.
- GUD-504: Include rationalization-prevention evidence expectations from ADR-007 in verification section.

---

## Source Guidelines to Incorporate (agents-personal)

Mandatory source set for this phase. All ProjectManager orchestration and checkpoint design decisions must be traceable to at least one of these:

- `C:/Users/s1058662/repos/agents-personal/README.md` — agent framework conventions.
- `C:/Users/s1058662/repos/agents-personal/templates/README.md` — agent template generation rules and frontmatter conventions.
- `C:/Users/s1058662/repos/agents-personal/templates/agents/conductor.template.md` — orchestration baseline with Entry Gate, checkpoint model, workflow routing, and hand-off enforcement pattern.
- `C:/Users/s1058662/repos/agents-personal/templates/agents/product-owner.template.md` (Phase 4 output) — caller agent handoff conventions.
- `C:/Users/s1058662/repos/agents-personal/templates/agents/business-analyst.template.md` — specialist agent handoff baseline.
- `C:/Users/s1058662/repos/agents-personal/templates/agents/scrum-master.template.md` — planning agent handoff baseline.
- `C:/Users/s1058662/repos/agents-personal/templates/agents/worker.template.md` — executor agent handoff baseline.
- `C:/Users/s1058662/repos/agents-personal/docs/architecture/ADR-001-orchestration-and-subagents.md` — checkpoint gating, Entry Gate pattern, orchestration model.
- `C:/Users/s1058662/repos/agents-personal/docs/architecture/ADR-002-task-centric-persistence.md` — persistent state model for checkpoints.
- `C:/Users/s1058662/repos/agents-personal/docs/architecture/ADR-005-ide-compatibility.md` — IDE tool constraints and platform divergence.
- `C:/Users/s1058662/repos/agents-personal/docs/architecture/ADR-007-rationalization-prevention.md` — evidence-based verification requirements.
- `VIP/learning_base/ideas/pm_agent_coordination_system_implementation_plan.md` (Sections 4 ProjectManager Responsibilities, 5 PM Orchestration Workflows, 8 Agent Access Summary).
- `VIP/learning_base/REVIEW_WORKFLOW.md` — cascade dependency and checkpointing model.
- `VIP/docs/README.md` (or project planning artifacts) — planning/task-tracking tool conventions used in 2026_01_VIP.

---

## Six Core Workflows (Research Baseline)

### Workflow A: Resource Ingestion

- **Caller**: User, ProductOwner.
- **Trigger**: "Ingest [document]", "Add to learning_base", "Process resource".
- **Agent sequence**: ProductOwner (classify + template) → [Worker if binary] → learning_base plac ement.
- **Checkpoints**: (CP-A1) Resource classified? (CP-A2) Template applied? (CP-A3) learning_base path valid?
- **Success**: Resource filed in learning_base with metadata.
- **Failure**: Cannot classify → escalate to ProjectManager or reject.

### Workflow B: Stakeholder Feedback

- **Caller**: ProductOwner, Stakeholder.
- **Trigger**: "Process feedback from [stakeholder]", "Create VoC for", "Extract insights".
- **Agent sequence**: ProductOwner (stakeholder-feedback skill) → create VoC record.
- **Checkpoints**: (CP-B1) Feedback captured? (CP-B2) Guardrail mapping complete? (CP-B3) Actionable insights extracted?
- **Success**: VoC record filed in learning_base/11_voice_of_customer.
- **Failure**: Unclear feedback → escalate to stakeholder for clarification.

### Workflow C: Requirements Cascade

- **Caller**: ProductOwner, BusinessAnalyst.
- **Trigger**: "Run cascade review", "Check what's impacted", "Update dependent docs", "Verify requirements alignment".
- **Agent sequence**: ProductOwner (trigger) → cascade analysis (impact discovery) → BusinessAnalyst (update requirements) → cascade verification (confirm no secondary impacts).
- **Checkpoints**: (CP-C1) Impacted docs identified? (CP-C2) Requirements updated? (CP-C3) Secondary impact check complete? (CP-C4) Stakeholder approval required?
- **Success**: Requirements document updated, dependent docs linked, cascade complete.
- **Failure**: Scope creep or missing dependency → rework requirements updates.

### Workflow D: Diagram Lifecycle

- **Caller**: ProductOwner, UIUXDesigner.
- **Trigger**: "Create diagram for", "Update diagram", "Publish diagram to learning_base", "Render Mermaid".
- **Agent sequence**: UIUXDesigner (design + diagram-generation skill) → create/render (Mermaid or draw.io) → publish to images/diagrams.
- **Checkpoints**: (CP-D1) Diagram complete? (CP-D2) Source file (.mmd or .drawio) saved? (CP-D3) Rendered image generated? (CP-D4) Linked in documentation?
- **Success**: Diagram and rendered images published to images/diagrams/, linked in documentation, diagram_manifest.json updated.
- **Failure**: Render failed or format unsupported → escalate to UIUXDesigner for correction.

### Workflow E: Backlog Planning

- **Caller**: ProductOwner, ScrumMaster, User (planning request).
- **Trigger**: "Groom the backlog", "Plan sprint", "Prioritize items", "Sprint planning", "Assign phase".
- **Agent sequence**: ProductOwner (backlog-management skill, prioritize) → ScrumMaster (breakdown-plan skill, estimate + dependencies) → create sprint plan.
- **Checkpoints**: (CP-E1) Backlog prioritized (MoSCoW)? (CP-E2) Items phase-aligned? (CP-E3) Sprint plan created? (CP-E4) Capacity check passed?
- **Success**: Sprint plan created with task breakdown, effort estimates, dependencies, and success criteria; published to docs/ways-of-work/sprint_NN.md.
- **Failure**: Backlog items blocked by undefined requirements → escalate to BusinessAnalyst for requirement clarification or defer to next sprint.

### Workflow F: Quality Gate Review Loop

- **Caller**: QAEngineer, ProductOwner.
- **Trigger**: "Run test", "Execute test suite", "QA review", "Quality gate", "Test pass/fail decision".
- **Agent sequence**: QAEngineer (test execution, quality-gate-review skill) → pass/fail decision → [if pass] mark sprint item 'Done', [if fail] escalate.
- **Checkpoints**: (CP-F1) Test suite executed? (CP-F2) Test results reviewed? (CP-F3) All tests pass? (CP-F4) Acceptance criteria met?
- **Success**: Tests pass → sprint item status 'Done', artifact published.
- **Failure (QA Fail)**: Tests fail → create rework task, assign to developer, create new sprint item for fix, or escalate to PM if blocker.

---

## Worked Invocation Walkthrough

**Scenario**: User requests ingestion of the VIP protocol PDF into the learning base.

| Step | Actor | Action | Checkpoint | Outcome |
| --- | --- | --- | --- | --- |
| 1 | User | Types "Ingest VIP protocol PDF" in Copilot Chat | — | PM Entry Gate receives request; keyword "Ingest" + caller role "User" matches → routes to Workflow A (Resource Ingestion). |
| 2 | ProjectManager | Routes to ProductOwner with `resource-ingestion` skill and attaches source file context | — | ProductOwner invoked with `resource-ingestion` skill; receives PDF path and ingestion prompt. |
| 3 | ProductOwner | Classifies resource (PDF = protocol document → `learning_base/05_technical_specs/`), applies classification tag | CP-A1: Resource classified? | PASS — resource type confirmed as protocol spec; classification tag `technical-protocol` applied. |
| 4 | ProductOwner | Applies standardised metadata header (title, date, source, tags) to the created markdown file | CP-A2: Template applied? | PASS — markdown file created at `learning_base/05_technical_specs/vip_protocol_[name].md` with full metadata. |
| 5 | ProductOwner | Validates that the target path exists and is the correct learning_base sub-directory | CP-A3: learning_base path valid? | PASS — path validated; file written at confirmed location. |
| 6 | ProjectManager | Receives CP-A3 PASS signal; performs orchestration review (read-only; no file modifications) | — | PM confirms Workflow A success path: no escalation required. |
| 7 | User | Receives confirmation | — | "Resource ingested: `learning_base/05_technical_specs/vip_protocol_[name].md` — classification: technical-protocol." Workflow A terminates successfully. |

**Failure fork (classification ambiguous)**: If at CP-A1 the resource cannot be classified unambiguously (e.g., the PDF mixes protocol content with stakeholder notes), PM does not route to ProductOwner. Instead PM pauses Workflow A and prompts the user: "Resource cannot be classified automatically. Please specify: (A) protocol/technical-spec → `05_technical_specs/`, (B) stakeholder reference → `11_voice_of_customer/`, or (C) cancel ingestion." Only after the user confirms a classification does PM re-route to ProductOwner with the confirmed classification tag. This satisfies the Unknown Workflow fallback: when intent is ambiguous, PM always seeks clarification rather than guessing a workflow.

---

## Inline Frontmatter Stubs (CP-5.6 Evidence)

Each stub below shows the required handoff button to ProjectManager, conforming to `agents-personal/templates/README.md`.

### ProjectManager (Orchestrator)

```yaml
---
name: ProjectManager
description: >
  Orchestrator for multi-agent workflows across resource ingestion, stakeholder feedback,
  requirements cascade, diagram lifecycle, backlog planning, and quality gate review.
  Read-only checkpoint enforcement and delegation router. Entry gate for all workflows.
  Trigger phrases: "orchestrate", "route workflow", "checkpoint decision", "escalation review",
  "workflow status", "delegation matrix".
copilot:
  tools: ["read/readFile", "search/semanticSearch", "search/textSearch", "workspace/fileSearch", "search/webSearch", "vscode/askQuestions"]
  model: opus
  user_invokable: false
  handoffs: []
cc:
  tools: ["Read", "LS", "Glob", "Grep", "WebSearch", "TodoRead"]
  disallowedTools: ["Bash", "Write", "Edit", "Task", "MultiEdit", "terminal/runInTerminal"]
  model: claude-opus-4-5
  skills: [architecture, deep-research]
---
```

**Note**: ProjectManager `disallowedTools`:
  - `Bash`, `terminal/runInTerminal`: No direct execution; orchestration-only delegates to Worker.
  - `Write`, `Edit`, `MultiEdit`: No file modifications; PM is read-only.
  - `Task`: No subagent spawning outside orchestration context; all delegation via explicit handoff buttons.

### ProductOwner (Existing Agent — Handoff to ProjectManager)

```yaml
---
name: ProductOwner
description: >
  Stakeholder intake, VoC structuring, backlog curation, resource ingestion.
  Handoff to ProjectManager for orchestration decisions, cross-team escalations, or
  approval blockers. Trigger phrases: "ingest", "process feedback", "groom backlog",
  "run cascade review", "update backlog".
copilot:
  tools: [...]
  model: opus
  user-invokable: true
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
  tools: [...]
  disallowedTools: ["Bash", "Task", "MultiEdit"]
  model: claude-opus-4-5
---
```

### BusinessAnalyst (Existing Agent — Handoff to ProjectManager)

```yaml
---
name: BusinessAnalyst
description: >
  Requirements detail, architecture alignment, technical feasibility.
  Return to ProductOwner after requirement updates. Escalate to ProjectManager
  if architectural decision or cross-team coordination required.
copilot:
  tools: [...]
  model: opus
  user-invokable: true
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
  tools: [...]
  disallowedTools: [...]
  model: claude-opus-4-5
---
```

### ScrumMaster (Existing Agent — Handoff to ProjectManager)

```yaml
---
name: ScrumMaster
description: >
  Sprint planning, execution cadence, backlog breakdown.
  Return to ProductOwner after sprint plan completion. Escalate to ProjectManager
  for capacity/phase conflicts or cross-sprint dependencies.
copilot:
  tools: [...]
  model: opus
  user-invokable: true
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
  tools: [...]
  disallowedTools: [...]
  model: claude-opus-4-5
---
```

### FrontendDev (Existing Agent — Handoff to ProjectManager)

```yaml
---
name: FrontendDev
description: >
  Read-only technical advisor for frontend feasibility and UI/UX compatibility checks.
  Escalate to ProjectManager for architecture conflicts or cross-team coordination.
copilot:
  tools: ["read/readFile", "search/semanticSearch", "workspace/fileSearch", "search/webSearch", "vscode/askQuestions"]
  model: opus
  user-invokable: false
  handoffs:
    - label: Escalate to ProjectManager
      agent: ProjectManager
      prompt: "Escalate this technical concern for orchestration and cross-team decision."
      send: false
cc:
  tools: ["Read", "LS", "Glob", "Grep", "WebSearch"]
  disallowedTools: ["Bash", "Write", "Edit", "Task", "MultiEdit"]
  model: claude-opus-4-5
---
```

### BackendDev (Existing Agent — Handoff to ProjectManager)

```yaml
---
name: BackendDev
description: >
  Read-only technical advisor for backend feasibility, architecture alignment, database feasibility.
  Escalate to ProjectManager for architecture conflicts or cross-team coordination.
copilot:
  tools: ["read/readFile", "search/semanticSearch", "workspace/fileSearch", "search/webSearch", "vscode/askQuestions"]
  model: opus
  user-invokable: false
  handoffs:
    - label: Escalate to ProjectManager
      agent: ProjectManager
      prompt: "Escalate this technical concern for orchestration and cross-team decision."
      send: false
cc:
  tools: ["Read", "LS", "Glob", "Grep", "WebSearch"]
  disallowedTools: ["Bash", "Write", "Edit", "Task", "MultiEdit"]
  model: claude-opus-4-5
---
```

### QAEngineer (Existing Agent — Handoff to ProjectManager)

```yaml
---
name: QAEngineer
description: >
  Test execution and quality gate review. No direct file edits; escalate to ProjectManager
  for quality gate failures, blocker escalation, or re-planning decisions.
copilot:
  tools: ["read/readFile", "search/semanticSearch", "workspace/fileSearch", "search/webSearch", "vscode/askQuestions"]
  model: opus
  user-invokable: false
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
  tools: ["Read", "LS", "Glob", "Grep", "WebSearch"]
  disallowedTools: ["Bash", "Write", "Edit", "Task", "MultiEdit"]
  model: claude-opus-4-5
---
```

### UIUXDesigner (Existing Agent — Handoff to ProjectManager)

```yaml
---
name: UIUXDesigner
description: >
  Diagram creation, Mermaid rendering, diagram lifecycle management. Delegate to
  ProjectManager for cross-team coordination, publishing approval, or diagram strategy changes.
copilot:
  tools: ["read/readFile", "search/semanticSearch", "workspace/fileSearch", "search/webSearch", "vscode/askQuestions", "workspace/createFile", "edit/editFile"]
  model: opus
  user-invokable: false
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
  tools: ["Read", "LS", "Glob", "Grep", "WebSearch", "Write", "Edit"]
  disallowedTools: ["Bash", "Task", "MultiEdit"]
  model: claude-opus-4-5
---
```

---

## Detailed File Changes (Phase 5 Deliverables)

All writes in this phase are limited to `.tasks/005-pm-agent-system/`.

### 1. Create `.tasks/005-pm-agent-system/artifacts/phase-5/phase-5-projectmanager-spec.md`

Content:
- **ProjectManager Role Charter**: one-paragraph statement of purpose (orchestration, checkpoint enforcement, multi-agent coordination, workflow routing), primary responsibilities (Entry Gate routing, checkpoint decision, delegation rules, escalation handling), and explicit non-goals (no architecture decisions, no code execution, no stakeholder authority, no technical task work).
- **Permission Tier**: Tier O (orchestration-only), read-only with no write/execute permissions.
  - Copilot tools: `read/readFile`, `search/semanticSearch`, `search/textSearch`, `workspace/fileSearch`, `search/webSearch`, `vscode/askQuestions` (read and search only).
  - Copilot excluded: `terminal/runInTerminal` (no Bash), `edit/editFile`, `workspace/createFile` (no writes).
  - CC tools: `Read`, `LS`, `Glob`, `Grep`, `WebSearch`, `TodoRead` (read, search, todo tracking).
  - CC excluded: `Bash` (no terminal), `Write`, `Edit`, `MultiEdit` (no file modifications), `Task` (no subagent spawning).
- **Six Workflow Summaries**: for each workflow (A-F), one paragraph describing entry trigger, agent sequence, primary checkpoints, success path, and failure escalation.
- **Checkpoint Governance Model**: table summarizing checkpoint types:
  - Automated logical gates (PM evaluates condition, auto-proceed or block).
  - Human reviewer checkpoints (PM pauses for human decision).
  - Decision options per checkpoint (Proceed, Rework, Escalate).
  - Impact on downstream workflows (which workflow is triggered or blocked per decision).
- **Orchestration Context**: summary of how ProjectManager Entry Gate enforces ADR-001 model:
  - User or agent makes workflow request → PM receives request → PM routes to correct agent per delegation rules → PM enforces checkpoints between agent steps.
  - Explicit "user_invokable: false" for PM; all entry is via keyword trigger + caller role matching.
- **Skill Integration Summary**: table mapping Phase 2 + Phase 3 skills to workflow steps (e.g., resource-ingestion in Workflow A, stakeholder-feedback in Workflow B, etc.).
- **Escalation Path**: explicit decision tree for escalation cases (e.g., "if QA fails AND blocker found, PM offers: fix requirement, skip feature, or defer phase").
- **Invocation Patterns**: (a) user requests workflow by keyword → PM entry gate routes to appropriate agent(s); (b) agent handoff to PM → PM checkpoint decision; (c) disallowed contexts (no direct peer-to-peer agent calls outside PM orchestration).
- **No Direct Invocation**: Explicit statement that ProjectManager cannot be invoked directly by users; only via orchestration delegation.

### 2. Create `.tasks/005-pm-agent-system/artifacts/phase-5/phase-5-orchestration-routing-matrix.md`

Content:
- **Master orchestration routing table** with columns:
  - `Workflow ID` (A-F).
  - `Workflow Name` (Resource Ingestion, Stakeholder Feedback, etc.).
  - `Entry Trigger` (keyword phrase, caller role).
  - `Step Sequence` (ordered list: 1. Agent, 2. Agent, 3. Checkpoint, etc.).
  - `Agent per Step` (ProductOwner, BusinessAnalyst, ScrumMaster, FrontendDev, BackendDev, QAEngineer, UIUXDesigner, or Worker).
  - `Checkpoint ID(s)` (CP-A1, CP-A2, … CP-F4).
  - `Success Termination` (artifact type, save location, next workflow triggered).
  - `Failure Path` (rework trigger, escalation decision).
  - `Conditional Branches` (if X, then route to A; if Y, then route to B).

- **Workflow-specific subsections** for each workflow A-F:
  - Visual ASCII flowchart (entry trigger → agent step 1 → checkpoint 1 → decision → agent step 2 → checkpoint 2 → success/failure path).
  - One table per workflow showing step-by-step routing:
    - `Step #`, `Agent`, `Skill/Action`, `Expected Input`, `Expected Output`, `Next Checkpoint`, `Disallowed Actions`.
  - Example (Workflow B: Stakeholder Feedback):
    - Step 1: ProductOwner, stakeholder-feedback skill, VoC creation, stakeholder quote list → VoC markdown → CP-B1.
    - Step 2: [Conditional] If guardrail mapping unclear, escalate to BA; else proceed to CP-B2.
    - Step 3: ProductOwner triggers cascade review → CP-C1 (Workflow C initiated).

- **Conditional Branching Examples**:
  - Workflow C (cascade): "If requirements update fails architecture check (BackendDev review), rework requirements or escalate to PM for scope decision."
  - Workflow E (sprint planning): "If backlog items exceed capacity, PO re-prioritizes or defers items to next sprint."
  - Workflow F (QA): "If QA pass, mark sprint item 'Done'; if QA fail, create rework item or escalate to PM if blocker."

### 3. Create `.tasks/005-pm-agent-system/artifacts/phase-5/phase-5-comprehensive-checkpoint-table.md`

Content:
- **Master checkpoint table** covering ALL checkpoints across six workflows with columns:
  - `Checkpoint ID` (CP-A1 through CP-F4).
  - `Workflow` (A, B, C, D, E, F).
  - `Checkpoint Description` (e.g., "Resource classified?", "Tests pass?").
  - `Condition to Pass` (e.g., "Resource has metadata header with classification tag", "All test assertions green").
  - `Checkpoint Owner` (ProductOwner, BusinessAnalyst, ScrumMaster, UIUXDesigner, QAEngineer, or PM).
  - `Pause Required?` (Y/N — is human decision required?).
  - `Pause Owner` (which role/reviewer must make decision if N = human).
  - `Decision Options` (Proceed, Rework, Escalate, or workflow-specific options like "Pass", "Fail", "Defer").
  - `Impact if Proceed` (next workflow triggered, artifact saved, status update).
  - `Impact if Rework` (which agent is tasked to rework, revised checkpoint).
  - `Impact if Escalate` (escalated to PM for manual decision or human reviewer).
  - `Tie-Breaker Rule` (if multiple decision options are viable, which takes precedence?).

- **Checkpoint detail cards** (one per checkpoint) with:
  - Checkpoint rationale (why is this checkpoint necessary?).
  - Failure scenarios (what errors or blockers could arise?).
  - Escalation criteria (under what conditions should this be escalated to PM?).
  - Integration with task-tracking (does this checkpoint create a planning artifact, update a sprint status, etc.?).

### 4. Create `.tasks/005-pm-agent-system/artifacts/phase-5/phase-5-delegation-rules.md`

Content:
- **Entry Point Decision Matrix**: table mapping caller role + request keyword → which workflow:
  - User + "ingest document" → Workflow A (Resource Ingestion).
  - ProductOwner + "process feedback" → Workflow B (Stakeholder Feedback).
  - ProductOwner/BA + "run cascade review" → Workflow C (Requirements Cascade).
  - UIUXDesigner + "publish diagram" → Workflow D (Diagram Lifecycle).
  - ProductOwner/SM + "plan sprint" → Workflow E (Backlog Planning).
  - QAEngineer + "quality gate" → Workflow F (Quality Gate Review).
  - Any role + unrecognised keywords → Unknown Workflow (fallback): PM prompts caller for clarification; no specialist agent is invoked until a matching workflow is confirmed.

- **Agent Assignment Matrix** (per workflow): table with columns:
  - `Workflow`, `Step #`, `Assigned Agent`, `Required Skill(s)`, `Allowed Actions` (read at [path], write at [path], execute [tool]), `Disallowed Actions` (no Bash, no code edits, etc.).

- **Permission Guard Rails**: explicit rules per agent:
  - ProductOwner: Write `learning_base/`, `docs/ways-of-work/`; read everywhere; no execute.
  - BusinessAnalyst: Write `learning_base/02_requirements/`, `learning_base/03_architecture/`; read everywhere; no execute.
  - ScrumMaster: Write `docs/ways-of-work/sprint_*.md`, `learning_base/09_decisions/`; read everywhere; no execute.
  - FrontendDev, BackendDev: Read-only advisors; no write, no execute.
  - QAEngineer: Read `learning_base/`, `docs/`, test execution; write only `learning_base/07_testing/test_results_*.md`; no code edits.
  - UIUXDesigner: Write `images/diagrams/`, `learning_base/03_architecture/diagrams/`; execute diagram-generation skill only; no code edits.
  - Worker: Full access (read + write + execute); used by PM for resource conversion only.

- **Tie-Breaking Rules** for fork decisions (when multiple agents could handle a task):
  - "If requirement change touches architecture AND data model, BA leads, consults BackendDev, escalates to PM if conflict."
  - "If diagram is for user docs AND technical architecture, UIUXDesigner decides publication scope; PM approves cross-boundary impact."
  - "If sprint item is blocked AND depends on another item, ScrumMaster re-plans, PM approves if phase targets are impacted."

- **Escalation Criteria**: when each type of issue should be escalated to PM:
  - Scope creep detected (new requirement outside phase scope).
  - Cross-team conflict (two agents disagree on approach).
  - Resource blockage (required resource/agent unavailable).
  - Quality gate blocker (test failure on critical path).
  - Timeline risk (checkpoint completion threatening sprint deadline).

- **Validation Rules** (Builder must verify all three before marking this artifact complete):
  1. **Keyword mutual exclusivity**: every entry-point keyword in the Entry Point Decision Matrix must appear in exactly one workflow row; no keyword may map to multiple workflows. Detected overlap must be resolved by keyword refinement or an explicit disambiguation note before the artifact passes review.
  2. **Explicit permission guards on all agent assignments**: every row in the Agent Assignment Matrix must include non-empty `Allowed Actions` and `Disallowed Actions` columns; a row without explicit permission constraints is invalid and must be completed before review.
  3. **Deterministic tie-breaking outcomes**: every tie-breaking rule must specify a single unambiguous winning agent or action; rules that produce "either A or B" without a selection criterion are invalid. Each tie-breaking rule must designate exactly one primary agent and one escalation target for when the primary agent cannot proceed.

### 5. Create `.tasks/005-pm-agent-system/artifacts/phase-5/phase-5-task-tracking-coordination.md`

Content:
- **Artifact Handoff Format**: specification for checkpoint approval artifacts:
  - JSON format example: `{ "checkpoint_id": "CP-A1", "workflow": "A", "passed": true, "timestamp": "2026-03-18T14:30Z", "approver": "ProductOwner", "next_step": "apply_template" }`.
  - Or markdown metadata header: YAML frontmatter with `checkpoint_id`, `passed`, `approver`, `next_step`, optional `notes`.
  - Or planning-tool native format (if using JIRA, Azure DevOps, etc.) with checkpoint status field.

- **Planning Integration Mapping**: table linking PM orchestration to planning/backlog artifacts:
  - Workflow A completion → learning_base file created → learning_base index updated.
  - Workflow B completion → VoC record created → backlog items tagged with "awaiting-refinement" or moved to "requirements-draft" column.
  - Workflow C completion → requirement change documented with traceability → dependent backlog items marked "cascade-impact-review".
  - Workflow D completion → diagram published → documentation links updated.
  - Workflow E completion → sprint plan created → backlog items assigned to sprint, status "Sprint-Ready".
  - Workflow F completion (Pass) → sprint item status "Done"; (Fail) → new sprint item "Fix bug" or "Clarify requirement" created.

- **Checkpoint-to-Planning Trigger Rules**: explicit IF-THEN for PM checkpoint decisions affecting planning:
  - IF CP-C2 (Requirements updated) THEN mark_planning_task("requirements-updated", timestamp), tag_backlog_items("cascade-review-pending").
  - IF CP-E3 (Sprint plan created) THEN publish_sprint_plan_artifact(docs/ways-of-work/sprint_NN.md), update_planning_tool(sprint_id=NN, items=[...]).
  - IF CP-F3 (Tests fail) AND is_blocker THEN create_planning_issue("Fix blocker", priority=critical), escalate_to_pm(decision required).

- **Artifact Path Conventions**: canonical locations for PM orchestration output:
  - Workflow A checkpoints → `.tasks/005-pm-agent-system/workflow-logs/A_[timestamp]_ingestion_[resource-name].json`.
  - Workflow B checkpoints → `learning_base/11_voice_of_customer/voc_[id]_[stakeholder].md` + `.tasks/workflow-logs/B_[timestamp]_voc.json`.
  - Workflow C checkpoints → `.tasks/workflow-logs/C_[timestamp]_cascade_[requirement-id].md` + update to dependent docs.
  - Workflow D checkpoints → `images/diagrams/[diagram].mmd` or `.drawio` + `.tasks/workflow-logs/D_[timestamp]_diagram.json`.
  - Workflow E checkpoints → `docs/ways-of-work/sprint_[num].md` + `.tasks/workflow-logs/E_[timestamp]_sprint.json`.
  - Workflow F checkpoints → `learning_base/07_testing/test_results_[sprint_num].md` + planning status update + `.tasks/workflow-logs/F_[timestamp]_qag ate.json`.

- **Integration Validation Rules**: how to verify orchestration → planning → artifact chain:
  - Trace checkpoint ID → planning task ID (must be linkable).
  - Verify artifact is saved at expected canonical path.
  - Confirm metadata in artifact points back to originating workflow and checkpoints.
  - Validate that approval timestamp in checkpoint ≤ artifact timestamp (no retroactive approvals).
  - Check planning-tool status matches PM checkpoint decision (if Pass, status must be 'Done'; if Fail, new task must exist).

- **Compatibility with Existing Planning Tools**: guidance for mapping PM orchestration to 2026_01_VIP planning processes:
  - If using markdown backlog.md: checkpoint decisions create status markers and link to workflow artifacts.
  - If using JIRA/Azure DevOps: checkpoint approvals trigger issue status transitions (e.g., "awaiting-approval" → "approved").
  - If using Planner/task-tracking: orchestration checkpoints map to checkpoint fields in task tracking schema.

### 6. Create `.tasks/005-pm-agent-system/artifacts/phase-5/phase-5-specialist-agent-handoff-stubs.md`

Content:
- **Master handoff stubs section** for all seven specialist and executor agents (ProductOwner, BusinessAnalyst, ScrumMaster, FrontendDev, BackendDev, QAEngineer, UIUXDesigner).
- For each agent:
  - Agent name and role.
  - Current handoff buttons (if defined in Phase 4 or existing templates).
  - **Required addition**: explicit "Escalate to ProjectManager" handoff button with YAML syntax: `label: "Escalate to ProjectManager"`, `agent: ProjectManager`, `prompt: "..."`, `send: true`.
  - Confirmation that existing permissions and tool scopes are NOT changed by Phase 5 (only handoff buttons added).
  - Checkpoint pause condition for PM on receiving escalation (PM pauses for human decision or auto-decision per delegation rules).

### 7. Create `.tasks/005-pm-agent-system/artifacts/phase-5/phase-5-projectmanager-template-skeleton.md`

Content:
- **ProjectManager template skeleton** for `templates/agents/project-manager.template.md`.
- **Required shared frontmatter block**:
  - `name: ProjectManager`.
  - `description`: multi-line with orchestration trigger phrases (orchestrate, route workflow, checkpoint, escalation review, delegation) embedded per templates README activation.
- **Copilot block**:
  - `tools`: explicit inclusion list (read, search, workspace fileSearch, web search).
  - `model: "opus"` (size appropriate for multi-workflow reasoning and checkpoint logic).
  - `user_invokable: false` (PM is not user-facing; entry is via delegation).
  - `handoffs: []` (ProjectManager does not hand off to other agents; it orchestrates and gates all handoffs FROM other agents TO each other).
- **CC block**:
  - `tools`: read-only list using CC tool names (Read, LS, Glob, Grep, WebSearch, TodoRead).
  - `disallowedTools: ["Bash", "Write", "Edit", "Task", "MultiEdit", "terminal/runInTerminal"]` (explicit enforcement of read-only orchestration-only boundary).
  - `model: "claude-opus-4-5"`.
  - `skills: [architecture, deep-research]` (for understanding complex workflow interactions, cascade impact analysis, escalation reasoning).
- **Body block structure** (marked as placeholder descriptions):
  - `## Role`: ProjectManager orchestration-only responsibility, checkpoint enforcement, delegation authority, and explicit non-goals.
  - `## Six Workflows`: brief summary table of Workflows A-F (name, entry trigger, agent sequence, key checkpoints).
  - `## Checkpoint Model`: ADR-001 checkpoint pattern, automated vs. human-decision gates, decision options per checkpoint.
  - `## Orchestration Routing`: reference (or embedding) of orchestration-routing-matrix with conditional branching logic.
  - `## Delegation Rules`: explicit entry-point decision matrix and agent-assignment guidance.
  - `## Permission Boundaries**: explicit statement that PM is read-only; no direct file edits or script execution. All delegation via handoff buttons.
  - `## Escalation Handling`: decision tree for escalation cases (scope creep, conflicts, blockers) with PM decision options (fix, skip, defer, escalate-to-human).
  - `## Task-Tracking Integration`: how PM checkpoints map to planning artifacts and status updates.
  - `## Invocation Patterns**: user request → PM entry gate → agent routing → checkpoint enforcement → success/failure handling.
  - `## Relationship to Conductor Pattern`: this section must clarify that ProjectManager *extends* the Conductor archetype defined in `conductor.template.md` — it does not instantiate a Conductor at runtime. While Conductor provides the structural baseline (Entry Gate, checkpoint model, handoff enforcement), ProjectManager adds domain-specific workflow routing (Workflows A–F), six specialised checkpoint sequences, and explicit permission-tier enforcement (Tier O). The body must state which Conductor conventions are inherited unchanged (Entry Gate keyword matching, `user_invokable: false`, `disallowedTools` contract) and which are extended (multi-workflow routing matrix, human-decision vs. automated checkpoint distinction, task-tracking trigger rules). Any constraint from the Conductor baseline that ProjectManager cannot relax (e.g., `Task` disallowed even when coordinating subagents) must be explicitly restated here to prevent future drift.
- Note platform divergence where applicable: `<!-- COPILOT-ONLY -->` or `<!-- CC-ONLY -->` directives for any tool-specific routing (per ADR-005).

### 8. Create `.tasks/005-pm-agent-system/artifacts/phase-5/phase-5-source-traceability-matrix.md`

Content:
- One row per normative design decision in Phase 5 artifacts.
- Required minimum columns:
  - `pm rule` — the orchestration/checkpoint design decision.
  - `source doc` — file path of the authoritative source.
  - `source clause` — specific section or heading.
  - `implementation note` — how the rule is applied in the Phase 5 ProjectManager spec.
  - `verification evidence` — how the Builder or reviewer can confirm compliance.
- Minimum coverage targets:
  - One row: ProjectManager role charter (Tier O, orchestration-only) — source: pm_agent_coordination_system_implementation_plan.md Section 4.
  - At least one row per workflow (six rows A-F) — source: pm_agent_coordination_system_implementation_plan.md Section 5.
  - One row: ADR-001 checkpoint model application — source: ADR-001.
  - One row: Entry Gate pattern — source: conductor.template.md.
  - One row: Handoff button keyword structure — source: templates/README.md, ADR-001.
  - One row: Read-only tool scope specification — source: pm_agent_coordination_system_implementation_plan.md Section 8 Agent Access Summary.
  - One row per six specialist agents' handoff-to-PM requirement — source: Phase 4 output + ADR-001.
  - One row: Task-tracking integration compatibility — source: pm_agent_coordination_system_implementation_plan.md Section 7.
  - All rows must cite agents-personal template sources and ADRs.

---

## Implementation Steps

### Step 1: Derive ProjectManager role charter from implementation plan and conductor pattern

- Use pm_agent_coordination_system_implementation_plan.md Section 4 (ProjectManager Responsibilities) and Section 5 (PM Orchestration Workflows).
- Use conductor.template.md orchestration pattern as baseline for Entry Gate, checkpoint model, and handoff enforcement.
- Confirm Tier O (orchestration-only) assignment with read-only constraint per pm_agent_coordination_system_implementation_plan.md Section 8.
- Define explicit non-goals: no architecture decisions, no code execution, no direct task work, no stakeholder authority.
- Source: `pm_agent_coordination_system_implementation_plan.md` Sections 4-5, `conductor.template.md`, ADR-001.

### Step 2: Define six workflows and checkpoint sequences

- For each of Workflows A-F, trace through pm_agent_coordination_system_implementation_plan.md Section 5 (PM Orchestration Workflows):
  - Extract workflow entry trigger, agent sequence, key checkpoints, success/failure paths.
  - Create flowchart for each workflow (ASCII or visual).
  - Map each checkpoint to decision table (next Steps 3).
- Derive checkpoints from:
  - Phase 2 skill output contracts (e.g., resource-ingestion skill produces learning_base file → requires CP-A3 "learning_base path valid?").
  - Phase 4 handoff contracts (e.g., PO→BA handoff includes CP-C2 "Requirements updated?").
  - Domain logic (e.g., diagram publish requires CP-D4 "Linked in documentation?").
- Source: `pm_agent_coordination_system_implementation_plan.md` Sections 5.1-5.6, `phase-2-skill-template-set.md`, `phase-4-handoff-contracts-matrix.md`.

### Step 3: Build comprehensive checkpoint table

- For all checkpoints (CP-A1 through CP-F4), create one row with:
  - Checkpoint ID, workflow, description, pass condition.
  - Checkpoint owner (which agent evaluates?) and pause requirement (human decision?).
  - Decision options, impact on downstream workflows.
  - Failure scenarios and escalation criteria.
- Validate that every checkpoint has at least one decision path forward (no dead ends).
- Source: all six workflows (Step 2) + Phase 2 skill output contracts + Phase 4 handoff contracts + ADR-001 checkpoint pattern.

### Step 4: Build orchestration routing matrix

- Create master table with all workflows, entry triggers, agent sequences, checkpoints, termination paths.
- For each workflow, include conditional branching logic (if X decision made at checkpoint, route to which agent/workflow).
- Validate that all checkpoints from comprehensive table (Step 3) are included in routing matrix.
- Validate that no agent is assigned a step it cannot perform (permission guard rails).
- Source: pm_agent_coordination_system_implementation_plan.md Section 5 + Phase 4 delegation rules.

### Step 5: Define delegation rules and agent assignment matrix

- Create entry-point decision matrix: caller role + keyword → workflow assignment.
- Create agent-assignment matrix per workflow: step # → assigned agent → allowed actions → disallowed actions.
- Define permission guard rails per agent (read [path], write [path], execute [tool]).
- Identify tie-breaking rules for fork decisions (multiple agents could handle, which is primary?).
- Source: pm_agent_coordination_system_implementation_plan.md Section 8 Agent Access Summary, Phase 4 handoff contracts, templates/README.md permission patterns.

### Step 6: Specify task-tracking coordination mechanism

- Define artifact handoff format for checkpoint approvals (JSON, markdown, planning-tool native).
- Create mapping table: workflow completion → planning artifact (what gets saved where).
- Define checkpoint-to-planning trigger rules (IF checkpoint decision, THEN planning action).
- Specify canonical paths for workflow logs (timestamps, IDs, traceability).
- Validate integration with 2026_01_VIP existing planning tools (markdown backlog, JIRA, planner, etc.).
- Source: pm_agent_coordination_system_implementation_plan.md Section 7, `phase-2-skill-contracts.md` artifact output schemas.

### Step 7: Identify required handoff buttons for all specialist agents

- For each of seven specialist agents (ProductOwner, BA, SM, FrontendDev, BackendDev, QAEngineer, UIUXDesigner), confirm current handoff structure (from Phase 4 or existing templates).
- Specify required addition: explicit "Escalate to ProjectManager" handoff button with YAML keyword structure.
- Document that Phase 5 does NOT modify existing agent templates; only clarifies handoff-to-PM button requirements.
- Source: `phase-4-productowner-existing-agent-integration.md`, existing agent templates in agents-personal.

### Step 8: Draft ProjectManager template skeleton

- Confirm all required frontmatter blocks: `name`, `description` (with orchestration trigger phrases), `copilot:` (read-only tools), `cc:` (read-only tools).
- For CC block, explicitly cite `disallowedTools: ["Bash", "Write", "Edit", "Task", "MultiEdit", "terminal/runInTerminal"]` with reasoning:
  - `Bash`, `terminal/runInTerminal` block Worker handoff (Worker executes format conversion).
  - `Write`, `Edit`, `MultiEdit` enforce read-only constraint (PM cannot modify files directly).
  - `Task` blocks arbitrary subagent spawning (orchestration-only; delegation via explicit handoff buttons).
- Include `## Checkpoint Model`, `## Orchestration Routing`, `## Delegation Rules`, `## Escalation Handling`, and `## Task-Tracking Integration` sections as body structure placeholders.
- Flag platform divergence: `<!-- COPILOT-ONLY -->` or `<!-- CC-ONLY -->` directives.
- Source: `templates/README.md`, `conductor.template.md`, ADR-005.

### Step 9: Build source traceability matrix

- For each normative rule in Phase 5 artifacts, create one row with full citation.
- Verify minimum coverage targets (role charter, six workflows, checkpoint model, Entry Gate, handoff keywords, read-only scope, specialist-to-PM handoffs, task-tracking).
- Ensure all sources reference agents-personal templates, ADRs, and pm_agent_coordination_system_implementation_plan.md.
- Source: all mandatory sources listed in this plan.

### Step 10: Publish artifacts and update phase tracking

- Write eight Phase 5 artifacts into `.tasks/005-pm-agent-system/artifacts/phase-5/`.
- Update Phase 5 row in `task.md` to `📋 Planned` with plan link and notes.

---

## Dependencies

- DEP-500: Phases 1-4 planned and reviewed (baseline reuse mapping, skill templates, specialist agents, ProductOwner integration).
- DEP-501: Read access to pm_agent_coordination_system_implementation_plan.md Sections 4-8 (ProjectManager, Orchestration Workflows, Agent Access Summary).
- DEP-502: Read access to conductor.template.md for orchestration pattern (Entry Gate, checkpoint model, handoff enforcement).
- DEP-503: Read access to Phase 4 artifacts (ProductOwner spec, handoff contracts, delegation rules).
- DEP-504: Read access to Phase 2 artifacts (skill contracts and output schemas).
- DEP-505: Read access to agents-personal ADRs: ADR-001 (orchestration), ADR-002 (task-centric persistence), ADR-005 (IDE compatibility).
- DEP-506: Read access to learning_base/REVIEW_WORKFLOW.md for cascade dependency model.
- DEP-507: Read access to 2026_01_VIP planning/task-tracking documentation (how orchestration outputs integrate with existing planning tools).

---

## Risks and Mitigations

- RISK-500: ProjectManager checkpoint enforcement becomes a bottleneck if every decision requires PM pause and human review.
  - MIT-500: Distinguish automated logical checkpoints (PM auto-evaluates condition) from human-decision checkpoints (PM pauses). Document in checkpoint table which are which. Design checkpoint conditions to be unambiguous (avoid "does this look right?" questions).

- RISK-501: Workflow routing becomes ambiguous when multiple workflows could be triggered by the same keywords (e.g., "cascade review" could mean Workflow C or a refresh within Workflow E).
  - MIT-501: Establish strict entry-point keywords for each workflow; avoid synonyms that overlap. Document in entry-point decision matrix with examples ("run cascade review" → always Workflow C; "re-plan sprint" → always Workflow E).

- RISK-502: Specialist agents attempt to bypass PM orchestration and call each other directly (e.g., BA directly invokes QA instead of routing through PM).
  - MIT-502: Enforce disallowedTools: Task in all specialist agents, preventing subagent spawning outside PM orchestration. Include explicit statement in their templates: "Do not invoke subagents; escalate to ProjectManager for routing."

- RISK-503: Task-tracking artifacts get out of sync with PM checkpoint decisions (e.g., planning tool shows item "Done" but PM checkpoint is "Failed").
  - MIT-503: Define explicit integration rules (Step 6) that are deterministic: IF checkpoint decision = Proceed, THEN planning status = [specific value]; no manual override. Validate integration in pilot testing.

- RISK-504: PM template is too prescriptive and becomes a bottleneck for future workflows or edge cases not covered in these six workflows.
  - MIT-504: Design PM orchestration as "extensible coordinator" — future workflows can be added as new workflow entries in routing matrix without changing core checkpoint model or delegation logic. Document constraint: new workflows must follow same checkpoint + handoff pattern.

- RISK-505: Diagram lifecycle (Workflow D) checkpoint becomes complex if diagrams require multiple iterations of review/revision.
  - MIT-505: Establish clear diagram review checkpoint approval step (CP-D3) before rendering; once approved, rendering and publishing are automated (CP-D4 auto-proceeds). If revision is needed, cycle back to CP-D3 with new draft, not a separate new workflow.

- RISK-506: ProjectManager disallowedTools constraint (no Write, Edit) appears to conflict with "PM must handle escalation decisions" if escalation decision requires creating an escalation artifact (e.g., a decision record).
  - MIT-506: Clarify: PM can delegate Worker or other agent to write escalation artifacts; PM chooses what to write but does not execute the write itself. This is consistent with orchestration-only (PM delegates, does not execute). Include explicit example in template: "Escalate to Worker to create decision record; PM specifies content, Worker writes."

- RISK-507: Specification of all eight Phase 5 artifacts creates substantial documentation burden that may be redundant across artifacts.
  - MIT-507: Structure artifacts to minimize duplication: routing matrix includes summary row; comprehensive checkpoint table includes deep detail; delegation rules reference both; template skeleton references routing matrix. Each artifact has a specific audience (reviewer, builder, specialist agents).

---

## Success Criteria

- SC-500: ProjectManager role charter exists with explicit orchestration-only responsibility and read-only constraint; Tier O assignment confirmed.
- SC-501: Six workflows (A-F) are defined with entry triggers, agent sequences, checkpoints, success/failure paths.
- SC-502: Comprehensive checkpoint table covers ALL checkpoints across six workflows (minimum 20+ checkpoints); each checkpoint has decision options, pause requirement, downstream impact.
- SC-503: Orchestration routing matrix includes all workflows, entry triggers, agent sequences, checkpoints, conditional branching, and termination paths.
- SC-504: Delegation rules specify entry-point decision matrix (caller role + keyword → workflow), agent-assignment matrix per workflow step, permission guard rails, and tie-breaking rules.
- SC-505: Task-tracking coordination document specifies artifact format, checkpoint-to-planning mapping, trigger rules, canonical paths, and integration validation.
- SC-506: All seven specialist agents (ProductOwner, BA, SM, FrontendDev, BackendDev, QAEngineer, UIUXDesigner) have explicit "Escalate to ProjectManager" handoff button stub.
- SC-507: ProjectManager template skeleton conforms to `agents-personal/templates/README.md` format with `name`, `description`, `copilot:`, `cc:` blocks and `disallowedTools: ["Bash", "Write", "Edit", "Task", "MultiEdit", "terminal/runInTerminal"]`.
- SC-508: ProjectManager `disallowedTools` explicitly prevents file edits, terminal execution, and subagent spawning, enforcing read-only + orchestration-only boundary.
- SC-509: Source traceability matrix covers minimum targets: role, six workflows, checkpoint model, Entry Gate, handoff keywords, read-only scope, specialist handoffs, task-tracking. All sources cite agents-personal and pm_agent_coordination_system_implementation_plan.md.
- SC-510: Phase 5 is marked `📋 Planned` in `task.md` and linked to this plan file.
- SC-511: All Phase 5 write targets are `.tasks/005-pm-agent-system/**` only.
- SC-512: No files outside `.tasks/` were modified while preparing this phase plan.

---

## Verification

### Automated Checks

Confirm Phase 5 plan exists and is linked from task.md:
```
rg "ProjectManager Orchestration Layer|phase-5-projectmanager-orchestration-layer.md|📋 Planned" .tasks/005-pm-agent-system
```

Confirm mandatory source references are present in this plan:
```
rg "pm_agent_coordination_system_implementation_plan|conductor.template.md|ADR-001|ADR-002|ADR-005|orchestration|checkpoint" .tasks/005-pm-agent-system/plan/phase-5-projectmanager-orchestration-layer.md
```

Confirm all six workflows are named:
```
rg "Workflow A: Resource Ingestion|Workflow B: Stakeholder Feedback|Workflow C: Requirements Cascade|Workflow D: Diagram Lifecycle|Workflow E: Backlog Planning|Workflow F: Quality Gate Review" .tasks/005-pm-agent-system/plan/phase-5-projectmanager-orchestration-layer.md
```

Confirm ProjectManager Tier O and disallowedTools:
```
rg "Tier O|disallowedTools.*Bash|disallowedTools.*Write|disallowedTools.*Edit|disallowedTools.*Task" .tasks/005-pm-agent-system/plan/phase-5-projectmanager-orchestration-layer.md
```

Confirm all seven specialist agents handoff stubs mentioned:
```
rg "ProductOwner|BusinessAnalyst|ScrumMaster|FrontendDev|BackendDev|QAEngineer|UIUXDesigner" .tasks/005-pm-agent-system/plan/phase-5-projectmanager-orchestration-layer.md | grep -i "handoff\|escalate"
```

Confirm orchestration routing and checkpoint terminology:
```
rg "orchestration routing matrix|comprehensive checkpoint table|delegation rules|task-tracking coordination|workflow|Entry Gate|handoff" .tasks/005-pm-agent-system/plan/phase-5-projectmanager-orchestration-layer.md
```

Confirm all declared file create/update targets are `.tasks`-scoped:
```
rg "^### [0-9]+\. Create " .tasks/005-pm-agent-system/plan/phase-5-projectmanager-orchestration-layer.md
```
(Reviewer check: each matched path must start with `.tasks/005-pm-agent-system/`.)

Confirm ProjectManager template skeleton mentions disallowedTools:
```
rg "name: ProjectManager" .tasks/005-pm-agent-system/plan/phase-5-projectmanager-orchestration-layer.md
```
(Expected: one match in the Inline Frontmatter Stubs section.)

### Manual Verification Steps

1. Review `phase-5-projectmanager-spec.md` and confirm ProjectManager role charter includes explicit orchestration-only and read-only constraints.
2. Confirm ProjectManager permission tier is assigned as Tier O (read-only, no write/execute).
3. Confirm `disallowedTools` array for ProjectManager explicitly includes `Bash`, `Write`, `Edit`, `Task`, and `terminal/runInTerminal`.
4. Confirm all six workflows (A-F) are listed with entry triggers, agent sequences, key checkpoints, and termination paths.
5. Confirm comprehensive checkpoint table includes at least 20 checkpoints with decision options, pause requirements, and downstream impacts.
6. Confirm orchestration routing matrix includes conditional branching logic (if X decision, then route to Y).
7. Confirm delegation rules specify entry-point decision matrix (caller role + keyword → workflow assignment).
8. Confirm task-tracking coordination document specifies artifact format and checkpoint-to-planning mapping with concrete examples.
9. Confirm all seven specialist agents (ProductOwner, BA, SM, FrontendDev, BackendDev, QAEngineer, UIUXDesigner) have listed handoff-to-ProjectManager button stubs.
10. Confirm source traceability matrix includes minimum coverage (role, six workflows, checkpoint model, Entry Gate, handoff keywords, read-only scope, specialist handoffs, task-tracking).
11. Confirm no files outside `.tasks/` were modified while preparing this phase plan.
12. Confirm reviewer CP-5.2, CP-5.3, CP-5.4, and CP-5.5 acceptance is explicitly required before `⭐ Reviewed` transition.

### Success Evidence

- Builder can implement Phase 5 artifacts using only this plan plus the mandatory source set, without additional research.
- Reviewer can trace every ProjectManager checkpoint, orchestration rule, and delegation decision back to `agents-personal` sources and pm_agent_coordination_system_implementation_plan.md.
- Phase 6 (Access and Permission Governance) can use Phase 5 Tier O assignment and disallowedTools as foundational rules for ProjectManager access matrix enforcement.
- Specialist agents can reference Phase 5 handoff button stubs to confirm "Escalate to ProjectManager" keyword structure for their templates.
- Pilot testing (Phase 8) can validate that orchestration routing, checkpoint gating, and task-tracking integration work end-to-end per Phase 5 specification.

---

## Next Phase

Phase 6: Access and Permission Governance — formalize and enforce the permission model across all agents (Tier W, Tier O, Tier X, Tier R) with boundary rules, disallowedTools enforcement, and governance checklist for drift detection.
