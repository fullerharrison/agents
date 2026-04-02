# Phase 2 - PM-Tool Recommendations Skill + Wiring

**Status:** 📋 Planned  
**Files:** `templates/skills/pm-tool-recommendations/SKILL.template.md`, `templates/agents/project-manager.template.md`, `templates/agents/product-owner.template.md`, `templates/agents/business-analyst.template.md`, `templates/agents/scrum-master.template.md`  
**ADR reference:** ADR-008 §Key Architectural Patterns §1 (PM-Tool Recommendation Trigger), WS-007 (PM-TOOL-LOGIC)

---

## Overview

This phase introduces a shared PM recommendations skill and wires it into the four PM agent templates defined in Phase 2 scope:

1. Create a new skill template at `templates/skills/pm-tool-recommendations/SKILL.template.md`.
2. Add the skill to `cc.skills` in all four PM templates.
3. Add an explicit `## PM Framework Recommendations` section in each PM template body so invocation behavior is deterministic and auditable.

The recommendation logic must proactively surface framework guidance only when qualifying context signals are present and must rank outputs by signal strength.

---

## Framework Trigger Table (Authoritative Mapping)

This table is the required trigger contract for the new skill and all four wiring sections.

| Signal Family | Qualifying Context Signal (examples) | Recommended Framework | Recommendation Intent | Output Priority Rule |
| --- | --- | --- | --- | --- |
| Root-cause diagnosis | unresolved blocker, unknown cause, repeated failure, "why is this failing" | Fishbone (Ishikawa) | Structure causal analysis across people/process/tooling/data | Rank above all others when blocker/root-cause language is explicit |
| Accountability clarity | ownership confusion, role overlap, "who is responsible", handoff ambiguity | RACI | Clarify Responsible/Accountable/Consulted/Informed roles | Rank highest when role ambiguity is explicit |
| Risk/governance tracking | mention of risks, assumptions, issues, dependencies, mitigation tracking | RAID Log | Create a structured RAID register and owners | Rank highest when two or more RAID terms are explicit |
| Decision rights | unclear approver, governance conflict, tie-breaker needed, decision deadlock | RAPID/DACI | Define decision-maker and contributor roles | Rank highest when decision-rights conflict is explicit |
| Portfolio prioritization | competing initiatives, investment trade-offs, growth/share discussion | BCG Matrix | Compare initiatives by value vs investment profile | Rank highest when portfolio prioritization is explicit |
| Stakeholder landscape | unknown influence map, sponsor uncertainty, stakeholder conflict | Stakeholder Analysis | Map power/interest and engagement strategy | Rank highest when stakeholder ambiguity/conflict is explicit |
| Initiative kickoff | new initiative, project launch, scope baseline request | Project Charter | Establish scope, objectives, constraints, authority | Rank highest when kickoff/new-project signals are explicit |

**Multi-signal ranking:**
- Compute recommendation order by signal specificity: explicit phrase match > semantic intent match > weak contextual hint.
- If two or more frameworks have equal confidence after specificity scoring, break ties using this deterministic order: Fishbone (Ishikawa) > RACI > RAID Log > RAPID/DACI > Stakeholder Analysis > BCG Matrix > Project Charter.
- Surface top recommendation first, followed by up to 2 secondary recommendations.
- Suppress all recommendations when no qualifying signal is present (false-positive guard).

**Platform wiring expectations (deterministic):**
- Claude: wire `pm-tool-recommendations` through frontmatter `cc.skills` in all four PM templates so the skill is available for explicit invocation.
- Copilot: enforce behavior through the inserted `## PM Framework Recommendations` body instructions, because invocation behavior relies on prompt/body guidance and generated skill availability after regeneration.
- Phase 6 must verify both generated trees expose the same capability intent: skill availability in generated outputs plus body-level recommendation instructions.

---

## Exact File Edits

### 1) New file: `templates/skills/pm-tool-recommendations/SKILL.template.md`

Create a new skill template with:

- YAML frontmatter:
  - `name: pm-tool-recommendations`
  - `description`: PM framework recommendation logic for qualifying planning/governance signals
- Body sections:
  - `# PM Tool Recommendations`
  - `## Trigger Contract` (contains the exact framework table above)
  - `## Ranking and Conflict Resolution`
  - `## False-Positive Guard`
  - `## Output Format`

Required output format block:

```markdown
PM-TOOL-RECOMMENDATION:
  status: recommended | not-applicable
  primary_framework: <framework-name | none>
  confidence: high | medium | low
  qualifying_signals:
    - <signal-1>
    - <signal-2>
  secondary_frameworks:
    - <framework-name>
  rationale: <brief reason tied to observed signal>
  next_action: <explicit user/agent action>
```

### 2) Update file: `templates/agents/project-manager.template.md`

#### A. `cc.skills` wiring

Edit frontmatter `cc.skills` list:

- Current:
  - `skills: ["architecture", "deep-research", "critic"]`
- New:
  - `skills: ["architecture", "deep-research", "critic", "pm-tool-recommendations"]`

#### B. Body wiring

Insert a new section `## PM Framework Recommendations` after `## Entry Point Routing Matrix` and before `## Checkpoint Decision Options`.

Section requirements:
- State that PM evaluates incoming workflow context for qualifying PM-tool signals.
- Require `pm-tool-recommendations` usage before escalation decisions when ambiguity, blocker diagnosis, governance conflict, or prioritization trade-off is detected.
- Require the `PM-TOOL-RECOMMENDATION` block in escalation notes.

### 3) Update file: `templates/agents/product-owner.template.md`

#### A. `cc.skills` wiring

Edit frontmatter `cc.skills` list:

- Current:
  - `skills: ["resource-ingestion", "stakeholder-feedback", "requirements-cascade", "backlog-management"]`
- New:
  - `skills: ["resource-ingestion", "stakeholder-feedback", "requirements-cascade", "backlog-management", "pm-tool-recommendations"]`

#### B. Body wiring

Insert `## PM Framework Recommendations` after `## Entry Point Routing` and before `## Domain Language Reference`.

Section requirements:
- Require tool recommendation check in three PO contexts:
  - VoC ambiguity / role conflict -> RACI or Stakeholder Analysis
  - Backlog prioritization trade-offs -> BCG
  - New initiative intake -> Project Charter
- Enforce false-positive guard: do not output recommendations when user request is operational-only (for example, straightforward file ingestion).

### 4) Update file: `templates/agents/business-analyst.template.md`

#### A. `cc.skills` wiring

Edit frontmatter `cc.skills` list:

- Current:
  - `skills: [prd, breakdown-epic-pm, breakdown-feature-prd, update-specification, architecture-blueprint-generator]`
- New:
  - `skills: [prd, breakdown-epic-pm, breakdown-feature-prd, update-specification, architecture-blueprint-generator, pm-tool-recommendations]`

#### B. Body wiring

Insert `## PM Framework Recommendations` after `## Available Skills` table and before `## Workflow`.

Section requirements:
- Trigger guidance for BA contexts:
  - unclear ownership in requirement flows -> RACI
  - risks/assumptions/dependencies in requirements updates -> RAID
  - governance/decision-right uncertainty in scope approval -> RAPID/DACI
- Require recommendation output in structured block when qualifying signal exists.

### 5) Update file: `templates/agents/scrum-master.template.md`

#### A. `cc.skills` wiring

Edit frontmatter `cc.skills` list:

- Current:
  - `skills: [breakdown-plan, breakdown-epic-arch, update-implementation-plan, project-workflow-analysis-blueprint-generator, folder-structure-blueprint-generator, readme-blueprint-generator]`
- New:
  - `skills: [breakdown-plan, breakdown-epic-arch, update-implementation-plan, project-workflow-analysis-blueprint-generator, folder-structure-blueprint-generator, readme-blueprint-generator, pm-tool-recommendations]`

#### B. Body wiring

Insert `## PM Framework Recommendations` after `## Available Skills` table and before `## Workflow`.

Section requirements:
- Trigger guidance for SM contexts:
  - sprint blockers with unknown cause -> Fishbone
  - dependency/risk management during planning -> RAID
  - prioritization among competing sprint candidates -> BCG
  - kickoff planning for new delivery thread -> Project Charter

---

## Implementation Checklist

- [ ] Create `templates/skills/pm-tool-recommendations/SKILL.template.md` with trigger table, ranking logic, and output schema
- [ ] Add `pm-tool-recommendations` to `cc.skills` in all 4 PM templates
- [ ] Add `## PM Framework Recommendations` section to each PM template body at specified insertion points
- [ ] Ensure all seven required frameworks are present by name: RACI, RAID Log, Fishbone (Ishikawa), RAPID/DACI, BCG Matrix, Stakeholder Analysis, Project Charter
- [ ] Ensure recommendation logic includes suppression when no qualifying signal exists

---

## Out of Scope

- Implementing ingestion error-path blocks (`INGESTION-DECISION`) in ProductOwner/BusinessAnalyst (Phase 3)
- Teams Planner output contract in BusinessAnalyst (Phase 4)
- Role boundary guards for all PM agents (Phase 5)
- Regeneration/install/validation run (`make && ./install.sh`) execution (Phase 6)

---

## Tests

Behavioral and static checks for this phase:

1. **Skill presence and metadata**
```bash
test -f templates/skills/pm-tool-recommendations/SKILL.template.md
rg -n "^name:\s*pm-tool-recommendations$" templates/skills/pm-tool-recommendations/SKILL.template.md
```

