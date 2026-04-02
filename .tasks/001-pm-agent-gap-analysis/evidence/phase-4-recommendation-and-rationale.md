# Phase 4 Recommendation and Rationale

## Selected Option

REMOPT-B - Comprehensive Baseline Realignment

## Selection Rationale

REMOPT-B is selected because the task acceptance criteria require full restoration of all four domains: coordination, ingestion, planner-output, and PM-recommendation behavior. Phase 3 evidence shows these domains are interdependent through RC-001 through RC-007.

1. Acceptance criteria completeness:
- Coordination and ingestion depend on RC-002 gate enforcement and RC-001 path resolution.
- Planner-output requires RC-005 schema conformance and RC-004 trigger routing.
- PM-recommendation requires RC-003 instruction alignment plus RC-004 trigger activation plus RC-007 evaluation logic.

2. Phase 3 evidence alignment:
- Phase 3 root-cause catalog confirms all seven categories are observed and active.
- Phase 3 gap-RC links show each acceptance domain is blocked by at least one deferred RC under REMOPT-A.

3. Baseline-parity objective:
- REMOPT-B is the only option with full RC-001 through RC-007 coverage and full alignment to baseline contract obligations.

4. Full baseline-parity feasibility with phased risk mitigation:
- Full baseline parity remains achievable through phased implementation sequencing (RC-001/RC-002 foundation, RC-003/RC-004 behavior activation, RC-005/RC-006 output and contract alignment, RC-007 recommendation evaluation hardening) while controlling rollout risk via stage-gated validation.

## Explicit REMOPT-A Residual-Gap Acknowledgment

REMOPT-A intentionally defers the PM-Recommendation domain. This leaves a known residual gap: proactive PM framework recommendation behavior is not operational and still requires manual PM intervention. Specifically, GAP-005 and GAP-006 remain only partially covered under REMOPT-A until RC-003, RC-004, and RC-007 are implemented.

| Acceptance Domain | Coverage | Residual Gap | Resolution Path |
| --- | --- | --- | --- |
| PM-Recommendation | ❌ Deferred | Proactive framework recommendation logic absent | Phase 6 enhancement after production validation |

## Expected Outcome by Acceptance Domain

- Coordination: full Conductor checkpoint enforcement and explicit BA-to-Scrum-to-Builder progression.
- Ingestion: binary path resolution fixed and blocker-state communication made explicit.
- Planner-output: BAS-SCHEMA-001/002/004-compliant outputs suitable for planner-import workflow.
- PM-recommendation: active context evaluation and proactive framework recommendation output (initial set: RAID, RACI, Fishbone, with extensibility to DACI/RAPID, stakeholder analysis, and charter recommendation patterns).

## Residual Risk

- Integration edge cases may appear when gates, triggers, and PM-tool logic are enabled together.
- PM framework context classification may need iterative tuning after first deployment cycle.
- Rollback remains more complex than REMOPT-A due to distributed changes.

## Implementation Readiness Check

- Tool/path constraints: no critical blockers identified for implementing RC-001 path fixes.
- Conductor gate framework: baseline precedent exists and is reusable.
- Trigger predicates: implementation pattern is known from baseline routing behavior.
- PM recommendation logic: output contract and context signals are defined and implementable.
- Overall readiness: implementation-ready for Phase 5 workstream decomposition.
