---
task: Sync upstream and conform PM agents to current framework
slug: pm-upstream-conformance
created: 2026-04-10
status: planning
---

# Sync Upstream and Conform PM Agents to Current Framework

## Phases

| # | Phase | Status | Plan | Notes |
| --- | --- | --- | --- | --- |
| 1 | Git Sync Prep and Divergence Analysis | ✅ Done | [phase-1-git-sync-prep.md](plan/phase-1-git-sync-prep.md) | **7 ahead / 0 behind**. Merge base = upstream tip (`510d4f4`, 2026-04-10). PM commits (44d8970–17dfbc3) NOT FOUND. 20 claude files identified. 0 conflict candidates. Phase 2 merge already done via `86e1479`. See Findings section. |
| 2 | Merge Upstream (Excluding Claude Files) | ⬜ Not Started | — | **REVISED**: Upstream already merged. Scope = verify merge quality + confirm generated files match templates. Then proceed to Phase 3. |
| 3 | Recover or Recreate PM Templates | ⬜ Not Started | — | PM files from tasks 001-003 don't exist on disk; recover from git history or create fresh |
| 4 | Conform PM Templates to Upstream Patterns | ⬜ Not Started | — | Apply Worker elimination, delivery reports, anti-hallucination, tool merge patterns |
| 5 | Update PM Spec Document | ⬜ Not Started | — | Create/update docs/pm-agents.md reflecting current upstream architecture |
| 6 | Regenerate, Validate, and Install | ⬜ Not Started | — | make validate, tests, make && ./install.sh |

**Status:** ⬜ Not Started → 📋 Planned → ⭐ Reviewed → 🔄 In Progress → ✅ Done

## Overview

This task syncs the `project-management-stakeholder` branch with upstream (`mcouthon/agents`), then ensures custom PM agent templates conform to any breaking/structural changes in the upstream framework.

## Goal

Branch is up-to-date with upstream. PM agent templates exist, follow current upstream conventions, and pass all validation. Installed agents reflect the merged state.

---

## Research Findings

### CRITICAL: PM Files Missing from Working Tree

The `project-management-stakeholder` branch (confirmed via `.git/HEAD`) does NOT contain:

| Expected File | Status | Evidence |
| --- | --- | --- |
| `templates/agents/project-manager.template.md` | ❌ Missing | `file_search` returned no results |
| `templates/agents/product-owner.template.md` | ❌ Missing | `file_search` returned no results |
| `templates/agents/business-analyst.template.md` | ❌ Missing | `file_search` returned no results |
| `templates/agents/scrum-master.template.md` | ❌ Missing | `file_search` returned no results |
| `templates/agents/frontend-dev.template.md` | ❌ Missing | `file_search` returned no results |
| `templates/agents/backend-dev.template.md` | ❌ Missing | `file_search` returned no results |
| `templates/agents/qa-engineer.template.md` | ❌ Missing | `file_search` returned no results |
| `templates/agents/uiux-designer.template.md` | ❌ Missing | `file_search` returned no results |
| `docs/pm-agents.md` | ❌ Missing | Not in `docs/` listing |
| `docs/architecture/ADR-008-pm-agent-coordination-patterns.md` | ❌ Missing | ADR-008 is `worker-elimination.md` (upstream) |
| `docs/architecture/ADR-010-*` | ❌ Missing | Referenced in task 003 commit `17dfbc3` |
| `templates/skills/pm-tool-recommendations/SKILL.template.md` | ❌ Missing | `file_search` returned no results |
| `scripts/validate-pm-patterns.ps1` | ❌ Missing | `file_search` returned no results |

**Root cause (likely)**: Tasks 001-003 were executed on a different machine (Windows paths `C:\Users\s1058662\...` in task 001). The PM files either:
1. Were committed to git history and later lost during a rebase/reset
2. Were never committed to THIS clone — the work happened in a different repository

**Action required**: Phase 1 must run `git log` to check if PM commits (`44d8970`, `a60ea0b`, `b709837`, `2a40775`, `17dfbc3` from task 003) exist in the branch history. If they do, they can be recovered. If not, PM templates must be created from scratch using the plans in `.tasks/`.

### Current Upstream Framework State

Source: workspace filesystem analysis (`templates/agents/`, `generated/`, `CHANGELOG.md`, `README.md`)

