---
artifact: phase-3-source-traceability-matrix
task: 005-pm-agent-system
phase: 3
created: 2026-03-18
status: complete
sources:
  - agents-personal/templates/README.md
  - agents-personal/templates/agents/business-analyst.template.md
  - agents-personal/templates/agents/researcher.template.md
  - agents-personal/templates/agents/conductor.template.md
  - agents-personal/templates/agents/worker.template.md
  - agents-personal/docs/architecture/ADR-001-orchestration-and-subagents.md
  - agents-personal/docs/architecture/ADR-002-task-centric-persistence.md
  - agents-personal/docs/architecture/ADR-004-skill-powered-subagents.md
  - agents-personal/docs/architecture/ADR-005-ide-compatibility.md
  - agents-personal/docs/architecture/ADR-007-rationalization-prevention.md
  - .github/copilot-instructions.md
---

# Phase 3 Source Traceability Matrix

## Purpose

This document traces every normative design decision in Phase 3 artifacts back to its authoritative source in the agents-personal framework, ADR set, or 2026_01_VIP repository instructions. It satisfies REQ-305 (source traceability) and SC-306 (minimum coverage targets).

**Minimum coverage targets (from Phase 3 plan §Detailed File Changes — Step 4):**
- ✅ At least one row for each of the four specialists
- ✅ At least one row per permission tier (Tier R, Tier RE, Tier RW-D)
- ✅ At least one row for UIUXDesigner Mermaid lifecycle compliance
- ✅ At least one row per agents-personal ADR referenced

---

## Traceability Matrix

