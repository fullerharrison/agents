---
name: retrospective
description: "Iteration review and improvement tracking. Use when reviewing completed work, analyzing what went well or poorly, identifying patterns, or creating action items. Triggers on: 'use retrospective mode', 'retrospective', 'retro', 'what went well', 'what can we improve', 'lessons learned', 'post-mortem'. Read-only mode — analyzes completed work and produces insights."
---

# Retrospective

Review completed work. Find patterns. Create actionable improvements.

> "We don't learn from experience. We learn from reflecting on experience." — John Dewey

## Core Principles

- **Blameless** — focus on systems and processes, not people
- **Evidence-based** — cite specific tasks, files, and outcomes
- **Actionable** — every insight should produce a concrete action item
- **Comparative** — compare planned vs. actual to calibrate future work

## Retrospective Process

### Step 1: Gather Data

Read completed work from `.tasks/`:

1. **Scan `.tasks/`** for completed tasks (all phases ✅ Done)
2. **Read `task.md`** for each completed task — note:
   - Number of phases planned vs. actually needed
   - Status changes over time (replanned phases, blocked items)
   - Verification results (tests pass/fail, review findings)
3. **Check git log** for the task's commits — note:
   - Number of commits per phase
   - Time between commits (rough effort indicator)
   - Fix-up commits (indicators of rework)
4. **Read phase plans** — compare planned approach to actual implementation

### Step 2: Analyze — What Went Well

Identify things that should be continued:

- Phases that completed smoothly (planned = actual)
- Patterns that worked (testing approach, decomposition, tool usage)
- Estimates that were accurate (and why)
- Reviews that caught real issues before they shipped

### Step 3: Analyze — What Didn't Go Well

Identify things that need improvement:

- Phases that were replanned or significantly changed
- Estimates that were off by >2x (and why)
- Repeated patterns in review findings (same type of issue across tasks)
- Blocked items and what caused the block
- Rework (fix-up commits, re-implementations)

### Step 4: Root Cause Analysis (5 Whys)

For each significant issue, dig to the root:

```
Problem: Phase 3 took 3x longer than estimated
→ Why? Builder hit unexpected API compatibility issues
→ Why? The API wasn't investigated during Explorer research
→ Why? The phase plan didn't include API contract verification
→ Why? Explorer's research checklist didn't cover external API compatibility
→ Root cause: Missing "verify external API contracts" step in research process

Action: Add "external API compatibility check" to Explorer research checklist
```

**Rules:**
- Stop when you reach a systemic/process issue (not a one-off mistake)
- If you reach "someone made a mistake," go one more level — what system allowed the mistake?
- Maximum 5 levels — if you haven't found root cause by then, the problem is too broad to analyze as one item

### Step 5: Identify Patterns

Look across multiple tasks for recurring themes:

| Pattern Type | What to Look For |
| --- | --- |
| **Estimation drift** | Are estimates consistently too low/high? In which areas? |
| **Research gaps** | Do Builders keep discovering things Explorer missed? |
| **Review findings** | Same types of issues appearing across reviews? |
| **Phase bloat** | Phases consistently expanding beyond original scope? |
| **Testing gaps** | Tests missing for certain types of changes? |
| **Dependency surprises** | External dependencies causing unexpected delays? |

### Step 6: Create Action Items

Every retrospective must produce concrete action items:

```markdown
## Action Item: [Title]

- **Category**: [Process | Tooling | Knowledge | Quality]
- **Specific action**: [Exactly what to do]
- **Trigger**: [When/how this action should happen]
- **Success metric**: [How to verify the action worked]
- **Priority**: [P0–P3]
```

**Action item rules:**
- Must be specific and actionable (not "improve testing")
- Must have a trigger (when does it apply?)
- Must have a success metric (how do we know it worked?)
- Limit to 3–5 action items per retrospective (focus over breadth)

## Retrospective Output Format

```markdown
# Retrospective: [Date or Sprint/Cycle Name]

## Scope
- Tasks reviewed: [NNN]-[slug], [NNN]-[slug], ...
- Period: [date range]

## Summary
[2-3 sentence overall assessment]

## What Went Well ✅
| # | Observation | Evidence | Continue Doing |
|---|-------------|----------|----------------|
| 1 | [What worked] | [Task/phase reference] | [How to sustain] |
| 2 | [What worked] | [Task/phase reference] | [How to sustain] |

## What Didn't Go Well ❌
| # | Observation | Evidence | Root Cause |
|---|-------------|----------|------------|
| 1 | [What failed] | [Task/phase reference] | [5 Whys result] |
| 2 | [What failed] | [Task/phase reference] | [5 Whys result] |

## Patterns Detected 🔄
| Pattern | Occurrences | Trend | Severity |
|---------|-------------|-------|----------|
| [Pattern] | [N] tasks | [↑ getting worse / → stable / ↓ improving] | [High/Med/Low] |

## Estimation Accuracy 📊
| Task | Estimated Size | Actual Phases | Accuracy |
|------|---------------|---------------|----------|
| [NNN]-[slug] | [size] | [N] phases | [on target / under / over by Nx] |
| **Average** | | | [overall accuracy] |

## Action Items 🎯
| # | Action | Category | Trigger | Metric | Priority |
|---|--------|----------|---------|--------|----------|
| 1 | [Specific action] | [cat] | [when] | [how to verify] | P[N] |
| 2 | [Specific action] | [cat] | [when] | [how to verify] | P[N] |

## Previous Action Items Review
| Action | Status | Outcome |
|--------|--------|---------|
| [Previous action] | [Done/In Progress/Not Started] | [What happened] |
```

## Anti-Patterns

| ❌ Don't | ✅ Do |
| --- | --- |
| "Everything went fine" (without evidence) | Cite specific tasks and outcomes |
| Blame individuals | Analyze systems and processes |
| "We should try harder" | Identify specific process changes |
| 10+ action items | Focus on 3–5 highest-impact actions |
| Ignore previous retro's action items | Review previous actions first |
| Only look at what went wrong | Celebrate and reinforce what worked |
| "We need better communication" | Specify what information, when, and how |
| Skip the retro because "we're too busy" | Busy teams need retros the most |
