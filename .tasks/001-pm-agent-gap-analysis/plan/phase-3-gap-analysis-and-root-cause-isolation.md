---
phase: 3
phase_name: Gap Analysis and Root-Cause Isolation
task: Investigate PM custom-agent coordination failures vs known-good baseline
status: Planned
created: 2026-03-23
owner: Explorer
---

# Phase 3 Plan: Gap Analysis and Root-Cause Isolation

## Objective

Produce a traceable, contract-by-contract gap register that identifies every point where VIP PM-agent behavior diverges from the known-good baseline, classifies each gap by root-cause category, and isolates actionable breakpoints for use in Phase 4 remediation planning.

## Scope

- In scope:
  - Compare each Phase 1 FAIL-* and REPRO-* scenario against the baseline contracts mapped in Phase 2.
  - Walk every BAS-XREF-* crosswalk entry and document exact observed-vs-expected deltas.
  - Trace each mismatch to a specific instruction, skill, prompt, workflow gate, output template, or path configuration in the VIP environment.
  - Classify each gap by root-cause category.
  - Produce a root-cause summary that connects gaps to acceptance criteria domains.
  - Rank gaps by remediation priority for Phase 4 input.
- Out of scope:
  - Implementing or proposing specific fix instructions or code changes (Phase 4).
  - Creating new repro scenarios beyond re-applying existing REPRO-* to baselines.
  - Revisiting or revising Phase 1 or Phase 2 evidence content.

---

## Phase Dependencies

| Dependency ID | Source Phase | Artifact Required | Required Content |
|---|---|---|---|
| DEP-PHASE3-001 | Phase 1 | `evidence/phase-1-failure-mode-matrix.md` | FAIL-001, FAIL-002, FAIL-003 rows with evidence references |
| DEP-PHASE3-002 | Phase 1 | `evidence/phase-1-minimal-repro-scenarios.md` | REPRO-001, REPRO-002, REPRO-003 rows with trigger/steps/observed result |
| DEP-PHASE3-003 | Phase 1 | `evidence/phase-1-artifact-inventory.md` | ART-* IDs and source paths for traceability |
| DEP-PHASE3-004 | Phase 1 | `evidence/phase-1-handoff-timeline.md` | Session timelines with mismatch flags |
| DEP-PHASE3-005 | Phase 2 | `evidence/phase-2-phase1-crosswalk.md` | BAS-XREF-001 through BAS-XREF-007 with contract IDs |
| DEP-PHASE3-006 | Phase 2 | `evidence/phase-2-orchestration-contract-map.md` | BAS-CONTRACT-001 through BAS-CONTRACT-010 |
| DEP-PHASE3-007 | Phase 2 | `evidence/phase-2-trigger-condition-catalog.md` | BAS-TRIG-* predicates and preconditions |
| DEP-PHASE3-008 | Phase 2 | `evidence/phase-2-role-boundary-matrix.md` | BAS-ROLE-* must-do / must-not-do boundaries |
| DEP-PHASE3-009 | Phase 2 | `evidence/phase-2-memory-write-path-map.md` | BAS-MEM-* write paths and write-trigger conditions |
| DEP-PHASE3-010 | Phase 2 | `evidence/phase-2-output-schema-contracts.md` | BAS-SCHEMA-001 through BAS-SCHEMA-004 |
| DEP-PHASE3-011 | Phase 2 | `evidence/phase-2-conductor-checkpoints.md` | BAS-GATE-* entry/pass/fail criteria |

**Pre-condition gate**: All DEP-PHASE3-* artifacts must contain substantive non-empty content before this phase begins. If any DEP-PHASE3-005 through DEP-PHASE3-011 artifact is missing or header-only, block Phase 3 and raise a dependency-blocker entry in the contingency log.

---

## Detailed Artifacts to Produce

### 1. ID and Convention Declaration

- **File**: `evidence/phase-3-id-conventions.md`
- **Purpose**: Declare the Phase 3 identifier namespaces so all gap and root-cause records are unambiguous and scannable.
- **Required contents**:
  - Gap record IDs: `GAP-*` (e.g., GAP-001)
  - Root-cause record IDs: `RC-*` (e.g., RC-001)
  - Gap-to-root-cause link IDs: `LINK-*` (e.g., LINK-001)
  - Dependency-blocker record IDs: `PHASE3-BLOCK-*`
  - Coverage summary record IDs: `COV-*`
  - Root-cause category vocabulary (see Step 2 for list)
  - Severity and confidence scale definitions

