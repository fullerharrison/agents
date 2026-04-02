---
goal: Phase 6 - Access and Permission Governance
phase: 6
date_created: 2026-03-18
last_updated: 2026-03-18
owner: Explorer
status: Planned
tags: [planning, permissions, governance, access-control, enforcement, tooling-boundary, consistency-check]
---

# Phase 6 Plan: Access and Permission Governance

## Goal

Publish and enforce per-agent read/write/execute boundaries across all nine agents in the PM agent system, producing a complete permission tier table, explicit tooling boundary matrix (Copilot and CC frontmatter per agent), enforcement mechanism specifications, validation rules for detecting permission drift, and a cross-agent consistency check that confirms no two agents have contradictory or overlapping authority profiles.

---

## Scope

- In scope:
  - Permission tier table covering all nine agents: ProjectManager, ProductOwner, BusinessAnalyst, ScrumMaster, FrontendDev, BackendDev, QAEngineer, UIUXDesigner, Worker.
  - Six permission tier definitions (Tier O, Tier R, Tier RE, Tier RW-D, Tier W, Tier F) with canonical properties: read scope, write scope, execute scope, and delegation authority.
  - Tooling boundary matrix: explicit Copilot `tools:` list and `disallowedTools:` list per agent per tier, derived from the `agents-personal` framework source (Section 11.2, agent template frontmatter stubs from Phases 3–5).
  - CC-equivalent tool boundary mapping per agent tier (cc: block forbidden/allowed tool categories).
  - Enforcement mechanism specification covering three enforcement layers: template-level (frontmatter), generation-time (generate.js validation), and runtime (checkpoint gates + orchestration routing).
  - Write-path partition table: for all Tier W agents (ProductOwner, BusinessAnalyst, ScrumMaster), explicit non-overlapping write path assignments with conflict resolution rules.
  - Execute-scope boundary: QAEngineer test-only execute vs UIUXDesigner render-only execute — precise permitted command list and explicit excluded command list.
  - Cross-agent permission consistency check matrix: six property axes (read scope, write scope, execute scope, disallowedTools completeness, escalation path, tool-tier alignment) × nine agents, with PASS/FAIL verdict per cell.
  - Drift detection checklist: verifiable conditions that indicate a template has drifted from its declared tier, with detection method per condition.
  - Permission governance review gate: checklist of evidence required before Builder generates any agent template, enforcing the governance layer as a mandatory pre-condition.
  - Source traceability matrix linking every governance rule to its originating source (agents-personal framework, VIP plan Section 8, Phases 3–5 decisions).
  - README/docs alignment check: confirms that `agents-personal` README agent table and any agents-personal `docs/` references are consistent with the governance matrix defined here (no write to agents-personal docs — read-only alignment verification only).
  - Creation of all Phase 6 artifacts under `.tasks/005-pm-agent-system/artifacts/phase-6/`.
  - Update of `task.md` Phase 6 row to `📋 Planned`.

- Out of scope:
  - Creating or editing any template file in `C:/Users/s1058662/repos/agents-personal/`.
  - Running `make`, `install.sh`, `generate.js`, or any template-generation workflow.
  - Modifying any file outside `.tasks/005-pm-agent-system/` in `2026_01_VIP` or `agents-personal`.
  - Defining Phase 7 workflow contracts (separate phase).
  - Defining Phase 8 pilot validation tests (separate phase).
  - Changing permission tier assignments decided in Phases 3–5 unless contradictions are discovered during the cross-agent consistency check.

---

## Checkpoints (Plan-Only Governance)

