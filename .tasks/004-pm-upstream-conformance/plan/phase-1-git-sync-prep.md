# Phase 1: Git Sync Prep and Divergence Analysis

## Objective

Map the exact divergence between the `project-management-stakeholder` branch and `upstream/main`. Determine if PM commits from tasks 001–003 exist in git history and can be recovered. Produce a summary that informs the Phase 2 merge strategy.

## Prerequisites

- Working directory: `/Users/harrisonfuller/Library/Mobile Documents/com~apple~CloudDocs/repositories/agents`
- Current branch: `project-management-stakeholder`
- Shell: zsh on macOS
- `upstream` remote must point to `mcouthon/agents`

## Implementation Steps

All steps are git commands. Do NOT run commands longer than ~5 lines.

### Step 1: Verify remote and branch

```bash
git remote -v
```

Confirm `upstream` points to `mcouthon/agents`. If missing, add it:

```bash
git remote add upstream https://github.com/mcouthon/agents.git
```

```bash
git branch --show-current
```

Confirm output is `project-management-stakeholder`.

### Step 2: Fetch upstream

```bash
git fetch upstream
```

### Step 2b: Check origin sync

Check if the local branch and `origin/project-management-stakeholder` are in sync. This reveals if the other machine pushed commits that the local branch doesn't have.

```bash
git log --oneline origin/project-management-stakeholder..HEAD
```

```bash
git log --oneline HEAD..origin/project-management-stakeholder
```

If either command shows commits, the local and remote branches have diverged. Resolve before proceeding (pull or reconcile).

### Step 3: Map divergence — PM branch commits not in upstream

```bash
git log --oneline upstream/main..HEAD --first-parent
```

Record the count and list of commits. These are "our" commits that upstream doesn't have.

### Step 4: Map divergence — upstream commits not in PM branch

```bash
git log --oneline HEAD..upstream/main --first-parent
```

Record the count and list. These are upstream commits we need to incorporate.

### Step 5: Files changed upstream since divergence (summary)

```bash
git diff HEAD...upstream/main --stat
```

This shows the three-dot diff (changes on upstream since the merge base).

### Step 6: List changed files (names only)

```bash
git diff HEAD...upstream/main --name-only
```

Save this output — it's needed for Step 9 to identify Claude-specific files.

### Step 6b: Capture our-side changes since merge base

Get the list of files changed on our branch since the merge base with upstream:

```bash
git diff upstream/main...HEAD --name-only
```

Save this output — it's needed in Step 10 for automated conflict candidate detection.

### Step 7: Search for PM commits from tasks 001–003

Check if commits `44d8970`, `a60ea0b`, `b709837`, `2a40775`, `17dfbc3` exist anywhere in the repo history:

```bash
git log --all --oneline | grep -E '44d8970|a60ea0b|b709837|2a40775|17dfbc3'
```

**If found**: These commits can be cherry-picked or files extracted via `git show <hash>:<path>`.

**If NOT found**: PM templates must be created from scratch using plans in `.tasks/001-*`, `.tasks/002-*`, `.tasks/003-*`. This is the expected outcome given the work was done on a different machine/clone.

### Step 7b: Build recovery manifest (if PM commits found)

If any of the PM commits from Step 7 are found in history, run `git show --stat` on each to document which files those commits touched and their content scope. This gives Phase 3 a recovery manifest.

```bash
git show <hash> --stat
```

Repeat for each found commit hash. Record the output — file paths and change sizes tell Phase 3 exactly what can be cherry-picked or extracted.

### Step 8: Search for PM template files in any branch

```bash
git log --all --oneline -- templates/agents/project-manager.template.md
```

If no results, also try:

```bash
git log --all --oneline -- templates/agents/product-owner.template.md
```

This confirms whether PM template files were ever committed to this clone.

### Step 9: Identify Claude-specific files in the diff

From the Step 6 output, identify files matching these patterns:

| Pattern | Classification |
| --- | --- |
| `generated/claude/**` | Claude-generated output — exclude from merge |
| `CLAUDE.md` | Claude Code root instructions — exclude |
| `.claude/**` | Claude Code config directory — exclude |
| `docs/cc-quickstart.md` | Claude Code documentation — exclude |

Record the full list of Claude-specific files that appear in the diff. These will be `git restore`'d after the merge in Phase 2.

**Important**: Template files containing `<!-- CC-ONLY -->` directives are NOT excluded — they're bidirectional source and must be merged normally.

Also grep the diff for any additional claude-related files not matching the known patterns above:

