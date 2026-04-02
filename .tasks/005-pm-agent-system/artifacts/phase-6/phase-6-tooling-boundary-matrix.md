---
artifact: phase-6-tooling-boundary-matrix
task: 005-pm-agent-system
phase: 6
created: 2026-03-18
status: complete
checkpoint: CP-6.3
sources:
  - agents-personal/templates/README.md (Section: Frontmatter Structure)
  - agents-personal/docs/architecture/ADR-005-ide-compatibility.md
  - phase-6-permission-tier-definitions.md (canonical tier properties)
  - phase-3-plan (REQ-303, REQ-304, REQ-305)
  - phase-4-plan (REQ-402, REQ-410)
  - phase-5-plan (REQ-501, REQ-509)
  - VIP/learning_base/ideas/pm_agent_coordination_system_implementation_plan.md Section 11.2
---

# Phase 6 Artifact: Tooling Boundary Matrix

## Purpose

This document defines the exact Copilot `tools:` list, Copilot `disallowedTools:` list, and CC `tools:` / `disallowedTools:` list for every agent in the PM agent system. Tool names use the exact identifier strings from `agents-personal/templates/README.md` and Section 11.2 of the source plan.

**Namespace rule (ADR-005):** Copilot and CC use different tool identifier namespaces. Copilot uses slash-namespaced strings (e.g., `read/readFile`, `edit/editFiles`). CC uses PascalCase tool names (e.g., `Read`, `Edit`, `Bash`). These are listed separately in every agent row.

---

## Tooling Boundary Matrix

### ProjectManager — Tier O (Orchestration-Only)

| Dimension | Tool List |
| --- | --- |
| **Copilot `tools:`** | `vscode/askQuestions`, `read/readFile`, `search/semanticSearch`, `search/textSearch`, `workspace/fileSearch`, `search/webSearch` |
| **Copilot `disallowedTools:`** | `terminal/runInTerminal`, `edit/createFile`, `edit/editFiles`, `edit/createDirectory`, `Task` |
| **CC `tools:`** | `Read`, `LS`, `Glob`, `Grep`, `WebSearch`, `TodoRead` |
| **CC `disallowedTools:`** | `Bash`, `Write`, `Edit`, `MultiEdit`, `TodoWrite` |
| **Special Copilot flag** | `disable-model-invocation: true` |
| **Special CC flag** | `permissionMode: plan` |
| **Rationale** | Read and search only; full write/execute exclusion; `Task` excluded to prevent unstructured subagent spawning; `disable-model-invocation` prevents orchestration loops; `TodoWrite` excluded to prevent PM from creating persistent state writes |

**Prohibited category coverage:**
- ❌ Terminal: `terminal/runInTerminal` (Copilot), `Bash` (CC)
- ❌ File creation: `edit/createFile` (Copilot), `Write` (CC)
- ❌ File editing: `edit/editFiles` (Copilot), `Edit`, `MultiEdit` (CC)
- ❌ Directory creation: `edit/createDirectory` (Copilot)
- ❌ Subagent spawn: `Task` (Copilot + CC context)
- ❌ State write: `TodoWrite` (CC)

---

### ProductOwner — Tier W (Read + Write, No Execute)

| Dimension | Tool List |
| --- | --- |
| **Copilot `tools:`** | `vscode/askQuestions`, `read/problems`, `read/readFile`, `agent`, `edit/createDirectory`, `edit/createFile`, `edit/editFiles`, `search/semanticSearch`, `search/textSearch`, `workspace/fileSearch`, `search/webSearch`, `todo` |
| **Copilot `disallowedTools:`** | `terminal/runInTerminal` |
| **CC `tools:`** | `Read`, `LS`, `Glob`, `Grep`, `Write`, `Edit`, `WebSearch`, `TodoRead`, `TodoWrite` |
| **CC `disallowedTools:`** | `Bash`, `Task` |
| **Special flags** | None |
| **Rationale** | Full read + write access; terminal excluded to prevent script execution; `Task` excluded in CC because PO delegates via handoff buttons only |

