# Phase 1 Minimal Repro Scenarios

| Scenario ID | Preconditions | Inputs | Steps | Expected Result | Observed Result | Repro Rate | Evidence Links |
|---|---|---|---|---|---|---|---|
| REPRO-001 (ingestion) | Chat-ingestion workflow enabled; mixed file set includes at least one binary `.make`; learning-base target path available | User prompt equivalent to ingest documents in intake folder | 1. Submit ingestion request for folder containing text + binary `.make` file. 2. Observe handoff to Worker for binary conversion. 3. Track completion state and blocker list. | Structured ingestion completes with explicit artifact writes and no unresolved required-source blockers for required deliverables. | Binary conversion path invoked; intermediate write/tool constraint surfaced; unresolved dependency remained (`ADS-HTP-VIP-Requirements-Matrix.xlsx` pending). | 1/1 in captured evidence | FAIL-001, ART-002:L2090, ART-003:L32614, ART-002:L32082 |
| REPRO-002 (planner output) | Same environment; planning request routed through PM/BA chain | User prompt requesting sprint or implementation plan | 1. Submit planning request. 2. Observe orchestration/delegation sequence. 3. Check for planner-import-friendly output artifact in response chain. | BA outputs planner-import-friendly structure or references concrete artifact with required fields. | Delegation to background agent after isolation error; in-session evidence lacks planner-import-ready output artifact. | 1/1 in captured evidence | FAIL-002, ART-003:L32702, ART-003:request_5ab36e44 response block |
| REPRO-003 (PM-tool recommendation) | Context includes uncertainty, stakeholder coordination risk, and blockers | Export/follow-up request after blocker-rich run context | 1. Run ingestion/planning contexts with unresolved blockers. 2. Ask for follow-up/export response. 3. Inspect for proactive PM framework recommendation content. | At least one justified PM-tool recommendation appears (e.g., RAID log for blockers, RACI for role clarity). | Responses contain status/export summaries and action bullets only; no explicit PM framework recommendation. | 1/1 in captured evidence | FAIL-003, ART-008, ART-002:L4706-L4814 |

## Domain Mapping

- Ingestion domain: REPRO-001
- Planner-output domain: REPRO-002
- PM-tool recommendation domain: REPRO-003
