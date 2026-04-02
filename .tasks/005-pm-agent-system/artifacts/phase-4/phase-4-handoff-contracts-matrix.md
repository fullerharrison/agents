---
artifact: phase-4-handoff-contracts-matrix
task: 005-pm-agent-system
phase: 4
created: 2026-03-18
status: complete
sources:
  - agents-personal/templates/agents/business-analyst.template.md
  - agents-personal/templates/agents/scrum-master.template.md
  - agents-personal/templates/agents/worker.template.md
  - agents-personal/templates/agents/conductor.template.md
  - agents-personal/docs/architecture/ADR-001-orchestration-and-subagents.md
  - agents-personal/docs/architecture/ADR-002-task-centric-persistence.md
  - learning_base/ideas/pm_agent_coordination_system_implementation_plan.md
  - learning_base/REVIEW_WORKFLOW.md
---

# Phase 4 — Handoff Contracts Matrix (CP-4.2 Evidence)

## Purpose

This document defines explicit bilateral handoff contracts between ProductOwner and each of the three existing agents it works with: BusinessAnalyst, ScrumMaster, and Worker. Each contract specifies the upstream caller, trigger phrase, input expected, output produced, downstream consumers, checkpoint pause requirement, and reverse handoff path.

> **Governance note:** All handoff designs trace to ADR-001 §Checkpoint Enforcement and `conductor.template.md` handoff button pattern. See `phase-4-source-traceability-matrix.md` for full citations.

---

## Handoff Contract 1: ProductOwner → BusinessAnalyst (CP-4.2 Evidence)

### Summary

| Field | Value |
| --- | --- |
| **Direction** | ProductOwner → BusinessAnalyst |
| **Trigger Phrase** | "Update requirements based on" or "Incorporate VoC into" |
| **Upstream Caller** | ProductOwner (via `stakeholder-feedback` or `requirements-cascade` skill completion) |
| **Checkpoint Pause Required** | **YES** — ProductOwner review required after BA completes requirements update |
| **Handoff Button Label** | `Update Requirements` |
| **Reverse Handoff Label** | `Return to ProductOwner` |

### Input Expected by BusinessAnalyst

ProductOwner must supply all of the following before the handoff is valid:

| Input Component | Format | Required |
| --- | --- | --- |
| VoC record path | Markdown file at `learning_base/11_voice_of_customer/voc_NNN_*.md` | **Required** |
| Verbatim stakeholder quotes | Embedded in VoC record under `## Verbatim Evidence` section | **Required** |
| Quantified pain points | Frequency and impact ratings in VoC record | **Required** |
| Guardrail mappings | Table in VoC record linking pain points to specific guardrails | **Required** |
| Feature requests with impact/frequency | Prioritized table in VoC record | **Required** |
| Cascade scope (if available) | Path to cascade review summary at `.tasks/005-pm-agent-system/cascade-review-*.md` | Optional — if already run |

**Input validation gate:** BusinessAnalyst MUST NOT begin requirements update if VoC record is missing `guardrail_mapping` metadata or if verbatim quotes section is empty. BA must return to ProductOwner with a specific data request before proceeding.

### Output Produced by BusinessAnalyst

| Output Component | Location | Required Metadata |
| --- | --- | --- |
| Updated requirements document(s) | `learning_base/02_requirements/` | `last_updated`, `voc_source`, `guardrail_reference`, `changed_by: BusinessAnalyst` |
| Traceability notes | Embedded in requirements doc under `## Change Rationale` | `voc_file`, `stakeholder`, `date` |
| Feasibility assessment | Inline notes in requirements doc under `## Architecture Notes` | If architecture impact is found |
| Scope flag (if scope creep detected) | Comment in requirements doc + flag to ProductOwner in reverse handoff | `scope_risk: true`, `description` |

### Downstream Consumers

