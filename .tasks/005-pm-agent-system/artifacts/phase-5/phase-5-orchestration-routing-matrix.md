---
artifact: phase-5-orchestration-routing-matrix
phase: 5
created: 2026-03-18
status: reviewed
tags: [orchestration, routing, matrix, workflows, checkpoints, conditional-branching]
---

# Phase 5 Artifact: Orchestration Routing Matrix

## Master Routing Table

| Workflow | Name | Entry Trigger | Caller Role(s) | Step Sequence | Agents | Checkpoint IDs | Success Termination | Failure Path |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| A | Resource Ingestion | "Ingest", "Add to learning_base", "Process resource" | User, ProductOwner | PO classify → PO template → PO validate path | ProductOwner, [Worker if binary] | CP-A1, CP-A2, CP-A3 | `learning_base/[subdir]/[name].md` created with metadata | Cannot classify → PM pause + user prompt |
| B | Stakeholder Feedback | "Process feedback", "Create VoC", "Extract insights" | ProductOwner, Stakeholder | PO capture → PO guardrail map → PO extract insights → [cascade trigger] | ProductOwner, [BA if cascade needed] | CP-B1, CP-B2, CP-B3 | VoC record in `learning_base/11_voice_of_customer/` | Unclear feedback → stakeholder clarification |
| C | Requirements Cascade | "Run cascade review", "Check what's impacted", "Update dependent docs", "Verify requirements alignment" | ProductOwner, BusinessAnalyst | PO trigger → BA impact analysis → BA update requirements → [FE/BE review if needed] → cascade verify | ProductOwner, BusinessAnalyst, [FrontendDev], [BackendDev] | CP-C1, CP-C2, CP-C3, CP-C4 | Requirements doc updated, dependent docs linked | Scope creep → rework or escalate |
| D | Diagram Lifecycle | "Create diagram", "Update diagram", "Publish diagram", "Render Mermaid" | ProductOwner, UIUXDesigner | UIUX design → UIUX render → UIUX validate source → UIUX publish | UIUXDesigner | CP-D1, CP-D2, CP-D3, CP-D4 | `images/diagrams/[name].png` published, manifest updated | Render fail → UIUX correction; format unsupported → PM escalate |
| E | Backlog Planning | "Groom backlog", "Plan sprint", "Prioritize items", "Sprint planning", "Assign phase" | ProductOwner, ScrumMaster, User | PO prioritize (MoSCoW) → SM breakdown + estimate → SM dependencies → sprint plan publish | ProductOwner, ScrumMaster | CP-E1, CP-E2, CP-E3, CP-E4 | `docs/ways-of-work/sprint_NN.md` published | Backlog blocked → BA for req clarification or defer |
| F | Quality Gate Review | "Run test", "Quality gate", "QA review", "Test pass/fail decision", "Execute test suite" | QAEngineer, ProductOwner | QA execute → QA review results → QA pass/fail decision | QAEngineer, [FrontendDev/BackendDev if technical failure] | CP-F1, CP-F2, CP-F3, CP-F4 | Sprint item status "Done"; artifact published | Tests fail → rework task or PM escalation if blocker |

---

## Workflow A: Resource Ingestion — Detailed Routing

```
[User/PO] "Ingest [document]"
    │
    ▼
PM Entry Gate (keyword match: "ingest" | "add to learning_base" | "process resource")
    │
    ▼
ProductOwner (resource-ingestion skill)
    │
    ▼ CP-A1: Resource classified?
    ├─ PASS → ProductOwner: apply metadata template
    └─ FAIL (ambiguous) → PM PAUSE: user selects category
         └─ User confirms → ProductOwner: apply confirmed classification
    │
    ▼ CP-A2: Template applied?
    ├─ PASS → ProductOwner: validate learning_base path
    └─ FAIL → ProductOwner: rework metadata header
    │
    ▼ CP-A3: learning_base path valid?
    ├─ PASS → [if binary file] Worker: convert to markdown → PM: confirm Workflow A success
    └─ FAIL → PM PAUSE: path error; PM prompts user for target directory
    │
    ▼
SUCCESS: Resource filed. PM notifies user.
```

