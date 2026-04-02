# Phase 4 Remediation Decision Matrix

## Comparison Table

| Attribute | REMOPT-A (Critical-Path Patch) | REMOPT-B (Comprehensive Realignment) |
|---|---|---|
| Effort | Moderate (250-350 lines) | High (700-1000 lines) |
| Risk Level | Lower | Higher |
| Timeline | 2-3 weeks | 4-6 weeks |
| Coordination Domain | ✅ Full | ✅ Full |
| Ingestion Domain | ✅ Full | ✅ Full |
| Planner-Output Domain | ✅ Full | ✅ Full |
| PM-Recommendation Domain | ⚠️ Partial/Deferred | ✅ Full |
| Baseline Parity | 75% | 100% |
| Rollback Complexity | Low | High |
| Production Risk | Lower (additive changes, tested patterns) | Higher (distributed changes, novel logic) |
| Key Trade-off | Defers PM-tool logic; fast restoration of coordination, ingestion, and planner-output | Full restoration across all domains with longer timeline and higher integration risk |
| Selection Recommendation Flag | Candidate for constrained timelines | Recommended |

## Decision Guidance

- Choose REMOPT-A if timeline pressure is acute (2-3 weeks), risk tolerance is conservative, and PM-Recommendation behavior can be deferred.
- Choose REMOPT-B if baseline parity is mandatory, all acceptance domains must be fully met, and 4-6 weeks are available for phased rollout and validation.

## Recommended Option

Recommended Option: REMOPT-B based on full acceptance-domain coverage, complete RC-001 through RC-007 remediation, and direct alignment to baseline-parity goals.
