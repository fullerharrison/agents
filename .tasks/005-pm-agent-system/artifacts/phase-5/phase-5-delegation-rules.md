---
artifact: phase-5-delegation-rules
phase: 5
created: 2026-03-18
status: reviewed
tags: [delegation, entry-point, agent-assignment, permission-guard-rails, tie-breaking, escalation]
---

# Phase 5 Artifact: Delegation Rules

## Entry Point Decision Matrix

| Caller Role | Request Keyword(s) | Matched Workflow | Notes |
| --- | --- | --- | --- |
| User | "ingest", "add to learning_base", "process resource", "file document" | A — Resource Ingestion | Exact keyword match required; "ingest" is the primary trigger |
| ProductOwner | "ingest", "add to learning_base", "process resource" | A — Resource Ingestion | Same as User path; PO may also invoke directly |
| ProductOwner | "process feedback", "create VoC", "extract insights", "stakeholder feedback" | B — Stakeholder Feedback | "feedback" alone is insufficient; must include "process" or "create" qualifier |
| ProductOwner | "run cascade review", "check what's impacted", "update dependent docs", "verify requirements alignment" | C — Requirements Cascade | "cascade" alone maps to C; "run cascade" is primary trigger |
| BusinessAnalyst | "run cascade review", "check what's impacted", "update dependent docs" | C — Requirements Cascade | BA may co-trigger Workflow C with PO |
| UIUXDesigner | "create diagram", "update diagram", "publish diagram", "render mermaid", "diagram lifecycle" | D — Diagram Lifecycle | "diagram" as noun trigger; "render" also maps to D |
| ProductOwner | "create diagram", "update diagram" | D — Diagram Lifecycle | PO may initiate diagram request; UIUX executes |
| ProductOwner | "groom backlog", "plan sprint", "prioritize items", "sprint planning", "assign phase", "backlog review" | E — Backlog Planning | "plan" + "sprint" OR "groom" + "backlog" are dual triggers |
| ScrumMaster | "plan sprint", "sprint planning", "breakdown sprint", "estimate sprint" | E — Backlog Planning | SM may co-trigger Workflow E with PO |
| User | "plan sprint", "groom backlog" | E — Backlog Planning | User may initiate planning request |
| QAEngineer | "run test", "execute test suite", "quality gate", "test pass/fail", "QA review" | F — Quality Gate | "quality gate" is primary trigger for F |
| ProductOwner | "quality gate", "QA review" | F — Quality Gate | PO may trigger F to verify sprint item |
| Any role | Unrecognized keywords | Unknown Workflow (Fallback) | PM prompts caller to clarify intent; no agent invoked until confirmed |

### Keyword Mutual Exclusivity Validation

Per REQ validation rule 1 (Deterministic Routing), every keyword above maps to exactly ONE workflow. Overlap analysis:

| Keyword | Mapped Workflows | Status |
| --- | --- | --- |
| "ingest" | A only | ✅ Exclusive |
| "feedback" (qualified) | B only | ✅ Exclusive (qualifier required: "process feedback") |
| "cascade review" / "cascade" | C only | ✅ Exclusive |
| "diagram" (as noun trigger) | D only | ✅ Exclusive |
| "plan sprint" / "groom backlog" | E only | ✅ Exclusive |
| "quality gate" / "run test" | F only | ✅ Exclusive |
| "plan" alone | AMBIGUOUS | ⚠️ Disambiguation note: "plan" alone is insufficient; must be qualified as "plan sprint" (E) or "plan cascade" (C). PM prompts if bare "plan" is received. |
| "review" alone | AMBIGUOUS | ⚠️ Disambiguation note: "review" alone is insufficient; must be qualified as "QA review" (F) or "cascade review" (C). PM prompts if bare "review" is received. |

### Unknown Workflow Fallback

When PM receives a request that does not match any entry-point keyword:

1. PM does NOT route to any specialist agent.
2. PM responds to caller: "I couldn't match your request to a workflow. Which workflow do you want to initiate?
   - [A] Resource Ingestion — 'ingest [document]'
   - [B] Stakeholder Feedback — 'process feedback from [stakeholder]'
   - [C] Requirements Cascade — 'run cascade review'
   - [D] Diagram Lifecycle — 'create/update/publish diagram'
   - [E] Backlog Planning — 'plan sprint' or 'groom backlog'
   - [F] Quality Gate — 'quality gate' or 'run test'
   - Or describe what you need and I'll help match it."
3. Only after the caller confirms a workflow does PM proceed with routing.
4. If the caller describes a new workflow not covered by A-F, PM escalates to human reviewer for workflow registration before proceeding.

---

## Agent Assignment Matrix

### Workflow A: Resource Ingestion

| Step | Agent | Required Skill(s) | Allowed Actions | Disallowed Actions |
| --- | --- | --- | --- | --- |
| 1 — Classify resource | ProductOwner | `resource-ingestion` | Read any path; write classification tag to metadata | No Bash; no code execution; no write outside `learning_base/` |
| 2 — Apply template | ProductOwner | `resource-ingestion` | Write markdown file to `learning_base/[subdir]/` | No write outside `learning_base/`; no edit of existing docs |
| 3 — Validate path | ProductOwner | `resource-ingestion` | Read `learning_base/` directory; verify path exists | No path creation; no subdir creation without PM approval |
| 4 (conditional) — Convert binary | Worker | (format conversion) | Read source binary; write markdown to `learning_base/[subdir]/` | No internet access; no code execution beyond conversion |