| Step | Agent | Skill/Action | Expected Input | Expected Output | Next Checkpoint | Disallowed Actions |
| --- | --- | --- | --- | --- | --- | --- |
| 1 | ProductOwner | `resource-ingestion` — classify resource | Document path, resource type hint | Classification tag, target subdir | CP-A1 | No code execution, no direct file writes outside learning_base |
| 2 | ProductOwner | Apply metadata template | Classified resource | Markdown file with YAML frontmatter | CP-A2 | No edit of existing documents |
| 3 | ProductOwner | Validate path exists | Target `learning_base/` path | Path validation result | CP-A3 | No path creation outside learning_base |
| 4 (conditional) | Worker | Convert binary to markdown | Binary file (docx, eml, PDF) | Markdown file | — | No internet access, no code execution |

---

## Workflow B: Stakeholder Feedback — Detailed Routing

```
[PO/Stakeholder] "Process feedback from [name]"
    │
    ▼
PM Entry Gate (keyword match: "process feedback" | "create VoC" | "extract insights")
    │
    ▼
ProductOwner (stakeholder-feedback skill)
    │
    ▼ CP-B1: Feedback captured?
    ├─ PASS → ProductOwner: map to guardrails
    └─ FAIL → PM: request more detail from stakeholder
    │
    ▼ CP-B2: Guardrail mapping complete?
    ├─ PASS → ProductOwner: extract actionable insights
    └─ FAIL (unclear guardrail) → [Optional] BusinessAnalyst: clarify requirement boundaries
    │
    ▼ CP-B3: Actionable insights extracted?
    ├─ PASS + cascade needed → PM triggers Workflow C
    ├─ PASS + no cascade → SUCCESS: VoC record filed
    └─ FAIL → ProductOwner: rework insight extraction
    │
    ▼
SUCCESS: VoC record in learning_base/11_voice_of_customer/
```

| Step | Agent | Skill/Action | Expected Input | Expected Output | Next Checkpoint | Disallowed Actions |
| --- | --- | --- | --- | --- | --- | --- |
| 1 | ProductOwner | `stakeholder-feedback` — capture feedback | Stakeholder raw input (email, chat, notes) | Structured feedback record | CP-B1 | No architectural decisions |
| 2 | ProductOwner | Map to guardrails | Structured feedback + guardrail catalog | Guardrail mapping table | CP-B2 | No requirement changes without BA review |
| 3 | ProductOwner | Extract insights | Guardrail-mapped feedback | Actionable insight list | CP-B3 | No direct cascade updates |
| 4 (conditional) | BusinessAnalyst | Clarify requirement boundaries | Ambiguous guardrail item | Clarified requirement constraint | — | No stakeholder communication |

---

## Workflow C: Requirements Cascade — Detailed Routing

```
[PO/BA] "Run cascade review" / "Update dependent docs"
    │
    ▼
PM Entry Gate (keyword match: "run cascade review" | "check what's impacted" | "update dependent docs" | "verify requirements alignment")
    │
    ▼
ProductOwner (trigger + initial scope)
    │
    ▼
BusinessAnalyst (requirements-cascade + deep-research skills)
    │
    ▼ CP-C1: Impacted docs identified?
    ├─ PASS → BA: update requirements documents
    └─ FAIL → BA: expand dependency search
    │
    ▼ CP-C2: Requirements updated?
    ├─ PASS → [FrontendDev or BackendDev: architecture review if technical impact]
    └─ FAIL → BA: rework requirement update
    │
    ▼ CP-C3: Secondary impact check complete?
    ├─ PASS + no stakeholder approval needed → SUCCESS
    └─ PASS + stakeholder approval needed → CP-C4
    │
    ▼ CP-C4: Stakeholder approval required?
    ├─ APPROVED → SUCCESS: cascade complete
    └─ REWORK → BA: revise based on stakeholder feedback
    └─ FAIL (architecture conflict) → PM ESCALATE: scope decision required
    │
    ▼
SUCCESS: Requirements updated, dependent docs linked.
```