| Checkpoint | Owner | Required Evidence | Decision Options |
| --- | --- | --- | --- |
| CP-6.1 Permission Tier Definitions | Explorer | Six-tier definition table at `.tasks/005-pm-agent-system/artifacts/phase-6/phase-6-permission-tier-definitions.md` with: tier name, tier code, read scope, write scope, execute scope, delegation authority, and canonical disallowedTools list per tier | Proceed, Rework, Defer |
| CP-6.2 Nine-Agent Permission Tier Table | Reviewer (human) | Agent permission tier table artifact at `.tasks/005-pm-agent-system/artifacts/phase-6/phase-6-agent-permission-tier-table.md` covering all nine agents with: tier code, read paths, write paths (or "None"), execute authority (or "None"), disallowedTools exact list (Copilot), and agent status (new/existing) — consistent with Phases 3–5 and Section 8 of source plan | Approve, Request Changes |
| CP-6.3 Tooling Boundary Matrix | Reviewer (human) | Tooling boundary matrix artifact at `.tasks/005-pm-agent-system/artifacts/phase-6/phase-6-tooling-boundary-matrix.md` with explicit Copilot `tools:` list, Copilot `disallowedTools:` list, and CC tool category grants/denials per agent (nine agents × two platforms) — all tool names consistent with agents-personal Section 11.2 source table | Approve, Request Changes |
| CP-6.4 Write-Path Partition Table | Reviewer (human) | Write-path partition table confirming non-overlapping write assertions for ProductOwner (`learning_base/`, `docs/`), BusinessAnalyst (`docs/`, `learning_base/`, `specs/`), ScrumMaster (`docs/ways-of-work/`), and UIUXDesigner (`diagrams/`, `images/diagrams/`, `docs/` diagram-adjacent only) — with the following explicit, pre-selected conflict resolution strategy for `docs/` overlap: **Step 1 — sub-path partition by content type** (PO owns VoC/intake artifacts; BA owns requirements/ADRs/specs; SM owns sprint/ways-of-work; UIUXDesigner owns diagram image references only); **Step 2 — caller-workflow context as tie-breaker** when content type alone is ambiguous. No open choice between "sub-path partition OR priority-of-caller" remains; both mechanisms apply in sequence. Worker (Tier F) writes to Tier W–owned paths only when mechanically executing on behalf of an invoking Tier W agent or ProjectManager, with the invoking agent retaining authorship and content accountability. | Approve, Request Changes |
| CP-6.5 Execute-Scope Boundary | Reviewer (human) | Execute-scope boundary document at `.tasks/005-pm-agent-system/artifacts/phase-6/phase-6-execute-scope-boundary.md` specifying: (a) QAEngineer: permitted test commands list, prohibited command list; (b) UIUXDesigner: permitted render command (mmdc), prohibited command list; (c) Worker: full execute authority with no explicit restriction (mechanical conversion use case only) | Approve, Request Changes |
| CP-6.6 Enforcement Mechanism Specification | Reviewer (human) | Enforcement mechanism document at `.tasks/005-pm-agent-system/artifacts/phase-6/phase-6-enforcement-mechanisms.md` covering three layers: (1) template-level — how `disallowedTools` in frontmatter prevents tool calls; (2) generation-time — how `generate.js` enforces required frontmatter fields; (3) runtime — how ProjectManager checkpoint routing blocks out-of-permission actions. Each layer must include: trigger condition, enforcement action, failure mode, and recovery path | Approve, Request Changes |
| CP-6.7 Cross-Agent Permission Consistency Check Matrix | Reviewer (human) | Cross-agent consistency check matrix artifact at `.tasks/005-pm-agent-system/artifacts/phase-6/phase-6-cross-agent-consistency-check.md` with: nine agent rows × six check axes (read scope, write scope, execute scope, disallowedTools completeness, escalation path present, tool-tier alignment), individual PASS/FAIL verdict per cell, summary verdict per agent, and blocking issues list (any FAIL cells that must be resolved before Builder execution) | Approve, Request Changes |
| CP-6.8 Drift Detection Checklist | Reviewer (human) | Drift detection checklist at `.tasks/005-pm-agent-system/artifacts/phase-6/phase-6-drift-detection-checklist.md` enumerating minimum twelve conditions (six tiers × two conditions each = 12; minimum two independently verifiable conditions per tier — traceable floor per REQ-612), detection method (e.g., grep for prohibited tool name in frontmatter, manual review of write path list), responsible party (Builder post-generation, human reviewer pre-deploy), and remediation action per condition | Approve, Request Changes |
| CP-6.9 README and Docs Alignment Check | Reviewer (human) | Alignment check evidence confirming: (a) agents-personal README agent table (existing) is consistent with final nine-agent tier table from CP-6.2; (b) no agents-personal docs files were modified by this phase; (c) if a discrepancy is found between agents-personal docs and this governance matrix, a resolution recommendation is documented (but not applied — Builder applies it) | Approve, Request Changes |
| CP-6.10 Source Alignment and Plan-Only Boundary Check | Explorer + Reviewer | Source traceability matrix at `.tasks/005-pm-agent-system/artifacts/phase-6/phase-6-source-traceability-matrix.md` with minimum columns: `governance rule`, `source doc`, `source clause`, `phase-where-established`, `implementation note`. All Phase 6 file create/update targets verified as `.tasks/005-pm-agent-system/**` only. Coverage: Section 8 (Agent Access Summary), Section 11.2 (Tool Permission Patterns), Phase 3 (Tier R/RE/RW-D), Phase 4 (Tier W), Phase 5 (Tier O). | Approve, Request Changes, Defer |

---

## Status Governance (Plan-Only Mode)

- `📋 Planned` is set when this phase plan is created and linked from `task.md`.
- `⭐ Reviewed` is set by the reviewer after CP-6.2, CP-6.3, CP-6.6, and CP-6.7 evidence is accepted.
- `✅ Done` is reserved for Builder execution plus verification evidence; Explorer does not set this for unexecuted implementation work.

---

## Requirements and Constraints

- REQ-601: Define exactly six permission tiers covering all nine agents with non-overlapping authority profiles:
  - **Tier O** (Orchestration-Only): ProjectManager only.
  - **Tier R** (Read-Only): FrontendDev, BackendDev.
  - **Tier RE** (Read + Execute): QAEngineer only.
  - **Tier RW-D** (Read + Write Diagrams): UIUXDesigner only.
  - **Tier W** (Read + Write, No Execute): ProductOwner, BusinessAnalyst, ScrumMaster.
  - **Tier F** (Full Access): Worker only.
- REQ-602: The nine-agent permission tier table must be consistent with the following prior-phase decisions:
  - Phase 3: FrontendDev and BackendDev → Tier R; QAEngineer → Tier RE; UIUXDesigner → Tier RW-D.
  - Phase 4: ProductOwner → Tier W; BusinessAnalyst (existing) → Tier W; ScrumMaster (existing) → Tier W.
  - Phase 5: ProjectManager → Tier O.
  - Source plan Section 8: Worker → Tier F (full access, Bash-enabled, mechanical conversion executor).
