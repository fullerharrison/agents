---
goal: Phase 4 - ProductOwner and Existing-Agent Integration
phase: 4
date_created: 2026-03-18
last_updated: 2026-03-18
owner: Explorer
status: Planned
tags: [planning, product-owner, handoffs, existing-agents, stakeholder-intake, backlog-grooming, governance]
---

# Phase 4 Plan: ProductOwner and Existing-Agent Integration

## Goal

Define implementation-ready ProductOwner template specification with explicit delegation contracts to three existing agents — BusinessAnalyst, ScrumMaster, and Worker — establishing clear responsibility boundaries for stakeholder intake triage, Voice of Customer structuring, backlog maintenance, and resource conversion workflows.

## Scope

- In scope:
  - ProductOwner role charter and primary responsibilities.
  - ProductOwner permission tier assignment (Tier W: write-enabled, same as BusinessAnalyst and ScrumMaster).
  - ProductOwner Copilot and CC tool scopes.
  - ProductOwner skill integrations: `resource-ingestion`, `stakeholder-feedback`, `requirements-cascade`, `backlog-management`.
  - Explicit handoff contracts:
    - ProductOwner → BusinessAnalyst (requirements update trigger, input summary, checkpoint pause pattern).
    - ProductOwner → ScrumMaster (backlog prioritization trigger, sprint planning input format, ownership transition).
    - ProductOwner → Worker (resource conversion prerequisites, when Worker handles .docx/.eml conversion vs when PO processes directly).
  - Frontmatter stubs for BusinessAnalyst, ScrumMaster, and Worker showing explicit handoffs back to ProductOwner.
  - Ambiguity resolution table (ProductOwner vs BusinessAnalyst on requirements, ProductOwner vs ScrumMaster on planning, ProductOwner vs Worker on resource processing).
  - Invocation patterns: user-invokable, ProjectManager-delegated, subagent escalation.
  - Template skeleton specification conforming to `agents-personal/templates/README.md` generation rules.
  - Integration with Phase 2 skill workflows (resource-ingestion, stakeholder-feedback, requirements-cascade, backlog-management).
  - Creation of all Phase 4 artifacts under `.tasks/005-pm-agent-system/`.
  - Update of `task.md` Phase 4 row to `📋 Planned`.

- Out of scope:
  - Creating or editing ProductOwner template in `C:/Users/s1058662/repos/agents-personal/templates/agents/`.
  - Creating or editing BusinessAnalyst, ScrumMaster, or Worker templates in `agents-personal` (those exist; Phase 4 spec clarifies handoffs only).
  - Running `make`, `install.sh`, or any template-generation workflow.
  - Modifying non-`.tasks/` files in `2026_01_VIP` or `agents-personal`.
  - Phase 5 ProjectManager orchestration layer design — that is independent.

---

## Checkpoints (Plan-Only Governance)

| Checkpoint | Owner | Required Evidence | Decision Options |
| --- | --- | --- | --- |
| CP-4.1 ProductOwner Role Charter | Explorer | ProductOwner role charter with primary responsibility, non-goals, and explicit non-overlap with BusinessAnalyst and ScrumMaster confirmed via comparison table | Proceed, Rework, Defer |
| CP-4.2 Handoff Contract Completeness | Reviewer (human) | Handoff matrix artifact at `.tasks/005-pm-agent-system/artifacts/phase-4/phase-4-handoff-contracts-matrix.md` with explicit upstream caller, input summary, output format, downstream consumers, and checkpoint pause expectation for all three handoff pairs | Approve, Request Changes |
| CP-4.3 Existing-Agent Handoff Stubs | Reviewer (human) | Frontmatter stubs embedded in plan for BusinessAnalyst, ScrumMaster, and Worker showing explicit handoff buttons/labels back to ProductOwner with required keyword structure — demonstrating bidirectional handoff compliance to ADR-001 orchestration model | Approve, Request Changes |
| CP-4.4 Worker vs ProductOwner Conversion Boundary | Reviewer (human) | Clear decision matrix specifying: (a) when Worker converts .docx/.eml/binary formats because those require Bash; (b) when ProductOwner processes directly (already-markdown, URLs, classifications); (c) checkpoint between Worker output and PO classification | Approve, Request Changes |
| CP-4.5 Skill Integration Traceability | Reviewer (human) | Mapping of all four PO skills (from Phase 2) to concrete workflow steps in ProductOwner template spec, with trigger phrases and escalation paths aligned | Approve, Request Changes |
| CP-4.6 Template Generation Readiness | Explorer + Reviewer | Template frontmatter skeleton for ProductOwner includes required shared, copilot:, and cc: blocks conforming to `templates/README.md` agent template format. **Direct evidence:** ProductOwner frontmatter stub embedded in "Inline Frontmatter Stubs (CP-4.6 Evidence)" section of this plan. | Approve, Request Changes |
| CP-4.7 Source Alignment and Plan-Only Boundary Check | Explorer + Reviewer | Source traceability matrix artifact at `.tasks/005-pm-agent-system/artifacts/phase-4/phase-4-source-traceability-matrix.md` with minimum columns: `po rule`, `source doc`, `source clause`, `implementation note`, `verification evidence`. All Phase 4 file create/update targets verified as `.tasks/005-pm-agent-system/**` only | Approve, Request Changes, Defer |

---

## Status Governance (Plan-Only Mode)

- `📋 Planned` is set when this phase plan is created and linked from `task.md`.
- `⭐ Reviewed` is set by the reviewer after CP-4.2, CP-4.3, CP-4.4, and CP-4.5 evidence is accepted.
- `✅ Done` is reserved for Builder execution plus verification evidence; Explorer does not set this for unexecuted implementation work.

---

## Requirements and Constraints

