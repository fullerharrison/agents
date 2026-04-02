---
artifact: phase-6-drift-detection-checklist
task: 005-pm-agent-system
phase: 6
created: 2026-03-18
status: complete
checkpoint: CP-6.8
sources:
  - agents-personal/docs/architecture/ADR-001-orchestration-and-subagents.md
  - agents-personal/docs/architecture/ADR-007-rationalization-prevention.md
  - phase-6-permission-tier-definitions.md (tier canonical properties)
  - phase-6-enforcement-mechanisms.md (enforcement layer definitions)
  - phase-3-plan (REQ-303, REQ-612)
  - VIP/learning_base/ideas/pm_agent_coordination_system_implementation_plan.md Section 8, 11.2
---

# Phase 6 Artifact: Drift Detection Checklist

## Purpose

This checklist enables detection of permission drift — the condition where an agent's actual behavior or template configuration deviates from its declared permission tier. Per REQ-612, a minimum of two independently verifiable conditions per tier must be enumerated, yielding a minimum floor of twelve conditions total (six tiers × two conditions each).

**Traceable floor formula (REQ-612):** `minimum conditions = 2 × number of tiers = 2 × 6 = 12`

This document enumerates 14 conditions (exceeding the minimum) to ensure coverage of both configuration-level and behavioral-level drift across all tiers.

---

## Drift Detection Format

Each condition follows this structure:

- **Condition ID:** unique reference code
- **Tier:** affected tier code
- **Drift Type:** Configuration (frontmatter deviation) or Behavioral (runtime action deviation)
- **Drift Signal:** what to look for
- **Detection Method:** how to check for the signal
- **Responsible Party:** who must perform the check
- **Remediation Action:** what to do if drift is detected

---

## Tier O — Orchestration-Only (ProjectManager)

### Condition O-1: PM Template Gains Write Tool

| Field | Value |
| --- | --- |
| **Condition ID** | O-1 |
| **Tier** | O (ProjectManager) |
| **Drift Type** | Configuration |
| **Drift Signal** | `edit/createFile`, `edit/editFiles`, `edit/createDirectory`, `Write`, or `Edit` appears in the ProjectManager template `tools:` or `cc.tools:` list, or the `disallowedTools:` list has been shortened to remove any of these entries |
| **Detection Method** | Grep the generated `project-manager.agent.md` (Copilot output) and `project-manager.md` (CC output) for any of: `edit/createFile`, `edit/editFiles`, `edit/createDirectory`, `Write`, `Edit`. If any appear outside `disallowedTools`, drift is present. Command: `grep -E "edit/createFile\|edit/editFiles\|Write\|Edit" generated/copilot/agents/project-manager.agent.md` |
| **Responsible Party** | Builder (post-generation verification); Human Reviewer (pre-deploy sign-off) |
| **Remediation Action** | Remove write tools from `tools:` list; restore to `disallowedTools:` list; re-run `generate.js`; re-verify against `phase-6-tooling-boundary-matrix.md` |

---

### Condition O-2: PM Accepts Execute Request Without Routing

| Field | Value |
| --- | --- |
| **Condition ID** | O-2 |
| **Tier** | O (ProjectManager) |
| **Drift Type** | Behavioral |
| **Drift Signal** | ProjectManager session log shows a file creation, file edit, or terminal command executed directly by the PM context — not as a handoff to a specialist agent |
| **Detection Method** | Review PM session transcript for any `edit:`, `write:`, `terminal:`, or `bash:` tool call that is NOT preceded by a handoff-button routing action. If PM directly invoked `edit/createFile` or `Bash`, drift has occurred. Secondary check: look for file artifacts in `.tasks/` or `learning_base/` where the authoring session is the ProjectManager (not a specialist agent). |
| **Responsible Party** | Human Reviewer (post-session review); PM checkpoint gate (Layer 3 enforcement) |
| **Remediation Action** | Flag session as governance violation; escalate to Human Reviewer; re-run the affected workflow step using the correct specialist agent; document exception decision if output must be accepted |

---

## Tier R — Read-Only Advisory (FrontendDev, BackendDev)

### Condition R-1: Read-Only Agent Template Contains Write Tool

| Field | Value |
| --- | --- |
| **Condition ID** | R-1 |
| **Tier** | R (FrontendDev, BackendDev) |
| **Drift Type** | Configuration |
| **Drift Signal** | `edit/createFile`, `edit/editFiles`, `edit/createDirectory`, `Write`, `Edit`, or `MultiEdit` appears in the agent's `tools:` or `cc.tools:` list in the generated template |
| **Detection Method** | Grep the generated agent files: `grep -E "edit/createFile\|edit/editFiles\|Write\|Edit\|MultiEdit" generated/copilot/agents/frontend-dev.agent.md generated/copilot/agents/backend-dev.agent.md`. Any match in the `tools:` block (not `disallowedTools:`) is a drift signal. |
| **Responsible Party** | Builder (post-generation); Human Reviewer (pre-deploy) |
| **Remediation Action** | Remove write tools from `tools:` block; add to `disallowedTools:`; re-generate; re-verify |