- REQ-603: Write-path partition for Tier W agents must be explicitly non-overlapping at the first path segment. Where apparent overlap exists (e.g. all three Tier W agents can write `docs/`), the conflict resolution strategy is explicitly pre-selected as follows: **Step 1 — sub-path partition by content type** (each agent owns a distinct content category within `docs/`: PO → VoC/intake artifacts; BA → requirements, ADRs, feature specs; SM → sprint plans and ways-of-work docs; UIUXDesigner → diagram image references only); **Step 2 — caller-workflow context as tie-breaker** for any remaining ambiguity after content-type partitioning. The "sub-path partition OR priority-of-caller" open question is closed: both mechanisms apply in sequence. This two-step strategy must be carried forward verbatim into the CP-6.4 artifact.
- REQ-604: `disallowedTools` lists must use the exact tool identifier strings from the `agents-personal` framework (as found in Section 11.2 and existing template frontmatter), not generic labels. Copilot and CC identifier namespaces are different and must be documented separately.
- REQ-605: Execute scope for QAEngineer must be limited to: `execute/runTests`, `execute/runInTerminal` (test scripts only), `execute/getTerminalOutput`, `execute/testFailure`, `execute/awaitTerminal`, `read/terminalLastCommand`, `read/terminalSelection`. QAEngineer must explicitly disallow all `edit/*` tools.
- REQ-606: Execute scope for UIUXDesigner must permit render script invocation (`mmdc` via `execute/runInTerminal`) and must explicitly exclude all non-render terminal operations. UIUXDesigner `disallowedTools` must not block `edit/*` tools because diagram write requires file creation.
- REQ-607: Tier O (ProjectManager) `disallowedTools` must explicitly name all six prohibited categories: `terminal/runInTerminal`, `Bash` (CC), `edit/createFile`, `edit/editFiles`, `edit/createDirectory`, `Task` (subagent spawning outside orchestration context). The `disable-model-invocation: true` flag is a separate concern from `disallowedTools` but must be included in the tooling boundary matrix.
- REQ-608: Enforcement mechanism Layer 1 (template-level) must define: what happens when a disallowed tool is invoked, whether the framework blocks silently or surfaces an error, and whether the agent can self-report its own constraint violations.
- REQ-609: Enforcement mechanism Layer 2 (generation-time) must reference `agents-personal/scripts/generate.js` and the `install.sh` validation list. Required frontmatter fields that are absent at generation time must cause a build failure.
- REQ-610: Enforcement mechanism Layer 3 (runtime checkpoint routing) must reference the ProjectManager orchestration routing matrix from Phase 5. The PM routing matrix serves as the operational enforcement layer — if an agent cannot perform an action (due to its tier), the PM must route to the correct agent rather than letting the restricted agent proceed.
- REQ-611: Cross-agent consistency check must verify that: (a) no Tier R or Tier O agent has any `edit/*` tool in its allowed list; (b) no Tier O or Tier W or Tier R or Tier RW-D agent has unrestricted Bash access; (c) every agent has exactly one escalation path defined; (d) ProjectManager is not listed as a downstream consumer in any escalation path (PM is the orchestrator, not a downstream specialist); (e) tool-tier alignment — each agent's actual allowed tools match the declared tier's canonical tool list.
- REQ-612: Drift detection checklist must include conditions for each tier: Tier O drift (agent starts accepting write/execute requests), Tier R drift (agent starts generating file outputs), Tier RE drift (agent modifies source files instead of only executing tests), Tier RW-D drift (agent writes outside diagram paths), Tier W drift (agent attempts Bash execution), Tier F drift (no inherent drift risk, but verify conversion-only use case is maintained). **Minimum floor: two independently verifiable conditions per tier × six tiers = twelve conditions total.** This formula is the traceable basis for CP-6.8's "minimum twelve" requirement. Builder must enumerate at least two distinct, separately detectable conditions per tier; a single broad condition restated twice does not satisfy the floor.
- REQ-613: README and docs alignment check must confirm: the agents-personal README lists the agent types; any existing documentation about agent permissions is consistent with the governance matrix; if inconsistencies are found, they are flagged with a resolution note (not silently overridden).
- REQ-614: All agents must have an explicit escalation path. For all non-PM agents: escalation path is always → ProjectManager. For ProjectManager: escalation path is → Human Reviewer. No agent may escalate directly to another specialist agent without PM routing.
- CON-601: This phase is planning-only; no production template files are created or edited.
- CON-602: All writes are restricted to `.tasks/005-pm-agent-system/**`.
- CON-603: Permission tier assignments established in Phases 3–5 must not be contradicted without explicit justification and explicit notation of which prior-phase decision is being superseded.
- CON-604: This phase must not modify or overwrite governance decisions from Phases 3–5 — Phase 6 consolidates and verifies, not redesigns.
- CON-605: Worker is an existing agent. Phase 6 documents its Tier F assignment and tooling boundary for completeness, but must not propose changes to the Worker template itself.
- GUD-601: Follow task-centric persistence conventions from ADR-002.
- GUD-602: Enforce orchestration constraints and subagent scope control from ADR-001.
- GUD-603: Maintain IDE compatibility rules from ADR-005 (Copilot vs CC tool identifier namespace differences must be respected).
- GUD-604: Include rationalization-prevention evidence expectations from ADR-007 in verification section.

---

## Source Guidelines to Incorporate (agents-personal)

Mandatory source set for Phase 6. All governance rule decisions must be traceable to at least one of these:

- `C:/Users/s1058662/repos/agents-personal/README.md` — overall framework conventions and agent listing.
- `C:/Users/s1058662/repos/agents-personal/templates/README.md` — agent template format, required frontmatter fields, `disallowedTools` convention.
- `C:/Users/s1058662/repos/agents-personal/templates/agents/conductor.template.md` — Tier O canonical source: `disable-model-invocation: true`, delegation-only tools, `disallowedTools` pattern for orchestration agents.
- `C:/Users/s1058662/repos/agents-personal/templates/agents/business-analyst.template.md` — Tier W canonical source: `edit/*` tools, no execute, write-enabled pattern.
- `C:/Users/s1058662/repos/agents-personal/templates/agents/scrum-master.template.md` — Tier W existing agent: write-restricted to `docs/ways-of-work/`.
- `C:/Users/s1058662/repos/agents-personal/templates/agents/worker.template.md` — Tier F canonical source: full tool access including Bash.
- `C:/Users/s1058662/repos/agents-personal/templates/agents/researcher.template.md` — Tier R canonical source: read-only tools, no edit, no execute.
- `C:/Users/s1058662/repos/agents-personal/docs/architecture/ADR-001-orchestration-and-subagents.md` — orchestration model, checkpoint enforcement, Entry Gate.
- `C:/Users/s1058662/repos/agents-personal/docs/architecture/ADR-002-task-centric-persistence.md` — persistent state model.
- `C:/Users/s1058662/repos/agents-personal/docs/architecture/ADR-005-ide-compatibility.md` — Copilot vs CC tool namespace differences.
- `C:/Users/s1058662/repos/agents-personal/docs/architecture/ADR-007-rationalization-prevention.md` — evidence-based verification.
- `VIP/learning_base/ideas/pm_agent_coordination_system_implementation_plan.md` Section 8 (Agent Access Summary), Section 11.2 (Tool Permission Patterns) — primary permission source for all nine agents.
- `.tasks/005-pm-agent-system/plan/phase-3-specialist-agent-templates.md` — Tier R/RE/RW-D tier definitions and disallowedTools established in REQ-303, REQ-304, REQ-305.
- `.tasks/005-pm-agent-system/plan/phase-4-productowner-existing-agent-integration.md` — Tier W definition for ProductOwner; REQ-410 (PO disallowedTools); REQ-402 (Tier W same as BA/SM).
- `.tasks/005-pm-agent-system/plan/phase-5-projectmanager-orchestration-layer.md` — Tier O definition for ProjectManager; REQ-501 (PM disallowedTools); REQ-509 (explicit PM disallowedTools list).

---

## Permission Tier Definitions (Research Baseline)

The following six tiers govern the entire PM agent system. Tier names and codes are canonical and must be used consistently across all templates, documentation, and governance artifacts.

### Tier O — Orchestration-Only

| Property | Value |
| --- | --- |
| Tier code | O |
| Agent(s) | ProjectManager |
| Read scope | `.tasks/`, `learning_base/` (constrained to task and context reading) |
| Write scope | None |
| Execute scope | None |
| Delegation authority | Full — may route to any agent in the system |
| Copilot allowed tools | `vscode/askQuestions`, `read/readFile`, `agent`, `search/fileSearch`, `search/listDirectory`, `todo` |
| Copilot disallowedTools | `terminal/runInTerminal`, `edit/createFile`, `edit/editFiles`, `edit/createDirectory`, `Task` |
| CC disallowedTools | `Bash`, `Write`, `Edit`, `MultiEdit`, `TodoWrite` (no state writes) |
| Special flags | `disable-model-invocation: true` |
| Escalation path | → Human Reviewer (PM is the terminal orchestration point) |

### Tier R — Read-Only (Advisory)

| Property | Value |
| --- | --- |
| Tier code | R |
| Agent(s) | FrontendDev, BackendDev |
| Read scope | All paths |
| Write scope | None |
| Execute scope | None |
| Delegation authority | None — outputs are advisory text only |
| Copilot allowed tools | `vscode/askQuestions`, `read/problems`, `read/readFile`, `agent`, `search`, `web`, `todo` |
| Copilot disallowedTools | `terminal/runInTerminal`, `edit/createFile`, `edit/editFiles`, `edit/createDirectory` |
| CC disallowedTools | `Bash`, `Write`, `Edit`, `MultiEdit` |
| Escalation path | → ProjectManager |

### Tier RE — Read + Execute (Test-Only)

| Property | Value |
| --- | --- |
| Tier code | RE |
| Agent(s) | QAEngineer |
| Read scope | All paths |
| Write scope | None |
| Execute scope | Test execution only: `runTests`, `runInTerminal` (test scripts only), `getTerminalOutput`, `testFailure`, `awaitTerminal`, `terminalLastCommand`, `terminalSelection` |
| Delegation authority | None — escalates findings but does not delegate work |
| Copilot allowed tools | `vscode/askQuestions`, `execute/testFailure`, `execute/getTerminalOutput`, `execute/awaitTerminal`, `execute/runInTerminal`, `execute/runTests`, `read/problems`, `read/readFile`, `read/terminalSelection`, `read/terminalLastCommand`, `agent`, `search`, `todo` |
| Copilot disallowedTools | `edit/createFile`, `edit/editFiles`, `edit/createDirectory` |
| CC disallowedTools | `Write`, `Edit`, `MultiEdit` |
| Escalation path | → ProjectManager |

### Tier RW-D — Read + Write Diagrams (Diagram-Scoped Write)

| Property | Value |
| --- | --- |
| Tier code | RW-D |
| Agent(s) | UIUXDesigner |
| Read scope | All paths |
| Write scope | `diagrams/`, `images/diagrams/`, `docs/` (diagram-adjacent only — `.mmd` sources, rendered `.png` files, and image references in markdown only) |
| Execute scope | Mermaid render only: `mmdc` via `execute/runInTerminal` |
| Delegation authority | None — escalates only |
| Copilot allowed tools | `vscode/askQuestions`, `read/problems`, `read/readFile`, `agent`, `edit/createDirectory`, `edit/createFile`, `edit/editFiles`, `execute/runInTerminal`, `execute/getTerminalOutput`, `search`, `web`, `todo` |
| Copilot disallowedTools | `terminal/runInTerminal` (non-mmdc Bash; enforced by template body constraint, not tool exclusion) |
| CC disallowedTools | `Bash` (general shell; `mmdc` render command only permitted) |
| Notes | Write restriction to diagram paths is enforced by template body instruction, not solely by frontmatter. Template must explicitly state: "Write only to `diagrams/`, `images/diagrams/`, and diagram-adjacent `docs/` references." |
| Escalation path | → ProjectManager |

