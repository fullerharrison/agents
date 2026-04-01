---
name: requirements
description: "User story writing, acceptance criteria, and scope definition. Use when creating stories, defining requirements, breaking down epics, or writing acceptance criteria. Triggers on: 'use requirements mode', 'write a user story', 'acceptance criteria', 'define requirements', 'break down this epic', 'scope this feature', 'INVEST'. Full access mode — can write requirement files."
---

# Requirements Engineering

Write clear, testable requirements. Decompose large initiatives into deliverable stories.

> "A user story is a promise to have a conversation." — Alistair Cockburn

## The INVEST Checklist

Every user story MUST pass all six criteria. If any fails, rewrite before proceeding.

| Criterion | Question | Red Flag |
| --- | --- | --- |
| **Independent** | Can this be built without other stories? | "After story X is done..." |
| **Negotiable** | Can the details flex during implementation? | Prescribes exact solution |
| **Valuable** | Does it deliver value to a user or the business? | "Refactor the internal..." |
| **Estimable** | Is there enough detail to estimate effort? | "Somehow handle edge cases" |
| **Small** | Can it be completed in one iteration/phase? | Touches 5+ subsystems |
| **Testable** | Can you write a test for the acceptance criteria? | "Should be intuitive" |

**The Rewrite Litmus Test**: Read the acceptance criteria aloud. If a QA engineer couldn't write test cases from them alone, the criteria are too vague.

## Story Format

```markdown
# Story: [Concise Title]

**As a** [specific role — not "user"],
**I want** [observable goal — what they do, not how],
**So that** [measurable benefit — why it matters].

## Acceptance Criteria

- [ ] **Given** [specific precondition], **When** [specific action], **Then** [observable outcome]
- [ ] **Given** [specific precondition], **When** [specific action], **Then** [observable outcome]

## Notes
- [Implementation considerations, constraints, or context]
- [Links to related stories or research]
```

### Acceptance Criteria Rules

1. **Specific preconditions** — not "the user is logged in" but "a user with admin role is authenticated"
2. **Single action per criterion** — one When, one Then
3. **Observable outcomes** — things you can see, measure, or query
4. **Include the negative case** — what happens when it goes wrong
5. **Include boundary cases** — empty lists, max values, concurrent access

## Anti-Patterns

| ❌ Don't Write This | ✅ Write This Instead | Why |
| --- | --- | --- |
| "As a user, I want the system to be fast" | "As a shopper, I want search results in <200ms so I don't abandon the page" | Specific role, measurable, testable |
| "Handle all edge cases" | "Given an empty cart, When checkout is clicked, Then show 'Add items first'" | Specific edge case with expected behavior |
| "Implement caching layer" | "As a dashboard user, I want the report to load in <1s on repeat views" | Describes need, not solution |
| "Users should be able to manage their profile" | Break into: view profile, edit name, change email, upload avatar | Each story is independently deliverable |
| "Given the system works, Then it should continue working" | "Given 100 concurrent users, When all submit forms, Then all receive confirmation within 5s" | Testable with specific numbers |

## Epic Decomposition

Break large initiatives into deliverable pieces:

```
Epic: [Large initiative]
├── Feature 1: [Vertical slice of value]
│   ├── Story 1.1: [Smallest deliverable piece]
│   ├── Story 1.2: [Next piece]
│   └── Story 1.3: [Next piece]
├── Feature 2: [Next vertical slice]
│   ├── Story 2.1
│   └── Story 2.2
└── Feature 3: [Next vertical slice]
    └── Story 3.1
```

### Decomposition Rules

1. **Vertical, not horizontal** — each story delivers end-to-end value through all layers, not "build the database layer" then "build the API layer"
2. **Walking skeleton first** — the first story should be the thinnest possible end-to-end path
3. **Happy path, then sad paths** — start with the main flow, add error handling as separate stories
4. **Core, then extensions** — basic feature first, enhancements as follow-up stories
5. **Stop decomposing at "S" size** — if a story is Small enough to estimate confidently, don't break it further

### Decomposition Decision Tree

```
Is this bigger than a single phase of work?
├─ Yes → Is it a clear vertical slice of user value?
│        ├─ Yes → It's a Feature — break into Stories
│        └─ No → It's too horizontal — rethink the slice
└─ No → Is it testable with specific acceptance criteria?
         ├─ Yes → It's a Story — ready to implement
         └─ No → Needs refinement — add acceptance criteria
```

## Scope Definition

Every feature/epic needs explicit boundaries:

```markdown
## Scope

### In Scope
- [Specific thing that IS included]
- [Another specific inclusion]

### Out of Scope
- [Specific thing that is NOT included] — [why]
- [Another exclusion] — [why]

### Deferred
- [Thing that will be done later] — revisit after [trigger]
- [Another deferral] — blocked by [dependency]
```

**Rules:**
- "Out of Scope" means "we explicitly won't do this" — requires a reason
- "Deferred" means "we will do this, but not now" — requires a trigger for when
- If stakeholders keep asking about something, it needs to be in one of these three lists
- Scope boundaries should be reviewed when requirements change

## Rationalization Prevention

| Excuse | Reality | Required Action |
| --- | --- | --- |
| "The requirements are obvious" | Obvious to you ≠ obvious to the implementer | Write them down with acceptance criteria |
| "We'll figure out the details during implementation" | Undefined details become undefined behavior | Define at least the happy path + 1 error case |
| "This story is small enough as-is" | Check INVEST — is it really testable and estimable? | Run the INVEST checklist explicitly |
| "Acceptance criteria are overkill for this" | Without criteria, how do you know when it's done? | One criterion minimum — even for small stories |
| "The epic doesn't need decomposition" | If it's bigger than "S", it needs breaking down | Apply the decomposition decision tree |
| "Scope is implied" | Implied scope is the #1 source of scope creep | Write explicit in-scope / out-of-scope / deferred |

## Quality Checklist

Before finalizing any requirement:

```markdown
- [ ] Story follows "As a / I want / So that" format
- [ ] Role is specific (not "user")
- [ ] Goal is observable (not implementation detail)
- [ ] Benefit is measurable
- [ ] All acceptance criteria use Given/When/Then
- [ ] Happy path covered
- [ ] At least one error/edge case covered
- [ ] INVEST criteria all pass
- [ ] Scope boundaries defined
- [ ] Story is ≤ "S" size (or decomposition planned)
```
