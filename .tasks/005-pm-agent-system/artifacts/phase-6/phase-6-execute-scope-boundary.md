---
artifact: phase-6-execute-scope-boundary
task: 005-pm-agent-system
phase: 6
created: 2026-03-18
status: complete
checkpoint: CP-6.5
sources:
  - phase-6-permission-tier-definitions.md (Tier RE and Tier RW-D definitions)
  - phase-3-plan (REQ-303, REQ-305)
  - VIP/learning_base/ideas/pm_agent_coordination_system_implementation_plan.md Section 3.5, Section 11.2
  - .github/copilot-instructions.md (Mermaid lifecycle steps)
  - agents-personal/docs/architecture/ADR-007-rationalization-prevention.md
---

# Phase 6 Artifact: Execute-Scope Boundary

## Purpose

This document defines precise permitted and prohibited command sets for the three agents that have any execute scope: QAEngineer (Tier RE), UIUXDesigner (Tier RW-D), and Worker (Tier F). ProjectManager, ProductOwner, BusinessAnalyst, ScrumMaster, FrontendDev, and BackendDev have **no execute scope** — this document does not apply to them.

---

## 1. QAEngineer — Test-Only Execute (Tier RE)

### Permitted Commands

QAEngineer may execute test runner commands and test observation operations only. All permitted execution must be in service of evaluating test results — not fixing, modifying, or building.

| Execute Category | Permitted Commands / Tools | Notes |
| --- | --- | --- |
| **Test runner — JavaScript/Node** | `npm test`, `jest`, `npx jest`, `npx playwright test`, `vitest` | Any Jest/Playwright/Vitest test invocation |
| **Test runner — Python** | `pytest`, `python -m pytest` | Include flags for coverage: `pytest --cov` |
| **Test runner — .NET** | `dotnet test` | Standard .NET test runner |
| **Test runner — Make** | `make test` | Only when `test` target is a test runner |
| **Coverage reports** | `pytest --cov`, `jest --coverage`, `nyc` | Coverage reporting as part of test run |
| **Terminal read (Copilot)** | `read/terminalLastCommand`, `read/terminalSelection`, `execute/getTerminalOutput`, `execute/awaitTerminal` | Read/observe terminal output only |
| **Test failure capture** | `execute/testFailure` | Capture structured test failure data |
| **Test execution (Copilot)** | `execute/runInTerminal`, `execute/runTests` | Scoped to test commands only |
| **CC Bash** | `pytest [args]`, `npm test [args]`, `dotnet test [args]`, `jest [args]` | All other Bash commands prohibited |

### Prohibited Commands

QAEngineer must not execute any of the following. If asked, QAEngineer must decline and report to ProjectManager.

| Prohibited Category | Examples | Reason |
| --- | --- | --- |
| **Build commands** | `npm run build`, `dotnet build`, `make build`, `tsc` | Build is not QA responsibility |
| **Install commands** | `npm install`, `pip install`, `dotnet restore` | Dependency management out of scope |
| **Deployment commands** | `kubectl apply`, `docker build`, `helm install`, `az deploy` | Deployment out of scope |
| **File modification** | `rm`, `mv`, `cp [to new location]`, `sed -i`, `awk -i` | QA must not modify files |
| **Script execution (non-test)** | `scripts/generate.js`, `install.sh`, `render_mermaid_diagrams.ps1` | Non-test scripts prohibited |
| **Source file editing** | Any editor invocation, `edit/createFile`, `edit/editFiles` | QA must not edit source or test files |
| **Git operations** | `git commit`, `git push`, `git merge` | Not QA responsibility |

### Enforcement Notes

- Copilot: `edit/createFile`, `edit/editFiles`, `edit/createDirectory` are in `disallowedTools` — machine-enforced.
- CC: `Write`, `Edit`, `MultiEdit` are in `disallowedTools` — machine-enforced.
- `Bash` terminal scope is instruction-enforced only (no command-granular frontmatter restriction): template body must list the exact permitted test commands.
- **ADR-007 rationalization-prevention:** QAEngineer must not rationalize editing a test or source file as "just a minor fix." If a test failure requires code modification, QAEngineer reports the failure and escalates to ProjectManager — it does not self-remediate.

---

## 2. UIUXDesigner — Render-Only Execute (Tier RW-D)

### Permitted Commands

UIUXDesigner may only execute Mermaid rendering operations. These are explicitly scoped to diagram source-to-image conversion as part of the four-step Mermaid lifecycle.

| Execute Category | Permitted Commands / Tools | Notes |
| --- | --- | --- |
| **Mermaid CLI render** | `mmdc --input [path].mmd --output [path].png --scale 4 --backgroundColor white` | Exact flag set per `.github/copilot-instructions.md` step 2 |
| **Render script shortcut** | `scripts/render_mermaid_diagrams.ps1` | Batch render via project-standard script; must be in `scripts/` directory |
| **Output verification** | `execute/getTerminalOutput` after mmdc | Capture render success/failure output |
| **Copilot execute** | `execute/runInTerminal` (mmdc only), `execute/getTerminalOutput` | Scoped to mmdc commands only by template body |

### Prohibited Commands

UIUXDesigner must not execute any non-render terminal command. If asked, UIUXDesigner must decline and return a handoff to ProjectManager.

