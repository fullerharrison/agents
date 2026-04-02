# Phase 4 Root-Cause to Remediation Traceability

| RC ID | RC Category | Priority | Option ID (Targeted) | Option ID (Deferred) | Traceability Rationale | Phase 5 Workstream |
|---|---|---|---|---|---|---|
| RC-001 | PATH-RESOLUTION | Phase4-Critical | REMOPT-A, REMOPT-B | None | Binary-conversion tooling path failure blocks ingestion in GAP-001 and GAP-002; both options require immediate path fix and fallback handling. | Workstream-Ingestion-Path-Fix |
| RC-002 | GATE-MISSING | Phase4-Critical | REMOPT-A, REMOPT-B | None | Missing BAS-GATE-001/002/003 is the coordination blocker behind GAP-007 and contributes to ingestion-state failures in GAP-001 and GAP-002. | Workstream-Conductor-Gates |
| RC-003 | CONFIG-DRIFT | Phase4-High | REMOPT-B | REMOPT-A | VIP PM instruction drift removed BAS-SCHEMA-003 recommendation-block obligation; REMOPT-A defers while REMOPT-B realigns PM instruction behavior. | Workstream-PM-Instruction-Alignment |
| RC-004 | TRIGGER-MISSING | Phase4-High | REMOPT-B | REMOPT-A | Missing BA planning-intent and risk/governance triggers blocks dynamic routing and PM recommendation activation in GAP-004, GAP-005, and GAP-006. | Workstream-Trigger-Predicates |
| RC-005 | FORMAT-CONTRACT | Phase4-Critical | REMOPT-A, REMOPT-B | None | BAS-SCHEMA-001/002/004 omissions cause planner-output failures in GAP-003 and GAP-004; both options include schema conformance updates. | Workstream-Schema-Conformance |
| RC-006 | ROLE-BOUNDARY | Phase4-High | REMOPT-B | REMOPT-A | Planning bypassed BA-to-Scrum-to-Builder boundaries in GAP-003 and GAP-007; REMOPT-A relies on gate substitution while REMOPT-B adds explicit role rules. | Workstream-Role-Boundary-Enforcement |
| RC-007 | PM-TOOL-LOGIC | Phase4-High | REMOPT-B | REMOPT-A | PM framework evaluation loop is absent and causes GAP-005/GAP-006; REMOPT-A defers. REMOPT-B implements framework logic with initial set RAID, RACI, Fishbone and context checks for blockers/stakeholder/governance signals. | Workstream-PM-Tool-Logic |
