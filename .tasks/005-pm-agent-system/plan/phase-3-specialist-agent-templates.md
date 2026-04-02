---
goal: Phase 3 - Specialist Agent Templates
phase: 3
date_created: 2026-03-18
last_updated: 2026-03-18
owner: Explorer
status: Planned
tags: [planning, specialist-agents, permissions, handoffs, diagram-lifecycle, governance]
---

# Phase 3 Plan: Specialist Agent Templates

## Goal

Define implementation-ready template specifications for four specialist agents — FrontendDev, BackendDev, QAEngineer, and UIUXDesigner — with explicit role charters, non-overlapping permission tiers, precise tool scopes, and handoff contracts that integrate cleanly into the PM agent orchestration system.

## Scope

- In scope:
  - Role charter for each of the four specialists: purpose, primary responsibility, non-goals.
  - Tool scope specification (Copilot frontmatter and CC frontmatter) for each specialist.
  - Permission tier assignment: read-only advisory, read + test execute, limited write + diagram generate.
  - Output contract per specialist: what artifacts each produces, where outputs land in `2026_01_VIP`.
  - Invocation patterns: user-invokable vs subagent-invoked, trigger phrase catalogue, escalation path.
  - Handoff contracts: upstream callers, downstream consumers, checkpoint interaction.
  - Template skeleton specification per `agents-personal/templates/README.md` generation rules.
  - Permission and handoff matrix consolidating all four roles.
  - Source traceability matrix following Phase 2's required column set.
  - UIUXDesigner diagram lifecycle compliance verification against `.github/copilot-instructions.md` Mermaid workflow.
  - Creation of all Phase 3 artifacts under `.tasks/005-pm-agent-system/`.
  - Update of `task.md` Phase 3 row to `📋 Planned`.

- Out of scope:
  - Creating or editing specialist agent templates in `C:/Users/s1058662/repos/agents-personal/templates/agents/`.
  - Running `make`, `install.sh`, or any template-generation workflow.
  - Modifying any file outside `.tasks/005-pm-agent-system/` in `2026_01_VIP` or `agents-personal`.
  - Phase 4 ProductOwner design or Phase 6 full permission governance — those are independent phases.

---

## Checkpoints (Plan-Only Governance)

| Checkpoint | Owner | Required Evidence | Decision Options |
| --- | --- | --- | --- |
| CP-3.1 Specialist Role Coverage | Explorer | Four-specialist role charter table with primary responsibility, non-goals, and output contract per specialist — confirming zero overlap | Proceed, Rework, Defer |
| CP-3.2 Permission Tier Review | Reviewer (human) | Permission matrix artifact at `.tasks/005-pm-agent-system/artifacts/phase-3/phase-3-handoff-permission-matrix.md` with explicit tool inclusion and exclusion per platform per agent | Approve, Request Changes |
| CP-3.3 Diagram Isolation Compliance | Reviewer (human) | UIUXDesigner template spec cites all four steps from `.github/copilot-instructions.md` Mermaid lifecycle: `.mmd` save, `render_mermaid_diagrams.ps1` execution, document image insertion, `diagram_manifest.json` update | Approve, Request Changes |
| CP-3.4 Template Generation Readiness | Explorer + Reviewer | Skeleton specs for all four agents include required frontmatter blocks (shared, copilot, cc) that conform to `agents-personal/templates/README.md` agent template format. **Direct evidence:** inline frontmatter stubs for all four specialists are embedded in the "Inline Frontmatter Stubs (CP-3.4 Evidence)" section of this plan file, with UIUXDesigner `disallowedTools` explicitly named. | Approve, Request Changes |
| CP-3.5 Source Alignment and Plan-Only Boundary check | Explorer + Reviewer | Traceability matrix complete with minimum required columns; all Phase 3 file create/update targets verified as `.tasks/005-pm-agent-system/**` only | Approve, Request Changes, Defer |

---

## Status Governance (Plan-Only Mode)

- `📋 Planned` is set when this phase plan is created and linked from `task.md`.
- `⭐ Reviewed` is set by the reviewer after CP-3.2, CP-3.3, and CP-3.4 evidence is accepted.
- `✅ Done` is reserved for Builder execution plus verification evidence; Explorer does not set this for unexecuted implementation work.

