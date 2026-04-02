---
artifact: phase-1-orchestration-skill-invocation-guidelines
task: 005-pm-agent-system
phase: 1
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

# Phase 1 Orchestration, Skill, and Invocation Guidelines

## Purpose

This document consolidates mandatory rules from the agents-personal README and ADRs for use during PM agent system design (Phases 2–8). Each rule section includes a requirement-to-source mapping table.

> **Source-priority note:** Where README prose and ADR text differ, the ADR takes precedence as the authoritative decision record (RISK-001 mitigation per phase-1 plan).

---

## 1. Orchestration Checkpoints

### Rules

| Rule ID | Rule | Source |
|---|---|---|
| ORC-001 | Every multi-phase workflow must include mandatory pause points implemented via `AskUserQuestion` (CC) or `askQuestions` (Copilot). | ADR-001 §Mandatory Pause Points |
| ORC-002 | Checkpoints must fire **unconditionally**. Even if the user says "plan only" or "skip implementation", the checkpoint still presents options. | ADR-001 §Checkpoint Enforcement: "Checkpoints fire unconditionally" |
| ORC-003 | Checkpoint headers must be visually distinct (`### 🛑 CHECKPOINT`) and placed as separate workflow steps — not as notes at the end of action sequences. | ADR-001 §Checkpoint Enforcement: "Visual CHECKPOINT headers as distinct workflow steps" |
| ORC-004 | Each checkpoint is a separate user decision point. Batching checkpoints is prohibited. | ADR-001 Rationalization Prevention Table: "I can batch these checkpoints" |
| ORC-005 | The Phase Implemented checkpoint must offer at minimum: `[Commit]`, `[Verify]`, `[Abort]`. | ADR-001 §Mandatory Pause Points checkpoint table |
| ORC-006 | Orchestrators must maintain a Position Lock: exactly ONE `[in-progress]` todo item = current instruction. Before any action, verify the in-progress item matches the intended action. | ADR-001 §Position Lock |
| ORC-007 | Entry Gate: orchestrators must read `.tasks/` directory as their FIRST tool call before responding to any user message. No exceptions, including urgent bugs or "quick" questions. | ADR-001 §Entry Gate pattern; §First Action Protocol Enforcement |
| ORC-008 | Conductors/orchestrators must NEVER research, analyze code, or read source files for understanding. All such work is delegated to Explorer or Researcher. | ADR-001 §Conductor constraints |
| ORC-009 | Conductors/orchestrators must NEVER edit files directly. All file edits are delegated to Builder. | ADR-001 §Conductor constraints |
| ORC-010 | Mode is set once per task (Full Execution vs Plan Only) and recorded in task frontmatter. Mode ambiguity causes inconsistent behavior. | ADR-001 §Mode Simplification |

### Checkpoint Standard Pause-Point Table (canonical)

Source: ADR-001 §Mandatory Pause Points

| Pause Point | Trigger | User Action |
|---|---|---|
| Task Created | After Explorer/orchestrator creates phases | Approve task structure |
| Phase Plan Ready | After plan + review | Approve plan, adopt fixes |
| Phase Implemented | After Builder + Reviewer | `[Commit]` / `[Verify]` / `[Abort]` |

### PM System Mapping

| PM Checkpoint | Maps To | Implementing Agent |
|---|---|---|
| Stakeholder intake confirmed | Task Created equivalent | ProductOwner |
| Requirements cascade review | Phase Plan Ready equivalent | BusinessAnalyst → ProjectManager |
| Sprint plan approved | Phase Implemented equivalent | ScrumMaster → ProjectManager |
| Quality gate outcome | Abort/Continue decision | ProjectManager |

---

## 2. Subagent Scope Restrictions

### Rules