| Consumer | What They Receive | When |
| --- | --- | --- |
| ProductOwner | Requirements update confirmation + scope flag (if applicable) | After BA completes; PO must review before cascade proceeds |
| ProjectManager | Checkpoint decision notification | After PO review confirms no scope creep |
| ScrumMaster | Updated requirements as sprint planning input | After PO approves cascade and backlog is groomed |
| FrontendDev / BackendDev | Technical feasibility review of new requirements | Via ProjectManager delegation, after PO approval |

### Checkpoint Pause Protocol

```
CHECKPOINT: BusinessAnalyst has completed requirements update.
ProductOwner MUST review before cascade review proceeds.

Review questions:
1. Does the requirements update capture all stakeholder intent from the VoC record?
2. Is there any unintended scope expansion?
3. Are all guardrail references correctly reflected?

Decision options:
→ "Approve — proceed to cascade" (triggers requirements-cascade skill)
→ "Revise — request BA changes with: [specific feedback]"
→ "Defer — hold cascade pending [condition]"
```

### Reverse Handoff: BusinessAnalyst → ProductOwner

**Condition:** BA completes requirements update.

**Handoff button YAML (to be added to BusinessAnalyst template):**
```yaml
- label: Return to ProductOwner
  agent: ProductOwner
  prompt: >
    Requirements updated based on VoC input. Review for stakeholder alignment and scope integrity
    before triggering cascade review. Flag any detected scope risks.
  send: true
```

**Expected PO action after receiving reverse handoff:**
1. Review requirements changes against original VoC record for accuracy.
2. Confirm no unintended scope expansion occurred.
3. Verify requirements traceability back to original stakeholder VoC.
4. If approved: trigger `requirements-cascade` skill.
5. If not approved: return to BA with specific revision feedback.

**Disallowed:** BA must NOT trigger cascade review; cascade is always PO-initiated.

---

## Handoff Contract 2: ProductOwner → ScrumMaster (CP-4.2 Evidence)

### Summary

| Field | Value |
| --- | --- |
| **Direction** | ProductOwner → ScrumMaster |
| **Trigger Phrase** | "Plan sprint based on" or "Create sprint plan from" |
| **Upstream Caller** | ProductOwner (after `backlog-management` skill produces groomed/prioritized backlog) |
| **Checkpoint Pause Required** | **YES** — ProductOwner review required after SM completes sprint plan |
| **Handoff Button Label** | `Plan Sprint` |
| **Reverse Handoff Label** | `Return to ProductOwner` |

### Input Expected by ScrumMaster

ProductOwner must supply all of the following before the handoff is valid:

| Input Component | Format | Required |
| --- | --- | --- |
| Groomed backlog | `docs/ways-of-work/backlog.md` with all items categorized | **Required** |
| MoSCoW labels | Each item labeled Must/Should/Could/Won't | **Required** |
| Phase alignment | Each item assigned to Phase 1/2/3/4 | **Required** |
| Rough effort opinion | Initial sizing (S/M/L or story point range) per item | **Required** — rough only; SM finalizes |
| Dependency list | Known dependencies between backlog items | **Required** if dependencies exist |
| Stakeholder value rating | Priority rationale per item (why it matters) | **Required** |
| Technical value rating | Engineering value per item (debt reduction, enablement) | Optional |
| Sprint capacity constraints | Available team capacity for the sprint | Required if provided by team |

**Input validation gate:** ScrumMaster MUST NOT begin sprint breakdown if MoSCoW labels are missing from more than 20% of Must-Have items, or if phase alignment is absent. SM must return to ProductOwner with a specific grooming request before proceeding.

### Output Produced by ScrumMaster

| Output Component | Location | Required Metadata |
| --- | --- | --- |
| Sprint plan | `docs/ways-of-work/sprint_NN.md` | `sprint_number`, `planned_start`, `planned_end`, `capacity`, `total_story_points` |
| Breakdown tasks per backlog item | Embedded in sprint plan | `parent_backlog_item`, `effort_points`, `assigned_to`, `acceptance_criteria` |
| Dependency map | Embedded in sprint plan under `## Dependencies` | `blocks`, `blocked_by` |
| QA test scope mapping | `## QA Scope` section in sprint plan | `test_type`, `coverage_target`, `qa_owner` |
| Capacity flag (if overloaded) | Comment in sprint plan + flag to ProductOwner | `capacity_risk: true`, `overloaded_items`, `deferral_candidates` |

