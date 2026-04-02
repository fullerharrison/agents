# Phase 4 Remediation Option Scope Matrix

| Option ID | Option Name | RC IDs Targeted | RC IDs Deferred | Gap IDs Fully Addressed | Gap IDs Partially Addressed | Acceptance Domains Addressed | Out-of-Scope Decisions | Option Characterization |
|---|---|---|---|---|---|---|---|---|
| REMOPT-A | Critical-Path Patch | RC-001, RC-002, RC-005 | RC-003, RC-004, RC-006, RC-007 | GAP-001, GAP-002, GAP-003, GAP-004, GAP-007 | GAP-005, GAP-006 | Coordination, Ingestion, Planner-Output | No refactoring of learning-base write paths; PM logic deferred; role-boundary enforcement delegated to gate logic | Tactical patch addressing 3 critical RCs; unblocks 3/4 acceptance domains; lower timeline risk |
| REMOPT-B | Comprehensive Baseline Realignment | RC-001, RC-002, RC-003, RC-004, RC-005, RC-006, RC-007 | None | GAP-001, GAP-002, GAP-003, GAP-004, GAP-005, GAP-006, GAP-007 | None | Coordination, Ingestion, Planner-Output, PM-Recommendation | None | Strategic realignment of full PM agent orchestration; achieves baseline parity; higher implementation risk |

## Option Package Notes

### REMOPT-A Package

- Intent: Stabilize core orchestration, ingestion, and planner-output quickly with limited blast radius.
- Critical RCs covered: RC-001, RC-002, RC-005.
- Residual gap: PM-Recommendation domain remains deferred and requires follow-on implementation.

### REMOPT-B Package

- Intent: Restore complete baseline parity across all Phase 3 root causes.
- RCs covered: RC-001 through RC-007.
- Outcome target: Full coverage of all 4 acceptance domains with no deferred root-cause domains.
