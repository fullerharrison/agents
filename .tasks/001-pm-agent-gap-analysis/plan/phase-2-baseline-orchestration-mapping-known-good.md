---
phase: 2
phase_name: Baseline Orchestration Mapping (Known-Good)
task: Investigate PM custom-agent coordination failures vs known-good baseline
status: Planned
created: 2026-03-19
owner: Explorer
---

# Phase 2 Plan: Baseline Orchestration Mapping (Known-Good)

## Objective
Produce a source-linked baseline map of known-good orchestration behavior from C:/Users/s1058662/repos/agents so later gap analysis can compare VIP behavior contract-by-contract without ambiguity.

## Scope
- In scope:
  - Extract known-good orchestration contracts from the baseline repository.
  - Document trigger conditions, role boundaries, memory write paths, output schema contracts, and conductor gate checkpoints.
  - Align baseline contracts to Phase 1 failure domains (coordination, ingestion, planner output, PM-tool recommendations).
  - Produce machine-scannable identifiers and traceability between baseline contracts and downstream analysis needs.
- Out of scope:
  - Any remediation or code change proposals.
  - Direct modifications to the baseline repository.
  - Root-cause conclusions (handled in Phase 3).

## Detailed File Changes and Artifacts to Produce

1. Create baseline source index.
- File: .tasks/001-pm-agent-gap-analysis/evidence/phase-2-baseline-source-index.md
- Purpose: Record every baseline input used for orchestration mapping with provenance.
- Required contents:
  - Source IDs BAS-SRC-*.
  - Baseline path, relative file path, captured timestamp, hash/immutable identifier where available.
  - Inclusion rationale and relevance tags (coordination, ingestion, planner, PM-tool recommendation).

2. Create orchestration contract map.
- File: .tasks/001-pm-agent-gap-analysis/evidence/phase-2-orchestration-contract-map.md
- Purpose: Define expected handoff contracts in known-good flow.
- Required contents:
  - Contract IDs BAS-CONTRACT-*.
  - Columns: Contract ID, Initiator Role, Target Role, Trigger, Required Inputs, Required Outputs, Failure Signal, Evidence Source.
  - Explicit mapping for user intake, delegation, execution, completion, and return-to-user stages.

3. Create trigger condition catalog.
- File: .tasks/001-pm-agent-gap-analysis/evidence/phase-2-trigger-condition-catalog.md
- Purpose: Normalize baseline trigger logic for orchestration transitions.
- Required contents:
  - Trigger IDs BAS-TRIG-*.
  - Trigger predicates, required preconditions, forbidden states, expected next role/action.

4. Create role boundary matrix.
- File: .tasks/001-pm-agent-gap-analysis/evidence/phase-2-role-boundary-matrix.md
- Purpose: Document authority and responsibility boundaries across orchestrating agents.
- Required contents:
  - Role IDs BAS-ROLE-*.
  - Columns: Role, Must Do, Must Not Do, Inputs Owned, Outputs Owned, Escalation Path, Evidence Source.

5. Create memory and learning-base write path map.
- File: .tasks/001-pm-agent-gap-analysis/evidence/phase-2-memory-write-path-map.md
- Purpose: Capture known-good persistence rules and write locations.
- Required contents:
  - Path IDs BAS-MEM-*.
  - Memory scopes, target paths, required structure, write trigger, write owner role, failure handling expectations.

6. Create output schema and formatting contracts.
- File: .tasks/001-pm-agent-gap-analysis/evidence/phase-2-output-schema-contracts.md
- Purpose: Define baseline output format obligations, including planner-friendly outputs and PM-tool recommendation formatting.
- Required contents:
  - Schema IDs BAS-SCHEMA-*.
  - Required fields for BA/planner outputs.
  - PM recommendation contract fields (framework name, trigger rationale, when-to-apply guidance).

7. Create conductor checkpoint baseline.
- File: .tasks/001-pm-agent-gap-analysis/evidence/phase-2-conductor-checkpoints.md
- Purpose: Provide gate criteria used to validate known-good orchestration progression.
- Required contents:
  - Checkpoint IDs BAS-GATE-*.
  - Entry condition, pass criteria, fail criteria, evidence artifact(s), blocking severity.

