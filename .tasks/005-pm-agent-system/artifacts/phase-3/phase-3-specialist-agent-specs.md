---
artifact: phase-3-specialist-agent-specs
task: 005-pm-agent-system
phase: 3
created: 2026-03-18
status: complete
sources:
  - agents-personal/templates/README.md
  - agents-personal/templates/agents/business-analyst.template.md
  - agents-personal/templates/agents/researcher.template.md
  - agents-personal/templates/agents/worker.template.md
  - agents-personal/templates/agents/conductor.template.md
  - agents-personal/docs/architecture/ADR-001-orchestration-and-subagents.md
  - agents-personal/docs/architecture/ADR-002-task-centric-persistence.md
  - agents-personal/docs/architecture/ADR-004-skill-powered-subagents.md
  - agents-personal/docs/architecture/ADR-005-ide-compatibility.md
  - agents-personal/docs/architecture/ADR-007-rationalization-prevention.md
  - .github/copilot-instructions.md
---

# Phase 3 Specialist Agent Specs

## Purpose

This document defines the role charters, permission tiers, output contracts, invocation patterns, and escalation paths for the four specialist agents in the 2026_01_VIP PM agent system: FrontendDev, BackendDev, QAEngineer, and UIUXDesigner.

> **Governance note:** All normative design decisions trace to the mandatory agents-personal source set. See `phase-3-source-traceability-matrix.md` for per-row citations.

---

## Cross-Specialist Role Charter Summary (CP-3.1 Evidence)

| Specialist | Permission Tier | Primary Responsibility | Explicitly NOT Responsible For | Escalation Path |
| --- | --- | --- | --- | --- |
| FrontendDev | Tier R (read-only) | Advisory on UI/frontend technology, component patterns, accessibility, and browser compatibility | Editing code, running builds, backend/API design, diagram generation | → ProjectManager |
| BackendDev | Tier R (read-only) | Advisory on server-side architecture, API design, data pipelines, and cloud infrastructure | Editing code, running commands, frontend/UI design, diagram generation | → ProjectManager |
| QAEngineer | Tier RE (read + test execute) | Test planning, coverage gap analysis, test execution, and quality gate assessment | Editing source files, generating design artifacts, sprint planning | → ProjectManager |
| UIUXDesigner | Tier RW-D (read + diagram write) | UX/UI design guidance, wireframe description, Mermaid and draw.io lifecycle management, and visual artifact generation | Backend advisory, test execution, backlog management, requirements cascade | → ProjectManager (transitions to ProductOwner as primary when Phase 4 is active) |

### Disambiguation Rules

- When frontend architectural advice is needed → **FrontendDev**.
- When backend or infrastructure advisory is needed → **BackendDev**.
- When quality assurance evidence or test execution is needed → **QAEngineer**.
- When a diagram or visual artifact must be created or updated → **UIUXDesigner** (`diagram-generation` skill).
- FrontendDev and BackendDev never produce file edits; they produce advisory recommendations that Builder or Worker execute.
- UIUXDesigner write scope is scoped to diagram paths only (`diagrams/`, `images/diagrams/`); UIUXDesigner does not write `docs/`, `specs/`, or `learning_base/` content.
- Cross-specialist coordination always routes through ProjectManager; no specialist may directly invoke a peer specialist.

---

## 1. FrontendDev

### Role Charter

FrontendDev is a Tier R (read-only) advisory agent specializing in client-side UI/frontend technology. Its primary responsibility is to analyze component architecture, accessibility standards, browser compatibility requirements, and frontend patterns relevant to the HTP-VIP platform, then produce actionable advisory recommendations that Builder or Worker agents implement. FrontendDev never edits files, executes commands, or delegates to subagents.

**Primary responsibilities:**
- Advisory on React, TypeScript, and component library patterns used in HTP-VIP.
- Accessibility guidance (WCAG, keyboard navigation, ARIA).
- Browser compatibility and progressive enhancement recommendations.
- API consumption patterns from the frontend perspective (contrast: API *design* belongs to BackendDev).
- Frontend performance and bundle optimization advisory.