**Agents (11)**: Analyst, Builder, Committer, Conductor, Explorer, Planner, Releaser, Researcher, Reviewer, Triager
- [templates/agents/](templates/agents/) — 10 templates (Researcher is listed in README as internal)
- [generated/copilot/agents/](generated/copilot/agents/) — 10 generated agent files
- [generated/claude/agents/](generated/claude/agents/) — 10 + stale `worker.md` (orphan, `cleanup_known_orphans()` handles it at install time)

**Skills (22)**: architecture, bdd, consolidate-task, critic, debug, deep-research, design, documentation, estimation, github-sync, knowledge-management, makefile, mentor, phase-review, prioritization, release-management, requirements, retrospective, risk-assessment, security-review, tech-debt, testing

**Instructions (6)**: global, golang, project-management, python, terminal, typescript

**Config**: `defaults/config.json` — model tiers `opus: "4.6"`, `sonnet: "4.6"`, empty `defaultTools`/`agentTools`

**Package version**: `2.0.0` in `package.json` (CHANGELOG lists unreleased changes post-2.1.0)

### Key Upstream Changes Since ~March 2026

These are the changes that PM templates must conform to (from [CHANGELOG.md](CHANGELOG.md)):

| Change | Impact on PM Templates | Severity |
| --- | --- | --- |
| **Worker agent eliminated** ([ADR-008](docs/architecture/ADR-008-worker-elimination.md)) | PM spec referenced Worker in roster + handoffs; ScrumMaster→Builder handoff must replace any Worker references | 🔴 Breaking |
| **Builder delivers structured reports** | PM templates handing off to Builder should expect `📦 Phase [N]` delivery reports | 🟡 Medium |
| **Conductor: "What Changed" summary** | PM Conductor orchestration patterns must align with new checkpoint format | 🟡 Medium |
| **Anti-hallucination grounding** | Explorer, Reviewer, Researcher got evidence-grounding + rationalization prevention; PM agents using these as subagents inherit this benefit | 🟢 Low |
| **MCP tools merge in generate.js** | `resolveSectionTools()` merges `defaultTools`/`agentTools` from config; PM templates should use standard tool format | 🟢 Low |
| **Model tier resolution** | Templates use `opus`/`sonnet` tier names (not hardcoded strings); `config.json` resolves at generation time | 🟡 Medium |
| **Documentation enforcement** | Builder requires documentation updates; Conductor step 2e enforces docs | 🟢 Low |
| **install.sh stale file cleanup** | Uses manifest for clean installs; PM agents will be tracked automatically | 🟢 Low |
| **New agents: Triager, Planner, Releaser, Analyst** | Upstream now has native PM workflow agents; PM templates must avoid duplicating their roles | 🔴 Critical Design |
| **Body directives: `<!-- COPILOT-ONLY -->` / `<!-- CC-ONLY -->`** | PM templates should use directives for platform-specific content | 🟡 Medium |
| **Template frontmatter structure** | Two-section format (`copilot:` / `cc:`) with tools, model, agents, handoffs | 🟡 Medium |

### Upstream PM Workflow (Already Native)