2. **Framework contract completeness (7/7 required frameworks)**
```bash
rg -n "RACI|RAID|Fishbone|Ishikawa|RAPID|DACI|BCG|Stakeholder Analysis|Project Charter" templates/skills/pm-tool-recommendations/SKILL.template.md
```
Expected: all seven framework categories represented.

3. **Wiring in all 4 PM templates**
```bash
rg -n "pm-tool-recommendations" templates/agents/project-manager.template.md templates/agents/product-owner.template.md templates/agents/business-analyst.template.md templates/agents/scrum-master.template.md
```
Expected: at least one frontmatter `skills` hit per file, plus body-section references.

4. **Body section presence in all 4 PM templates**
```bash
rg -n "^## PM Framework Recommendations" templates/agents/project-manager.template.md templates/agents/product-owner.template.md templates/agents/business-analyst.template.md templates/agents/scrum-master.template.md
```
Expected: exactly 1 section heading in each file.

5. **Additive-only guard (no template deletions, one new section per file, one new skill item)**
```bash
git diff -- templates/agents/project-manager.template.md templates/agents/product-owner.template.md templates/agents/business-analyst.template.md templates/agents/scrum-master.template.md
```
Expected: diffs are additive-only for the four templates, with no removed existing sections/policies; each file adds exactly one `## PM Framework Recommendations` section and exactly one `pm-tool-recommendations` skill item.

6. **Placement checks (inserted sections between exact anchors)**
```bash
rg -n "## Entry Point Routing Matrix|## PM Framework Recommendations|## Checkpoint Decision Options" templates/agents/project-manager.template.md
rg -n "## Entry Point Routing|## PM Framework Recommendations|## Domain Language Reference" templates/agents/product-owner.template.md
rg -n "## Available Skills|## PM Framework Recommendations|## Workflow" templates/agents/business-analyst.template.md
rg -n "## Available Skills|## PM Framework Recommendations|## Workflow" templates/agents/scrum-master.template.md
```
Expected: in each file, heading order confirms `## PM Framework Recommendations` appears after the first named anchor and before the second named anchor.

---

## Verification

### Automated Checks

Run:

```bash
make validate
rg -n "pm-tool-recommendations" templates/agents/project-manager.template.md templates/agents/product-owner.template.md templates/agents/business-analyst.template.md templates/agents/scrum-master.template.md
rg -n "RACI|RAID|Fishbone|Ishikawa|RAPID|DACI|BCG|Stakeholder Analysis|Project Charter" templates/skills/pm-tool-recommendations/SKILL.template.md
git diff -- templates/agents/project-manager.template.md templates/agents/product-owner.template.md templates/agents/business-analyst.template.md templates/agents/scrum-master.template.md
rg -n "## Entry Point Routing Matrix|## PM Framework Recommendations|## Checkpoint Decision Options" templates/agents/project-manager.template.md
rg -n "## Entry Point Routing|## PM Framework Recommendations|## Domain Language Reference" templates/agents/product-owner.template.md
rg -n "## Available Skills|## PM Framework Recommendations|## Workflow" templates/agents/business-analyst.template.md
rg -n "## Available Skills|## PM Framework Recommendations|## Workflow" templates/agents/scrum-master.template.md
```

### Manual Verification Steps

1. Open each PM template and confirm `pm-tool-recommendations` is present in `cc.skills`.
2. Confirm each PM template contains one `## PM Framework Recommendations` section at the planned insertion point.
3. Open the new skill file and confirm the trigger contract table covers all 7 framework categories and includes ranking + false-positive guard.
4. Inspect template diffs and confirm edits are additive-only in the four PM templates: no removed legacy sections, one new heading section per file, and one appended skill token in each frontmatter list.
5. Confirm anchor ordering in each PM template shows inserted section between the exact source/target headings defined in this phase.

### Success Criteria

- New skill template exists at `templates/skills/pm-tool-recommendations/SKILL.template.md` with trigger table, ranking rules, false-positive guard, and structured output schema.
- All four PM templates include `pm-tool-recommendations` in `cc.skills`.
- All four PM templates include a deterministic `## PM Framework Recommendations` section.
- Trigger contract includes all required framework families and maps each to explicit qualifying signals.
- Additive-only constraint passes for all four PM templates (no deletions, one new section per file, one new skill item).
- Placement checks confirm inserted sections are between exact anchor headings in each PM template.
- Validation checks return expected matches with no missing framework or missing wiring references.

---

## Phase 6 Handoff Note (Post-Generate Verification)

When Phase 6 performs regeneration/install/validation, verify both generated trees reflect this phase:

- `generated/claude/`: confirm PM agents include `pm-tool-recommendations` in generated skill wiring and retain `## PM Framework Recommendations` guidance.
- `generated/copilot/`: confirm generated agent/instruction artifacts preserve body-level PM recommendation behavior and expose generated skill availability for invocation.

Phase 6 handoff must include a short parity check summary confirming both trees carry equivalent PM-tool recommendation intent.
