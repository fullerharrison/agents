---
phase: 1
phase_name: Evidence Collection and Repro Mapping
task: Investigate PM custom-agent coordination failures vs known-good baseline
status: Reviewed
created: 2026-03-19
owner: Explorer
---

# Phase 1 Plan: Evidence Collection and Repro Mapping

## Objective
Produce a reproducible, source-linked evidence package that captures where PM-agent coordination diverges from expected behavior in the VIP environment.

## Scope
- In scope:
  - Inventory artifacts from VIP task assets, chat logs, and planner sample workbook reference.
  - Build an event timeline of expected vs observed agent handoffs.
  - Document concrete failed outcomes for ProjectOwner ingestion and Business Analyst planner output.
  - Capture explicit PM-tool recommendation failures with corresponding reproducible scenarios.
  - Define minimal reproducible scenarios for each failure mode.
  - Enforce evidence provenance fields (capture timestamp and immutable identifier/hash where possible).
- Out of scope:
  - Any code or instruction changes to fix behavior.
  - Root-cause recommendations (covered in later phases).

## Detailed File Changes and Evidence Artifacts to Produce

1. Create evidence source index.
- File: `.tasks/001-pm-agent-gap-analysis/evidence/phase-1-source-index.md`
- Purpose: Enumerate every evidence input with origin path, timestamp captured, and integrity notes.
- Required contents:
  - External source path list (VIP task path, chat-log folder, planner workbook path).
  - File-level capture metadata (name, modified time, size/hash when available).
  - Inclusion/exclusion rationale.

2. Create artifact inventory.
- File: `.tasks/001-pm-agent-gap-analysis/evidence/phase-1-artifact-inventory.md`
- Purpose: Normalize all discovered artifacts into a searchable inventory table.
- Required contents:
  - Columns: Artifact ID, Source Path, Type, Date, Relevant Agent(s), Related Requirement Domain, Notes.
  - Mapping to requirement domains: coordination, ingestion, planner output, PM-tool recommendations.

3. Create handoff timeline.
- File: `.tasks/001-pm-agent-gap-analysis/evidence/phase-1-handoff-timeline.md`
- Purpose: Show expected vs observed handoff sequence with evidence references.
- Required contents:
  - Ordered sequence table by run/session.
  - Event fields: Sequence #, Timestamp, Initiator Agent, Target Agent, Expected Handoff, Observed Handoff, Evidence Reference, Mismatch Flag.
  - At least three complete session timelines.

4. Create failure-mode matrix.
- File: `.tasks/001-pm-agent-gap-analysis/evidence/phase-1-failure-mode-matrix.md`
- Purpose: Capture concrete failed outcomes and classify impact.
- Required contents:
  - Failure IDs for:
    - ProjectOwner did not process/add structured learning-base content.
    - Business Analyst output not planner-import-friendly.
    - PM-tool recommendation behavior is incorrect, missing, or unsupported for task context.
  - Columns: Failure ID, Trigger Context, Expected Behavior, Observed Behavior, Severity, Frequency, Evidence References.

5. Create minimal repro scenarios.
- File: `.tasks/001-pm-agent-gap-analysis/evidence/phase-1-minimal-repro-scenarios.md`
- Purpose: Define smallest repeatable scenario for each observed failure mode.
- Required contents:
  - Scenario ID, Preconditions, Inputs, Steps, Expected Result, Observed Result, Repro Rate, Evidence Links.
  - Separate scenarios for ingestion failure, planner-format failure, and PM-tool recommendation failure.

6. Create external-source contingency log.
- File: `.tasks/001-pm-agent-gap-analysis/evidence/phase-1-external-source-contingencies.md`
- Purpose: Track inaccessible paths, partial evidence packaging, and progression blocks.
- Required contents:
  - Columns: Source ID, Source Path, Access Status, Failure Time, Attempt Count, Blocking (Y/N), Partial Evidence Package ID, Next Action.
  - Explicit records of continue-with-partial-evidence vs block-progression decisions.