**Prohibited category coverage:**
- ❌ Terminal: `terminal/runInTerminal` (Copilot), `Bash` (CC)
- ❌ Subagent spawn: `Task` (CC)
- ✅ File write: `edit/createFile`, `edit/editFiles` (Copilot), `Write`, `Edit` (CC)

---

### BusinessAnalyst — Tier W (Read + Write, No Execute)

| Dimension | Tool List |
| --- | --- |
| **Copilot `tools:`** | `vscode/askQuestions`, `read/problems`, `read/readFile`, `agent`, `edit/createDirectory`, `edit/createFile`, `edit/editFiles`, `search/semanticSearch`, `search/textSearch`, `workspace/fileSearch`, `search/webSearch`, `todo` |
| **Copilot `disallowedTools:`** | `terminal/runInTerminal` |
| **CC `tools:`** | `Read`, `LS`, `Glob`, `Grep`, `Write`, `Edit`, `WebSearch`, `TodoRead`, `TodoWrite` |
| **CC `disallowedTools:`** | `Bash`, `Task` |
| **Special flags** | None |
| **Rationale** | Identical tier to ProductOwner; same write toolset, same terminal prohibition. Existing agent — template must be validated against this boundary matrix on next generation. |

**Prohibited category coverage:**
- ❌ Terminal: `terminal/runInTerminal` (Copilot), `Bash` (CC)
- ❌ Subagent spawn: `Task` (CC)
- ✅ File write: `edit/createFile`, `edit/editFiles` (Copilot), `Write`, `Edit` (CC)

---

### ScrumMaster — Tier W (Read + Write, No Execute)

| Dimension | Tool List |
| --- | --- |
| **Copilot `tools:`** | `vscode/askQuestions`, `read/problems`, `read/readFile`, `agent`, `edit/createDirectory`, `edit/createFile`, `edit/editFiles`, `search/semanticSearch`, `search/textSearch`, `workspace/fileSearch`, `search/webSearch`, `todo` |
| **Copilot `disallowedTools:`** | `terminal/runInTerminal` |
| **CC `tools:`** | `Read`, `LS`, `Glob`, `Grep`, `Write`, `Edit`, `WebSearch`, `TodoRead`, `TodoWrite` |
| **CC `disallowedTools:`** | `Bash`, `Task` |
| **Special flags** | None |
| **Rationale** | Identical tier to PO and BA; same write toolset, same terminal prohibition. Existing agent — write path restriction to `docs/ways-of-work/` is instruction-enforced in template body. |

**Prohibited category coverage:**
- ❌ Terminal: `terminal/runInTerminal` (Copilot), `Bash` (CC)
- ❌ Subagent spawn: `Task` (CC)
- ✅ File write: `edit/createFile`, `edit/editFiles` (Copilot), `Write`, `Edit` (CC)

---

### FrontendDev — Tier R (Read-Only Advisory)

| Dimension | Tool List |
| --- | --- |
| **Copilot `tools:`** | `vscode/askQuestions`, `read/problems`, `read/readFile`, `agent`, `search/semanticSearch`, `search/textSearch`, `workspace/fileSearch`, `search/webSearch`, `todo` |
| **Copilot `disallowedTools:`** | `terminal/runInTerminal`, `edit/createFile`, `edit/editFiles`, `edit/createDirectory` |
| **CC `tools:`** | `Read`, `LS`, `Glob`, `Grep`, `WebSearch`, `TodoRead` |
| **CC `disallowedTools:`** | `Bash`, `Write`, `Edit`, `MultiEdit`, `Task` |
| **Special flags** | None |
| **Rationale** | No write, no execute, no subagent spawning. Advisory text outputs only. All write and terminal tools excluded in both namespaces. |