### Downstream Consumers

| Consumer | What They Receive | When |
| --- | --- | --- |
| ProductOwner | Sprint plan review + capacity flags | After SM completes; PO must review before execution begins |
| ProjectManager | Execution tracking input | After PO approves sprint plan |
| FrontendDev / BackendDev | Technical scope review for sprint items | Via ProjectManager delegation |
| QAEngineer | Test plan generation input from QA scope mapping | Via ProjectManager after sprint approval |

### Checkpoint Pause Protocol

```
CHECKPOINT: ScrumMaster has completed sprint plan.
ProductOwner MUST review before sprint execution begins.

Review questions:
1. Does the sprint plan correctly interpret the groomed backlog priority order?
2. Are phase roadmap constraints honored (no Phase 3 items in a Phase 2 sprint)?
3. Is the capacity estimate realistic given team availability?
4. Are all Must-Have items included if capacity permits?

Decision options:
→ "Approve — begin sprint execution" (ProjectManager proceeds to execution tracking)
→ "Re-plan — adjust for: [specific constraint clarification]"
→ "Defer sprint — condition: [blocking dependency or approval needed]"
```

### Reverse Handoff: ScrumMaster → ProductOwner

**Condition:** SM completes sprint plan.

**Handoff button YAML (to be added to ScrumMaster template):**
```yaml
- label: Return to ProductOwner
  agent: ProductOwner
  prompt: >
    Sprint plan complete. Backlog items mapped to tasks and effort. PO review required for
    backlog interpretation accuracy, phase alignment, and capacity realism before execution begins.
  send: true
```

**Expected PO action after receiving reverse handoff:**
1. Review sprint plan for backlog interpretation accuracy.
2. Confirm phase roadmap constraints are honored.
3. Confirm capacity estimate is realistic.
4. Confirm all Must-Have items are included or explicitly deferred with rationale.
5. If approved: notify ProjectManager to begin execution tracking.
6. If not approved: return to SM with specific re-planning request.

**Disallowed:** SM must NOT adjust backlog priorities; PO owns backlog curation authority.

---

## Handoff Contract 3: ProductOwner → Worker (CP-4.2 Evidence)

### Summary

| Field | Value |
| --- | --- |
| **Direction** | ProductOwner → Worker |
| **Trigger Phrase** | "Convert these resources" or "Process binary resources" |
| **Upstream Caller** | ProductOwner (via `resource-ingestion` skill, when binary resources are detected) |
| **Checkpoint Pause Required** | **YES** — ProductOwner review required after Worker completes conversion |
| **Handoff Button Label** | `Convert Resources` |
| **Reverse Handoff Label** | `Classify and Route` |

### Pre-Handoff Resource Type Check (PO responsibility)

Before invoking Worker, ProductOwner MUST perform a local type check:

| Check | Action |
| --- | --- |
| File has `.md`, `.txt`, `.csv` extension, or is a URL | PO processes directly — DO NOT invoke Worker |
| File has `.docx`, `.eml`, `.msg`, or other binary extension | Invoke Worker for conversion |
| File type is uncertain | Check file header/magic bytes or ask user for clarification; do not guess |
| File is already in `learning_base/_inbox/` as markdown | PO proceeds to classification — Worker already ran |

**This pre-check prevents unnecessary Worker invocations for already-text resources.**

### Input Expected by Worker

| Input Component | Format | Required |
| --- | --- | --- |
| File paths to convert | List of absolute or repo-relative paths | **Required** |
| Intended classification | Context for each file (e.g., "meeting notes", "stakeholder email", "vendor document") | **Required** |
| Output destination | `learning_base/_inbox/` (default) or override path | Optional — default is `_inbox/` |
| Conversion quality threshold | "best effort" (default) or "strict" (fail if garbled) | Optional — default is "best effort" |