8. Create Phase 1 to baseline crosswalk.
- File: .tasks/001-pm-agent-gap-analysis/evidence/phase-2-phase1-crosswalk.md
- Purpose: Link each Phase 1 failure and repro domain to the exact baseline contract(s) needed for comparison in Phase 3.
- Required contents:
  - Crosswalk IDs BAS-XREF-*.
  - Columns: Phase 1 Failure/Repro ID, Domain, Baseline Contract IDs, Comparison Notes.

9. Update task phase status and plan link.
- File: .tasks/001-pm-agent-gap-analysis/task.md
- Purpose: Mark planning completion for this phase and link plan artifact.
- Required change:
  - Phase 2 row status to 📋 Planned.
  - Plan column link to plan/phase-2-baseline-orchestration-mapping-known-good.md.

## Step-by-Step Implementation Actions

1. Establish baseline evidence conventions.
- Define IDs at top of phase-2-baseline-source-index.md: BAS-SRC-*, BAS-CONTRACT-*, BAS-TRIG-*, BAS-ROLE-*, BAS-MEM-*, BAS-SCHEMA-*, BAS-GATE-*, BAS-XREF-*.
- Define required provenance fields and exception handling rules for unavailable hashes.

2. Enumerate baseline orchestration sources.
- Inventory baseline orchestration-relevant files under C:/Users/s1058662/repos/agents.
- Prioritize files that define agent instructions, role contracts, handoff workflows, memory writes, and output templates.
- Populate phase-2-baseline-source-index.md.

2a. Contingency branch: handle baseline-source access failure.
- If C:/Users/s1058662/repos/agents is inaccessible, immediately create a blocked-state note in phase-2-baseline-source-index.md with timestamp, attempted path, and error summary.
- Block handling: mark Phase 2 as blocked for direct source extraction and do not fabricate BAS-SRC-* entries.
- Alternate handling: if a previously captured baseline snapshot exists in .tasks/001-pm-agent-gap-analysis/evidence or other task-scoped artifacts, proceed using only those artifacts and mark each BAS-SRC-* as snapshot-derived.
- Deferred handling: if no valid snapshot exists, defer Steps 3-9 and carry forward a dependency note that Phase 3 cannot start until baseline-source access is restored.

3. Extract end-to-end handoff contracts.
- Parse baseline instructions/workflow assets to identify each expected role transition.
- Record BAS-CONTRACT-* rows with deterministic trigger and output requirements.
- Populate phase-2-orchestration-contract-map.md.

4. Normalize transition triggers.
- Identify trigger predicates and state conditions associated with each handoff.
- Populate BAS-TRIG-* in phase-2-trigger-condition-catalog.md with precise preconditions and next-step obligations.

5. Map role boundaries and ownership.
- Derive role-specific duties and prohibitions from baseline definitions.
- Populate BAS-ROLE-* entries in phase-2-role-boundary-matrix.md.

6. Map memory and learning-base persistence paths.
- Identify where each role writes persistent context and under what trigger.
- Record structure and ownership expectations using BAS-MEM-* in phase-2-memory-write-path-map.md.

7. Capture output and PM-framework recommendation contracts.
- Extract required output structure for planner-friendly BA artifacts.
- Extract recommendation obligations for PM frameworks (for governance, uncertainty, prioritization, and root-cause contexts).
- Populate BAS-SCHEMA-* rows in phase-2-output-schema-contracts.md.

8. Define conductor gate checkpoints.
- Extract baseline gate semantics for progression control.
- Populate BAS-GATE-* rows in phase-2-conductor-checkpoints.md.

9. Build Phase 1 to baseline crosswalk.
- Map FAIL-* and REPRO-* items from Phase 1 evidence to baseline contract IDs.
- Populate phase-2-phase1-crosswalk.md with BAS-XREF-* entries.