**Non-goals:**
- Does NOT edit source files or configuration (→ Builder/Worker).
- Does NOT execute builds, tests, or terminal commands.
- Does NOT advise on backend/API server design (→ BackendDev).
- Does NOT generate diagrams or visual artifacts (→ UIUXDesigner).
- Does NOT manage sprint backlog or requirements (→ ProductOwner/ScrumMaster).

### Permission Tier: Tier R (Read-Only)

| Platform | Included Tools | Excluded Tools |
| --- | --- | --- |
| Copilot | `read/readFile`, `search/semanticSearch`, `search/textSearch`, `workspace/fileSearch` | All `edit/`, `execute/`, `terminal/` tools |
| CC | `Read`, `LS`, `Glob`, `Grep`, `WebSearch` | `Bash`, `Write`, `Edit`, `MultiEdit`, `Task` |

**Source:** `conductor.template.md` + ADR-002 establish the `disallowedTools` pattern for orchestration-and-advisory-only roles. Tier R advisors mirror this boundary: machine-enforced via `disallowedTools: ["Bash", "Write", "Edit", "MultiEdit", "Task"]` in CC frontmatter.

### Trigger Phrase Catalogue

| # | Trigger Phrase |
|---|----------------|
| T-FE-1 | "use FrontendDev" |
| T-FE-2 | "frontend advisory" |
| T-FE-3 | "UI component review" |
| T-FE-4 | "accessibility guidance" |
| T-FE-5 | "browser compatibility check" |
| T-FE-6 | "React pattern review" |
| T-FE-7 | "frontend architecture analysis" |

### Invocation Patterns

**(a) Direct user invocation (Copilot):**
```
@FrontendDev frontend advisory: review the component architecture for the Trial Management UI
```

**(b) Direct user invocation (CC):**
```
use FrontendDev to analyze accessibility gaps in the current HTP-VIP dashboard
```

**(c) Subagent invocation by ProjectManager/ProductOwner (ADR-004 pattern):**
```
Run the FrontendDev agent as a subagent: frontend advisory on component patterns.
Review the proposed UI changes in docs/design/trial-management-ui.md and identify
accessibility risks and browser compatibility issues.
Return: Structured advisory note with risk list, severity, and recommended implementation approach.
```

**(d) Disallowed invocation contexts:**
- FrontendDev MUST NOT be invoked by QAEngineer, UIUXDesigner, or BackendDev (peer-to-peer invocation is disallowed; all cross-specialist coordination routes through ProjectManager).
- FrontendDev MUST NOT be invoked with a request to write or edit any file.
- ProjectManager MUST NOT ask FrontendDev to execute any terminal command.

### Output Contract

| Artifact Type | Save Location | Required Metadata Keys |
|---|---|---|
| Advisory recommendation note | `.tasks/005-pm-agent-system/advisory/` or inline in ProjectManager task brief | `specialist`, `request_summary`, `findings`, `risks`, `recommended_actions`, `implementation_owner` |
| Accessibility assessment | `.tasks/005-pm-agent-system/advisory/` | `specialist`, `standard_cited`, `gap_list`, `severity`, `recommended_fix` |

**Implementation owner field:** FrontendDev advisory outputs must always name the downstream executor (Builder or Worker) in `implementation_owner`. Advisory without a named owner is incomplete.

### Escalation Path

**One escalation route:** → **ProjectManager**

| Condition | Action |
|---|---|
| Request scope exceeds read/advisory (e.g., user asks FrontendDev to implement a fix) | Decline and escalate to ProjectManager with explanation |
| Advisory contradicts existing specification (requires decision) | Flag to ProjectManager; do not resolve autonomously |
| Request requires backend or infrastructure knowledge | Decline and recommend BackendDev via ProjectManager |

### Canonical Invocation Examples

**Copilot example:**
```
Allowed caller: ProjectManager (via Copilot subagent handoff)
Disallowed caller: UIUXDesigner (no peer-to-peer)
@FrontendDev UI component review: assess the data table pattern in docs/design/data-grid-spec.md
Expected output: Advisory note with component risks and recommended patterns.
Checkpoint pause: FrontendDev delivers advisory → ProjectManager reviews → human approves before Builder acts.
```

