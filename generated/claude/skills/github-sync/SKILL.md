---
name: github-sync
description: "Optional GitHub integration for syncing .tasks/ state to GitHub Issues, PRs, and Projects. Use when creating GitHub issues from tasks, syncing project boards, or pushing task state to GitHub. Triggers on: 'use github-sync mode', 'sync to github', 'create github issue', 'create PR', 'update project board', 'github sync'. Full access mode — can read tasks and invoke GitHub operations."
allowed-tools: [Read, Edit, Write, Bash, Grep, Glob]
---

# GitHub Sync

Sync `.tasks/` state to GitHub Issues, PRs, and Projects.

> **`.tasks/` is always the source of truth.** GitHub is a sync target, never the primary store.

## Prerequisites

This skill requires GitHub CLI (`gh`) or MCP GitHub tools to be configured.

**Quick check:**
```bash
gh auth status  # Should show logged in
```

If `gh` is not available, this skill operates in **preview mode** — generates the commands/payloads without executing them.

## Design Principles

1. **Local-first**: All planning and state management happens in `.tasks/`
2. **One-way sync**: `.tasks/` → GitHub (not bidirectional)
3. **Idempotent**: Running sync twice produces the same result
4. **Non-destructive**: Never closes/deletes GitHub issues that still exist in `.tasks/`
5. **Opt-in**: Only sync items explicitly requested — never auto-sync everything

## Task → Issue Mapping

| `.tasks/` Concept | GitHub Equivalent |
| --- | --- |
| Task (`task.md`) | Issue |
| Phase | Checklist item in issue body |
| Story (from Planner) | Issue with `story` label |
| Backlog item | Issue with priority label |
| Milestone (from roadmap) | GitHub Milestone |
| Priority (P0–P3) | Labels: `priority: critical`, `priority: high`, `priority: medium`, `priority: low` |
| Size (XS–XL) | Labels: `size: xs`, `size: s`, `size: m`, `size: l`, `size: xl` |
| Type | Labels: `type: bug`, `type: feature`, `type: enhancement`, `type: tech-debt` |

## Sync Operations

### Create Issue from Task

```bash
gh issue create \
  --title "[NNN] Task title" \
  --body "$(cat .tasks/[NNN]-[slug]/task.md)" \
  --label "priority: [level],size: [size],type: [type]"
```

**Issue body format:**

```markdown
> Synced from `.tasks/[NNN]-[slug]/task.md`

## Phases

- [ ] Phase 1: [name] — [status emoji]
- [ ] Phase 2: [name] — [status emoji]
- [x] Phase 3: [name] — ✅ Done

## Context
[Summary from task.md research section]
```

### Update Issue from Task

When task state changes (phase completed, status updated):

```bash
gh issue edit [issue-number] \
  --body "$(generate-updated-body)"
```

Update phase checklist items to match `.tasks/` status.

### Create PR from Completed Phase

After a phase is implemented and committed:

```bash
gh pr create \
  --title "[type](scope): [description]" \
  --body "Implements Phase [N] of #[issue-number]

## Changes
[Summary of changes from Builder]

## Verification
[Verification results from Reviewer]

Refs: .tasks/[NNN]-[slug]/plan/phase-N-[name].md"
```

### Sync Milestone from Roadmap

```bash
# Create milestone
gh api repos/{owner}/{repo}/milestones \
  --method POST \
  --field title="M1: [Milestone Name]" \
  --field description="[From roadmap.md]" \
  --field due_on="[date if available]"

# Associate issues
gh issue edit [issue-number] --milestone "M1: [Milestone Name]"
```

## Label Setup

First-time setup — create the label taxonomy:

```bash
# Priority labels
gh label create "priority: critical" --color "d73a4a" --description "P0 — drop other work"
gh label create "priority: high" --color "e99695" --description "P1 — this sprint"
gh label create "priority: medium" --color "fbca04" --description "P2 — backlog"
gh label create "priority: low" --color "0e8a16" --description "P3 — icebox"

# Size labels
gh label create "size: xs" --color "c5def5" --description "< 1 hour"
gh label create "size: s" --color "c5def5" --description "1-4 hours"
gh label create "size: m" --color "bfdadc" --description "4-8 hours"
gh label create "size: l" --color "d4c5f9" --description "1-3 days"
gh label create "size: xl" --color "d4c5f9" --description "3+ days"

# Type labels
gh label create "type: bug" --color "d73a4a"
gh label create "type: feature" --color "0075ca"
gh label create "type: enhancement" --color "a2eeef"
gh label create "type: tech-debt" --color "e4e669"
gh label create "type: research" --color "d876e3"
```

## Sync State Tracking

To avoid duplicate syncs, track GitHub issue numbers in task files:

```markdown
<!-- github-sync: issue=#42 -->
```

Append this comment to `task.md` after first sync. On subsequent syncs, read it to find the linked issue.

## Preview Mode

When GitHub CLI is not available, output what WOULD happen:

```markdown
## GitHub Sync Preview (dry run)

### Would Create Issue
- **Title**: [NNN] Task title
- **Labels**: priority: high, size: m, type: feature
- **Milestone**: M1: MVP
- **Body**: [first 200 chars of task.md]...

### Would Create PR
- **Title**: feat(auth): add JWT token refresh
- **Base**: main
- **Head**: [current branch]
- **Refs**: #42
```

## Anti-Patterns

| ❌ Don't | ✅ Do |
| --- | --- |
| Edit GitHub issues directly and expect `.tasks/` to update | Always edit `.tasks/` first, then sync to GitHub |
| Auto-sync everything on every change | Sync explicitly when ready to share |
| Create one issue per phase | One issue per task; phases are checklist items |
| Close GitHub issues when task is "done" | Close issues only when all phases are verified and committed |
| Use GitHub Projects as the planning tool | Use Planner agent + `.tasks/`; sync to Projects for visibility only |
| Sync incomplete research | Sync after Explorer research is complete and approved |