```bash
git diff HEAD...upstream/main --name-only | grep -i claude
```

Add any unexpected matches to the exclusion list (after manual review).

### Step 10: Produce divergence summary

Document findings in one of these formats:
- Report back in chat (preferred for this phase)
- Or append to this plan file under a `## Results` section

The summary must include:

1. **Divergence counts**: N commits ahead, M commits behind
2. **PM commit recovery**: found / not found (and which ones)
3. **Claude files to exclude**: exact file list from the diff
4. **Merge base**: `git merge-base HEAD upstream/main` hash and date
5. **Recommendation**: merge vs. rebase strategy for Phase 2
6. **Conflict risk**: which files appear in both our commits and upstream's changes

To get the merge base hash and date (captures when divergence happened):

```bash
git log -1 --format="%H %ai %s" $(git merge-base HEAD upstream/main)
```

To find conflict candidates (files changed on both sides), use automated intersection of Step 6 and Step 6b outputs:

```bash
git diff --name-only $(git merge-base HEAD upstream/main)..HEAD | sort > /tmp/ours.txt
```

```bash
git diff --name-only $(git merge-base HEAD upstream/main)..upstream/main | sort > /tmp/theirs.txt
```

```bash
comm -12 /tmp/ours.txt /tmp/theirs.txt
```

The output of `comm -12` is the exact list of conflict candidates — files modified on both sides since the merge base.

## Success Criteria

- [ ] `git remote -v` shows upstream configured correctly
- [ ] Upstream is fetched (latest refs available)
- [ ] Divergence is mapped — commit counts in both directions documented
- [ ] PM commit recovery status is determined (found / not found for each of the 5 hashes)
- [ ] Claude files to exclude are identified from the actual diff output
- [ ] Merge base hash is recorded
- [ ] Conflict candidates are identified (files changed on both sides)
- [ ] Summary produced with clear recommendation for Phase 2 approach

## Verification

### Automated Checks

- `git remote -v` — upstream remote is present and points to correct repo
- `git fetch upstream` — exits 0 (no errors)
- `git log --all --oneline | grep -cE '44d8970|a60ea0b|b709837|2a40775|17dfbc3'` — count of found commits (0 = none recovered)

### Manual Verification Steps

1. Review divergence commit list — confirm PM-related commits (if any) are identified
2. Review Claude file list — confirm it covers `generated/claude/`, `CLAUDE.md`, `.claude/`, `docs/cc-quickstart.md` and nothing else is accidentally excluded
3. Review conflict candidate list — confirm overlap between local and upstream changes makes sense

### Demo Statement

Developer runs the divergence analysis commands and has a complete summary showing commit counts, PM commit recovery status, and a list of Claude files to exclude — enough to confidently execute the Phase 2 merge.

## Notes

- This is a **read-only, terminal-heavy phase** — no files are modified (except optionally this plan)
- If upstream remote is already configured and fetched, steps 1–2 are instant
- The `sync_upstream_notes.txt` in the repo root describes a rebase workflow (`rebase main` then force-push). Phase 2 will decide between merge and rebase based on findings here
- Commands reference `--first-parent` to keep the log clean; if the branch has merge commits, this avoids expanding merged branch histories

---

## Findings

_Executed: 2026-04-10_

### 1. Divergence Counts

| Direction | Count | Details |
| --- | --- | --- |
| Commits **ahead** of upstream/main | **7** | See commit list below |
| Commits **behind** upstream/main | **0** | Branch is fully absorbed — upstream already merged |

**Our 7 commits (newest first):**

| Hash | Date | Message |
| --- | --- | --- |
| `86e1479` | 2026-04-10 | Merge branch 'main' into project-management-stakeholder |
| `f6349ea` | 2026-04-10 | update (deleted stale `.tasks/002-new-agent-setup-guide` artifacts + `.tasks/005-pm-agent-system/`) |
| `634f81b` | 2026-04-02 | updates (added `.gitattributes`, `scripts/install-windows.ps1`, updated setup guidance) |
| `e44a36d` | 2026-04-02 | task update (added `.tasks/002-new-agent-setup-guide` artifacts) |
| `876c50e` | 2026-04-02 | update tasks (added `.tasks/001-003` task files and plans) |
| `ea9aefa` | 2026-03-31 | build z team (added PM templates, skills, generated files — 52 files) |
| `450e0ac` | 2026-03-27 | first commit (added `sync_upstream_notes.txt`) |

### 2. Merge Base

