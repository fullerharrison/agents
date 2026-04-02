---
artifact: phase-6-source-traceability-matrix
task: 005-pm-agent-system
phase: 6
created: 2026-03-18
status: complete
checkpoint: CP-6.10
sources:
  - All Phase 6 governance artifacts
  - agents-personal framework source set
  - VIP/learning_base/ideas/pm_agent_coordination_system_implementation_plan.md
  - Phases 3, 4, 5 plans and artifacts
---

# Phase 6 Artifact: Source Traceability Matrix

## Purpose

This document links every Phase 6 governance rule to its originating source. Every permission tier definition, tooling boundary rule, enforcement mechanism, write-path partition rule, execute-scope rule, and drift detection condition can be traced to at least one source document and one prior-phase decision.

**Required columns:** `governance rule` | `source doc` | `source clause` | `phase-where-established` | `implementation note`

---

## Source Traceability Matrix

| # | Governance Rule | Source Doc | Source Clause | Phase Established | Implementation Note |
| --- | --- | --- | --- | --- | --- |
| 1 | **Tier O definition — ProjectManager is orchestration-only, read/route only, no write/execute** | `agents-personal/templates/agents/conductor.template.md` | Conductor pattern: `disable-model-invocation: true`, delegation-only tools | Phase 5, REQ-501, REQ-509 | Tier O canonical source is the conductor template. PM inherits all conductor constraints. |
| 2 | **Tier O `disallowedTools` — six prohibited categories: terminal, createFile, editFiles, createDirectory, Task, state writes** | Phase 5 plan REQ-509; `conductor.template.md` frontmatter pattern | REQ-509 explicit PM `disallowedTools` list; conductor pattern tool exclusions | Phase 5, REQ-509 | `terminal/runInTerminal`, `edit/createFile`, `edit/editFiles`, `edit/createDirectory`, `Task` (Copilot); `Bash`, `Write`, `Edit`, `MultiEdit`, `TodoWrite` (CC) |
| 3 | **`disable-model-invocation: true` for ProjectManager** | `agents-personal/templates/agents/conductor.template.md` | Conductor pattern special flag; prevents orchestration loops | Phase 5, REQ-501 | Must be present in ProjectManager template frontmatter. |
| 4 | **Tier R definition — FrontendDev and BackendDev are read-only advisory** | `agents-personal/templates/agents/researcher.template.md`; source plan Section 8 | Researcher template read-only profile; Section 8 role access summary | Phase 3, REQ-303 | Tier R canonical source is the researcher template. FE and BE inherit Tier R profile. |
| 5 | **Tier R `disallowedTools` — all write and execute tools excluded** | Phase 3 plan REQ-303; `researcher.template.md` | REQ-303 specialist agent permissions; researcher template `disallowedTools` | Phase 3, REQ-303 | `terminal/runInTerminal`, `edit/createFile`, `edit/editFiles`, `edit/createDirectory` (Copilot); `Bash`, `Write`, `Edit`, `MultiEdit`, `Task` (CC) |
| 6 | **Tier RE definition — QAEngineer has test-only execute scope** | Source plan Section 3.5 (QAEngineer frontmatter); ADR-001 capability table | Section 3.5 QAEngineer template spec; ADR-001 agent capabilities matrix | Phase 3, REQ-303, REQ-305 | Tier RE is a specialization of Tier R with test execute tools added. |
| 7 | **Tier RE execute scope — permitted test commands only: pytest, jest, npm test, dotnet test** | Source plan Section 3.5; Phase 3 plan REQ-605 | Section 3.5 QAEngineer frontmatter execute scope; REQ-605 exact permitted command list | Phase 3, REQ-303; Phase 6, REQ-605 | Must appear in QAEngineer template body `## Permission Boundaries` as explicit permitted command list. |
| 8 | **Tier RE `disallowedTools` — all `edit/*` tools excluded** | Phase 3 plan REQ-305; Phase 6 REQ-605 | REQ-305 QAEngineer tool exclusions; REQ-605 `edit/*` exclusion requirement | Phase 3, REQ-305; Phase 6, REQ-605 | `edit/createFile`, `edit/editFiles`, `edit/createDirectory` (Copilot); `Write`, `Edit`, `MultiEdit` (CC) |
| 9 | **Tier RW-D definition — UIUXDesigner has diagram-scoped write and mmdc render execute** | `.github/copilot-instructions.md` Mermaid lifecycle; Phase 3 plan REQ-303, REQ-304 | Copilot instructions four-step Mermaid lifecycle; REQ-303 specialist permissions; REQ-304 diagram write scope | Phase 3, REQ-303, REQ-304 | Tier RW-D write paths: `diagrams/`, `images/diagrams/`, `docs/` (image refs only). Execute: mmdc only. |
| 10 | **Tier RW-D write path restriction is instruction-enforced, not frontmatter-enforced** | Phase 3 plan CP-3.3 decision note; Phase 6 REQ-606 | CP-3.3: "CC frontmatter does not provide path-granular tool scoping"; REQ-606 diagram write + execute permission | Phase 3, CP-3.3; Phase 6, REQ-606 | Template body must explicitly state: "Write only to `diagrams/`, `images/diagrams/`, and diagram-adjacent `docs/` references." |
| 11 | **Tier RW-D `disallowedTools` — `Bash` excluded (CC), `MultiEdit` excluded, `Task` excluded** | Phase 3 plan REQ-303; Phase 6 REQ-606; `phase-3-handoff-permission-matrix.md` Section 5 | REQ-303 UIUXDesigner machine-enforced disallowedTools; REQ-606 Bash exclusion requirement | Phase 3, REQ-303; Phase 6, REQ-606 | `Bash`, `MultiEdit`, `Task` in CC `disallowedTools`. `MultiEdit` prevents bulk cross-path edits. |
| 12 | **Tier W definition — ProductOwner, BusinessAnalyst, ScrumMaster: read + write, no execute** | `agents-personal/templates/agents/business-analyst.template.md`; `scrum-master.template.md`; Phase 4 plan REQ-402 | BA template write-enabled profile; REQ-402 Tier W same tier for PO/BA/SM | Phase 4, REQ-402 | All three agents share Tier W profile. Write scope is role-partitioned. |
| 13 | **Tier W `disallowedTools` — `terminal/runInTerminal` (Copilot), `Bash` (CC), `Task` (CC)** | Phase 4 plan REQ-410; `business-analyst.template.md` frontmatter | REQ-410 PO `disallowedTools` including `terminal/runInTerminal`; BA template `disallowedTools` | Phase 4, REQ-402, REQ-410 | All three Tier W agents share this `disallowedTools` profile. Existing BA and SM templates must be validated on next generation cycle. |
| 14 | **Tier F definition — Worker: full access, mechanical conversion executor** | `agents-personal/templates/agents/worker.template.md`; source plan Section 8 | Worker template full-access profile; Section 8 role access summary | Section 8 of source plan; Phase 4 Worker-vs-PO conversion matrix | Worker is the only Tier F agent. Full access is mechanically constrained by body instruction — not frontmatter. |
| 15 | **Tier F conversion-context constraint — body-level only** | Source plan Section 8; Phase 4 `phase-4-worker-vs-productowner-conversion-decision-matrix.md` | Section 8 Worker scope note: "mechanical conversion executor"; Phase 4 conversion boundary rules | Source plan Section 8; Phase 4 | Body constraint phrase required: "Execute only the specific conversion command requested in the invocation instruction." |
| 16 | **Write-path partition for Tier W — sub-path by content type (Step 1), caller workflow (Step 2)** | Source plan Section 8 (per-agent write column); Phase 6 REQ-603 | Section 8 agent write path summary; REQ-603 two-step conflict resolution strategy | Phase 6, REQ-603 (consolidates Phase 3/4 path decisions) | Both steps apply in sequence: Step 1 = content type partition; Step 2 = caller workflow as tie-breaker. The "OR" open choice is closed — both mechanisms mandatory. |
| 17 | **ProductOwner `docs/` partition — VoC/intake artifacts only** | Source plan Section 8; Phase 4 plan REQ-402 | Section 8 PO write paths; Phase 4 handoff contracts | Phase 4, REQ-402 | PO does not write requirements, specs, ADRs, sprint plans, or technical docs to `docs/`. |
| 18 | **BusinessAnalyst `docs/` partition — requirements, ADRs, specs** | `business-analyst.template.md`; source plan Section 8 | BA template write scope; Section 8 BA write paths | Phase 4, REQ-402 | BA has broader `docs/` authority than PO. Default authority holder for unresolved `docs/` ambiguity. |
| 19 | **ScrumMaster `docs/ways-of-work/` partition — sprint plans only** | `scrum-master.template.md`; source plan Section 8 | SM template write scope; Section 8 SM write paths | Phase 4, REQ-402 | Narrowest Tier W write scope. No overlap with BA or PO for sprint artifacts. |
| 20 | **UIUXDesigner `docs/` partition — image references only (diagram-adjacent)** | `.github/copilot-instructions.md` Mermaid lifecycle step 3; Phase 3 REQ-304 | Mermaid step 3: insert `![Figure N](...)` reference; REQ-304 UIUXDesigner write scope | Phase 3, REQ-304 | UIUXDesigner must not create new `docs/` documents. Existing file edits for image reference insertion only. |
| 21 | **Worker Tier-F edge case — writes to Tier W paths only with explicit invocation** | Phase 4 `phase-4-worker-vs-productowner-conversion-decision-matrix.md`; Phase 6 REQ-603 | Phase 4 Worker invocation rules; REQ-603 Worker edge case rule | Phase 4; Phase 6, REQ-603 | Three conditions required: explicit invocation, explicit path instruction, conversion context. Invoking agent retains authorship accountability. |
| 22 | **Copilot tool namespace — slash-namespaced identifiers** | `agents-personal/templates/README.md` Frontmatter Structure; ADR-005 | README frontmatter example: `tools: ["vscode/askQuestions", "read/readFile", ...]`; ADR-005 IDE compatibility | ADR-005; framework convention | All Copilot tool IDs use format `category/toolName`. Must not use PascalCase in Copilot frontmatter. |
| 23 | **CC tool namespace — PascalCase identifiers** | `agents-personal/templates/README.md` Frontmatter Structure; ADR-005 | README frontmatter example: `cc.tools: [Read, Grep, Glob, Edit, Write, ...]`; ADR-005 IDE compatibility | ADR-005; framework convention | All CC tool IDs use PascalCase. Must not use slash-namespaced IDs in CC frontmatter. |
| 24 | **Enforcement Layer 1 — `disallowedTools` frontmatter blocks tool invocation** | `agents-personal/templates/README.md`; ADR-001 tool constraint pattern | README `disallowedTools` convention; ADR-001 agent capability constraints | Phase 6, REQ-608 | When a disallowed tool is invoked, the IDE framework blocks the call. Template body must include rationalization-prevention escalation note. |
| 25 | **Enforcement Layer 2 — `generate.js` validates required frontmatter fields** | `agents-personal/scripts/generate.js`; `install.sh` lines 222–259; source plan Section 11.1 | `generate.js` compilation validation; `check_generated_files()` function | Phase 6, REQ-609 | `disallowedTools` content not auto-validated by `generate.js` — manual human review is the gate for `disallowedTools` correctness. |
| 26 | **Enforcement Layer 3 — PM routing matrix blocks out-of-permission actions at runtime** | Phase 5 `phase-5-orchestration-routing-matrix.md`; ADR-001 checkpoint gating | Phase 5 PM routing rules; ADR-001 Entry Gate and checkpoint enforcement | Phase 5; Phase 6, REQ-610 | PM must re-route to capable agent when restricted agent reports inability to perform action. Layer 3 catches artifact-visible violations only. |
| 27 | **Cross-agent consistency check — six axes, nine agents, PASS/FAIL per cell** | ADR-007 rationalization-prevention evidence standard; Phase 6 REQ-611 | ADR-007: pre-declared outcomes prevent post-hoc cherry-picking; REQ-611 consistency check requirements | Phase 6, REQ-611 | Outcomes pre-declared in plan before implementation. Builder must not adjust PASS/FAIL verdicts post-hoc without documented justification. |
| 28 | **Drift detection minimum floor — 2 conditions × 6 tiers = 12 conditions** | Phase 6 REQ-612 | REQ-612: "Minimum floor: two independently verifiable conditions per tier × six tiers = twelve conditions total." | Phase 6, REQ-612 | This formula is the traceable basis for the minimum floor. Builder enumerated 12 conditions; two per tier. |
| 29 | **Escalation path rule — all non-PM agents escalate to PM; PM escalates to Human** | Phase 6 REQ-614; ADR-001 orchestration model | REQ-614 escalation path requirement; ADR-001 conductor/specialist authority boundary | Phase 3 (specialist escalation) + Phase 5 (PM escalation to Human); Phase 6, REQ-614 consolidation | No agent may escalate directly to a peer specialist. Worker escalates to caller agent (PO or PM) as single path. |
| 30 | **README alignment check — agents-personal README must list agent types** | `agents-personal/README.md`; Phase 6 REQ-613 | README agent listing; REQ-613 documentation alignment requirement | Phase 6, REQ-613 | New agents (PM, PO, FE, BE, QA, UIUX) must be added to README by Builder in a future template generation phase. This is a read-only verification in Phase 6. |

