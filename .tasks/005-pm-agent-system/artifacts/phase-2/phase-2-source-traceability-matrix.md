---
artifact: phase-2-source-traceability-matrix
task: 005-pm-agent-system
phase: 2
created: 2026-03-18
status: complete
sources:
  - agents-personal/README.md
  - agents-personal/templates/README.md
  - agents-personal/docs/architecture/ADR-001-orchestration-and-subagents.md
  - agents-personal/docs/architecture/ADR-002-task-centric-persistence.md
  - agents-personal/docs/architecture/ADR-004-skill-powered-subagents.md
  - agents-personal/docs/architecture/ADR-005-ide-compatibility.md
  - agents-personal/docs/architecture/ADR-007-rationalization-prevention.md
  - agents-personal/docs/synthesis/skills.md
---

# Phase 2 Source Traceability Matrix

## Purpose

This matrix provides a row-per-normative-rule trace from every significant Phase 2 skill rule to its source document, source clause, implementation note, and verification evidence. It satisfies CP-2.2 of the Phase 2 governance model.

> **Minimum columns required (from phase plan):** `skill rule`, `source doc`, `source clause`, `implementation note`, `verification evidence`

---

## Matrix

| # | Skill Rule | Skill(s) | Source Doc | Source Clause | Implementation Note | Verification Evidence |
|---|-----------|----------|-----------|--------------|--------------------|-----------------------|
| TR-001 | Every skill must include minimum 5 trigger phrase variants in description | All 5 | `agents-personal/docs/synthesis/skills.md` | §Quality Checklist: "Trigger Clarity — Are activation keywords specific and discoverable?" | All five skills define 9–10 trigger phrases in their Trigger Catalog (phase-2-skill-contracts.md §Trigger Catalog per skill) | Count trigger phrases in `phase-2-skill-contracts.md`; minimum 5 per skill |
| TR-002 | Trigger keywords must appear in SKILL.template.md `description` field for auto-activation | All 5 | `agents-personal/templates/README.md` | §Frontmatter Structure §Skill Template Frontmatter: "description must contain trigger keywords" | Template specs for all five skills embed trigger phrases verbatim in frontmatter `description` skeleton (phase-2-template-specs.md §Frontmatter Skeleton per skill) | Check `description` field in each frontmatter skeleton for trigger keyword presence |
| TR-003 | Each skill must have a distinct primary intent with no overlap in output artifact type | All 5 | `agents-personal/docs/synthesis/skills.md` | §Skill Review Criteria: "Minimal overlap with existing skills"; §Quality Checklist "Overlap — <20% overlap" | Overlap disambiguation table in `phase-2-skill-contracts.md` §Cross-Skill Overlap Disambiguation Table defines priority rules and routing | Review Cross-Skill Overlap Disambiguation Table; confirm each skill maps to a unique output artifact type |
| TR-004 | Each skill must have exactly one escalation path | All 5 | `agents-personal/docs/architecture/ADR-001-orchestration-and-subagents.md` | §Mandatory Pause Points; §Checkpoint Enforcement | Each skill contract defines exactly one escalation path in the Handoff Contract section (Escalation path row) | Count Escalation path rows in each skill's Handoff Contract; verify exactly one per skill |
| TR-005 | Skills must be under 500 lines (progressive disclosure) | All 5 | `agents-personal/docs/synthesis/skills.md` | §What We Adopted: "Progressive disclosure (<500 lines for main skill file)" | Template specs include body block outlines with bounded sections; rationalization prevents scope bloat | Count lines in each template spec's body block list; confirm feasibility ≤ 500 lines |
| TR-006 | Skill templates must include a rationalization prevention table (≥3 rows, 3-column format) | All 5 | `agents-personal/docs/architecture/ADR-007-rationalization-prevention.md` | §Table Format: "`| Excuse | Reality | Required Action |` format" | Each skill in `phase-2-template-specs.md` defines a Rationalization Prevention Rows section with ≥3 rows | Count rows in each Rationalization Prevention Rows section in `phase-2-template-specs.md` |
| TR-007 | Copilot output for skills: `name` + `description` only | All 5 | `agents-personal/templates/README.md` | §Skill Template Frontmatter Generation Rules: "Copilot output: name, description only" | All five frontmatter skeletons include only `name` and `description` at root level (outside `cc:` block) | Review `phase-2-template-specs.md` frontmatter skeletons; confirm no Copilot-specific fields at root |
| TR-008 | CC output for skills: `name` + `description` + `cc:` fields flattened | All 5 | `agents-personal/templates/README.md` | §Skill Template Frontmatter Generation Rules: "CC output: name, description + all cc: fields (flattened)" | All five frontmatter skeletons include `cc: context` and `cc: allowed-tools` for CC enhancement | Review `phase-2-template-specs.md` frontmatter skeletons; confirm `cc:` block present |
| TR-009 | No `copilot:` section in skill templates | All 5 | `agents-personal/templates/README.md` | §Skill Template Frontmatter: "Skills have simpler structure — Copilot uses only name and description" | No `copilot:` block appears in any of the five skill frontmatter skeletons | Grep `phase-2-template-specs.md` for "copilot:"; must return no results within frontmatter skeletons |
| TR-010 | `cc.context: fork` for isolated execution in all PM system skills | All 5 | `agents-personal/templates/README.md` | §Skill Template Frontmatter: "cc: context: fork" | All five template specs include `context: fork` in `cc:` block | Check `cc.context` in each frontmatter skeleton in `phase-2-template-specs.md` |
| TR-011 | Skills 3 (requirements-cascade) and 5 (diagram-generation) must NOT have `Write` in `allowed-tools` | `requirements-cascade`, `diagram-generation` | Phase 2 plan (phase-2-skill-template-set.md) | REQ-202: plan-only mode; CON-201: no production edits | Template specs for skills 3 and 5 explicitly note `Write` excluded from `allowed-tools` with plan-only rationale | Check `allowed-tools` in `phase-2-template-specs.md` skills 3 and 5; confirm no `Write` |
| TR-012 | Platform-specific blocks in template bodies require both opening and closing tags | All 5 | `agents-personal/templates/README.md` | §Rules Rule 3: "Platform blocks require closing tags"; §Validation Rules: unclosed blocks are generator errors | All `<!-- COPILOT-ONLY -->` and `<!-- CC-ONLY -->` blocks in template specs include corresponding closing tags | Review Platform-Specific Sections tables in `phase-2-template-specs.md`; confirm paired opening/closing directives |
| TR-013 | No nesting of conditional directives | All 5 | `agents-personal/templates/README.md` | §Rules Rule 5: "No nesting — directives cannot contain other directives" | Template specs define platform blocks at top level only; no nested `CC-ONLY` inside `COPILOT-ONLY` | Inspect Platform-Specific Sections in each template spec; confirm no nested directive references |
| TR-014 | Checkpoints fire unconditionally — cannot be suppressed by user or agent | All 5 | `agents-personal/docs/architecture/ADR-001-orchestration-and-subagents.md` | §Checkpoint Enforcement: "Checkpoints fire unconditionally — even if user says 'plan only' or 'skip implementation'" | All checkpoint conditions in skill contracts use absolute triggers (no conditions that allow bypass) | Review Checkpoint Touchpoints tables; confirm no "if user requests" bypass clauses |
| TR-015 | Checkpoint headers must be visually distinct (`### 🛑 CHECKPOINT`) as separate workflow steps | All 5 | `agents-personal/docs/architecture/ADR-001-orchestration-and-subagents.md` | §Checkpoint Enforcement: "Visual CHECKPOINT headers as distinct workflow steps" | Template specs specify Checkpoint Conditions as named blocks; `### 🛑 CHECKPOINT` header required in template bodies | Template body Required Body Blocks tables include "Checkpoint Conditions" as a named block for each skill |
| TR-016 | Copilot checkpoint pause uses `askQuestions` tool; CC uses `AskUserQuestion` | All 5 | `agents-personal/docs/architecture/ADR-001-orchestration-and-subagents.md` | §Mandatory Pause Points: "askQuestions (CC: AskUserQuestion)" | Platform-specific sections in all skill template specs define correct checkpoint pause tools per platform | Check Platform-Specific Sections in `phase-2-template-specs.md`; confirm `askQuestions` (Copilot) and `AskUserQuestion` (CC) |
| TR-017 | Subagent invocation uses Worker agent with skill trigger keywords in prompt | All 5 | `agents-personal/docs/architecture/ADR-004-skill-powered-subagents.md` | §Subagent Prompt Structure: "Run the [Worker] agent as a subagent: [Skill trigger phrase]." | All five Invocation Patterns sections in `phase-2-skill-contracts.md` include canonical Worker subagent prompt with skill trigger phrase | Review Invocation Patterns sections in `phase-2-skill-contracts.md`; confirm Worker + trigger phrase pattern |
| TR-018 | CC subagent invocation uses `Task(Worker, "...")` syntax | All 5 | `agents-personal/docs/architecture/ADR-005-ide-compatibility.md` | §Conditional Directives table: "Subagent invocation — CC: Task(Agent, 'prompt')" | CC canonical invocation examples in `phase-2-orchestration-invocation-map.md` use `Task(Worker, ...)` syntax | Review Example 1B, 2B, 3B, 4B, 5B in `phase-2-orchestration-invocation-map.md`; confirm `Task(Worker, ...)` format |
| TR-019 | Copilot subagent invocation uses "Run the [Agent] agent as a subagent" prose syntax | All 5 | `agents-personal/docs/architecture/ADR-005-ide-compatibility.md` | §Conditional Directives table: "Subagent invocation — Copilot: 'Run the X agent as a subagent'" | Copilot canonical invocation examples (1A, 2A, 3A, 4A, 5A) use "Run the Worker agent as a subagent" prose | Review Example 1A, 2A, 3A, 4A, 5A in `phase-2-orchestration-invocation-map.md` |
| TR-020 | Subagent context is isolated; parent receives summary only | All 5 | `agents-personal/docs/architecture/ADR-004-skill-powered-subagents.md` | §Factor Comparison: "Subagent context garbage-collected; Summary only returned" | All Worker subagent invocation examples specify "Return: [summary spec]" at end of prompt | Check Return: clauses in all canonical invocation examples in `phase-2-orchestration-invocation-map.md` |
| TR-021 | ProjectManager cannot invoke any skill directly (read-only orchestrator) | All 5 | `agents-personal/docs/architecture/ADR-001-orchestration-and-subagents.md` | §Conductor Agent Pattern: "You do NOT do the work directly"; Phase 1 SCP-007 | Disallowed callers for all five skills list ProjectManager; invocation map section 6 includes explicit PM restriction | Check Disallowed Callers in invocation matrix; check section 6 of `phase-2-orchestration-invocation-map.md` |
| TR-022 | Worker agent must be `user-invokable: false` | `resource-ingestion`, `stakeholder-feedback`, `requirements-cascade`, `backlog-management`, `diagram-generation` (Worker used by all) | `agents-personal/docs/architecture/ADR-001-orchestration-and-subagents.md` | §Worker Subagent Pattern: "user-invokable: false" | Phase 1 reuse-map §2 documents Worker `user-invokable: false` as a "Reuse as-is" decision | Confirm Worker agent frontmatter sets `user-invokable: false` (existing agent, not modified here) |
| TR-023 | Subagents cannot spawn sub-subagents (CC platform constraint) | All 5 | `agents-personal/docs/architecture/ADR-001-orchestration-and-subagents.md` | §CC constraint: "Subagents cannot spawn sub-subagents" | Invocation map section 6 explicitly lists sub-subagent spawning as disallowed; requirements-cascade non-goal blocks recursive invocation | Check section 6 of `phase-2-orchestration-invocation-map.md` for this rule |
| TR-024 | Each skill output schema must map to concrete 2026_01_VIP artifact paths | All 5 | Phase 2 plan (phase-2-skill-template-set.md) | REQ-203: "Each output contract must map to concrete 2026_01_VIP target locations" | All five output schemas specify `artifact_path` with concrete `learning_base/`, `diagrams/`, or `.tasks/` paths | Check `artifact_path` field in each skill's Output Schema in `phase-2-skill-contracts.md` |
| TR-025 | VoC artifacts must follow `voc_{NNN}_{slug}.md` naming convention | `stakeholder-feedback` | Phase 1 interface-map.md §3 Agent Output Contract Map | ProductOwner output: `learning_base/11_voice_of_customer/voc_{NNN}_{slug}.md` | Stakeholder-feedback output schema specifies VoC naming convention and references existing VoC examples | Check Output Schema naming convention in `phase-2-skill-contracts.md` §Skill 2 |
| TR-026 | Ingestion artifacts must go to correct `learning_base/` subdirectory per resource type | `resource-ingestion` | Phase 1 interface-map.md §4 Skill-to-Path Binding Map | resource-ingestion → `learning_base/` appropriate subdirectory | Classification rules table in skill contract defines default target per resource_type | Check Classification Rules table in `phase-2-skill-contracts.md` §Skill 1 |
| TR-027 | Backlog artifacts must go to `learning_base/planner_updates/` | `backlog-management` | Phase 1 interface-map.md §3 Agent Output Contract Map | ProductOwner/ScrumMaster → `learning_base/planner_updates/` | Backlog-management output schema specifies `learning_base/planner_updates/backlog_{YYYYMMDD}_{slug}.md` | Check artifact_path in `phase-2-skill-contracts.md` §Skill 4 Output Schema |
| TR-028 | Diagram source files must go to `diagrams/`; rendered exports to `images/diagrams/` | `diagram-generation` | Phase 1 interface-map.md §3: UIUXDesigner output paths | `diagrams/` (source), `images/diagrams/` (export, future) | Diagram-generation output schema specifies `source_file` in `diagrams/` and `render_target` in `images/diagrams/` | Check Output Schema fields `source_file` and `render_target` in `phase-2-skill-contracts.md` §Skill 5 |
| TR-029 | Diagram generation must comply with Mermaid lifecycle rules in `.github/copilot-instructions.md` | `diagram-generation` | Phase 1 task.md §Research Findings: "Mermaid lifecycle requirements defined in .github/copilot-instructions.md" | Mermaid lifecycle compliance reference | Skill contract requires `lifecycle_compliance_check` field; skill template spec includes Mermaid Lifecycle Compliance body block | Check `lifecycle_compliance_check` in `phase-2-skill-contracts.md` §Skill 5 Output Schema |
| TR-030 | Cascade plan output must be plan-only; Worker/Builder execute the edits | `requirements-cascade` | Phase 2 plan REQ-202 (plan-only mode); Phase 2 skill contracts §Skill 3 Non-Goals | Non-goal: "Does NOT apply document edits autonomously" | `allowed-tools` for requirements-cascade excludes `Write`; execution_queue delegated to Worker/Builder | Check `allowed-tools` in `phase-2-template-specs.md` §Skill 3 frontmatter skeleton |
| TR-031 | Task files must persist to `.tasks/[NNN-slug]/` with descriptive filenames | All artifacts (phase-2 deliverables) | `agents-personal/docs/architecture/ADR-002-task-centric-persistence.md` | §Directory Structure: `.tasks/[NNN-slug]/task.md` | All Phase 2 artifacts are written to `.tasks/005-pm-agent-system/artifacts/phase-2/` | Verify all Phase 2 deliverable paths start with `.tasks/005-pm-agent-system/` |
| TR-032 | Phase status must use standard progression symbols | `task.md` phase table | `agents-personal/docs/architecture/ADR-002-task-centric-persistence.md` | §Task File Structure: "⬜ Not Started → 📋 Planned → ⭐ Reviewed → 🔄 In Progress → ✅ Done" | `task.md` Phase 2 row updated to `✅ Done` upon Builder execution | Confirm Phase 2 row in `task.md` phase table shows `✅ Done` after this phase is complete |
| TR-033 | Agents use persona names (nouns), not verb-based names, to avoid CC built-in conflicts | All agent references | `agents-personal/docs/architecture/ADR-005-ide-compatibility.md` | §Agent Naming Convention: "Agents use persona names (nouns) rather than verb-based names" | All skill contracts and invocation map use PersonaName format: ProductOwner, BusinessAnalyst, ScrumMaster, UIUXDesigner, Worker, ProjectManager | Review all agent references in Phase 2 artifacts; confirm PascalCase persona naming |
| TR-034 | Handoff buttons are Copilot-only; CC uses instructional text | All 5 (invocation map) | `agents-personal/docs/architecture/ADR-005-ide-compatibility.md` | §Acceptable Losses by Platform: "Claude Code: Handoff UI buttons → Instructions guide next steps" | Orchestration-invocation-map §3 includes a Handoff Buttons table with Copilot and CC equivalents | Review §3 Handoff Buttons table in `phase-2-orchestration-invocation-map.md` |
| TR-035 | Skill activation is auto-triggered by keywords; no slash command system | All 5 | `agents-personal/docs/synthesis/skills.md` | §What We Adopted: "Rich skill descriptions with trigger keywords for discovery"; §Rejected: "Command system (/superpowers:brainstorm)" | Skill contracts use trigger phrase model for activation; no slash command references | Confirm no `/skill-name:...` slash command syntax in any Phase 2 artifact |
| TR-036 | TDD skill testing: validate skills with RED/GREEN test scenarios | All 5 | `agents-personal/docs/synthesis/skills.md` | §TDD Skill Testing: "Watch agent fail without skill (RED), write skill (GREEN), close loopholes (REFACTOR)" | Phase 2 is planning-only; TDD validation is deferred to Builder phase when templates are created | Future Builder phase must include RED/GREEN test scenarios for each skill before production deployment |
| TR-037 | Skills evaluated against Quality Checklist before acceptance (Distinct Value, Trigger Clarity, Constraint/Mode, Size, Overlap, TDD Testable) | All 5 | `agents-personal/docs/synthesis/skills.md` | §Skill Evaluation Checklist: "4+ criteria = strong skill" | Each skill in Phase 2 satisfies: Distinct Value (unique output artifact), Trigger Clarity (9–10 triggers), Constraint/Mode (distinct behavioral constraints), Overlap (disambiguation table), Size (<500 lines spec'd) | Apply Skill Evaluation Checklist to each skill during Builder phase; document scoring |
| TR-038 | Subagent invocation: agent choice is Worker (full access) or Researcher (read-only) | All 5 | `agents-personal/docs/architecture/ADR-004-skill-powered-subagents.md` | §Subagent Prompt Structure: "Agent choice: Worker (full access) or Research (read-only)" | All skill invocation patterns specify Worker as subagent; read-only operations do not use Worker for skills that exclude `Write` | Check canonical invocation examples in `phase-2-orchestration-invocation-map.md`; all use Worker |
| TR-039 | Each skill must have non-overlapping primary intent (SC-208) | All 5 | Phase 2 plan (phase-2-skill-template-set.md) | SC-208: "Acceptance gate: reviewer confirms all five skills have non-overlapping primary intent" | Cross-Skill Overlap Disambiguation Table in `phase-2-skill-contracts.md` defines routing priority rules; each skill maps to exactly one output artifact type | Review table; confirm no two skills share primary output artifact type |
| TR-040 | Scope of Phase 2 writes is restricted to `.tasks/005-pm-agent-system/` | All Phase 2 deliverables | Phase 2 plan CON-202: "Writes are restricted to .tasks/005-pm-agent-system/**" | CON-202 | All four Phase 2 artifacts and the task.md update are in `.tasks/005-pm-agent-system/` | Verify no files outside `.tasks/005-pm-agent-system/` were created or modified in Phase 2 |

---

## Source Coverage Summary

| Source Document | Rules Covered | TR Numbers |
|----------------|--------------|------------|
| `agents-personal/docs/synthesis/skills.md` | Trigger clarity, overlap, progressive disclosure, TDD testing, skill evaluation | TR-001, TR-003, TR-005, TR-035, TR-036, TR-037 |
| `agents-personal/templates/README.md` | Frontmatter rules, generation rules, directive syntax, validation | TR-002, TR-007, TR-008, TR-009, TR-010, TR-012, TR-013 |
| `agents-personal/docs/architecture/ADR-001-orchestration-and-subagents.md` | Checkpoint rules, subagent scope, PM read-only, Worker pattern | TR-014, TR-015, TR-016, TR-021, TR-022, TR-023 |
| `agents-personal/docs/architecture/ADR-002-task-centric-persistence.md` | Task file persistence, phase status symbols | TR-031, TR-032 |
| `agents-personal/docs/architecture/ADR-004-skill-powered-subagents.md` | Subagent invocation pattern, context isolation, summary return | TR-017, TR-020, TR-038 |
| `agents-personal/docs/architecture/ADR-005-ide-compatibility.md` | CC vs Copilot syntax, persona naming, handoff buttons | TR-018, TR-019, TR-033, TR-034 |
| `agents-personal/docs/architecture/ADR-007-rationalization-prevention.md` | Rationalization prevention table format and placement | TR-006 |
| Phase 1 artifacts (reuse-map, interface-map, orchestration-guidelines) | Output paths, PM constraints, ORC rules | TR-011, TR-024, TR-025, TR-026, TR-027, TR-028, TR-030 |
| Phase 2 plan (phase-2-skill-template-set.md) | REQ-201–206, CON-201–202, SC-208 | TR-011, TR-024, TR-039, TR-040 |
| `.github/copilot-instructions.md` (2026_01_VIP) | Mermaid lifecycle compliance | TR-029 |

---

## Acceptance Gate Evidence (SC-208)

This section provides the evidence required for the non-overlapping primary intent acceptance gate.

| Skill | Primary Output Artifact Type | Primary Output Path | Overlap with Others? |
|-------|----------------------------|--------------------|-----------------------|
| `resource-ingestion` | Ingestion summary document | `learning_base/{subdirectory}/ingestion_{YYYYMMDD}_{slug}.md` | ❌ None — unique output type |
| `stakeholder-feedback` | Voice of Customer record | `learning_base/11_voice_of_customer/voc_{NNN}_{slug}.md` | ❌ None — unique VoC path |
| `requirements-cascade` | Cascade plan + execution queue | `learning_base/09_decisions/cascade_{YYYYMMDD}_{slug}.md` | ❌ None — plan-only, no document edits |
| `backlog-management` | MoSCoW backlog slice | `learning_base/planner_updates/backlog_{YYYYMMDD}_{slug}.md` | ❌ None — unique backlog artifact |
| `diagram-generation` | Diagram change specification + render commands | `learning_base/09_decisions/diagram_spec_{YYYYMMDD}_{slug}.md` | ❌ None — unique diagram spec |

**Escalation path summary (one per skill):**

| Skill | Escalation Path |
|-------|----------------|
| `resource-ingestion` | → ProductOwner (via CP-RI-2 action_flags review) |
| `stakeholder-feedback` | → ProductOwner (via CP-SF-1 escalation_flag) |
| `requirements-cascade` | → ProjectManager (via CP-RC-4 urgent priority) |
| `backlog-management` | → ProductOwner (via CP-BM-3 VoC escalation conflict) |
| `diagram-generation` | → ProjectManager (via CP-DG-1 new diagram creation scope) |

All five skills have distinct primary intent and exactly one escalation path. ✅ SC-208 acceptance gate criteria met.
