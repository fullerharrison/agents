---
artifact: phase-1-reuse-map
task: 005-pm-agent-system
phase: 1
created: 2026-03-18
status: complete
sources:
  - agents-personal/README.md
  - agents-personal/templates/agents/business-analyst.template.md
  - agents-personal/templates/agents/worker.template.md
  - agents-personal/docs/architecture/ADR-001-orchestration-and-subagents.md
  - agents-personal/docs/architecture/ADR-002-task-centric-persistence.md
  - agents-personal/docs/architecture/ADR-004-skill-powered-subagents.md
---

# Phase 1 Reuse Map — BusinessAnalyst and Worker Patterns

## Purpose

This document maps the reusable patterns from the `agents-personal` framework that can be adopted, adapted, or deferred for the 2026_01_VIP PM agent system.  
All decisions are grounded in source citations to agents-personal README and ADRs (see ADR priority note below).

> **Source-priority note (RISK-001 mitigation):** Where ADR text and README prose differ, the ADR takes precedence as the authoritative decision record.

---

## 1. BusinessAnalyst Pattern — Canonical Definition

**Source file:** `agents-personal/templates/agents/business-analyst.template.md`

### Extracted Pattern Elements

| Element | Value | Source Reference |
|---------|-------|-----------------|
| Role type | Domain-specific analyst with write access, no terminal/execute | `business-analyst.template.md` frontmatter: `disallowedTools: [Bash]` |
| Tool scope | Read, Edit, Write, Grep, Glob, WebFetch, WebSearch, TaskList/Get/Create/Update | `business-analyst.template.md` `cc.tools` |
| Tool restriction | No `Bash` (execution) | `business-analyst.template.md` `cc.disallowedTools: [Bash]` |
| Model | `opus` for both Copilot and CC | `business-analyst.template.md` `model: opus` |
| Skills | Auto-activating domain skills (`prd`, `breakdown-epic-pm`, `breakdown-feature-prd`, `update-specification`, `architecture-blueprint-generator`) | `business-analyst.template.md` `cc.skills` |
| User-invokable | `true` — exposed to users as a direct-invoke agent | `business-analyst.template.md` `user-invokable: true` |
| Handoff targets | Scrum Master (Plan Sprint), self (Save Work) | `business-analyst.template.md` `copilot.handoffs` |
| Output paths | `docs/`, `learning_base/02_requirements/`, `docs/ways-of-work/plan/`, `specs/` | `business-analyst.template.md` Step 4 |
| Workflow pattern | Step 1 Understand → Step 2 Apply Skill → Step 3 Write with domain precision → Step 4 Save | `business-analyst.template.md` Workflow section |
| Context load | Read all reference documents before writing any artifact | `business-analyst.template.md` "Always consult relevant documents before writing any artefact" |

### PM System Reuse: BusinessAnalyst Role

| Pattern Candidate | Decision | Rationale | Source |
|---|---|---|---|
| **Tool scope (Read/Edit/Write, no Bash)** | **Reuse as-is** | Matches the "limited write, no execute" profile required for ProductOwner and specialist advisory agents. Sets the baseline for non-orchestrator write-capable agents. | `business-analyst.template.md` frontmatter; ADR-001 §Worker Subagent Pattern |
| **`disallowedTools: [Bash]`** | **Reuse as-is** | All PM specialist agents except QAEngineer should use this restriction. Bash absence prevents accidental execution by non-executor roles. | `business-analyst.template.md` `cc.disallowedTools`; ADR-001 §Worker Subagent Pattern |
| **Auto-activating skill set** | **Reuse with adaptation** | The skill-trigger model is reused; specific skill names are adapted for PM system workflows (resource-ingestion, stakeholder-feedback, requirements-cascade, backlog-management, diagram-generation — Phase 2). | `business-analyst.template.md` `cc.skills`; ADR-004 §Pattern |
| **Domain-context load step** | **Reuse as-is** | The "read all reference docs before writing" pattern is adopted for all write-capable PM agents. Prevents hallucinated constraints. | `business-analyst.template.md` "Always consult relevant documents before writing any artefact" |
| **Step-based workflow (Understand → Skill → Write → Save)** | **Reuse as-is** | The 4-step pattern structures agent behavior and prevents out-of-order output. All specialist agents in phases 3–4 adopt this structure. | `business-analyst.template.md` Workflow section |
| **Handoff buttons / handoff targets** | **Reuse with adaptation** | Pattern is reused; target agents change (ProductOwner → ScrumMaster; ScrumMaster → ProjectManager; etc.). Exact handoff labels are defined per agent in phases 3–5. | `business-analyst.template.md` `copilot.handoffs`; README.md §Handoff Buttons |
| **`user-invokable: true`** | **Reuse as-is for direct-invoke agents** | BusinessAnalyst, ProductOwner, and ScrumMaster are user-invokable. Specialist advisors use the same value. Internal sub-agents (Worker) set `user-invokable: false`. | `business-analyst.template.md`; ADR-001 §Worker Subagent Pattern |
| **`opus` model for write-capable agents** | **Reuse as-is** | All write-capable PM agents inherit the `opus` model selection. Sonnet is reserved for internal Worker subagents (context-isolated short-duration tasks). | `business-analyst.template.md` `model: opus`; ADR-001 §Worker Subagent Pattern (`model: sonnet`) |
| **Output path conventions** | **Reuse with adaptation** | 2026_01_VIP path conventions (see Phase 1 Interface Map) govern where outputs land. The pattern (explicit save locations per doc type) is retained. | `business-analyst.template.md` Step 4; REQ-003 |
| **HTP-VIP domain language** | **Reuse as-is** | The BusinessAnalyst template already embeds HTP-VIP domain terminology (Trial, Plot, Germplasm, etc.). This context block is adopted for ProductOwner and ScrumMaster agents. | `business-analyst.template.md` Core Domain Language |