---

## README and Docs Alignment Check Evidence

### Check 1: agents-personal README Agent Table

- **Source:** `C:/Users/s1058662/repos/agents-personal/README.md`
- **Finding:** The agents-personal README lists existing framework agents. The six new PM system agents (ProjectManager, ProductOwner, FrontendDev, BackendDev, QAEngineer, UIUXDesigner) are new agents not yet present in the README.
- **Alignment condition:** These six agents are "to be added" when Builder generates their templates in a future phase.
- **Resolution recommendation:** Builder must add entries for all six new agents to the agents-personal README agent table when generating their templates. This is a Builder task, not a Phase 6 write action.
- **Phase 6 action:** Read-only verification only. No modification to agents-personal README in this phase.

### Check 2: agents-personal ADR Consistency

- **Sources checked:** ADR-001 (orchestration), ADR-002 (task-centric persistence), ADR-005 (IDE compatibility), ADR-007 (rationalization prevention)
- **Finding:** No ADR entry contradicts Phase 6 permission tier definitions.
  - ADR-001 conductor pattern → consistent with Tier O `disable-model-invocation` and delegation-only model.
  - ADR-005 IDE namespace separation → consistent with Copilot vs CC tool identifier rules in Phase 6.
  - ADR-007 rationalization prevention → directly incorporated into enforcement Layer 1 template body requirements and drift detection conditions.