| # | Specialist Rule | Source Doc | Source Clause | Implementation Note | Verification Evidence |
|---|---|---|---|---|---|
| T3-001 | **FrontendDev Tier R: `disallowedTools: ["Bash", "Write", "Edit", "MultiEdit", "Task"]`** | `conductor.template.md` | Frontmatter `disallowedTools` pattern; machine-enforced write restriction | FrontendDev CC frontmatter sets all five disallowed tools; mirrors conductor's approach to guarantee orchestration-only scope | Grep for `disallowedTools.*Bash.*Write.*Edit` in `frontend-dev.template.md` |
| T3-002 | **BackendDev Tier R: same `disallowedTools` as FrontendDev** | `conductor.template.md` + ADR-002 | ADR-002 GUD-301: Tier R advisors produce advisory artifacts scoped to `.tasks/` only; inability to write source files is machine-enforced | BackendDev CC frontmatter identical to FrontendDev. ADR-002 cited as governing convention (GUD-301) | Grep for `disallowedTools` in `backend-dev.template.md` |
| T3-003 | **Permission Tier R: read-only with `disallowedTools` following conductor pattern** | `conductor.template.md`; ADR-001 §Conductor Agent Pattern | Conductor establishes the canonical `disallowedTools` enforcement for non-executing coordinating agents; Tier R advisors adopt this boundary | Tier R designation maps to conductor `disallowedTools` in phase-3-handoff-permission-matrix.md Permission Matrix | Confirm FrontendDev and BackendDev `disallowedTools` arrays are identical to each other and include all five tools |
| T3-004 | **Permission Tier RE: QAEngineer reads and executes tests but cannot edit files** | `worker.template.md` §Capabilities (Bash = full terminal); ADR-001 §Agent Capabilities Table | Worker is the only agent with both Bash and Edit; QAEngineer splits this: Bash kept (test execution), Edit/Write disallowed (no source modification). This is a new tier derived from Worker by removing write-capable tools | QAEngineer `disallowedTools: ["Write", "Edit", "MultiEdit", "Task"]`; `Bash` retained in tools list | Grep for `disallowedTools` in `qa-engineer.template.md`; confirm `Bash` present in tools, absent from disallowedTools |
| T3-005 | **QAEngineer: rationalization-prevention clause — MUST NOT edit test files, even for "minor fixes"** | ADR-007 §Rationalization Prevention | ADR-007 establishes that agents MUST NOT rationalize exceeding their permission tier. QAEngineer's Bash access creates an opening for rationalizing "quick test fixes." Explicit instruction-enforced rule prevents this. | "Rationalization-prevention rule (ADR-007)" block included in QAEngineer `## Permission Boundaries` section | Check QAEngineer template body for "ADR-007" and "rationalization" keywords |
| T3-006 | **Permission Tier RW-D: UIUXDesigner has `Write`/`Edit` in CC tools but `Bash`/`Task`/`MultiEdit` in disallowedTools** | `business-analyst.template.md` frontmatter `cc.tools` (Write, Edit) + `disallowedTools: [Bash]`; Phase 3 plan §Step 2 UIUXDesigner `disallowedTools` evidence note | UIUXDesigner inherits write-capable tool scope from BusinessAnalyst (Write + Edit in CC), but adds Bash to disallowedTools and explicitly prohibits Task and MultiEdit for diagram scope control | UIUXDesigner CC frontmatter: `tools: ["Read", "LS", "Glob", "Grep", "Write", "Edit", "WebSearch", "TodoRead", "TodoWrite"]`; `disallowedTools: ["Bash", "Task", "MultiEdit"]` | Grep for UIUXDesigner frontmatter stubs in phase-3-template-skeletons.md; confirm three entries in disallowedTools |
| T3-007 | **UIUXDesigner write scope restriction to `diagrams/` and `images/diagrams/` is instruction-enforced (not machine-enforced at path level)** | Phase 3 plan §Step 2 evidence note; ADR-005 §IDE compatibility | CC frontmatter does not provide path-granular tool scoping. Path restriction must be implemented as a runtime instruction in `## Permission Boundaries`. This limitation is acknowledged and documented. | UIUXDesigner template body `## Permission Boundaries` section explicitly states write scope; phase-3-handoff-permission-matrix.md §Instruction-Enforced Boundaries table documents this | Confirm `## Permission Boundaries` in UIUXDesigner template body cites `diagrams/` and `images/diagrams/` paths |
| T3-008 | **UIUXDesigner Mermaid diagram lifecycle: Step 1 — save `.mmd` source to `images/diagrams/NN_short_description.mmd`** | `.github/copilot-instructions.md` §Step 1 | "Save the raw Mermaid source as a `.mmd` file in `images/diagrams/` using a descriptive `snake_case` name" with zero-padded `NN` sequence number | UIUXDesigner template body `## Diagram Lifecycle Compliance — Step 1` section enumerates exact path, naming convention, and example | Search UIUXDesigner template for `Step 1` and `images/diagrams/NN_short_description.mmd` |
| T3-009 | **UIUXDesigner Mermaid diagram lifecycle: Step 2 — instruct user to run `scripts/render_mermaid_diagrams.ps1`** | `.github/copilot-instructions.md` §Step 2 — Run the render script | "After saving the `.mmd` file, run `scripts/render_mermaid_diagrams.ps1`." UIUXDesigner cannot self-execute (`Bash` machine-disallowed) — instructs user instead. | UIUXDesigner template body `## Diagram Lifecycle Compliance — Step 2` provides PowerShell command; notes "You MUST NOT execute this yourself" | Search UIUXDesigner template for `render_mermaid_diagrams.ps1` and "MUST NOT execute" |
| T3-010 | **UIUXDesigner Mermaid diagram lifecycle: Step 3 — insert image reference `![Figure N — Description](../../images/diagrams/NN_short_description.png)`** | `.github/copilot-instructions.md` §Step 3 — Insert the image | "Replace the mermaid code block or add an image reference immediately after it" using `![Figure N — Description](../../images/diagrams/NN_short_description.png)` | UIUXDesigner template body `## Diagram Lifecycle Compliance — Step 3` provides exact Markdown image syntax and example | Search UIUXDesigner template for `Step 3` and `![Figure` |
| T3-011 | **UIUXDesigner Mermaid diagram lifecycle: Step 4 — verify `diagram_manifest.json` updated** | `.github/copilot-instructions.md` §Step 4 — Update `diagram_manifest.json` | "The manifest at `images/diagrams/diagram_manifest.json` is auto-updated by `render_mermaid_diagrams.ps1`. Verify the new diagram appears in it after rendering." | UIUXDesigner template body `## Diagram Lifecycle Compliance — Step 4`; output contract includes `manifest_status: VERIFIED / PENDING` | Search UIUXDesigner template for `Step 4` and `diagram_manifest.json` |
| T3-012 | **All four specialists: `user-invokable: true` in Copilot frontmatter** | `business-analyst.template.md` frontmatter `copilot.user-invokable: true`; Phase 1 reuse map §PM System Reuse table row "user-invokable: true" | Specialist advisors follow BusinessAnalyst pattern: user-invokable true (direct-invoke agents) AND orchestrator-invokable (subagent). Contrast Worker which uses `user-invokable: false`. | All four template skeletons set `user-invokable: true` in Copilot block | Grep for `user-invokable: true` in phase-3-template-skeletons.md |
| T3-013 | **FrontendDev, BackendDev, QAEngineer: `model: sonnet` (Copilot) / `claude-sonnet-4-5` (CC)** | `worker.template.md` `cc.model: sonnet` (speed-optimized); templates README §E5 platform-specific model names | Sonnet is speed/cost appropriate for advisory and test-execution agents. Opus is reserved for write-capable agents with complex multi-step tasks (UIUXDesigner). | Copilot: `model: sonnet`; CC: `model: claude-sonnet-4-5` in FrontendDev, BackendDev, QAEngineer skeletons | Grep for `model: sonnet` in three skeletons; `model: claude-sonnet-4-5` in cc blocks |
| T3-014 | **UIUXDesigner: `model: opus` (Copilot) / `claude-opus-4-5` (CC)** | `business-analyst.template.md` `model: opus`; Phase 1 reuse map "opus model for write-capable agents" | UIUXDesigner is write-capable (Tier RW-D) and performs complex multi-step diagram lifecycle. Opus matches BusinessAnalyst pattern for write-capable agents. | Copilot: `model: opus`; CC: `model: claude-opus-4-5` in UIUXDesigner skeleton | Grep for `model: opus` in UIUXDesigner skeleton |
| T3-015 | **All four specialists: single escalation route → ProjectManager** | ADR-001 §Conductor Agent Pattern (PM is checkpoint and routing authority); REQ-302 (exactly one escalation path per specialist) | Centralizing escalation through ProjectManager prevents specialist-to-specialist authority confusion and maintains the orchestration model where PM is the sole decision-routing agent. | Each specialist `## Escalation Path` section states "Single escalation route: → ProjectManager" | Grep for "escalation route" in phase-3-specialist-agent-specs.md; confirm one entry per specialist |
| T3-016 | **All four specialists: no peer-to-peer specialist invocation** | ADR-001 §Scope Enforcement via `agents:` restriction; §Worker Subagent Pattern | The scope restriction model in ADR-001 prohibits agents from invoking unauthorized peers. Specialists have no `agents:` field in their frontmatter because they do not invoke other specialists; all cross-specialist routing goes through ProjectManager. | "Disallowed Invocation Contexts" section in each specialist's invocation patterns block | Grep for "Disallowed Invocation" in phase-3-specialist-agent-specs.md |
| T3-017 | **Subagent invocation pattern for specialists (ADR-004 keyword structure)** | ADR-004 §Subagent Prompt Structure | "Run the [Agent] agent as a subagent: [skill trigger phrase]. [Specific instructions]. Return: [expected format]." | Each specialist "Invocation Patterns" section includes ADR-004 canonical subagent invocation example with `Run the [Agent] agent as a subagent:` prefix | Grep for "Run the.*agent as a subagent" in phase-3-specialist-agent-specs.md |
| T3-018 | **Template skeleton format: `name`, `description`, `copilot:` block, `cc:` block per templates README** | `agents-personal/templates/README.md` §Agent Template Frontmatter | "Shared metadata: `name`, `description`; Copilot-specific: `copilot:` block with `tools`, `model`, `user-invokable`, `handoffs`; CC-specific: `cc:` block with `tools`, `disallowedTools`, `model`, `skills`" | All four template skeletons in phase-3-template-skeletons.md include all required frontmatter blocks | Verify each skeleton in phase-3-template-skeletons.md for presence of `name:`, `description:`, `copilot:`, `cc:` keys |
| T3-019 | **Platform-specific body directives: `<!-- COPILOT-ONLY -->` and `<!-- CC-ONLY -->` for invocation instruction sections** | `agents-personal/templates/README.md` §Body Content Directives; ADR-005 §IDE Compatibility | "Directives mark platform-specific content. Content before any directive is SHARED." Invocation instruction formats differ between platforms (Copilot: `@AgentName`; CC: `use AgentName`), requiring platform-specific sections. | Platform-specific invocation instructions in template skeletons use `<!-- COPILOT-ONLY -->` / `<!-- /COPILOT-ONLY -->` and `<!-- CC-ONLY -->` / `<!-- /CC-ONLY -->` directives | Grep for `COPILOT-ONLY` and `CC-ONLY` in phase-3-template-skeletons.md |
| T3-020 | **FrontendDev CC skills: `[architecture, deep-research, critic]`** | ADR-004 §Skill Semantics; Phase 3 plan §Detailed File Changes — Step 2 skill assignments | Architecture for component pattern analysis; deep-research for standards investigation; critic for advisory quality review. All three are read-only skills consistent with Tier R permission. | FrontendDev `cc.skills: [architecture, deep-research, critic]` in template skeleton | Grep for `skills.*architecture.*deep-research.*critic` in frontend-dev skeleton |
| T3-021 | **BackendDev CC skills: `[architecture, deep-research, security-review]`** | ADR-004 §Skill Semantics; Phase 3 plan §Detailed File Changes — Step 2 | Architecture for system design; deep-research for API standard research; security-review for boundary advisory. No write-capable skills assigned (RISK-306 mitigation: all assigned skills are read-only). | BackendDev `cc.skills: [architecture, deep-research, security-review]` | Grep for `skills.*architecture.*deep-research.*security-review` in backend-dev skeleton |
| T3-022 | **QAEngineer CC skills: `[testing, debug, critic]`** | ADR-004 §Skill Semantics; Phase 3 plan §Detailed File Changes — Step 2 | Testing for test plan generation; debug for test failure analysis; critic for coverage gap assessment. All consistent with Tier RE (read + test execute). | QAEngineer `cc.skills: [testing, debug, critic]` | Grep for `skills.*testing.*debug.*critic` in qa-engineer skeleton |
| T3-023 | **UIUXDesigner CC skills: `[architecture, design]`** | ADR-004 §Skill Semantics; Phase 3 plan §Detailed File Changes — Step 2 | Architecture for system flow diagram creation; design for UX/wireframe generation. Both are consistent with Tier RW-D (read + diagram write). | UIUXDesigner `cc.skills: [architecture, design]` | Grep for `skills.*architecture.*design` in uiux-designer skeleton |
| T3-024 | **Task-centric persistence: advisory outputs save to `.tasks/005-pm-agent-system/advisory/`** | ADR-002 §Task-Centric Persistence; GUD-301 | ADR-002 establishes that all agent outputs are organized under the task directory rather than scattered across the repository. Advisory notes are task artifacts and belong in `.tasks/`. | Output contract tables for FrontendDev and BackendDev specify `.tasks/005-pm-agent-system/advisory/` as save location | Grep for `advisory/` in phase-3-specialist-agent-specs.md output contract sections |
| T3-025 | **Four-step workflow pattern for agents (Read → Analyze/Execute → Advise/Report → Escalate)** | `business-analyst.template.md` Workflow section (Step 1 Understand → Step 2 Apply Skill → Step 3 Write → Step 4 Save); Phase 1 reuse map "Step-based workflow: Reuse as-is" | BusinessAnalyst's four-step workflow is adapted for specialist agents. Pattern is retained; step names are adapted to role (advisors: Analyze instead of Apply Skill; QAEngineer: Execute instead of Write). | Each specialist template body includes a `## Workflow` section with four named steps | Grep for `## Workflow` in phase-3-template-skeletons.md; confirm four steps per specialist |
| T3-026 | **Handoff buttons in Copilot frontmatter: at least one per agent pointing to ProjectManager** | `business-analyst.template.md` `copilot.handoffs`; templates README §E3 Agents Referencing Other Agents | Handoffs are Copilot-only (live under `copilot:`). CC uses return escalation via instruction. BusinessAnalyst pattern reused: each agent has at least one handoff pointing to next-step agent. | All four template skeletons include `handoffs:` block with "Return to ProjectManager" entry | Grep for `handoffs:` in phase-3-template-skeletons.md |
| T3-027 | **HTP-VIP domain context block: domain entities in project context section** | `business-analyst.template.md` §Core Domain Language; Phase 1 reuse map "HTP-VIP domain language: Reuse as-is" | BusinessAnalyst already embeds HTP-VIP domain terminology. Specialist templates adopt the same pattern with domain entities relevant to each role (Trial, Plot, Germplasm for all; component names for FE; API endpoints for BE). | Each template skeleton `## Project Context` section names relevant HTP-VIP domain entities | Grep for domain terms (Trial, Plot, Germplasm) in phase-3-template-skeletons.md |

