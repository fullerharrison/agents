---
artifact: phase-8-source-traceability-matrix
task: 005-pm-agent-system
phase: 8
created: 2026-03-18
status: complete
checkpoint: CP-8.7
sources:
  - .tasks/005-pm-agent-system/plan/phase-8-pilot-validation-integration-testing.md (Source Traceability Matrix section, REQ-808)
  - .tasks/005-pm-agent-system/task.md (all phases)
---

# Phase 8 Artifact: Source Traceability Matrix

## Purpose

This document maps every Phase 8 validation scenario and test case to the source phase, source document, source design decision (rule or contract), and an implementation note aligned to `agents-personal/templates/README.md` or approved ADR guidance. Required by REQ-808.

---

## Traceability Matrix

| Scenario / Rule | Source Phase | Source Document | Source Clause / Decision ID | Implementation Note |
| --- | --- | --- | --- | --- |
| **E2E-01** Resource Ingestion — Mixed Inputs | Phase 4, Phase 5 | `task.md` Phase 4 detail; Phase 5 Workflow A routing | REQ-406 (Worker conversion); Phase 5 Workflow A entry gate and CP-A1/A2/A3 | Exercises PO→Worker conversion boundary and three-resource classification path; Worker binary conversion must use explicit invocation instruction naming target path |
| **E2E-02** Stakeholder Feedback to VoC | Phase 4, Phase 5 | `task.md` Phase 4 REQ-404; Phase 5 Workflow B; WFC-B | PO→BA handoff; PM feedback gate at CP-B3; cascade trigger decision | Exercises Phase 4 PO→BA handoff contract and Phase 5 feedback workflow checkpoint; VoC template sections from Phase 2 skill contracts |
| **E2E-03** Requirements Cascade Update (hard-gate) | Phase 4, Phase 5, Phase 6 | `task.md` Phase 4 REQ-404; Phase 5 Workflow C; Phase 6 Tier R constraints | BA cascade analysis; FrontendDev/BackendDev advisory-only; CP-C1/C2/C3 | Advisors must remain read-only throughout cascade under all conditions; BA is sole requirements doc writer; Tier R constraints from Phase 6 master permission table |
| **E2E-04** Diagram Lifecycle (hard-gate) | Phase 3, Phase 5 | Phase 3 REQ-304; `.github/copilot-instructions.md`; Phase 5 Workflow D | UIUXDesigner four-step Mermaid lifecycle; CP-D1/D2/D3/D4; Tier RW-D boundary | All four lifecycle steps mandatory; UIUXDesigner is sole diagram writer; render script is only permitted execute tool for UIUXDesigner; manifest update mandatory |
| **E2E-05** Backlog Planning — Sprint Preparation | Phase 4, Phase 5, Phase 7 | `task.md` Phase 5 backlog workflow; Phase 7 WFC-E; Phase 7 planner compatibility spec | SM sprint plan; QA test stub; CP-E1/E2/E3/E4; 22-column CSV schema | Sprint artifacts must match Phase 7 planner compatibility spec; 22 columns verified; QA test stub must be linked in sprint artifact |
| **E2E-06** Quality Gate Review Loop (hard-gate) | Phase 5, Phase 7 | Phase 5 Workflow F; WFC-F; Phase 5 CP-F3 quality gate | PM gate decision; PASS/FAIL routing; re-gate before planning-state change | Full PASS and FAIL branch coverage required; re-gate is mandatory before any planning-state change; FAIL path requires advisory step and BA revised plan |
| **PB-01** PM forbidden edit | Phase 5, Phase 6 | Phase 5 REQ-501; Phase 6 Tier O definition | PM disallowedTools: `edit/editFiles`, `edit/createFile`, `terminal/runInTerminal` | Orchestration-only tier; `disable-model-invocation: true` for PM; enforced by `conductor.template.md` frontmatter pattern |
| **PB-02** FrontendDev forbidden write | Phase 3, Phase 6 | Phase 3 REQ-303; Phase 6 Tier R definition | FrontendDev disallowedTools: `edit/editFiles`, `edit/createFile`, `Bash`, `Write`, `Edit`, `MultiEdit` | Read-only advisory; Tier R established in Phase 3 template; verified in Phase 6 cross-agent consistency check |
| **PB-03** BackendDev forbidden Bash | Phase 3, Phase 6 | Phase 3 REQ-303; Phase 6 Tier R definition | BackendDev disallowedTools: `Bash`, `Write`, `Edit` | Same Tier R as FrontendDev; Bash disallowed for all read-only advisors |
| **PB-04** QAEngineer forbidden file edit | Phase 3, Phase 6 | Phase 3 REQ-303; Phase 6 Tier RE definition | QAEngineer disallowedTools: `Write`, `Edit`, `MultiEdit`; permitted: test execution tools | Tier RE: read + execute (test tools only); file edits disallowed |
| **PB-05** QAEngineer permitted test execution | Phase 3, Phase 6 | Phase 3 REQ-303; Phase 6 Tier RE definition | QAEngineer permitted tools: `pytest`, `jest`, `npm test`, `dotnet test`, coverage scripts | Verify positive case: test execution proceeds without file-edit disallowance triggering |
| **PB-06** UIUXDesigner forbidden `docs/` write | Phase 3, Phase 6 | Phase 3 REQ-304; Phase 6 Tier RW-D definition | UIUXDesigner write boundary: `diagrams/`, `images/diagrams/`; `docs/` write allowed for image-ref insertion only | Phase 6 Write-Path Partition Table: UIUXDesigner inserts image refs only; does not create new `docs/` files |
| **PB-07** UIUXDesigner permitted diagram write | Phase 3, Phase 6 | Phase 3 REQ-304; Phase 6 Tier RW-D definition | UIUXDesigner permitted write: `images/diagrams/`; `.mmd` source files | Positive case: confirms Tier RW-D boundary is correctly scoped (not over-restricted) |
| **PB-08** ProductOwner forbidden Bash | Phase 4, Phase 6 | Phase 4 REQ-402; Phase 6 Tier W definition | PO disallowedTools: `Bash`, `terminal/runInTerminal` | PO→Worker conversion contract: PO delegates binary conversion; PO never executes Bash |
| **PB-09** Worker uninvoked write blocked | Phase 6 | Phase 6 Worker Tier-F edge case; Phase 6 Authorship Accountability Rule | Worker Tier-F condition 1 (explicit invocation absent) | Worker scope violation: uninvoked write to requirements path must be blocked; Worker must escalate to PM |
| **PB-10** PM forbidden Task() dispatch | Phase 5, Phase 6 | Phase 5 REQ-501; Phase 6 Tier O; `conductor.template.md` | PM disallowedTools (CC): `Task`; PM uses handoff-button pattern only | ADR-001 conductor pattern: PM orchestrates via handoff buttons, not subagent Task() calls |
| **PB-11** FrontendDev advisory in cascade (hard-gate) | Phase 5, Phase 6 | Phase 5 Workflow C; Phase 6 Tier R; REQ-802 | FrontendDev disallowedTools active during Workflow C; BA is sole writer | REQ-802 explicitly requires PB-11 as targeted advisor-constraint scenario for Tier F and Tier R validation in E2E-03 context |
| **PB-12** BackendDev advisory in cascade (hard-gate) | Phase 5, Phase 6 | Phase 5 Workflow C; Phase 6 Tier R; REQ-802 | BackendDev disallowedTools active during Workflow C | Same mandatory advisor-constraint requirement as PB-11 for BackendDev |
| **CS-01** CP-4.1 PO Role Charter | Phase 4 | `task.md` Phase 4; Phase 4 plan CP-4.1 | PO role charter non-overlap confirmation | Phase 4 governance checkpoint; validates PO role boundaries do not duplicate BA or SM |
| **CS-02** CP-4.4 Worker vs PO Boundary | Phase 4 | Phase 4 plan CP-4.4; Phase 4 worker-vs-PO conversion matrix | Worker handles .docx/.eml; PO handles already-markdown | Phase 4 conversion decision matrix enforces boundary at input classification |
| **CS-03** CP-5.1 Feedback Intake Gate | Phase 5 | Phase 5 plan CP-5.1; Phase 5 Workflow B | PM pause after VoC structuring; BA cascade requires checkpoint approval | Phase 5 checkpoint table; approval required before BA cascade begins |
| **CS-04** CP-5.2 Requirements Cascade Gate | Phase 5 | Phase 5 plan CP-5.2; Phase 5 Workflow C | PM presents flagging list; BA waits for approval before editing | Phase 5 checkpoint; BA must not update before gate resolves |
| **CS-05** CP-5.3 Unknown Workflow Fallback | Phase 5 | Phase 5 plan CP-5.3; Phase 5 orchestration routing matrix | PM unknown-workflow fallback message; no silent delegation | Phase 5 routing matrix defines fallback for unrecognised trigger phrases |
| **CS-06** CP-5.4 Backlog Prioritization Gate | Phase 5 | Phase 5 plan CP-5.4; Phase 5 Workflow E | SM waits for PO MoSCoW-complete confirmation before breakdown | Phase 5 checkpoint; SM breakdown only starts after PO confirms completion |
| **CS-07** CP-5.6 Quality Gate Decision (mandatory) | Phase 5 | Phase 5 plan CP-5.6; Phase 5 Workflow F | PM gate decision: PASS→SM planning update; FAIL→escalation | ADR-007 rationalization prevention: PM must not skip gate and assume outcome; observable gate decision required |
| **CS-08** CP-3.3 UIUXDesigner Lifecycle (mandatory) | Phase 3 | Phase 3 plan CP-3.3; `.github/copilot-instructions.md` | All four diagram lifecycle steps logged before workflow close | Phase 3 diagram governance; four steps are mandatory and logged; skipping any step violates Phase 3 REQ-304 |
| **CS-09** CP-5.8 Source Alignment Boundary Check | Phase 5 | Phase 5 plan CP-5.8; Phase 8 CON-802 | All Phase 8 targets within `.tasks/`; no writes to `agents-personal` or production paths | CON-802: all writes during planning phase restricted to `.tasks/005-pm-agent-system/**` |
| **CS-10** Phase 8 Pilot Recommendation Gate (mandatory) | Phase 8 | Phase 8 plan CS-10; REQ-807 | Evidence E1–E7 complete before go/conditional-go/hold decision | ADR-007: pilot recommendation must be evidence-based; CS-10 gate blocks recommendation without complete evidence |
| **QG-PASS path** Quality Gate PASS | Phase 5 | Phase 5 Workflow F; WFC-F; Phase 5 CP-F3/F4 | QA PASS: 0 critical failures AND ≥80% coverage → SM planning update | Quantitative thresholds from Phase 8 plan stream S-QG; zero advisory invocation on PASS path |
| **QG-FAIL path** Quality Gate FAIL | Phase 5 | Phase 5 Workflow F; WFC-F FAIL escalation | QA FAIL: ≥1 critical failure → FE+BE advisory (0 writes) → BA revised plan → re-gate | Re-gate before planning-state change is mandatory; FAIL path advisor constraint tested under escalation pressure (ADR-007) |
| **AC-01** Resource classification record | Phase 2, Phase 5 | Phase 2 skill contracts; Phase 5 Workflow A output schema | Title, source, date, category, priority, related-requirement IDs | Phase 2 ingestion skill contract defines required metadata fields |
| **AC-02** VoC record (mandatory) | Phase 2, Phase 5, Phase 7 | Phase 2 stakeholder-feedback skill; WFC-B output schema | VoC template sections: segment, feedback summary, guardrails, implications, priority score | Phase 7 WFC-B output schema defines template; MoSCoW priority score is required field |
| **AC-03** Requirements cascade update (mandatory) | Phase 2, Phase 5, Phase 7 | Phase 2 requirements-cascade skill; WFC-C output schema | In-place update; change summary appended; no unrelated sections modified | Phase 7 WFC-C: requirements doc updated in `learning_base/02_requirements/`; cascade impact report produced |
| **AC-04** Diagram `.mmd` source | Phase 3, Phase 7 | Phase 3 diagram lifecycle; WFC-D output schema | `NN_snake_case.mmd` naming; valid Mermaid syntax | `.github/copilot-instructions.md` defines `NN_` naming convention; Phase 3 REQ-304 |
| **AC-05** Diagram rendered `.png` | Phase 3, Phase 7 | Phase 3 diagram lifecycle; WFC-D output schema | 4× scale PNG; produced by `render_mermaid_diagrams.ps1` | Render script is the only permitted execution tool for UIUXDesigner; 4× scale defined in copilot-instructions |
| **AC-06** Groomed backlog artifact | Phase 5, Phase 7 | Phase 5 Workflow E; WFC-E output schema | MoSCoW priorities, phase alignment, effort estimates, dependency links | Phase 7 planner compatibility spec; MoSCoW values from Phase 5 PO skill |
| **AC-07** Sprint plan artifact | Phase 5, Phase 7 | Phase 5 Workflow E; WFC-E output schema; Phase 7 CSV schema | 22-column CSV; agent roles from defined role set; QA stub linked | Phase 7 planner compatibility spec; 22 columns audited 2026-03-18 |
| **AC-08** Quality gate report | Phase 5, Phase 7 | Phase 5 Workflow F; WFC-F output schema | Pass/fail status, critical failure count, coverage %, test-plan IDs | Quantitative fields required; enables numeric threshold verification at CS-07 gate |
| **AC-09** Pilot readiness recommendation (mandatory) | Phase 8 | Phase 8 plan REQ-806; pilot report template | Exactly one of {go, conditional-go, hold}; evidence table references all 5 streams | REQ-806: three-decision gate with numeric thresholds; REQ-807: E1–E7 evidence paths |
| **Worker Tier-F Fix Verification** (all WF-* scenarios) | Phase 6 | Phase 6 Worker Tier-F edge case section; Phase 6 authorship accountability rule; Phase 6 scope violation trigger | Three conditions: explicit invocation + explicit instruction + conversion context | Phase 6 edge case rule is the governing contract; Worker Tier-F fix verification document defines 16 scenarios; 0 violations required |
| **Advisor Cascade Scenarios** (all AC-CAS-* scenarios) | Phase 5, Phase 6 | Phase 5 Workflows C and F; Phase 6 Tier R; REQ-802 | FrontendDev/BackendDev disallowedTools enforcement under escalation pressure | ADR-007 rationalization prevention: escalation pressure must not cause advisor agents to rationalize a write action; 0 file writes across all four scenarios |
| **Pilot Recommendation Framework** | Phase 8 | Phase 8 plan REQ-806; task.md Phase 8 exit criteria | go/conditional-go/hold with numeric thresholds; evidence E1–E7 | Three-decision gate with numeric per-stream thresholds; conditional-go has explicit constraint list requirement; hold has explicit remediation requirement |

