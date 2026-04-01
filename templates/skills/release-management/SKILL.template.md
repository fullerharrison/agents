---
name: release-management
description: "Semantic versioning, changelog management, release checklists, and deployment readiness. Use when preparing releases, bumping versions, writing changelogs, or creating release notes. Triggers on: 'use release-management mode', 'prepare release', 'bump version', 'write changelog', 'release notes', 'semantic version', 'create tag'. Full access mode — can edit release files."

cc:
  allowed-tools: [Read, Edit, Write, Bash, Grep, Glob]
---

# Release Management

Prepare clean, well-documented releases with correct versioning.

> "A changelog is for humans, not machines. Write for the person deciding whether to upgrade."

## Semantic Versioning Decision Tree

```
Does ANY change break backward compatibility?
(removed API, changed behavior, incompatible schema, renamed exports)
├─ Yes → MAJOR bump (X.0.0)
│        Reset MINOR and PATCH to 0
└─ No → Does ANY change add new functionality?
         (new API, new feature, new option, new capability)
         ├─ Yes → MINOR bump (x.Y.0)
         │        Reset PATCH to 0
         └─ No → PATCH bump (x.y.Z)
                  (bug fixes, performance improvements, internal refactors)
```

### Breaking Change Indicators

These changes require a MAJOR bump:

| Area | Breaking If |
| --- | --- |
| **Public API** | Functions/methods removed, renamed, or signature changed |
| **Behavior** | Default behavior changed (even if "improved") |
| **Config** | Config format changed, keys renamed/removed |
| **Schema** | Database schema requires migration |
| **Dependencies** | Minimum version requirements increased |
| **Output** | Output format changed (JSON structure, CLI output, file format) |
| **Compatibility** | Platform/runtime support dropped |

### NOT Breaking (safe for MINOR/PATCH)

- Adding new optional parameters with defaults
- Adding new functions/methods/endpoints
- Adding new config keys with defaults
- Deprecation warnings (without removal)
- Internal refactoring that preserves all public behavior
- Performance improvements

## Keep a Changelog Format

```markdown
# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [X.Y.Z] - YYYY-MM-DD

### Added
- **Feature name** — What it does and why it matters

### Changed
- **Area changed** — How behavior differs from before

### Deprecated
- **Feature name** — What to use instead, removal timeline

### Removed
- **Feature name** — Why it was removed, migration path

### Fixed
- **Bug description** — What was broken and how it's fixed now

### Security
- **Vulnerability** — What was patched, CVE if applicable
```

### Changelog Rules

1. **Human-readable** — write for users deciding whether to upgrade
2. **Reverse chronological** — newest version at the top
3. **Grouped by type** — Added, Changed, Deprecated, Removed, Fixed, Security
4. **One entry per logical change** — group related commits into a single entry
5. **Bold labels** — start each entry with a bolded context label
6. **Link versions** — compare links at the bottom of the file
7. **Unreleased section** — always present for work-in-progress

### What Belongs in the Changelog

| Include | Exclude |
| --- | --- |
| New features | Internal refactoring (no behavior change) |
| Bug fixes | Code style changes |
| Breaking changes | Test-only changes |
| Deprecations | Build system changes (unless user-affecting) |
| Security fixes | Dependency updates (unless security-related) |
| Performance improvements (if notable) | Merge commits |

## Release Checklist

```markdown
## Pre-Release Checklist

### Quality
- [ ] All tests pass (show output)
- [ ] No new lint warnings
- [ ] Type checks pass
- [ ] Manual smoke test completed (if applicable)

### Documentation
- [ ] CHANGELOG.md updated with all user-facing changes
- [ ] Version bumped in all locations (package.json, pyproject.toml, etc.)
- [ ] Unreleased section moved to new version section
- [ ] New empty Unreleased section added
- [ ] Version comparison links updated at bottom of CHANGELOG
- [ ] Breaking changes include migration guide
- [ ] Release notes drafted

### Git
- [ ] All changes committed
- [ ] Branch is clean (no uncommitted changes)
- [ ] Annotated tag created: `git tag -a vX.Y.Z -m "Release vX.Y.Z"`
- [ ] Tag verified: `git show vX.Y.Z`
```

## Release Notes Template

```markdown
# Release vX.Y.Z

[1-2 sentence summary of this release's theme]

## Highlights
- [Most impactful change in plain language]
- [Second highlight]
- [Third highlight, if notable]

## Breaking Changes
[If none: "No breaking changes in this release."]
[If any: describe what changed and how to migrate]

### Migration Guide
[Step-by-step migration for each breaking change]

## What's New
[Expanded descriptions of Added items]

## Bug Fixes
[Expanded descriptions of Fixed items]

## Full Changelog
See [CHANGELOG.md](CHANGELOG.md#xyz---yyyy-mm-dd) for complete details.

## Contributors
[List contributors if applicable]
```

## Pre-Release Versioning

| Stage | Format | Purpose |
| --- | --- | --- |
| **Alpha** | `X.Y.Z-alpha.1` | Early testing, features incomplete |
| **Beta** | `X.Y.Z-beta.1` | Feature complete, testing in progress |
| **RC** | `X.Y.Z-rc.1` | Release candidate, final validation |

Increment the number (alpha.1, alpha.2, ...) for each pre-release iteration.

## Version Comparison Links

At the bottom of CHANGELOG.md, maintain comparison links:

```markdown
[Unreleased]: https://github.com/owner/repo/compare/vX.Y.Z...HEAD
[X.Y.Z]: https://github.com/owner/repo/compare/vA.B.C...vX.Y.Z
[A.B.C]: https://github.com/owner/repo/compare/vD.E.F...vA.B.C
```

## Anti-Patterns

| ❌ Don't | ✅ Do |
| --- | --- |
| Dump git log as changelog | Write human-readable summaries |
| "Various bug fixes" | Describe each fix specifically |
| MINOR bump with breaking changes | Check the breaking change indicators |
| "Updated dependencies" (without context) | Note if dependency update fixes a vulnerability or changes behavior |
| Skip the changelog for "small" releases | Every release gets a changelog entry |
| Create lightweight tags | Always use annotated tags (`git tag -a`) |
| Tag without running tests | Tests pass before tagging — always |
| Forget to update version comparison links | Add the new version to comparison links |
