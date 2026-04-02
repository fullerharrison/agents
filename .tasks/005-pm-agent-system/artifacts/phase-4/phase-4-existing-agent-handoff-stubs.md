---
artifact: phase-4-existing-agent-handoff-stubs
task: 005-pm-agent-system
phase: 4
created: 2026-03-18
status: complete
sources:
  - agents-personal/templates/agents/business-analyst.template.md
  - agents-personal/templates/agents/scrum-master.template.md
  - agents-personal/templates/agents/worker.template.md
  - agents-personal/docs/architecture/ADR-001-orchestration-and-subagents.md
  - agents-personal/templates/README.md
---

# Phase 4 — Existing Agent Handoff Stubs (CP-4.3 Evidence)

## Purpose

This document specifies the required additions to the existing BusinessAnalyst, ScrumMaster, and Worker agent templates to enable bidirectional handoffs with ProductOwner. Phase 4 does NOT modify existing agent templates — this artifact specifies what Builder must add during production template generation.

> **Important governance constraint:** These are specification stubs only. The existing agent templates in `agents-personal/templates/agents/` are NOT modified during Phase 4. Builder will implement these additions in a subsequent phase using these stubs as the authoritative specification.

---

## Existing-Agent Handoff Addition Summary

| Agent | Current Tier | Handoff to PO Required | Checkpoint Pause | New Handoff Label | Send on Trigger |
| --- | --- | --- | --- | --- | --- |
| BusinessAnalyst | Tier W-L (write-limited) | YES | YES — PO reviews before cascade | `Return to ProductOwner` | `send: true` |
| ScrumMaster | Tier W (write-enabled) | YES | YES — PO reviews before execution | `Return to ProductOwner` | `send: true` |
| Worker | Tier X (full access) | YES | YES — PO reviews conversion quality | `Classify and Route` | `send: true` |

**Conformance note:** Adding reverse handoff buttons does NOT change existing agent tool scopes, model assignments, or permission tiers. These are additive handoff declarations only.

---

## 1. BusinessAnalyst — Reverse Handoff Stub

### Current Agent Profile

| Attribute | Current Value | Source |
| --- | --- | --- |
| **Tier** | Tier W-L (write-limited) | `business-analyst.template.md` |
| **Tool scope** | Read, Edit, Write (no Bash) | `business-analyst.template.md` |
| **Model** | `opus` (Copilot) / `claude-opus-4-5` (CC) | `business-analyst.template.md` |
| **User-invokable** | `true` | `business-analyst.template.md` |
| **Current handoffs** | Scrum Master (Plan Sprint), self (Save Work) | `business-analyst.template.md` |
| **Current skills** | `prd`, `breakdown-epic-pm`, `breakdown-feature-prd`, `update-specification`, `architecture-blueprint-generator` | `business-analyst.template.md` |

### Required Handoff Addition

Add the following handoff button to `business-analyst.template.md` `copilot.handoffs:` array:

```yaml
- label: Return to ProductOwner
  agent: ProductOwner
  prompt: >
    Requirements updated based on VoC input. ProductOwner review required before cascade proceeds.
    Check: (1) Stakeholder intent captured accurately? (2) Any scope creep detected?
    (3) All guardrail references reflected? Approve cascade or return BA with revision feedback.
  send: true
```

### Checkpoint Pause Requirement

**YES** — ProductOwner must pause and review after receiving this handoff before triggering cascade review.

**PO review protocol:**
1. Review requirements changes against original VoC record.
2. Confirm no unintended scope expansion occurred.
3. Verify requirements traceability back to original stakeholder VoC.
4. Decision: approve cascade, revise BA output, or defer.

### Skill Alignment with PO Workflows

| BA Skill | ProductOwner Integration |
| --- | --- |
| `update-specification` | Directly used when BA updates requirements based on PO VoC; BA triggers after `Update Requirements` handoff |
| `architecture-blueprint-generator` | Invoked if VoC requires new architectural component; result returned to PO via `Return to ProductOwner` |
| `prd` | Used if PO VoC triggers a new feature requiring a full PRD; PRD returned to PO for strategic priority assignment |
| `breakdown-epic-pm` | Used when PO backlog epic requires breakdown into features; BA provides breakdown, PO validates stakeholder alignment |

