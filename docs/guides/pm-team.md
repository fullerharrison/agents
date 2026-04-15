# Project Management Agent Team

A reference for the PM agent team: what each agent does, how they relate, what skills
support them, and a step-by-step guide for adding new agents in the future.

---

## Team Overview

The PM team is an orchestrated pipeline. **Conductor** drives the full
lifecycle; the other agents own distinct phases.

```
User request
    │
    ▼
┌───────────┐   plan     ┌──────────┐   phase plans  ┌──────────┐
│ Conductor │──────────▶│  Planner │               │ Explorer │
│           │            └──────────┘               │          │
│ (routes   │   explore  ┌──────────┐◀──────────────│ (phases) │
│ all work) │──────────▶│ Explorer │               └──────────┘
│           │            └──────────┘
│           │   build    ┌──────────┐
│           │──────────▶│  Builder │
│           │            └──────────┘
│           │   review   ┌──────────┐
│           │──────────▶│ Reviewer │
│           │            └──────────┘
│           │   commit   ┌──────────┐
│           │──────────▶│ Committer│
│           │            └──────────┘
│           │   release  ┌──────────┐
│           │──────────▶│ Releaser │
└───────────┘            └──────────┘

Intake path:
User → Triager → Planner → Conductor
```

---

## Agent Catalog

| Agent | Model | Role | Writes to | Safe to invoke directly? |
|---|---|---|---|---|
| **Conductor** | opus + sonnet | Orchestrator — routes all work, never does work directly | nothing | Yes — start here for complex multi-phase tasks |
| **Planner** | opus | Roadmaps, epic breakdown, RICE/MoSCoW prioritization, stories | `.tasks/` only | Yes — use for planning new features |
| **Triager** | sonnet | Rapid intake: classify type, RICE score, severity, duplicate check, routing | nothing (read-only) | Yes — use for new incoming bugs or ideas |
| **Explorer** | opus | Codebase research, phased implementation planning | `.tasks/` only | Yes — use for understanding unfamiliar code |
| **Builder** | sonnet | Execute approved phase plans, full code access | code files | Via Conductor; direct OK for targeted changes |
| **Reviewer** | sonnet | Verify implementation: tests, types, lint, plan completeness | nothing (read + run tests) | Via Conductor; direct OK for code review |
| **Committer** | sonnet | Semantic conventional commits with logical file grouping | git commits | After review is complete |
| **Releaser** | sonnet | Changelog, semantic versioning, git tags, release notes | `CHANGELOG.md`, version files | After commits are merged |
| **Analyst** | opus | Knowledge management — ingest docs, synthesize, extract actions | `docs/knowledge/` | Yes — for processing research and documentation |
| **Researcher** | sonnet | Internal read-only research subagent | nothing | No — internal only (`user-invokable: false`) |

---

## Conductor Workflow

Conductor checkpoints require explicit user approval before proceeding:

```
1. List .tasks/                         (entry gate — always)
2. Explorer → create task.md            
3. ─── CHECKPOINT: Task Created ──────  ◀ pause, show plan
4. Explorer → create phase-N-*.md       
5. Explorer → phase-review (skill)      
6. ─── CHECKPOINT: Phase Ready ───────  ◀ pause, confirm
7. Builder → implement phase            
8. Reviewer → verify                    
9. ─── CHECKPOINT: Phase Done ─────────  ◀ pause, confirm
10. Committer → commit                  
11. Repeat 4–10 for each phase          
12. Final phase: docs + consolidate-task ADR + Releaser suggestion
```

---

## Supporting Skills

These skills are used by the PM agents. They auto-activate when their triggers appear in a prompt.

| Skill | Used by | Mode | Purpose |
|---|---|---|---|
| `prioritization` | Planner, Triager | Read-only | RICE scoring, MoSCoW, Impact/Effort matrix, anti-pattern table |
| `requirements` | Planner | Full access | INVEST checklist, story/AC format, epic decomposition, vertical slices |
| `estimation` | Planner | Read-only | T-shirt sizing (XS–XL), complexity factors, risk multipliers (capped 4x) |
| `risk-assessment` | Planner, Triager | Read-only | 6-category checklist, Probability×Impact matrix, risk register format |
| `phase-review` | Explorer (via Conductor) | Read-only | Review a phase plan for flaws before implementation starts |
| `retrospective` | Reviewer | Read-only | 6-step retro process, estimation accuracy table, action items format |
| `github-sync` | Planner | Full access | `.tasks/` → GitHub Issues/PRs/Projects one-way sync |
| `consolidate-task` | Conductor (final phase) | Full access | Archive completed tasks as ADRs in `docs/architecture/` |
| `backlog-management` | Planner | Full access | MoSCoW + 4-phase delivery model, Microsoft Planner-compatible output |
| `requirements-cascade` | Planner | Full access | Cascade review when requirement documents change |

---

## Project Management Instructions

[`project-management.instructions.md`](../../.copilot/instructions/project-management.instructions.md)
applies to all `.tasks/**/*.md` files and sets these conventions:

| Concern | Standard |
|---|---|
| **Status emoji** | ⬜ Not Started · 📋 Planned · 🔄 In Progress · ⭐ Reviewed · ✅ Done · ❌ Blocked · 🔴 At Risk · 🧊 Icebox |
| **Task naming** | `[NNN]-[slug]` — 3-digit sequential, 2–4 lowercase hyphenated words |
| **Priority** | P0 critical/immediate → P1 this sprint → P2 backlog → P3 icebox |
| **Size** | XS <1h · S 1–4h · M 4–8h · L 1–3d · XL 3+d |
| **Phase table** | `\| # \| Phase \| Size \| Status \|` |
| **User story** | As a / I want / So that |
| **Acceptance criteria** | Given / When / Then checkboxes |

`.tasks/` file layout:

```
.tasks/[NNN]-[slug]/
  task.md                  # Research + phase table (required)
  roadmap.md               # Project-level plan (Planner)
  backlog.md               # Priority-ordered items (Planner)
  stories/
    story-001-[name].md
  plan/
    phase-1-[name].md
    phase-2-[name].md
  retro.md
```

---

## How to Add a New Agent

### 1. Create the template

Add `templates/agents/my-agent.template.md`. Use the skeleton below, fill in every section:

```markdown
---
name: MyAgent
description: "One-sentence purpose. Use for: X, Y, Z. Triggers on: 'keyword1', 'keyword2'."

copilot:
  tools:
    [
      "vscode/askQuestions",   # ask clarifying questions
      "read/readFile",         # read files
      # "edit/editFiles",      # uncomment if agent modifies files
      # "execute/*",           # uncomment if agent runs commands
      "agent",                 # invoke subagents
      "search",
      "todo",
    ]
  model: sonnet                # sonnet (default) or opus (planning/analysis)
  agents: ["Explorer", "Researcher"]   # subagents this agent can invoke
  # user-invokable: false      # uncomment to hide from users (internal only)
  handoffs:
    - label: Next Step
      agent: Conductor
      prompt: Hand this off to the next stage.
      send: false

cc:
  tools: [Read, Grep, Glob, "Task(Explorer, Researcher)", LSP]
  # disallowedTools: [Bash, Edit, Write]   # restrict as needed
  model: sonnet
  # skills: [debug, testing]   # skills to auto-load for CC
---

## Purpose

Describe the agent's role, key behaviors, and constraints.

## Constraints

- NEVER [list hard prohibitions]
- Writes ONLY to [scope]

## Workflow

1. Step one
2. Step two

## Output Format

Describe the expected output structure.
```

### 2. Add to config (if needed)

If your agent needs a model tier not already present, update `defaults/config.json`:

```json
{
  "models": {
    "opus": "4.6",
    "sonnet": "4.6"
  }
}
```

Model strings resolve as: `opus` → `Claude Opus 4.6 (copilot)`, `sonnet` → `Claude Sonnet 4.6 (copilot)`.

### 3. Regenerate

```bash
make
```

This regenerates:
- `generated/copilot/agents/my-agent.agent.md` — VS Code Copilot reads this
- `generated/claude/agents/my-agent.md` — Claude Code reads this

### 4. Install

```bash
./install.sh
```

This copies the generated files to:
- `~/.copilot/agents/my-agent.agent.md` (VS Code global agents)
- `~/.claude/agents/my-agent.md` (Claude Code global agents)

### 5. Validate

```bash
make validate
```

Exits 0 if committed generated files match their templates. Run this in CI or before committing.

### 6. Verify in VS Code

1. Open VS Code and open a new Copilot Chat
2. Type `@` — your agent should appear in the agent picker
3. Invoke it and confirm behavior matches the template

### 7. Update the README

Add a row to the Agents table in [`README.md`](../../README.md):

```markdown
| **MyAgent** | sonnet | One-line description |
```

Update the agent count in the "What You Get" section.

---

## Common Patterns

### Read-only agent (Triager, Reviewer pattern)

```yaml
copilot:
  tools: ["vscode/askQuestions", "read/readFile", "read/problems", "agent", "search", "todo"]
  model: sonnet

cc:
  disallowedTools: [Bash, Edit, Write]
```

### Planning agent (Planner pattern)

```yaml
copilot:
  tools: ["vscode/askQuestions", "read/readFile", "agent", "edit/createDirectory",
          "edit/createFile", "edit/editFiles", "search", "web", "todo"]
  model: opus
  agents: ["Explorer", "Researcher"]

cc:
  disallowedTools: [Bash]
  model: opus
  skills: [requirements, estimation, prioritization, risk-assessment]
```

Body must include the constraint: `NEVER edit code files. Writes ONLY to .tasks/`.

### Internal-only subagent (Researcher, Worker pattern)

```yaml
copilot:
  user-invokable: false
  tools: ["read/readFile", "search"]
  model: sonnet
```

---

## Source Files Reference

| File | Purpose |
|---|---|
| `templates/agents/*.template.md` | Source of truth for all agents |
| `templates/README.md` | Full frontmatter spec with all supported fields |
| `defaults/config.json` | Model tier → version string mapping |
| `scripts/generate.js` | Template → generated files compiler |
| `Makefile` | `make` (generate), `make validate` (CI check), `make install` |
| `install.sh` | Copies generated files to `~/.copilot/` and `~/.claude/` |
| `generated/copilot/agents/` | Do not edit — regenerated by `make` |
| `generated/claude/agents/` | Do not edit — regenerated by `make` |
| `~/.copilot/agents/` | Live agent files VS Code reads |
| `~/.copilot/skills/` | Live skill files auto-activated by VS Code |
| `~/.copilot/instructions/` | Live instruction files keyed to `applyTo` patterns |