10. Perform traceability quality check.
- Ensure each BAS-CONTRACT-* links back to BAS-SRC-* evidence.
- Ensure each Phase 1 failure domain links to at least one baseline contract in crosswalk.

11. Update task tracking.
- Verify the existing Phase 2 row in task.md first.
- If status is not 📋 Planned, update it to 📋 Planned.
- If plan link is missing or mismatched, update it to plan/phase-2-baseline-orchestration-mapping-known-good.md.
- If both status and plan link already match, perform no file change; this idempotent check is verification-only and not an artifact-change objective.

## Dependencies and Notes

- DEP-1: Read access to C:/Users/s1058662/repos/agents is required for source extraction.
- DEP-2: Phase 1 evidence IDs (FAIL-*, REPRO-*) remain stable for crosswalk mapping.
- DEP-3: Baseline source set must include both orchestration and output contract definitions.
- DEP-4: No gap conclusions should be written in Phase 2 artifacts; this phase is baseline-only mapping.
- DEP-5: If baseline-source access fails and no approved snapshot exists, this phase is blocked and downstream Phase 3 is deferred.

## Risks and Assumptions

- RISK-1: Baseline repository may contain multiple candidate orchestration patterns.
  - Mitigation: Select the default/active path and record exclusion rationale for alternatives.
- RISK-2: Some baseline contracts may be implicit rather than explicitly documented.
  - Mitigation: Mark implicit contracts clearly and anchor each to direct source text.
- RISK-3: Planner-output requirements may be split across templates and instructions.
  - Mitigation: Aggregate into BAS-SCHEMA-* with source-level traceability.

- ASSUMPTION-1: Known-good behavior in C:/Users/s1058662/repos/agents is currently authoritative.
- ASSUMPTION-2: Phase 1 evidence package is complete enough to support crosswalk mapping.
- ASSUMPTION-3: This phase creates only baseline mapping artifacts and task tracking updates.

## Tests

This phase is documentation and mapping only; no production behavior changes are implemented.

- TEST-1 (Traceability test): Every BAS-CONTRACT-* must cite at least one BAS-SRC-* reference.
- TEST-2 (Coverage test): Crosswalk must include all Phase 1 failure domains: ingestion, planner-output, PM-framework recommendation, and coordination handoffs.
- TEST-3 (Contract completeness test): Each BAS-SCHEMA-* entry must specify required fields and failure signal criteria.
- TEST-4 (Artifact presence test): All eight required Phase 2 evidence files must exist before declaring SC-1.
- TEST-5 (Structure test): Required headers/column names must appear in each evidence artifact that defines tabular contracts.
- TEST-6 (Substantive completeness test): Each of the eight Phase 2 artifacts must include substantive non-empty content beyond title/header/token-only matches.
- TEST-7 (Row/content quality test): Artifacts with ID rows must include at least one row where multiple required fields are populated with non-placeholder values and meaningful text.

## Success Criteria

- SC-1: Eight Phase 2 evidence documents exist under .tasks/001-pm-agent-gap-analysis/evidence and each contains substantive non-empty content (not header-only/token-only).
- SC-2: All baseline contracts are represented with IDs and source traceability (BAS-CONTRACT-* -> BAS-SRC-*).
- SC-3: Trigger, role, memory, schema, and conductor domains each have dedicated artifacts with complete required columns.
- SC-4: Crosswalk links each Phase 1 failure/repro domain to one or more baseline contract IDs.
- SC-5: task.md shows Phase 2 as 📋 Planned with a valid plan link.

## Verification

### Automated Checks
- Run rg --files .tasks/001-pm-agent-gap-analysis/evidence and confirm presence of these exact files:
  - phase-2-baseline-source-index.md
  - phase-2-orchestration-contract-map.md
  - phase-2-trigger-condition-catalog.md
  - phase-2-role-boundary-matrix.md
  - phase-2-memory-write-path-map.md
  - phase-2-output-schema-contracts.md
  - phase-2-conductor-checkpoints.md
  - phase-2-phase1-crosswalk.md