**Conditional Branch**: If requirements update fails architecture check (BackendDev review at CP-C3), PM offers:
- Rework requirements (re-route to BA)
- Accept architectural constraint and scope-limit the change (PM + PO decide)
- Escalate to human for architecture decision

| Step | Agent | Skill/Action | Expected Input | Expected Output | Next Checkpoint | Disallowed Actions |
| --- | --- | --- | --- | --- | --- | --- |
| 1 | ProductOwner | Trigger cascade, define scope | Requirement change description | Scope statement, affected doc list | CP-C1 | No direct document edits |
| 2 | BusinessAnalyst | `requirements-cascade` — impact analysis | Scope statement | Impacted document list with change type | CP-C1 | No stakeholder communication |
| 3 | BusinessAnalyst | Update requirements docs | Impacted doc list | Updated `learning_base/02_requirements/` docs | CP-C2 | No architecture decisions |
| 4 (conditional) | BackendDev | Architecture review | Updated requirements | Architecture compatibility verdict | CP-C3 | No write access; read-only advisory |
| 5 (conditional) | FrontendDev | UI/UX feasibility review | Updated requirements | Frontend compatibility verdict | CP-C3 | No write access; read-only advisory |

---

## Workflow D: Diagram Lifecycle — Detailed Routing

```
[PO/UIUX] "Create diagram for [feature]" / "Publish diagram"
    │
    ▼
PM Entry Gate (keyword match: "create diagram" | "update diagram" | "publish diagram" | "render mermaid")
    │
    ▼
UIUXDesigner (diagram-generation skill)
    │
    ▼ CP-D1: Diagram design complete?
    ├─ PASS → UIUXDesigner: save source file (.mmd or .drawio)
    └─ FAIL → UIUXDesigner: revise design
    │
    ▼ CP-D2: Source file saved?
    ├─ PASS → UIUXDesigner: render image
    └─ FAIL → UIUXDesigner: save source before proceeding
    │
    ▼ CP-D3: Rendered image generated?
    ├─ PASS → UIUXDesigner: link in documentation
    └─ FAIL (render error) → UIUXDesigner: correct source; if format unsupported → PM escalate
    │
    ▼ CP-D4: Linked in documentation?
    ├─ PASS → PM: trigger manifest update; SUCCESS
    └─ FAIL → UIUXDesigner: add documentation link
    │
    ▼
SUCCESS: Diagram published, manifest updated.
```

| Step | Agent | Skill/Action | Expected Input | Expected Output | Next Checkpoint | Disallowed Actions |
| --- | --- | --- | --- | --- | --- | --- |
| 1 | UIUXDesigner | `diagram-generation` — design | Feature description or update request | Diagram draft (Mermaid syntax or .drawio) | CP-D1 | No code edits, no requirement changes |
| 2 | UIUXDesigner | Save source file | Diagram draft | `.mmd` or `.drawio` file in `images/diagrams/` | CP-D2 | No write outside `images/` or `learning_base/03_architecture/diagrams/` |
| 3 | UIUXDesigner | Render image | Source file | `.png` or `.svg` rendered image | CP-D3 | No external tool invocation |
| 4 | UIUXDesigner | Link in documentation | Rendered image path | Documentation link updated | CP-D4 | No write outside diagram-relevant docs |

---

## Workflow E: Backlog Planning — Detailed Routing

