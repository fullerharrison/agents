---
artifact: phase-5-comprehensive-checkpoint-table
phase: 5
created: 2026-03-18
status: reviewed
tags: [checkpoints, decision-gates, pause-conditions, workflow-control, escalation]
---

# Phase 5 Artifact: Comprehensive Checkpoint Table

## Master Checkpoint Table

| CP ID | Workflow | Description | Condition to Pass | Owner | Pause Required? | Pause Owner | Decision Options | Impact if Proceed | Impact if Rework | Impact if Escalate | Tie-Breaker Rule |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| CP-A1 | A | Resource classified? | Resource has classification tag + target subdir confirmed | ProductOwner | N (auto) | PM (if ambiguous) | Proceed, Rework, Escalate | Apply metadata template (CP-A2) | PO re-classifies; PM prompts user if second attempt fails | PM pauses; user selects category | If two categories equally valid, prompt user; do not auto-assign |
| CP-A2 | A | Template applied? | Markdown file has YAML frontmatter with title, date, source, tags | ProductOwner | N (auto) | — | Proceed, Rework | Validate path (CP-A3) | PO reworks metadata header | — | Required fields: title, date, source, tags — all must be non-empty |
| CP-A3 | A | learning_base path valid? | Target `learning_base/[subdir]/` exists; file written at expected location | ProductOwner | N (auto) | PM (if path error) | Proceed, Rework, Escalate | Workflow A success; PM notifies user | PO corrects path; if subdir missing, Worker creates it | PM pauses; prompts user for correct target dir | Always use existing subdir; new subdirs require PM approval |
| CP-B1 | B | Feedback captured? | Structured feedback record created with stakeholder name, date, raw content | ProductOwner | N (auto) | PM (if incomplete) | Proceed, Rework | Guardrail mapping (CP-B2) | PO requests more detail from stakeholder | PM requests clarification from stakeholder | Minimum required fields: stakeholder, date, raw feedback — all must be present |
| CP-B2 | B | Guardrail mapping complete? | All feedback items mapped to at least one guardrail or flagged as "no guardrail match" | ProductOwner | Y (if new guardrail) | Human reviewer | Proceed, Rework, Escalate | Extract insights (CP-B3) | PO re-maps with BA advisory | PM escalates to human if new guardrail category needed | If mapping ambiguous, BA consults; if conflict persists, PM pauses for human |
| CP-B3 | B | Actionable insights extracted? | Insight list has at least one item with action type (requirement, backlog item, risk, or note) | ProductOwner | N (auto) | — | Proceed, Cascade, Rework | VoC record filed; if cascade needed → Workflow C | PO reworks insight extraction | — | If zero insights extractable, file VoC as "informational only" and notify PM |
| CP-C1 | C | Impacted docs identified? | Dependency search complete; list of affected docs with change type (update/review/link-only) | BusinessAnalyst | N (auto) | — | Proceed, Rework | Update requirements (CP-C2) | BA expands dependency search scope | — | If dependency list is empty, BA must confirm intentional "no impact" before Proceeding |
| CP-C2 | C | Requirements updated? | All identified affected docs updated with change; traceability links added | BusinessAnalyst | Y (human review) | Human reviewer | Approve, Request Changes | Secondary impact check (CP-C3) | BA revises updates per reviewer feedback | PM escalates if requirement change has architectural implications | Reviewer must approve before cascade proceeds; no auto-proceed on this checkpoint |
| CP-C3 | C | Secondary impact check complete? | No additional undiscovered dependencies; FE/BE advisory complete if technical | BusinessAnalyst + advisors | N (auto) | — | Proceed, Rework, Escalate | Stakeholder approval check (CP-C4) or SUCCESS | BA re-checks dependencies | PM escalates for architecture or scope decision | Technical advisor disagreement → PM escalates to human |
| CP-C4 | C | Stakeholder approval required? | If approval required: stakeholder confirmed in writing | ProductOwner | Y (stakeholder approval) | Stakeholder + PM | Approved, Rework, Defer | Workflow C SUCCESS | BA revises based on feedback | PM escalates for phase-level scope decision | If stakeholder unreachable for 2 business days, PM escalates to human manager for decision |
| CP-D1 | D | Diagram design complete? | Diagram source (Mermaid syntax or draw.io JSON) is logically complete and matches feature spec | UIUXDesigner | N (auto) | — | Proceed, Rework | Save source file (CP-D2) | UIUX revises design | — | If feature spec is incomplete, UIUX must pause and request spec from PO before designing |
| CP-D2 | D | Source file saved? | `.mmd` or `.drawio` file exists at `images/diagrams/[name].[ext]` | UIUXDesigner | N (auto) | — | Proceed, Rework | Render image (CP-D3) | UIUX saves source file | — | Source file must exist before rendering; no render without source |
| CP-D3 | D | Rendered image generated? | `.png` or `.svg` file exists at `images/diagrams/[name].[ext]` with valid render | UIUXDesigner | N (auto) | PM (if render fails) | Proceed, Rework, Escalate | Link in docs (CP-D4) | UIUX corrects source and re-renders | PM escalates if format unsupported | If two renders exist, latest replaces older; manifest must be updated |
| CP-D4 | D | Linked in documentation? | Documentation file contains link to rendered image; link is valid | UIUXDesigner | N (auto) | — | Proceed, Rework | PM triggers manifest update; Workflow D SUCCESS | UIUX adds missing documentation link | — | Link must use relative path from docs root; absolute paths are invalid |
| CP-E1 | E | Backlog prioritized (MoSCoW)? | All in-scope backlog items have MoSCoW tag (Must/Should/Could/Won't) | ProductOwner | N (auto) | — | Proceed, Rework | Phase-align items (CP-E2) | PO re-prioritizes with stakeholder input | — | Untagged items block CP-E1; PO must tag all items before proceeding |
| CP-E2 | E | Items phase-aligned? | All Must/Should items assigned to a specific phase or sprint | ProductOwner | N (auto) | — | Proceed, Rework, Escalate (req clarification) | ScrumMaster breakdown (CP-E3) | PO aligns items; if undefined requirements → Workflow C | PM triggers Workflow C for requirement clarification | If phase assignment conflicts with existing commitments, SM escalates to PM |
| CP-E3 | E | Sprint plan created? | Sprint plan exists at `docs/ways-of-work/sprint_NN.md` with breakdown, estimates, dependencies | ScrumMaster | Y (human review) | Human reviewer | Approve, Request Changes | Capacity check (CP-E4) | SM revises sprint plan | PM escalates if sprint targets conflict with phase commitments | Sprint plan must include task IDs traceable to backlog items; missing IDs block approval |
| CP-E4 | E | Capacity check passed? | Total estimated effort ≤ team capacity for sprint period | ScrumMaster | N (auto) | PM (if over capacity) | Proceed, Re-prioritize, Defer | Workflow E SUCCESS; sprint published | PO re-prioritizes: defer Could/Should items or split story | PM escalates if phase targets are impacted by deferral | Capacity is measured in story points or days; unit must be consistent within sprint |
| CP-F1 | F | Test suite executed? | Test suite run completed (pass or fail); no execution errors | QAEngineer | N (auto) | PM (if env error) | Proceed, Retry, Escalate | Review results (CP-F2) | QA retries after environment fix | PM escalates if environment issue is systemic | Environment errors ≠ test failures; must be distinguished before escalation |
| CP-F2 | F | Test results reviewed? | QA has reviewed all test results; pass/fail classification assigned | QAEngineer | N (auto) | — | Proceed, Rework | Pass/fail decision (CP-F3) | QA completes result review | — | All tests must be reviewed; skipped tests count as "not reviewed" |
| CP-F3 | F | All tests pass? | All test assertions green; no failing tests in test suite | QAEngineer | Y (if fail with blocker) | PM + human | Pass → sprint Done, Fail → Rework or Escalate | Sprint item "Done" (CP-F4) or rework task created | QA creates rework task; routes to developer | PM offers Fix / Skip / Defer options | Blockers vs. non-blockers must be explicitly classified; unclassified failures default to "blocker" |
| CP-F4 | F | Acceptance criteria met? | All acceptance criteria for sprint item explicitly satisfied per definition-of-done | QAEngineer + ProductOwner | Y (human review) | Human reviewer | Approve (Done), Request Changes | Sprint item status "Done"; artifact published | QA/dev cycle for criteria not met; may trigger Workflow C | PM escalates for requirement revision (Workflow C trigger) | Acceptance criteria must be pre-defined before sprint start; retroactive criteria changes require PM approval |

---

## Checkpoint Detail Cards

### CP-A1 — Resource Classified
**Rationale**: Classification determines the correct learning_base subdirectory and metadata tags. Without classification, resources are unfiled and unsearchable.
**Failure scenarios**: Resource type is ambiguous (e.g., PDF mixing protocol and stakeholder notes); no matching category exists.
**Escalation criteria**: Second classification attempt fails; user input required.
**Task-tracking integration**: Successful classification logged in workflow log `A_[timestamp]_ingestion_[name].json`.

### CP-A2 — Template Applied
**Rationale**: Metadata template ensures every resource has consistent frontmatter for search, retrieval, and traceability.
**Failure scenarios**: Required metadata field missing (title, date, source, or tags).
**Escalation criteria**: Template cannot be auto-populated (e.g., source URL unknown); PM prompts user.
**Task-tracking integration**: Template success creates workflow log entry; no planning artifact update.

### CP-A3 — Path Valid
**Rationale**: Confirms the resource was persisted at the correct location; prevents orphaned files.
**Failure scenarios**: Target subdirectory does not exist; file write failed.
**Escalation criteria**: Path creation required (new subdirectory); PM approval needed before Worker creates subdir.
**Task-tracking integration**: Path validation result stored in workflow log; success triggers "ingestion complete" status.

### CP-B1 — Feedback Captured
**Rationale**: Ensures raw stakeholder input is preserved in structured form before processing.
**Failure scenarios**: Stakeholder input is too brief or vague to extract structured feedback.
**Escalation criteria**: Stakeholder unreachable for follow-up; PM prompts user for fallback action.
**Task-tracking integration**: Feedback record creation triggers backlog item "VoC received" status.

### CP-B2 — Guardrail Mapping Complete
**Rationale**: Guardrail mapping prevents out-of-scope requirements from entering the backlog unchecked.
**Failure scenarios**: Feedback item references a requirement area not covered by existing guardrails; new guardrail needed.
**Escalation criteria**: New guardrail category needed; requires human reviewer approval before adoption.
**Task-tracking integration**: Guardrail mapping complete triggers "VoC mapped" status on backlog item.

### CP-B3 — Insights Extracted
**Rationale**: Ensures VoC translates into concrete actions (requirements, backlog items, risks) rather than passive notes.
**Failure scenarios**: Feedback is purely informational with no actionable content.
**Escalation criteria**: None standard; "informational only" VoC records are valid outcomes.
**Task-tracking integration**: Insight extraction triggers backlog items or risk log entries as applicable.

### CP-C1 — Impacted Docs Identified
**Rationale**: Cascade review must begin with a complete dependency map to prevent orphaned requirement changes.
**Failure scenarios**: Dependency tool search misses cross-module references; manual review required.
**Escalation criteria**: Dependency discovery is inconclusive; BA must signal PM for human verification.
**Task-tracking integration**: Dependency list creation triggers "cascade-impact-review" tag on affected backlog items.

### CP-C2 — Requirements Updated
**Rationale**: Human reviewer checkpoint ensures that requirement changes are correct and complete before cascading.
**Failure scenarios**: Requirements change contradicts architecture; requirement is ambiguous.
**Escalation criteria**: Reviewer requests changes three times; PM escalates to architectural review.
**Task-tracking integration**: Approval updates backlog item status "requirements-updated"; approval timestamp recorded.

### CP-C3 — Secondary Impact Check
**Rationale**: Ensures the initial cascade update did not create new downstream dependencies.
**Failure scenarios**: Updated requirement creates new dependency on an unreviewed component.
**Escalation criteria**: Technical advisor identifies architecture conflict; PM must decide on scope.
**Task-tracking integration**: Secondary check completion updates "cascade-review-pending" items to "cascade-complete".

### CP-C4 — Stakeholder Approval
**Rationale**: Requirement changes affecting stakeholder commitments or VoC items require explicit stakeholder sign-off.
**Failure scenarios**: Stakeholder unavailable; stakeholder rejects requirement change.
**Escalation criteria**: Stakeholder rejection triggers scope renegotiation; PM escalates if phase impacted.
**Task-tracking integration**: Approval event logged with stakeholder identity and timestamp; drives "requirements-approved" status.

### CP-D1 — Diagram Design Complete
**Rationale**: Ensures diagram is logically sound before file creation or rendering resources are committed.
**Failure scenarios**: Feature spec is incomplete; diagram contradicts existing architecture.
**Escalation criteria**: Design cannot proceed without updated feature spec; PM re-routes to PO.
**Task-tracking integration**: Design completion triggers "diagram-in-progress" status.

### CP-D2 — Source File Saved
**Rationale**: Source file preservation is mandatory for version control and future diagram updates.
**Failure scenarios**: File system error; wrong directory.
**Escalation criteria**: Write fails; PM checks permissions and routes to Worker for retry.
**Task-tracking integration**: Source file path recorded in workflow log.

### CP-D3 — Rendered Image Generated
**Rationale**: Confirms the diagram source is valid and renderable in the target format.
**Failure scenarios**: Mermaid syntax error; unsupported draw.io export format.
**Escalation criteria**: Unsupported format → PM escalates to UIUXDesigner for format change.
**Task-tracking integration**: Render success triggers "diagram-rendered" status in workflow log.

### CP-D4 — Linked in Documentation
**Rationale**: Ensures diagram is discoverable and cross-referenced in the correct documentation sections.
**Failure scenarios**: Documentation file not found; incorrect path reference.
**Escalation criteria**: Documentation location ambiguous; PM prompts PO for correct doc target.
**Task-tracking integration**: Link validation completes "diagram-published" workflow log entry; manifest updated.

### CP-E1 — Backlog Prioritized
**Rationale**: MoSCoW classification drives sprint scope; untagged items cause planning ambiguity.
**Failure scenarios**: Stakeholder disagreement on priority; items without clear business value.
**Escalation criteria**: Priority conflict between stakeholders; PM mediates or defers.
**Task-tracking integration**: MoSCoW tags applied to all backlog items in planning tool.

### CP-E2 — Items Phase-Aligned
**Rationale**: Phase alignment prevents work from entering a sprint that belongs to a future phase.
**Failure scenarios**: Item depends on undefined requirements (Workflow C needed); item spans multiple phases.
**Escalation criteria**: Undefined requirements block phase alignment; PM triggers Workflow C.
**Task-tracking integration**: Phase tags applied to backlog items; "Sprint-Candidate" status for current-phase items.

### CP-E3 — Sprint Plan Created
**Rationale**: Human reviewer ensures sprint plan is achievable and aligned with phase targets before commitment.
**Failure scenarios**: Missing task IDs; no traceability to backlog items.
**Escalation criteria**: Reviewer rejects plan due to unrealistic estimates; PM mediates with SM and PO.
**Task-tracking integration**: Approved sprint plan published to `docs/ways-of-work/sprint_NN.md`; backlog items status "Sprint-Ready".

### CP-E4 — Capacity Check
**Rationale**: Over-commitment causes sprint failure; capacity check prevents this.
**Failure scenarios**: Capacity calculation error; team availability changes after planning.
**Escalation criteria**: Phase targets impacted by deferral; PM escalates for phase-level decision.
**Task-tracking integration**: Capacity result recorded in sprint plan; deferred items returned to backlog with "deferred" tag.

### CP-F1 — Test Suite Executed
**Rationale**: Test execution must complete cleanly before results can be reviewed.
**Failure scenarios**: Test environment failure; test runner crash.
**Escalation criteria**: Systemic environment failure; PM escalates to infrastructure owner.
**Task-tracking integration**: Test execution event logged in `learning_base/07_testing/test_results_[sprint].md`.

### CP-F2 — Test Results Reviewed
**Rationale**: Human QA review ensures failures are properly classified before escalation decisions.
**Failure scenarios**: QA unable to classify failure type (test issue vs. code issue).
**Escalation criteria**: Ambiguous failure classification; PM prompts QA to distinguish test issue from requirement issue.
**Task-tracking integration**: Review completion triggers "QA-in-review" status on sprint item.

### CP-F3 — All Tests Pass
**Rationale**: Binary pass/fail gate determines whether the sprint item moves to Done or enters rework.
**Failure scenarios**: Flaky tests producing false failures; blocker classification disagreement.
**Escalation criteria**: Blocker found → PM presents Fix / Skip / Defer decision.
**Task-tracking integration**: Pass → sprint item "Done"; Fail + blocker → new planning issue "Fix blocker" created.

### CP-F4 — Acceptance Criteria Met
**Rationale**: Final human verification that all acceptance criteria are satisfied before marking complete.
**Failure scenarios**: Acceptance criteria were retroactively modified; not all criteria were testable.
**Escalation criteria**: Acceptance criteria conflict with current requirements → PM triggers Workflow C for revision.
**Task-tracking integration**: Approval logs acceptance verification; sprint item transitioned to "Done" status.