- Run rg "Contract ID\s*\|\s*Initiator Role\s*\|\s*Target Role\s*\|\s*Trigger\s*\|\s*Required Inputs\s*\|\s*Required Outputs\s*\|\s*Failure Signal\s*\|\s*Evidence Source" .tasks/001-pm-agent-gap-analysis/evidence/phase-2-orchestration-contract-map.md and confirm header exists.
- Run rg "Role\s*\|\s*Must Do\s*\|\s*Must Not Do\s*\|\s*Inputs Owned\s*\|\s*Outputs Owned\s*\|\s*Escalation Path\s*\|\s*Evidence Source" .tasks/001-pm-agent-gap-analysis/evidence/phase-2-role-boundary-matrix.md and confirm header exists.
- Run rg "Phase 1 Failure/Repro ID\s*\|\s*Domain\s*\|\s*Baseline Contract IDs\s*\|\s*Comparison Notes" .tasks/001-pm-agent-gap-analysis/evidence/phase-2-phase1-crosswalk.md and confirm header exists.
- Run rg "BAS-SRC-|BAS-CONTRACT-|BAS-TRIG-|BAS-ROLE-|BAS-MEM-|BAS-SCHEMA-|BAS-GATE-|BAS-XREF-" .tasks/001-pm-agent-gap-analysis/evidence and confirm each ID family appears at least once.
- Run rg "FAIL-|REPRO-" .tasks/001-pm-agent-gap-analysis/evidence/phase-2-phase1-crosswalk.md and confirm crosswalk references both failure and repro IDs.
- Run rg "^\|\s*BAS-CONTRACT-" .tasks/001-pm-agent-gap-analysis/evidence/phase-2-orchestration-contract-map.md and confirm at least one contract row exists.
- Run rg "^\|\s*BAS-ROLE-" .tasks/001-pm-agent-gap-analysis/evidence/phase-2-role-boundary-matrix.md and confirm at least one role row exists.
- Run rg "^\|\s*BAS-XREF-" .tasks/001-pm-agent-gap-analysis/evidence/phase-2-phase1-crosswalk.md and confirm at least one crosswalk row exists.
- Run rg "^\|\s*BAS-SRC-[^|]*\|\s*[^|[:space:]][^|]*\|\s*[^|[:space:]][^|]*\|\s*[^|[:space:]][^|]*\|\s*[^|[:space:]][^|]*\|\s*[^|[:space:]][^|]*\|" .tasks/001-pm-agent-gap-analysis/evidence/phase-2-baseline-source-index.md and confirm at least one BAS-SRC row has multiple populated non-empty fields.
- Run rg "^\|\s*BAS-CONTRACT-[^|]*\|\s*[^|[:space:]][^|]*\|\s*[^|[:space:]][^|]*\|\s*[^|[:space:]][^|]*\|\s*[^|[:space:]][^|]*\|\s*[^|[:space:]][^|]*\|\s*[^|[:space:]][^|]*\|\s*[^|[:space:]][^|]*\|" .tasks/001-pm-agent-gap-analysis/evidence/phase-2-orchestration-contract-map.md and confirm at least one BAS-CONTRACT row has all required columns substantively populated.
- Run rg "^\|\s*BAS-TRIG-[^|]*\|\s*[^|[:space:]][^|]*\|\s*[^|[:space:]][^|]*\|\s*[^|[:space:]][^|]*\|\s*[^|[:space:]][^|]*\|" .tasks/001-pm-agent-gap-analysis/evidence/phase-2-trigger-condition-catalog.md and confirm at least one BAS-TRIG row has populated predicate/precondition/forbidden-state/next-action fields.
- Run rg "^\|\s*BAS-ROLE-[^|]*\|\s*[^|[:space:]][^|]*\|\s*[^|[:space:]][^|]*\|\s*[^|[:space:]][^|]*\|\s*[^|[:space:]][^|]*\|\s*[^|[:space:]][^|]*\|\s*[^|[:space:]][^|]*\|" .tasks/001-pm-agent-gap-analysis/evidence/phase-2-role-boundary-matrix.md and confirm at least one BAS-ROLE row has all ownership/boundary fields populated.
- Run rg "^\|\s*BAS-MEM-[^|]*\|\s*[^|[:space:]][^|]*\|\s*[^|[:space:]][^|]*\|\s*[^|[:space:]][^|]*\|\s*[^|[:space:]][^|]*\|\s*[^|[:space:]][^|]*\|\s*[^|[:space:]][^|]*\|" .tasks/001-pm-agent-gap-analysis/evidence/phase-2-memory-write-path-map.md and confirm at least one BAS-MEM row has populated scope/path/structure/trigger/owner/failure-handling fields.
- Run rg "^\|\s*BAS-SCHEMA-[^|]*\|\s*[^|[:space:]][^|]*\|\s*[^|[:space:]][^|]*\|\s*[^|[:space:]][^|]*\|" .tasks/001-pm-agent-gap-analysis/evidence/phase-2-output-schema-contracts.md and confirm at least one BAS-SCHEMA row has populated required-fields and failure-signal content.
- Run rg "^\|\s*BAS-GATE-[^|]*\|\s*[^|[:space:]][^|]*\|\s*[^|[:space:]][^|]*\|\s*[^|[:space:]][^|]*\|\s*[^|[:space:]][^|]*\|\s*[^|[:space:]][^|]*\|" .tasks/001-pm-agent-gap-analysis/evidence/phase-2-conductor-checkpoints.md and confirm at least one BAS-GATE row has populated entry/pass/fail/evidence/severity fields.
- Run rg "^\|\s*BAS-XREF-[^|]*\|\s*(FAIL-|REPRO-)[^|]*\|\s*[^|[:space:]][^|]*\|\s*BAS-CONTRACT-[^|]*\|\s*[^|[:space:]][^|]*\|" .tasks/001-pm-agent-gap-analysis/evidence/phase-2-phase1-crosswalk.md and confirm at least one BAS-XREF row has populated domain/contract/comparison content.
- Run rg "\b(TBD|TODO|N/A|placeholder)\b" .tasks/001-pm-agent-gap-analysis/evidence/phase-2-*.md and confirm no substantive row relied on placeholders for required fields.
- Run rg "\| 2 \| Baseline Orchestration Mapping \(Known-Good\) \| 📋 Planned \|" .tasks/001-pm-agent-gap-analysis/task.md and confirm one matching row.
- Run rg "phase-2-baseline-orchestration-mapping-known-good.md" .tasks/001-pm-agent-gap-analysis/task.md and confirm plan link exists.