### Template Modification Notes

- Do NOT change `disallowedTools: [Bash]` — BusinessAnalyst remains no-execute.
- Do NOT change existing handoff buttons (`Plan Sprint` to ScrumMaster, `Save Work` self-reference).
- The `Return to ProductOwner` button is ADDITIVE only.
- Do NOT change BA's output scope (`docs/`, `learning_base/02_requirements/`, `specs/`).
- Confirm that `user-invokable: true` is preserved (BA remains user-accessible).

---

## 2. ScrumMaster — Reverse Handoff Stub

### Current Agent Profile

| Attribute | Current Value | Source |
| --- | --- | --- |
| **Tier** | Tier W (write-enabled) | `scrum-master.template.md` |
| **Tool scope** | Read, Edit, Write (no Bash) | `scrum-master.template.md` |
| **Model** | `opus` (Copilot) / `claude-opus-4-5` (CC) | `scrum-master.template.md` |
| **User-invokable** | `true` | `scrum-master.template.md` |
| **Current handoffs** | Varies by implementation (check current template) | `scrum-master.template.md` |
| **Current skills** | Sprint planning, breakdown workflows | `scrum-master.template.md` |

### Required Handoff Addition

Add the following handoff button to `scrum-master.template.md` `copilot.handoffs:` array:

```yaml
- label: Return to ProductOwner
  agent: ProductOwner
  prompt: >
    Sprint plan complete. Backlog items mapped to sprint tasks with effort estimates
    and acceptance criteria. ProductOwner review required before sprint execution begins.
    Check: (1) Backlog priority order respected? (2) Phase roadmap constraints honored?
    (3) Capacity estimate realistic? Approve execution or request re-planning.
  send: true
```

### Checkpoint Pause Requirement

**YES** — ProductOwner must pause and review after receiving this handoff before sprint execution is authorized.

**PO review protocol:**
1. Review sprint plan for backlog interpretation accuracy.
2. Confirm phase roadmap constraints are honored (no Phase 3 items in a Phase 2 sprint).
3. Confirm capacity estimate is realistic given team availability.
4. Confirm all Must-Have items are included (or explicitly deferred with rationale).
5. Decision: approve execution, request re-planning with specific constraint, or defer sprint pending dependency.

### Skill Alignment with PO Workflows

| SM Skill/Workflow | ProductOwner Integration |
| --- | --- |
| Sprint breakdown | SM receives PO-groomed backlog and breaks into tasks; returns sprint plan to PO via `Return to ProductOwner` |
| Effort estimation | SM assigns final story points; PO reviews against original rough estimate for significant variance (>2x flags escalation) |
| Dependency mapping | SM identifies execution-layer dependencies; PO reviews for strategic impact (does this unblock or block key stakeholder commitments?) |
| Sprint review | SM runs sprint review session and captures outcomes; PO reviews completed vs. deferred items and updates backlog accordingly |

### Template Modification Notes

- Do NOT change existing ScrumMaster tool scope or `disallowedTools`.
- The `Return to ProductOwner` button is ADDITIVE only.
- Preserve all existing ScrumMaster handoff buttons.
- Preserve `user-invokable: true` (SM remains user-accessible).
- Do NOT add `agents:` restriction to SM if not already present — SM delegates via handoff buttons, not subagent spawning.

---

## 3. Worker — Reverse Handoff Stub

### Current Agent Profile

| Attribute | Current Value | Source |
| --- | --- | --- |
| **Tier** | Tier X (full access) | `worker.template.md` |
| **Tool scope** | Read, Edit, Write, Bash, Grep, Glob, LSP (CC); full terminal access (Copilot) | `worker.template.md` |
| **Model** | `sonnet` (CC) | `worker.template.md` (speed-optimized for short isolated tasks) |
| **User-invokable** | `false` (hidden from user-facing invocation) | `worker.template.md` |
| **Current handoffs** | Not defined in base template (invoked by parent agents via subagent pattern) | `worker.template.md`; ADR-001 |
| **Current skills** | File system, conversion mechanics, terminal operations | `worker.template.md` |

### Required Handoff Addition