---

## Requirements and Constraints

- REQ-301: Define exactly four specialist agents matching Phase 3 scope: FrontendDev, BackendDev, QAEngineer, UIUXDesigner.
- REQ-302: Each specialist specification must include role charter, permission tier, Copilot tool scope, CC tool scope, typical invocation patterns, output contract, and exactly one escalation path.
- REQ-303: Permission tiers must be strictly tiered and non-overlapping in practice:
  - Tier R (read-only): FrontendDev, BackendDev.
  - Tier RE (read + test execute): QAEngineer.
  - Tier RW-D (read + limited write to diagram paths only): UIUXDesigner.
- REQ-304: UIUXDesigner template spec must enumerate all four steps of the Mermaid diagram lifecycle from `.github/copilot-instructions.md` (Step 1: save `.mmd` source; Step 2: run render script; Step 3: insert image into document; Step 4: verify `diagram_manifest.json` update).
- REQ-305: Template skeletons must conform to the `agents-personal/templates/README.md` agent template frontmatter format with correct `name`, `description`, `copilot:` block, and `cc:` block.
- REQ-306: Handoff contracts must explicitly state: which upstream agent may invoke each specialist, expected input summary, expected output shape, and checkpoint pause expectation.
- REQ-307: Role charters must establish non-overlapping responsibilities using a comparison table to prevent scope ambiguity, especially for FrontendDev vs BackendDev and UIUXDesigner vs QAEngineer.
- CON-301: This phase is planning-only; no production template files are created or edited.
- CON-302: All writes are restricted to `.tasks/005-pm-agent-system/**`.
- CON-303: UIUXDesigner write scope behavioral constraint covers `diagrams/`, `images/diagrams/`, and `.github/copilot-instructions.md` cross-reference only — no write access to `docs/`, `specs/`, or `learning_base/` is prescribed.
- GUD-301: Follow task-centric persistence conventions from ADR-002.
- GUD-302: Enforce subagent and orchestration constraints and scope control from ADR-001.
- GUD-303: Maintain skill-powered delegation semantics from ADR-004 for any skill references.
- GUD-304: Maintain IDE compatibility rules from ADR-005.
- GUD-305: Include rationalization-prevention evidence expectations from ADR-007 in verification section.

---

## Source Guidelines to Incorporate (agents-personal)

Mandatory source set for this phase. All specialist design decisions must be traceable to at least one of these:

- `C:/Users/s1058662/repos/agents-personal/README.md`
- `C:/Users/s1058662/repos/agents-personal/templates/README.md`
- `C:/Users/s1058662/repos/agents-personal/templates/agents/business-analyst.template.md` — role-agent baseline (user-invokable, write-enabled, handoff pattern)
- `C:/Users/s1058662/repos/agents-personal/templates/agents/conductor.template.md` — orchestration-only and `disallowedTools` pattern
- `C:/Users/s1058662/repos/agents-personal/templates/agents/researcher.template.md` — read-only subagent baseline
- `C:/Users/s1058662/repos/agents-personal/templates/agents/worker.template.md` — full-access subagent baseline
- `C:/Users/s1058662/repos/agents-personal/docs/architecture/ADR-001-orchestration-and-subagents.md`
- `C:/Users/s1058662/repos/agents-personal/docs/architecture/ADR-002-task-centric-persistence.md`
- `C:/Users/s1058662/repos/agents-personal/docs/architecture/ADR-004-skill-powered-subagents.md`
- `C:/Users/s1058662/repos/agents-personal/docs/architecture/ADR-005-ide-compatibility.md`
- `C:/Users/s1058662/repos/agents-personal/docs/architecture/ADR-007-rationalization-prevention.md`
- `.github/copilot-instructions.md` — Mermaid diagram lifecycle compliance source for UIUXDesigner

---

## Role Charter Summary (Research Finding)

The four specialists serve distinct functions in the PM system. The table below records the non-overlapping charter boundary confirmed during research:

| Specialist | Permission Tier | Primary Responsibility | Explicitly NOT Responsible For | Escalation Path |
| --- | --- | --- | --- | --- |
| FrontendDev | Tier R (read-only) | Advisory on UI/frontend technology, component patterns, accessibility, and browser compatibility | Editing code, running builds, backend/API design, diagram generation | → ProjectManager |
| BackendDev | Tier R (read-only) | Advisory on server-side architecture, API design, data pipelines, and cloud infrastructure | Editing code, running commands, frontend/UI design, diagram generation | → ProjectManager |
| QAEngineer | Tier RE (read + test execute) | Test planning, coverage gap analysis, test execution, and quality gate assessment | Editing source files, generating design artifacts, sprint planning | → ProjectManager |
| UIUXDesigner | Tier RW-D (read + diagram write) | UX/UI design guidance, wireframe description, Mermaid and draw.io lifecycle management, and visual artifact generation | Backend advisory, test execution, backlog management, requirements cascade | → ProjectManager (transitions to ProductOwner as primary when Phase 4 is active) |

**Disambiguation rules:**
- When frontend architectural advice is needed → FrontendDev.
- When backend or infrastructure advisory is needed → BackendDev.
- When quality assurance evidence or test execution is needed → QAEngineer.
- When a diagram or visual artifact must be created or updated → UIUXDesigner (diagram-generation skill).
- FrontendDev and BackendDev never produce file edits; they produce advisory recommendations that Builder or Worker execute.
- UIUXDesigner write scope is scoped to diagram paths only; UIUXDesigner does not write `docs/`, `specs/`, or `learning_base/` content.

---

## Inline Frontmatter Stubs (CP-3.4 Evidence)

Each stub below is a one-row representative skeleton showing the required `shared`, `copilot:`, and `cc:` frontmatter blocks per specialist, conforming to `agents-personal/templates/README.md`. These are embedded here as direct CP-3.4 evidence that all four skeleton specs include the required blocks before Builder generates the full template files. Full body sections (`## Role`, `## Project Context`, `## Permission Boundaries`, `## Invocation Patterns`) are specified as content descriptions in Detailed File Changes — Step 2.

### FrontendDev

```yaml
---
name: FrontendDev
description: >
  Tier R read-only advisor for UI/frontend technology, component patterns,
  accessibility, and browser compatibility. Trigger phrases: "use FrontendDev",
  "frontend advisory", "UI component review", "accessibility guidance",
  "browser compatibility check".
copilot:
  tools: ["read/readFile", "search/semanticSearch", "search/textSearch", "workspace/fileSearch"]
  model: sonnet
  user-invokable: true
  handoffs:
    - label: Return to ProjectManager
      agent: ProjectManager
cc:
  tools: ["Read", "LS", "Glob", "Grep", "WebSearch"]
  disallowedTools: ["Bash", "Write", "Edit", "MultiEdit", "Task"]
  model: claude-sonnet-4-5
  skills: [architecture, deep-research, critic]
---
```

### BackendDev

```yaml
---
name: BackendDev
description: >
  Tier R read-only advisor for server-side architecture, API design, data
  pipelines, and cloud infrastructure. Trigger phrases: "use BackendDev",
  "backend advisory", "API design review", "infrastructure advice",
  "data pipeline guidance".
copilot:
  tools: ["read/readFile", "search/semanticSearch", "search/textSearch", "workspace/fileSearch"]
  model: sonnet
  user-invokable: true
  handoffs:
    - label: Return to ProjectManager
      agent: ProjectManager
cc:
  tools: ["Read", "LS", "Glob", "Grep", "WebSearch"]
  disallowedTools: ["Bash", "Write", "Edit", "MultiEdit", "Task"]
  model: claude-sonnet-4-5
  skills: [architecture, deep-research, security-review]
---
```

### QAEngineer

```yaml
---
name: QAEngineer
description: >
  Tier RE specialist for test planning, coverage gap analysis, test execution,
  and quality gate assessment. Trigger phrases: "use QAEngineer", "test review",
  "coverage analysis", "run quality gates", "QA assessment", "test coverage report".
copilot:
  tools: ["read/readFile", "search/semanticSearch", "search/textSearch", "workspace/fileSearch", "terminal/runInTerminal"]
  model: sonnet
  user-invokable: true
  handoffs:
    - label: Return to ProjectManager
      agent: ProjectManager
cc:
  tools: ["Read", "LS", "Glob", "Grep", "Bash", "WebSearch", "TodoRead", "TodoWrite"]
  disallowedTools: ["Write", "Edit", "MultiEdit", "Task"]
  model: claude-sonnet-4-5
  skills: [testing, debug, critic]
---
```

