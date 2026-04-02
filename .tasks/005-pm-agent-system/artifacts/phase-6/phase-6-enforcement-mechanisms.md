---
artifact: phase-6-enforcement-mechanisms
task: 005-pm-agent-system
phase: 6
created: 2026-03-18
status: complete
checkpoint: CP-6.6
sources:
  - agents-personal/docs/architecture/ADR-001-orchestration-and-subagents.md
  - agents-personal/docs/architecture/ADR-007-rationalization-prevention.md
  - agents-personal/templates/README.md (disallowedTools convention)
  - agents-personal/scripts/generate.js (generation validation reference)
  - phase-5-orchestration-routing-matrix.md (Layer 3 reference)
  - phase-6-permission-tier-definitions.md (tier canonical properties)
  - VIP/learning_base/ideas/pm_agent_coordination_system_implementation_plan.md Section 11.1, 11.2
---

# Phase 6 Artifact: Enforcement Mechanism Specification

## Purpose

This document defines the three enforcement layers that prevent agents from exceeding their declared permission tiers. Each layer targets a different point in the agent lifecycle — template authoring, template generation, and runtime operation. Together they form a defense-in-depth governance model.

**REQ-608, REQ-609, REQ-610** govern the requirements for each layer. All three layers must be operational before any new agent template is deployed to `agents-personal/generated/`.

---

## Enforcement Layer Overview

| Layer | Enforcement Point | When Active | Primary REQ |
| --- | --- | --- | --- |
| **Layer 1: Template-Level** | `disallowedTools:` frontmatter array | At every agent invocation (runtime IDE enforcement) | REQ-608 |
| **Layer 2: Generation-Time** | `generate.js` + `install.sh` validation | During template compilation (build time) | REQ-609 |
| **Layer 3: Runtime Checkpoint** | ProjectManager orchestration routing matrix | During active workflow execution | REQ-610 |

---

## Layer 1: Template-Level Enforcement (Frontmatter `disallowedTools`)

### Mechanism Description

Every agent template includes a `disallowedTools:` array in the YAML frontmatter. When the agent is invoked in Copilot or CC, the IDE framework reads the frontmatter and prevents the listed tools from being called during the agent's execution context.

| Property | Detail |
| --- | --- |
| **Trigger condition** | Agent is invoked; agent body or reasoning attempts to call a disallowed tool |
| **Enforcement action** | IDE (Copilot or CC) intercepts the tool call and blocks it before execution |
| **Failure mode** | Agent attempts a prohibited tool call → IDE returns an error or silent refusal (IDE-dependent) |
| **Recovery path** | Agent must not retry the same prohibited call. Template body should include a rationalization-prevention note instructing the agent to escalate instead (see behavioral enforcement below) |
| **Limitation** | Tool exclusion covers tool invocation only. It does not prevent an agent from producing text that describes how to invoke a tool, or reasoning about what a tool would do. Template body guidance is required as a second control layer. |

### Namespace Rules

Copilot and CC have different tool identifier namespaces (ADR-005). Both must be declared in the same template using the platform-keyed frontmatter structure from `agents-personal/templates/README.md`:

```yaml
copilot:
  tools: [...]
  disallowedTools: [...]
cc:
  tools: [...]
  disallowedTools: [...]
```

See `phase-6-tooling-boundary-matrix.md` for exact tool identifier strings per agent per platform.

### Behavioral Enforcement (Template Body Complement)

Frontmatter alone does not prevent reasoning-level violations. Every agent template body must include a `## Permission Boundaries` section with explicit behavioral rules:

| Requirement | Template Body Statement |
| --- | --- |
| For Tier R and Tier O agents | "You may NOT edit any file. If asked, decline and escalate to ProjectManager." |
| For Tier R agents | "You may NOT run any command. All execution routes to Builder/Worker." |
| For QAEngineer (Tier RE) | "Terminal access is granted for test execution only. Permitted: `pytest`, `jest`, `npm test`, `dotnet test`. All other terminal commands are prohibited." |
| For UIUXDesigner (Tier RW-D) | "Write scope is `diagrams/` and `images/diagrams/` ONLY. Do not write to any other path. Execute only `mmdc` or `render_mermaid_diagrams.ps1` via `execute/runInTerminal`." |
| For Tier W agents | "You may write files within your designated write paths. You may NOT execute terminal commands or shell scripts." |
| For Worker (Tier F) | "Execute only the specific conversion command requested in the invocation instruction. Do not initiate writes to Tier W–owned paths without an explicit invocation instruction referencing the target path and conversion task." |
| For all agents | "All cross-specialist coordination routes through ProjectManager only. You may NOT invoke peer specialist agents directly." |