- REQ-401: Define ProductOwner role with explicit primary responsibility (stakeholder intake, VoC structuring, backlog curation) and non-goals (no architecture decision-making authority, no direct test execution, no diagram generation).
- REQ-402: ProductOwner must be assigned Tier W (write-enabled) permission tier, identical in tool scope to BusinessAnalyst and ScrumMaster, per the pm_agent_coordination_system_implementation_plan.md architecture (Section 8 Agent Access Summary).
- REQ-403: ProductOwner template spec must define exactly four skill integrations: `resource-ingestion`, `stakeholder-feedback`, `requirements-cascade`, `backlog-management` (Phase 2 deliverable).
- REQ-404: ProductOwner → BusinessAnalyst handoff contract must specify: (a) trigger phrase ("update requirements based on"); (b) input format (VoC record with mapped guardrails and feature summaries); (c) output expectation (requirements document updates in `02_requirements/`); (d) checkpoint pause (after VoC processing, before BA begins cascade).
- REQ-405: ProductOwner → ScrumMaster handoff contract must specify: (a) trigger phrase ("plan sprint based on"); (b) input format (groomed/prioritized backlog with MoSCoW and phase alignment); (c) output expectation (sprint plan with tasks, effort, dependencies); (d) checkpoint pause (after backlog prioritization, before SM planning).
- REQ-406: ProductOwner → Worker handoff contract must specify: (a) trigger phrase for conversion request ("convert these resources"); (b) resource types Worker must handle (binary: .docx, .eml, .msg, other non-markdown); (c) expected Worker output format (markdown with metadata header); (d) checkpoint pause (after Worker conversion, before PO classification).
- REQ-407: Worker → ProductOwner reverse handoff must state: (a) when Worker finishes format conversion; (b) handoff button text for ProductOwner ("Classify and Route"); (c) expected PO action (categorize resource, apply template, trigger cascade).
- REQ-408: Ambiguity resolution table must distinguish: (a) ProductOwner (strategic backlog + stakeholder voice) from BusinessAnalyst (requirements detail + architecture alignment); (b) ProductOwner (intake + grooming) from ScrumMaster (breakdown + execution planning); (c) ProductOwner (pre-conversion classification intent) from Worker (mechanical format conversion).
- REQ-409: Template skeleton must conform to `agents-personal/templates/README.md` agent template frontmatter format with correct `name`, `description` (with trigger phrases), `copilot:` block, and `cc:` block.
- REQ-410: ProductOwner `disallowedTools` must explicitly exclude: `terminal/runInTerminal` (Copilot) and `Bash` (CC), preventing direct PowerShell/script execution (Worker handles conversion).
- REQ-411: ProductOwner template spec must include a `## Skill Trigger Catalogue` section enumerating all trigger phrases from Phase 2 skills and use cases where each skill is invoked.
- CON-401: This phase is planning-only; no production template files are created or edited.
- CON-402: All writes are restricted to `.tasks/005-pm-agent-system/**`.
- CON-403: ProductOwner specification must not prescribe or override existing BusinessAnalyst, ScrumMaster, or Worker templates — Phase 4 only clarifies handoff contracts and role boundaries.
- GUD-401: Follow task-centric persistence conventions from ADR-002.
- GUD-402: Enforce subagent and orchestration constraints and scope control from ADR-001.
- GUD-403: Maintain skill-powered delegation semantics from ADR-004.
- GUD-404: Maintain IDE compatibility rules from ADR-005.
- GUD-405: Include rationalization-prevention evidence expectations from ADR-007 in verification section.

---

## Source Guidelines to Incorporate (agents-personal)

Mandatory source set for this phase. All ProductOwner and handoff design decisions must be traceable to at least one of these:

- `C:/Users/s1058662/repos/agents-personal/README.md`
- `C:/Users/s1058662/repos/agents-personal/templates/README.md`
- `C:/Users/s1058662/repos/agents-personal/templates/agents/business-analyst.template.md` — role-agent baseline (user-invokable, write-enabled, handoff pattern, skill integration)
- `C:/Users/s1058662/repos/agents-personal/templates/agents/scrum-master.template.md` — planning agent baseline (write-enabled, skill integration for planning workflows)
- `C:/Users/s1058662/repos/agents-personal/templates/agents/worker.template.md` — full-access executor baseline (write + execute permissions, subagent invocation pattern)
- `C:/Users/s1058662/repos/agents-personal/templates/agents/conductor.template.md` — orchestration pattern (checkpoints, Entry Gate, workflow routing, handoff enforcement)
- `C:/Users/s1058662/repos/agents-personal/docs/architecture/ADR-001-orchestration-and-subagents.md`
- `C:/Users/s1058662/repos/agents-personal/docs/architecture/ADR-002-task-centric-persistence.md`
- `C:/Users/s1058662/repos/agents-personal/docs/architecture/ADR-004-skill-powered-subagents.md`
- `C:/Users/s1058662/repos/agents-personal/docs/architecture/ADR-005-ide-compatibility.md`
- `C:/Users/s1058662/repos/agents-personal/docs/architecture/ADR-007-rationalization-prevention.md`
- `VIP/learning_base/ideas/pm_agent_coordination_system_implementation_plan.md` (Sections 3.2 ProductOwner, 6 learning_base Ingestion Pipeline, 8 Agent Access Summary)
- `VIP/learning_base/REVIEW_WORKFLOW.md` — cascade dependency model for requirements-cascade skill routing

---

## Role Charter Summary (Research Finding)

ProductOwner serves as the primary voice of stakeholder intent, backlog curator, and gateway for external resources into the learning_base. The charter is carefully bounded to avoid overlap with BusinessAnalyst (requirements detail), ScrumMaster (sprint execution), and Worker (resource conversion mechanics).

| Aspect | ProductOwner | NOT ProductOwner |
| --- | --- | --- |
| **Primary Responsibility** | Stakeholder voice, intake triage, backlog prioritization, VoC structuring | Requirements detail writing, technical feasibility assessment, sprint breakdown, format conversion |
| **Skill Ownership** | resource-ingestion, stakeholder-feedback, requirements-cascade (trigger), backlog-management | deep-research (BA), breakdown-plan (SM), conversion mechanics (Worker) |
| **Write Scope** | learning_base/ (VoC, backlog, ideas), docs/ (backlog.md) | No write scope for codes, tests, configs, or architecture specs |
| **Execute Scope** | None (no Bash, no runInTerminal) | N/A (PO is read+write, not execute) |
| **Handoffs Out** | BA (requirements update), SM (sprint planning), Worker (resource conversion) | No direct escalation to QA, Builder, FrontendDev, BackendDev (all via PM) |
| **Handoffs In** | ProjectManager (delegation), Worker (converted resources), BA/SM (feedback on impact) | No direct input from specialists (all routed through PM) |
| **Escalation Path** | → ProjectManager (disputes, resource limits, stakeholder deadlock) | N/A |

