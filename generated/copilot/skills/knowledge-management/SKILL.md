---
name: knowledge-management
description: "Knowledge base organization, entry writing, cataloging, and synthesis. Use when managing a project learning base, writing knowledge entries, organizing information by topic, or synthesizing findings across sources. Triggers on: 'use knowledge-management mode', 'knowledge base', 'learning base', 'catalog this', 'add to knowledge', 'knowledge entry', 'synthesize findings'. Full access mode — can read and write knowledge files."
---

# Knowledge Management

Organize information into structured, searchable, cross-referenced knowledge.

> "In knowledge management, the goal isn't to capture everything — it's to capture what changes behavior."

## Core Principles

1. **One concept per entry** — never mix multiple distinct ideas into one file
2. **Source everything** — every claim traces to a verifiable source
3. **Tag consistently** — tags power cross-cutting discovery
4. **Confidence honestly** — distinguish verified from speculative
5. **Synthesize regularly** — raw entries become wisdom only when connected

## Entry Quality Checklist

Before saving any knowledge entry:

```markdown
- [ ] Title is specific and searchable (not "Notes on X")
- [ ] Source is cited (URL, file path, or task reference)
- [ ] Date recorded
- [ ] Topic assigned (matches existing topic or new one justified)
- [ ] Tags assigned (minimum 2)
- [ ] Confidence level set (High/Medium/Low)
- [ ] Summary is ≤3 sentences
- [ ] Key findings are distinct bullet points (not prose)
- [ ] Actionable insights section present (even if empty)
- [ ] Cross-references added (even if just "none yet")
```

## Topic Taxonomy

Good topics are:
- **Narrow enough** to hold related entries (not "programming")
- **Broad enough** to cluster multiple entries (not "that one bug")
- **Noun-based** not action-based ("authentication" not "implementing auth")
- **Stable** — topics shouldn't need renaming often

**Creating a new topic:**
- Check if it fits under an existing topic as a subtopic first
- If truly new: create `topics/[slug]/index.md`
- Add to `catalog.md` topics table
- Use `[slug]` format: lowercase, hyphen-separated

## Tag Conventions

Tags enable cross-cutting search across topics:

| Tag Pattern | Examples | Purpose |
| --- | --- | --- |
| **Source type** | `source:web`, `source:codebase`, `source:task`, `source:book` | Filter by where knowledge came from |
| **Confidence** | `confidence:high`, `confidence:low` | Filter by reliability |
| **Status** | `status:synthesized`, `status:needs-review`, `status:outdated` | Lifecycle tracking |
| **Action needed** | `action:task`, `action:skill`, `action:instruction` | Flagged for extraction |
| **Domain** | `domain:security`, `domain:performance`, `domain:ux` | Cross-topic domain tagging |

## Confidence Levels

| Level | When to Use |
| --- | --- |
| **High** | Verified by direct testing, official docs, or multiple independent sources confirming |
| **Medium** | Single source, plausible but not independently verified, inferred from evidence |
| **Low** | Speculative, single anecdotal source, second-hand, or contradicted by other sources |

**Never omit confidence.** Unmarked entries are assumed unreliable.

## Anti-Patterns

| ❌ Don't | ✅ Do |
| --- | --- |
| "Notes on meeting with X" | Extract specific insights as separate tagged entries |
| Copying raw content verbatim | Summarize the key insight; link to source |
| Generic tags like "important" | Use structured tags: `source:web`, `domain:auth` |
| One giant synthesis doc for everything | One synthesis per topic cluster |
| Entries with no cross-references | Even "no related entries yet" is better than blank |
| Updating entries in-place without noting the update | Append `Updated: [date] — [what changed]` |
| Flagging everything as High confidence | Be honest — Medium is the right default for most findings |

## Ingestion Decision Tree

```
New information arrives
├─ Is it a single coherent concept?
│   ├─ Yes → Create one entry
│   └─ No → Break into multiple entries first
│
├─ Does an existing topic fit?
│   ├─ Yes → Add to that topic
│   └─ No → Is this a genuinely distinct domain?
│             ├─ Yes → Create new topic
│             └─ No → Find closest topic and use subtopic
│
└─ Is it actionable?
    ├─ Yes → Add to Actionable Insights section AND flag with action:* tag
    └─ No → Leave Actionable Insights section empty (don't delete it)
```

## Synthesis Triggers

Run a synthesis for a topic when:

- 5+ new entries added since last synthesis
- Entries contain contradictory findings
- Preparing to make a decision informed by the topic
- Onboarding someone to the knowledge area
- Quarterly knowledge base review

**Synthesis scope rule:** One synthesis doc per topic. If a topic has sub-themes, create subsections within the topic synthesis — don't split into multiple synthesis files.

## Catalog Maintenance

The catalog is the map to the knowledge base. Keep it accurate:

- Update `catalog.md` after **every** ingestion session (even single entries)
- The tag index is the most valuable navigation tool — keep it current
- Mark entries with `status:outdated` when superseded (don't delete — history matters)
- Archive topics with zero entries last 90 days to `topics/archived/`

Return: confirmation of file created with line count.