### Manual Verification Steps
1. Open each of the eight phase-2 evidence files and verify at least one substantive row/entry exists with non-empty, meaningful values in required fields (not title/header/token-only content).
2. In each artifact, inspect at least one ID row and confirm fields contain concrete baseline-specific content (for example, explicit trigger predicates, role prohibitions, memory paths, schema fields, gate criteria, or comparison notes), not placeholders.
3. Pick one BAS-CONTRACT-* entry and trace it back to BAS-SRC-* evidence and forward to BAS-XREF-* crosswalk entry, confirming all three nodes contain substantive non-empty content.
4. Confirm PM-framework recommendation obligations are explicitly documented with concrete required fields and when-to-apply guidance in phase-2-output-schema-contracts.md.
5. Confirm conductor checkpoints include concrete entry condition, pass criteria, and fail criteria text for BAS-GATE-* entries.
6. Confirm phase output stays baseline-descriptive only, with no remediation recommendation content.

### Verification Success Criteria
- All automated checks return positive matches with no missing ID category and with substantive row/content matches in every Phase 2 artifact.
- Manual verification confirms at least one concrete, non-placeholder, multi-field substantive entry in each of the eight artifacts.
- Manual traceability check succeeds for at least one contract in each domain (trigger, role, memory, schema, gate).
- Crosswalk demonstrates complete Phase 1 domain coverage for downstream Phase 3 gap analysis.

## Handoff to Next Phase
Phase 3 can start when SC-1 through SC-5 are satisfied and baseline contracts are traceable end-to-end from source evidence to crosswalk mappings.