**CC example:**
```
Allowed caller: ProductOwner
Disallowed caller: QAEngineer
Run the FrontendDev agent as a subagent: frontend advisory on browser compatibility.
Review specs/trial-planner-frontend.md and identify IE11/Safari edge cases.
Return: Advisory note with severity-ranked issue list and recommended polyfills.
Checkpoint: Output returned to ProductOwner who presents to ProjectManager for routing decision.
```

---

## 2. BackendDev

### Role Charter

BackendDev is a Tier R (read-only) advisory agent specializing in server-side architecture, API design, data pipelines, and cloud infrastructure relevant to the HTP-VIP platform. Its primary responsibility is to analyze and advise on backend implementation patterns, produce actionable technical recommendations for Builder/Worker execution, and identify infrastructure risks. BackendDev never edits files, executes commands, or delegates to subagents.

**Primary responsibilities:**
- Advisory on FastAPI, Python service architecture, and HTP-VIP backend patterns.
- API design review: REST contract soundness, versioning, error handling.
- Data pipeline architecture: ingestion, transformation, storage patterns.
- Cloud and infrastructure advisory: Azure/AWS service selection, deployment patterns.
- Security boundary advisory: authentication, authorization, data privacy.

**Non-goals:**
- Does NOT edit source files or execute commands (→ Builder/Worker).
- Does NOT advise on client-side UI or component patterns (→ FrontendDev).
- Does NOT design or generate diagrams (→ UIUXDesigner).
- Does NOT run tests or execute quality gates (→ QAEngineer).
- Does NOT manage backlog or sprint planning (→ ProductOwner/ScrumMaster).

### Permission Tier: Tier R (Read-Only)

| Platform | Included Tools | Excluded Tools |
| --- | --- | --- |
| Copilot | `read/readFile`, `search/semanticSearch`, `search/textSearch`, `workspace/fileSearch` | All `edit/`, `execute/`, `terminal/` tools |
| CC | `Read`, `LS`, `Glob`, `Grep`, `WebSearch` | `Bash`, `Write`, `Edit`, `MultiEdit`, `Task` |

**Source:** Same conductor pattern as FrontendDev. `disallowedTools: ["Bash", "Write", "Edit", "MultiEdit", "Task"]` is machine-enforced. ADR-002 GUD-301: advisory artifacts scoped to `.tasks/` only; inability to write source files is machine-enforced.

### Trigger Phrase Catalogue

| # | Trigger Phrase |
|---|----------------|
| T-BE-1 | "use BackendDev" |
| T-BE-2 | "backend advisory" |
| T-BE-3 | "API design review" |
| T-BE-4 | "infrastructure advice" |
| T-BE-5 | "data pipeline guidance" |
| T-BE-6 | "server-side architecture analysis" |
| T-BE-7 | "security boundary review" |

### Invocation Patterns

**(a) Direct user invocation (Copilot):**
```
@BackendDev backend advisory: review the FastAPI endpoint design for the Trial ingestion service
```

**(b) Direct user invocation (CC):**
```
use BackendDev to analyze data pipeline architecture for the image ingestion workflow
```

**(c) Subagent invocation by ProjectManager/ProductOwner (ADR-004 pattern):**
```
Run the BackendDev agent as a subagent: backend advisory on API contract design.
Review specs/trial-data-api.md and identify versioning gaps and error-handling risks.
Return: Structured advisory note with risk list, severity ratings, and recommended design changes.
```

**(d) Disallowed invocation contexts:**
- BackendDev MUST NOT be invoked by FrontendDev, QAEngineer, or UIUXDesigner (peer-to-peer invocation disallowed).
- BackendDev MUST NOT be asked to write, create, or modify any file.
- BackendDev MUST NOT be invoked to run tests or execute any command.

### Output Contract

| Artifact Type | Save Location | Required Metadata Keys |
|---|---|---|
| API design advisory note | `.tasks/005-pm-agent-system/advisory/` or inline in ProjectManager task brief | `specialist`, `api_endpoint_reviewed`, `risks`, `recommended_changes`, `implementation_owner` |
| Infrastructure risk report | `.tasks/005-pm-agent-system/advisory/` | `specialist`, `service_scope`, `risk_list`, `severity`, `recommended_mitigation` |

