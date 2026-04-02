---
phase: 4
title: Optional Validation Checklist
status: 📋 Planned
created: 2026-03-17
artifact: artifacts/phase-4/phase-4-validation-checklist.md
---

# Phase 4 Plan: Optional Validation Checklist

## Objective

Deliver a standalone, self-contained checklist artifact that a developer can run through **after** completing their agent setup (without re-reading the full guidance document). It consolidates every discrete verification step from the end-to-end workflow into a single file that:

1. Confirms generated agent files are **structurally correct and complete**
2. Validates that **template directives** are syntactically valid and properly paired
3. Confirms the agent is **discoverable** in both Copilot and Claude Code

## Non-Duplication Contract with Phase 3

Phase 3 already covers the following material — Phase 4 MUST NOT rewrite these at length:

| Phase 3 location | Content already there |
|---|---|
| Section 6 §"Dry-Run Validation Command" | `make validate` command, success/failure output |
| Section 6 §"Manual Validation Checklist" | 7 inline checkboxes embedded within the narrative |
| Section 7 §"Verify Discoverability in Copilot" | 5-step Copilot discovery walkthrough |
| Section 7 §"Verify Discoverability in Claude Code" | 4-step CC discovery walkthrough |
| Section 8 "Troubleshooting & Edge Cases" | Generation failures, validation issues, installation problems |

Phase 4's **differentiation**: Phase 3 checklists are embedded contextually within narrative steps. Phase 4 provides a **consolidated gate checklist** — a single document, standalone, numbered for traceability, with explicit pass/fail criteria and a back-reference to the Phase 3 section for remediation. It is optimized for use after authoring, not during.

---

## What To Create

**Artifact path:** `artifacts/phase-4/phase-4-validation-checklist.md`

**Format:** A standalone Markdown document, optimized for:
- Printing or side-by-side use during review
- Sequential top-to-bottom execution (numbered items, not just bullets)
- Tracking pass/fail per item (checkbox per item with inline fail-criteria)
- Quick reference back to Phase 3 sections for remediation

---

## Implementation Steps: Sections to Include

### Section A — Pre-Flight: Template File Checks (5–7 items)

Covers structure of the `.template.md` source file before generation runs.

Checks to include:
- A1. File name follows `<slug>.template.md` convention and lives in `templates/agents/`
- A2. YAML frontmatter opens on line 1 with `---`
- A3. `name:` field is present and non-empty in frontmatter
- A4. `description:` field is present and non-empty in frontmatter
- A5. `copilot:` section present in frontmatter (with at least a `tools:` or `allowedTools:` subkey if required)
- A6. `cc:` section present in frontmatter (optional sub-fields permitted but block must exist)
- A7. At least one of `<!-- COPILOT-ONLY -->` / `<!-- CC-ONLY -->` directive or shared body content is present

Each item format:
```
- [ ] **A3 — `name:` present** · Fail: file has blank `name:` or key is absent · Fix: § 2 Frontmatter
```

### Section B — Directive Validity Checks (4–6 items)

Covers correctness of the body directive syntax.

Checks to include:
- B1. Every `<!-- COPILOT-ONLY -->` opening tag has a matching `<!-- /COPILOT-ONLY -->` closing tag
- B2. Every `<!-- CC-ONLY -->` opening tag has a matching `<!-- /CC-ONLY -->` closing tag
- B3. Every `<!-- SHARED -->` block (if used) has a matching `<!-- /SHARED -->` closing tag
- B4. No underscore-variant directives present (`COPILOT_ONLY`, `CC_ONLY` — hyphens required)
- B5. Directive blocks are not nested inside each other (flat structure only)
- B6. No `<!-- COPILOT-ONLY -->` / `<!-- CC-ONLY -->` comment strings appear raw in expected outputs (i.e. generator stripped them)

### Section C — Generation Output Checks (6–8 items)

Confirms `make` ran and produced the expected output files.

Checks to include:
- C1. `generated/copilot/agents/<name>.agent.md` exists after running `make`
- C2. `generated/claude/agents/<name>.md` exists after running `make`
- C3. Copilot output contains platform-specific content from `<!-- COPILOT-ONLY -->` blocks
- C4. Copilot output does NOT contain content from `<!-- CC-ONLY -->` blocks
- C5. CC output contains platform-specific content from `<!-- CC-ONLY -->` blocks
- C6. CC output does NOT contain content from `<!-- COPILOT-ONLY -->` blocks
- C7. Shared body content (outside all directive blocks) appears in both outputs
- C8. Raw directive comment tags (`<!-- COPILOT-ONLY -->` etc.) are absent from both outputs

### Section D — Automated Validation Gate (2–3 items)

Covers the `make validate` automated check.