### UIUXDesigner

```yaml
---
name: UIUXDesigner
description: >
  Tier RW-D specialist for UX/UI design guidance, wireframe description, Mermaid
  and draw.io diagram lifecycle management, and visual artifact generation. Write
  scope restricted to diagrams/ and images/diagrams/ paths only. Trigger phrases:
  "use UIUXDesigner", "design review", "update diagram", "create wireframe",
  "diagram lifecycle", "UX guidance".
copilot:
  tools: ["read/readFile", "search/semanticSearch", "workspace/fileSearch", "workspace/createFile", "workspace/editFile"]
  model: opus
  user-invokable: true
  handoffs:
    - label: Return to ProjectManager
      agent: ProjectManager
cc:
  tools: ["Read", "LS", "Glob", "Grep", "Write", "Edit", "WebSearch", "TodoRead", "TodoWrite"]
  disallowedTools: ["Bash", "Task", "MultiEdit"]
  model: claude-opus-4-5
  skills: [architecture, design]
---
```

> **UIUXDesigner write boundary enforcement note:** `Bash` and `Task` are machine-disallowed, preventing shell execution (no self-invocation of `render_mermaid_diagrams.ps1`) and subagent spawning. `MultiEdit` is disallowed to prevent bulk path-agnostic edits. Path-level restriction to `diagrams/` and `images/diagrams/` is **instruction-enforced** via the `## Permission Boundaries` body section — CC frontmatter does not provide path-granular tool scoping, so this boundary is policy-level rather than tool-level.

---

## Detailed File Changes (Phase 3 Deliverables)

All writes in this phase are limited to `.tasks/005-pm-agent-system/`.

### 1. Create `.tasks/005-pm-agent-system/artifacts/phase-3/phase-3-specialist-agent-specs.md`

Content:
- One top-level section per specialist (FrontendDev, BackendDev, QAEngineer, UIUXDesigner).
- Per-specialist subsections:
  - **Role Charter**: one-paragraph statement of purpose, primary responsibilities, and explicit non-goals to scope the agent at runtime.
  - **Permission Tier**: named tier with explicit tool inclusion and exclusion list for both Copilot and CC.
  - **Trigger Phrase Catalogue**: minimum five trigger phrases for user description field activation per specialist.
  - **Invocation Patterns**: (a) direct user invocation; (b) subagent invocation by ProjectManager/ProductOwner with required keyword structure (following ADR-004 pattern); (c) disallowed invocation contexts.
  - **Output Contract**: artifact types produced, expected save location within `2026_01_VIP`, required metadata keys.
  - **Escalation Path**: exactly one escalation route per specialist (aligns with CP-3.1 non-overlap requirement).
  - **Canonical Invocation Examples**: one Copilot example and one CC example per specialist, stating allowed caller role, disallowed caller role, and expected checkpoint pause behaviour.
- Cross-specialist overlap table restating the role charter summary with conflict resolution priority.
- UIUXDesigner subsection must include a dedicated **Diagram Lifecycle Compliance** block enumerating all four `.github/copilot-instructions.md` steps:
  - Step 1: Save `.mmd` source to `images/diagrams/` with naming convention `NN_short_description.mmd`.
  - Step 2: Run `scripts/render_mermaid_diagrams.ps1` to render PNG at 4× scale.
  - Step 3: Insert `![Figure N — Description](../../images/diagrams/NN_short_description.png)` into the target document.
  - Step 4: Verify that `images/diagrams/diagram_manifest.json` is updated (auto-updated by the render script; agent must confirm).

### 2. Create `.tasks/005-pm-agent-system/artifacts/phase-3/phase-3-template-skeletons.md`

