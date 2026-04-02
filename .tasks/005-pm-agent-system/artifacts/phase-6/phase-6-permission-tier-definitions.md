---
artifact: phase-6-permission-tier-definitions
task: 005-pm-agent-system
phase: 6
created: 2026-03-18
status: complete
checkpoint: CP-6.1
sources:
  - agents-personal/templates/agents/conductor.template.md
  - agents-personal/templates/agents/researcher.template.md
  - agents-personal/templates/agents/business-analyst.template.md
  - agents-personal/templates/agents/scrum-master.template.md
  - agents-personal/templates/agents/worker.template.md
  - agents-personal/docs/architecture/ADR-001-orchestration-and-subagents.md
  - agents-personal/docs/architecture/ADR-005-ide-compatibility.md
  - phase-3-plan (REQ-303, REQ-304, REQ-305)
  - phase-4-plan (REQ-402, REQ-410)
  - phase-5-plan (REQ-501, REQ-509)
  - VIP/learning_base/ideas/pm_agent_coordination_system_implementation_plan.md Section 8
---

# Phase 6 Artifact: Permission Tier Definitions

## Purpose

This document defines the six canonical permission tiers governing all agents in the 2026_01_VIP PM agent system. Tier codes, names, and property values are authoritative references for template authoring, generation-time validation, and runtime enforcement. All Phase 6, Phase 7, and Phase 8 artifacts must reference these tiers by canonical code and name.

---

## Tier Definitions

### Tier O — Orchestration-Only

| Property | Value |
| --- | --- |
| **Tier code** | O |
| **Tier name** | Orchestration-Only |
| **Agent(s)** | ProjectManager |
| **Read scope** | `.tasks/`, `learning_base/` (task and context reading only) |
| **Write scope** | **None** |
| **Execute scope** | **None** |
| **Delegation authority** | Full — may route to any agent in the system via explicit handoff buttons |
| **Copilot `tools:`** | `vscode/askQuestions`, `read/readFile`, `search/semanticSearch`, `search/textSearch`, `workspace/fileSearch`, `search/webSearch` |
| **Copilot `disallowedTools:`** | `terminal/runInTerminal`, `edit/createFile`, `edit/editFiles`, `edit/createDirectory`, `Task` |
| **CC `tools:`** | `Read`, `LS`, `Glob`, `Grep`, `WebSearch`, `TodoRead` |
| **CC `disallowedTools:`** | `Bash`, `Write`, `Edit`, `MultiEdit`, `TodoWrite` |
| **Special flags** | `disable-model-invocation: true` (conductor pattern; PM cannot be invoked by another model) |
| **Escalation path** | → Human Reviewer (PM is the terminal orchestration point; no further agent escalation) |
| **Source** | `conductor.template.md`; Phase 5 REQ-501, REQ-509; ADR-001 orchestration model |

**Behavioral enforcement notes:**
- PM must decline all write and execute requests. If a PM instance is asked to modify a file, it must surface a handoff button to the appropriate Tier W or Tier F agent.
- `disable-model-invocation: true` prevents orchestration loops where PM is invoked by a subagent.
- `Task` is excluded from Copilot tools because all delegation is through structured handoff buttons — arbitrary subagent spawning is not permitted.

---

### Tier R — Read-Only (Advisory)

| Property | Value |
| --- | --- |
| **Tier code** | R |
| **Tier name** | Read-Only (Advisory) |
| **Agent(s)** | FrontendDev, BackendDev |
| **Read scope** | All paths (unrestricted read for advisory quality) |
| **Write scope** | **None** |
| **Execute scope** | **None** |
| **Delegation authority** | None — outputs are advisory text only; no subagent invocation |
| **Copilot `tools:`** | `vscode/askQuestions`, `read/problems`, `read/readFile`, `agent`, `search/semanticSearch`, `search/textSearch`, `workspace/fileSearch`, `search/webSearch`, `todo` |
| **Copilot `disallowedTools:`** | `terminal/runInTerminal`, `edit/createFile`, `edit/editFiles`, `edit/createDirectory` |
| **CC `tools:`** | `Read`, `LS`, `Glob`, `Grep`, `WebSearch`, `TodoRead` |
| **CC `disallowedTools:`** | `Bash`, `Write`, `Edit`, `MultiEdit`, `Task` |
| **Special flags** | None |
| **Escalation path** | → ProjectManager |
| **Source** | `researcher.template.md`; Phase 3 REQ-303; source plan Section 8 |