### Agent Self-Reporting

Template body must include a rationalization-prevention note (ADR-007) for agents with execute or write access. Example for QAEngineer:

> "If you are about to edit a source file to fix a failing test, STOP. Report the failure, describe the recommended fix, and escalate to ProjectManager for routing to the appropriate developer agent. Do not rationalize editing as 'just a minor fix.'"

---

## Layer 2: Generation-Time Enforcement (`generate.js` Validation)

### Mechanism Description

`agents-personal/scripts/generate.js` compiles all `.template.md` files in `templates/agents/` into platform-specific outputs under `generated/copilot/agents/` and `generated/claude/agents/`. Required frontmatter fields must be present or the build fails.

| Property | Detail |
| --- | --- |
| **Trigger condition** | `generate.js` is run (manually or via `make`) during template build |
| **Enforcement action** | Missing required frontmatter fields (e.g., `name`, `description`, `copilot:`) cause a build failure — template is not compiled to output |
| **Failure mode** | Build fails with a field-absent error. Template is not deployed. Builder must fix the template frontmatter before re-running. |
| **Recovery path** | Add missing frontmatter field; re-run `generate.js`; verify output in `generated/` |

### Required Frontmatter Fields (Build-Validated)

Per `agents-personal/templates/README.md` and Section 11.1 of the source plan:

| Field | Required | Validated by `generate.js` |
| --- | --- | --- |
| `name` | Yes | Yes — build failure if absent |
| `description` | Yes | Yes — build failure if absent |
| `copilot:` block | Yes (for Copilot output) | Yes — Copilot output skipped if absent |
| `cc:` block | Yes (for CC output) | Yes — CC output skipped if absent |
| `copilot.tools:` | Yes | Yes — Copilot agent without tools list is invalid |
| `copilot.disallowedTools:` | Conditionally required (required for all PM system agents) | **Not currently auto-validated** — see manual review gate below |
| `cc.disallowedTools:` | Conditionally required | **Not currently auto-validated** — see manual review gate below |

### `install.sh` New-Agent Registration

Per Section 11.1 of the source plan (lines 222–259), each new agent must be added to the `check_generated_files()` list in `install.sh`. The following agents require registration before deployment:

| Agent | Status | `install.sh` Action Required |
| --- | --- | --- |
| ProjectManager | New | Add `project-manager` to `check_generated_files()` |
| ProductOwner | New | Add `product-owner` to `check_generated_files()` |
| FrontendDev | New | Add `frontend-dev` to `check_generated_files()` |
| BackendDev | New | Add `backend-dev` to `check_generated_files()` |
| QAEngineer | New | Add `qa-engineer` to `check_generated_files()` |
| UIUXDesigner | New | Add `ui-ux-designer` to `check_generated_files()` |
| BusinessAnalyst | Existing | Already registered; validate `disallowedTools` alignment |
| ScrumMaster | Existing | Already registered; validate `disallowedTools` alignment |
| Worker | Existing | Already registered; validate conversion-context body constraint |

### Manual Review Gate (Governance Pre-Condition)

`generate.js` does **not** currently validate `disallowedTools` content. Before Builder runs `generate.js` to create any PM system agent template, a human reviewer must:

1. Open the compiled template in `generated/copilot/agents/` or `generated/claude/agents/`.
2. Verify `disallowedTools` against the Phase 6 tooling boundary matrix (`phase-6-tooling-boundary-matrix.md`).
3. Confirm no prohibited tool appears in the `tools:` allowed list.
4. Sign off in the relevant CP-6.x checkpoint before the template is considered approved.

This manual review gate is a **mandatory pre-condition** for Builder execution on any PM system agent template. It is not optional even when `generate.js` succeeds.

---

## Layer 3: Runtime Checkpoint Enforcement (PM Routing Matrix)