---

## ADR Alignment Table

| ADR | Guidance Applied in Phase 8 |
| --- | --- |
| ADR-001 | PM orchestration-only constraint; handoff-button pattern; no Task() dispatch; Tier O enforcement (PB-01, PB-10, CS-05) |
| ADR-002 | Task-centric persistence: all Phase 8 artifacts in `.tasks/005-pm-agent-system/artifacts/phase-8/`; evidence E1–E7 paths follow task-centric convention |
| ADR-004 | Skill-powered delegation: all agent actions in scenarios reference the correct skill (resource-ingestion, stakeholder-feedback, requirements-cascade, backlog-management, diagram-generation, quality-gate-review) |
| ADR-005 | IDE compatibility: all verification methods in this plan use query/file-inspection steps only; no heredoc, no multi-line terminal commands in validation design |
| ADR-007 | Rationalization prevention: (1) CS-07/CS-10 gates require observable evidence before decisions; (2) advisor cascade scenarios test whether agents write under escalation pressure; (3) Worker Tier-F fix verification requires observable 0-violation evidence, not assertion |

---

## Requirement Coverage Table

| Requirement | Source | Covered By |
| --- | --- | --- |
| REQ-801 | Phase 8 plan | E2E-01 through E2E-06 (all six core workflows) |
| REQ-802 | Phase 8 plan | PB-01 through PB-12; PB-11 and PB-12 specifically cover advisor-constraint scenarios |
| REQ-803 | Phase 8 plan | CS-01 through CS-10 (all ten checkpoint IDs; none documented as implicit) |
| REQ-804 | Phase 8 plan | QG-PASS and QG-FAIL paths; QG-FAIL includes FE/BE escalation and re-gate |
| REQ-805 | Phase 8 plan | AC-01 through AC-09 (all nine artifact types; each has path, format, and compatibility test) |
| REQ-806 | Phase 8 plan | Pilot report template: exactly three decision outcomes; numeric thresholds per stream |
| REQ-807 | Phase 8 plan | Evidence checklist E1–E7; each has artifact path in `.tasks/005-pm-agent-system/artifacts/phase-8/` |
| REQ-808 | Phase 8 plan | This document — source traceability matrix |
| CON-801 | Phase 8 plan | Planning-only mode; no scenario execution in this phase |
| CON-802 | Phase 8 plan | All phase-8 artifact writes in `.tasks/005-pm-agent-system/artifacts/phase-8/`; no production path writes |
| GUD-805 | ADR-007 | CS-07, CS-10, advisor cascade scenarios, Worker fix verification all require observable evidence |
