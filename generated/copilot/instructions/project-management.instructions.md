---
applyTo: ".tasks/**/*.md"
---

# Project Management Conventions

Standards for all files in `.tasks/` directories.

## Status Indicators

Use these emoji consistently in phase tables, backlog items, and status reports:

| Emoji | Status | Meaning |
| --- | --- | --- |
| ⬜ | Not Started | Work hasn't begun |
| 📋 | Planned | Detailed plan exists |
| 🔄 | In Progress | Currently being worked on |
| ⭐ | Reviewed | Plan or implementation reviewed |
| ✅ | Done | Completed and verified |
| ❌ | Blocked | Cannot proceed — blocker documented |
| 🔴 | At Risk | May not complete on time or as planned |
| 🧊 | Icebox | Deferred indefinitely |

## Task Naming

Format: `[NNN]-[slug]`

- `NNN` = 3-digit sequential number (001, 002, ..., 999)
- `slug` = 2-4 lowercase words, hyphen-separated
- Always use next available number (scan `.tasks/` for highest)
- Examples: `001-add-authentication`, `042-refactor-api-layer`

## Priority Labels

| Label | Meaning | Action |
| --- | --- | --- |
| **P0** | Critical | Drop other work, fix immediately |
| **P1** | High | Do this sprint/cycle |
| **P2** | Medium | Backlog — do when capacity allows |
| **P3** | Low | Icebox — revisit quarterly |

## Size Labels

| Label | Complexity | Rough Scope |
| --- | --- | --- |
| **XS** | Trivial | Single file, <1 hour |
| **S** | Low | Known pattern, 1-4 hours |
| **M** | Moderate | Multi-file, some unknowns, 4-8 hours |
| **L** | High | Cross-cutting, significant unknowns, 1-3 days |
| **XL** | Very high | Architecture-level, research needed, 3+ days |

## Cross-References

When linking between task files:

- Reference tasks: `→ see [NNN]-[slug]` or `Refs: [NNN]-[slug]`
- Reference phases: `Phase N of [NNN]-[slug]`
- Reference stories: `Story [NNN]-[slug]/stories/story-NNN-[name].md`
- Reference backlog: `Backlog #[rank] in [NNN]-[slug]/backlog.md`

## Phase Table Format

```markdown
| # | Phase | Size | Status |
|---|-------|------|--------|
| 1 | [Phase name] | [XS-XL] | ⬜ Not Started |
| 2 | [Phase name] | [S] | 🔄 In Progress |
| 3 | [Phase name] | [M] | ✅ Done |
```

## User Story Format

```markdown
**As a** [specific role],
**I want** [observable goal],
**So that** [measurable benefit].
```

## Acceptance Criteria Format

```markdown
- [ ] **Given** [precondition], **When** [action], **Then** [outcome]
```

## File Organization

```
.tasks/[NNN]-[slug]/
  task.md                          # Research + phase table (required)
  roadmap.md                       # Project-level plan (if Planner created)
  backlog.md                       # Priority-ordered items (if Planner created)
  stories/
    story-001-[name].md            # Detailed user stories
  plan/
    phase-1-[name].md              # Detailed phase plans
    phase-2-[name].md
  retro.md                         # Retrospective notes (if reviewed)
```