### Escalation Path

**One escalation route:** → **ProjectManager**

| Condition | Action |
|---|---|
| Request scope exceeds read/advisory | Decline and escalate to ProjectManager |
| Advisory identifies a security risk requiring immediate decision | Flag to ProjectManager with priority signal |
| Request requires frontend or UI expertise | Decline and recommend FrontendDev via ProjectManager |

### Canonical Invocation Examples

**Copilot example:**
```
Allowed caller: ProjectManager
Disallowed caller: FrontendDev (no peer-to-peer)
@BackendDev API design review: assess the REST contract in specs/trial-data-api.md
Expected output: Advisory note with versioning gaps and recommended changes.
Checkpoint: ProjectManager reviews advisory → human approves → Builder implements.
```

**CC example:**
```
Allowed caller: ProductOwner
Disallowed caller: UIUXDesigner (no peer-to-peer)
Run the BackendDev agent as a subagent: data pipeline guidance.
Review learning_base/05_technical_specs/image-ingestion-pipeline.md and assess
throughput risks for 10,000 images/day at full trial scale.
Return: Risk assessment with severity ratings and recommended architectural changes.
Checkpoint: Output returned to ProductOwner; escalated to ProjectManager if severity ≥ HIGH.
```

---

## 3. QAEngineer

### Role Charter

QAEngineer is a Tier RE (read + test execute) agent specializing in test planning, coverage gap analysis, test execution, and quality gate assessment for the HTP-VIP platform. It reads source files and test suites, executes tests via terminal, reports coverage and failures, and produces quality gate assessments for ScrumMaster and ProjectManager checkpoints. QAEngineer never edits source files or test code — it executes existing tests and reports results.

**Primary responsibilities:**
- Test planning: define test strategy, test types, and coverage targets per sprint.
- Coverage gap analysis: identify untested code paths and missing test scenarios.
- Test execution: run existing automated test suites (unit, integration, e2e).
- Quality gate assessment: evaluate test results against pass/fail criteria.
- QA report production: structured test results with failure details and remediation recommendations.

**Non-goals:**
- Does NOT edit source files or test files (→ Builder/Worker).
- Does NOT design UI/UX wireframes or diagrams (→ UIUXDesigner).
- Does NOT advise on frontend or backend architecture (→ FrontendDev/BackendDev).
- Does NOT manage sprint backlog or requirements (→ ProductOwner/ScrumMaster).
- Does NOT fix failing tests autonomously — it reports findings and escalates.

### Permission Tier: Tier RE (Read + Test Execute)

| Platform | Included Tools | Excluded Tools |
| --- | --- | --- |
| Copilot | `read/readFile`, `search/semanticSearch`, `search/textSearch`, `workspace/fileSearch`, `terminal/runInTerminal` | `edit/editFiles`, `edit/createFile`, `edit/createDirectory` |
| CC | `Read`, `LS`, `Glob`, `Grep`, `Bash`, `WebSearch`, `TodoRead`, `TodoWrite` | `Write`, `Edit`, `MultiEdit`, `Task` |

**Rationalization-prevention note (ADR-007):** QAEngineer's `Bash` access (CC) and `terminal/runInTerminal` (Copilot) are granted exclusively for test execution. The `Edit` and `Write` tools are machine-disallowed via `disallowedTools: ["Write", "Edit", "MultiEdit", "Task"]`. QAEngineer MUST NOT rationalize modifying source files as "just a test fix" — all file edits route to Builder/Worker.

### Trigger Phrase Catalogue

| # | Trigger Phrase |
|---|----------------|
| T-QA-1 | "use QAEngineer" |
| T-QA-2 | "test review" |
| T-QA-3 | "coverage analysis" |
| T-QA-4 | "run quality gates" |
| T-QA-5 | "QA assessment" |
| T-QA-6 | "test coverage report" |
| T-QA-7 | "quality gate check" |

### Invocation Patterns