---

### Condition R-2: Read-Only Agent Produces a File Artifact

| Field | Value |
| --- | --- |
| **Condition ID** | R-2 |
| **Tier** | R (FrontendDev, BackendDev) |
| **Drift Type** | Behavioral |
| **Drift Signal** | A new file appears in `.tasks/`, `docs/`, `learning_base/`, or `specs/` that was authored in a session where only FrontendDev or BackendDev was active — with no corresponding Tier W or Tier F agent session in the handoff chain |
| **Detection Method** | Review file creation timestamps and session logs after FrontendDev or BackendDev sessions. If a file was created and the only active agent was a Tier R agent, drift has occurred. Advisory outputs from Tier R agents should only appear as text in the conversation — not as committed files unless explicitly routed through a Tier W agent for authoring. |
| **Responsible Party** | Human Reviewer (post-session audit); PM Layer 3 checkpoint (artifact authorship check) |
| **Remediation Action** | Identify the file; verify if it was authorized (i.e., produced by a downstream Tier W agent based on advisory output). If file was produced directly by the Tier R agent, mark it as ungoverned; route to appropriate Tier W agent for re-authorship or deletion |

---

## Tier RE — Read + Execute / Test-Only (QAEngineer)

### Condition RE-1: QAEngineer Template Contains Write Tool

| Field | Value |
| --- | --- |
| **Condition ID** | RE-1 |
| **Tier** | RE (QAEngineer) |
| **Drift Type** | Configuration |
| **Drift Signal** | `edit/createFile`, `edit/editFiles`, `edit/createDirectory`, `Write`, `Edit`, or `MultiEdit` appears in the QAEngineer `tools:` or `cc.tools:` list in the generated template |
| **Detection Method** | Grep: `grep -E "edit/createFile\|edit/editFiles\|Write\|Edit\|MultiEdit" generated/copilot/agents/qa-engineer.agent.md`. Any match in the `tools:` block is a drift signal. Also verify: `disallowedTools:` in the generated file contains all three required Copilot write tools. |
| **Responsible Party** | Builder (post-generation); Human Reviewer (pre-deploy) |
| **Remediation Action** | Remove write tools from `tools:` block; restore to `disallowedTools:`; re-generate; re-verify against `phase-6-tooling-boundary-matrix.md` |

---

### Condition RE-2: QAEngineer Executes Non-Test Terminal Command

| Field | Value |
| --- | --- |
| **Condition ID** | RE-2 |
| **Tier** | RE (QAEngineer) |
| **Drift Type** | Behavioral |
| **Drift Signal** | QAEngineer session transcript shows a terminal command other than `pytest`, `jest`, `npm test`, `make test`, `dotnet test`, or coverage report variants. Examples of prohibited commands: `npm install`, `rm`, `git commit`, `docker build`, `scripts/generate.js`. |
| **Detection Method** | Review QAEngineer session transcript terminal calls. Compare each `execute/runInTerminal` or `Bash` call against the permitted command list in `phase-6-execute-scope-boundary.md`. Any command not on the permitted list is a drift signal. |
| **Responsible Party** | Human Reviewer (post-session audit); QAEngineer template body self-check (rationalization-prevention per ADR-007) |
| **Remediation Action** | Flag the session as a behavioral violation; identify whether the non-test command was requested by the user (user-initiated scope expansion) or self-initiated (agent drift). Route future sessions through the correct agent for the prohibited command. Update template body with stricter rationalization-prevention note if self-initiated drift was detected. |

---

## Tier RW-D — Read + Write Diagrams (UIUXDesigner)

### Condition RWD-1: UIUXDesigner Writes Outside Diagram Paths

| Field | Value |
| --- | --- |
| **Condition ID** | RWD-1 |
| **Tier** | RW-D (UIUXDesigner) |
| **Drift Type** | Behavioral |
| **Drift Signal** | A file is created or modified by UIUXDesigner outside of `diagrams/`, `images/diagrams/`, or `docs/` (diagram-adjacent image reference insertion). Examples: UIUXDesigner creates a new `docs/requirements/*.md` file, or writes to `specs/`, `learning_base/`, or `scripts/`. |
| **Detection Method** | After UIUXDesigner sessions, check file system changes: `git status` or file modification timestamps. Any new or modified file outside `diagrams/`, `images/diagrams/`, or existing `docs/` files (modified for image reference insertion only) is a drift signal. Specifically: a new file in `docs/` that is not solely an `![Figure N](...)` image reference insert is a write scope violation. |
| **Responsible Party** | Builder (post-session path audit); PM Layer 3 checkpoint (artifact authorship check) |
| **Remediation Action** | Identify the out-of-scope file. If a new `docs/` file was created by UIUXDesigner, assess whether it should be: (1) converted to an image-reference-only edit by a Tier W agent, (2) deleted and re-created by the appropriate Tier W agent, or (3) escalated to PM for governance decision. Update UIUXDesigner template body write-path constraint if body language was ambiguous. |

