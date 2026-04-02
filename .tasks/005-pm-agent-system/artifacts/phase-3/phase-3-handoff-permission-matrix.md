---
artifact: phase-3-handoff-permission-matrix
task: 005-pm-agent-system
phase: 3
created: 2026-03-18
status: complete
sources:
  - agents-personal/templates/agents/conductor.template.md
  - agents-personal/docs/architecture/ADR-001-orchestration-and-subagents.md
  - agents-personal/docs/architecture/ADR-002-task-centric-persistence.md
  - agents-personal/docs/architecture/ADR-004-skill-powered-subagents.md
  - agents-personal/docs/architecture/ADR-007-rationalization-prevention.md
  - .github/copilot-instructions.md
  - phase-3-specialist-agent-specs.md
---

# Phase 3 Handoff and Permission Matrix

## Purpose

This document consolidates the permission tiers, handoff contracts, escalation registry, and disallowed action registry for all four Phase 3 specialist agents. It serves as the CP-3.2 evidence artifact for Reviewer approval.

---

## 1. Permission Matrix (CP-3.2 Evidence)

| Agent | Read (any file) | Write (docs/specs) | Write (diagrams/images) | Execute (tests) | Execute (terminal cmds) | Delegate to subagent | User-invokable |
|---|---|---|---|---|---|---|---|
| **FrontendDev** | ✅ Allowed | ❌ Denied | ❌ Denied | ❌ Denied | ❌ Denied | ❌ Denied | ✅ Allowed |
| **BackendDev** | ✅ Allowed | ❌ Denied | ❌ Denied | ❌ Denied | ❌ Denied | ❌ Denied | ✅ Allowed |
| **QAEngineer** | ✅ Allowed | ❌ Denied | ❌ Denied | ✅ Allowed | ⚠️ Conditional¹ | ❌ Denied | ✅ Allowed |
| **UIUXDesigner** | ✅ Allowed | ❌ Denied | ✅ Allowed² | ❌ Denied | ❌ Denied | ❌ Denied | ✅ Allowed |

**Column notes:**

¹ **QAEngineer Execute (terminal commands):** Conditional — terminal execution is permitted only for test runner commands (`pytest`, `npm test`, `npx playwright test`). Any other terminal command is disallowed. Machine-enforced via `Bash` included in CC tools, but behavioral scope is instruction-enforced. Source: ADR-001 §Agent Capabilities Table; MIT-303.

² **UIUXDesigner Write (diagrams/images):** Allowed and governed by Mermaid diagram lifecycle from `.github/copilot-instructions.md`. Write scope is `diagrams/` and `images/diagrams/` exclusively. Machine-enforced by disallowing `Bash`, `Task`, `MultiEdit`; path restriction is instruction-enforced per CON-303 and MIT-302.

### Permission Tier Definitions

| Tier | Name | Agents | Machine-Enforced Restrictions |
|---|---|---|---|
| **Tier R** | Read-Only Advisory | FrontendDev, BackendDev | `disallowedTools: ["Bash", "Write", "Edit", "MultiEdit", "Task"]` |
| **Tier RE** | Read + Test Execute | QAEngineer | `disallowedTools: ["Write", "Edit", "MultiEdit", "Task"]` |
| **Tier RW-D** | Read + Diagram Write | UIUXDesigner | `disallowedTools: ["Bash", "Task", "MultiEdit"]` |

---

## 2. Handoff Contract Table