### Output Produced by Worker

| Output Component | Location | Required Metadata |
| --- | --- | --- |
| Converted markdown files | `learning_base/_inbox/` | `source_file`, `source_type`, `ingested_date`, `classification` (from PO intent), `tags`, `conversion_tool` |
| Conversion summary | Inline in Worker return message | `files_converted`, `files_failed`, `notes_on_quality` |
| Failure report (if applicable) | Inline in Worker return message | `failed_file`, `failure_reason`, `recommended_action` |

**Conversion quality standard:** Worker must include a `## Conversion Notes` section in each output file noting if any content was truncated, garbled, or required special handling. PO uses this section to assess quality during checkpoint review.

### Downstream Consumers

| Consumer | What They Receive | When |
| --- | --- | --- |
| ProductOwner | Converted markdown files in `_inbox/` + conversion summary | After Worker completes; PO must review quality before classifying |
| learning_base/ (via PO classification) | Final classified resource in appropriate category folder | After PO approves quality and routes |

### Checkpoint Pause Protocol

```
CHECKPOINT: Worker has completed binary resource conversion.
ProductOwner MUST review before classification and routing proceeds.

Review questions:
1. Is the converted markdown readable and complete (no garbled content)?
2. Does the conversion include the full source content or was content lost?
3. Are metadata headers correctly populated (source_file, source_type, ingested_date)?
4. Is the content suitable for the intended classification (stated when delegating to Worker)?

Decision options:
→ "Accept — proceed to classify and route" (PO applies template and routes to learning_base category)
→ "Re-convert — Worker retry with: [clarification on failed section or format]"
→ "Escalate — conversion unrecoverable, escalate to ProjectManager for stakeholder decision"
```

### Reverse Handoff: Worker → ProductOwner

**Condition:** Binary resource conversion completes.

**Handoff button YAML (to be added to Worker template for PM-system context):**
```yaml
- label: Classify and Route
  agent: ProductOwner
  prompt: >
    Resources converted to markdown in learning_base/_inbox/. PO must review conversion quality
    and route to appropriate learning_base category with template applied.
  send: true
```

**Expected PO action after receiving reverse handoff:**
1. Review converted markdown output for quality, formatting, and completeness.
2. Check `## Conversion Notes` section for any quality warnings.
3. If acceptable: apply resource-ingestion skill to classify into correct `learning_base/` folder.
4. If unacceptable: return to Worker with specific re-conversion request, or escalate to PM if unrecoverable.

**Disallowed:** Worker must NOT classify or route resources; PO owns the strategy for where resources live.

---

## Reverse Handoff Summary

| Source Agent | Target Agent | Handoff Label | Trigger Condition | PO Pause Required |
| --- | --- | --- | --- | --- |
| BusinessAnalyst | ProductOwner | `Return to ProductOwner` | Requirements update complete | **YES** — review for scope integrity before cascade |
| ScrumMaster | ProductOwner | `Return to ProductOwner` | Sprint plan complete | **YES** — review for backlog accuracy and phase alignment before execution |
| Worker | ProductOwner | `Classify and Route` | Binary resource conversion complete | **YES** — review conversion quality before classifying |

---

## Ambiguity Resolution Registry (REQ-408 Evidence)

### Situation 1: "Should ProductOwner or BusinessAnalyst write requirements documents?"

**Answer:**
- **BA writes:** detailed requirements specifications — criteria, acceptance conditions, design rationale, architecture alignment. BA owns the formal requirements document in `learning_base/02_requirements/`.
- **PO writes:** backlog items (user value, priority, estimated effort), VoC records (verbatim quotes, pain points, guardrail mappings), and backlog change rationale. PO owns stakeholder intent capture.
- **Coordination rule:** PO creates VoC → PO delegates requirements update to BA via `Update Requirements` handoff → BA updates requirements → BA returns to PO with `Return to ProductOwner` → PO reviews for stakeholder alignment → PO triggers cascade if scope confirmed.
- **No double-writing:** PO does not write to `learning_base/02_requirements/`; BA does not write backlog items or VoC records.