7. Update task phase status and plan link.
- File: `.tasks/001-pm-agent-gap-analysis/task.md`
- Purpose: Keep phase tracking current.
- Required change:
  - Phase 1 row status to `⭐ Reviewed`.
  - Plan column link to `plan/phase-1-evidence-collection-and-repro-mapping.md`.

## Step-by-Step Implementation Actions

1. Establish evidence boundary and ID convention.
- Define IDs: SRC-*, ART-*, EVT-*, FAIL-*, REPRO-*.
- Define contingency/package IDs: CONT-*, PKG-*.
- Add required provenance fields to source/artifact tables: Captured At (UTC), Immutable Identifier/Hash, Hash Algorithm (if used), Exception Reason (if unavailable).
- Record conventions at top of `phase-1-source-index.md`.

2. Ingest and catalog source artifacts.
- Enumerate all candidate files from the VIP task folder and chat-log folder.
- Record planner workbook metadata and expected import constraints reference from current task context.
- For each source/artifact, record provenance (timestamp and immutable identifier/hash where possible).
- Populate `phase-1-source-index.md` and `phase-1-artifact-inventory.md`.

3. Build session timelines from logs/artifacts.
- Identify each run/session with enough continuity for handoff tracing.
- Populate expected vs observed handoff rows in `phase-1-handoff-timeline.md`.

4. Isolate and document failure modes.
- Extract concrete examples where:
  - ProjectOwner ingestion outcome is absent/incorrect.
  - Business Analyst output shape cannot be used for planner import flow.
  - PM-tool recommendation behavior is absent, incorrect, or not actionable.
- Populate `phase-1-failure-mode-matrix.md` with severity/frequency observations.

5. Define minimal reproducible scenarios.
- Reduce each failure mode to minimum required trigger conditions and steps.
- Record at least three independent reproducible scenarios in `phase-1-minimal-repro-scenarios.md`.

6. Apply external-source contingency rules.
- If an external path is inaccessible, log CONT-* entry with at least two timestamped access attempts.
- Build a partial evidence package (PKG-*) when at least two source classes remain available.
- Block progression when any targeted domain lacks at least one confirmed repro due to missing evidence.
- Allow conditional progression only when blocked domains and explicit owner follow-up actions are documented.

7. Cross-check traceability and completeness.
- Ensure every failure and repro scenario links to one or more artifact IDs.
- Ensure all four requirement domains are represented in inventory coverage notes.
- Confirm provenance fields are populated for all SRC-* and ART-* rows (or exception reason documented).

8. Update phase tracking.
- Confirm Phase 1 row in `task.md` remains `⭐ Reviewed` with plan file link.

## Dependencies and Notes

- DEP-1: Read access to external VIP paths listed in `task.md` is required.
- DEP-2: Chat-log timestamps must be available to build accurate event sequence.
- DEP-3: Planner workbook reference must remain accessible for format-context evidence.
- DEP-4: No downstream phase should start before failure IDs and repro IDs are stable.

## External-Source Contingency Rules

- CONT-1: Any inaccessible source path requires at least two timestamped access attempts before final classification.
- CONT-2: Inaccessible sources must be logged in `phase-1-external-source-contingencies.md` with explicit blocking status.
- CONT-3: Partial evidence packages must receive PKG-* IDs and list covered vs uncovered domains.
- CONT-4: Progression is blocked if a targeted domain cannot produce at least one confirmed repro.
- CONT-5: Conditional progression is permitted only with documented owner, action, and due date for blocked domains.

## Risks and Assumptions

- RISK-1: External artifacts may change during capture, causing timeline drift.
  - Mitigation: Store capture timestamp for every source and freeze evidence snapshot references.
- RISK-2: Logs may be incomplete, creating ambiguous handoff transitions.
  - Mitigation: Mark unknown transitions explicitly and avoid inferred conclusions.