- **Discrepancies:** None detected.
- **Phase 6 action:** Read-only verification only. No ADR modifications in this phase.

### Check 3: `.github/copilot-instructions.md` Diagram Lifecycle

- **Source:** `VIP/.github/copilot-instructions.md`
- **Finding:** The four-step Mermaid diagram lifecycle (write `.mmd` source → render → insert image reference → verify manifest) is consistent with UIUXDesigner Tier RW-D write scope and execute scope defined in Phase 6.
  - Step 2 (render) → maps to UIUXDesigner `execute/runInTerminal` for `mmdc` only.
  - Step 3 (insert image reference) → maps to UIUXDesigner `docs/` write permission for diagram-adjacent image references only.
- **Discrepancies:** None detected.
- **Phase 6 action:** Read-only verification only.

---

## Plan-Only Boundary Check

All Phase 6 file create/update targets have been verified as within `.tasks/005-pm-agent-system/**`. No file outside this path was created or modified.

| Action | Target Path | In-Boundary? |
| --- | --- | --- |
| Create directory | `.tasks/005-pm-agent-system/artifacts/phase-6/` | ✅ Yes |
| Create | `.tasks/005-pm-agent-system/artifacts/phase-6/phase-6-permission-tier-definitions.md` | ✅ Yes |
| Create | `.tasks/005-pm-agent-system/artifacts/phase-6/phase-6-agent-permission-tier-table.md` | ✅ Yes |
| Create | `.tasks/005-pm-agent-system/artifacts/phase-6/phase-6-tooling-boundary-matrix.md` | ✅ Yes |
| Create | `.tasks/005-pm-agent-system/artifacts/phase-6/phase-6-execute-scope-boundary.md` | ✅ Yes |
| Create | `.tasks/005-pm-agent-system/artifacts/phase-6/phase-6-enforcement-mechanisms.md` | ✅ Yes |
| Create | `.tasks/005-pm-agent-system/artifacts/phase-6/phase-6-cross-agent-consistency-check.md` | ✅ Yes |
| Create | `.tasks/005-pm-agent-system/artifacts/phase-6/phase-6-drift-detection-checklist.md` | ✅ Yes |
| Create | `.tasks/005-pm-agent-system/artifacts/phase-6/phase-6-source-traceability-matrix.md` | ✅ Yes |
| Update | `.tasks/005-pm-agent-system/task.md` | ✅ Yes |
| **Any file outside `.tasks/005-pm-agent-system/**`** | — | ❌ None detected |
