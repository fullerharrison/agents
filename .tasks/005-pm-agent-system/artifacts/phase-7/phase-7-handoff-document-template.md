---
document: phase-7-handoff-document-template
version: 1.0
phase: 7
date_created: 2026-03-18
artifact: phase-7-handoff-document-template
task: 005-pm-agent-system
status: complete
sources:
  - agents-personal/docs/architecture/ADR-001-orchestration-and-subagents.md
  - agents-personal/docs/architecture/ADR-002-task-centric-persistence.md
  - .tasks/005-pm-agent-system/artifacts/phase-4/phase-4-handoff-contracts-matrix.md
  - .tasks/005-pm-agent-system/artifacts/phase-7/phase-7-workflow-contracts.md
---

# Phase 7 Artifact: Handoff Document Template

## Purpose

This document defines the canonical handoff document template (v1.0) for all agent-to-agent transitions in the 2026_01_VIP PM agent system. Every handoff between a sending agent and a receiving agent must use this template to ensure checkpoint traceability, decision-state clarity, and cross-session auditability.

The template is markdown-only and compatible with both Copilot chat context passing and CC context block conventions (no binary attachments; path references only) per REQ-705.

## Scope

This template applies to all agent-to-agent handoffs in the PM agent system, covering all six workflows (A–F). It is instantiated once per handoff event and saved as a file record in `.tasks/005-pm-agent-system/artifacts/` (or the relevant `.tasks/` run-log) per the ADR-002 task-centric persistence requirement and REQ-706.

## Relationship to ADR-001

ADR-001 defines the orchestration handoff button convention (`[Label →]`) and the Entry Gate checkpoint pattern. This template operationalises those conventions by providing the full document structure surrounding the handoff button, ensuring the receiving agent has complete context before proceeding past the checkpoint gate.

---

## Template (v1.0)

> **Instructions for use:** Copy the template below. Replace all `<!-- placeholder -->` stubs with actual values. Save the completed document as a file at the path indicated in Section 6 (Workflow Provenance) before the receiving agent proceeds. Delete these instructions from the completed instance.

---