| Rule ID | Rule | Source |
|---|---|---|
| SCP-001 | Each agent declares which subagents it may invoke via `agents:` frontmatter. It may ONLY invoke those declared agents. | ADR-001 §Scope Enforcement via `agents` Restriction |
| SCP-002 | Internal agents (Worker, Researcher) must set `user-invokable: false` to hide them from user-facing invocation lists. | ADR-001 §Worker Subagent Pattern: `user-invokable: false` |
| SCP-003 | `disable-model-invocation: true` prevents an agent from being auto-invoked by the model. Use for orchestrators that must be explicitly user-invoked (Conductor/ProjectManager). | ADR-001 §Conductor Agent Pattern |
| SCP-004 | Subagents are context-isolated: each invocation is fresh, subagents do not share state with each other. | ADR-001 §Context note: "Each invocation is fresh — subagents don't share state" |
| SCP-005 | Subagents return summaries only. The parent context receives only the result summary; full reasoning is garbage-collected. | ADR-004 §Factor Comparison |
| SCP-006 | Scope enforcement is implemented via `disallowedTools` in frontmatter. Read-only agents must list Edit, Write, Bash as disallowed. | ADR-001 §Conductor Agent Pattern: `disallowedTools: [Edit, Write, Bash, Grep]` |
| SCP-007 | CC platform constraint: Conductor/PM agents may ONLY use Read and Glob on paths within `.tasks/`. Any other path requires a `Task()` delegation. | ADR-001 §CC constraint |
| SCP-008 | CC platform constraint: Subagents cannot spawn sub-subagents. Only the direct parent agent may invoke subagents. | ADR-001 §CC constraint: "Subagents cannot spawn sub-subagents" |

### Canonical `agents:` Restriction Table (agents-personal baseline)

Source: ADR-001 §Solution: After diagram + §Scope Enforcement

| Parent Agent | Allowed Subagents (`agents:`) |
|---|---|
| Conductor | Explorer, Builder, Reviewer, Committer, Worker |
| Builder | Worker |
| Reviewer | Worker |
| Committer | Researcher |
| Explorer | Explorer (self-recurse), Researcher |

### PM System Scope Restriction Table (Phase 5 input)

| PM Agent | Allowed Subagents | Rationale |
|---|---|---|
| ProjectManager | ProductOwner, BusinessAnalyst, ScrumMaster, FrontendDev, BackendDev, QAEngineer, UIUXDesigner | PM is the top-level orchestrator; Worker excluded (REQ-002) |
| ProductOwner | BusinessAnalyst, ScrumMaster, Worker | Limited write agent; Worker invoked for conversion/processing tasks |
| ScrumMaster | Worker | Execution delegation only |
| BusinessAnalyst | Worker | Isolated document conversion or update tasks |
| FrontendDev | (none) | Read-only advisory; no delegation |
| BackendDev | (none) | Read-only advisory; no delegation |
| QAEngineer | Worker | Test execution delegation |
| UIUXDesigner | Worker | Diagram generation execution delegation |

---

## 3. Skill Trigger and Delegation Behavior

### Rules

| Rule ID | Rule | Source |
|---|---|---|
| SKL-001 | Skills auto-activate based on trigger keywords in the user's prompt. No manual invocation is required. | README.md §Skills (Auto-Activate) |
| SKL-002 | Skill descriptions must include explicit trigger keywords so discovery works. Trigger keywords must match user vocabulary. | docs/synthesis/skills.md §Skill Evaluation Checklist: "Trigger Clarity" |
| SKL-003 | Skills must have distinct behavioral constraints — not just format guidance. A skill must meaningfully change how an agent acts, not just how output looks. | docs/synthesis/skills.md §Skill Evaluation Checklist: "Constraint/Mode" |
| SKL-004 | Skills must be under 500 lines. Core content stays focused; reference material is split out. | docs/synthesis/skills.md §Skill Evaluation Checklist: "Size" |
| SKL-005 | Skills must be TDD-tested: observe the agent fail without the skill (RED), write the skill (GREEN), close loopholes (REFACTOR). | docs/synthesis/skills.md §TDD Skill Testing; README.md §Validating Skills |
| SKL-006 | New skills must pass the overlap test before creation: less than 20% overlap with existing skills. | docs/synthesis/skills.md §Skill Evaluation Checklist: "Overlap" |
| SKL-007 | When an agent needs a skill in a context-isolated task, it invokes the skill via a subagent prompt containing the skill trigger keywords. | ADR-004 §Pattern |
| SKL-008 | Skill-powered subagent pattern: `Run the [Worker|Researcher] agent as a subagent: [skill trigger phrase]. [Task description]. Return: [what parent needs].` | ADR-004 §Subagent Prompt Structure |
| SKL-009 | The skill's progressive loading (discovery → instructions → resources) happens in the subagent's isolated context. Only the summary returns to the parent. | ADR-004 §Key Insights |
| SKL-010 | Copilot platform: skills are declared in `cc.skills` frontmatter array. VS Code uses `chat.skillsFilesLocations`. | ADR-005 §Compatibility Layers |