---

## Coverage Summary

### By Specialist

| Specialist | Rows Covering This Agent | Row IDs |
|---|---|---|
| FrontendDev | 5 | T3-001, T3-003, T3-012, T3-013, T3-015, T3-016, T3-017, T3-020, T3-024, T3-025, T3-026, T3-027 |
| BackendDev | 5 | T3-002, T3-003, T3-012, T3-013, T3-015, T3-016, T3-017, T3-021, T3-024, T3-025, T3-026, T3-027 |
| QAEngineer | 5 | T3-004, T3-005, T3-012, T3-013, T3-015, T3-016, T3-017, T3-022, T3-025, T3-026, T3-027 |
| UIUXDesigner | 5+ | T3-006, T3-007, T3-008, T3-009, T3-010, T3-011, T3-012, T3-014, T3-015, T3-016, T3-017, T3-023, T3-025, T3-026, T3-027 |

### By Permission Tier

| Tier | Rows | Row IDs |
|---|---|---|
| Tier R (read-only) | T3-001, T3-002, T3-003 | Three rows establishing Tier R tool scope and conductor pattern adoption |
| Tier RE (read + test execute) | T3-004, T3-005 | Two rows: QAEngineer tool split, ADR-007 rationalization prevention |
| Tier RW-D (read + diagram write) | T3-006, T3-007, T3-008, T3-009, T3-010, T3-011 | Six rows: UIUXDesigner write scope and complete four-step Mermaid lifecycle |

