# Phase 1 Artifact Inventory

| Artifact ID | Source Path | Type | Date (UTC) | Relevant Agent(s) | Related Requirement Domain | Captured At (UTC) | Immutable Identifier/Hash | Hash Algorithm | Exception Reason | Notes |
|---|---|---|---|---|---|---|---|---|---|---|
| ART-001 | C:/Users/s1058662/OneDrive - Syngenta/workspace/Projects/2026_01_VIP/.tasks/005-pm-agent-system/task.md | Markdown task record | 2026-03-19T21:34:26Z | ProjectManager, ProductOwner, BusinessAnalyst | coordination | 2026-03-19T22:17:00Z | 14E2F4CE81FB5DF6A8DF6FE91536AA244DB6903C4C0C7D02077CA04A07B6F138 | SHA256 | N/A | Defines expected orchestration and required role behavior |
| ART-002 | C:/Users/s1058662/OneDrive - Syngenta/workspace/Projects/2026_01_VIP/learning_base/ideas/chat_logs/pm_agent_improvements/document_ingestion_and_processing_request.json | Chat export JSON | 2026-03-19T22:16:35Z | ProductOwner, Worker, Builder | ingestion, coordination | 2026-03-19T22:20:22Z | 7A104598ED54FE20C46F52C0212DB7A667F8A36818BC5B6A6FDC670A30D26147 | SHA256 | N/A | Contains ingestion request, binary-file handoff requirement, and status responses |
| ART-003 | C:/Users/s1058662/OneDrive - Syngenta/workspace/Projects/2026_01_VIP/learning_base/ideas/chat_logs/pm_agent_improvements/document_ingestion_and_processing_request_2.json | Chat export JSON | 2026-03-19T22:20:22Z | ProductOwner, Worker, Builder, CLI agent | coordination, planner output, PM-tool recommendations | 2026-03-19T22:20:22Z | A5291E40F6ADB0C91989A14D36A7C66D7645E2757DA7F67614C81A24369A6860 | SHA256 | N/A | Contains worker conversion details, planning request, and incomplete planning handoff outcome |
| ART-004 | C:/Users/s1058662/Downloads/Test - agent planner (3).xlsx | Planner workbook sample | 2026-03-18T10:36:59Z | BusinessAnalyst | planner output | 2026-03-19T22:16:59Z | 517B016033A4B877E78EB97600B87ABC063A1BB4B7C5AD5E3989852DAC2DC8C9 | SHA256 | N/A | Target format anchor for planner-import-friendly output expectation |
| ART-005 | ART-002 lines 4706, 4742, 4778, 4886 | Extracted event set | 2026-03-19 | ProductOwner, BusinessAnalyst | ingestion, coordination | 2026-03-19T22:42:00Z | Derived from ART-002 | N/A | Derived evidence | Shows requirement to review workflows, blocked mock-up sharing, and SME gating |
| ART-006 | ART-003 lines 6, 19433, 32702, 33091 | Extracted session markers | 2026-03-19 | ProjectManager, CLI agent | coordination | 2026-03-19T22:50:00Z | Derived from ART-003 | N/A | Derived evidence | Confirms distinct sessions and delegation transitions |
| ART-007 | ART-003 request_5ab36e44 response block | Extracted planning handoff evidence | 2026-03-19 | BusinessAnalyst, CLI agent | planner output | 2026-03-19T22:50:00Z | Derived from ART-003 | N/A | Derived evidence | Planning request delegated; no validated planner-import output captured in same flow |
| ART-008 | ART-003 request_73d2d5ce response block | Extracted export response evidence | 2026-03-19 | ProjectManager, ProductOwner | PM-tool recommendations | 2026-03-19T22:50:00Z | Derived from ART-003 | N/A | Derived evidence | Response exports chat, but no proactive PM framework recommendation present |

## Coverage Notes by Requirement Domain

- coordination: ART-001, ART-002, ART-003, ART-006
- ingestion: ART-002, ART-005
- planner output: ART-004, ART-007
- PM-tool recommendations: ART-003, ART-008