- RISK-3: Planner workbook constraints may be partially implicit.
  - Mitigation: Separate observed constraints from assumed constraints in artifact notes.

- ASSUMPTION-1: Existing chat logs contain enough detail to trace at least one full failed run.
- ASSUMPTION-2: Failure domains in `task.md` are still the authoritative focus for Phase 1.
- ASSUMPTION-3: This phase outputs evidence only; diagnosis and remediation decisions occur later.

## Success Criteria

- SC-1: Six Phase 1 evidence documents exist under `.tasks/001-pm-agent-gap-analysis/evidence/` and are non-empty.
- SC-2: Every documented failure mode (ingestion, planner-format, PM-tool recommendation) includes at least one explicit evidence reference and one repro scenario.
- SC-3: At least three end-to-end session timelines capture expected vs observed sequence with mismatch flags.
- SC-4: `task.md` shows Phase 1 status as `⭐ Reviewed` and links to this plan file.
- SC-5: At least one confirmed repro exists for each targeted domain.
- SC-6: Provenance checks are complete for all source/artifact rows (timestamp + immutable identifier/hash where possible; exceptions documented).

## Verification

### Automated Checks
- Run `rg "FAIL-|REPRO-|EVT-|ART-|SRC-" .tasks/001-pm-agent-gap-analysis/evidence` and confirm all ID categories appear.
- Run `rg "CONT-|PKG-" .tasks/001-pm-agent-gap-analysis/evidence` and confirm contingency/package IDs appear when source access failures exist.
- Run `rg "\| 1 \| Evidence Collection and Repro Mapping \| ⭐ Reviewed \|" .tasks/001-pm-agent-gap-analysis/task.md` and confirm one matching phase row.
- Run `rg "phase-1-evidence-collection-and-repro-mapping.md" .tasks/001-pm-agent-gap-analysis/task.md` and confirm plan link exists.
- Run `rg "PM-tool recommendation" .tasks/001-pm-agent-gap-analysis/evidence/phase-1-failure-mode-matrix.md .tasks/001-pm-agent-gap-analysis/evidence/phase-1-minimal-repro-scenarios.md` and confirm explicit PM-tool failure and repro capture.

### Manual Verification Steps
1. Open each Phase 1 evidence document and confirm required table columns/sections are present.
2. Manually trace one failure ID from matrix -> timeline -> repro scenario and confirm references are consistent.
3. Confirm at least three sessions are fully traced in timeline and each targeted domain has at least one confirmed repro.
4. Confirm provenance columns are populated for each source/artifact row and include immutable identifiers/hashes where possible.
5. If any source is inaccessible, confirm contingency log records attempts, packaging decision, and block/conditional progression status.
6. Confirm out-of-scope boundaries are preserved (no remediation edits in Phase 1 artifacts).

### Verification Success Criteria
- All automated checks return at least one positive match with no missing ID class.
- Manual traceability check succeeds for at least one ingestion failure, one planner-format failure, and one PM-tool recommendation failure.
- Minimum of three traced sessions is met.
- At least one confirmed repro exists for each targeted domain.
- Observability checks for ingestion failures are explicit with linked log/event artifact evidence and mismatch flags.
- Phase 1 package is self-contained enough for Phase 2 baseline mapping without re-collecting evidence.

## Handoff to Next Phase
Phase 2 can start only when SC-1 through SC-6 are satisfied, or when CONT-5 conditional progression is explicitly documented.

## Phase 2 Entry Criteria (Evidence Quality Gates)

- QG-1: Minimum three traced sessions exist with complete expected vs observed handoff rows.
- QG-2: At least one confirmed repro exists for each targeted domain: ingestion, planner-format, PM-tool recommendation.
- QG-3: Ingestion failure observability is explicit with linked evidence references and mismatch markers.
- QG-4: Provenance coverage is complete (timestamp + immutable identifier/hash where possible), with documented exceptions.
- QG-5: Any inaccessible external source has contingency status recorded and progression decision applied per CONT-4/CONT-5.