### Canonical Agent → Skill Pairings (agents-personal baseline)

Source: ADR-004 §Common Agent → Skill Pairings

| Agent | Skill | Trigger Scenario |
|---|---|---|
| Explorer | architecture | Understanding system structure |
| Explorer | deep-research | Exhaustive investigation with citations |
| Builder | debug | Tests failing during implementation |
| Builder | mentor | Learning while implementing |
| Reviewer | critic | Stress-testing implementation |
| Reviewer | tech-debt | Code quality and smell detection |
| Reviewer | security | Attack surface analysis |

### PM System Skill Delegation Matrix (Phase 2 input)

| PM Agent | Skill | Trigger Scenario |
|---|---|---|
| BusinessAnalyst | prd | "write a PRD", "document requirements" |
| BusinessAnalyst | breakdown-epic-pm | "break down this epic", "PM breakdown" |
| BusinessAnalyst | breakdown-feature-prd | "spec out this feature", "feature PRD" |
| BusinessAnalyst | update-specification | "update the spec", "add to data model" |
| BusinessAnalyst | architecture-blueprint-generator | "document the architecture of" |
| ProductOwner | resource-ingestion | "ingest this email/doc/link", "capture this input" |
| ProductOwner | stakeholder-feedback | "process stakeholder feedback", "structure VoC" |
| ProductOwner | backlog-management | "prioritize backlog", "MoSCoW scoring" |
| ScrumMaster | backlog-management | "sprint planning", "velocity breakdown" |
| UIUXDesigner | diagram-generation | "generate diagram", "update Mermaid" |
| BusinessAnalyst | requirements-cascade | "cascade requirement update", "propagate change" |

---

## 4. Invocation Patterns (VS Code and CC Semantics)

### Rules

| Rule ID | Rule | Source |
|---|---|---|
| INV-001 | VS Code agent invocation: `@AgentName` inline in chat, or handoff buttons in agent UI. | README.md §The Workflow; ADR-005 §Support Matrix |
| INV-002 | CC agent invocation: `use AgentName` in chat, or `claude --agent AgentName` from shell, or `Task(AgentName, "prompt")` for subagent delegation. | README.md §Claude Code Usage; ADR-005 §Compatibility Layers |
| INV-003 | Handoff buttons (VS Code only): keep chat context and history. No reset on handoff. CC equivalent is instructions guiding the user to invoke the next agent manually. | README.md §Handoff Buttons; ADR-005 §Acceptable Losses |
| INV-004 | Agent names must use persona (noun) form to avoid collision with IDE built-in verb agents (`Explore`, `Plan`, etc.). Examples: Explorer, Builder, Reviewer, Committer. | ADR-005 §Agent Naming Convention |
| INV-005 | VS Code subagent invocation: "Run the X agent as a subagent: [task]". CC subagent invocation: `Task(AgentName, "prompt")`. | ADR-005 §Conditional Directives; templates/README.md §E3 |
| INV-006 | Platform-specific tool names differ completely between Copilot and CC — they must use separate `copilot.tools` and `cc.tools` arrays. There is no cross-platform mapping. | templates/README.md §E4 Platform-Specific Tool Names |
| INV-007 | Platform-specific model names differ: Copilot uses `["Claude Opus 4.5 (copilot)"]`, CC uses `opus` or `sonnet`. Separate `copilot.model` and `cc.model` fields. | templates/README.md §E5 Platform-Specific Model Names |
| INV-008 | Internal agents (Worker, Researcher) have no CC-only body content — the template body is identical for both platforms. Platform body sections are `<!-- CC-ONLY -->` / `<!-- COPILOT-ONLY -->`. | templates/README.md §E1 |
| INV-009 | Copilot `agents:` frontmatter restricts which subagents a Copilot agent may invoke. CC uses `Task(AgentName)` in `cc.tools` array. | templates/README.md §E3; ADR-001 §Scope Enforcement |

### Platform Feature Parity Table

Source: ADR-005 §Support Matrix

| Feature | VS Code | Claude Code | Cursor | IntelliJ |
|---|---|---|---|---|
| Agents | ✅ Hard enforcement | ✅ Hard enforcement | ❌ | ❌ |
| Skills | ✅ | ✅ | ✅ | ❌ |
| Instructions | ✅ | ✅ | ❌ | ✅ (global only) |
| Tool restrictions | ✅ | ✅ | ❌ | ❌ |
| Handoff buttons | ✅ | ❌ (instructions guide) | ❌ | ❌ |