```
[PO/SM/User] "Plan sprint" / "Groom backlog"
    │
    ▼
PM Entry Gate (keyword match: "groom backlog" | "plan sprint" | "prioritize items" | "sprint planning" | "assign phase")
    │
    ▼
ProductOwner (backlog-management skill)
    │
    ▼ CP-E1: Backlog prioritized (MoSCoW)?
    ├─ PASS → PO: align items to phases
    └─ FAIL → PO: rework prioritization with stakeholder input
    │
    ▼ CP-E2: Items phase-aligned?
    ├─ PASS → ScrumMaster (breakdown-plan skill)
    └─ FAIL (undefined requirements) → [BA: requirement clarification (Workflow C)]
    │
    ▼ ScrumMaster: breakdown + estimate + dependencies
    │
    ▼ CP-E3: Sprint plan created?
    ├─ PASS → SM: capacity check
    └─ FAIL → SM: rework sprint plan
    │
    ▼ CP-E4: Capacity check passed?
    ├─ PASS → SUCCESS: publish sprint plan
    └─ FAIL → PO: re-prioritize or defer items; return to CP-E1
    │
    ▼
SUCCESS: docs/ways-of-work/sprint_NN.md published.
```

**Conditional Branch (capacity exceeded)**: "If backlog items exceed capacity, ProductOwner re-prioritizes (defer Must-Have → Should-Have) OR ScrumMaster splits story, OR PM escalates if phase targets are impacted."

| Step | Agent | Skill/Action | Expected Input | Expected Output | Next Checkpoint | Disallowed Actions |
| --- | --- | --- | --- | --- | --- | --- |
| 1 | ProductOwner | `backlog-management` — MoSCoW prioritize | Backlog item list | Prioritized backlog with MoSCoW tags | CP-E1 | No sprint creation directly |
| 2 | ProductOwner | Phase-align items | Prioritized backlog | Phase-tagged backlog | CP-E2 | No architecture decisions |
| 3 | ScrumMaster | `breakdown-plan` — estimate + dependencies | Phase-aligned backlog | Story breakdown with effort estimates | CP-E3 | No backlog re-prioritization |
| 4 | ScrumMaster | Capacity check | Story breakdown | Capacity validation result | CP-E4 | No item deletion from backlog |

---

## Workflow F: Quality Gate Review Loop — Detailed Routing

```
[QA/PO] "Run test" / "Quality gate"
    │
    ▼
PM Entry Gate (keyword match: "run test" | "execute test suite" | "QA review" | "quality gate" | "test pass/fail decision")
    │
    ▼
QAEngineer (quality-gate-review skill)
    │
    ▼ CP-F1: Test suite executed?
    ├─ PASS → QA: review results
    └─ FAIL (execution error) → PM: check environment; QA retry or escalate
    │
    ▼ CP-F2: Test results reviewed?
    ├─ PASS → QA: evaluate all tests pass?
    └─ FAIL → QA: complete result review
    │
    ▼ CP-F3: All tests pass?
    ├─ PASS → QA: verify acceptance criteria
    └─ FAIL + non-blocker → QA: create rework task; route to developer
    └─ FAIL + blocker → PM ESCALATE: Fix / Skip / Defer decision
    │
    ▼ CP-F4: Acceptance criteria met?
    ├─ PASS → SUCCESS: sprint item "Done"
    └─ FAIL → PM: acceptance criteria review; may trigger Workflow C for requirement revision
    │
    ▼
SUCCESS: Sprint item status "Done". Artifact published to learning_base/07_testing/.
```

**Conditional Branch (QA blocker)**: "If QA pass, mark sprint item 'Done'. If QA fail + blocker, PM presents: (A) Fix requirement (→ Workflow C), (B) Skip feature (PO defers to backlog), (C) Defer phase (escalate to human)."

| Step | Agent | Skill/Action | Expected Input | Expected Output | Next Checkpoint | Disallowed Actions |
| --- | --- | --- | --- | --- | --- | --- |
| 1 | QAEngineer | `quality-gate-review` — execute test suite | Test plan, sprint item | Test execution results | CP-F1 | No code edits, no requirement changes |
| 2 | QAEngineer | Review results | Test results | Pass/fail summary | CP-F2 | No direct sprint status updates |
| 3 | QAEngineer | Pass/fail decision | Pass/fail summary | Decision + blocker classification | CP-F3 | No architecture decisions |
| 4 (conditional) | FrontendDev or BackendDev | Technical failure analysis | Failing test details | Root cause advisory | — | No write access; read-only advisory |