The upstream framework already has a project management workflow ([README.md](README.md#L56-L63)):

```
Triager → Planner → Conductor → ... → Releaser
```

- **Triager**: Intake, RICE scoring, routing to Planner/Explorer/Conductor
- **Planner**: Roadmaps, stories, backlog management
- **Conductor**: Multi-phase orchestration (Explorer → Builder → Reviewer → Committer)
- **Releaser**: Changelogs, versions, tags
- **Analyst**: Knowledge management, learning base

The custom PM agents (ProjectManager, ProductOwner, ScrumMaster, BusinessAnalyst, FrontendDev, BackendDev, QAEngineer, UIUXDesigner) are **domain-specific PM roles** that complement (not duplicate) the upstream workflow agents. But the relationship needs to be explicitly defined.

### "Claude Files" to Exclude from Sync

Files/directories that are Claude Code-specific and should be excluded (restored after merge):

| Path | Reason |
| --- | --- |
| `CLAUDE.md` | CC root instructions (if upstream adds it) |
| `.claude/` | CC configuration directory (if upstream adds it) |
| `generated/claude/` | CC-generated agents, rules, skills |
| `docs/cc-quickstart.md` | CC-specific documentation |

**Note**: Templates themselves are bidirectional (contain `<!-- CC-ONLY -->` sections). Excluding `generated/claude/` at the file level is clean, but blanket-excluding template CC sections would break the generator. The exclusion should target **generated output and CC-only config files**, not template source.

### Template Frontmatter Pattern (Current Convention)

From [conductor.template.md](templates/agents/conductor.template.md#L1-L35) and [builder.template.md](templates/agents/builder.template.md#L1-L55):

```yaml
---
name: AgentName
description: "One-line description"

copilot:
  tools: [...]
  agents: [...]
  model: opus | sonnet | ["opus", "sonnet"]
  disable-model-invocation: true  # optional
  handoffs:
    - label: Button Label
      agent: TargetAgent
      prompt: What to do.
      send: true|false

cc:
  tools: [...]
  disallowedTools: [...]
  permissionMode: plan | bypassPermissions
  model: opus | sonnet
  skills: [skill-names]
---
```

### What's on the Branch but Not Upstream

Based on filesystem (can't run `git diff` — no terminal access):

| File/Dir | Notes |
| --- | --- |
| `.tasks/001-pm-agent-gap-analysis/` | Completed PM gap analysis (Windows machine) |
| `.tasks/002-encode-pm-agent-patterns/` | Completed PM pattern encoding (Windows machine) |
| `.tasks/002-new-agent-setup-guide/` | Agent setup guide with 4 phases + artifacts |
| `.tasks/003-pm-agent-critical-fixes/` | Completed PM critical fixes (Windows machine) |
| `sync_upstream_notes.txt` | Manual sync instructions |

---

## Phase Detail

### Phase 1: Git Sync Prep and Divergence Analysis

**Goal**: Map the exact divergence between the PM branch and upstream. Determine if PM commits exist in history.

**Steps**:
1. `git fetch upstream` — get latest upstream state
2. `git log --oneline upstream/main..HEAD --first-parent` — commits on PM branch not in upstream
3. `git log --oneline HEAD..upstream/main --first-parent` — upstream commits not yet in branch
4. `git diff HEAD...upstream/main --stat` — files changed upstream since divergence
5. `git diff HEAD...upstream/main --name-only` — list of changed files
6. `git log --all --oneline | grep -E '44d8970|a60ea0b|b709837|2a40775|17dfbc3'` — check if PM commits from task 003 exist anywhere in history
7. If PM commits exist: `git log --oneline --all -- templates/agents/project-manager.template.md` to trace their fate
8. Identify which upstream-changed files are "claude files" to exclude (listed in research above)

**Output**: Divergence summary with commit counts, file lists, and PM commit recovery status.

### Phase 2: Merge Upstream (Excluding Claude Files)

**Goal**: Bring upstream changes into the branch while excluding CC-specific files.

**Steps** (based on [sync_upstream_notes.txt](sync_upstream_notes.txt)):
1. `git fetch upstream`
2. `git checkout main && git merge upstream/main && git push origin main`
3. `git checkout project-management-stakeholder && git rebase main`
4. After rebase, restore excluded claude files to their pre-merge state:
   ```
   git restore --source HEAD~N -- CLAUDE.md .claude/ generated/claude/ docs/cc-quickstart.md
   ```
   (Only needed if these files existed before and differ; if they didn't exist before, use `git rm` for newly added ones)
5. Resolve any merge conflicts (likely in `CHANGELOG.md`, possibly `README.md` if PM changes modified them)
6. `git push --force-with-lease origin project-management-stakeholder`

**Note on claude file exclusion**: The bidirectional template system means `generated/claude/` is regenerated from the same templates. Excluding it from git doesn't break anything — it just means CC output isn't tracked on this branch. The user can add `generated/claude/` to `.gitignore` on this branch if desired.

### Phase 3: Recover or Recreate PM Templates

**Goal**: Get PM agent templates into the workspace, either by recovering from git history or creating from scratch.

**If PM commits found in history (Phase 1 step 6)**:
- Cherry-pick the PM commits onto the rebased branch
- Resolve conflicts with upstream changes (especially Worker elimination affecting PM agent references)

**If PM commits NOT found**:
- Create PM templates from scratch using the detailed specifications in:
  - `.tasks/002-encode-pm-agent-patterns/task.md` — template specifications, RC patterns, role boundaries
  - `.tasks/003-pm-agent-critical-fixes/task.md` — Builder in roster, Worker constraints, QA write scope
  - `.tasks/001-pm-agent-gap-analysis/task.md` — original gap analysis
- Templates to create (8):
  - `templates/agents/project-manager.template.md`
  - `templates/agents/product-owner.template.md`
  - `templates/agents/business-analyst.template.md`
  - `templates/agents/scrum-master.template.md`
  - `templates/agents/frontend-dev.template.md`
  - `templates/agents/backend-dev.template.md`
  - `templates/agents/qa-engineer.template.md`
  - `templates/agents/uiux-designer.template.md`
- Skill to create:
  - `templates/skills/pm-tool-recommendations/SKILL.template.md`
- Spec document:
  - `docs/pm-agents.md`
- Each template must follow current upstream frontmatter pattern (see Research Findings)

### Phase 4: Conform PM Templates to Upstream Patterns

**Goal**: Ensure PM templates use current upstream conventions and account for breaking changes.

**Required conformance updates**:
1. **Worker elimination** (ADR-008): Remove all Worker references from PM agent handoffs, roster, and permission tiers. Replace `ScrumMaster → Worker` with `ScrumMaster → Builder` where applicable. Remove Worker from pm-agents.md agent roster.
2. **Model tier names**: Use `opus` / `sonnet` instead of hardcoded model strings in all PM template frontmatter.
3. **Template frontmatter structure**: Ensure `copilot:` and `cc:` sections follow convention from conductor/builder templates.
4. **Body directives**: Use `<!-- COPILOT-ONLY -->` / `<!-- CC-ONLY -->` for platform-specific content.
5. **Tool format**: Use standard tool arrays matching upstream patterns (e.g., `read/readFile`, `edit/editFiles`).
6. **Builder delivery reports**: PM orchestration patterns should expect structured `📦 Phase [N]` reports from Builder.
7. **Anti-hallucination**: Add evidence-grounding guidelines to any PM agents that do research (ProductOwner, BusinessAnalyst analysis).
8. **Relationship to upstream PM agents**: Define how PM-specific agents (ProjectManager, ProductOwner, etc.) relate to native workflow agents (Triager, Planner, Conductor, Releaser, Analyst). Avoid role duplication.

### Phase 5: Update PM Spec Document

**Goal**: Create or update `docs/pm-agents.md` to reflect the current architecture.

**Key updates needed**:
- Agent roster reflects 10-agent PM system (8 PM-specific + Builder + Committer cross-references, no Worker)
- Permission tiers align with upstream patterns
- Handoff contracts are valid (all agent names resolve to roster entries)
- Workflow definitions account for upstream Triager/Planner/Releaser capabilities
- Worker elimination is reflected throughout (no Worker in any table or workflow)
- QAEngineer has RE+W-QA permission (from task 003)
- WORKER-INVOCATION/WORKER-SCOPE-DECLARATION/WORKER-ACTION-LOG blocks removed or replaced with Builder equivalents

### Phase 6: Regenerate, Validate, and Install

**Goal**: Verify everything works end-to-end.

**Steps**:
1. `make validate` — dry-run generation to check templates parse correctly
2. `make` — regenerate all output files
3. `./tests/test-generate.sh` — run generation tests
4. `./tests/validate-skills.sh` — validate skill files
5. Verify PM agents appear in `generated/copilot/agents/`
6. Verify PM skill appears in `generated/copilot/skills/pm-tool-recommendations/`
7. `./install.sh` — install to ~/.copilot/
8. Verify PM agents installed: `ls ~/.copilot/agents/ | grep -E 'project-manager|product-owner|business-analyst|scrum-master|frontend-dev|backend-dev|qa-engineer|uiux-designer'`

---

## Knowledge Gaps

| Searched For | Found | Impact |
| --- | --- | --- |
| PM commit hashes in git history | Cannot check (no terminal access) | Phase 1 must determine if recovery or recreation is needed |
| Upstream divergence (git log/diff) | Cannot check (no terminal access) | Phase 1 prerequisite |
| Whether PM templates were ever committed to this branch | Commits referenced in task 003 but files absent | Blocks Phase 3 strategy decision |
| Upstream version tag or release since 2.1.0 | CHANGELOG has unreleased changes; package.json says 2.0.0 | Minor — won't affect plan |

## Out of Scope

- Modifying upstream framework agents (Triager, Planner, Conductor, etc.)
- Creating Claude Code-specific PM configurations
- Porting PM work from the Windows machine's VIP project
- Modifying `scripts/generate.js` or `install.sh`