---

## 2. Worker Pattern — Canonical Definition

**Source file:** `agents-personal/templates/agents/worker.template.md`  
**Supporting ADR:** `agents-personal/docs/architecture/ADR-001-orchestration-and-subagents.md`

### Extracted Pattern Elements

| Element | Value | Source Reference |
|---------|-------|-----------------|
| Role type | Internal subagent — context-isolated task execution, NOT user-invokable | `worker.template.md` frontmatter; ADR-001 §Worker Subagent Pattern |
| Tool scope (CC) | Read, Edit, Write, Bash, Grep, Glob, LSP | `worker.template.md` `cc.tools` |
| Tool scope (Copilot) | execute/testFailure, getTerminalOutput, awaitTerminal, runInTerminal, runTests, read/problems, readFile, terminalSelection, terminalLastCommand, createDirectory, createFile, editFiles, search, todo | `worker.template.md` `copilot.tools` |
| Bash | **Allowed** — full terminal access including test runs | `worker.template.md` `cc.tools: [Bash]` |
| Model | `sonnet` (speed-optimized for isolated short tasks) | `worker.template.md` `cc.model: sonnet` |
| `user-invokable` | `false` — hidden from user-facing invocation lists | `worker.template.md` `copilot.user-invokable: false` |
| Capabilities | Full access: read, edit, create files; terminal; focused scope | `worker.template.md` §Capabilities |
| Output contract | Concise: what was done, what was verified; specific: file paths + test results; honest: failures reported | `worker.template.md` §Output |
| Process | Read task → Execute → Verify success (run tests if applicable) → Return summary | `worker.template.md` §Process |
| Invocation pattern | Invoked by parent agents (Builder, Reviewer, Conductor). Spawned via `agents` frontmatter restriction + skill-powered subagent prompt. | ADR-001 §Worker Subagent Pattern; ADR-004 §Subagent Prompt Structure |

### Subagent Invocation Pattern (from ADR-001 and ADR-004)

```markdown
# Canonical Worker invocation prompt structure (ADR-004 §Subagent Prompt Structure)
Run the Worker agent as a subagent: [skill trigger phrase if applicable].
[Specific task description with context].
Return: [What the parent agent needs back].
```

**Agent scope restriction table** (ADR-001 §Scope Enforcement):

| Parent Agent | Allowed Subagents via `agents:` |
|---|---|
| Conductor | Explorer, Builder, Reviewer, Committer, Worker |
| Builder | Worker |
| Reviewer | Worker |
| Committer | Researcher |
| Explorer | Explorer (self-recurse), Researcher |

### PM System Reuse: Worker Role

| Pattern Candidate | Decision | Rationale | Source |
|---|---|---|---|
| **`user-invokable: false`** | **Reuse as-is** | Worker must remain hidden from user invocation. It is spawned only by parent agents. This is non-negotiable for PM system integration. | `worker.template.md`; ADR-001 §Worker Subagent Pattern |
| **`sonnet` model** | **Reuse as-is** | Workers perform short-duration, isolated tasks. Sonnet is cost/speed appropriate. | `worker.template.md` `cc.model: sonnet` |
| **Bash / full terminal access** | **Reuse as-is** | Worker is the only agent in the PM system permitted to execute terminal commands. All other agents route execution through Worker delegation. | `worker.template.md` `cc.tools: [Bash]`; ADR-001 §Agent Capabilities Table |
| **Context isolation / summary-only return** | **Reuse as-is** | Worker findings are garbage-collected after summary return. Parent agents (ProductOwner, BusinessAnalyst, ScrumMaster) receive only the summary. This keeps PM agent contexts lean. | ADR-004 §Factor Comparison "Subagent context garbage-collected" |
| **4-step process (Read → Execute → Verify → Return)** | **Reuse as-is** | The process pattern is adopted for any Worker invocation within PM workflows. Verification step is non-negotiable (rationalization prevention). | `worker.template.md` §Process; ADR-007 |
| **`agents:` scope restriction on invoking agents** | **Reuse with adaptation** | PM-system agents that may invoke Worker must declare `agents: ["Worker"]` in their frontmatter. ProductOwner and ScrumMaster are the primary PM-layer Worker invokers. ProjectManager is read-only and **cannot invoke Worker directly** (REQ-002). | ADR-001 §Scope Enforcement via `agents` Restriction |
| **Skill-powered subagent invocation** | **Reuse as-is** | When PM agents delegate complex isolated tasks (e.g., file conversion, diagram generation), they invoke Worker with skill trigger keywords in the subagent prompt (ADR-004 pattern). | ADR-004 §Pattern; `worker.template.md` §Process |
| **LSP-preferred navigation (CC-only)** | **Reuse as-is** | CC-platform Workers use `goToDefinition`, `findReferences`, `getDiagnostics` over grep. This carries forward to any PM system Worker invocations. | `worker.template.md` §Tool Preference CC-ONLY |