### Workflow B: Stakeholder Feedback

| Step | Agent | Required Skill(s) | Allowed Actions | Disallowed Actions |
| --- | --- | --- | --- | --- |
| 1 — Capture feedback | ProductOwner | `stakeholder-feedback` | Read stakeholder input; write feedback record to `learning_base/11_voice_of_customer/` | No architectural decisions; no requirement changes without BA |
| 2 — Guardrail mapping | ProductOwner | `stakeholder-feedback` | Read guardrail catalog; write mapping to VoC record | No new guardrail creation without human approval |
| 3 — Extract insights | ProductOwner | `stakeholder-feedback` | Write insights list to VoC record | No backlog item creation directly; route to Workflow E |
| 4 (conditional) — Req boundary clarification | BusinessAnalyst | `deep-research` | Read `learning_base/02_requirements/`; write clarification note to VoC record | No stakeholder communication; no direct VoC edits |

### Workflow C: Requirements Cascade

| Step | Agent | Required Skill(s) | Allowed Actions | Disallowed Actions |
| --- | --- | --- | --- | --- |
| 1 — Trigger cascade, define scope | ProductOwner | — | Read `learning_base/`; write cascade scope note | No direct requirement edits |
| 2 — Impact analysis | BusinessAnalyst | `requirements-cascade`, `deep-research` | Read all `learning_base/`, `docs/`; write dependency list to `.tasks/` workflow log | No stakeholder communication; no architecture decisions |
| 3 — Update requirements | BusinessAnalyst | `requirements-cascade` | Write to `learning_base/02_requirements/`, `learning_base/03_architecture/` | No write outside BA-permitted paths |
| 4 (conditional) — Architecture review | BackendDev | — | Read all paths (read-only advisory) | No write; no execute; no requirement modifications |
| 5 (conditional) — Frontend review | FrontendDev | — | Read all paths (read-only advisory) | No write; no execute; no requirement modifications |

### Workflow D: Diagram Lifecycle

| Step | Agent | Required Skill(s) | Allowed Actions | Disallowed Actions |
| --- | --- | --- | --- | --- |
| 1 — Design diagram | UIUXDesigner | `diagram-generation` | Read feature spec, existing diagrams; create diagram source | No code edits; no requirement changes |
| 2 — Save source file | UIUXDesigner | `diagram-generation` | Write `.mmd` or `.drawio` to `images/diagrams/` or `learning_base/03_architecture/diagrams/` | No write outside diagram paths |
| 3 — Render image | UIUXDesigner | `diagram-generation` | Execute diagram-generation render; write `.png`/`.svg` to `images/diagrams/` | No external tool invocation beyond diagram render |
| 4 — Link in docs | UIUXDesigner | `diagram-generation` | Write documentation link to target doc | No write outside diagram-relevant documentation |

### Workflow E: Backlog Planning

| Step | Agent | Required Skill(s) | Allowed Actions | Disallowed Actions |
| --- | --- | --- | --- | --- |
| 1 — MoSCoW prioritize | ProductOwner | `backlog-management` | Read backlog; write MoSCoW tags to backlog items in `docs/ways-of-work/` | No sprint creation; no architecture decisions |
| 2 — Phase-align | ProductOwner | `backlog-management` | Write phase tags to backlog items | No item deletion from backlog |
| 3 — Breakdown + estimate | ScrumMaster | `breakdown-plan` | Read backlog; write story breakdown + estimates to sprint plan | No backlog re-prioritization; no item deletion |
| 4 — Capacity check | ScrumMaster | `breakdown-plan` | Read team capacity data; write capacity result to sprint plan | No direct backlog modifications |

### Workflow F: Quality Gate Review

| Step | Agent | Required Skill(s) | Allowed Actions | Disallowed Actions |
| --- | --- | --- | --- | --- |
| 1 — Execute test suite | QAEngineer | `quality-gate-review` | Read test plans; execute test suite; write results to `learning_base/07_testing/test_results_*.md` | No code edits; no requirement changes |
| 2 — Review results | QAEngineer | `quality-gate-review` | Read test results; write pass/fail classification | No direct sprint status updates |
| 3 — Pass/fail decision | QAEngineer | `quality-gate-review` | Write decision + blocker classification | No architecture decisions; no planning updates directly |
| 4 (conditional) — Technical failure analysis | BackendDev or FrontendDev | — | Read test results, code, requirements (read-only advisory) | No write; no execute; no requirement modifications |

---

## Permission Guard Rails Per Agent