---

### 2. Gap Register

- **File**: `evidence/phase-3-gap-register.md`
- **Purpose**: One row per contract gap with full observational detail, traceable to Phase 1 and Phase 2 IDs.
- **Required columns**:

  | Gap ID | Failure/Repro ID(s) | Domain | Baseline Contract ID(s) | VIP Observed Behavior | Baseline Expected Behavior | Delta Description | Severity | Confidence | Phase 1 Evidence Reference | Phase 2 Evidence Reference |

- **Domain values** (from crosswalk): coordination handoffs, ingestion, planner-output, pm-recommendation
- **Severity values**: Critical (blocks acceptance domain), High (materially degrades quality), Medium (degrades reliability)
- **Confidence values**: High (directly traceable to artifact text), Medium (inferred from surrounding evidence), Low (requires additional observation)
- **Minimum coverage required**: At least one GAP-* row per BAS-XREF-* entry (BAS-XREF-001 through BAS-XREF-007); i.e., at least 7 gap rows required.
- **Traceability requirement**: Every GAP-* must cite at least one Phase 1 artifact reference (FAIL-*, REPRO-*, ART-*, or EVT-*) and at least one Phase 2 contract reference (BAS-CONTRACT-*, BAS-TRIG-*, BAS-SCHEMA-*, or BAS-GATE-*).

---

### 3. Root-Cause Catalog

- **File**: `evidence/phase-3-root-cause-catalog.md`
- **Purpose**: Classify every identified root cause into a named category with supporting evidence, independent of the specific gap row.
- **Required columns**:

  | RC ID | Root-Cause Category | Description | Affected Artifacts in VIP Environment | Baseline Contract ID(s) Violated | Evidence Source(s) | Remediation Priority |

- **Mandatory root-cause categories** (derive from task.md Phase 3 scope):
  1. `CONFIG-DRIFT` — VIP instruction, skill, or prompt diverged from baseline without compensating change
  2. `TRIGGER-MISSING` — Trigger condition or entry predicate absent or incorrect in VIP environment
  3. `PATH-RESOLUTION` — Tooling, file path, or environment variable mismatch prevents expected write or read
  4. `FORMAT-CONTRACT` — Output format or schema obligation missing, incomplete, or structurally incompatible
  5. `PM-TOOL-LOGIC` — PM framework recommendation logic absent, incomplete, or not triggered in qualifying context
  6. `ROLE-BOUNDARY` — Agent executed actions that violate its defined authority or failed to execute required obligations
  7. `GATE-MISSING` — Conductor checkpoint or progression gate absent, bypassed, or not enforced
- **Remediation priority**: Phase4-Critical, Phase4-High, Phase4-Low (feeds directly into Phase 4 option scoping)
- **Minimum coverage**: At least one RC-* entry for each category that is observed as present; categories confirmed absent must be explicitly marked as `NOT-OBSERVED` with rationale.

---

### 4. Gap-to-Root-Cause Link Table

- **File**: `evidence/phase-3-gap-rc-links.md`
- **Purpose**: Provide a machine-scannable many-to-many mapping between GAP-* rows and RC-* rows so that remediations in Phase 4 can address root causes rather than symptoms.
- **Required columns**:

  | Link ID | Gap ID | RC ID | Link Rationale | Confidence |

- **Minimum coverage**: Every GAP-* must appear in at least one LINK-* row. Every RC-* marked as observed must appear in at least one LINK-* row.

---

### 5. Acceptance Domain Coverage Summary

- **File**: `evidence/phase-3-coverage-summary.md`
- **Purpose**: Confirm that all four acceptance criteria domains from task.md are represented in the gap analysis before declaring Phase 3 complete.
- **Required contents**:
  - Four COV-* rows, one per acceptance domain:
    1. `COV-001` — Agent coordination/orchestration reliability
    2. `COV-002` — Learning-base ingestion behavior
    3. `COV-003` — Planner-friendly BA output format
    4. `COV-004` — PM-tool recommendation behavior
  - Columns: `COV ID | Acceptance Domain | Gap IDs Mapped | RC IDs Mapped | Gaps Fully Traced | Coverage Notes`
  - Any domain with zero traced gaps must be flagged as `UNRESOLVED` with explanation.