### Mechanism Description

All workflow requests route through the ProjectManager Entry Gate (ADR-001 conductor pattern). The PM routing matrix (Phase 5 `phase-5-orchestration-routing-matrix.md`) determines which agent handles each step. If an agent reports it "cannot perform X" due to its tier constraint, PM must reroute to a capable agent — it must never let a restricted agent attempt a disallowed action.

| Property | Detail |
| --- | --- |
| **Trigger condition** | A workflow step requires an action that is outside the currently assigned agent's permission tier |
| **Enforcement action** | PM routing matrix routes the step to the agent with the correct permission tier. The restricted agent does not attempt the action. |
| **Failure mode** | Out-of-permission artifact appears in `.tasks/` or `learning_base/` (e.g., a read-only advisory agent has produced a file write artifact) → PM checkpoint holds |
| **Recovery path** | PM surfaces a decision to the human reviewer: (1) accept artifact with explicit exception grant, (2) reject artifact and re-run with the correct agent, or (3) escalate to human for policy decision |
| **Limitation** | Layer 3 only detects violations that produce filesystem artifacts. Advisory agents producing text outputs that exceed their role cannot be reliably detected through checkpoint file checking. Layer 1 (frontmatter) and Layer 1 body (template instructions) remain the primary control for advisory-only agents. |

### Checkpoint Violation Detection Flow

```
Workflow step complete
       ↓
PM checkpoint evaluates output
       ↓
Is the output authored by the correct tier agent?
    YES → Checkpoint passes → Continue workflow
    NO  → Violation detected
           ↓
       PM holds workflow
           ↓
       Human decision required:
         Option A: Accept artifact (explicit exception documented)
         Option B: Reject artifact → re-run with correct agent
         Option C: Escalate to human for governance decision
```

### PM Routing Rules for Permission Enforcement

The following routing rules derive from the PM orchestration routing matrix (Phase 5). They represent the Layer 3 operational enforcement of per-tier permissions.

| Requested Action | Restricted Agent (Tier) | PM Routes To | Routing Rule |
| --- | --- | --- | --- |
| Write a requirements doc | FrontendDev (Tier R) | BusinessAnalyst (Tier W) | Read-only agents cannot produce documents; BA is the write-enabled specialist for requirements |
| Execute test suite | ProductOwner (Tier W) | QAEngineer (Tier RE) | Write-only agents cannot execute tests; QAEngineer is the sole test-execute tier agent |
| Render a Mermaid diagram | BusinessAnalyst (Tier W) | UIUXDesigner (Tier RW-D) | Diagram rendering is UIUXDesigner exclusive scope |
| Convert a file format | ScrumMaster (Tier W) | Worker (Tier F) | Format conversion requires Bash execution; Worker is the only full-execute agent |
| Write any file | ProjectManager (Tier O) | Appropriate Tier W or Tier F agent | PM is read-only; all file writes route to specialist agents |

### Checkpoint Evidence Requirements

For each PM-managed checkpoint (CP-A through CP-F, see Phase 5 comprehensive checkpoint table), the following evidence must be present to pass:

1. **Output file exists** at the declared target path.
2. **Output authorship** is attributed to the correct tier agent (via session log or handoff receipt).
3. **No disallowed tool invocation** was recorded during the step (observable from agent session log if available).
4. **Escalation path was followed** if a restriction was encountered (no silent bypass).

---

## Three-Layer Defense Summary

| Layer | Blocks At | Machine-Enforced | Human Review Required | Residual Risk |
| --- | --- | --- | --- | --- |
| Layer 1: Frontmatter | Tool invocation | ✅ Yes (IDE-level) | Template body review | Text-level reasoning violations not caught |
| Layer 2: Generation-time | Template build | ✅ Partially (required fields) | Manual `disallowedTools` review | `disallowedTools` not auto-validated |
| Layer 3: Runtime checkpoint | Workflow step output | ✅ Artifact presence check | Violation triage decision | Advisory-only violations not artifact-visible |

**Combined coverage:** All three layers must be in place. No single layer is sufficient to enforce the full permission governance model. Any deployed agent that bypasses Layer 2 manual review is considered ungoverned and must be quarantined pending a CP-6.x review decision.
