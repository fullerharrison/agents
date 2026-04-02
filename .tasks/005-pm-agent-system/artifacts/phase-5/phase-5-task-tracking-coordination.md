---
artifact: phase-5-task-tracking-coordination
phase: 5
created: 2026-03-18
status: reviewed
tags: [task-tracking, planning, checkpoint-integration, artifact-handoff, coordination]
---

# Phase 5 Artifact: Task-Tracking Coordination

## Artifact Handoff Format

Checkpoint approval decisions are persisted as structured artifacts in one of the following formats, depending on the planning tool in use for 2026_01_VIP:

### Format A: JSON Checkpoint Record (Default)

```json
{
  "checkpoint_id": "CP-A1",
  "workflow": "A",
  "workflow_name": "Resource Ingestion",
  "passed": true,
  "decision": "Proceed",
  "timestamp": "2026-03-18T14:30Z",
  "approver": "ProductOwner",
  "next_step": "apply_template",
  "artifact_path": "learning_base/05_technical_specs/vip_protocol_example.md",
  "notes": "Resource classified as technical-protocol; target path confirmed."
}
```

### Format B: Markdown Metadata Header (YAML Frontmatter)

```yaml
---
checkpoint_id: CP-E3
workflow: E
workflow_name: Backlog Planning
passed: true
decision: Approve
timestamp: 2026-03-18T15:00Z
approver: Human Reviewer
next_step: capacity_check
artifact_path: docs/ways-of-work/sprint_03.md
notes: Sprint plan approved; task IDs traceable to backlog items.
---
```

### Format C: Planning Tool Native Format

If the project uses JIRA, Azure DevOps, or Microsoft Planner:

| Field | Value |
| --- | --- |
| Item type | Checkpoint Approval |
| Checkpoint ID | CP-F3 |
| Status | Pass / Fail |
| Assignee | QAEngineer |
| Sprint | Sprint 03 |
| Comment | All tests pass; blocker classification: none |
| Linked items | Sprint item ID(s) affected |

### Format Selection Rule

Use Format A (JSON) by default for all `workflow-logs/` entries. Use Format B (markdown frontmatter) when the checkpoint result is embedded directly in a learning_base or docs artifact. Use Format C only when a planning tool with native workflow fields is active in 2026_01_VIP.

---

## Planning Integration Mapping

| Workflow | Completion Event | Planning Artifact Created or Updated | Location | Status Update |
| --- | --- | --- | --- | --- |
| A | Resource ingested | learning_base index updated; workflow log created | `learning_base/[subdir]/[name].md` + `.tasks/005-pm-agent-system/workflow-logs/A_[timestamp]_ingestion_[name].json` | Backlog item "Resource Received" (if tracked) → "Ingested" |
| B | VoC record filed | VoC record created; backlog items tagged "awaiting-refinement" | `learning_base/11_voice_of_customer/voc_[id]_[stakeholder].md` + `.tasks/workflow-logs/B_[timestamp]_voc.json` | Backlog items tagged "requirements-draft" or "VoC-received" |
| C | Cascade complete | Requirements updated; dependent docs linked; cascade log | Updated `learning_base/02_requirements/` docs + `.tasks/workflow-logs/C_[timestamp]_cascade_[req-id].md` | Dependent backlog items status → "cascade-complete"; previously "cascade-impact-review" |
| D | Diagram published | Diagram in `images/diagrams/`; manifest updated; doc link added | `images/diagrams/[name].png` (or .svg) + `learning_base/03_architecture/diagrams/[name].mmd` + `.tasks/workflow-logs/D_[timestamp]_diagram.json` | Documentation status "diagram-published" |
| E | Sprint plan created | Sprint plan published; backlog items assigned to sprint | `docs/ways-of-work/sprint_NN.md` + `.tasks/workflow-logs/E_[timestamp]_sprint.json` | Backlog items status → "Sprint-Ready"; sprint status → "Active" |
| F (Pass) | Tests pass | Test results published; sprint item marked Done | `learning_base/07_testing/test_results_[sprint].md` + `.tasks/workflow-logs/F_[timestamp]_qagate.json` | Sprint item status → "Done" |
| F (Fail) | Tests fail | Test results published; rework item created | `learning_base/07_testing/test_results_[sprint].md` + new backlog item "Fix: [failure description]" | Sprint item status → "Blocked" or "In Rework"; new item "Fix bug" created |

---

## Checkpoint-to-Planning Trigger Rules

Explicit IF-THEN rules that govern how PM checkpoint decisions translate into planning artifact updates:

### Workflow A Triggers
- IF CP-A1 PASS THEN log `{ classification_tag, target_subdir }` to workflow log A.
- IF CP-A3 PASS THEN mark_learning_base_index_updated(); close Workflow A log with status "success".
- IF CP-A1 FAIL (ambiguous) THEN pause_workflow(); prompt_user_for_classification(); resume_on_confirmation().

### Workflow B Triggers
- IF CP-B1 PASS THEN create_voc_record(stakeholder, date, raw_feedback); status "VoC-captured".
- IF CP-B2 PASS THEN update_voc_record_with_guardrail_mapping(); status "guardrail-mapped".
- IF CP-B3 PASS + cascade_needed THEN trigger_workflow_C(requirement_ids=[...]).
- IF CP-B3 PASS + no_cascade THEN file_voc_record(); tag_backlog_items(status="awaiting-refinement").

### Workflow C Triggers
- IF CP-C1 PASS THEN tag_affected_backlog_items(status="cascade-impact-review"); log dependency list.
- IF CP-C2 PASS (human approved) THEN mark_planning_task(status="requirements-updated", approver, timestamp); log approval.
- IF CP-C3 PASS THEN update_affected_items(status="cascade-complete"); log secondary check result.
- IF CP-C4 APPROVED THEN close_cascade_workflow(); log stakeholder approval; notify PM of Workflow C success.
- IF CP-C4 REWORK THEN return_to_BA_for_revision(); log rework request with feedback.

### Workflow D Triggers
- IF CP-D2 PASS THEN log_source_file_path(path, format) to workflow log D.
- IF CP-D3 PASS THEN log_rendered_image_path(path) to workflow log D.
- IF CP-D4 PASS THEN update_diagram_manifest(); close Workflow D log with status "success"; update_doc_link.
- IF CP-D3 FAIL (render error) THEN log_render_error(); route_to_UIUX_for_correction().
- IF CP-D3 FAIL (unsupported format) THEN escalate_to_PM(); PM prompts UIUX for format change.

### Workflow E Triggers
- IF CP-E1 PASS THEN apply_moscow_tags_to_backlog(); log prioritization complete.
- IF CP-E2 PASS THEN apply_phase_tags_to_backlog(); status "Sprint-Candidate" for current-phase Must/Should items.
- IF CP-E3 PASS (human approved) THEN publish_sprint_plan(docs/ways-of-work/sprint_NN.md); update_planning_tool(sprint_id=NN, items=[...]).
- IF CP-E3 REQUEST CHANGES THEN SM_revises_sprint_plan(); resubmit_for_review().
- IF CP-E4 PASS THEN confirm_sprint_ready(); backlog_items_status → "Sprint-Ready".
- IF CP-E4 FAIL (over capacity) THEN PO_re_prioritizes(); deferred_items_status → "deferred".

### Workflow F Triggers
- IF CP-F1 PASS THEN log_test_execution_complete(suite, timestamp, env).
- IF CP-F3 PASS THEN mark_sprint_item_done(item_id); publish_test_results().
- IF CP-F3 FAIL + NOT blocker THEN create_rework_task("Fix: [failure description]", assignee=developer, priority=normal).
- IF CP-F3 FAIL + IS blocker THEN escalate_to_PM(); PM_offers_decision(Fix|Skip|Defer).
  - Fix → trigger Workflow C for requirement revision.
  - Skip → PO removes item from sprint; create backlog item for future sprint.
  - Defer → PM escalates to human for phase-level decision.
- IF CP-F4 PASS THEN sprint_item_status → "Done"; log_acceptance_verification(approver, timestamp).
- IF CP-F4 FAIL THEN trigger_workflow_C(reason="acceptance_criteria_conflict").

---

## Artifact Path Conventions

Canonical locations for all PM orchestration output and workflow log artifacts:

| Workflow | Artifact Type | Canonical Path |
| --- | --- | --- |
| A — Resource Ingestion | Resource file | `learning_base/[subdir]/[resource-name].md` |
| A — Workflow log | JSON checkpoint log | `.tasks/005-pm-agent-system/workflow-logs/A_[YYYYMMDD-HHmmZ]_ingestion_[resource-name].json` |
| B — Stakeholder Feedback | VoC record | `learning_base/11_voice_of_customer/voc_[id]_[stakeholder].md` |
| B — Workflow log | JSON checkpoint log | `.tasks/005-pm-agent-system/workflow-logs/B_[YYYYMMDD-HHmmZ]_voc_[stakeholder].json` |
| C — Requirements Cascade | Updated requirement docs | `learning_base/02_requirements/[doc-name].md` |
| C — Cascade log | Markdown cascade record | `.tasks/005-pm-agent-system/workflow-logs/C_[YYYYMMDD-HHmmZ]_cascade_[req-id].md` |
| D — Diagram source | Mermaid or draw.io source | `images/diagrams/[diagram-name].[mmd|drawio]` or `learning_base/03_architecture/diagrams/[name].[mmd|drawio]` |
| D — Diagram render | PNG or SVG image | `images/diagrams/[diagram-name].[png|svg]` |
| D — Workflow log | JSON checkpoint log | `.tasks/005-pm-agent-system/workflow-logs/D_[YYYYMMDD-HHmmZ]_diagram_[name].json` |
| E — Sprint plan | Sprint plan document | `docs/ways-of-work/sprint_[NN].md` |
| E — Workflow log | JSON checkpoint log | `.tasks/005-pm-agent-system/workflow-logs/E_[YYYYMMDD-HHmmZ]_sprint_[NN].json` |
| F — Test results | QA test results document | `learning_base/07_testing/test_results_sprint_[NN].md` |
| F — Workflow log | JSON checkpoint log | `.tasks/005-pm-agent-system/workflow-logs/F_[YYYYMMDD-HHmmZ]_qagate_sprint_[NN].json` |

### Naming Convention Rules

- Timestamps: ISO 8601 compact format: `YYYYMMDD-HHmmZ` (UTC).
- Workflow logs use the pattern: `[Workflow-Letter]_[timestamp]_[descriptor].[ext]`.
- Sprint numbers: two-digit zero-padded: `sprint_03`, `sprint_10`.
- Requirement IDs: `REQ-[NNN]` format inherited from learning_base requirement docs.
- Stakeholder identifiers: use lowercase-hyphenated name or role (e.g., `product-manager`, `john-doe`).

---

## Integration Validation Rules

How to verify the PM orchestration → planning → artifact chain is intact:

1. **Checkpoint-to-planning traceability**: Every checkpoint log entry (`checkpoint_id`, `workflow`, `timestamp`) must be traceable to a specific planning artifact or status update. Orphaned log entries without a matching planning artifact are a validation failure.

2. **Artifact path compliance**: Every workflow log and output artifact must be at the canonical path for its workflow type (see Artifact Path Conventions above). Files at non-canonical paths are a validation failure.

3. **Metadata provenance**: Every output artifact's YAML frontmatter must reference the originating `checkpoint_id` and `workflow`. Artifacts without provenance metadata cannot be traced in audits.

4. **Timestamp ordering**: Checkpoint approval timestamp must be ≤ artifact creation timestamp. A checkpoint timestamp that is later than the artifact creation timestamp indicates a retroactive approval, which is a validation failure.

5. **Planning status consistency**: Planning tool status for a sprint item must match the most recent PM checkpoint decision:
   - CP-F3 PASS → item status must be "Done" or transitioning to "Done".
   - CP-F3 FAIL → item status must be "Blocked" or "In Rework" with a linked rework task.
   - CP-E4 FAIL → deferred items must have "deferred" tag and be removed from current sprint.
   Items with inconsistent status (e.g., marked "Done" but CP-F3 shows FAIL) are a validation failure.

6. **Sprint plan traceability**: Sprint plan document at `docs/ways-of-work/sprint_NN.md` must include task IDs that are traceable back to backlog item IDs. Missing traceability links are a validation failure.

---

## Compatibility with Existing Planning Tools

### Markdown Backlog (2026_01_VIP Default)

PM orchestration integrates with markdown-based backlog tracking as follows:

- Checkpoint decisions create status markers in backlog items (tags, status fields, or comment lines).
- Workflow log JSON files provide the authoritative audit trail; markdown backlog provides human-readable status.
- Sprint plans are published as standalone markdown documents in `docs/ways-of-work/`.
- Backlog item IDs use the format `ITEM-[NNN]` for traceability across sprint and backlog documents.

### JIRA / Azure DevOps (If Active)

- Checkpoint approvals trigger issue status transitions:
  - CP-C2 approval → requirement issue: "In Review" → "Approved"
  - CP-E3 approval → sprint planning issue: "Planning" → "Sprint-Ready"
  - CP-F3 PASS → sprint item: "QA" → "Done"
  - CP-F3 FAIL → sprint item: "QA" → "Blocked"; new issue "Fix: [description]" created
- Checkpoint log JSON files must be attached to the related JIRA/ADO issue for traceability.
- PM orchestration does not directly integrate with JIRA/ADO API; a human or Worker agent performs status updates based on PM checkpoint decisions.

### Microsoft Planner / Task Tracking

- Checkpoint decisions map to Planner bucket transitions and label updates.
- Workflow A completion → task in "Ingested Resources" bucket.
- Workflow E approval → sprint tasks in "Sprint Active" bucket with phase labels.
- Workflow F pass → task moved to "Done" bucket with QA verification date.