---

### 6. Phase 3 Dependency Blocker Log (conditional)

- **File**: `evidence/phase-3-dependency-blockers.md`
- **Purpose**: Record any dependency failures discovered at the start of Phase 3 that prevent full execution.
- **Required contents** (create only if a blocker is found; create an empty file noting `No blockers detected` otherwise):
  - Columns: `PHASE3-BLOCK ID | Dependency ID | Blocked Artifact | Blocking Reason | Timestamp | Resolution Path`
  - Conditional progression rule: if any COV-* domain produces zero GAP-* traces due to dependency gaps, record `PHASE3-BLOCK-*` and note the domain as requiring Phase 2 remediation before Phase 4 begins.

---

### 7. task.md Update

- **File**: `.tasks/001-pm-agent-gap-analysis/task.md`
- **Required change**: Update Phase 3 row to `📋 Planned` with plan link `[phase-3-gap-analysis-and-root-cause-isolation.md](plan/phase-3-gap-analysis-and-root-cause-isolation.md)`.

---

## Step-by-Step Implementation Actions

### Step 1: Declare ID conventions and verify dependencies

1. Create `evidence/phase-3-id-conventions.md` with ID namespaces, category vocabulary, severity scale, and confidence scale as defined in Artifact 1 above.
2. For each DEP-PHASE3-* artifact, verify the file exists and contains at least one substantive row beyond header.
3. If any Phase 2 DEP (DEP-PHASE3-005 through DEP-PHASE3-011) is missing or header-only, create `evidence/phase-3-dependency-blockers.md` with a `PHASE3-BLOCK-*` entry and stop; do not proceed to Step 2.
4. Otherwise create `evidence/phase-3-dependency-blockers.md` with a `No blockers detected` note.

---

### Step 2: Walk each BAS-XREF-* entry and record gap rows

For each of the seven BAS-XREF-* entries in `evidence/phase-2-phase1-crosswalk.md`:

1. Read the Phase 1 failure or repro row (FAIL-001/002/003 or REPRO-001/002/003) from Phase 1 evidence.
2. Read each referenced BAS-CONTRACT-* row from `evidence/phase-2-orchestration-contract-map.md`.
3. Compare the "Observed Behavior" from Phase 1 against the "Required Outputs" and "Failure Signal" from the Phase 2 contract.
4. For each distinct delta found, create a GAP-* row in `evidence/phase-3-gap-register.md`.
5. Cross-check against BAS-TRIG-*, BAS-ROLE-*, BAS-MEM-*, BAS-SCHEMA-*, and BAS-GATE-* as applicable to the domain of the XREF entry.

**BAS-XREF walking order** (process in dependency sequence):
- BAS-XREF-001: FAIL-001 vs BAS-CONTRACT-002, 008, 009 → ingestion domain
- BAS-XREF-002: REPRO-001 vs BAS-CONTRACT-002, 004, 010 → ingestion domain
- BAS-XREF-003: FAIL-002 vs BAS-CONTRACT-008, 009, 010 → planner-output domain
- BAS-XREF-004: REPRO-002 vs BAS-CONTRACT-008, 009 → planner-output domain (cross-check BAS-SCHEMA-001, BAS-SCHEMA-002, BAS-SCHEMA-004)
- BAS-XREF-005: FAIL-003 vs BAS-CONTRACT-010 → pm-recommendation domain (cross-check BAS-SCHEMA-003)
- BAS-XREF-006: REPRO-003 vs BAS-CONTRACT-010 → pm-recommendation domain
- BAS-XREF-007: FAIL-002 vs BAS-CONTRACT-001, 003, 005, 007 → coordination handoffs domain

> **Note — dual FAIL-002 coverage**: Both BAS-XREF-003 and BAS-XREF-007 reference FAIL-002 but from different contract angles (planner-output vs coordination handoffs). They must produce **distinct** GAP-* rows; do not merge or deduplicate them across domains.

---