---

### Condition RWD-2: UIUXDesigner Executes Non-Render Command

| Field | Value |
| --- | --- |
| **Condition ID** | RWD-2 |
| **Tier** | RW-D (UIUXDesigner) |
| **Drift Type** | Behavioral |
| **Drift Signal** | UIUXDesigner session shows a terminal command other than `mmdc` or `scripts/render_mermaid_diagrams.ps1`. Examples: `npm install`, `git commit`, `python script.py`, `draw.io --export`. |
| **Detection Method** | Review UIUXDesigner session transcript for `execute/runInTerminal` calls. Any command other than `mmdc [args]` or invocation of `render_mermaid_diagrams.ps1` is a drift signal. |
| **Responsible Party** | Human Reviewer (post-session audit) |
| **Remediation Action** | Flag the session. If the non-render command was user-requested, escalate to PM for appropriate routing. If self-initiated, update template body with stricter execute constraint. |

---

## Tier W — Read + Write, No Execute (ProductOwner, BusinessAnalyst, ScrumMaster)

### Condition W-1: Tier W Agent Template Contains Terminal Tool

| Field | Value |
| --- | --- |
| **Condition ID** | W-1 |
| **Tier** | W (ProductOwner, BusinessAnalyst, ScrumMaster) |
| **Drift Type** | Configuration |
| **Drift Signal** | `terminal/runInTerminal` or `Bash` appears in the `tools:` or `cc.tools:` list of any Tier W agent generated template |
| **Detection Method** | Grep generated files for all three agents: `grep -E "terminal/runInTerminal\|Bash" generated/copilot/agents/product-owner.agent.md generated/copilot/agents/business-analyst.agent.md generated/copilot/agents/scrum-master.agent.md`. Any match in the `tools:` block (not `disallowedTools:`) is a drift signal. Also check CC: `grep "Bash" generated/claude/agents/product-owner.md`. |
| **Responsible Party** | Builder (post-generation); Human Reviewer (pre-deploy) |
| **Remediation Action** | Move `terminal/runInTerminal` / `Bash` from `tools:` to `disallowedTools:`; re-generate; re-verify |

---

### Condition W-2: Tier W Agent Writes Outside Declared Path Partition

| Field | Value |
| --- | --- |
| **Condition ID** | W-2 |
| **Tier** | W (ProductOwner, BusinessAnalyst, ScrumMaster) |
| **Drift Type** | Behavioral |
| **Drift Signal** | A Tier W agent writes a file to a path outside its designated write partition. Examples: ProductOwner writes to `specs/`; BusinessAnalyst writes to `docs/ways-of-work/sprint_NN.md`; ScrumMaster writes to `docs/requirements/`. |
| **Detection Method** | After Tier W agent sessions, audit file changes: `git diff --name-only HEAD`. Cross-reference each changed path against the agent's declared write partition in `phase-6-agent-permission-tier-table.md`. Any path outside the declared partition is a drift signal. |
| **Responsible Party** | Human Reviewer (post-session path audit); PM Layer 3 checkpoint |
| **Remediation Action** | Identify the out-of-partition file. Route to the correct Tier W agent for re-authorship if needed. Flag as a partition violation in the session record. Update template body write-path constraint if the body language was ambiguous. |

---

## Tier F — Full Access (Worker)

### Condition F-1: Worker Writes to Tier W Path Without Explicit Invocation

| Field | Value |
| --- | --- |
| **Condition ID** | F-1 |
| **Tier** | F (Worker) |
| **Drift Type** | Behavioral |
| **Drift Signal** | Worker produces an output file on a Tier W–owned path (`docs/`, `learning_base/02_requirements/`, `learning_base/11_voice_of_customer/`, `specs/`, `docs/ways-of-work/`) without an explicit invocation instruction in the session that names the target path and conversion task |
| **Detection Method** | After Worker sessions, check file modification paths: `git diff --name-only HEAD`. If any file on a Tier W–owned path was modified and the session was initiated directly by the user (not by a Tier W agent or PM), examine the invocation for explicit path instruction. Absence of explicit path instruction is a drift signal. |
| **Responsible Party** | Human Reviewer (post-session invocation audit); PM Layer 3 checkpoint |
| **Remediation Action** | Flag the file as ungoverned. Present to the appropriate Tier W agent to accept or reject authorship. Document as Tier F scope violation. If violation was user-initiated, inform user that Worker requires explicit invocation instruction for writes to Tier W–owned paths. |