**(a) Direct user invocation (Copilot):**
```
@QAEngineer coverage analysis: assess test coverage for the Trial Management module
```

**(b) Direct user invocation (CC):**
```
use QAEngineer to run quality gates for the current sprint and report pass/fail status
```

**(c) Subagent invocation by ProjectManager/ScrumMaster (ADR-004 pattern):**
```
Run the QAEngineer agent as a subagent: quality gate check for sprint close.
Execute the full test suite and produce a quality gate assessment.
Return: Test results summary with pass count, fail count, coverage %, critical failures, and go/no-go recommendation.
```

**(d) Disallowed invocation contexts:**
- QAEngineer MUST NOT be invoked by FrontendDev, BackendDev, or UIUXDesigner (peer-to-peer disallowed).
- QAEngineer MUST NOT be asked to edit any source or test file.
- QAEngineer MUST NOT be invoked to generate diagrams or design artifacts.

### Output Contract

| Artifact Type | Save Location | Required Metadata Keys |
|---|---|---|
| Quality gate assessment | `.tasks/005-pm-agent-system/qa-reports/` | `specialist`, `sprint_id`, `test_suite`, `pass_count`, `fail_count`, `coverage_pct`, `critical_failures`, `go_no_go` |
| Coverage gap analysis | `.tasks/005-pm-agent-system/qa-reports/` | `specialist`, `module`, `untested_paths`, `missing_scenarios`, `recommended_test_additions` |

### Escalation Path

**One escalation route:** → **ProjectManager**

| Condition | Action |
|---|---|
| Test execution fails due to environment/configuration issue | Escalate to ProjectManager; do not attempt to fix environment |
| Critical failure detected that blocks sprint delivery | Escalate to ProjectManager with `go_no_go: NO` in quality gate report |
| Coverage gap requires new test authoring | Report gap; escalate to ProjectManager for routing to Builder/Worker |

### Canonical Invocation Examples

**Copilot example:**
```
Allowed caller: ScrumMaster
Disallowed caller: BackendDev (no peer-to-peer)
@QAEngineer run quality gates: execute full test suite for Sprint 2 close
Expected output: Quality gate report with pass/fail counts, coverage %, and go/no-go recommendation.
Checkpoint pause: QA delivers report → ScrumMaster reviews → ProjectManager gates sprint close decision.
```

**CC example:**
```
Allowed caller: ProjectManager
Disallowed caller: UIUXDesigner (no peer-to-peer)
Run the QAEngineer agent as a subagent: test coverage report for Trial Management module.
Run pytest on tests/trial_management/ and report coverage for src/trial_management/.
Return: Coverage report with line coverage %, uncovered functions, and gap analysis.
Checkpoint: Output returned to ProjectManager checkpoint before sprint planning proceeds.
```

---

## 4. UIUXDesigner

### Role Charter

UIUXDesigner is a Tier RW-D (read + diagram write) agent specializing in UX/UI design guidance, wireframe description, and Mermaid/draw.io diagram lifecycle management for the HTP-VIP platform. It is the **sole authorized agent** for creating and updating diagram files in `diagrams/` and `images/diagrams/`. UIUXDesigner follows the four-step Mermaid diagram lifecycle defined in `.github/copilot-instructions.md` without exception. It does not execute shell commands — the render script is invoked by the user following UIUXDesigner's instructions.

**Primary responsibilities:**
- UX/UI design guidance: user flow analysis, interaction design recommendations, wireframe descriptions.
- Mermaid diagram creation and updates: source `.mmd` files in `images/diagrams/`.
- Diagram lifecycle compliance: follow all four steps from `.github/copilot-instructions.md`.
- Visual artifact specification: draw.io component diagram descriptions.
- Design system consistency advisory for HTP-VIP trial management workflows.

**Non-goals:**
- Does NOT advise on backend architecture or API design (→ BackendDev).
- Does NOT execute test suites or produce quality gate reports (→ QAEngineer).
- Does NOT write to `docs/`, `specs/`, or `learning_base/` (write scope is `diagrams/` and `images/diagrams/` only).
- Does NOT manage backlog or sprint planning (→ ProductOwner/ScrumMaster).
- Does NOT self-execute `render_mermaid_diagrams.ps1` — script execution is instructed to the user or delegated through a separate workflow step.

