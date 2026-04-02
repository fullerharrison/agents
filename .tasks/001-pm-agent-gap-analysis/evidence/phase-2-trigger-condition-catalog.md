# Phase 2 Trigger Condition Catalog

| Trigger ID | Trigger Predicate | Required Preconditions | Forbidden States | Expected Next Role/Action | Evidence Source |
|---|---|---|---|---|---|
| BAS-TRIG-001 | Conductor receives any message while running orchestrated flow. | .tasks directory must be readable and task state resolvable. | Responding before task-state resolution. | Resolve task state, then branch to initialization or resume flow. | BAS-SRC-001 |
| BAS-TRIG-002 | User asks for new work and no matching task exists. | Slug generation and task numbering context available. | Skipping task creation and researching directly. | Delegate to Explorer to create task and phased plan. | BAS-SRC-001, BAS-SRC-002 |
| BAS-TRIG-003 | Next phase is unplanned and status is not started. | task.md phase table present with next phase identified. | Invoking Builder before plan/review checkpoint. | Delegate planning to Explorer for phase plan creation. | BAS-SRC-001 |
| BAS-TRIG-004 | Plan review output returned for current phase. | Review findings attached to phase and checkpoint options ready. | Auto-continuation without explicit user approval. | Pause at plan-review checkpoint and wait for user decision. | BAS-SRC-001 |
| BAS-TRIG-005 | Phase approved for implementation. | Current phase status is reviewed or in-progress and plan path exists. | Starting implementation on planned-only status without approval. | Transition status to in-progress and invoke Builder. | BAS-SRC-001, BAS-SRC-003 |
| BAS-TRIG-006 | Business Analyst receives requirement-to-planning intent. | Requirement artifacts have been written with sufficient scope detail. | Returning no planning route when sprint plan was requested. | Handoff to Scrum Master using Plan Sprint channel. | BAS-SRC-005, BAS-SRC-006 |
| BAS-TRIG-007 | Scrum Master has saved plan and user requests execution. | Saved plan path exists and implementation boundary is clear. | Invoking implementation before plan artifact exists. | Handoff to Builder using Implement Phase channel. | BAS-SRC-006 |