---

## Inline Frontmatter Stubs (CP-4.6 Evidence)

Each stub below is a one-row representative skeleton showing the required `shared`, `copilot:`, and `cc:` frontmatter blocks per agent, conforming to `agents-personal/templates/README.md`. These are embedded here as direct CP-4.6 evidence that ProductOwner and existing-agent handoff stubs include the required blocks before Builder generates the full template files.

### ProductOwner

```yaml
---
name: ProductOwner
description: >
  Tier W write-enabled agent for stakeholder intake, Voice of Customer processing,
  backlog curation, and resource ingestion for HTP-VIP. Trigger phrases: "ingest this",
  "process feedback from", "groom the backlog", "run cascade review", "update backlog".
copilot:
  tools: ["vscode/askQuestions", "read/readFile", "search/semanticSearch", "search/textSearch", "workspace/fileSearch", "workspace/createDirectory", "workspace/createFile", "edit/editFile", "search/webSearch"]
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
cc:
  tools: ["Read", "LS", "Glob", "Grep", "WebSearch", "Write", "Edit", "TodoRead", "TodoWrite"]
  disallowedTools: ["Bash", "Task", "MultiEdit"]
  model: claude-opus-4-5
  skills: [architecture, deep-research, semantic_search]
---
```

**Note**: ProductOwner `disallowedTools` includes:
  - `Bash`: Prevents direct PowerShell/terminal execution for binary format conversion (Worker handles `.docx`/`.eml` conversion with pandoc/email parsers).
  - `Task`: Prevents subagent spawning outside PM orchestration (all external agent coordination routes through ProjectManager).
  - `MultiEdit`: Prevents path-agnostic bulk edits across authorization boundaries (e.g., simultaneous edits to `code/` and `learning_base/` in one operation; PO is scoped to `learning_base/` and `docs/ways-of-work/` only).

### BusinessAnalyst (Existing Agent — Handoff Back to ProductOwner)

```yaml
---
name: BusinessAnalyst
description: >
  Requirements detail, architecture alignment, and technical feasibility assessment.
  Works with ProductOwner on VoC-driven requirements updates and with ScrumMaster on
  sprint planning constraints. Trigger phrases: "review requirements", "check architecture
  alignment", "validate technical feasibility".
copilot:
  tools: [...]
  model: opus
  user-invokable: true
  handoffs:
    - label: Return to ProductOwner
      agent: ProductOwner
      prompt: "Backlog items are now requirements-aligned. PO can proceed to sprint planning."
      send: true
    - label: Review with Architecture
      agent: BackendDev
      prompt: "Verify these requirements are architecturally feasible."
      send: false
cc:
  tools: [... existing BA spec ...]
  disallowedTools: [... existing BA spec ...]
  model: claude-opus-4-5
  skills: [architecture, deep-research]
---
```

### ScrumMaster (Existing Agent — Handoff Back to ProductOwner)

```yaml
---
name: ScrumMaster
description: >
  Sprint planning, execution cadence, and backlog breakdown. Works with ProductOwner
  on grooming inputs and with BusinessAnalyst on requirements-to-sprint mapping.
  Trigger phrases: "plan sprint", "breakdown user story", "status update", "sprint review".
copilot:
  tools: [...]
  model: opus
  user-invokable: true
  handoffs:
    - label: Return to ProductOwner
      agent: ProductOwner
      prompt: "Sprint plan complete. PO may need to adjust backlog based on capacity constraints."
      send: true
cc:
  tools: [... existing SM spec ...]
  disallowedTools: [... existing SM spec ...]
  model: claude-opus-4-5
  skills: [breakdown-plan]
---
```

### Worker (Existing Agent — Handoff to ProductOwner)

```yaml
---
name: Worker
description: >
  Full-access executor for resource conversion, file setup, and technical tasks.
  Converts binary resources (.docx, .eml, .msg) to markdown for ProductOwner classification.
  Trigger phrases: "convert these files", "set up environment", "run this script", "execute".
copilot:
  tools: [...]
  model: opus
  handoffs:
    - label: Classify and Route
      agent: ProductOwner
      prompt: "Resources are converted to markdown. PO will classify and route to learning_base."
      send: true
cc:
  tools: [... existing Worker spec ...]
  disallowedTools: [... existing Worker spec ...]
  model: claude-opus-4-5
  skills: [...]
---
```

---

## Detailed File Changes (Phase 4 Deliverables)

All writes in this phase are limited to `.tasks/005-pm-agent-system/`.

### 1. Create `.tasks/005-pm-agent-system/artifacts/phase-4/phase-4-productowner-spec.md`

Content:
- **ProductOwner Role Charter**: one-paragraph statement of purpose, primary responsibilities (stakeholder intake, VoC structuring, backlog curation, cascade review triggering), and explicit non-goals (no architecture decision-making, no test execution, no diagram generation, no format conversion mechanics).
- **Permission Tier**: Tier W (write-enabled), identical in tool scope to BusinessAnalyst and ScrumMaster per pm_agent_coordination_system_implementation_plan.md Section 8.
  - Copilot tools: `vscode/askQuestions`, `read/readFile`, `search/*`, `workspace/fileSearch`, `workspace/createDirectory`, `workspace/createFile`, `edit/editFile`, `search/webSearch`.
  - Copilot excluded: `terminal/runInTerminal` (Worker handles binary conversion with Bash).
  - CC tools: `Read`, `LS`, `Glob`, `Grep`, `WebSearch`, `Write`, `Edit`, `TodoRead`, `TodoWrite`.
  - CC excluded: `Bash` (Worker handles conversion), `Task` (PM orchestrates), `MultiEdit` (path-granular control).
- **Skill Integration Summary**: table mapping four Phase 2 skills to ProductOwner workflows:
  - `resource-ingestion`: text classification + template application for mixed resources.
  - `stakeholder-feedback`: VoC creation with guardrail mapping and actionable insights.
  - `requirements-cascade`: trigger cascade check after VoC or backlog changes.
  - `backlog-management`: MoSCoW prioritization and phase-aligned grooming.