Content:
- One template skeleton per specialist.
- Each skeleton must include:
  - **Shared frontmatter block**: `name`, `description` (with trigger phrases embedded in description per templates README activation pattern).
  - **`copilot:` block** with:
    - `tools`: explicit inclusion list using Copilot tool name strings from templates README.
    - `model`: assigned model tier (`sonnet` for read-only advisors and QAEngineer; `opus` for UIUXDesigner due to diagram generation complexity).
    - `user-invokable`: `true` for all four (aligned with BusinessAnalyst/ScrumMaster pattern; specialists are user-accessible as well as orchestrator-invokable).
    - `handoffs`: at least one handoff button per agent pointing to the appropriate next-step agent.
  - **`cc:` block** with:
    - `tools`: list using CC tool name strings.
    - `disallowedTools`: explicit exclusion list.
    - `model`: tier string.
    - `skills`: relevant skills per agent (see skill assignments below).
  - **Body block structure**: required `## Role`, `## Project Context`, `## Permission Boundaries`, and `## Invocation Patterns` sections marked as placeholder with description of expected content.
  - Note where `<!-- COPILOT-ONLY -->` or `<!-- CC-ONLY -->` directives apply (per ADR-005 platform divergence instruction).
- Skill assignments by agent:
  - FrontendDev cc skills: `[architecture, deep-research, critic]`
  - BackendDev cc skills: `[architecture, deep-research, security-review]`
  - QAEngineer cc skills: `[testing, debug, critic]`
  - UIUXDesigner cc skills: `[architecture, design]`

### 3. Create `.tasks/005-pm-agent-system/artifacts/phase-3/phase-3-handoff-permission-matrix.md`

Content:
- **Permission Matrix** table:
  - Rows: FrontendDev, BackendDev, QAEngineer, UIUXDesigner.
  - Columns: Read (any file), Write (docs/specs), Write (diagrams/images), Execute (tests), Execute (terminal commands), Delegate to subagent, User-invokable.
  - Cell values: ✅ Allowed, ❌ Denied, ⚠️ Conditional (with condition noted).
  - Column notes: "Write (diagrams/images)" for UIUXDesigner is ✅ Allowed and must cite Mermaid lifecycle compliance requirement.
- **Handoff Contract Table**:
  - Rows: one per specialist.
  - Columns: Upstream Callers (who may invoke), Input Expected (summary format expected), Output Produced (format/schema), Downstream Consumers (who receives output), Checkpoint Pause Expected (Y/N and condition).
- **Escalation Registry**:
  - One row per specialist with escalation path, trigger condition, and receiving agent.
- **Disallowed Action Registry**:
  - Table listing specific disallowed actions per agent that must appear as explicit rules in the agent's runtime instructions (not just in frontmatter toolsets), to provide behavioral enforcement.

### 4. Create `.tasks/005-pm-agent-system/artifacts/phase-3/phase-3-source-traceability-matrix.md`

Content:
- One row per normative design decision in Phase 3 artifacts.
- Required minimum columns (same as Phase 2 pattern):
  - `specialist rule` — the design decision being traced.
  - `source doc` — file path of the authoritative source.
  - `source clause` — specific section or heading within the source.
  - `implementation note` — how the rule is applied in the Phase 3 template spec.
  - `verification evidence` — how the Builder or reviewer can confirm compliance.
- Coverage must reference all mandatory source documents listed in this plan.
- Minimum coverage targets:
  - At least one row for each of the four specialists.
  - At least one row per permission tier (Tier R, Tier RE, Tier RW-D).
  - At least one row for UIUXDesigner Mermaid lifecycle compliance.
  - At least one row per agents-personal ADR referenced.

### 5. Update `.tasks/005-pm-agent-system/task.md`

Changes required during execution (by Explorer or Builder at phase-tracking points):
- Set Phase 3 status from `⬜ Not Started` to `📋 Planned`.
- Add plan link `[phase-3-specialist-agent-templates.md](plan/phase-3-specialist-agent-templates.md)` in the Plan column.
- Update Phase 3 notes to: `"Specialist agent specs, template skeletons, permission matrix, and source traceability defined. Awaiting reviewer approval at CP-3.2/CP-3.3/CP-3.4 gates."`.

---

## Implementation Steps

### Step 1: Derive role charters from research

- Use task.md Phase 3 exit criteria, agents-personal BusinessAnalyst/Researcher/Worker template patterns, and ADR-001 subagent scope rules to write the four role charters.
- Confirm non-overlap by completing the cross-specialist comparison table before writing any template skeleton.
- Source: `task.md`, `business-analyst.template.md`, `researcher.template.md`, ADR-001.

### Step 2: Assign and validate permission tiers