---

## 3. Explicit PM Read-Only Orchestration Constraints

**Source:** ADR-001 §Conductor Agent Pattern; README.md §The Workflow

These constraints apply specifically to the **ProjectManager** agent adaptation (Phase 5) and govern how it differs from both BusinessAnalyst and Conductor:

| Constraint | Rule | Source |
|---|---|---|
| **PM is read-only** | ProjectManager may NOT use Edit, Write, or Bash tools. It is an orchestration-only agent. | ADR-001 §Conductor Agent Pattern: `disallowedTools: [Edit, Write, Bash, Grep]` (conductor pattern); REQ-002 |
| **PM delegates all work** | ProjectManager NEVER executes tasks directly. All work is routed to specialist agents or Worker via subagent delegation. | ADR-001 "You do NOT do the work directly" |
| **PM pauses at checkpoints** | ProjectManager uses `AskUserQuestion` (CC) / `askQuestions` (Copilot) for mandatory pause points. Checkpoints are unconditional. | ADR-001 §Mandatory Pause Points; §Checkpoint Enforcement |
| **PM scope: `.tasks/` read + `AskUserQuestion`** | Like Conductor (CC constraint), PM may only read `.tasks/` directly. All other reads require delegation. | ADR-001 §CC constraint: "Read/Glob scope: `.tasks/` only" |
| **PM must not invoke Worker directly** | Worker is invoked by execution-layer agents (ProductOwner, ScrumMaster). PM delegates to those agents, not to Worker. | ADR-001 §Worker Subagent Pattern; REQ-002 |
| **`disable-model-invocation: true`** | PM (like Conductor) must be explicitly invoked by the user. Model auto-invocation is disabled. | ADR-001 §Conductor Agent Pattern: `disable-model-invocation: true` |
| **`agents:` restriction** | PM's frontmatter `agents:` list contains only the specialist agents it may invoke (ProductOwner, BusinessAnalyst, ScrumMaster, etc.). Worker is excluded. | ADR-001 §Scope Enforcement via `agents` Restriction |
| **No ADR consolidation or self-research** | PM does not research or write ADRs. That work belongs to Builder/Explorer equivalents. | ADR-001 "NEVER research, analyze code, or read source files for understanding" |

---

## 4. Pattern Coverage Summary

| Pattern | BusinessAnalyst Source | Worker Source | PM System Use |
|---|---|---|---|
| Tool scope (read/write, no execute) | ✅ business-analyst.template.md | — | ProductOwner, BA reuse, specialist advisors |
| Tool restriction (`disallowedTools: [Bash]`) | ✅ business-analyst.template.md | — | All PM agents except QAEngineer and Worker |
| Internal hidden subagent (`user-invokable: false`) | — | ✅ worker.template.md | Worker unchanged |
| Full-access execute (Bash) | — | ✅ worker.template.md | Worker only |
| Context isolation + summary return | — | ✅ ADR-004 | All Worker invocations from PM agents |
| Skill-trigger auto-activation | ✅ business-analyst.template.md | ✅ ADR-004 | Phase 2 skill set |
| `agents:` scope restriction | — | ✅ ADR-001 | All PM agents with subagent authority |
| Checkpoint pause (`AskUserQuestion`) | — | ✅ ADR-001 | ProjectManager (Phase 5), ScrumMaster (Phase 3) |
| Opus model (write-capable agents) | ✅ business-analyst.template.md | — | BA, ProductOwner, ScrumMaster |
| Sonnet model (short-lived subagents) | — | ✅ worker.template.md | Worker |
| Read-only orchestrator pattern | — | ✅ ADR-001 (Conductor) | ProjectManager (Phase 5) |
| Rationalization prevention tables | — | ✅ ADR-007 | All PM agent templates (Phase 3–5) |

---

## 5. Deferred Patterns

| Pattern | Reason Deferred | Future Phase |
|---|---|---|
| Conductor `permissionMode: plan` | PM Phase 5 will assess if `permissionMode: plan` is appropriate for ProjectManager vs. full orchestrator mode | Phase 5 |
| `disable-model-invocation: true` detail | Needs PM context confirmation; Conductor uses it but BusinessAnalyst does not | Phase 5 |
| ScrumMaster-specific reuse | ScrumMaster template exists (`scrum-master.template.md`) but has not been analyzed here; reuse assessment deferred to Phase 3 | Phase 3 |
| Researcher subagent reuse | Researcher (`researcher.template.md`) is a read-only internal agent; potential use for PM research delegation assessed in Phase 5 | Phase 5 |