### Step 3: Classify root causes for each gap

For each GAP-* row:

1. Examine the delta description and evidence references.
2. Identify which root-cause category (or categories) applies from the category vocabulary in phase-3-id-conventions.md.
3. Check whether an RC-* entry for that category already exists in `evidence/phase-3-root-cause-catalog.md`; if yes, reference it; if no, create a new RC-* entry.
4. Record the category, description, affected VIP artifacts, violated baseline contract(s), evidence sources, and remediation priority.
5. For each category in the mandatory list, after processing all gaps, confirm whether it appears. Mark absent categories as `NOT-OBSERVED` with rationale.

---

### Step 4: Populate the Gap-to-Root-Cause link table

1. For each GAP-* row in the gap register, create one or more LINK-* rows in `evidence/phase-3-gap-rc-links.md`.
2. For each observed RC-* entry, verify at least one LINK-* row references it.
3. Record Link Rationale as a one-sentence explanation of the causal connection — do not use placeholders.

---

### Step 5: Build the coverage summary

1. Create `evidence/phase-3-coverage-summary.md`.
2. For each of the four acceptance domains (COV-001 through COV-004), list every GAP-* and RC-* ID that maps to that domain.
3. Check whether every GAP-* row in the gap register has been assigned to at least one COV-* row. If any GAP-* is unassigned, add it and note which domain it belongs to.
4. Flag any domain with zero traced gaps as `UNRESOLVED` and create a `PHASE3-BLOCK-*` entry in the dependency blockers log.

---

### Step 6: Traceability quality check

Before declaring Phase 3 complete:

1. Confirm every GAP-* cites at least one Phase 1 ID and one Phase 2 ID.
2. Confirm every RC-* marked as observed appears in at least one LINK-* row.
3. Confirm every BAS-XREF-* entry produced at least one GAP-* row.
4. Confirm all four COV-* domains are populated with at least one GAP-* and at least one RC-* reference.
5. Confirm no required field in any table row contains only a placeholder value (TBD, TODO, N/A, placeholder).

---

### Step 7: Update task tracking

> **No-op check**: If Phase 3 row in `task.md` already shows `📋 Planned` with plan link `[phase-3-gap-analysis-and-root-cause-isolation.md](plan/phase-3-gap-analysis-and-root-cause-isolation.md)`, this step is a no-op — skip.

1. Open `.tasks/001-pm-agent-gap-analysis/task.md`.
2. Update Phase 3 row: status → `📋 Planned`, Plan column → `[phase-3-gap-analysis-and-root-cause-isolation.md](plan/phase-3-gap-analysis-and-root-cause-isolation.md)`.

---

## Root-Cause Category Reference

| Category Code | Description |
|---|---|
| `CONFIG-DRIFT` | VIP instruction, skill, or prompt content diverged from baseline without compensating change |
| `TRIGGER-MISSING` | A trigger condition or entry predicate from BAS-TRIG-* is absent or incorrectly specified in VIP |
| `PATH-RESOLUTION` | A file path, memory-write target, or environment variable mismatch prevents expected VIP behavior |
| `FORMAT-CONTRACT` | A schema or template obligation from BAS-SCHEMA-* is missing, incomplete, or structurally incompatible in VIP |
| `PM-TOOL-LOGIC` | PM framework recommendation logic is absent, incomplete, or fails to activate under qualifying context in VIP |
| `ROLE-BOUNDARY` | VIP agent executes prohibited actions or omits required obligations per BAS-ROLE-* |
| `GATE-MISSING` | A Conductor checkpoint or progression gate from BAS-GATE-* is absent or not enforced in VIP |

---

## Risks and Assumptions

- **RISK-1**: VIP environment instructions may be partially aligned to baseline, producing gaps that span multiple root-cause categories simultaneously.
  - Mitigation: Allow multiple RC-* references per GAP-* row; document composite root causes explicitly.
- **RISK-2**: Some VIP files from Phase 1 source paths may be inaccessible during Phase 3 comparison.
  - Mitigation: Use captured artifact content from Phase 1 inventory (ART-* references) and Phase 2 baseline as delta evidence. If the artifact content is partially available but insufficient to confirm a delta with high confidence, mark the corresponding GAP-* row as `Low` confidence rather than creating a `PHASE3-BLOCK-*` entry. A `PHASE3-BLOCK-*` entry is reserved for cases where the dependency artifact is entirely missing or header-only, making it impossible to produce any GAP-* row for that domain.
