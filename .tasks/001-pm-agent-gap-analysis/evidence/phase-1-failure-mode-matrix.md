# Phase 1 Failure-Mode Matrix

| Failure ID | Trigger Context | Expected Behavior | Observed Behavior | Severity | Frequency | Evidence References |
|---|---|---|---|---|---|---|
| FAIL-001 | Ingestion flow with mixed attachments, including binary `.make` source | ProjectOwner/ProductOwner pipeline should complete structured learning-base ingestion with explicit completion state and no unresolved dependency blockers for required inputs | Binary handoff required; intermediate file-write/tooling error observed; dependency remained unresolved (`ADS-HTP-VIP-Requirements-Matrix.xlsx` pending) | High | Repeated in captured ingestion run | ART-002:L2090, ART-002:L32082, ART-003:L32614, ART-003:L32580-L33260 |
| FAIL-002 | User requests sprint/implementation plan output aligned to downstream planning workflow | Business Analyst pathway should return planner-import-friendly, field-stable output or explicit artifact link in-session | Planning request delegated to background agent after isolation failure; no validated planner-import-friendly artifact returned in captured chain | High | Observed in session SESS-02 | ART-003:L32702, ART-003:request_5ab36e44 response block, ART-007 |
| FAIL-003 | Context contains governance uncertainty, stakeholder alignment risk, and unresolved blockers | PM layer should proactively recommend at least one applicable PM framework (e.g., RACI, RAID, Ishikawa, DACI/RAPID, stakeholder analysis, charter) | Response/export activity did not include explicit framework recommendation despite blocker-heavy context | Medium | Observed across SESS-02 and SESS-03 snapshots | ART-003:L33091, ART-008, ART-002:L4706-L4814 |

## Severity/Frequency Legend

- Severity: High = directly blocks acceptance domains; Medium = materially degrades decision quality.
- Frequency: derived only from captured sessions; broader rate requires later-phase repetition tests.