### Tier W — Read + Write (No Execute)

| Property | Value |
| --- | --- |
| Tier code | W |
| Agent(s) | ProductOwner, BusinessAnalyst, ScrumMaster |
| Read scope | All paths |
| Write scope | Role-partitioned (see Write-Path Partition Table below) |
| Execute scope | None |
| Delegation authority | Handoff-only — each W-tier agent can invoke named downstream agents via handoff buttons |
| Copilot allowed tools | `vscode/askQuestions`, `read/problems`, `read/readFile`, `agent`, `edit/createDirectory`, `edit/createFile`, `edit/editFiles`, `search`, `web`, `todo` |
| Copilot disallowedTools | `terminal/runInTerminal` |
| CC disallowedTools | `Bash` |
| Escalation path | → ProjectManager |

### Tier F — Full Access

| Property | Value |
| --- | --- |
| Tier code | F |
| Agent(s) | Worker |
| Read scope | All paths |
| Write scope | All paths (constrained to conversion task context by template body) |
| Execute scope | All: Bash, `runInTerminal`, file conversion scripts |
| Delegation authority | None — Worker executes and returns output to caller |
| Copilot allowed tools | Full toolset including `execute/*` and `edit/*` |
| Copilot disallowedTools | None formally; template body constrains scope to conversion context |
| CC disallowedTools | None formally |
| Notes | Tier F is not a blank permission grant. Worker template body must define: "Only execute commands required for the requested conversion task." |
| Escalation path | → Caller agent (ProductOwner or ProjectManager) |

---

## Nine-Agent Permission Tier Table (Research Baseline)

The following table consolidates all nine agents with their tier assignment, prior-phase source, and brief permission summary.

| Agent | Tier | Code | Read Scope | Write Paths | Execute | Status | Phase Established |
| --- | --- | --- | --- | --- | --- | --- | --- |
| ProjectManager | Orchestration-Only | O | `.tasks/`, `learning_base/` | None | None | New | Phase 5 (REQ-501) |
| ProductOwner | Read + Write | W | All | `learning_base/`, `docs/` | None | New | Phase 4 (REQ-402) |
| BusinessAnalyst | Read + Write | W | All | `docs/`, `learning_base/`, `specs/` | None | Existing | Phase 4 (REQ-402) |
| ScrumMaster | Read + Write | W | All | `docs/ways-of-work/` | None | Existing | Phase 4 (REQ-402) |
| FrontendDev | Read-Only | R | All | None | None | New | Phase 3 (REQ-303) |
| BackendDev | Read-Only | R | All | None | None | New | Phase 3 (REQ-303) |
| QAEngineer | Read + Execute | RE | All | None | Test execution only | New | Phase 3 (REQ-303) |
| UIUXDesigner | Read + Write Diagrams | RW-D | All | `diagrams/`, `images/diagrams/`, `docs/` (diagram-adjacent) | mmdc render only | New | Phase 3 (REQ-303) |
| Worker | Full Access | F | All | All | All (conversion context) | Existing | Section 8, source plan |

---

## Write-Path Partition Table (Research Baseline)

The three Tier W agents all have write access to `docs/`. The following partition defines non-overlapping primary ownership by path. When multiple agents could write to the same path, the ownership rule or caller context determines which agent writes.

| Agent | Primary Write Paths | `docs/` Partition Rule | Conflict Resolution |
| --- | --- | --- | --- |
| ProductOwner | `learning_base/11_voice_of_customer/`, `learning_base/_inbox/`, `docs/` (VoC-derived summaries) | Writes VoC records and intake summaries into `docs/`. Does not write requirements, specs, or technical docs. | If PO and BA both need to write to `docs/requirements/`, BA writes. PO writes intake artifacts only. |
| BusinessAnalyst | `docs/`, `learning_base/02_requirements/`, `specs/` | Writes requirements documents, ADRs (`learning_base/09_decisions/`), feature specs. Does not write sprint plans or VoC records. | BA has broader `docs/` authority than PO. For direct conflicts, PM must route to BA for structured documentation. |
| ScrumMaster | `docs/ways-of-work/` | Writes sprint plans, task schemas, ways-of-work documentation only. Does not write to root `docs/` or `specs/`. | SM write scope is the narrowest of the three. No conflict with BA or PO for sprint artifacts. |
| UIUXDesigner | `diagrams/`, `images/diagrams/`, `docs/` (image references only) | Inserts `.png` image references into existing markdown files in `docs/` as part of Mermaid lifecycle. Does not create new `docs/` documents. | UIUXDesigner edits `docs/` files only to insert `![Figure N](...)` references. Any other `docs/` edit is out of scope. |
| **Worker (Tier F)** | All paths (conversion context only) | Worker carries no path restrictions at the tier level, so it may write to `docs/`, `learning_base/`, or `specs/` — the same paths owned by Tier W agents. | **Edge case rule:** Worker writes to Tier W–owned paths only when explicitly invoked by a Tier W agent or ProjectManager for a specific mechanical conversion task. Worker must not initiate writes to `docs/`, `learning_base/02_requirements/`, `learning_base/11_voice_of_customer/`, or `specs/` autonomously. The invoking Tier W agent owns the resulting output and retains authorship and content accountability; Worker acts solely as a mechanical executor. If Worker produces output on a Tier W–owned path without an explicit invocation instruction, this constitutes a Tier F scope violation and must be escalated to ProjectManager. |