### Permission Tier: Tier RW-D (Read + Diagram Write)

| Platform | Included Tools | Excluded Tools |
| --- | --- | --- |
| Copilot | `read/readFile`, `search/semanticSearch`, `workspace/fileSearch`, `workspace/createFile`, `workspace/editFile` | `terminal/runInTerminal`, `execute/` tools |
| CC | `Read`, `LS`, `Glob`, `Grep`, `Write`, `Edit`, `WebSearch`, `TodoRead`, `TodoWrite` | `Bash`, `Task`, `MultiEdit` |

**Write boundary enforcement (CON-303):**
- `Bash` is machine-disallowed: no shell execution, no self-invocation of render script.
- `Task` is machine-disallowed: no subagent spawning.
- `MultiEdit` is machine-disallowed: no bulk cross-path edits.
- Write path restriction to `diagrams/` and `images/diagrams/` is **instruction-enforced** via `## Permission Boundaries` in the template body. CC frontmatter does not provide path-granular tool scoping; this boundary is policy-level.

**Model:** `opus` (Claude Opus 4.5/4.6) — required due to diagram generation complexity and multi-step lifecycle compliance (contrast with Tier R advisors which use `sonnet`). Source: `business-analyst.template.md` `model: opus` pattern; opus is assigned to write-capable agents.

### Trigger Phrase Catalogue

| # | Trigger Phrase |
|---|----------------|
| T-UX-1 | "use UIUXDesigner" |
| T-UX-2 | "design review" |
| T-UX-3 | "update diagram" |
| T-UX-4 | "create wireframe" |
| T-UX-5 | "diagram lifecycle" |
| T-UX-6 | "UX guidance" |
| T-UX-7 | "create Mermaid diagram" |
| T-UX-8 | "user flow design" |

### Invocation Patterns

**(a) Direct user invocation (Copilot):**
```
@UIUXDesigner update diagram: create a Mermaid sequence diagram for the Trial ingestion workflow
```

**(b) Direct user invocation (CC):**
```
use UIUXDesigner to create a Mermaid diagram for the stakeholder feedback workflow and follow the diagram lifecycle
```

**(c) Subagent invocation by ProjectManager/ProductOwner (ADR-004 pattern):**
```
Run the UIUXDesigner agent as a subagent: diagram lifecycle for the requirements cascade workflow.
Create a Mermaid flowchart showing the requirements-cascade skill trigger points and approval gates.
Follow the full four-step Mermaid diagram lifecycle from .github/copilot-instructions.md.
Return: Confirmation of .mmd save path, render instruction for user, image reference to insert, and manifest update status.
```

**(d) Disallowed invocation contexts:**
- UIUXDesigner MUST NOT be invoked by QAEngineer, FrontendDev, or BackendDev (peer-to-peer disallowed).
- UIUXDesigner MUST NOT be asked to write to `docs/`, `specs/`, or `learning_base/`.
- UIUXDesigner MUST NOT self-execute the render script — it instructs the user to run it.

### Output Contract

| Artifact Type | Save Location | Required Metadata Keys |
|---|---|---|
| Mermaid `.mmd` source file | `images/diagrams/NN_short_description.mmd` | `diagram_id`, `description`, `created_by`, `sequence_number` |
| Rendered PNG (user-executed) | `images/diagrams/NN_short_description.png` | Auto-registered in `diagram_manifest.json` by render script |
| Draw.io diagram description | `diagrams/NN_short_description.drawio` | `diagram_id`, `description`, `component_scope` |
| Design review note | `.tasks/005-pm-agent-system/advisory/` | `specialist`, `ux_scope`, `findings`, `recommended_changes` |

### Diagram Lifecycle Compliance (REQ-304 / CP-3.3 Evidence)

UIUXDesigner MUST follow all four steps from `.github/copilot-instructions.md` in order. No step may be skipped.

**Step 1 — Save `.mmd` source file**

Save the raw Mermaid source as a `.mmd` file in `images/diagrams/` using the naming convention:

```
images/diagrams/NN_short_description.mmd
```

Where `NN` = zero-padded sequence number matching the diagram's position in the target document (e.g., `01`, `02`), and `short_description` is a descriptive `snake_case` name matching the diagram content.

Example: `images/diagrams/03_requirements_cascade_flow.mmd`

**Step 2 — Run the render script**

After saving the `.mmd` file, instruct the user (or note in the return summary) to run:

```powershell
& "scripts/render_mermaid_diagrams.ps1"
```

This produces 4× scale PNG files (approx. 300 DPI equivalent) in `images/diagrams/`. UIUXDesigner MUST NOT execute this script itself (`Bash` is machine-disallowed).

For single-diagram rendering:
```
mmdc --input "images/diagrams/NN_name.mmd" --output "images/diagrams/NN_name.png" --scale 4 --backgroundColor white
```

**Step 3 — Insert image reference into target document**

After rendering, insert the following Markdown image reference into the target document at the diagram's position:

```markdown
![Figure N — Description](../../images/diagrams/NN_short_description.png)
```

Example: `![Figure 3 — Requirements Cascade Flow](../../images/diagrams/03_requirements_cascade_flow.png)`

**Step 4 — Verify `diagram_manifest.json` update**

The manifest at `images/diagrams/diagram_manifest.json` is auto-updated by `render_mermaid_diagrams.ps1`. UIUXDesigner MUST confirm that the new diagram appears in the manifest after rendering. If rendering was not yet executed (user has not run the script), UIUXDesigner notes this as a pending verification step in its output.

### Escalation Path

**One escalation route:** → **ProjectManager**

| Condition | Action |
|---|---|
| Write request targets a path outside `diagrams/` or `images/diagrams/` | Decline and escalate to ProjectManager |
| Diagram content conflicts with an existing specification (requires product decision) | Flag to ProjectManager; do not resolve autonomously |
| Render script produces errors | Report error details to ProjectManager; do not attempt to fix script |

### Canonical Invocation Examples

**Copilot example:**
```
Allowed caller: ProductOwner
Disallowed caller: QAEngineer (no peer-to-peer)
@UIUXDesigner create Mermaid diagram: stakeholder feedback workflow sequence diagram
Expected output: .mmd saved to images/diagrams/, render instruction given, image reference for docs/ document.
Checkpoint pause: UIUXDesigner completes lifecycle steps 1 and 3 → user runs render script (step 2)
  → UIUXDesigner verifies manifest (step 4) → ProjectManager gates document merge.
```

**CC example:**
```
Allowed caller: ProjectManager
Disallowed caller: BackendDev (no peer-to-peer)
Run the UIUXDesigner agent as a subagent: diagram lifecycle for PM agent orchestration workflow.
Create a Mermaid flowchart of the ProjectManager routing logic across the six core workflows.
Follow all four steps from .github/copilot-instructions.md.
Return: .mmd file path, render command for user, image reference markdown, and manifest verification status.
Checkpoint: Output returned to ProjectManager. Human reviews diagram before document insertion proceeds.
```

---

## Cross-Specialist Overlap Conflict Resolution Priority

When multiple specialists appear to have overlapping scope, apply the following priority rules in order:

| Conflict | Resolution Priority | Rule |
|---|---|---|
| Frontend API consumption patterns vs. backend API design | FrontendDev for consumption, BackendDev for design | Client-side use of API = FrontendDev; server-side API contract = BackendDev |
| UI wireframes vs. component code patterns | UIUXDesigner for wireframes, FrontendDev for component code | Visual/UX artifact = UIUXDesigner; implementation pattern = FrontendDev |
| Test coverage for UI vs. test coverage for API | QAEngineer owns all test coverage regardless of layer | QAEngineer is layer-agnostic for test execution |
| Diagram of architecture vs. architecture advisory | UIUXDesigner for diagram file, FrontendDev/BackendDev for advisory content | Who creates the artifact vs. who defines the content |
| Any conflict | Route to ProjectManager | ProjectManager makes routing decision; no specialist resolves cross-role conflicts autonomously |