- Map each specialist to Tier R, RE, or RW-D.
- For each tier, enumerate:
  - Copilot tools included (from templates README tool name strings).
  - Copilot tools excluded (via absence or explicit guidance).
  - CC tools included.
  - CC `disallowedTools` list.
- Validate that Tier R specialists have no `edit/` or `execute/` tools.
- Validate that Tier RE (QAEngineer) includes test-execution tools but no file-edit tools.
- Validate that Tier RW-D (UIUXDesigner) includes file-creation/edit tools but explicitly excludes shell execution (`Bash` in CC; no `execute/runInTerminal` in Copilot — diagram generation uses the PowerShell render script invoked as a user instruction, not direct Bash execution).
- Note: UIUXDesigner cannot self-execute `render_mermaid_diagrams.ps1` in plan-only mode; this is flagged as a runtime concern for Phase 6 permission governance.
- **Tier R `disallowedTools` evidence (conductor pattern / ADR-002):** FrontendDev and BackendDev apply the same `disallowedTools` enforcement pattern established in `conductor.template.md`, which is the canonical `agents-personal` template for an agent that coordinates without executing writes. Per ADR-002 (task-centric persistence), Tier R advisors produce advisory artifacts scoped to `.tasks/` only; inability to write source files is machine-enforced by including `Write`, `Edit`, `MultiEdit`, and `Bash` in `disallowedTools`. This mirrors conductor's approach of using `disallowedTools` to guarantee orchestration-only scope. GUD-301 references ADR-002 as the governing convention for this output boundary.
- **UIUXDesigner CC `disallowedTools` (explicit entries for machine-enforceable write boundaries):** The UIUXDesigner CC block must specify `disallowedTools: ["Bash", "Task", "MultiEdit"]`. `Bash` prevents any shell execution; `Task` prevents subagent spawning; `MultiEdit` prevents bulk cross-path edits. These three entries constitute the machine-enforceable boundary layer. Write path restriction to `diagrams/` and `images/diagrams/` is instruction-enforced via `## Permission Boundaries` in the template body; see also the UIUXDesigner stub in the "Inline Frontmatter Stubs (CP-3.4 Evidence)" section above for the precise `disallowedTools` array.
- Source: `templates/README.md`, `conductor.template.md`, ADR-002, ADR-005, ADR-001.

### Step 3: Define output contracts and invocation patterns

- For each specialist, define:
  - What artifacts they produce (advisory notes, test reports, diagram files, assessment summaries).
  - Where outputs land in `2026_01_VIP` (advisory outputs → `.tasks/` or `learning_base/`; diagram outputs → `images/diagrams/` and matching `diagrams/` source).
  - How they are invoked directly by users (Copilot `@AgentName` / CC `use AgentName`) and as subagents (ADR-004 `Run the [Agent] as a subagent: ... trigger keywords ...`).
  - Disallowed invocation contexts (e.g., specialist invoking a peer specialist directly — all cross-specialist coordination routes through ProjectManager).
- For UIUXDesigner, define diagram output contract using the four-step Mermaid lifecycle from `.github/copilot-instructions.md`.
- Source: ADR-004, `.github/copilot-instructions.md`, `task.md` Phase 3 scope.

### Step 4: Define handoff contracts

- For each specialist, document:
  - Upstream callers: ProjectManager (orchestrated), ProductOwner (for UIUXDesigner diagram requests), user (direct invocation).
  - Input expected: natural language advisory request or structured task brief from orchestrator.
  - Output format: advisory markdown document, test report, diagram spec, or diagram file set.
  - Downstream consumers: ProjectManager (checkpoint result), Builder/Worker (implementation guidance from advisors), BusinessAnalyst (for requirements impact of advisory findings).
  - Checkpoint pause: whether the specialist output requires a human checkpoint before downstream work proceeds.
- Source: ADR-001 checkpoint model, `conductor.template.md` pause pattern.

### Step 5: Draft template skeletons

- Write the template frontmatter + body structure per templates README format for all four agents.
- Confirm all blocks are present: `name`, `description`, `copilot:`, `cc:`, role section, project context section, permission boundary section, invocation pattern section.
- Flag any places where platform divergence requires `<!-- COPILOT-ONLY -->` or `<!-- CC-ONLY -->` directives (per ADR-005).
- Source: `templates/README.md`, ADR-005.