**Overlap rule:** When a `docs/` write action is ambiguous, the caller workflow determines the responsible agent:
- Stakeholder Feedback Workflow → ProductOwner writes VoC, BusinessAnalyst writes requirements updates.
- Diagram Lifecycle Workflow → UIUXDesigner inserts image references only.
- Requirements Cascade Workflow → BusinessAnalyst writes all updated docs.
- Sprint Planning Workflow → ScrumMaster writes sprint plan into `docs/ways-of-work/`.
- **Worker (Tier F) on Tier W–owned paths:** Worker may write to the same paths as Tier W agents only when acting as a mechanical executor on behalf of an invoking Tier W agent or ProjectManager. Worker-produced files on Tier W–owned paths are governed by the invoking agent's write partition; the invoking agent must accept or reject the output before it is considered authoritative. Worker must never write to Tier W–owned paths without an explicit invocation instruction referencing the target path and conversion task.

---

## Execute-Scope Boundary (Research Baseline)

### QAEngineer Test-Only Execute

| Execute Category | Permitted Commands | Prohibited Commands |
| --- | --- | --- |
| Test execution | `pytest`, `jest`, `npm test`, `make test`, `dotnet test` | Any build, install, or deployment command |
| Terminal read | `read/terminalLastCommand`, `read/terminalSelection`, `execute/getTerminalOutput` | Write to terminal or execute shell commands not related to tests |
| Test failure capture | `execute/testFailure`, `execute/awaitTerminal` | Editing source files after test failure |
| Coverage reports | `execute/runInTerminal` for coverage scripts only | Any `rm`, `mv`, `cp`, `install` commands |
| Prohibited categories | — | `edit/createFile`, `edit/editFiles`, `edit/createDirectory`, `Bash` (general) |

### UIUXDesigner Render-Only Execute

| Execute Category | Permitted Commands | Prohibited Commands |
| --- | --- | --- |
| Mermaid render | `mmdc --input [path].mmd --output [path].png --scale 4 --backgroundColor white` | Any non-`mmdc` terminal command |
| Render script shortcut | `scripts/render_mermaid_diagrams.ps1` (via `execute/runInTerminal`) | Any script not in `scripts/` directory |
| Prohibited categories | — | `install.sh`, `make`, `npm`, `python`, `git`, any general shell operation |

### Worker Full Execute (Conversion Context)

| Execute Category | Permitted Commands | Scope Constraint |
| --- | --- | --- |
| Format conversion | `pandoc`, `libreoffice --convert-to`, `python convert_*.py` | Only when invoked by ProductOwner or ProjectManager for explicit conversion task |
| Archive/move | `mv`, `cp` for output placement into `learning_base/_inbox/` → target | Only after successful conversion; no destructive operations |
| General Bash | All commands | Constrained by template body: "Execute only the specific conversion command requested." |

---

## Enforcement Mechanism Layers (Research Baseline)

### Layer 1: Template-Level (Frontmatter)

Enforcement point: `disallowedTools:` array in agent template YAML frontmatter.

| How it works | When a tool listed in `disallowedTools` is invoked, the agent framework (Copilot or CC) blocks the call before the agent body processes the request. |
| Failure mode | Agent attempts a prohibited tool call → framework returns an error or silent refusal depending on IDE. Agent must not retry the same call. |
| Agent self-reporting | Template body should include a rationalization-prevention note: "If you are about to call [prohibited tool], STOP and escalate to [ProjectManager/caller agent] instead." |
| Limitation | Tool exclusion covers tool-invocation only. It does not prevent an agent from producing text that describes how to invoke a tool. Template body guidance is required as a second control. |

### Layer 2: Generation-Time (generate.js Validation)

Enforcement point: `agents-personal/scripts/generate.js` template compilation + `install.sh` validation list.

| How it works | `generate.js` compiles all `.template.md` files in `templates/agents/`. Required frontmatter fields (`name`, `description`, `copilot:`) must be present. Missing fields cause a build failure. |
| Required validation additions | Each new agent (`project-manager`, `product-owner`, `frontend-dev`, `backend-dev`, `qa-engineer`, `ui-ux-designer`) must be added to the `check_generated_files()` list in `install.sh` (lines 222-259 per Section 11.1 source). |
| disallowedTools validation | `generate.js` does not currently validate `disallowedTools` content. Governance compliance requires a manual review step before Builder generates templates: human reviewer must verify `disallowedTools` against the approved Phase 6 tooling boundary matrix. |
| Failure mode | Missing frontmatter field → build fails, template not deployed. Wrong disallowedTools (not caught automatically) → human review is the final gate. |

### Layer 3: Runtime (Checkpoint Gates + PM Routing)

Enforcement point: ProjectManager orchestration routing matrix (Phase 5).

| How it works | All incoming requests route through ProjectManager Entry Gate. PM routing matrix determines which agent handles each step. If an agent reports it "cannot perform X" (due to tier), PM must reroute to a capable agent rather than allowing the restricted agent to attempt the action. |
| Checkpoint guards | Each PM-managed checkpoint verifies that the previous step's output exists and is authored by the correct agent tier. If a read-only agent produced a file artifact, PM flags this as a permission violation and pauses for human review. |
| Violation detection | Out-of-permission artifact present in `.tasks/` or `learning_base/` → PM checkpoint holds; requires human decision: accept artifact (grant exception), reject artifact (rerun with correct agent), or escalate. |
| Limitation | Layer 3 only detects violations that produce filesystem artifacts. Advisory agents producing text outputs that exceed their role cannot be reliably detected through this layer. Template body guidance (Layer 1 body) remains the primary control for advisory-only agents. |

