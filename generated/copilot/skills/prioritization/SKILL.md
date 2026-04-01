---
name: prioritization
description: "Priority frameworks, backlog grooming, dependency mapping, and work sequencing. Use when deciding what to work on next, ordering a backlog, comparing competing priorities, or resolving 'everything is urgent'. Triggers on: 'use prioritization mode', 'prioritize', 'what should I work on', 'backlog', 'RICE', 'MoSCoW', 'impact effort', 'rank these', 'triage'. Read-only mode — analyzes and recommends but doesn't modify."
---

# Prioritization

Decide what to do first. Use frameworks to cut through noise and opinion.

> "If everything is important, nothing is important."

## The Three Questions

Before applying any framework, answer:

1. **What is the goal?** — What are we optimizing for? (Revenue? Stability? Speed? User satisfaction?)
2. **What are the constraints?** — Time, people, dependencies, risk appetite
3. **What happens if we do nothing?** — Some items are urgent only because we think they are

## RICE Framework

Score each item. Rank by RICE score (highest first).

| Factor | How to Score | Scale |
| --- | --- | --- |
| **Reach** | How many users/flows/sessions does this affect? | 1–10 (relative scale) |
| **Impact** | How much does it affect each reached user? | 0.25 (minimal), 0.5 (low), 1 (medium), 2 (high), 3 (massive) |
| **Confidence** | How sure are you about Reach and Impact? | 50% (low), 80% (medium), 100% (high) |
| **Effort** | How much work is this? | T-shirt → number: XS=0.5, S=1, M=2, L=4, XL=8 |

**RICE Score** = (Reach × Impact × Confidence) / Effort

### RICE Scoring Guide

**Reach** (scale to your context):
- 10: Affects every user/every request
- 7: Affects most users or a critical flow
- 4: Affects a segment or secondary flow
- 1: Affects edge case or internal tooling

**Impact** (on each affected user):
- 3 (Massive): Unblocks a new capability, eliminates a critical pain point
- 2 (High): Significant improvement to daily workflow
- 1 (Medium): Noticeable improvement
- 0.5 (Low): Minor improvement, nice-to-have
- 0.25 (Minimal): Barely noticeable

**Confidence** (be honest):
- 100%: Data-backed, validated, or trivially obvious
- 80%: Strong intuition + some evidence
- 50%: Speculative — haven't validated with data or users

### RICE Example

| Item | Reach | Impact | Conf | Effort | RICE |
| --- | --- | --- | --- | --- | --- |
| Fix checkout crash | 10 | 3 | 100% | S (1) | **30.0** |
| Add dark mode | 6 | 0.5 | 80% | L (4) | **0.6** |
| API rate limiting | 8 | 2 | 80% | M (2) | **6.4** |

Decision: Fix checkout crash first (30.0 >> 6.4 >> 0.6).

## MoSCoW Method

When RICE feels too granular, use MoSCoW for coarser categorization.

| Category | Definition | Test |
| --- | --- | --- |
| **Must** | Without this, the release fails or is unsafe | "Would we delay the release for this?" → Yes |
| **Should** | Important but the release works without it | "Are users significantly impacted without this?" → Yes |
| **Could** | Nice to have, include if time permits | "Would users notice if we skip this?" → Maybe |
| **Won't** (this time) | Explicitly excluded from current scope | "Can this wait until next cycle?" → Yes |

**Rules:**
- **Must** items should be ≤60% of capacity (leave room for unknowns)
- **Won't** is not "never" — it's "not this cycle"
- If you can't classify something, it's probably **Could**
- Revisit **Won't** items each cycle — some may escalate

## Impact/Effort Matrix

Quick visual sorting into four quadrants:

```
                    HIGH IMPACT
                        │
         Big Bets       │    Quick Wins ★
      (plan carefully)  │    (do these first)
                        │
   LOW EFFORT ──────────┼──────────── HIGH EFFORT
                        │
         Fill-Ins       │    Money Pits ✗
      (when idle)       │    (avoid or decompose)
                        │
                    LOW IMPACT
```

| Quadrant | Action |
| --- | --- |
| **Quick Wins** (high impact, low effort) | Do immediately — best ROI |
| **Big Bets** (high impact, high effort) | Plan carefully, break into phases |
| **Fill-Ins** (low impact, low effort) | Do when capacity allows |
| **Money Pits** (low impact, high effort) | Avoid. If unavoidable, decompose until parts move to other quadrants |

## Dependency Mapping

Before finalizing order, map dependencies:

```markdown
## Dependencies

| Item | Blocks | Blocked By |
|------|--------|------------|
| A: Auth system | B, C | — |
| B: User profiles | D | A |
| C: API endpoints | — | A |
| D: Admin dashboard | — | B |
```

**Sequencing rules:**
1. **Blockers first** — unblocked items can't start until blockers finish
2. **High-risk early** — tackle uncertainty while there's time to course-correct
3. **Quick wins for momentum** — front-load some easy wins for morale and progress signals
4. **Critical path items** — items on the longest dependency chain get priority

## Backlog Grooming Checklist

Run periodically on existing backlogs:

```markdown
- [ ] Remove completed items
- [ ] Close or defer items older than [N] weeks with no progress
- [ ] Re-score items whose context has changed
- [ ] Check for new dependencies between items
- [ ] Verify "Must" items are still Must (priorities shift)
- [ ] Merge duplicate or overlapping items
- [ ] Identify items that can be decomposed into Quick Wins
- [ ] Flag items with no acceptance criteria for refinement
```

## Prioritization Anti-Patterns

| ❌ Anti-Pattern | ✅ Do Instead |
| --- | --- |
| Everything is P0 | Force-rank: only 1–2 items can be P0 at a time |
| Priority by loudness (whoever complains most) | Score objectively — RICE doesn't care who's asking |
| Ignoring dependencies | Map dependencies before ordering |
| Never re-prioritizing | Re-score when context changes (new info, completed work, shifting goals) |
| Optimizing for effort only (always doing easy things) | Balance Quick Wins with Big Bets — easy ≠ impactful |
| Treating "Won't" as permanent | Review Won't items each cycle — some become Must |
| Priority without estimation | You can't calculate RICE without Effort — estimate first |
| Sunk cost bias ("we started this, so finish it") | Evaluate remaining effort and impact, not what's already spent |

## Output Format

When prioritizing a set of items:

```markdown
## Priority Assessment

### Goal
[What we're optimizing for]

### Ranked Items

| Rank | Item | Framework | Score | Size | Action |
|------|------|-----------|-------|------|--------|
| 1 | [Item] | RICE | [N] | [size] | Do now |
| 2 | [Item] | RICE | [N] | [size] | Do next |
| 3 | [Item] | MoSCoW | Should | [size] | This cycle |
| — | [Item] | MoSCoW | Won't | [size] | Defer to [when] |

### Dependencies
[Dependency map if relevant]

### Recommendation
[1-2 sentences on suggested execution order and reasoning]
```