**Prohibited category coverage:**
- ❌ Terminal: `terminal/runInTerminal` (Copilot), `Bash` (CC)
- ❌ File creation: `edit/createFile` (Copilot), `Write` (CC)
- ❌ File editing: `edit/editFiles` (Copilot), `Edit`, `MultiEdit` (CC)
- ❌ Directory creation: `edit/createDirectory` (Copilot)
- ❌ Subagent spawn: `Task` (CC)

---

### BackendDev — Tier R (Read-Only Advisory)

| Dimension | Tool List |
| --- | --- |
| **Copilot `tools:`** | `vscode/askQuestions`, `read/problems`, `read/readFile`, `agent`, `search/semanticSearch`, `search/textSearch`, `workspace/fileSearch`, `search/webSearch`, `todo` |
| **Copilot `disallowedTools:`** | `terminal/runInTerminal`, `edit/createFile`, `edit/editFiles`, `edit/createDirectory` |
| **CC `tools:`** | `Read`, `LS`, `Glob`, `Grep`, `WebSearch`, `TodoRead` |
| **CC `disallowedTools:`** | `Bash`, `Write`, `Edit`, `MultiEdit`, `Task` |
| **Special flags** | None |
| **Rationale** | Identical tooling boundary to FrontendDev. Separate agent, same Tier R profile. |

**Prohibited category coverage:** (same as FrontendDev)
- ❌ Terminal, ❌ File creation, ❌ File editing, ❌ Directory creation, ❌ Subagent spawn

---

### QAEngineer — Tier RE (Read + Execute, Test-Only)

| Dimension | Tool List |
| --- | --- |
| **Copilot `tools:`** | `vscode/askQuestions`, `execute/testFailure`, `execute/getTerminalOutput`, `execute/awaitTerminal`, `execute/runInTerminal`, `execute/runTests`, `read/problems`, `read/readFile`, `read/terminalSelection`, `read/terminalLastCommand`, `agent`, `search/semanticSearch`, `search/textSearch`, `workspace/fileSearch`, `todo` |
| **Copilot `disallowedTools:`** | `edit/createFile`, `edit/editFiles`, `edit/createDirectory` |
| **CC `tools:`** | `Bash`, `Read`, `LS`, `Glob`, `Grep`, `WebSearch`, `TodoRead` |
| **CC `disallowedTools:`** | `Write`, `Edit`, `MultiEdit`, `Task` |
| **Special flags** | CC `Bash` is permitted but scope-constrained to test commands by template body. Template must explicitly list permitted commands: `pytest`, `jest`, `npm test`, `make test`, `dotnet test`. |
| **Rationale** | Execute tools included for test observation; all write tools excluded in both namespaces. Bash included in CC for test runner invocation but restricted by body instruction (REQ-605). |

**Prohibited category coverage:**
- ❌ File creation: `edit/createFile` (Copilot), `Write` (CC)
- ❌ File editing: `edit/editFiles` (Copilot), `Edit`, `MultiEdit` (CC)
- ❌ Directory creation: `edit/createDirectory` (Copilot)
- ❌ Subagent spawn: `Task` (CC)
- ✅ Test execution: `execute/runTests`, `execute/runInTerminal` (Copilot), `Bash` (CC, test-only)

---

### UIUXDesigner — Tier RW-D (Read + Write Diagrams)