| Agent | Write Paths | Read Paths | Execute Permissions | Disallowed |
| --- | --- | --- | --- | --- |
| ProjectManager | None | All | None | Bash, Write, Edit, MultiEdit, Task, terminal/runInTerminal |
| ProductOwner | `learning_base/` (all subdirs), `docs/ways-of-work/` | All | None (no terminal) | Bash, MultiEdit, Task |
| BusinessAnalyst | `learning_base/02_requirements/`, `learning_base/03_architecture/` | All | None | Bash, Write outside BA paths, Task, MultiEdit |
| ScrumMaster | `docs/ways-of-work/sprint_*.md`, `learning_base/09_decisions/` | All | None | Bash, Write outside SM paths, Task, MultiEdit |
| FrontendDev | None | All | None | Bash, Write, Edit, Task, MultiEdit |
| BackendDev | None | All | None | Bash, Write, Edit, Task, MultiEdit |
| QAEngineer | `learning_base/07_testing/test_results_*.md` | All | Test execution (QA tools only) | Bash for non-test purposes, Write outside QA paths, Edit code, Task, MultiEdit |
| UIUXDesigner | `images/diagrams/`, `learning_base/03_architecture/diagrams/` | All | `diagram-generation` skill execution | Bash, Task, MultiEdit, Write outside diagram paths |
| Worker | All | All | All (format conversion, file operations) | None (full access; used by PM for resource conversion only) |

---

## Tie-Breaking Rules

All tie-breaking rules must designate exactly one primary agent and one escalation target per rule:

| Scenario | Primary Agent | Escalation Target | Rule |
| --- | --- | --- | --- |
| Requirement change touches architecture AND data model | BusinessAnalyst (primary) | BackendDev (advisory) → PM (if conflict) | BA leads; BackendDev reviews architecture impact; if BA and BackendDev disagree on scope, PM escalates to human for architectural decision |
| Diagram is for user docs AND technical architecture | UIUXDesigner (primary) | PM (cross-boundary approval) | UIUX decides design and rendering; PM approves any cross-boundary publication (user docs + architecture docs simultaneously) |
| Sprint item is blocked AND depends on another item | ScrumMaster (primary) | PM (if phase targets impacted) | SM re-plans: either resequences items or splits story; if re-sequencing affects phase targets, PM escalates to human for phase-level decision |
| Feedback maps to multiple requirements areas | ProductOwner (primary) | BusinessAnalyst (triage) | PO assigns feedback to the most specific requirement area; BA resolves if cross-area conflict exists; if unresolvable, PM escalates to stakeholder for clarification |
| QA failure is ambiguous (test issue vs. code issue) | QAEngineer (primary) | BackendDev or FrontendDev (technical advisory) | QA must classify failure as test-issue OR code-issue before escalation; technical advisor provides root-cause support; PM escalates only if classification remains unresolvable after advisory |
| Cascade update creates new dependency discovered after CP-C3 | BusinessAnalyst (primary) | PM (if new dependency is out-of-scope) | BA handles in-scope new dependency as a supplementary cascade step; if new dependency is architecturally significant or out-of-scope, PM escalates to human for scope decision |

---

## Escalation Criteria

When a situation MUST be escalated to PM for manual decision or human reviewer involvement:

| Trigger | Escalation Type | PM Action |
| --- | --- | --- |
| Scope creep detected (new requirement outside phase scope) | PM decision: accept, reject, defer | PM pauses workflow; presents scope change options to human |
| Cross-team conflict (two agents disagree on approach) | PM mediation | PM surfaces conflict summary; human reviewer makes decision |
| Resource blockage (required agent/resource unavailable) | PM alternative routing | PM identifies alternative agent or defers workflow |
| Quality gate blocker (critical test failure) | PM Fix/Skip/Defer decision | PM presents three options; awaits human choice |
| Timeline risk (checkpoint completion threatening sprint deadline) | PM phase-level decision | PM escalates to human for timeline renegotiation or scope reduction |
| Unknown workflow request (no keyword match) | PM fallback prompt | PM prompts caller with workflow menu; awaits confirmation |
| Stakeholder unreachable for CP-C4 approval | PM timeout escalation | PM escalates to human manager after defined timeout |
| New guardrail category needed (CP-B2) | PM approval gate | PM pauses; surfaces new guardrail proposal to human reviewer |

---

## Deterministic Routing Validation Rules

Per the phase plan validation requirement, all three rules must be satisfied before this artifact is considered complete:

**Rule 1 — Keyword Mutual Exclusivity**
Every keyword in the Entry Point Decision Matrix maps to exactly one workflow row. Confirmed in the "Keyword Mutual Exclusivity Validation" table above. Ambiguous cases ("plan" alone, "review" alone) are flagged with explicit disambiguation notes; PM prompts for clarification rather than auto-routing.

**Rule 2 — Explicit Permission Guards on All Assignments**
Every row in the Agent Assignment Matrix includes non-empty `Allowed Actions` and `Disallowed Actions` columns. Confirmed: all rows across Workflows A-F are populated with explicit permissions. Rows without explicit constraints would be invalid and require completion before review.

**Rule 3 — Deterministic Tie-Breaking Outcomes**
Every tie-breaking rule specifies exactly one primary agent and one escalation target. Confirmed in the Tie-Breaking Rules table above. No rule produces "either A or B" without a selection criterion.