- **Trigger Phrase Catalogue**: exhaustive list of user-facing activation phrases per skill (minimum 6 variants per skill for natural language invocation). Examples:
  - resource-ingestion: "ingest [doc]", "process this document", "classify this resource", "drop [file] in inbox", "add to learning_base"
  - stakeholder-feedback: "process feedback from [name]", "create VoC for [stakeholder]", "extract insights from", "summarize stakeholder input"
  - requirements-cascade: "run cascade review", "check what's impacted", "verify requirements alignment", "update dependent docs"
  - backlog-management: "groom the backlog", "prioritize backlog", "update sprint backlog", "estimate effort for", "phase-align items"
- **Output Contract**: artifact types produced (VoC records, backlog updates, cascade change summaries), expected save locations (`learning_base/11_voice_of_customer/voc_NNN_*.md`, `docs/ways-of-work/backlog.md`, `.tasks/*/cascade-review-*.md`), required metadata keys (author, date, related_feature, tags).
- **Escalation Path**: exactly one escalation route (→ ProjectManager for stakeholder deadlock, resource constraints, or cross-team conflict).
- **Invocation Patterns**: (a) direct user invocation via Copilot @ProductOwner or user "use ProductOwner"; (b) subagent invocation by ProjectManager with skill-specific keyword structure (ADR-004 compliance); (c) disallowed contexts (no direct peer-to-peer calls to specialists; all external coordination routes through PM).
- **Domain Language Reference**: table of HTP-VIP domain terms (Trial, Plot, Germplasm, Guardrail, Phenotypic Trait, etc.) with brief definitions to support stakeholder communication.
- **Canonical Invocation Examples**: one Copilot example and one CC example per major workflow (resource ingestion, VoC processing, backlog grooming, cascade check), stating allowed caller role, disallowed caller role, expected checkpoint pause behavior, and how the handoff is triggered.

### 2. Create `.tasks/005-pm-agent-system/artifacts/phase-4/phase-4-handoff-contracts-matrix.md`

Content:
- **ProductOwner → BusinessAnalyst Handoff Contract**:
  - Trigger phrase: "Update requirements based on" or "Incorporate VoC into".
  - Upstream caller: ProductOwner (via skill workflow or direct delegation).
  - Input expected: VoC record markdown file with verbatim quotes, quantified pain points, guardrail mappings, and feature requests prioritized by impact/frequency.
  - Output produced: Requirements document updates in `learning_base/02_requirements/` with traced references to VoC source and guardrail compliance assessment.
  - Downstream consumers: ProjectManager (checkpoint decision on cascade), ScrumMaster (for sprint planning), FrontendDev/BackendDev (advisor review on feasibility).
  - Checkpoint pause expected: YES. ProductOwner review required after BA completes requirements update to confirm stakeholder intent is captured and no scope creep occurred before cascade proceeds.
  - Reverse handoff: BA → ProductOwner: "Requirements updated. Ready for cascade and sprint planning."

