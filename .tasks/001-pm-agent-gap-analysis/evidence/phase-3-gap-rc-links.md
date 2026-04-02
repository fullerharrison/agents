# Phase 3 Gap-to-Root-Cause Link Table

Many-to-many mapping between GAP-* rows and RC-* rows. Every GAP-* row appears in at least one LINK-* entry. Every observed RC-* row appears in at least one LINK-* entry.

| Link ID | Gap ID | RC ID | Link Rationale | Confidence |
|---|---|---|---|---|
| LINK-001 | GAP-001 | RC-001 | The binary-file tooling path failure (RC-001) is the direct mechanism that prevented the write-path completion in GAP-001; without a working binary-conversion executable the ingestion pipeline cannot reach the artifact-write step. | High |
| LINK-002 | GAP-001 | RC-002 | The absence of a Conductor checkpoint gate (RC-002) means the unresolved dependency in GAP-001 was never surfaced to the user as a blocker before the flow exited; a BAS-GATE-001 compliant checkpoint would have held at the dependency boundary. | High |
| LINK-003 | GAP-002 | RC-001 | REPRO-001 replicated the same path-resolution failure as FAIL-001; RC-001 is therefore the underlying cause of the stateful-progression break documented in GAP-002. | High |
| LINK-004 | GAP-002 | RC-002 | GAP-002's core delta — no user-visible checkpoint before exit with stale state — is the direct behavioural consequence of the missing Conductor gate (RC-002) at the BAS-CONTRACT-010 communication boundary. | High |
| LINK-005 | GAP-003 | RC-005 | The absence of a BAS-SCHEMA-001/002 conformant artifact in the planning chain (GAP-003) is the output manifestation of the format-contract gap (RC-005); the BA and Scrum Master agents did not produce required fields because the schema obligation is not encoded in their VIP instruction content. | High |
| LINK-006 | GAP-003 | RC-006 | The delegation to a background agent instead of routing through the explicit BA→Scrum Master handoff channel (GAP-003) is a direct role-boundary violation (RC-006); BAS-ROLE-005 requires BA to use the Plan Sprint channel, which was not followed. | High |
| LINK-007 | GAP-003 | RC-002 | No user-facing checkpoint was presented before background delegation in the planning flow; this is a BAS-GATE-002 violation captured in GAP-003 and caused by the missing-gate root cause (RC-002). | Medium |
| LINK-008 | GAP-004 | RC-005 | REPRO-002 confirms the same end-to-end absence of BAS-SCHEMA-001/002 conformant output fields that GAP-003 identifies; RC-005 is the common format-contract cause driving both GAP-003 and GAP-004. | Medium |
| LINK-009 | GAP-004 | RC-004 | The BA planning-intent trigger (BAS-TRIG-006 equivalent) is absent (RC-004); because the trigger predicate does not fire, the BA agent never routes to Scrum Master, which is why GAP-004 records no artifact path reference or plan save. | Medium |
| LINK-010 | GAP-005 | RC-007 | The PM recommendation evaluation loop is entirely absent from the VIP agent (RC-007); GAP-005 records the observable result — qualifying context present, recommendation block absent — which is the direct output of that logic gap. | High |
| LINK-011 | GAP-005 | RC-003 | The VIP instruction configuration does not include the BAS-SCHEMA-003 block obligation (RC-003); GAP-005's delta is co-caused by the instruction content divergence that removed or never added the schema-driven emission requirement. | High |
| LINK-012 | GAP-006 | RC-007 | REPRO-003 reproduced the no-recommendation result 1/1; RC-007 (absent PM-tool evaluation loop) is the confirmed causal mechanism; GAP-006 is the reproduced manifestation. | High |
| LINK-013 | GAP-006 | RC-004 | The risk/governance-context trigger condition that should activate the recommendation output path is absent (RC-004); without that trigger predicate, the qualifying signals in REPRO-003 cannot reach the recommendation logic even if it existed. | High |
| LINK-014 | GAP-007 | RC-002 | Background-agent delegation in the planning scenario bypassed the BAS-GATE-002 and BAS-GATE-003 checkpoint sequence; RC-002 (missing Conductor gates) is the structural cause enabling the bypass documented in GAP-007. | Medium |
| LINK-015 | GAP-007 | RC-006 | The planning delegation in GAP-007 occurred without completing the required review-and-approval sequence; delegating outside the established Conductor checkpoint chain constitutes the role-boundary violation (RC-006) at the orchestration layer. | Medium |

---

## Orphan Check

| ID Type | IDs present | Appears in LINK-* | Status |
|---|---|---|---|
| GAP-001 | ✓ | LINK-001, LINK-002 | Covered |
| GAP-002 | ✓ | LINK-003, LINK-004 | Covered |
| GAP-003 | ✓ | LINK-005, LINK-006, LINK-007 | Covered |
| GAP-004 | ✓ | LINK-008, LINK-009 | Covered |
| GAP-005 | ✓ | LINK-010, LINK-011 | Covered |
| GAP-006 | ✓ | LINK-012, LINK-013 | Covered |
| GAP-007 | ✓ | LINK-014, LINK-015 | Covered |
| RC-001 | ✓ | LINK-001, LINK-003 | Covered |
| RC-002 | ✓ | LINK-002, LINK-004, LINK-007, LINK-014 | Covered |
| RC-003 | ✓ | LINK-011 | Covered |
| RC-004 | ✓ | LINK-009, LINK-013 | Covered |
| RC-005 | ✓ | LINK-005, LINK-008 | Covered |
| RC-006 | ✓ | LINK-006, LINK-015 | Covered |
| RC-007 | ✓ | LINK-010, LINK-012 | Covered |

No orphaned GAP-* or RC-* entries.