- **RISK-3**: A gap may be a function of runtime behavior rather than static instruction content, making static comparison insufficient.
  - Mitigation: Mark confidence as `Low` and note that REPRO-* re-execution may be required; record as an open item in Phase 3 coverage summary.
- **RISK-4**: The number of GAP-* rows may be large enough that the gap register becomes unwieldy.
  - Mitigation: Group tightly related gaps under a shared RC-* and note in Link Rationale.

- **ASSUMPTION-1**: Phase 1 and Phase 2 evidence files are complete and contain substantive non-placeholder content.
- **ASSUMPTION-2**: BAS-XREF-001 through BAS-XREF-007 represent the complete set of Phase 1-to-baseline comparison vectors; no additional crosswalk entries are expected.
- **ASSUMPTION-3**: Root-cause classification uses static artifact comparison; runtime re-execution is out of scope for this phase.
- **ASSUMPTION-4**: This phase creates only analysis artifacts; no VIP instruction or baseline files are modified.

---

## Tests

This phase is analysis and documentation only; no production behavior changes are implemented.

- **TEST-1 (Gap completeness)**: Every BAS-XREF-* entry (001–007) must produce at least one GAP-* row.
- **TEST-2 (Traceability – Phase 1)**: Every GAP-* must cite at least one FAIL-*, REPRO-*, or ART-* reference.
- **TEST-3 (Traceability – Phase 2)**: Every GAP-* must cite at least one BAS-CONTRACT-*, BAS-TRIG-*, BAS-SCHEMA-*, BAS-GATE-*, or BAS-ROLE-* reference.
- **TEST-4 (Root-cause coverage)**: Every observed root-cause category must have at least one RC-* entry; absent categories must be explicitly marked `NOT-OBSERVED`.
- **TEST-5 (Link completeness)**: Every GAP-* appears in at least one LINK-* row and every observed RC-* appears in at least one LINK-* row.
- **TEST-6 (Acceptance domain coverage)**: All four COV-* rows are populated with at least one GAP-* and at least one RC-* ID.
- **TEST-7 (No placeholders)**: No required field in any table row contains `TBD`, `TODO`, `N/A`, or `placeholder` as its sole value.

---

## Success Criteria

- **SC-1**: Six Phase 3 evidence files exist under `.tasks/001-pm-agent-gap-analysis/evidence/`:
  - `phase-3-id-conventions.md`
  - `phase-3-gap-register.md`
  - `phase-3-root-cause-catalog.md`
  - `phase-3-gap-rc-links.md`
  - `phase-3-coverage-summary.md`
  - `phase-3-dependency-blockers.md` (present even if no blockers)
- **SC-2**: Gap register contains at least 7 substantive GAP-* rows (one per BAS-XREF-* entry minimum) with all required columns populated.
- **SC-3**: Root-cause catalog has at least one observed RC-* entry; all seven category codes are accounted for (observed or explicitly marked NOT-OBSERVED).
- **SC-4**: Every GAP-* row links to at least one Phase 1 and one Phase 2 evidence reference.
- **SC-5**: Link table provides full many-to-many coverage with no orphaned GAP-* or observed RC-*.
- **SC-6**: Coverage summary shows all four acceptance domains (COV-001 through COV-004) each with at least one mapped GAP-* and RC-*.
- **SC-7**: `task.md` shows Phase 3 as `📋 Planned` with a valid plan link.

---

## Verification

### Automated Checks

> **Shell/environment note**: The `rg -l` command below requires `ripgrep` ≥ 13. On Windows the path separator is `\`; substitute accordingly. Run from the workspace root.

```
# SC-1: Confirm all required artifacts exist
rg -l "." .tasks/001-pm-agent-gap-analysis/evidence/ --glob "phase-3-*"

# SC-2: Confirm gap register has at least 7 GAP-* rows
rg "^\|\s*GAP-" .tasks/001-pm-agent-gap-analysis/evidence/phase-3-gap-register.md

