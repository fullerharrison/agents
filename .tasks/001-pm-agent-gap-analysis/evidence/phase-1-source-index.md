# Phase 1 Source Index

## Scope and ID Conventions

- Source IDs: SRC-*
- Artifact IDs: ART-*
- Event IDs: EVT-*
- Failure IDs: FAIL-*
- Repro IDs: REPRO-*
- Contingency IDs: CONT-*
- Partial package IDs: PKG-*

## Provenance Requirements

Every source row includes:

- Captured At (UTC)
- Immutable Identifier/Hash (or Exception Reason)
- Hash Algorithm (if hash exists)

## External Source Path List

| Source ID | Source Path | Access Status | Captured At (UTC) | Immutable Identifier/Hash | Hash Algorithm | Exception Reason |
|---|---|---|---|---|---|---|
| SRC-VIP-001 | C:/Users/s1058662/OneDrive - Syngenta/workspace/Projects/2026_01_VIP/.tasks/005-pm-agent-system | Accessible | 2026-03-19T22:16:56Z | Directory snapshot + file metadata captured | N/A | Directory-level source |
| SRC-CHAT-001 | C:/Users/s1058662/OneDrive - Syngenta/workspace/Projects/2026_01_VIP/learning_base/ideas/chat_logs/pm_agent_improvements/document_ingestion_and_processing_request.json | Accessible | 2026-03-19T22:20:22Z | 7A104598ED54FE20C46F52C0212DB7A667F8A36818BC5B6A6FDC670A30D26147 | SHA256 | N/A |
| SRC-CHAT-002 | C:/Users/s1058662/OneDrive - Syngenta/workspace/Projects/2026_01_VIP/learning_base/ideas/chat_logs/pm_agent_improvements/document_ingestion_and_processing_request_2.json | Accessible | 2026-03-19T22:20:22Z | A5291E40F6ADB0C91989A14D36A7C66D7645E2757DA7F67614C81A24369A6860 | SHA256 | N/A |
| SRC-PLAN-001 | C:/Users/s1058662/Downloads/Test - agent planner (3).xlsx | Accessible | 2026-03-19T22:16:59Z | 517B016033A4B877E78EB97600B87ABC063A1BB4B7C5AD5E3989852DAC2DC8C9 | SHA256 | N/A |
| SRC-CHAT-003 | C:/Users/s1058662/OneDrive - Syngenta/workspace/Projects/2026_01_VIP/learning_base/ideas/chat_logs/pm_agent_improvements/combined-log.txt | Inaccessible | 2026-03-19T22:54:37Z | None | N/A | Missing path; two access attempts logged in contingency file |

## File-Level Capture Metadata

| Source ID | File Name | Last Modified (UTC) | Size (bytes) | Captured At (UTC) | Immutable Identifier/Hash | Hash Algorithm | Notes |
|---|---|---|---:|---|---|---|---|
| SRC-VIP-001 | task.md | 2026-03-19T21:34:26Z | 18239 | 2026-03-19T22:17:00Z | 14E2F4CE81FB5DF6A8DF6FE91536AA244DB6903C4C0C7D02077CA04A07B6F138 | SHA256 | Primary PM-system task record used for expected orchestration context |
| SRC-VIP-001 | artifacts/phase-11/e2e-execution-log.md | 2026-03-19T19:42:11Z | 11591 | 2026-03-19T22:17:00Z | Not computed | N/A | Metadata captured from directory snapshot |
| SRC-VIP-001 | artifacts/phase-11/pilot-readiness-report.md | 2026-03-19T19:42:11Z | 9816 | 2026-03-19T22:17:00Z | Not computed | N/A | Metadata captured from directory snapshot |
| SRC-VIP-001 | plan/phase-5-projectmanager-orchestration-layer.md | 2026-03-18T23:32:47Z | 69323 | 2026-03-19T22:17:00Z | Not computed | N/A | Used as expected orchestrator behavior reference |
| SRC-CHAT-001 | document_ingestion_and_processing_request.json | 2026-03-19T22:16:35Z | 1976531 | 2026-03-19T22:20:22Z | 7A104598ED54FE20C46F52C0212DB7A667F8A36818BC5B6A6FDC670A30D26147 | SHA256 | Session and handoff evidence for ingestion flow |
| SRC-CHAT-002 | document_ingestion_and_processing_request_2.json | 2026-03-19T22:20:22Z | 1976366 | 2026-03-19T22:20:22Z | A5291E40F6ADB0C91989A14D36A7C66D7645E2757DA7F67614C81A24369A6860 | SHA256 | Session and handoff evidence for worker and planning flow |
| SRC-PLAN-001 | Test - agent planner (3).xlsx | 2026-03-18T10:36:59Z | 4283 | 2026-03-19T22:16:59Z | 517B016033A4B877E78EB97600B87ABC063A1BB4B7C5AD5E3989852DAC2DC8C9 | SHA256 | Planner format reference used for output compatibility expectation |

## Inclusion and Exclusion Rationale

- Included:
  - VIP PM-system task and artifact files needed to establish expected orchestration and output behavior.
  - Two chat-log JSON captures containing observed interactions, tool outcomes, and delegation behavior.
  - Planner workbook reference file for import-format compatibility context.
- Excluded:
  - Optional external web references from task scope (not required to establish reproducible local failures in Phase 1).
  - Non-evidentiary generated prompt boilerplate lines that do not affect handoff/failure outcomes.