Add the following handoff button to Worker's `copilot.handoffs:` array for PM-system context:

```yaml
- label: Classify and Route
  agent: ProductOwner
  prompt: >
    Resource conversion complete. Files converted to markdown in learning_base/_inbox/.
    ProductOwner must review conversion quality before classification and routing.
    Check: (1) Is converted markdown readable and complete? (2) Metadata headers correct?
    (3) Any conversion notes or quality warnings in the output?
    Classify acceptable conversions or request re-conversion with clarification.
  send: true
```

### Checkpoint Pause Requirement

**YES** — ProductOwner must pause and review conversion quality before classification proceeds.

**PO review protocol:**
1. Review each converted markdown file in `learning_base/_inbox/`.
2. Check `## Conversion Notes` section for quality warnings.
3. If acceptable: apply `resource-ingestion` skill to classify into correct `learning_base/` folder.
4. If unacceptable: request Worker re-conversion with specific clarification, or escalate to ProjectManager if unrecoverable.

### Conversion Scope Clarification

Worker handles format conversion for:

| File Type | Conversion Tool | Output Format |
| --- | --- | --- |
| `.docx` | `pandoc` (via Bash) | Markdown with metadata header |
| `.eml` | Email parser (via Bash) | Markdown with subject, sender, date, body |
| `.msg` | Outlook message parser (via Bash) | Markdown with metadata header |
| `.jpg`, `.png`, `.gif` | OCR if applicable (via Bash); reference placeholder if OCR unavailable | Markdown with image reference or extracted text |
| `.zip`, `.tar`, `.rar` | Extract and catalog contents (via Bash); classify each extracted file per above rules | Per-file conversion outputs |

Worker does NOT:
- Classify or categorize resources (→ ProductOwner).
- Decide which `learning_base/` folder a resource belongs in (→ ProductOwner).
- Apply learning_base document templates to converted content (→ ProductOwner).
- Make strategic decisions about resource relevance or priority (→ ProductOwner).

### Template Modification Notes

- Do NOT change Worker's `user-invokable: false` — Worker remains hidden from user-facing invocation.
- Do NOT change Worker's `model: sonnet` — Worker remains speed-optimized.
- Do NOT change Worker's `Bash` access — Worker requires Bash for binary conversion.
- The `Classify and Route` handoff button is ADDITIVE only.
- Do NOT add `disallowedTools` to Worker — Worker is full-access by design.
- Note: If Worker template does not currently have a `copilot.handoffs:` block, the block must be ADDED (not modified).

---

## Cross-Agent Bidirectional Handoff Summary (ADR-001 Compliance Evidence)

The following table demonstrates that all three existing agents now have explicit bidirectional handoff compliance with ProductOwner, satisfying ADR-001 §Checkpoint Enforcement requirement for explicit reverse handoffs:

| Agent | PO → Agent | Agent → PO | Trigger Condition | Checkpoint Required |
| --- | --- | --- | --- | --- |
| BusinessAnalyst | `Update Requirements` | `Return to ProductOwner` | Requirements update complete | YES |
| ScrumMaster | `Plan Sprint` | `Return to ProductOwner` | Sprint plan complete | YES |
| Worker | `Convert Resources` | `Classify and Route` | Conversion complete | YES |

**All three existing agents now have explicit reverse handoff paths back to ProductOwner with checkpoint pause requirements. This is the CP-4.3 evidence requirement satisfied.**

---

## Existing Agent Template Integrity Statement

Phase 4 specification confirms the following agent templates are NOT modified for any purpose other than adding the reverse handoff stubs described above:

| Template File | Permitted Change | Prohibited Changes |
| --- | --- | --- |
| `business-analyst.template.md` | Add `Return to ProductOwner` handoff button | No change to tool scope, model, skills, disallowedTools, or output paths |
| `scrum-master.template.md` | Add `Return to ProductOwner` handoff button | No change to tool scope, model, skills, disallowedTools, or output paths |
| `worker.template.md` | Add `Classify and Route` handoff button | No change to Bash access, model, user-invokable: false, or tool scope |

This integrity statement is binding for Builder during production template generation. Any additional changes to existing agent templates require a new plan phase with explicit scope approval.