### Invocation Syntax Comparison

Source: ADR-005 §Conditional Directives

| Pattern | VS Code Copilot | Claude Code |
|---|---|---|
| User prompt to agent | `askQuestions` tool | `AskUserQuestion` tool |
| Subagent invocation | "Run the X agent as a subagent" | `Task(Agent, "prompt")` |
| Directory listing | `list_dir` tool | `LS` / `Glob` tools |
| Workflow transitions | Handoff buttons | Instructions guide next steps |

---

## 5. IDE Compatibility Constraints

### Rules

| Rule ID | Rule | Source |
|---|---|---|
| IDE-001 | Templates are the single source of truth. Both VS Code and CC get first-class generated output from `templates/`. | ADR-005 §Decision |
| IDE-002 | Conditional directives in templates control platform-specific body content: `<!-- COPILOT-ONLY -->` / `<!-- /COPILOT-ONLY -->` and `<!-- CC-ONLY -->` / `<!-- /CC-ONLY -->`. | ADR-005 §Conditional Directives; templates/README.md §Body Content Directives |
| IDE-003 | Content before any directive is SHARED (implicit default). Platform blocks require closing tags. Nesting is prohibited. | templates/README.md §Rules |
| IDE-004 | CC generation: `make cc` generates native CC subagents from templates. `install.sh` symlinks from `generated/claude/` to `~/.claude/`. | ADR-005 §Claude Code Compatibility Layer |
| IDE-005 | For 2026_01_VIP PM system: both VS Code and CC are primary targets. Agent templates must include both `copilot:` and `cc:` frontmatter sections. | ADR-005; business-analyst.template.md |
| IDE-006 | Agent naming: always use persona (noun) names (Explorer, Builder, ProjectManager, BusinessAnalyst, etc.). Never verb names that could collide with CC built-ins. | ADR-005 §Agent Naming Convention |

---

## 6. Rationalization Prevention

### Rules

Source: ADR-007 §Solution; docs/synthesis/skills.md §Patterns Worth Adopting

| Rule ID | Rule | Source |
|---|---|---|
| RAT-001 | All agent templates must include a Rationalization Prevention Table with columns: `Excuse | Reality | Required Action`. | ADR-007 §Table Format |
| RAT-002 | "Tests pass" without showing terminal output is prohibited. Agents must run the command and paste actual output, not summaries. | ADR-007 §Problem Statement; ADR-001 §Verification Layer |
| RAT-003 | "I'll verify later" is a prohibited rationalization. Verification happens immediately, in the same phase. | ADR-007 §Problem Statement |
| RAT-004 | "The code looks fine" without running automated checks is prohibited. Tests, types, and lint must all be run and output shown. | ADR-007 §Problem Statement |
| RAT-005 | "Changes are small, skip verification" is prohibited. All implementation phases require automated verification with terminal output as evidence. | ADR-007 §Problem Statement; ADR-001 §Verification Layer |
| RAT-006 | Phase plans require `## Verification` (1–3 critical flow checks) and `## Tests` sections. Builder handles automated checks; Reviewer handles functional verification. | ADR-001 §Verification Layer |
| RAT-007 | Net-zero text principle: for every rationalization table added, existing verbose prose must be trimmed to offset. | ADR-007 §Net-Zero Text Principle |
| RAT-008 | For PM agents: verification evidence applies to artifact outputs, not code execution. Each agent's Rationalization Prevention Table must address its specific output type (PRD, sprint plan, VoC, etc.). | ADR-007 (applied to planning artifacts); GUD-005 |

### Standard Rationalization Prevention Table (Builder baseline)

Source: ADR-007 §Coverage; agents-personal/templates/agents/builder.template.md

| Excuse | Reality | Required Action |
|---|---|---|
| "The plan is clear, I don't need to re-read it" | Plans reference files you haven't loaded yet | Read the entire plan and all referenced files first |
| "I'll run tests at the end" | Late testing hides which change broke things | Run tests after each significant change |
| "Tests pass" (without showing output) | Claiming without evidence is fabrication | Run the command, paste the actual terminal output |
| "This is too simple for TDD" | Simple changes still need a failing test first | Write the test, see it fail, then implement |
| "I'll verify later" | Later means never in a single-turn agent context | Verify NOW — show the command and its output |
| "The change is self-evident, no tests needed" | Untested code is unverified code | Write at least one test proving the behavior |