| Prohibited Category | Examples | Reason |
| --- | --- | --- |
| **General shell** | `ls`, `cat`, `curl`, `wget`, `echo` | Not diagram-related |
| **Package management** | `npm install`, `pip install` | Not UIUXDesigner responsibility |
| **Build/deploy** | `make`, `npm run build`, `docker build` | Not UIUXDesigner responsibility |
| **Git operations** | `git commit`, `git push` | Not UIUXDesigner responsibility |
| **Non-Mermaid scripts** | `generate.js`, `install.sh`, any Python script | Only `render_mermaid_diagrams.ps1` permitted |
| **draw.io CLI render** | `xvfb-run`, `drawio --export` | draw.io rendering is user-assisted, not agent-executed |
| **File deletion** | `rm`, `del` | No file destruction permitted |
| **Bulk operations** | `find ... -exec`, `xargs` | Bulk operations excluded per `MultiEdit` prohibition |

### Mermaid Lifecycle Step Compliance

UIUXDesigner execute scope is tied to the four-step Mermaid lifecycle from `.github/copilot-instructions.md`:

| Step | UIUXDesigner Action | Execute Used? |
| --- | --- | --- |
| Step 1: Write `.mmd` source | Create `diagrams/[name].mmd` | ❌ No execute (file write only) |
| Step 2: Render to image | Run `mmdc` or `render_mermaid_diagrams.ps1` | ✅ Yes — this is the only execute step |
| Step 3: Insert image reference | Add `![Figure N](images/diagrams/[name].png)` to doc | ❌ No execute (file edit only) |
| Step 4: Verify manifest | Check diagram manifest file for completeness | ❌ No execute (file read only) |

**Compliance rule:** Execute is valid only during Step 2. Any attempt to use `execute/runInTerminal` outside of Step 2 (e.g., to run a validation script during Step 4) is out of scope.

### Enforcement Notes

- CC: `Bash` is in `disallowedTools` — machine-enforced general shell block.
- `execute/runInTerminal` in Copilot is allowed but scope-constrained by template body to `mmdc` and `render_mermaid_diagrams.ps1` only.
- `MultiEdit` excluded to prevent bulk cross-path edits.
- Template body must explicitly state: "Execute only `mmdc` or `scripts/render_mermaid_diagrams.ps1` via `execute/runInTerminal`. All other terminal operations are prohibited."

---

## 3. Worker — Full Execute (Conversion Context)

### Permitted Commands

Worker has no formal execute restrictions at the tier level. All execute scope is governed by the template body conversion-context constraint. The following table enumerates the primary use-case command categories.

| Execute Category | Permitted Commands | Scope Constraint |
| --- | --- | --- |
| **Format conversion** | `pandoc`, `libreoffice --convert-to [format]`, `python convert_*.py` | Only when invoked for an explicit conversion task by ProductOwner, BusinessAnalyst, ScrumMaster, or ProjectManager |
| **Archive / move (post-conversion)** | `mv [source] [target]`, `cp [source] [target]` | Output placement only, after successful conversion; no destructive pre-conversion operations |
| **Script execution** | Any script in `scripts/` directory | Only scripts referenced in the explicit invocation instruction |
| **General Bash** | All commands | Template body constraint: "Execute only the specific conversion command requested in the invocation instruction." |
| **CC Bash** | All commands | Same constraint: conversion task only |

### Scope Violation Conditions

Even though Worker has no formal execute disallowedTools list, the following conditions constitute scope violations that must trigger escalation to ProjectManager:

| Condition | Violation Type | Required Response |
| --- | --- | --- |
| Worker executes a build, install, or deploy command not referenced in the invocation | Scope creep | Stop; escalate to ProjectManager |
| Worker executes destructive operations (`rm -rf`, `truncate`, `shred`) | Destructive execution | Stop; escalate to ProjectManager |
| Worker executes on Tier W–owned paths without explicit invocation instruction | Tier F path violation | Stop; escalate to ProjectManager |
| Worker invokes another subagent (Task) | Unauthorized delegation | Stop; return to caller |

### Enforcement Notes

- No formal `disallowedTools` — template body is the sole constraint layer.
- Build must verify that the Worker template body contains the conversion-context constraint phrase before deploying.
- Tier F drift detection (see `phase-6-drift-detection-checklist.md`) monitors for Worker invocations outside the declared conversion use case.

---

## Execute Scope Comparison

| Agent | Tier | Execute Permitted? | What Can Be Executed | Key Constraint |
| --- | --- | --- | --- | --- |
| ProjectManager | O | ❌ None | — | No terminal at all |
| ProductOwner | W | ❌ None | — | `terminal/runInTerminal` disallowed |
| BusinessAnalyst | W | ❌ None | — | `terminal/runInTerminal` disallowed |
| ScrumMaster | W | ❌ None | — | `terminal/runInTerminal` disallowed |
| FrontendDev | R | ❌ None | — | No terminal, no execute |
| BackendDev | R | ❌ None | — | No terminal, no execute |
| QAEngineer | RE | ✅ Test-only | `pytest`, `jest`, `npm test`, `dotnet test`, coverage scripts | No source file edits; test commands only |
| UIUXDesigner | RW-D | ✅ Render-only | `mmdc`, `render_mermaid_diagrams.ps1` | Non-mmdc commands prohibited |
| Worker | F | ✅ Full (constrained) | All commands (conversion context only) | Body-level conversion constraint; no autonomous writes to Tier W paths |
