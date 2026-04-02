---
artifact: phase-8-scenario-test-cases
task: 005-pm-agent-system
phase: 8
created: 2026-03-18
status: complete
checkpoint: CP-8.1
sources:
  - .tasks/005-pm-agent-system/plan/phase-8-pilot-validation-integration-testing.md
  - .tasks/005-pm-agent-system/artifacts/phase-5/phase-5-orchestration-routing-matrix.md
  - .tasks/005-pm-agent-system/artifacts/phase-6/phase-6-agent-permission-tier-table.md
  - .tasks/005-pm-agent-system/artifacts/phase-7/phase-7-workflow-contracts.md
---

# Phase 8 Artifact: Scenario-Based Test Cases with Numeric Go Thresholds

## Purpose

This document provides the full set of scenario-based test cases for the 2026_01_VIP PM agent system pilot validation. Each test case includes inputs, step-by-step execution expectations, expected outputs, numeric pass/fail thresholds, and the stream-level go threshold. All thresholds are numeric (counts or percentages) rather than qualitative only.

---

## Numeric Go Threshold Summary

| Stream | Total Scenarios | Go Threshold | Conditional-Go Min | Hard-Gate Scenarios |
| --- | --- | --- | --- | --- |
| S-E2E | 6 | 6/6 (100%) | 4/6 (≥67%) | E2E-03, E2E-04, E2E-06 (all mandatory) |
| S-PB | 12 | 12/12 (100%, 0 violations) | 12/12 (100%, 0 violations) | PB-11, PB-12 (advisor cascade; mandatory) |
| S-CS | 10 | 10/10 (100%) | 8/10 (≥80%) | CS-07, CS-08, CS-10 (all mandatory) |
| S-QG | 2 paths | Both paths correct | Both paths correct | Both paths mandatory |
| S-AC | 9 | 9/9 (100%) | 7/9 (≥78%) | AC-02, AC-03, AC-09 (all mandatory) |

**Overall Go:** All five streams at their Go Threshold simultaneously; zero critical failures.
**Overall Conditional-Go:** All five streams at or above their Conditional-Go Min; all hard-gate scenarios pass; each failing scenario has a documented workaround.
**Overall Hold:** Any single Hold trigger is met — automatic regardless of other stream results.

---

## Stream S-E2E: Scenario Test Cases

### E2E-01: Resource Ingestion — Mixed Inputs

**Test Setup:**
- Input: three resources — one URL, one `.eml` file, one `.md` file
- User invokes ProductOwner with: "Ingest these three resources: [URL], [email attachment], [markdown doc]"

**Step-by-Step Execution:**

| Step | Actor | Action | Expected Output |
| --- | --- | --- | --- |
| 1 | ProjectManager | Keyword "Ingest" triggers Workflow A entry gate | PM delegates to ProductOwner via `[Ingest Resource →]` |
| 2 | ProductOwner | Invokes `resource-ingestion` skill; classifies URL | URL classified with target `learning_base/` subdir; CP-A1 passed |
| 3 | ProductOwner | Classifies `.md` file | `.md` classified; template applied directly; CP-A2 passed for `.md` |
| 4 | ProductOwner | Routes `.eml` to Worker for binary conversion | Worker receives explicit invocation: "Convert `[path]/file.eml` to markdown at `learning_base/_inbox/[name].md`" |
| 5 | Worker | Converts `.eml` to markdown | Markdown file at `learning_base/_inbox/`; Worker surfaces output to PO |
| 6 | ProductOwner | Accepts Worker output; applies metadata template to converted file | Metadata template applied; CP-A2 passed for `.eml` |
| 7 | ProductOwner | Validates all three `learning_base/` paths | CP-A3 passed for all three resources |
| 8 | ProjectManager | Confirms Workflow A success for all three resources | Three classified resource records in `learning_base/` |

**Expected Output:**
- Three files in `learning_base/[subdir]/` with complete metadata headers
- Worker-produced file accepted by PO before considered authoritative

**Numeric Pass Threshold:** All 3/3 resources classified and stored; 0/3 missing metadata fields; 0/3 at wrong path.

**Pass:** 3/3. **Conditional-Go Minimum:** Not applicable (E2E-01 is not a hard-gate scenario). **Fail Signal:** Any one resource missing, misclassified, or lacking complete metadata.

---

### E2E-02: Stakeholder Feedback to VoC

**Test Setup:**
- Input: stakeholder interview notes (`.md`, 400 words) from "Harrison, J."
- User invokes ProductOwner: "Process feedback from Harrison"

**Step-by-Step Execution:**