### Step 6: Build permission and handoff matrix

- Synthesize Step 2–4 outputs into the consolidated matrix table.
- Add the disallowed action registry covering behavioral rules that go beyond tool-level frontmatter constraints.
- Source: ADR-001, ADR-003 (agent consolidation context), Phase 1 interface map.

### Step 7: Build source traceability matrix

- For each normative rule in Phase 3 artifacts, create one row with full citation.
- Verify minimum coverage targets stated in the Detailed File Changes section are met.
- Source: all mandatory sources listed in this plan.

### Step 8: Publish artifacts and update phase tracking

- Write four Phase 3 artifacts into `.tasks/005-pm-agent-system/artifacts/phase-3/`.
- Update Phase 3 row in `task.md` to `📋 Planned` with plan link and notes.

---

## Dependencies

- DEP-301: Phase 1 baseline plan (`phase-1-baseline-reuse-mapping.md`) — provides orchestration constraints, BusinessAnalyst and Worker reuse patterns, and interface map.
- DEP-302: Phase 2 skill template set (`phase-2-skill-template-set.md`) — provides skill assignments for specialist CC blocks (especially `diagram-generation` skill linked to UIUXDesigner).
- DEP-303: Read access to agents-personal README/templates/ADRs as listed in source guidelines.
- DEP-304: Read access to `.github/copilot-instructions.md` for UIUXDesigner Mermaid lifecycle compliance.

---

## Risks and Mitigations

- RISK-301: FrontendDev and BackendDev role charters overlap at the full-stack boundary (e.g., API contracts, data models).
  - MIT-301: Scope FrontendDev to client-side concerns including API consumption patterns only; scope BackendDev to server-side implementation and API design ownership. Document this split explicitly in the cross-specialist comparison table and disambiguation rules section.

- RISK-302: UIUXDesigner write scope creep — agent begins writing to `docs/` or `learning_base/` in addition to diagram paths.
  - MIT-302: Specify write scope in both the template body (`## Permission Boundaries` section as runtime instruction) and the permission matrix. Require the `## Permission Boundaries` section to cite path restrictions by name.

- RISK-303: QAEngineer Bash/terminal access in CC enables unintended file edits.
  - MIT-303: Explicitly list `Edit` and `Write` in QAEngineer `disallowedTools` in the CC frontmatter block, and include a `## Permission Boundaries` section stating files may not be modified; only test execution and log reading are permitted.

- RISK-304: UIUXDesigner Mermaid workflow compliance step omitted from template body (only in frontmatter description).
  - MIT-304: Make diagram lifecycle compliance a required top-level subsection in the UIUXDesigner spec (`## Diagram Lifecycle Compliance`) with all four steps enumerated. CP-3.3 gates plan approval on this.

- RISK-305: Template skeletons generated with invalid YAML frontmatter (folded block scalars, nested structures not supported by agents-personal generator).
  - MIT-305: Follow the inline list format shown in existing templates (e.g., `tools: ["read/readFile", "search"]`) and avoid folded YAML blocks in tool lists, per templates README validation rules.

- RISK-306: Skills assigned to agents in CC blocks conflict with read-only constraints (e.g., QAEngineer assigned a write-capable skill).
  - MIT-306: Verify each assigned skill's allowed-tools at the time of template skeleton authoring and flag any conflict in the source traceability matrix for resolution before Builder execution.

---

## Success Criteria

- SC-301: Four specialist agent specs exist with non-overlapping role charters and explicit permission tiers.
- SC-302: All permission tiers are validated as non-overlapping via the permission matrix artifact.
- SC-303: UIUXDesigner template spec includes all four Mermaid lifecycle steps with path examples matching `.github/copilot-instructions.md`.
- SC-304: All four template skeletons conform to `agents-personal/templates/README.md` agent template frontmatter format.
- SC-305: Handoff contracts are explicit for all four specialists: upstream callers, expected input, output format, downstream consumers, checkpoint pause behaviour.
- SC-306: Source traceability matrix meets minimum coverage targets: four agents, three tiers, one UIUXDesigner diagram compliance row, citations spanning all mandatory source ADRs.
- SC-307: Phase 3 is marked `📋 Planned` in `task.md` and linked to this plan file.
- SC-308: All Phase 3 write targets are `.tasks/005-pm-agent-system/**` only.
- SC-309: Reviewer CP-3.3 acceptance confirms UIUXDesigner diagram isolation with zero write scope overlap to `docs/`, `specs/`, or `learning_base/`.