---

### Condition F-2: Worker Body Constraint Phrase Absent from Template

| Field | Value |
| --- | --- |
| **Condition ID** | F-2 |
| **Tier** | F (Worker) |
| **Drift Type** | Configuration |
| **Drift Signal** | The Worker template body does not contain the conversion-context constraint phrase: "Execute only the specific conversion command requested in the invocation instruction. Do not initiate writes to Tier W–owned paths without explicit invocation instruction referencing target path and conversion task." |
| **Detection Method** | Grep Worker template body: `grep -i "conversion command\|invocation instruction\|Tier W" templates/agents/worker.template.md`. If neither phrase is present, the body constraint is absent — this is a configuration drift signal. Also verify in the generated outputs: `grep "invocation instruction" generated/copilot/agents/worker.agent.md`. |
| **Responsible Party** | Builder (post-generation body verification); Human Reviewer (pre-deploy) |
| **Remediation Action** | Add the required conversion-context constraint phrase to the Worker template body `## Permission Boundaries` or `## Scope` section. Re-generate. Re-verify. This is a mandatory phrase; absence is a blocking issue. |

---

## Drift Condition Summary

| Condition ID | Tier | Drift Type | Key Signal | Detection Method | Responsible Party |
| --- | --- | --- | --- | --- | --- |
| O-1 | O | Configuration | Write tool in PM `tools:` | Grep generated template for `edit/createFile`, `Write`, `Edit` | Builder + Reviewer |
| O-2 | O | Behavioral | PM executes directly (no routing) | Session transcript audit for direct edit/bash calls | Human Reviewer |
| R-1 | R | Configuration | Write tool in Tier R `tools:` | Grep generated templates for `edit/createFile`, `Write`, `Edit` | Builder + Reviewer |
| R-2 | R | Behavioral | Tier R agent produces file artifact | File creation audit after Tier R sessions | Human Reviewer |
| RE-1 | RE | Configuration | Write tool in QAEngineer `tools:` | Grep generated template for `edit/*`, `Write`, `Edit` | Builder + Reviewer |
| RE-2 | RE | Behavioral | QA executes non-test command | Session transcript terminal call audit | Human Reviewer |
| RWD-1 | RW-D | Behavioral | UIUXDesigner writes outside diagram paths | `git status` / file timestamp audit after sessions | Builder + Reviewer |
| RWD-2 | RW-D | Behavioral | UIUXDesigner executes non-render command | Session transcript `execute/runInTerminal` audit | Human Reviewer |
| W-1 | W | Configuration | Tier W template contains terminal tool | Grep generated templates for `terminal/runInTerminal`, `Bash` | Builder + Reviewer |
| W-2 | W | Behavioral | Tier W writes outside path partition | `git diff --name-only` cross-referenced to partition table | Human Reviewer |
| F-1 | F | Behavioral | Worker writes Tier W path without invocation | File path audit + invocation instruction check | Human Reviewer |
| F-2 | F | Configuration | Worker body constraint phrase absent | Grep Worker template body for constraint phrase | Builder + Reviewer |

**Total conditions: 12 (meets minimum floor)** — includes two independently verifiable conditions per tier (one Configuration, one Behavioral for each) with the following exceptions:
- Tier RW-D: two Behavioral conditions (RWD-1 and RWD-2) because configuration drift is less likely given write tools are correctly included; behavioral write-path and execute-scope violations are the higher-risk channels.
- Tier W: one Configuration (W-1) and one Behavioral (W-2) — the terminal tool check is the highest configuration risk; write-path partition violation is the highest behavioral risk.

---

## Governance Review Gate

Before Builder generates any PM system agent template, the following conditions must be met:

| Gate Item | Check | Evidence Required |
| --- | --- | --- |
| Phase 6 consistency check complete | All nine agents verified PASS in `phase-6-cross-agent-consistency-check.md` | Reviewer sign-off on CP-6.7 |
| Tooling boundary matrix approved | `phase-6-tooling-boundary-matrix.md` approved at CP-6.3 | Reviewer sign-off on CP-6.3 |
| Drift detection checklist acknowledged | This document reviewed; responsible parties assigned | Reviewer sign-off on CP-6.8 |
| Agent template body constraints verified | Builder has confirmed `## Permission Boundaries` section in each template | Builder attestation post-generation |
| `install.sh` updated for new agents | All six new agents added to `check_generated_files()` | Builder attestation post-update |