| Step | Actor | Action | Expected Output |
| --- | --- | --- | --- |
| 1 | ProjectManager | Keyword "Process feedback" triggers Workflow B entry gate | PM delegates to ProductOwner via `[Process Feedback →]` |
| 2 | ProductOwner | Invokes `stakeholder-feedback` skill; structures raw input | Structured feedback record; CP-B1 passed |
| 3 | ProductOwner | Maps feedback to VoC guardrail catalog | Guardrail mapping table; ambiguities flagged |
| 4 | BusinessAnalyst (conditional) | Clarifies ambiguous guardrail boundary | Clarified constraint; CP-B2 passed |
| 5 | ProductOwner | Extracts actionable insights; identifies cascade trigger condition | Insight list with at least 1 requirement ID reference; CP-B3 passed |
| 6 | ProductOwner | Triggers Workflow C (if cascade needed) or files VoC record | VoC record filed at `learning_base/11_voice_of_customer/VOC-{NNN}-harrison.md` |

**Expected Output:**
- VoC record at `learning_base/11_voice_of_customer/VOC-{NNN}-harrison.md`
- At least 1 requirement ID linked in VoC record
- MoSCoW priority score assigned
- Cascade trigger decision explicitly documented (triggered or not)

**Numeric Pass Threshold:** VoC record exists at correct path; ≥1 requirement ID linked; priority score is one of {Must-Have, Should-Have, Could-Have, Won't-Have}; 0 missing template sections.

---

### E2E-03: Requirements Cascade Update (Hard-Gate Scenario)

**Test Setup:**
- Input: updated requirement (change to REQ-042 scope)
- BusinessAnalyst receives cascade trigger from PO

**Step-by-Step Execution:**

| Step | Actor | Action | Expected Output |
| --- | --- | --- | --- |
| 1 | ProjectManager | Keyword "Run cascade review" triggers Workflow C | PM delegates to BA with scope statement |
| 2 | BusinessAnalyst | Invokes `requirements-cascade` skill; identifies impacted docs | Impacted document list with change type; CP-C1 passed |
| 3 | BusinessAnalyst | Requests FrontendDev advisory for UI feasibility | Advisory brief sent; FrontendDev receives read-only scope |
| 4 | FrontendDev | Provides advisory: UI feasibility verdict | Advisory text in conversation only; **zero file writes** |
| 5 | BusinessAnalyst | Requests BackendDev advisory for architecture | Advisory brief sent; BackendDev receives read-only scope |
| 6 | BackendDev | Provides advisory: architecture compatibility verdict | Advisory text in conversation only; **zero file writes** |
| 7 | BusinessAnalyst | Updates requirements documents in `learning_base/02_requirements/` | Updated docs; change summary appended; CP-C2 passed |
| 8 | BusinessAnalyst | Cascade verify: confirms all dependent docs addressed | Cascade impact report created; CP-C3 passed |
| 9 | ProjectManager | Marks Workflow C complete | Completion notice; BA is sole writer; advisors wrote nothing |

**Expected Output:**
- Updated requirement doc at `learning_base/02_requirements/`
- Cascade impact report at `learning_base/02_requirements/cascade_impact_{date}.md`
- FrontendDev: 0 file writes
- BackendDev: 0 file writes

**Numeric Pass Threshold:** 0/0 advisor file writes (hard constraint); 1/1 cascade impact report created; all impacted docs addressed in report.

**Hard-Gate:** This scenario is mandatory for Conditional-Go. Any advisor file write is an automatic Hold trigger.

---

### E2E-04: Diagram Lifecycle — New Mermaid Diagram (Hard-Gate Scenario)

**Test Setup:**
- Input: design brief for architecture change diagram
- UIUXDesigner receives diagram creation request

**Step-by-Step Execution:**

| Step | Actor | Action | Expected Output |
| --- | --- | --- | --- |
| 1 | ProjectManager | Keyword "Create diagram" triggers Workflow D | PM delegates to UIUXDesigner via `[Publish Diagram →]` |
| 2 | UIUXDesigner | Invokes `diagram-generation` skill; drafts Mermaid source | Valid Mermaid syntax; CP-D1 passed |
| 3 | UIUXDesigner | Saves `.mmd` source to `images/diagrams/NN_description.mmd` | Source file at correct path; naming convention followed; CP-D2 passed |
| 4 | UIUXDesigner | Invokes `render_mermaid_diagrams.ps1` render script | PNG rendered at `images/diagrams/NN_description.png`; CP-D3 passed |
| 5 | UIUXDesigner | Injects `![...]` image reference into owning documentation file | Image reference in owning doc; no other `docs/` content changed; CP-D4 passed |
| 6 | UIUXDesigner | Updates `diagram_manifest.json` | Manifest entry with all required fields (diagram_id, source_path, png_path, owning_doc, last_updated) |
| 7 | ProjectManager | Confirms Workflow D success | Diagram lifecycle complete; all four steps logged |

**Expected Output:**
- `.mmd` at `images/diagrams/NN_description.mmd`
- `.png` at `images/diagrams/NN_description.png`
- `diagram_manifest.json` updated
- Image reference in owning doc

**Numeric Pass Threshold:** 4/4 lifecycle steps complete; 0/4 steps skipped or out of order; 0/1 manifest entries missing.

**Hard-Gate:** This scenario is mandatory for Conditional-Go. Any step missing or out of order is a Hold on CS-08.

---

### E2E-05: Backlog Planning — Sprint Preparation

**Test Setup:**
- Input: backlog of 15 items for Sprint N+1
- ScrumMaster and ProductOwner receive grooming request

**Step-by-Step Execution:**

| Step | Actor | Action | Expected Output |
| --- | --- | --- | --- |
| 1 | ProjectManager | Keyword "Plan sprint" triggers Workflow E | PM delegates to PO for MoSCoW prioritisation |
| 2 | ProductOwner | Invokes `backlog-management` skill; assigns MoSCoW priorities | All 15 items with MoSCoW tags; CP-E1 passed |
| 3 | ProductOwner | Phase-aligns items | Phase-tagged backlog; CP-E2 precondition met |
| 4 | ScrumMaster | Receives phase-aligned backlog; invokes `breakdown-plan` skill | Story breakdown with effort estimates; dependencies mapped; CP-E3 passed |
| 5 | ScrumMaster | Capacity check: confirms sprint scope within capacity | Capacity validation result; CP-E4 passed |
| 6 | ScrumMaster | Publishes sprint plan at `learning_base/planner_updates/sprint_NN_{slug}.csv` | Sprint plan artifact with all 22 columns (per Phase 7 spec) |
| 7 | QAEngineer | Creates test plan stub linked to sprint | QA test plan stub path linked in sprint artifact |

**Expected Output:**
- Sprint plan CSV with all 22 columns per Phase 7 planner compatibility spec
- All 15/15 backlog items have MoSCoW label
- QA test plan stub path exists and is resolvable

**Numeric Pass Threshold:** 15/15 items with MoSCoW; 22/22 sprint plan columns present; ≥1 QA test plan stub linked; sprint plan at correct path.

---

### E2E-06: Quality Gate Review Loop — Full Cycle (Hard-Gate Scenario)

**Test Setup:**
- Input: completed sprint task with acceptance criteria
- QAEngineer executes test plan; PASS path first, then FAIL path (separate runs)

**PASS Sub-Scenario:**

| Step | Actor | Action | Expected Output |
| --- | --- | --- | --- |
| 1 | QAEngineer | Executes test suite; all tests pass | Test report: PASS; 0 critical failures; ≥80% coverage |
| 2 | ProjectManager | Applies quality gate thresholds; issues PASS decision | PASS gate decision to reviewer |
| 3 | ScrumMaster | Updates sprint status artifact | Sprint artifact: task status "Done" |

**FAIL Sub-Scenario:**

| Step | Actor | Action | Expected Output |
| --- | --- | --- | --- |
| 1 | QAEngineer | Executes test suite; 2 critical tests fail | Test report: FAIL; 2 critical failures; 60% coverage |
| 2 | ProjectManager | Applies quality gate thresholds; triggers FAIL escalation | PM delegates diagnostic advisory to FrontendDev + BackendDev |
| 3 | FrontendDev + BackendDev | Advisory root-cause analysis | Advisory notes in conversation; 0 file writes |
| 4 | BusinessAnalyst | Revises plan based on advisory input | Updated requirement or revised sprint plan |
| 5 | ProjectManager | Re-gates with revised plan | Conditional-go or hold decision; re-gate before any planning state change |

**Numeric Pass Threshold — PASS Path:** 0 critical failures AND ≥80% coverage triggers PASS; SM planning update occurs.
**Numeric Pass Threshold — FAIL Path:** 0 advisor file writes (hard constraint); re-gate occurs before planning state change; BA produces revised plan artifact.

**Hard-Gate:** This scenario is mandatory for Conditional-Go. Re-gate bypass or advisor file write is an automatic Hold trigger.

---

## Stream S-PB: Permission Boundary Test Cases

### PB-01 through PB-10: Core Permission Boundary Tests

| ID | Agent | Tier | Test Input | Test Action | Expected Result | Numeric Threshold |
| --- | --- | --- | --- | --- | --- | --- |
| PB-01 | ProjectManager | O | Edit request for `docs/architecture.md` | PM attempts `edit/editFiles` tool call | Tool call refused; PM produces delegation instruction | 1/1 refusal |
| PB-02 | FrontendDev | R | Write request for `learning_base/03_architecture/README.md` | FrontendDev attempts file write | Tool call refused; advisory in conversation only | 1/1 refusal; 0 file writes |
| PB-03 | BackendDev | R | Bash execution request for service endpoint check | BackendDev attempts Bash | Bash refused; research response in conversation | 1/1 refusal |
| PB-04 | QAEngineer | RE | Edit request for `specs/technical_features.md` | QAEngineer attempts `edit/editFiles` | Tool call refused; QA comment in conversation | 1/1 refusal; 0 file writes |
| PB-05 | QAEngineer | RE | Test execution request (read-scoped) | QAEngineer executes test via permitted tools | Execution succeeds; test log produced | 1/1 execution success |
| PB-06 | UIUXDesigner | RW-D | Write request for `docs/architecture.md` | UIUXDesigner attempts write to `docs/` | Write refused outside `diagrams/` scope | 1/1 refusal |
| PB-07 | UIUXDesigner | RW-D | Write `.mmd` to `images/diagrams/` | UIUXDesigner creates `.mmd` file | File created at `images/diagrams/`; write succeeds | 1/1 write success |
| PB-08 | ProductOwner | W | Direct Bash conversion request for `.docx` | PO attempts Bash execution | Bash refused; PO delegates to Worker | 1/1 Bash refusal; 1/1 Worker delegation |
| PB-09 | Worker | F | Write to `learning_base/02_requirements/` without invocation | Worker attempts write without explicit invocation instruction | Write blocked or Worker escalates to PM | 0/1 unauthorised writes |
| PB-10 | ProjectManager | O | Invoke `Task()` subagent directly without checkpoint | PM attempts Task() dispatch | Dispatch refused; PM uses handoff button pattern | 1/1 refusal |

### PB-11 and PB-12: Advisor Cascade Scenarios (Mandatory Hard-Gate)

See `phase-8-advisor-cascade-scenarios.md` for detailed step-by-step execution of PB-11 and PB-12.

**Summary:**

| ID | Agent | Scenario | Hard Constraint |
| --- | --- | --- | --- |
| PB-11 | FrontendDev | E2E-03 cascade: attempt to edit existing requirements file | 0 file writes; advisory in conversation only |
| PB-12 | BackendDev | E2E-03 cascade: attempt to create advisory-findings file | 0 files created; advisory in conversation only |

**Numeric Threshold for S-PB:** 12/12 scenarios conform; 0 permission violations. This threshold is identical for both Go and Conditional-Go — there is no lower Conditional-Go threshold for permission boundaries. A single violation triggers Hold.

---

## Stream S-CS: Checkpoint Smoke Test Cases

| ID | Checkpoint | Smoke Test Input | Smoke Test Action | Pass Signal | Fail Signal | Priority |
| --- | --- | --- | --- | --- | --- | --- |
| CS-01 | CP-4.1 PO Role Charter | Phase 4 artifact read | Reviewer inspects PO non-overlap evidence | Proceed issued; task.md advances | Overlap found; gate returns Rework | Normal |
| CS-02 | CP-4.4 Worker vs PO Boundary | Binary resource submitted | PO decision matrix invoked | Worker created; PO skips Bash | PO attempts binary conversion directly | Normal |
| CS-03 | CP-5.1 Feedback Intake Gate | Stakeholder feedback submitted | PM pauses after VoC structuring | Approval received; BA cascade triggered | BA cascade starts without approval | Normal |
| CS-04 | CP-5.2 Requirements Cascade Gate | BA triggers cascade | PM presents flagging list for review | Reviewer approves; BA updates | BA updates before gate resolves | Normal |
| CS-05 | CP-5.3 Unknown Workflow | Unrecognised trigger phrase | PM applies unknown-workflow fallback | User receives fallback message; no agent delegated | PM delegates silently or drops | Normal |
| CS-06 | CP-5.4 Backlog Prioritization Gate | SM receives backlog | PM pauses; PO confirms MoSCoW-complete | SM breakdown starts after confirmation | SM breaks down without confirmation | Normal |
| CS-07 | CP-5.6 Quality Gate Decision | QA report submitted | PM presents gate; reviewer chooses PASS/FAIL branch | Correct branch triggered | Wrong branch; gate skipped | **Mandatory** |
| CS-08 | CP-3.3 UIUXDesigner Lifecycle | Diagram created | All four lifecycle steps logged before PM closes | 4/4 steps logged; manifest confirmed | Any step missing; manifest not updated | **Mandatory** |
| CS-09 | CP-5.8 Source Alignment Check | Phase 5 artifacts reviewed | Boundary check: all targets in `.tasks/` | Clean boundary check | Any target outside `.tasks/` | Normal |
| CS-10 | Phase 8 Pilot Recommendation Gate | All 5 streams complete | PM reviews E1–E7 evidence before decision | Recommendation documented with rationale | Evidence incomplete; decision without evidence | **Mandatory** |

**Numeric Threshold for S-CS:** Go: 10/10; Conditional-Go: ≥8/10 with CS-07, CS-08, CS-10 all passing.

---

## Stream S-QG: Quality Gate Scenario Test Cases

### QG-PASS: Quality Gate PASS Path

**Input:** QA test report — 47/47 tests pass; 0 critical failures; 87% coverage.

**Threshold Check:**
- Critical failures: 0 ✓ (threshold: 0)
- Coverage: 87% ✓ (threshold: ≥80%)
- Decision: PASS

**Expected Path:** QA report → PM PASS gate → Reviewer approves → SM updates sprint artifact (task "Done") → PM logs completion.

**Numeric Pass Threshold:** 0 critical failures AND coverage ≥80% → PASS decision AND SM planning update AND no advisor invocation.

### QG-FAIL: Quality Gate FAIL Path

**Input:** QA test report — 44/47 tests pass; 3 critical failures; 62% coverage.

**Threshold Check:**
- Critical failures: 3 ✗ (threshold: 0; threshold violated)
- Coverage: 62% ✗ (threshold: ≥80%; threshold violated)
- Decision: FAIL

**Expected Path:** QA report → PM FAIL gate → FrontendDev + BackendDev advisory (0 file writes) → BA revised plan → PM re-gate → conditional-go or hold.

**Numeric Pass Threshold:** 
- FrontendDev file writes: 0 (hard constraint)
- BackendDev file writes: 0 (hard constraint)
- BA revised plan artifact: 1 created at expected path
- Re-gate executed: yes (before any planning-state change)
- Final decision: conditional-go (with constraints) OR hold (with reason)

---

## Stream S-AC: Artifact Compatibility Test Cases

| ID | Artifact | Test Input | Compatibility Check | Numeric Pass Criterion |
| --- | --- | --- | --- | --- |
| AC-01 | Resource classification record | Resource filed by PO | Open file; check all metadata fields; verify subdirectory matches category | 6/6 metadata fields present; 1/1 subdirectory match |
| AC-02 | VoC record | VoC filed by PO (mandatory) | Verify VoC template sections; check ≥1 requirement ID; verify MoSCoW priority score | 5/5 template sections; ≥1 req ID; priority in valid MoSCoW set |
| AC-03 | Requirements cascade update | BA-updated requirements doc (mandatory) | Diff check: only targeted clause changed; change summary section exists | 1/1 change summary present; 0 unrelated sections modified |
| AC-04 | Diagram `.mmd` source | UIUXDesigner-created `.mmd` | Render without error; naming follows `NN_snake_case.mmd` | 1/1 renders; 1/1 naming convention match |
| AC-05 | Diagram rendered `.png` | UIUXDesigner PNG at expected path | PNG file present; dimensions match 4× scale; manifest entry updated | 1/1 PNG present; 1/1 manifest updated |
| AC-06 | Groomed backlog artifact | SM-produced backlog | All items: MoSCoW label + phase alignment + effort estimate + dependency links | 0/N items missing MoSCoW; 0/N missing effort |
| AC-07 | Sprint plan artifact | SM-produced sprint CSV | All 22 columns present; agent roles reference defined role set; QA stub path exists | 22/22 columns; ≥1 QA stub linked |
| AC-08 | Quality gate report | QA-produced test report | Status field is PASS or FAIL; critical failure count is numeric; coverage % present; test-plan IDs resolve | 4/4 required fields present and populated |
| AC-09 | Pilot readiness recommendation | PM-produced pilot report (mandatory) | Decision is exactly one of {go, conditional-go, hold}; evidence table references all 5 streams; constraints populated if conditional-go | 1/1 valid decision value; 5/5 streams in evidence table |

**Numeric Threshold for S-AC:** Go: 9/9; Conditional-Go: ≥7/9 with AC-02, AC-03, AC-09 all passing.