### Situation 2: "Should ProductOwner or ScrumMaster assign story points and dependencies?"

**Answer:**
- **PO owns:** strategic priority (MoSCoW), phase alignment, rough effort opinion (S/M/L), stakeholder value rationale.
- **SM owns:** final story point assignment (after detailed design review), dependency sequencing, task breakdown, acceptance criteria per task.
- **Coordination rule:** PO grooms backlog with rough sizing → PO delegates to SM with `Plan Sprint` handoff → SM breaks down to task level with final effort → SM returns to PO with `Return to ProductOwner` → PO reviews for backlog accuracy → PO approves before execution begins.
- **Conflict resolution:** If SM breakdown reveals significantly higher effort than PO estimated, SM flags the discrepancy in reverse handoff message; PO decides whether to defer item, split it, or accept the estimate and re-groom the backlog.

### Situation 3: "Should ProductOwner or Worker convert `.docx` files?"

**Answer:**
- **Worker converts:** binary/proprietary formats (`.docx`, `.eml`, `.msg`) — requires Bash/pandoc/email parsers. Worker owns the format mechanics.
- **PO classifies:** already-text/markdown resources AND Worker-converted output after checkpoint review. PO owns the strategy (where does this resource live, what category does it belong to, which template applies).
- **Decision boundary:** PO detects resource type via file extension or MIME type. If binary → PO invokes Worker with `Convert Resources` handoff. If already text → PO processes directly without Worker. If uncertain → PO asks user for clarification before deciding.
- **Ambiguous conversion output:** If Worker returns garbled or truncated content, PO reviews conversion notes, may request re-conversion with clarification, or escalates to ProjectManager if unrecoverable.

### Situation 4: "When does cascade review happen — after VoC creation, after requirements update, or both?"

**Answer:**
- **After VoC creation:** PO-triggered, using `requirements-cascade` skill to find which requirements and docs are impacted by the new stakeholder insight. This is the primary cascade trigger.
- **After requirements update:** If BA's requirements update introduces *new* requirements (not just refining existing ones), BA flags this in reverse handoff; PO decides whether secondary cascade check is needed.
- **After backlog changes:** If PO makes a strategic priority shift that affects the roadmap (e.g., a Phase 1 item moved to Phase 3), PO triggers cascade to check which downstream plans and docs need adjustment.
- **Rule:** Cascade is always PO-triggered. BA does not initiate cascade; BA only flags "cascade may be needed" in reverse handoff. PO makes the final call on whether and when to run cascade.

---

## Forward Handoff Matrix Summary

| From | To | Trigger | Input Format | Output Format | Checkpoint Pause |
| --- | --- | --- | --- | --- | --- |
| ProductOwner | BusinessAnalyst | "Update requirements based on" | VoC record (`.md`) with guardrail mapping | Requirements doc update in `02_requirements/` | YES — PO reviews BA output |
| ProductOwner | ScrumMaster | "Plan sprint based on" | Groomed backlog (`.md`) with MoSCoW and phase alignment | Sprint plan in `docs/ways-of-work/sprint_NN.md` | YES — PO reviews SM output |
| ProductOwner | Worker | "Convert these resources" | File path list + intended classification | Markdown files in `learning_base/_inbox/` | YES — PO reviews conversion quality |
| BusinessAnalyst | ProductOwner | Requirements updated | Requirements change summary | PO review of scope integrity | YES — human approval before cascade |
| ScrumMaster | ProductOwner | Sprint plan ready | Sprint plan review | PO approval or re-plan request | YES — human approval before execution |
| Worker | ProductOwner | Conversion complete | Converted markdown quality check | PO classification decision | YES — human approval before routing |