| Dimension | Tool List |
| --- | --- |
| **Copilot `tools:`** | `vscode/askQuestions`, `read/problems`, `read/readFile`, `agent`, `edit/createDirectory`, `edit/createFile`, `edit/editFiles`, `execute/runInTerminal`, `execute/getTerminalOutput`, `search/semanticSearch`, `search/textSearch`, `workspace/fileSearch`, `search/webSearch`, `todo` |
| **Copilot `disallowedTools:`** | `terminal/runInTerminal` (note: `execute/runInTerminal` is permitted for mmdc only; `terminal/runInTerminal` refers to general-purpose non-execute terminal access; body instruction restricts `execute/runInTerminal` scope to mmdc commands) |
| **CC `tools:`** | `Read`, `LS`, `Glob`, `Grep`, `Write`, `Edit`, `WebSearch`, `TodoRead` |
| **CC `disallowedTools:`** | `Bash`, `MultiEdit`, `Task` |
| **Special flags** | Write restriction to `diagrams/`, `images/diagrams/`, and diagram-adjacent `docs/` references is **instruction-enforced** in template body. Frontmatter cannot enforce path-granular write restrictions. |
| **Rationale** | Write tools included for diagram file creation; `Bash` excluded to prevent general shell execution; `MultiEdit` excluded to prevent bulk cross-path edits; render scope is instruction-limited to `mmdc` only. |

**Prohibited category coverage:**
- ❌ General terminal: `terminal/runInTerminal` (Copilot), `Bash` (CC)
- ❌ Bulk edit: `MultiEdit` (CC)
- ❌ Subagent spawn: `Task` (CC)
- ✅ Diagram write: `edit/createFile`, `edit/editFiles` (Copilot), `Write`, `Edit` (CC)
- ✅ Render execute: `execute/runInTerminal` (Copilot — mmdc only, body-constrained)

---

### Worker — Tier F (Full Access)

| Dimension | Tool List |
| --- | --- |
| **Copilot `tools:`** | Full toolset: `vscode/askQuestions`, `read/*`, `edit/*`, `execute/*`, `search/*`, `terminal/runInTerminal`, `todo`, `agent` |
| **Copilot `disallowedTools:`** | None formally; scope constrained by template body |
| **CC `tools:`** | Full toolset: `Bash`, `Read`, `LS`, `Glob`, `Grep`, `Write`, `Edit`, `MultiEdit`, `WebSearch`, `TodoRead`, `TodoWrite`, `Task` |
| **CC `disallowedTools:`** | None formally |
| **Special flags** | Template body must state: "Only execute commands required for the requested conversion task. Do not initiate writes to Tier W–owned paths without explicit invocation instruction referencing target path and task." |
| **Rationale** | Full access is required for mechanical file conversion tasks (format conversion, archive operations, script execution). Scope control is behavioral (template body) rather than frontmatter-level. Existing agent template must be reviewed for body-level conversion constraint presence during CP-6.2 verification. |

**Note on Tier F governance:**
- No formal `disallowedTools` does not mean unrestricted behavior. All scope control is body-level.
- Drift detection for Tier F (see `phase-6-drift-detection-checklist.md`) focuses on verifying that the body-level conversion constraint exists and is not bypassed.

---

## Namespace Cross-Reference Summary

| Copilot Tool Name | CC Equivalent | Category |
| --- | --- | --- |
| `edit/createFile` | `Write` | File creation |
| `edit/editFiles` | `Edit` | File editing |
| `edit/createDirectory` | (no direct CC equivalent — covered by `Write` context) | Directory creation |
| `terminal/runInTerminal` | `Bash` | General terminal / shell |
| `execute/runInTerminal` | `Bash` (scope-constrained) | Scoped execution |
| `execute/runTests` | `Bash` (test-only context) | Test execution |
| `Task` (subagent spawn) | `Task` (CC subagent) | Subagent invocation |
| `read/readFile` | `Read` | File reading |
| `search/semanticSearch`, `search/textSearch` | `Grep`, `Glob` | Search |
| `workspace/fileSearch` | `LS`, `Glob` | Directory listing |
| `search/webSearch` | `WebSearch` | Web access |
| `todo` | `TodoRead`, `TodoWrite` | Task tracking |

**Source:** `agents-personal/templates/README.md` — Frontmatter Structure; `agents-personal/docs/architecture/ADR-005-ide-compatibility.md` IDE compatibility guidelines.