**Behavioral enforcement notes:**
- Tier R agents produce advisory notes only. They must never create, edit, or commit files.
- If asked to "fix" something, the agent must decline, produce a finding note, and escalate to ProjectManager.
- Cross-specialist routing is prohibited — FrontendDev must not invoke BackendDev and vice versa.

---

### Tier RE — Read + Execute (Test-Only)

| Property | Value |
| --- | --- |
| **Tier code** | RE |
| **Tier name** | Read + Execute (Test-Only) |
| **Agent(s)** | QAEngineer |
| **Read scope** | All paths |
| **Write scope** | **None** |
| **Execute scope** | Test execution only: `runTests`, `runInTerminal` (test scripts only), `getTerminalOutput`, `testFailure`, `awaitTerminal`, `terminalLastCommand`, `terminalSelection` |
| **Delegation authority** | None — escalates findings but does not delegate work |
| **Copilot `tools:`** | `vscode/askQuestions`, `execute/testFailure`, `execute/getTerminalOutput`, `execute/awaitTerminal`, `execute/runInTerminal`, `execute/runTests`, `read/problems`, `read/readFile`, `read/terminalSelection`, `read/terminalLastCommand`, `agent`, `search/semanticSearch`, `search/textSearch`, `workspace/fileSearch`, `todo` |
| **Copilot `disallowedTools:`** | `edit/createFile`, `edit/editFiles`, `edit/createDirectory` |
| **CC `tools:`** | `Bash` (test execution only, scope-constrained by template body), `Read`, `LS`, `Glob`, `Grep`, `WebSearch`, `TodoRead` |
| **CC `disallowedTools:`** | `Write`, `Edit`, `MultiEdit`, `Task` |
| **Special flags** | Bash is permitted for test execution only; template body must state the permitted command set explicitly (REQ-605) |
| **Escalation path** | → ProjectManager |
| **Source** | Phase 3 REQ-303, REQ-305; source plan Section 3.5; ADR-007 rationalization-prevention |

**Behavioral enforcement notes:**
- Terminal access is granted for `pytest`, `jest`, `npm test`, `make test`, `dotnet test`, and coverage report scripts only.
- QAEngineer must NOT edit any source or test file. If a test failure requires a code fix, QAEngineer reports the finding and escalates — it does not self-remediate.
- ADR-007 rationalization-prevention applies: QAEngineer must not rationalize editing a file as "just a minor fix."

---

### Tier RW-D — Read + Write Diagrams (Diagram-Scoped Write)

| Property | Value |
| --- | --- |
| **Tier code** | RW-D |
| **Tier name** | Read + Write Diagrams (Diagram-Scoped Write) |
| **Agent(s)** | UIUXDesigner |
| **Read scope** | All paths |
| **Write scope** | `diagrams/`, `images/diagrams/`, `docs/` (diagram-adjacent only: `.mmd` sources, `.png` image references in existing markdown — no new `docs/` document creation) |
| **Execute scope** | Mermaid render only: `mmdc` via `execute/runInTerminal`; `scripts/render_mermaid_diagrams.ps1` via `execute/runInTerminal` |
| **Delegation authority** | None — escalates only |
| **Copilot `tools:`** | `vscode/askQuestions`, `read/problems`, `read/readFile`, `agent`, `edit/createDirectory`, `edit/createFile`, `edit/editFiles`, `execute/runInTerminal`, `execute/getTerminalOutput`, `search/semanticSearch`, `search/textSearch`, `workspace/fileSearch`, `search/webSearch`, `todo` |
| **Copilot `disallowedTools:`** | `terminal/runInTerminal` (non-mmdc general Bash; not tool-level enforceable — enforced by template body) |
| **CC `tools:`** | `Read`, `LS`, `Glob`, `Grep`, `Write`, `Edit`, `WebSearch`, `TodoRead` |
| **CC `disallowedTools:`** | `Bash` (general shell; `mmdc` render command invoked via Write-compatible pattern only), `MultiEdit`, `Task` |
| **Special flags** | Write restriction to diagram paths is instruction-enforced, not solely frontmatter-enforced. Template body must explicitly state: "Write only to `diagrams/`, `images/diagrams/`, and diagram-adjacent `docs/` references." |
| **Escalation path** | → ProjectManager |
| **Source** | Phase 3 REQ-303, REQ-304; source plan Section 3.x; `.github/copilot-instructions.md` Mermaid lifecycle |

**Behavioral enforcement notes:**
- UIUXDesigner must complete all four Mermaid lifecycle steps. Skipping any step is a compliance violation.
- Writes to `docs/` are limited to inserting `![Figure N](...)` image references in existing markdown files. UIUXDesigner must not create new `docs/` documents.
- `MultiEdit` is excluded to prevent bulk path-agnostic edits outside the diagram scope.