---

## Implementation Plan

This phase produces seven artifacts in `.tasks/005-pm-agent-system/artifacts/phase-6/`. All content is derived from the research baselines above plus sources listed in Source Guidelines.

### Artifacts to Create

| Artifact File | Content | Linked Checkpoint |
| --- | --- | --- |
| `phase-6-permission-tier-definitions.md` | Six-tier definition table with canonical properties | CP-6.1 |
| `phase-6-agent-permission-tier-table.md` | Nine-agent master table with tier, paths, tools, status | CP-6.2 |
| `phase-6-tooling-boundary-matrix.md` | Copilot tools + disallowedTools + CC tools per agent | CP-6.3 |
| `phase-6-execute-scope-boundary.md` | QAEngineer and UIUXDesigner permitted/prohibited command lists | CP-6.5 |
| `phase-6-enforcement-mechanisms.md` | Three enforcement layers with trigger, action, failure mode, recovery | CP-6.6 |
| `phase-6-cross-agent-consistency-check.md` | Nine agents × six axes consistency matrix with PASS/FAIL | CP-6.7 |
| `phase-6-drift-detection-checklist.md` | Twelve-condition drift detection checklist per tier | CP-6.8 |
| `phase-6-source-traceability-matrix.md` | Governance rule → source doc mapping for all rules | CP-6.10 |

The Write-Path Partition Table and Execute-Scope Boundary are embedded inline in `phase-6-agent-permission-tier-table.md` as supplementary tables, rather than standalone files (they are sub-sections of the main tier table artifact).

### File Create/Update Targets (Plan-Only Boundary)

All targets are under `.tasks/005-pm-agent-system/`. No files outside this directory are created or modified.

| Action | Target Path |
| --- | --- |
| Create directory | `.tasks/005-pm-agent-system/artifacts/phase-6/` |
| Create | `.tasks/005-pm-agent-system/artifacts/phase-6/phase-6-permission-tier-definitions.md` |
| Create | `.tasks/005-pm-agent-system/artifacts/phase-6/phase-6-agent-permission-tier-table.md` |
| Create | `.tasks/005-pm-agent-system/artifacts/phase-6/phase-6-tooling-boundary-matrix.md` |
| Create | `.tasks/005-pm-agent-system/artifacts/phase-6/phase-6-execute-scope-boundary.md` |
| Create | `.tasks/005-pm-agent-system/artifacts/phase-6/phase-6-enforcement-mechanisms.md` |
| Create | `.tasks/005-pm-agent-system/artifacts/phase-6/phase-6-cross-agent-consistency-check.md` |
| Create | `.tasks/005-pm-agent-system/artifacts/phase-6/phase-6-drift-detection-checklist.md` |
| Create | `.tasks/005-pm-agent-system/artifacts/phase-6/phase-6-source-traceability-matrix.md` |
| Update | `.tasks/005-pm-agent-system/task.md` (Phase 6 row: status → `📋 Planned`, plan link added) |

---

## Cross-Agent Permission Consistency Check (Plan-Only Pre-Verification)

The full matrix artifact is an implementation target (Builder creates it). This section records the six axes and expected outcomes for use as a construction guide.

### Six Check Axes

| Axis | Description | Pass Condition |
| --- | --- | --- |
| A1: Read Scope | Declared read paths match tier definition | Agent reads only within declared tier scope |
| A2: Write Scope | Declared write paths match tier definition; "None" for Tier O/R/RE | No write tools present for Tier O, R, RE |
| A3: Execute Scope | Execute tools match tier; absent for Tier O/R/W | No execute tools for Tier O, R, W; only test tools for Tier RE; only render for Tier RW-D |
| A4: disallowedTools Completeness | disallowedTools list covers all prohibited tools (no gap) | All prohibited tools named; no prohibited tool present in allowed list |
| A5: Escalation Path Present | Agent has exactly one escalation path defined | Single escalation path points to ProjectManager (or Human for PM) |
| A6: Tool-Tier Alignment | Actual allowed tools match the tier's canonical tool list from Section 11.2 | Tool list matches canonical source without additions or subtractions |

### Expected Verdict Summary (Pre-Construction)