# SC-3: Confirm root-cause catalog has observed RC-* entries
rg "^\|\s*RC-" .tasks/001-pm-agent-gap-analysis/evidence/phase-3-root-cause-catalog.md

# SC-3: Confirm all 7 root-cause category codes appear (each observed or NOT-OBSERVED)
rg "CONFIG-DRIFT|TRIGGER-MISSING|PATH-RESOLUTION|FORMAT-CONTRACT|PM-TOOL-LOGIC|ROLE-BOUNDARY|GATE-MISSING" .tasks/001-pm-agent-gap-analysis/evidence/phase-3-root-cause-catalog.md

# SC-4: Confirm Phase 1 and Phase 2 references appear in gap rows
rg "FAIL-|REPRO-|ART-" .tasks/001-pm-agent-gap-analysis/evidence/phase-3-gap-register.md
rg "BAS-CONTRACT-|BAS-TRIG-|BAS-SCHEMA-|BAS-GATE-|BAS-ROLE-" .tasks/001-pm-agent-gap-analysis/evidence/phase-3-gap-register.md

# SC-5: Confirm link table has LINK-* rows referencing both GAP-* and RC-*
rg "^\|\s*LINK-" .tasks/001-pm-agent-gap-analysis/evidence/phase-3-gap-rc-links.md
rg "GAP-" .tasks/001-pm-agent-gap-analysis/evidence/phase-3-gap-rc-links.md
rg "RC-" .tasks/001-pm-agent-gap-analysis/evidence/phase-3-gap-rc-links.md

# SC-6: Confirm all four COV-* rows appear in coverage summary
rg "COV-001|COV-002|COV-003|COV-004" .tasks/001-pm-agent-gap-analysis/evidence/phase-3-coverage-summary.md

# SC-7: Confirm task.md Phase 3 row shows Planned status and plan link
rg "📋 Planned" .tasks/001-pm-agent-gap-analysis/task.md
rg "phase-3-gap-analysis-and-root-cause-isolation.md" .tasks/001-pm-agent-gap-analysis/task.md

# TEST-7: Confirm no placeholder values in Phase 3 artifacts
rg "\b(TBD|TODO|placeholder)\b" .tasks/001-pm-agent-gap-analysis/evidence/phase-3-*.md
```

### Manual Verification Steps

1. Open `evidence/phase-3-gap-register.md` and confirm at least one GAP-* row per domain (coordination, ingestion, planner-output, pm-recommendation) exists with non-placeholder content in all columns.
2. Pick one GAP-* row and trace it: find the referenced FAIL-* or REPRO-* in Phase 1, the referenced BAS-CONTRACT-* in Phase 2, and the corresponding LINK-* in the link table — confirm all three contain substantive content.
3. Open `evidence/phase-3-root-cause-catalog.md` and confirm each observed RC-* entry has a concrete description of the affected VIP artifacts and an explicit remediation priority.
4. Open `evidence/phase-3-coverage-summary.md` and verify COV-001 through COV-004 each list specific GAP-* and RC-* IDs — no domain should show empty or `UNRESOLVED` without a corresponding blocker entry.
5. Confirm no gap row's "Delta Description" field contains only generic language; each must describe a specific instruction, contract, schema, or path difference.

### Success Criteria Verification

- All automated checks return matches with no missing ID categories.
- Manual trace for at least one GAP-* succeeds end-to-end across Phase 1 → Phase 2 → LINK-* map.
- All four acceptance domains show at least one traced gap and one root cause without `UNRESOLVED` status.
- No Phase 3 artifact contains only header rows or placeholder values.

---

## Handoff to Next Phase

Phase 4 (Remediation Options and Decision Package) can begin when SC-1 through SC-7 are satisfied and the root-cause catalog is fully linked to the gap register with no unresolved acceptance-domain coverage gaps.

Phase 4 inputs from this phase:
- `evidence/phase-3-gap-register.md` — supplies the canonical gap inventory
- `evidence/phase-3-root-cause-catalog.md` — defines the remediation target categories with priority ranks
- `evidence/phase-3-gap-rc-links.md` — ensures Phase 4 option scoping addresses root causes not just symptoms
- `evidence/phase-3-coverage-summary.md` — confirms which acceptance domains each option must restore