### By ADR Coverage

| ADR | Row IDs | Rule Covered |
|---|---|---|
| ADR-001 | T3-003, T3-004, T3-015, T3-016, T3-017 | Orchestration scope, agent capability table, escalation routing, subagent invocation |
| ADR-002 | T3-002, T3-024 | Task-centric persistence, advisory output paths |
| ADR-004 | T3-017, T3-020, T3-021, T3-022, T3-023 | Subagent prompt structure, skill semantics |
| ADR-005 | T3-007, T3-019 | Path-restriction instruction enforcement, platform-specific body directives |
| ADR-007 | T3-005 | Rationalization prevention for QAEngineer terminal access |

### UIUXDesigner Mermaid Lifecycle Compliance

| Lifecycle Step | Row | Compliance Statement |
|---|---|---|
| Step 1 — Save `.mmd` source | T3-008 | `images/diagrams/NN_short_description.mmd` naming; zero-padded sequence number |
| Step 2 — Run render script | T3-009 | `scripts/render_mermaid_diagrams.ps1`; UIUXDesigner instructs user, does not self-execute |
| Step 3 — Insert image reference | T3-010 | `![Figure N — Description](../../images/diagrams/NN_short_description.png)` syntax |
| Step 4 — Verify manifest | T3-011 | `images/diagrams/diagram_manifest.json` auto-updated; agent confirms or marks PENDING |