---

## Verification

### Automated Checks

Confirm Phase 3 plan exists and is linked from task.md:
```
rg "Specialist Agent Templates|phase-3-specialist-agent-templates.md|📋 Planned" .tasks/005-pm-agent-system
```

Confirm mandatory source references are present in this plan:
```
rg "agents-personal|ADR-001|ADR-002|ADR-004|ADR-005|ADR-007|templates/README|copilot-instructions" .tasks/005-pm-agent-system/plan/phase-3-specialist-agent-templates.md
```

Confirm UIUXDesigner Mermaid lifecycle compliance is declared:
```
rg "copilot-instructions|render_mermaid_diagrams|diagram_manifest|Step 1|Step 2|Step 3|Step 4" .tasks/005-pm-agent-system/plan/phase-3-specialist-agent-templates.md
```

Confirm permission tiers are named:
```
rg "Tier R|Tier RE|Tier RW-D|disallowedTools|read-only" .tasks/005-pm-agent-system/plan/phase-3-specialist-agent-templates.md
```

Confirm traceability matrix file and required columns are declared:
```
rg "phase-3-source-traceability-matrix|specialist rule|source doc|source clause|implementation note|verification evidence" .tasks/005-pm-agent-system/plan/phase-3-specialist-agent-templates.md
```

Confirm all declared file create/update targets are `.tasks`-scoped:
```
rg "^### [0-9]+\. (Create|Update) " .tasks/005-pm-agent-system/plan/phase-3-specialist-agent-templates.md
```
(Reviewer check: each matched path must start with `.tasks/005-pm-agent-system/`.)

Confirm inline frontmatter stubs exist for all four specialists (CP-3.4 direct evidence):
```
rg "name: (FrontendDev|BackendDev|QAEngineer|UIUXDesigner)" .tasks/005-pm-agent-system/plan/phase-3-specialist-agent-templates.md
```
(Expected: four matches, one per specialist, within the Inline Frontmatter Stubs section.)

Confirm UIUXDesigner `disallowedTools` are explicitly named in the plan:
```
rg "disallowedTools.*Bash.*Task|disallowedTools.*Task.*Bash" .tasks/005-pm-agent-system/plan/phase-3-specialist-agent-templates.md
```
(Expected: at least one match in the UIUXDesigner stub and one in Step 2 evidence notes.)

### Manual Verification Steps

1. Review `phase-3-specialist-agent-templates.md` and confirm all four required specialists are defined with non-overlapping scope in the Role Charter Summary table.
2. Confirm the permission tier table covers Tier R (×2), Tier RE (×1), and Tier RW-D (×1) with explicit tool inclusions and exclusions per platform.
3. Confirm UIUXDesigner section includes all four `.github/copilot-instructions.md` Mermaid lifecycle steps enumerated in the Detailed File Changes — Step 1 content description.
4. Confirm each template skeleton includes `name`, `description`, `copilot:` block, and `cc:` block per templates README format specification.
5. Confirm the handoff contract table specifies upstream callers, checkpoint pause expectation, and at least one downstream consumer for all four specialists.
6. Confirm no files outside `.tasks/` were modified while preparing this phase plan.
7. Confirm reviewer CP-3.3 acceptance is explicitly required before `⭐ Reviewed` transition.

### Success Evidence

- Builder can implement Phase 3 artifacts using only this plan plus the mandatory source set, without additional research.
- Reviewer can trace every specialist permission boundary and diagram compliance rule back to `agents-personal` sources and `.github/copilot-instructions.md`.
- Phase 4 (ProductOwner and Existing-Agent Integration) can reference the Phase 3 handoff contracts without re-deriving specialist capabilities.

---

## Tests

Not applicable for this phase. Phase 3 is planning-only documentation work that defines template specifications and does not introduce any executable behaviour. Behavioural testing of specialist agents is scoped to Phase 8 (Pilot Validation and Integration Testing).