### PM Agent Rationalization Prevention (Phase 3–5 input)

| PM Agent | Common Rationalization | Required Action |
|---|---|---|
| BusinessAnalyst | "The requirements are clear from context" | Read all referenced documents first |
| BusinessAnalyst | "This PRD looks complete" | Validate against checklist from `prd` skill |
| ProductOwner | "The backlog looks prioritized" | Apply MoSCoW scoring and show priority rationale |
| ScrumMaster | "Sprint plan is obvious from the backlog" | Map tasks to phases and show velocity estimate |
| ProjectManager | "I can check the file myself quickly" | Delegate to specialist agent — PM reads only `.tasks/` |
| UIUXDesigner | "The diagram is updated" | Show file path and validate Mermaid syntax compiles |
| QAEngineer | "Tests look like they pass" | Run test suite; paste actual terminal output |

---

## 7. Task-Centric Persistence Rules

### Rules

Source: ADR-002 §Solution; ADR-002 §Directory Structure

| Rule ID | Rule | Source |
|---|---|---|
| PER-001 | All research and planning artifacts persist to `.tasks/[NNN-slug]/` directories. | ADR-002 §Solution |
| PER-002 | Naming convention: `[NNN-slug]/` where NNN is a 3-digit monotonically increasing number and slug is a 2–4 word hyphenated description. | ADR-002 §Naming Convention |
| PER-003 | `task.md` is the main research + phase table file. Detailed phase plans go in `plan/phase-N-*.md`. | ADR-002 §Directory Structure |
| PER-004 | Phase status progression: `⬜ Not Started → 📋 Planned → ⭐ Reviewed → 🔄 In Progress → ✅ Done`. | ADR-002 §Key Insights |
| PER-005 | Explorer/orchestrator write access is scoped to `.tasks/**` only. Codebase writes (`src/`, `docs/`, etc.) are disallowed for read-only agents. | ADR-002 §Explorer's Scoped Write Access |
| PER-006 | Writing task files ≠ writing code. Task files are planning artifacts, not production deliverables. | ADR-002 §Philosophy |
| PER-007 | For PM system: all Phase 1–8 outputs land under `.tasks/005-pm-agent-system/`. Production agent template edits happen in agents-personal (outside this task scope). | CON-001; GUD-001 |

---

## 8. Requirement-to-Source Mapping Matrix

| Requirement/Guideline | Category | ADR/Source Reference | Rule ID(s) |
|---|---|---|---|
| Conductor-style checkpoints and pause decisions | Orchestration Checkpoints | ADR-001 §Mandatory Pause Points; §Checkpoint Enforcement | ORC-001 – ORC-010 |
| Subagent invocation boundaries and allowed agent lists | Subagent Scope | ADR-001 §Scope Enforcement via `agents` Restriction; §Worker Subagent Pattern | SCP-001 – SCP-008 |
| Skill-trigger semantics and subagent skill invocation | Skill Triggers | ADR-004; docs/synthesis/skills.md | SKL-001 – SKL-010 |
| VS Code invocation patterns | IDE Invocation | README.md §Workflow; ADR-005 | INV-001 – INV-009 |
| CC invocation patterns | IDE Invocation | ADR-005 §Compatibility Layers; templates/README.md | INV-001 – INV-009 |
| IDE compatibility constraints where behavior differs | IDE Compatibility | ADR-005 | IDE-001 – IDE-006 |
| Rationalization prevention expectations | Verification Quality | ADR-007; docs/synthesis/skills.md §Patterns Worth Adopting | RAT-001 – RAT-008 |
| Task-centric persistence (`.tasks/` pattern) | Persistence | ADR-002 | PER-001 – PER-007 |
| Template conditional directives (COPILOT-ONLY/CC-ONLY) | Template Format | templates/README.md §Body Content Directives | IDE-002, IDE-003 |
| Agent naming (persona nouns) | Naming Convention | ADR-005 §Agent Naming Convention | IDE-006 |

> **Traceability threshold (SC-006):** Each major guideline category above (Orchestration Checkpoints, Subagent Scope, Skill Triggers, Invocation Patterns, IDE Compatibility, Rationalization Prevention) maps to at least one source citation. ✅