- **ProductOwner → ScrumMaster Handoff Contract**:
  - Trigger phrase: "Plan sprint based on" or "Create sprint plan from".
  - Upstream caller: ProductOwner (after backlog grooming completes).
  - Input expected: Prioritized backlog markdown (from backlog-management skill) with MoSCoW labels (Must/Should/Could/Won't), phase alignment (Phase 1/2/3/4), effort estimates, dependency list, and stakeholder/technical value ratings.
  - Output produced: Sprint plan with breakdown tasks, effort (story points or days), dependencies, acceptance criteria, and QA test scope mapping in `docs/ways-of-work/sprint_NN.md`.
  - Downstream consumers: ProjectManager (execution tracking), FrontendDev/BackendDev (technical feasibility input), QAEngineer (test plan generation).
  - Checkpoint pause expected: YES. ProductOwner review after SM completes sprint plan to confirm backlog interpretation and confirm capacity/phase alignment before execution begins.
  - Reverse handoff: SM → ProductOwner: "Sprint plan ready. Backlog items mapped to tasks and effort."

- **ProductOwner → Worker Handoff Contract**:
  - Trigger phrase: "Convert these resources" or "Process binary resources".
  - Upstream caller: ProductOwner (resource-ingestion skill, when binary resources detected).
  - **Skill assumption**: resource-ingestion skill assumes **pre-identified binary resources** (user has flagged files needing format conversion). If PO is uncertain whether a resource is pre-converted or requires Worker processing, PO first reviews the file extension/type locally; if binary/proprietary format is confirmed, PO invokes Worker. If already markdown/text, PO processes directly without Worker delegation.
  - Input expected: List of file paths to convert (.docx, .eml, .msg, or other binary/proprietary formats) with intended classification (e.g., "meeting notes", "stakeholder email", "vendor document").
  - Output produced: Markdown files in `learning_base/_inbox/` with metadata header (source_file, source_type, ingested_date, author, classification, tags) and converted content ready for PO classification.
  - Downstream consumers: ProductOwner (classification + route) → appropriate learning_base folder with template applied.
  - Checkpoint pause expected: YES. ProductOwner review of converted markdown output to confirm formatting quality and completeness before classification. If conversion failed or garbled, handoff back to Worker for re-conversion with clarified intent.
  - Reverse handoff: Worker → ProductOwner: "Resources converted to markdown in _inbox/. Ready for classification."

- **Worker → ProductOwner Reverse Handoff**:
  - Condition: Binary resource conversion completes.
  - Handoff trigger: Worker completion with "Classify and Route" button to ProductOwner.
  - **PO MUST pause** before proceeding: Review converted markdown quality, formatting, and completeness. If conversion failed or produced garbled output, reject with clarification and send back to Worker for re-conversion. Only proceed if output is acceptable.
  - Expected PO action after pause acceptance: Classify into learning_base category, apply template, and trigger cascade review.
  - Disallowed action: Worker does NOT classify or route; PO owns strategy for where resources should live.

- **BusinessAnalyst → ProductOwner Reverse Handoff**:
  - Condition: Requirements update completes.
  - Handoff trigger: BA completion with "Return to ProductOwner" button.
  - **PO MUST pause** before proceeding: Review requirements changes for stakeholder alignment, confirm no scope creep has occurred, and verify requirements traceability back to original VoC. Only proceed if all stakeholder intent is captured and no unintended scope expansion is detected.
  - Expected PO action after pause acceptance: Approve cascade review or request BA revision with specific feedback.
  - Disallowed action: BA does not proceed to cascade review; cascade is PO-triggered via requirements-cascade skill.

- **ScrumMaster → ProductOwner Reverse Handoff**:
  - Condition: Sprint plan completes.
  - Handoff trigger: SM completion with "Return to ProductOwner" button.
  - **PO MUST pause** before proceeding: Review sprint plan for backlog interpretation accuracy, phase alignment, and capacity realism. Confirm that backlog item priorities are respected in task sequence and that phase roadmap constraints are honored. Only proceed if sprint plan reflects PO strategic intent and phase commitments.
  - Expected PO action after pause acceptance: Approve for execution or request SM re-planning with specific constraint clarifications.
  - Disallowed action: SM does not adjust backlog priorities; PO owns backlog curation authority.

- **Ambiguity Resolution Registry** (high-risk boundaries for common mistakes):
  - Situation: "Should ProductOwner or BusinessAnalyst write requirements documents?"
    - Answer: BA writes detailed requirements (criteria, acceptance conditions, design rationale). PO writes backlog items (user value, priority, estimated effort), VoC records (quotes, pain points, guardrails), and backlog change rationale. No double-writing; handoff is coordinated via checkpoint.
  - Situation: "Should ProductOwner or ScrumMaster assign story points and dependencies?"
    - Answer: PO grooming gathers initial effort opinion from team (collaborative, rough); SM breakdown assigns final story points after detailed design review. PO owns prioritization; SM owns detailed breakdown.
  - Situation: "Should ProductOwner or Worker convert .docx files?"
    - Answer: Worker converts binary formats (requires Bash/pandoc). PO processes already-markdown documents and decides where converted output should be classified. If PO cannot determine category (ambiguous content), PO can ask Worker for clarification or send to BA for categorization guidance.
  - Situation: "When does cascade review happen: after VoC creation, after requirements update, or both?"
    - Answer: After VoC creation (PO-triggered, to find which requirements and docs are impacted). After requirements update if new requirements are added (BA-triggered, but coordinated with PO checkpoint). After backlog changes if strategic priority shift impacts roadmap (PO-triggered).

---

### 3. Create `.tasks/005-pm-agent-system/artifacts/phase-4/phase-4-template-skeleton.md`

Content:
- ProductOwner template skeleton for `templates/agents/product-owner.template.md`.
- Required shared frontmatter block:
  - `name: ProductOwner`
  - `description`: multi-line with trigger phrases (ingest, feedback, cascade, backlog, groom) embedded in description per templates README activation pattern.
- **Copilot block** with:
  - `tools`: explicit inclusion list (read, search, workspace create/edit, web search).
  - `model`: "opus" (larger model for complex stakeholder communication and cross-domain understanding).
  - `user-invokable: true` (PO is user-accessible for direct intake request).
  - `handoffs`: three handoff buttons to BA, SM, and Worker with required keyword structure.
- **CC block** with:
  - `tools`: list using CC tool names (Read, LS, Glob, Grep, Write, Edit, Web, Todo).
  - `disallowedTools: ["Bash", "Task", "MultiEdit"]` (explicit machine-enforcement of conversion boundary and orchestration constraint).
  - `model: "claude-opus-4-5"`.
  - `skills: [architecture, deep-research, semantic_search]` (for understanding domain context, VoC insight extraction, cascade impact analysis).
- **Body block structure** (marked as placeholder descriptions):
  - `## Role`: ProductOwner primary responsibilities and escalation path.
  - `## Project Context`: HTP-VIP vision, domain language, stakeholder registry, learning_base structure, and backlog strategy.
  - `## Skill Trigger Catalogue`: detailed table of trigger phrases per Phase 2 skill with use cases and expected output format.
  - `## Permission Boundaries`: explicit statement that PO may write to `learning_base/` and `docs/ways-of-work/` only; no code, tests, configs, or architecture spec edits. Cannot execute scripts or Bash commands.
  - `## Handoff Contracts`: inline reference (or embedding) of the three primary handoff contracts (BA, SM, Worker) with checkpoint pause conditions.
  - `## Invocation Patterns`: direct user invocation, PM-delegated subagent invocation (ADR-004 style), disallowed contexts.
  - `## Domain Language`: HTP-VIP domain terms reference table (Trial, Plot, Germplasm, Phenotypic Trait, Guardrail, etc.).
- Note platform divergence where applicable: `<!-- COPILOT-ONLY -->` or `<!-- CC-ONLY -->` directives for any tool-specific invocation guidance (per ADR-005).

### 4. Create `.tasks/005-pm-agent-system/artifacts/phase-4/phase-4-existing-agent-handoff-stubs.md`

Content:
- Individual sections for BusinessAnalyst, ScrumMaster, and Worker showing:
  - Current handoff buttons/labels (if already present in agents-personal templates).
  - Required additions: explicit "Return to ProductOwner" button with required keyword structure for reverse handoff.
  - Confirmation that existing tool scopes (write permissions for BA/SM, execute for Worker) are NOT changed by Phase 4 (PO integration does not modify existing agent templates — only clarifies contractual handoffs).
- Each section documents:
  - Agent name.
  - Current Tier assignment (BA: Tier W, SM: Tier W, Worker: Tier X — full access).
  - Required handoff button addition (YAML snippet showing `label`, `agent: ProductOwner`, `prompt`, `send: true/false`).
  - Checkpoint pause requirement for ProductOwner review (Y/N).
  - Any skill alignment with PO workflows (BA: deep-research, architecture for requirements review; SM: breakdown-plan for sprint generation; Worker: file-system and conversion mechanics).

### 5. Create `.tasks/005-pm-agent-system/artifacts/phase-4/phase-4-worker-vs-productowner-conversion-decision-matrix.md`

Content:
- **Conversion Responsibility Matrix** (clear decision rules):
  - Resource type: .md, .txt, .csv, URLs, PDFs → ProductOwner processes directly (no conversion needed; already text format).
  - Resource type: .docx, .eml, .msg → Worker converts to markdown using Bash/`pandoc`/email parsers.
  - Resource type: .jpg, .png, .gif, other binary → Worker converts to text summary (OCR if applicable) or creates reference placeholder.
  - Resource type: .zip, .tar, .rar → Worker extracts and catalogs contents; classifies extracted items per above rules.
- **Process Flow**:
  - Step 1 (ProductOwner): Detect resource type from file extension or mime type.
  - Step 2 (Decision): If binary/proprietary → delegate to Worker. If already text → proceed to Step 3.
  - Step 3 (Worker if delegated): Convert to markdown with metadata header intact.
  - Step 4 (Checkpoint): Worker → ProductOwner handoff with converted markdown. PO reviews quality, formatting, and completeness.
  - Step 5 (ProductOwner): Classify converted resource (or PO-direct resource) into learning_base category using resource-ingestion skill.
  - Step 6 (ProductOwner): Apply learning_base template (meeting_notes, VoC, requirements, etc.) and trigger cascade review if impactful.
- **Disallowed Boundary**:
  - ProductOwner must NOT attempt to convert binary resources (no Bash, no terminal access).
  - Worker must NOT classify or route resources into learning_base categories (that is PO strategy).
  - If conversion produces ambiguous output (garbled, truncated), Worker escalates with "Cannot convert safely" message; PO decides next steps (re-send, skip, manual review).

### 6. Create `.tasks/005-pm-agent-system/artifacts/phase-4/phase-4-source-traceability-matrix.md`

Content:
- One row per normative design decision in Phase 4 artifacts.
- Required minimum columns (same as Phase 2/3 pattern):
  - `po rule` — the design decision being traced.
  - `source doc` — file path of the authoritative source.
  - `source clause` — specific section or heading within the source.
  - `implementation note` — how the rule is applied in the Phase 4 ProductOwner spec.
  - `verification evidence` — how the Builder or reviewer can confirm compliance.
- Coverage must reference all mandatory source documents listed in this plan.
- Minimum coverage targets:
  - At least one row for ProductOwner role charter and Tier W assignment (per pm_agent_coordination_system_implementation_plan.md Section 8).
  - At least one row per skill integration (four rows: resource-ingestion, stakeholder-feedback, requirements-cascade, backlog-management).
  - One row per handoff contract (three rows: PO→BA, PO→SM, PO→Worker).
  - One row for Worker conversion boundary and disallowedTools enforcement.
  - At least one row per agents-personal ADR referenced.
  - One row for orchestration compliance (ADR-001) confirming bidirectional handoffs and checkpoint pause patterns.

---

## Implementation Steps

### Step 1: Derive ProductOwner role charter from implementation plan and existing agents

- Use pm_agent_coordination_system_implementation_plan.md Section 3.2 ProductOwner description and Section 8 Agent Access Summary.
- Use business-analyst.template.md and scrum-master.template.md patterns as Tier W reference.
- Use conductor.template.md orchestration pattern for handoff escalation.
- Confirm non-overlap with BusinessAnalyst (detail vs. strategy), ScrumMaster (planning vs. curation), and Worker (mechanics vs. strategy) via the comparison table.
- Source: `pm_agent_coordination_system_implementation_plan.md`, `business-analyst.template.md`, `conductor.template.md`, ADR-001, ADR-002.

### Step 2: Define ProductOwner permission tier and tool scope

- AssignTier W (write-enabled) matching BusinessAnalyst and ScrumMaster.
- For Copilot tools:
  - Include: `vscode/askQuestions`, `read/readFile`, `search/semanticSearch`, `search/textSearch`, `workspace/fileSearch`, `workspace/createDirectory`, `workspace/createFile`, `edit/editFile`, `search/webSearch`.
  - Exclude: `terminal/runInTerminal` (Worker handles Bash-requiring conversions).
  - Note: no `execute/` tools (read+write, not execute).
- For CC tools:
  - Include: `Read`, `LS`, `Glob`, `Grep`, `WebSearch`, `Write`, `Edit`, `TodoRead`, `TodoWrite`.
  - Exclude (explicit `disallowedTools`): `Bash` (Worker boundary), `Task` (orchestration boundary), `MultiEdit` (path-controlled edits only).
- Validate tool scopes against pm_agent_coordination_system_implementation_plan.md Section 8 (Agent Access Summary).
- Source: `templates/README.md`, `conductor.template.md` (disallowedTools pattern), ADR-002, ADR-005.

### Step 3: Map ProductOwner to Phase 2 skill integrations

- Confirm all four Phase 2 skills are accessible to ProductOwner:
  - `resource-ingestion`: file classification + template application.
  - `stakeholder-feedback`: VoC creation with guardrail mapping.
  - `requirements-cascade`: trigger cascade check for impact analysis.
  - `backlog-management`: MoSCoW prioritization and phase alignment.
- For each skill, derive trigger phrases (minimum 6 variants) and use cases from Phase 2 skill specifications.
- **Worked Example — resource-ingestion trigger-phrase derivation**:
  - Base intent: "User wants to ingest a document (email, meeting notes, stakeholder feedback) into the learning_base."
  - Variant 1: "Ingest this document." (direct user language)
  - Variant 2: "Add this to the learning_base." (alternate framing)
  - Variant 3: "Process this stakeholder feedback." (domain-specific language)
  - Variant 4: "Classify and route this resource." (action-oriented)
  - Why variants matter: Users naturally phrase requests different ways; multiple trigger phrases ensure skill activation without requiring exact keyword matching. These four cover imperative (ingest, add), domain (feedback), and action-oriented (classify) formulations.
- Source: `phase-2-skill-template-set.md`, `phase-2-skill-contracts.md`.

### Step 4: Define handoff contracts with explicit checkpoint pause patterns

- For each of three handoff pairs (PO→BA, PO→SM, PO→Worker):
  - Derive upstream caller, input expected, output produced, downstream consumers from pm_agent_coordination_system_implementation_plan.md Section 5 (PM Orchestration Workflows).
  - Map checkpoint pause expectation to ADR-001 orchestration model: "CHECKPOINT: [action]. [decision options]?"
  - Specify reverse handoff button label and prompt structure.
- Use conductor.template.md and business-analyst.template.md as examples of handoff syntax.
- Source: `pm_agent_coordination_system_implementation_plan.md` Sections 5.1-5.6, ADR-001.

### Step 5: Create Worker vs. ProductOwner conversion decision matrix

- Enumerate resource types and decision rules for conversion responsibility.
- Specify boundary: Worker converts binary/proprietary; ProductOwner classifies and routes.
- Define checkpoint between Worker output and PO classification.
- Source: `pm_agent_coordination_system_implementation_plan.md` Section 6.2, REQ-406 (Phase 4 requirement).

### Step 6: Draft ProductOwner template skeleton

- Confirm all required frontmatter blocks are present: `name`, `description` (with trigger phrases), `copilot:` block, `cc:` block.
- For CC block, explicitly cite `disallowedTools: ["Bash", "Task", "MultiEdit"]` with brief explanation of boundary reasoning:
  - `Bash` blocks Worker conversion delegation boundary (Worker owns `.docx`/`.eml` format conversion).
  - `Task` blocks PM orchestration boundary (only PM can invoke subagents; PO delegates via handoff buttons).
  - `MultiEdit` blocks cross-authorization-boundary edits (e.g., code ↔ learning_base simultaneous edits; PO scope is `learning_base/` and `docs/ways-of-work/` only).
- Include `## Skill Trigger Catalogue`, `## Permission Boundaries`, `## Handoff Contracts`, and `## Domain Language` sections as body structure placeholders.
- Flag any platform divergence requiring `<!-- COPILOT-ONLY -->` or `<!-- CC-ONLY -->` directives.
- Source: `templates/README.md`, ADR-005.

### Step 7: Identify required additions to existing-agent templates

- For BusinessAnalyst, ScrumMaster, and Worker: confirm current handoff button structure (from agents-personal templates).
- Specify required additions: explicit "Return to ProductOwner" button with required YAML syntax.
- Document that Phase 4 does NOT modify existing agent templates; Phase 4 spec only clarifies contractual handoffs for Builder implementation in Phase 5.
- Source: `business-analyst.template.md`, `scrum-master.template.md`, `worker.template.md`.

### Step 8: Build source traceability matrix

- For each normative rule in Phase 4 artifacts, create one row with full citation.
- Verify minimum coverage targets stated in Detailed File Changes section — Step 6 are met.
- Source: all mandatory sources listed in this plan.

### Step 9: Publish artifacts and update phase tracking

- Write five Phase 4 artifacts into `.tasks/005-pm-agent-system/artifacts/phase-4/`.
- Update Phase 4 row in `task.md` to `📋 Planned` with plan link and notes.

---

## Dependencies

- DEP-401: Phase 1 baseline plan (`phase-1-baseline-reuse-mapping.md`) — provides orchestration constraints, existing-agent interface map, and reuse boundaries.
- DEP-402: Phase 2 skill template set (`phase-2-skill-template-set.md`) — provides skill contracts, trigger phrases, and input/output schemas that ProductOwner integrates.
- DEP-403: Phase 3 specialist agent templates (`phase-3-specialist-agent-templates.md`) — establishes permission tier patterns and handoff matrix structure.
- DEP-404: Read access to pm_agent_coordination_system_implementation_plan.md Sections 3.2 (ProductOwner), 5 (Workflows), 6 (Ingestion Pipeline), 8 (Agent Access Summary).
- DEP-405: Read access to agents-personal templates and ADRs (listed in Source Guidelines).
- DEP-406: Read access to learning_base/REVIEW_WORKFLOW.md for cascade dependency model.

---

## Risks and Mitigations

- RISK-401: ProductOwner and BusinessAnalyst responsibilities overlap on requirements — both want to interpret stakeholder intent.
  - MIT-401: Establish clear boundary: PO owns strategic backlog + VoC (what stakeholders say they want); BA owns requirements detail + architecture alignment (how to deliver it). Document this split explicitly in the ambiguity resolution table with concrete decision examples. CP-4.1 gates plan approval on this clarity.

- RISK-402: ProductOwner and ScrumMaster both manage backlog — confusion on who owns priority vs. breakdown.
  - MIT-402: Scope PO to MoSCoW pre-prioritization (strategic value + stakeholder impact) and SM to sprint breakdown (effort + dependencies + task sequence). Checkpoint pause between grooming and planning enforces handoff clarity. Document in ambiguity resolution table.

- RISK-403: Worker conversion failures (garbled .docx, email extraction truncated) leave ProductOwner without clear next steps.
  - MIT-403: Specify checkpoint pause after Worker handoff: PO must review converted markdown quality and can request re-conversion with clarification on failed section. If unrecoverable, PO escalates to ProjectManager for stakeholder contact or skip decision.

- RISK-404: ProductOwner attempts direct Bash execution (e.g., runs pandoc for .docx conversion without delegating to Worker).
  - MIT-404: Explicitly list `terminal/runInTerminal` and `Bash` in ProductOwner `disallowedTools` at machine enforcement level. Include a `## Permission Boundaries` section in the template body stating "Cannot execute scripts or Bash commands; Worker handles resource format conversion."

- RISK-405: Cascade review is triggered redundantly by both PO and BA — causing duplicate checking or conflicting updates.
  - MIT-405: Establish clear cascade workflow: PO triggers cascade after VoC creation to identify impacted documents, then BA updates requirements (within cascade scope); second cascade check happens only if new requirements are added that might trigger secondary impacts. Document in requirements-cascade skill trigger conditions.

- RISK-406: Template skeleton generated with invalid YAML (folded blocks in tools list, nested handoff structures).
  - MIT-406: Follow the inline list format shown in Phase 3 inline stubs (e.g., `tools: ["read/readFile", "search"]`) and avoid folded YAML blocks in frontmatter, per templates README validation rules.

- RISK-407: Skills assigned to ProductOwner in CC block conflict with write-only constraints (e.g., a skill that requires execute permissions).
  - MIT-407: Verify each Phase 2 skill's allowed-tools and confirm they are read+write compatible (no execute). Flag any conflict in the source traceability matrix for resolution before Builder execution.

---

## Success Criteria

- SC-401: ProductOwner role charter exists with explicit non-goals and three-way non-overlap with BA, SM, and Worker confirmed via comparison table.
- SC-402: ProductOwner permission tier is assigned as Tier W (write-enabled) with explicit tool inclusion and CC `disallowedTools: ["Bash", "Task", "MultiEdit"]` specified.
- SC-403: Three handoff contracts (PO→BA, PO→SM, PO→Worker) are explicit with upstream callers, input summary, output format, downstream consumers, and checkpoint pause expectation defined for each.
- SC-404: Two-stage resource conversion process is clearly specified: Worker converts binary formats (with Bash); ProductOwner classifies and routes text resources with templates.
- SC-405: All four Phase 2 skills are mapped to ProductOwner with trigger phrases, use cases, and escalation paths enumerated.
- SC-406: ProductOwner template skeleton conforms to `agents-personal/templates/README.md` agent template frontmatter format with required `name`, `description`, `copilot:`, and `cc:` blocks.
- SC-407: ProductOwner `disallowedTools` explicitly include `Bash` and `Task` at the machine-enforcement level, preventing format conversion and subagent spawning outside PM orchestration.
- SC-408: Ambiguity resolution table covers three high-risk boundaries (PO vs BA on requirements, PO vs SM on planning, PO vs Worker on conversion).
- SC-409: Reverse handoff buttons for BA, SM, and Worker are specified with required YAML keyword structure for ProductOwner return.
- SC-410: Source traceability matrix meets minimum coverage targets: one role, four skills, three handoffs, one conversion boundary, citations spanning all mandatory source ADRs.
- SC-411: Phase 4 is marked `📋 Planned` in `task.md` and linked to this plan file.
- SC-412: All Phase 4 write targets are `.tasks/005-pm-agent-system/**` only.

---

## Verification

### Automated Checks

Confirm Phase 4 plan exists and is linked from task.md:
```
rg "ProductOwner and Existing-Agent Integration|phase-4-productowner-existing-agent-integration.md|📋 Planned" .tasks/005-pm-agent-system
```

Confirm mandatory source references are present in this plan:
```
rg "agents-personal|ADR-001|ADR-002|ADR-004|ADR-005|pm_agent_coordination_system_implementation_plan|business-analyst|scrum-master|worker" .tasks/005-pm-agent-system/plan/phase-4-productowner-existing-agent-integration.md
```

Confirm ProductOwner Tier W assignment and disallowedTools:
```
rg "Tier W|disallowedTools.*Bash|disallowedTools.*Task" .tasks/005-pm-agent-system/plan/phase-4-productowner-existing-agent-integration.md
```

Confirm all three handoff contracts are named:
```
rg "ProductOwner → BusinessAnalyst|ProductOwner → ScrumMaster|ProductOwner → Worker" .tasks/005-pm-agent-system/plan/phase-4-productowner-existing-agent-integration.md
```

Confirm permission boundary rules are declared:
```
rg "Cannot execute|no Bash|Worker handles|ProductOwner classifies" .tasks/005-pm-agent-system/plan/phase-4-productowner-existing-agent-integration.md
```

Confirm traceability matrix file is declared:
```
rg "phase-4-source-traceability-matrix" .tasks/005-pm-agent-system/plan/phase-4-productowner-existing-agent-integration.md
```

Confirm all declared file create/update targets are `.tasks`-scoped:
```
rg "^### [0-9]+\. (Create|Update) " .tasks/005-pm-agent-system/plan/phase-4-productowner-existing-agent-integration.md
```
(Reviewer check: each matched path must start with `.tasks/005-pm-agent-system/`.)

Confirm ProductOwner frontmatter stub is embedded (CP-4.6 direct evidence):
```
rg "name: ProductOwner" .tasks/005-pm-agent-system/plan/phase-4-productowner-existing-agent-integration.md
```
(Expected: at least one match in the Inline Frontmatter Stubs section.)

Confirm Worker vs. ProductOwner boundary is explicit:
```
rg "Worker converts|ProductOwner classifies|conversion boundary|binary.*Worker|.docx.*Worker" .tasks/005-pm-agent-system/plan/phase-4-productowner-existing-agent-integration.md
```

### Manual Verification Steps

1. Review `phase-4-productowner-spec.md` and confirm ProductOwner role charter includes three explicit non-goals (no architecture, no tests, no diagrams).
2. Confirm ProductOwner permission tier table lists exactly the same Copilot and CC tools as BusinessAnalyst and ScrumMaster (Tier W reference).
3. Confirm `disallowedTools` array for ProductOwner explicitly includes `Bash` (blocks Worker conversion), `Task` (blocks orchestration bypass), and `MultiEdit` (blocks path-agnostic edits).
4. Confirm the three handoff contracts (BA, SM, Worker) each specify upstream caller, input summary, output format, and checkpoint pause expectation with explicit "YES" or "NO".
5. Confirm Worker vs. ProductOwner conversion matrix clearly states: Worker converts binary (.docx, .eml, .msg); ProductOwner classifies already-text resources.
6. Confirm reverse handoff buttons for BA, SM, and Worker are specified with YAML syntax showing `agent: ProductOwner`, `label`, and `prompt`.
7. Confirm the ambiguity resolution table covers all three high-risk boundaries (PO vs BA, PO vs SM, PO vs Worker) with concrete decision examples.
8. Confirm no files outside `.tasks/` were modified while preparing this phase plan.
9. Confirm reviewer CP-4.2 and CP-4.4 acceptance is explicitly required before `⭐ Reviewed` transition.
10. Confirm all four Phase 2 skills (resource-ingestion, stakeholder-feedback, requirements-cascade, backlog-management) are mapped to ProductOwner trigger phrases and use cases.

### Success Evidence

- Builder can implement Phase 4 artifacts using only this plan plus the mandatory source set, without additional research.
- Reviewer can trace every ProductOwner permission boundary, handoff contract, and skill integration back to `agents-personal` sources and pm_agent_coordination_system_implementation_plan.md.
- Phase 5 (ProjectManager Orchestration Layer) can reference the Phase 4 handoff contracts and skill integrations without additional ProductOwner-related research.
- Phase 6 (Access and Permission Governance) can use Phase 4 Tier W assignment and disallowedTools as foundational rules for ProductOwner access matrix enforcement.

---