```markdown
---
handoff_template_version: 1.0
workflow_id: <!-- placeholder: WFC-A | WFC-B | WFC-C | WFC-D | WFC-E | WFC-F -->
from_agent: <!-- placeholder: role name -->
to_agent: <!-- placeholder: role name -->
date: <!-- placeholder: YYYY-MM-DD -->
checkpoint_id: <!-- placeholder: CP-A1 | CP-B2 | ... -->
---

## Header

| Field | Value |
|-------|-------|
| Workflow ID | <!-- placeholder: WFC-A through WFC-F --> |
| From Agent | <!-- placeholder: e.g., ProductOwner --> |
| To Agent | <!-- placeholder: e.g., BusinessAnalyst --> |
| Trigger Phrase Used | <!-- placeholder: exact phrase that initiated this workflow instance --> |
| Date | <!-- placeholder: YYYY-MM-DD --> |
| Handoff Instance ID | <!-- placeholder: {workflow_id}-{YYYY-MM-DD}-{sequence} e.g., WFC-C-2026-03-18-001 --> |

---

## Context Summary

<!-- placeholder: One paragraph summarising what was processed in this workflow step, key decisions made, and any outstanding open questions that the receiving agent must be aware of before proceeding. Include any deviations from the standard workflow path. -->

---

## Artifact Manifest

| Artifact Name | File Path | Format | Status |
|---------------|-----------|--------|--------|
| <!-- placeholder: name --> | <!-- placeholder: relative path from repo root --> | <!-- placeholder: .md / .csv / .png / .json --> | <!-- placeholder: Ready / Needs Review / Blocked --> |
| <!-- placeholder: name --> | <!-- placeholder: path --> | <!-- placeholder: format --> | <!-- placeholder: status --> |

> Add one row per artifact produced or consumed in this handoff step. Status options: **Ready** (verified and complete), **Needs Review** (produced but not yet validated), **Blocked** (cannot proceed until dependency resolved).

---

## Checkpoint Gate Reference

| Field | Value |
|-------|-------|
| Checkpoint ID | <!-- placeholder: e.g., CP-A2 --> |
| Checkpoint Name | <!-- placeholder: e.g., Template Applied? --> |
| Current State | <!-- placeholder: Awaiting Decision / Passed / Rework Required --> |
| Decision Authority | <!-- placeholder: PM / Human Reviewer / Receiving Agent --> |
| Phase 5 Source | `phase-5-comprehensive-checkpoint-table.md` — row CP-{X}{N} |

> Reference the Phase 5 checkpoint ID governing this handoff. Do not redefine checkpoint logic — only indicate current state relative to the Phase 5 authority.

---

## Decision Gate

### Proceed

> Use when all artifacts are Ready and the checkpoint gate is Passed.

| Field | Value |
|-------|-------|
| Confirmed by | <!-- placeholder: role name --> |
| Confirmation date | <!-- placeholder: YYYY-MM-DD --> |
| Artefacts verified | <!-- placeholder: list artifact names confirmed as Ready --> |
| Next step | <!-- placeholder: next agent action or workflow continuation --> |

### Return

> Use when rework is required before the checkpoint can be passed.

| Field | Value |
|-------|-------|
| Returned by | <!-- placeholder: role name --> |
| Return date | <!-- placeholder: YYYY-MM-DD --> |
| Reason | <!-- placeholder: description of what is incorrect or incomplete --> |
| Rework scope | <!-- placeholder: specific items requiring rework --> |
| Estimated rework effort | <!-- placeholder: Low / Medium / High --> |
| Return target | <!-- placeholder: sending agent role --> |

### Escalate

> Use when a blocker cannot be resolved within the current agent set and requires PM or human intervention.

| Field | Value |
|-------|-------|
| Escalated by | <!-- placeholder: role name --> |
| Escalation date | <!-- placeholder: YYYY-MM-DD --> |
| Blocker description | <!-- placeholder: specific blocker preventing progression --> |
| Escalation target role | <!-- placeholder: ProjectManager / Human Reviewer --> |
| Urgency level | <!-- placeholder: Low / Medium / High / Blocking --> |
| Artefacts on hold | <!-- placeholder: list blocked artifacts --> |

---

## Workflow Provenance

> **Persistence requirement (REQ-706 / ADR-002):** When an agent completes a handoff step, this section must be populated and the completed handoff document saved as a file record in `.tasks/005-pm-agent-system/artifacts/{phase-or-run-log}/` (or the relevant `.tasks/` run-log path). Handoff provenance data must not exist solely in ephemeral conversation context. Each saved file ensures cross-session traceability and audit continuity.

| Field | Value |
|-------|-------|
| Originating Workflow ID | <!-- placeholder: WFC-A through WFC-F --> |
| Trigger Phrase Used | <!-- placeholder: exact phrase as entered by caller role --> |
| Date / Timestamp | <!-- placeholder: YYYY-MM-DD or YYYY-MM-DDTHH:MM --> |
| Caller Role | <!-- placeholder: role that triggered this workflow instance --> |
| Saved File Path | <!-- placeholder: .tasks/005-pm-agent-system/artifacts/{path}/handoff-{instance-id}.md --> |

---

## Receiving Agent Acknowledgement

> **Required before proceeding past the checkpoint gate.** The receiving agent must confirm receipt of this handoff document and all listed artifacts before taking any action.

| Field | Value |
|-------|-------|
| Received by | <!-- placeholder: receiving agent role --> |
| Receipt date | <!-- placeholder: YYYY-MM-DD --> |
| Artifacts confirmed | <!-- placeholder: confirm all Artifact Manifest entries are accessible --> |
| Checkpoint gate status | <!-- placeholder: Proceeding / Returning / Escalating --> |
| Acknowledgement note | <!-- placeholder: any clarification or immediate concern before proceeding --> |
```

---

## Usage Notes

### When to Use Each Decision Gate Option

| Situation | Decision Gate Option |
|-----------|----------------------|
| All artifacts are verified Ready and checkpoint is Passed | **Proceed** |
| One or more artifacts have issues; checkpoint not yet passed | **Return** |
| Blocker cannot be resolved by current agents; requires PM or human intervention | **Escalate** |
| Checkpoint state is Rework Required after previous Return | Re-issue as new handoff instance with updated Artifact Manifest and Return reasons addressed |

### How to Populate the Artifact Manifest

1. List every artifact produced by the sending agent during this workflow step.
2. List every input artifact the receiving agent will need to do their work.
3. Set Status to **Ready** only when the artifact has been verified as complete and at the stated file path.
4. Use **Needs Review** for artifacts that are produced but await validation before the checkpoint can be Passed.
5. Use **Blocked** when a dependency prevents the artifact from being produced; escalation is likely required.

### Integration with `.tasks/` Phase Status Updates

When this handoff document results in a new planning task or a phase status change:
- Reference the relevant `.tasks/{task-slug}/task.md` entry.
- Use only the canonical status markers: ⬜ Not Started → 📋 Planned → ⭐ Reviewed → 🔄 In Progress → ✅ Done.
- Update the `task.md` phase row only after the receiving agent's Acknowledgement is confirmed.
- Record the handoff file path in the relevant phase notes column of `task.md`.

### Compatibility Note

This template is markdown-only. It contains no embedded binary content, no inline images, and no format-specific constructs that would prevent passing via Copilot chat context or CC context blocks. All file references are path-only strings, not embedded objects. This satisfies REQ-705.