```
510d4f44204ed0a02ff8e68dea5ca820ac1dc4dd  2026-04-10 22:38:46 +0300
fix(conductor): reorder delivery report fields to prevent Try It truncation
```

**Critical insight**: The merge base is the **current tip of upstream/main** (`510d4f4` = `upstream/main` = `origin/main`). Commit `86e1479` merged `main` into our branch today. **Phase 2 as originally scoped (merge upstream) is already complete.**

### 3. PM Commit Recovery

| Commit Hash | Found? | Notes |
| --- | --- | --- |
| `44d8970` | ❌ Not found | Was from a different machine/clone |
| `a60ea0b` | ❌ Not found | Was from a different machine/clone |
| `b709837` | ❌ Not found | Was from a different machine/clone |
| `2a40775` | ❌ Not found | Was from a different machine/clone |
| `17dfbc3` | ❌ Not found | Was from a different machine/clone |

**Conclusion**: None of the 5 expected PM commits from tasks 001–003 exist in this clone's history. The PM work from those tasks was done in a different repository on a different machine (Windows, `C:\Users\s1058662\...`). PM templates must be created from scratch.

**However**: Commit `ea9aefa` ("build z team", 2026-03-31) already added substantial PM work to this clone:
- PM skill templates (8 skills: estimation, github-sync, knowledge-management, prioritization, release-management, requirements, retrospective, risk-assessment)
- PM instruction template (`templates/instructions/project-management.template.md`)
- Modified core agent templates (analyst, planner, releaser, triager, explorer, reviewer)
- All corresponding generated files for both Copilot and Claude

**Missing PM agents** (never committed to this clone):
- `templates/agents/project-manager.template.md`
- `templates/agents/product-owner.template.md`
- `templates/agents/business-analyst.template.md`
- `templates/agents/scrum-master.template.md`
- `templates/agents/frontend-dev.template.md`
- `templates/agents/backend-dev.template.md`
- `templates/agents/qa-engineer.template.md`
- `templates/agents/uiux-designer.template.md`
- `docs/pm-agents.md`

### 4. Claude Files to Exclude (from diff)

Since the upstream merge is already done, the `generated/claude/**` files on our branch reflect our PM work. No new `git restore` pass is needed.

**Claude-only files present on our branch** (from `git diff upstream/main...HEAD --name-only`):

```
generated/claude/agents/analyst.md
generated/claude/agents/builder.md
generated/claude/agents/committer.md
generated/claude/agents/conductor.md
generated/claude/agents/explorer.md
generated/claude/agents/planner.md
generated/claude/agents/releaser.md
generated/claude/agents/researcher.md
generated/claude/agents/reviewer.md
generated/claude/agents/triager.md
generated/claude/agents/worker.md          ← stale orphan (cleanup_known_orphans handles at install)
generated/claude/rules/project-management.md
generated/claude/skills/estimation/SKILL.md
generated/claude/skills/github-sync/SKILL.md
generated/claude/skills/knowledge-management/SKILL.md
generated/claude/skills/prioritization/SKILL.md
generated/claude/skills/release-management/SKILL.md
generated/claude/skills/requirements/SKILL.md
generated/claude/skills/retrospective/SKILL.md
generated/claude/skills/risk-assessment/SKILL.md
```

No `CLAUDE.md` or `.claude/` directory found in our diff. No `docs/cc-quickstart.md` in our diff.

**`grep -i claude` on diff returned 0 results** — all claude-specific content is under `generated/claude/` and correctly categorized above.

### 5. Conflict Candidates

```
comm -12 /tmp/ours.txt /tmp/theirs.txt → (empty)
```

**Zero conflict candidates.** Upstream has 0 changes since merge base (because the merge base IS the upstream tip). No merge conflicts to resolve.

### 6. Recommendation for Phase 2

**Phase 2 as planned ("Merge Upstream, Excluding Claude Files") is ALREADY DONE** via the `86e1479` merge commit from today.

**Revised Phase 2 scope**:
1. **Verify the merge quality** — confirm generated files match what `make` would produce from the current templates (no stale states)
2. **Remove stale `worker.md` orphan** from `generated/claude/agents/` if `install.sh` cleanup doesn't handle it
3. **Pivot directly to Phase 3** — the real work is creating the 8 missing specialized PM agent templates from scratch

**Recommended strategy**: Skip Phase 2 as a blocking gate. Treat it as a 30-minute verification step, then proceed immediately to Phase 3 (template creation) and Phase 4 (conformance). The upstream merge is done; the PM template gap is the critical path.
