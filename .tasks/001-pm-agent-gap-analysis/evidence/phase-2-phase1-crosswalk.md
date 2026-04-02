# Phase 2 Phase 1 Crosswalk

| Crosswalk ID | Phase 1 Failure/Repro ID | Domain | Baseline Contract IDs | Comparison Notes |
|---|---|---|---|---|
| BAS-XREF-001 | FAIL-001 | ingestion | BAS-CONTRACT-002, BAS-CONTRACT-008, BAS-CONTRACT-009 | Baseline requires persisted artifact writes and explicit role handoff continuity; Phase 1 ingestion failure indicates handoff and completion-state fragility to compare in Phase 3. |
| BAS-XREF-002 | REPRO-001 | ingestion | BAS-CONTRACT-002, BAS-CONTRACT-004, BAS-CONTRACT-010 | Repro path maps to baseline requirement for stateful checkpointed progression and explicit completion signaling before return-to-user. |
| BAS-XREF-003 | FAIL-002 | planner-output | BAS-CONTRACT-008, BAS-CONTRACT-009, BAS-CONTRACT-010 | Baseline BA-to-Scrum-to-Builder contract expects plan artifact and execution handoff; observed planner artifact absence becomes direct contract mismatch candidate. |
| BAS-XREF-004 | REPRO-002 | planner-output | BAS-CONTRACT-008, BAS-CONTRACT-009 | Baseline planner path demands saved planning outputs before or during execution handoff; repro captured missing planner-ready output to validate against BAS-SCHEMA-001 and BAS-SCHEMA-002. |
| BAS-XREF-005 | FAIL-003 | pm-recommendation | BAS-CONTRACT-010 | Baseline user return contract plus risk/stakeholder schema expectation implies recommendation-ready response block should appear when governance risk context is present. |
| BAS-XREF-006 | REPRO-003 | pm-recommendation | BAS-CONTRACT-010 | Repro scenario maps to baseline response completion contract; Phase 3 should verify whether recommendation block defined by BAS-SCHEMA-003 was omitted under qualifying context. |
| BAS-XREF-007 | FAIL-002 | coordination handoffs | BAS-CONTRACT-001, BAS-CONTRACT-003, BAS-CONTRACT-005, BAS-CONTRACT-007 | Isolation and async delegation behavior in Phase 1 should be compared against required checkpointed progression and reviewed-plan execution contract. |