| Agent | Upstream Callers (who may invoke) | Input Expected | Output Produced | Downstream Consumers | Checkpoint Pause Expected |
|---|---|---|---|---|---|
| **FrontendDev** | ProjectManager, ProductOwner, direct user | Natural language advisory request with scope (file refs or topic) | Structured advisory note: findings, risks, recommended actions, implementation_owner | ProjectManager (checkpoint), Builder/Worker (implementation) | **Yes** — Advisory delivered → PM reviews → human approves before Builder acts |
| **BackendDev** | ProjectManager, ProductOwner, direct user | Natural language advisory request with scope (API spec, architecture doc, or topic) | Structured advisory note: findings, risks, recommended changes, implementation_owner | ProjectManager (checkpoint), Builder/Worker (implementation) | **Yes** — Advisory delivered → PM reviews → human approves before Builder acts |
| **QAEngineer** | ProjectManager, ScrumMaster, direct user | Test execution scope: suite path(s), coverage targets, sprint/feature identifier | Quality gate assessment: pass/fail counts, coverage %, critical failures, go/no-go | ProjectManager (checkpoint and gate decision), ScrumMaster (sprint close routing) | **Yes** — QA report delivered → PM/SM review → human approves sprint close or escalation |
| **UIUXDesigner** | ProjectManager, ProductOwner, direct user | Diagram or design request: workflow name, diagram type, target document, sequence number | `.mmd` source file, render instruction, image reference markdown, manifest verification | ProjectManager (checkpoint), ProductOwner (product review), document maintainer | **Yes** — UIUXDesigner completes steps 1+3 → user runs render (step 2) → UIUXDesigner verifies manifest (step 4) → PM gates document merge |

### Handoff Trigger Conditions

| Agent | Handoff Trigger | Target | Handoff Label |
|---|---|---|---|
| FrontendDev | Advisory complete | ProjectManager | "Return to ProjectManager" |
| BackendDev | Advisory complete | ProjectManager | "Return to ProjectManager" |
| QAEngineer | QA report complete (any result) | ProjectManager | "Return to ProjectManager" |
| QAEngineer | Critical failure detected | ScrumMaster | "Escalate Failure to ScrumMaster" |
| UIUXDesigner | Diagram lifecycle complete | ProjectManager | "Return to ProjectManager" |
| UIUXDesigner | Diagram ready for product review | ProductOwner | "Return to ProductOwner" |

---

## 3. Escalation Registry

| Agent | Escalation Path | Trigger Condition | Receiving Agent | Required Output at Escalation |
|---|---|---|---|---|
| **FrontendDev** | → ProjectManager | Request scope exceeds advisory (write/execute request); advisory contradicts spec; request requires backend expertise | ProjectManager | Decline message with reason; escalation brief for PM routing |
| **BackendDev** | → ProjectManager | Request scope exceeds advisory; security risk requiring immediate decision; request requires frontend expertise | ProjectManager | Decline message with reason; security risk flag if applicable |
| **QAEngineer** | → ProjectManager | Critical failure (`go_no_go: NO-GO`); test environment failure; coverage gap requiring new tests | ProjectManager | Quality gate assessment with `go_no_go: NO-GO`; escalation reason |
| **UIUXDesigner** | → ProjectManager | Write request targets path outside `diagrams/`/`images/diagrams/`; diagram conflicts with existing spec; render script error | ProjectManager | Decline message; conflict or error description |

**Single-route enforcement:** Each specialist has exactly one escalation route (→ ProjectManager). No specialist may escalate directly to another specialist. This satisfies REQ-302 (exactly one escalation path per specialist) and REQ-307 (non-overlapping scopes).

---

## 4. Disallowed Action Registry

The following table lists specific disallowed behaviors that must appear as explicit runtime instructions in each agent's template body (not only in frontmatter toolsets). These provide behavioral enforcement beyond machine-level tool restrictions.