Checks to include:
- D1. `make validate` exits with code 0 ("All generated files match committed versions")
- D2. If `make validate` fails: diff is reviewed that shows only intentional changes
- D3. No uncommitted generated files exist in the repo (all changes are staged or committed)

### Section E — Installation Checks (4–5 items)

Confirms `./install.sh` ran and files are in the right places.

Checks to include:
- E1. `~/.copilot/agents/<name>.agent.md` exists (Copilot install)
- E2. `~/.claude/agents/<name>.md` exists (Claude Code install)
- E3. No stale old-name files remain in install directories from a previous rename
- E4. Install script exited with code 0 (no errors reported)
- E5. (Windows) Script was run via `bash ./install.sh` from WSL or Git Bash

### Section F — Discoverability Checks (4–5 items)

Confirms the agent is live and invokable in Copilot and Claude Code.

Important: Phase 3 Sections 7.2–7.3 already describe the *how-to* steps. Phase 4 frames these as **pass/fail criteria**, not re-written walkthroughs.

Checks to include:
- F1. Agent name appears in VS Code Copilot agent picker dropdown (after VS Code restart)
- F2. `@<agent-name>` auto-completes in Copilot Chat input
- F3. Agent responds to a minimal test prompt in Copilot Chat
- F4. `@<agent-name>` auto-completes in Claude Code chat input
- F5. Agent responds to a minimal test prompt in Claude Code

Each item references Phase 3 Section 7 for the detailed steps, not re-stated here.

### Section G — Checklist Summary Table (optional but recommended)

A final table showing all A–F sections with a single pass/fail column for quick sign-off:

| Section | Area | # Items | Pass? |
|---|---|---|---|
| A | Template File | 7 | ☐ |
| B | Directive Validity | 6 | ☐ |
| C | Generation Output | 8 | ☐ |
| D | Automated Validation | 3 | ☐ |
| E | Installation | 5 | ☐ |
| F | Discoverability | 5 | ☐ |

---

## Artifact Structure

```
artifacts/phase-4/phase-4-validation-checklist.md
├── Header block (date, status, scope, back-link to Phase 3 guidance)
├── How to Use (2–3 sentences: run top-to-bottom, tick pass/fail, follow Fix: links)
├── Section A — Pre-Flight: Template File Checks
├── Section B — Directive Validity Checks
├── Section C — Generation Output Checks
├── Section D — Automated Validation Gate
├── Section E — Installation Checks
├── Section F — Discoverability Checks
└── Section G — Summary Table
```

Total estimated length: 120–180 lines. Dense but scannable. No prose padding.

---

## Out of Scope

- Re-writing narrative explanations from Phase 3 (those belong in `phase-3-setup-guidance.md`)
- Providing fix scripts or automation (the checklist is manual/semi-manual by design)
- Testing or CI integration for the agents repo itself
- Skill and instruction template validation (agent templates only)

---

## Tests

There is no executable test suite for a Markdown checklist artifact. Validation for this phase is qualitative:

- Every checklist item is unambiguous (one clear pass criterion, one clear fail criterion)
- Every item references the correct Phase 3 section for remediation (no broken anchors)
- No overlap with Phase 3 inline checklists beyond what is needed for traceability
- All 3 goals stated in the task are covered: (1) file correctness, (2) directive validity, (3) discoverability

---

## Verification

### Completeness Review

After creating the artifact, verify against these criteria:

1. **Goal coverage:**
   - [ ] Generated file correctness addressed (Sections C, D)
   - [ ] Directive validity addressed (Section B)
   - [ ] Copilot discoverability addressed (Section F, items F1–F3)
   - [ ] Claude Code discoverability addressed (Section F, items F4–F5)

2. **Non-duplication:**
   - [ ] Section 6 of Phase 3 is referenced, not rewritten
   - [ ] Section 7 of Phase 3 is referenced, not rewritten
   - [ ] No paragraph-level repetition of Phase 3 content

3. **Standalone usability:**
   - [ ] A developer with zero Phase 3 context can execute the checklist and know what pass/fail means for each item
   - [ ] The artifact opens with a clear "How to Use" block
   - [ ] Each item includes both a pass criterion and a `Fix:` reference

### Success Criteria

- `artifacts/phase-4/phase-4-validation-checklist.md` exists and is non-empty
- All 6 check-sections (A–F) present with at least 3 items each
- Summary table (Section G) present
- Phase 4 row in `task.md` updated to ✅ Done after Builder completes

---

## Builder Handoff Notes

- Start from the section breakdown above; use the item format `- [ ] **X# — Label** · Fail: [criterion] · Fix: § [phase-3-section]` consistently throughout
- Keep prose minimal: this is a checklist, not a guide. One line per item is the target
- Reference Phase 3 sections by number and anchor (e.g., `Phase 3 § 6`) not by URL
- The "How to Use" block should be ≤4 sentences
- Do not add a troubleshooting section — that is already Section 8 of Phase 3