---

### Tier W — Read + Write (No Execute)

| Property | Value |
| --- | --- |
| **Tier code** | W |
| **Tier name** | Read + Write (No Execute) |
| **Agent(s)** | ProductOwner, BusinessAnalyst, ScrumMaster |
| **Read scope** | All paths |
| **Write scope** | Role-partitioned (see Write-Path Partition section in `phase-6-agent-permission-tier-table.md`) |
| **Execute scope** | **None** |
| **Delegation authority** | Handoff-only — each Tier W agent may invoke named downstream agents via explicit handoff buttons |
| **Copilot `tools:`** | `vscode/askQuestions`, `read/problems`, `read/readFile`, `agent`, `edit/createDirectory`, `edit/createFile`, `edit/editFiles`, `search/semanticSearch`, `search/textSearch`, `workspace/fileSearch`, `search/webSearch`, `todo` |
| **Copilot `disallowedTools:`** | `terminal/runInTerminal` |
| **CC `tools:`** | `Read`, `LS`, `Glob`, `Grep`, `Write`, `Edit`, `WebSearch`, `TodoRead`, `TodoWrite` |
| **CC `disallowedTools:`** | `Bash`, `Task` |
| **Special flags** | None |
| **Escalation path** | → ProjectManager |
| **Source** | `business-analyst.template.md`; `scrum-master.template.md`; Phase 4 REQ-402, REQ-410; source plan Section 8 |

**Behavioral enforcement notes:**
- Tier W agents may write files but cannot execute terminal commands or shell scripts.
- Write paths are strictly partitioned by content type (see Write-Path Partition table). Agents must not write to paths outside their designated partition.
- Delegating to Worker for mechanical conversion is permitted but does not grant the invoking agent elevated permissions — the invoking agent retains authorship accountability.

---

### Tier F — Full Access

| Property | Value |
| --- | --- |
| **Tier code** | F |
| **Tier name** | Full Access |
| **Agent(s)** | Worker |
| **Read scope** | All paths |
| **Write scope** | All paths (constrained to conversion task context by template body) |
| **Execute scope** | All: Bash, `runInTerminal`, file conversion scripts |
| **Delegation authority** | None — Worker executes and returns output to caller; no further subagent spawning |
| **Copilot `tools:`** | Full toolset including `execute/*` and `edit/*` |
| **Copilot `disallowedTools:`** | None formally; template body constrains scope to conversion context |
| **CC `tools:`** | Full toolset |
| **CC `disallowedTools:`** | None formally |
| **Special flags** | Tier F is not a blank permission grant. Template body must define: "Only execute commands required for the requested conversion task. Do not initiate writes to Tier W–owned paths without explicit invocation instruction." |
| **Escalation path** | → Caller agent (ProductOwner or ProjectManager); not to any specialist peer |
| **Source** | `worker.template.md`; source plan Section 8; Phase 4 Worker-vs-PO conversion matrix |

**Behavioral enforcement notes:**
- Worker is mechanically invoked by a Tier W agent or ProjectManager. It never initiates autonomous task work.
- Worker writing to `docs/`, `learning_base/`, or `specs/` is only valid when carrying an explicit invocation instruction referencing the target path and conversion task.
- If Worker produces output on a Tier W–owned path without an explicit invocation instruction, this is a Tier F scope violation — escalate to ProjectManager.
- Worker carries no path restrictions at the tier level; scope is enforced entirely by template body instructions.

---

## Tier Summary Table

| Tier Code | Tier Name | Agents | Write | Execute | Delegation | Escalation Path |
| --- | --- | --- | --- | --- | --- | --- |
| O | Orchestration-Only | ProjectManager | None | None | Full (handoff buttons) | → Human Reviewer |
| R | Read-Only (Advisory) | FrontendDev, BackendDev | None | None | None | → ProjectManager |
| RE | Read + Execute (Test-Only) | QAEngineer | None | Test execution only | None | → ProjectManager |
| RW-D | Read + Write Diagrams | UIUXDesigner | `diagrams/`, `images/diagrams/`, `docs/` (image refs only) | `mmdc` render only | None | → ProjectManager |
| W | Read + Write (No Execute) | ProductOwner, BusinessAnalyst, ScrumMaster | Role-partitioned `docs/`, `learning_base/`, `specs/` | None | Handoff-only | → ProjectManager |
| F | Full Access | Worker | All paths (conversion context) | All | None | → Caller agent |