| Agent | Disallowed Action | Enforcement Layer | Rule Statement |
|---|---|---|---|
| **FrontendDev** | Edit any file | Machine (disallowedTools) + Instruction | "You may NOT edit any file. If asked, decline and escalate to ProjectManager." |
| **FrontendDev** | Execute any terminal command | Machine (disallowedTools) + Instruction | "You may NOT run any command. All execution routes to Builder/Worker." |
| **FrontendDev** | Invoke any subagent | Machine (disallowedTools: Task) + Instruction | "You may NOT invoke subagents. Cross-specialist coordination routes through ProjectManager." |
| **FrontendDev** | Resolve cross-specialist scope conflicts autonomously | Instruction only | "Do not resolve conflicts with BackendDev/UIUXDesigner/QAEngineer scope. Escalate to ProjectManager." |
| **BackendDev** | Edit any file | Machine (disallowedTools) + Instruction | "You may NOT edit any file. If asked, decline and escalate to ProjectManager." |
| **BackendDev** | Execute any terminal command | Machine (disallowedTools) + Instruction | "You may NOT run any command." |
| **BackendDev** | Invoke any subagent | Machine (disallowedTools: Task) + Instruction | "You may NOT invoke subagents." |
| **BackendDev** | Resolve cross-specialist scope conflicts autonomously | Instruction only | "Escalate all cross-role scope questions to ProjectManager." |
| **QAEngineer** | Edit source or test files | Machine (disallowedTools: Edit, Write) + Instruction | "You may NOT edit any source or test file. All file modifications route to Builder/Worker." |
| **QAEngineer** | Execute non-test terminal commands | Instruction only (Bash allowed for tests) | "Terminal access is granted for test execution only: pytest, npm test, playwright. No other commands." |
| **QAEngineer** | Fix failing tests autonomously | Instruction only (ADR-007 rationalization prevention) | "You MUST NOT rationalize editing a test file as 'just a minor fix.' Report and escalate." |
| **QAEngineer** | Invoke subagents | Machine (disallowedTools: Task) + Instruction | "You may NOT invoke subagents." |
| **UIUXDesigner** | Write to docs/, specs/, or learning_base/ | Instruction only (path-level, not machine-enforced) | "Write scope is diagrams/ and images/diagrams/ ONLY. Do not write to any other path." |
| **UIUXDesigner** | Self-execute render_mermaid_diagrams.ps1 | Machine (disallowedTools: Bash) + Instruction | "You MUST NOT execute scripts. Instruct the user to run render_mermaid_diagrams.ps1." |
| **UIUXDesigner** | Invoke subagents | Machine (disallowedTools: Task) + Instruction | "You may NOT invoke subagents." |
| **UIUXDesigner** | Perform bulk cross-path edits | Machine (disallowedTools: MultiEdit) + Instruction | "MultiEdit is disallowed to prevent bulk path-agnostic edits outside diagram scope." |
| **UIUXDesigner** | Skip any Mermaid lifecycle step | Instruction only (all four steps mandatory) | "You MUST complete all four Mermaid lifecycle steps. Skipping any step is a compliance violation." |
| **All four** | Invoke peer specialist directly | Instruction only | "All cross-specialist coordination routes through ProjectManager only." |
| **All four** | Produce output outside .tasks/ (advisory agents) | Instruction only | "Advisory outputs save to .tasks/005-pm-agent-system/advisory/ only." |

---

## 5. Permission Enforcement Summary

### Machine-Enforced Boundaries (via `disallowedTools`)

| Agent | Disallowed in CC frontmatter | Coverage |
|---|---|---|
| FrontendDev | `["Bash", "Write", "Edit", "MultiEdit", "Task"]` | All execution, write, and subagent actions |
| BackendDev | `["Bash", "Write", "Edit", "MultiEdit", "Task"]` | All execution, write, and subagent actions |
| QAEngineer | `["Write", "Edit", "MultiEdit", "Task"]` | All write and subagent actions (Bash kept for test execution) |
| UIUXDesigner | `["Bash", "Task", "MultiEdit"]` | Shell execution, subagent spawning, bulk edits |

### Instruction-Enforced Boundaries (require runtime compliance)

| Boundary | Agent(s) | Reason Not Machine-Enforceable |
|---|---|---|
| Write path restriction to diagrams/ and images/diagrams/ | UIUXDesigner | CC frontmatter `Write`/`Edit` tools have no path-granular scope |
| QAEngineer terminal scope to test commands only | QAEngineer | Bash tool has no command-granular scope |
| Peer-to-peer invocation prohibition | All four | Cross-agent invocation is coordination-level, not tool-level |
| Mermaid lifecycle step compliance | UIUXDesigner | Step-ordering is behavioral, not mechanically enforceable |

**Source:** Phase 3 plan Step 2 note — "Path-level restriction to `diagrams/` and `images/diagrams/` is instruction-enforced via the `## Permission Boundaries` body section — CC frontmatter does not provide path-granular tool scoping, so this boundary is policy-level rather than tool-level."
