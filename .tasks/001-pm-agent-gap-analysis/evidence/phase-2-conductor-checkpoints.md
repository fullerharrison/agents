# Phase 2 Conductor Checkpoints Baseline

| Checkpoint ID | Entry Condition | Pass Criteria | Fail Criteria | Evidence Artifact(s) | Blocking Severity |
|---|---|---|---|---|---|
| BAS-GATE-001 | Task initialization completed and phase structure created. | User-facing Task Created checkpoint presented with explicit continue or abort choice. | Workflow moves to planning without pause and explicit checkpoint response. | BAS-SRC-001, BAS-SRC-010 | High |
| BAS-GATE-002 | Phase plan created and phase-review findings available. | Plan Review Complete checkpoint presented and user approval captured before implementation path. | Builder invocation occurs before plan-review checkpoint approval. | BAS-SRC-001, BAS-SRC-002 | High |
| BAS-GATE-003 | Phase is approved and status transitioned to in-progress. | Implementation runs against approved plan file with status aligned to active phase. | Status drift (planned/reviewed mismatch) or implementation without valid plan path. | BAS-SRC-001, BAS-SRC-003 | High |
| BAS-GATE-004 | Implementation outputs returned and verification evidence produced. | Implementation Complete checkpoint presented with disposition options and review evidence. | Completion asserted without tests/checks output evidence. | BAS-SRC-001, BAS-SRC-004 | High |
| BAS-GATE-005 | Phase accepted as complete. | task.md updated to done state and orchestration advances to next phase or finalization. | Phase marked complete without updating task state source of truth. | BAS-SRC-001, BAS-SRC-003 | Medium |