| Agent | A1 | A2 | A3 | A4 | A5 | A6 | Expected |
| --- | --- | --- | --- | --- | --- | --- | --- |
| ProjectManager | PASS | PASS | PASS | *Verify Task disallow* | PASS | PASS | No blockers |
| ProductOwner | PASS | PASS | PASS | *Verify terminal/runInTerminal* | PASS | PASS | No blockers |
| BusinessAnalyst | PASS | PASS | PASS | *Verify terminal/runInTerminal* | PASS | PASS | No blockers |
| ScrumMaster | PASS | PASS | PASS | *Verify terminal/runInTerminal* | PASS | PASS | No blockers |
| FrontendDev | PASS | PASS | PASS | *Verify edit/* exclusion* | PASS | PASS | No blockers |
| BackendDev | PASS | PASS | PASS | *Verify edit/* exclusion* | PASS | PASS | No blockers |
| QAEngineer | PASS | PASS | PASS | *Verify edit/* exclusion* | PASS | PASS | No blockers |
| UIUXDesigner | PASS | *Verify docs/ scope* | *Verify mmdc-only* | *Verify Bash exclusion* | PASS | PASS | Verify UIUXDesigner docs/ write partition |
| Worker | PASS | PASS | PASS | *Confirm conversion-only body constraint* | PASS | PASS | No blockers |

Items marked *Verify* are pre-identified review points where the Builder must confirm the correct value before declaring each cell PASS. These are not pre-ordained failures — they are the cells with highest drift risk given earlier phase plan decisions.

---

## README and Docs Alignment Check (Plan Specification)

Phase 6 governance must be consistent with the agents-personal README agent listing and any existing docs.

### Check 1: agents-personal README Agent Table

- Expected source: `C:/Users/s1058662/repos/agents-personal/README.md`
- Expected content: a table or list of agent names included in the framework.
- Alignment condition: the nine agents defined in Phase 6 (PM, PO, BA, SM, FE, BE, QA, UIUX, Worker) must all appear in the README agent listing (or be listed as "to be added" for new agents). If the README does not list new agents, a resolution recommendation must be documented in the Phase 6 `phase-6-source-traceability-matrix.md` for Builder to action.
- **Not a Phase 6 write action**: This check is read-only. Updating the agents-personal README is a Builder task.

### Check 2: agents-personal docs/ ADR Consistency

- Expected source: `C:/Users/s1058662/repos/agents-personal/docs/architecture/ADR-001` through `ADR-007`.
- Alignment condition: no ADR entry contradicts the permission tier definitions in Phase 6. If an ADR defines a permission model that differs from Phase 6, the discrepancy must be flagged in the source traceability matrix.
- **Not a Phase 6 write action**: ADR updates (if needed) are a Builder task in a future phase.

### Check 3: .github/copilot-instructions.md Diagram Lifecycle

- Expected source: `VIP/.github/copilot-instructions.md`
- Alignment condition: UIUXDesigner Tier RW-D write scope and execute scope match the four-step Mermaid diagram lifecycle defined in copilot-instructions.md (established in Phase 3 CP-3.3). Any discrepancy found in Phase 6 must be documented.

---

## Verification

### Plan-Only Verification (Explorer scope)

1. All Phase 6 file create/update targets verified as `.tasks/005-pm-agent-system/**` — no file outside this path is listed in the implementation plan.
2. Permission tier assignments in Phase 6 are consistent with Phase 3 (REQ-303), Phase 4 (REQ-402), Phase 5 (REQ-501), and source plan Section 8.
3. Nine agents are covered: ProjectManager, ProductOwner, BusinessAnalyst, ScrumMaster, FrontendDev, BackendDev, QAEngineer, UIUXDesigner, Worker — no agent omitted.
4. Six tiers are defined: Tier O, Tier R, Tier RE, Tier RW-D, Tier W, Tier F.
5. Every tier has a canonical `disallowedTools` list and an `escalation path`.
6. Write-path partition resolves apparent `docs/` overlap between ProductOwner, BusinessAnalyst, and UIUXDesigner.
7. Execute-scope boundary distinguishes QAEngineer (test-only) from UIUXDesigner (render-only) from Worker (conversion context).
8. Cross-agent consistency check axes and expected outcomes are defined before implementation (rationalization-prevention: outcomes are not cherry-picked post-hoc).

### Builder Verification (post-implementation)

- `task.md` Phase 6 row shows `📋 Planned` with link to `plan/phase-6-access-permission-governance.md`.
- All eight artifact files exist under `.tasks/005-pm-agent-system/artifacts/phase-6/`.
- `phase-6-cross-agent-consistency-check.md` has nine rows × six axes with explicit PASS/FAIL per cell and a blocking issues list.
- `phase-6-drift-detection-checklist.md` has minimum twelve conditions.
- `phase-6-tooling-boundary-matrix.md` Copilot tool names match exactly the tool string format used in `agents-personal/templates/README.md` and Section 11.2.
- No file outside `.tasks/005-pm-agent-system/**` was created or modified.

---

## Source Traceability Matrix (Construction Guide)

The full traceability matrix is an artifact to be built by Builder. The following stub records the required columns and expected row coverage.

**Required columns:** `governance rule` | `source doc` | `source clause` | `phase-where-established` | `implementation note`

**Minimum row coverage:**
- Tier O definition → conductor.template.md, Phase 5 REQ-501/REQ-509.
- Tier R definition → researcher.template.md, Phase 3 REQ-303.
- Tier RE definition → reviewer.template.md, Phase 3 REQ-303, source plan Section 3.5 (QAEngineer frontmatter).
- Tier RW-D definition → Phase 3 REQ-303/REQ-304, source plan Section 3.x (UIUXDesigner), copilot-instructions.md.
- Tier W (PO) → business-analyst.template.md, Phase 4 REQ-402/REQ-410.
- Tier W (BA) → business-analyst.template.md, Phase 4 REQ-402.
- Tier W (SM) → scrum-master.template.md, Phase 4 REQ-402.
- Tier F (Worker) → worker.template.md, source plan Section 8.
- disallowedTools Copilot namespace → ADR-005 (IDE compatibility).
- disallowedTools CC namespace → ADR-005.
- Write-path partition → source plan Section 8 (per-agent write column).
- Execute-scope boundary (QA) → source plan Section 3.5 (QAEngineer frontmatter).
- Execute-scope boundary (UIUXDesigner) → copilot-instructions.md Mermaid step 2, Phase 3 CP-3.3.
- Enforcement Layer 1 → ADR-001 (tool constraint pattern), templates/README.md.
- Enforcement Layer 2 → scripts/generate.js, install.sh lines 222-259 (per Section 11.1).
- Enforcement Layer 3 → ADR-001 (checkpoint gating), Phase 5 orchestration routing matrix.
- Cross-agent consistency axes → ADR-007 (rationalization-prevention evidence standard).
- Drift detection → ADR-007, ADR-001.
