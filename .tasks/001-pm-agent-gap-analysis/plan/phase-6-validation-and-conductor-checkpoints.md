---
phase: 6
phase_name: Validation and Conductor Checkpoints
task: Investigate PM custom-agent coordination failures vs known-good baseline
status: Done
created: 2026-03-23
owner: Explorer
consumes:
  - .tasks/001-pm-agent-gap-analysis/plan/phase-5-implementation-planning-by-workstream.md#phase-6-handoff-matrix
  - .tasks/001-pm-agent-gap-analysis/plan/phase-5-implementation-planning-by-workstream.md#phase-6-deterministic-scenario-set
---

# Phase 6 Plan: Validation and Conductor Checkpoints

## Objective

Execute deterministic validation across all acceptance domains using the Phase 5 handoff matrix and scenario set, enforce Conductor checkpoint evidence rules, and produce a complete sign-off package with residual risk recording.

## Scope

- In scope:
  - Execute PH6-SCN-001 through PH6-SCN-004 with checkpoint-level evidence capture.
  - Validate pass/fail gates for coordination, learning-base ingestion, Planner format, and PM-tool recommendations.
  - Produce validation artifacts and final sign-off package.
  - Record residual risks and decision outcomes for release readiness.
- Out of scope:
  - Implementing new remediation code paths.
  - Redefining Phase 5 contracts, scenario definitions, or gate IDs.

---

## Inputs and Preconditions

### Required Inputs (From Phase 5)

| Input ID | Source | Required Content | Validation Use |
|---|---|---|---|
| PH6-IN-001 | Phase 5 Handoff Matrix | Domain-to-artifact mapping and pass thresholds | Domain-level pass/fail adjudication |
| PH6-IN-002 | Phase 5 Deterministic Scenario Set | PH6-SCN-001..004 triggers, expected gates, expected artifacts | Execution checklist and scenario run control |
| PH6-IN-003 | Phase 5 Fail-Fast Criteria | BAS-GATE-001/002/003/010 stop conditions | Immediate stop and reroute logic |
| PH6-IN-004 | Workstream Test Inventory TG-001..TG-006 | Coverage-to-domain map | Coverage completion proof |

### Entry Preconditions

| Precondition ID | Condition | Blocking Rule |
|---|---|---|
| PH6-PRE-001 | All Phase 5 artifacts exist and are non-empty | If false, Phase 6 remains `Hold: Missing Inputs` |
| PH6-PRE-002 | Scenario prerequisites are satisfiable in target environment | If false, mark scenario `Blocked` and do not claim domain pass |
| PH6-PRE-003 | For each scenario, run logs include the gate IDs expected for that scenario's defined gate path (including expected hold/fail-fast stop points) | If false, that scenario run is invalid and must be repeated |
| PH6-PRE-004 | Validation evidence directories are writable | If false, stop before scenario execution |

---

## Validation Artifact Outputs

## Evidence Artifact Set

| Artifact ID | Path | Producer | Purpose |
|---|---|---|---|
| PH6-ART-001 | C:/Users/s1058662/OneDrive - Syngenta/workspace/Projects/2026_01_VIP/.tasks/005-pm-agent-system/artifacts/phase-11/e2e-execution-log.md | Conductor | Gate transitions, scenario trace, boundary enforcement evidence |
| PH6-ART-002 | C:/Users/s1058662/OneDrive - Syngenta/workspace/Projects/2026_01_VIP/.tasks/005-pm-agent-system/artifacts/phase-11/pilot-readiness-report.md | Scrum Master | Planner-schema checks and PM recommendation rationale evidence |
| PH6-ART-003 | C:/Users/s1058662/OneDrive - Syngenta/workspace/Projects/2026_01_VIP/learning_base/ideas/chat_logs/pm_agent_improvements/*.json | ProjectOwner + BA | Ingestion success/blocker exports (before/after snapshots) |
| PH6-ART-004 | C:/Users/s1058662/OneDrive - Syngenta/workspace/Projects/2026_01_VIP/.tasks/005-pm-agent-system/artifacts/phase-11/phase-6-validation-summary.md | Validation Lead | Scenario outcomes, domain verdicts, open defects |
| PH6-ART-005 | C:/Users/s1058662/OneDrive - Syngenta/workspace/Projects/2026_01_VIP/.tasks/005-pm-agent-system/artifacts/phase-11/phase-6-signoff-package.md | Conductor + PM Owner | Final approval record, residual risk register, go/no-go decision |

### Sign-Off Package Minimum Contents

1. Execution manifest listing PH6-SCN-001..004 with timestamps and owners.
2. Domain verdict table (Coordination, Ingestion, Planner, PM Recommendations).
3. Conductor gate evidence index for BAS-GATE-001/002/003/010.
4. Defect and exception ledger with disposition.
5. Residual risk register with owner, mitigation, and review date.
6. Final decision and approvals (Conductor, PM Owner, QA Reviewer) including explicit no-go confirmation for unresolved high-severity defects.

---

## Scenario Execution Checklist

### Global Execution Rules

- Rule PH6-RUN-001: Execute scenarios in numeric order unless blocked by fail-fast condition.
- Rule PH6-RUN-002: For each scenario, capture gate-by-gate evidence before moving to next gate.
- Rule PH6-RUN-003: Any fail-fast trigger immediately sets scenario verdict based on scenario expectation: use `Expected-Hold` or `Expected-Fail` when fail-fast/hold is the intended outcome for that scenario; otherwise set `Failed`. Record reroute action in all fail-fast cases.
- Rule PH6-RUN-004: Domain pass is only allowed when all mapped scenarios and artifacts pass threshold.
- Rule PH6-RUN-005: Deterministic repeatability gate applies to every scenario with minimum run count `N=3` consecutive executions.
- Rule PH6-RUN-006: Unexpected gate-order drift threshold is `0` across repeat runs; any drift invalidates the scenario pass claim.
- Rule PH6-RUN-007: Flake handling policy is mandatory: first inconsistent run is recorded as `Flake-Suspected`, scenario is rerun until either (a) 3 consecutive matching outcomes are achieved, or (b) flake persists for 5 total attempts and scenario is marked `Failed-Flaky` with defect record.

### Scenario Verdict Semantics

- Rule PH6-VER-001: Allowed scenario verdicts are `Pass`, `Expected-Hold`, `Expected-Fail`, `Failed`, `Failed-Flaky`, and `Blocked`.
- Rule PH6-VER-002: A scenario is considered `Outcome-Satisfied` only when verdict matches its Phase 5 expected outcome and required evidence is present.
- Rule PH6-VER-003: For PH6-SCN-002 specifically, explicit BAS-GATE-001 hold with required blocker evidence is `Expected-Hold` and is treated as `Outcome-Satisfied`.

### Step-by-Step Scenario Procedure (Apply to Each Scenario)

1. Initialize run record with scenario ID, owner, start timestamp, and prerequisite status.
2. Confirm expected trigger conditions are present exactly as defined in Phase 5 scenario set.
3. Execute orchestration flow and capture BAS gate transitions in `e2e-execution-log.md` for repeatability run IDs `R1..RN` (minimum `N=3`).
4. Compare repeat runs and confirm zero unexpected gate-order drift before continuing.
5. Capture domain artifacts (ingestion export, planner schema check, recommendation evidence) for that scenario.
6. Evaluate scenario pass/fail against defined gate and artifact thresholds, including repeatability gate.
7. If not `Outcome-Satisfied`, record fail-fast condition, corrective action, and retest requirement; apply flake policy when run consistency is not met.
8. Close scenario with end timestamp and signed scenario verdict.

### Scenario-by-Scenario Execution Matrix

| Scenario ID | Execution Focus | Mandatory Steps | Pass Gate |
|---|---|---|---|
| PH6-SCN-001 | Coordination happy path | Validate BAS-GATE-001 -> 002 -> 003 -> 010 complete order for `N=3` runs; verify no unauthorized role bypass | All required gates pass in-order across all repeat runs; no bypass transitions |
| PH6-SCN-002 | Ingestion blocker path | Force unresolved binary dependency; verify hold at BAS-GATE-001 and explicit decision controls | Hold behavior is explicit; no silent progression to BAS-GATE-002 |
| PH6-SCN-003 | Schema rejection path | Inject missing planner field; verify BAS-GATE-002 fail-fast, workbook-aligned field names/required columns/value types checks, and import simulation failure output | Deterministic schema fail with required remediation output and failed import simulation evidence |
| PH6-SCN-004 | PM recommendation qualification | Supply uncertainty, role-clarity, root-cause, prioritization, and governance qualifiers; verify BAS-SCHEMA-003 recommendation block and rationale mapping per trigger category | Recommendation block present with deterministic framework rationale for every qualifying trigger category |

---

## Conductor Gate Evidence Requirements

| Gate ID | Required Evidence | Required Artifact Location | Fail Condition |
|---|---|---|---|
| BAS-GATE-001 | Dependency validation status, initialization decision, hold/continue state | `e2e-execution-log.md` + ingestion json export for blocker/ready state | Any unresolved dependency without explicit hold-state evidence |
| BAS-GATE-002 | Plan/schema review result, trigger predicate evaluation, workbook-aligned field names, required columns, value types, import simulation outcome, revision checklist when failed | `pilot-readiness-report.md` + `e2e-execution-log.md` | Missing schema/trigger/import-simulation evidence or progression after failed review |
| BAS-GATE-003 | Role boundary enforcement, approved plan path, implementation-start readiness | `e2e-execution-log.md` | Any BA->Builder bypass or missing approval evidence |
| BAS-GATE-010 | Completion boundary evidence, recommendation presence/justified omission, checkpoint trail | `phase-6-validation-summary.md` + `phase-6-signoff-package.md` | Completion claimed without full checkpoint and domain evidence |

Gate evidence quality rule PH6-GATE-QUAL-001: every gate record must include unique run ID, scenario ID, timestamp, actor, verdict, artifact pointer, and integrity marker/checksum for each referenced artifact.

---

## Domain Pass/Fail Criteria

| Domain | Mapped Scenarios | Pass Criteria | Fail Criteria |
|---|---|---|---|
| Coordination/Orchestration | PH6-SCN-001, PH6-SCN-003 | 100% required gate order observed for `N=3` repeat runs per scenario; gate-order drift threshold = 0; 0 unauthorized transitions; all holds are explicit | Skipped gate, out-of-order transition, unexpected drift, or silent bypass |
| Learning-Base Ingestion | PH6-SCN-002 (+ non-blocking ingestion evidence in PH6-SCN-001) | 100% binary/non-binary runs emit either resolved-path completion or explicit blocker-state outputs; PH6-SCN-002 explicit hold at BAS-GATE-001 with blocker evidence is accepted as `Expected-Hold` | Missing ingestion artifact, silent ingestion failure, ambiguous blocker state, or progression beyond expected hold path |
| Planner Format Compliance | PH6-SCN-003 (+ schema checks in PH6-SCN-001) | 100% BAS-SCHEMA-001/002/004 mandatory fields present in passing runs; workbook-aligned field names, required columns, and value types validated; import simulation passes for passing runs; failures produce revision checklist | Any required field missing in a passing verdict, type mismatch, missing import simulation result, or no checklist on fail |
| PM-Tool Recommendations | PH6-SCN-004 | 100% qualifying scenarios include BAS-SCHEMA-003 recommendation block with rationale-to-context mapping across uncertainty, role-clarity, root-cause, prioritization, and governance trigger categories | Any qualifying trigger category without recommendation, missing category rationale mapping, or non-deterministic rationale |

Domain verdict rule PH6-DOM-001: domain is `Pass` only when every mapped scenario is `Outcome-Satisfied` (`Pass`, `Expected-Hold`, or `Expected-Fail` as applicable to scenario expectations) and all required artifacts are present and valid.

---

## Tests

### Test Inventory for Phase 6 Execution

| Test ID | Type | Validates | Evidence Output |
|---|---|---|---|
| PH6-TST-001 | Integration | End-to-end gate ordering across PH6-SCN-001 | `e2e-execution-log.md` gate trail |
| PH6-TST-002 | Negative | Ingestion dependency failure handling and hold behavior in PH6-SCN-002 | Ingestion json blocker-state + gate hold row |
| PH6-TST-003 | Negative | Planner schema fail-fast behavior with workbook-aligned field names/required columns/value types and import simulation outcome in PH6-SCN-003 | `pilot-readiness-report.md` validation fail row + import simulation result |
| PH6-TST-004 | Integration | PM recommendation qualification and deterministic rationale across uncertainty, role-clarity, root-cause, prioritization, and governance triggers in PH6-SCN-004 | Recommendation evidence in execution log + readiness report with category mapping |
| PH6-TST-005 | Coverage | Domain-level completion using all mapped scenarios | `phase-6-validation-summary.md` domain verdict table |

### Behavioral Test Rules

- Test rule PH6-BEH-001: assertions must target observable outcomes (gate state, artifacts, domain verdict), not internal call sequences.
- Test rule PH6-BEH-002: test doubles allowed only at external boundaries; prefer real orchestration path and real artifacts.
- Test rule PH6-BEH-003: every failed behavior requires a deterministic remediation output artifact.

---

## Final Sign-Off and Residual Risk Recording

### Sign-Off Workflow

1. Consolidate scenario results and domain verdicts into `phase-6-validation-summary.md`.
2. Confirm all gate evidence requirements are satisfied for BAS-GATE-001/002/003/010.
3. Populate residual risk register in `phase-6-signoff-package.md`.
4. Enforce no-go rules before approval: unresolved high-severity defect(s) or unresolved high-impact risk(s) block sign-off.
5. Record go/no-go decision with rationale tied to domain verdicts.
6. Capture approvals from Conductor, PM Owner, and QA Reviewer.

### Residual Risk Register Schema

| Field | Required Description |
|---|---|
| Risk ID | Stable identifier (e.g., PH6-RISK-001) |
| Domain | Coordination, Ingestion, Planner, or PM Recommendation |
| Description | Residual issue that does not block immediate sign-off |
| Impact | Low, Medium, High |
| Likelihood | Low, Medium, High |
| Mitigation | Concrete next action and owner |
| Review Date | Next validation checkpoint date |
| Acceptance Rationale | Why release can proceed with this risk |

Sign-off gate PH6-SIGN-001: final sign-off is blocked if any high-impact risk lacks mitigation owner or review date.
Sign-off gate PH6-SIGN-002: final sign-off is blocked if any unresolved high-severity defect remains open at decision time.

---

## Verification

### Automated Checks (Bash / rg)

Run from repository root:

```bash
rg -n "phase: 6|phase_name: Validation and Conductor Checkpoints|status: Done" .tasks/001-pm-agent-gap-analysis/plan/phase-6-validation-and-conductor-checkpoints.md
rg -n "PH6-SCN-001|PH6-SCN-002|PH6-SCN-003|PH6-SCN-004" .tasks/001-pm-agent-gap-analysis/plan/phase-6-validation-and-conductor-checkpoints.md
rg -n "BAS-GATE-001|BAS-GATE-002|BAS-GATE-003|BAS-GATE-010" .tasks/001-pm-agent-gap-analysis/plan/phase-6-validation-and-conductor-checkpoints.md
rg -n "Coordination/Orchestration|Learning-Base Ingestion|Planner Format Compliance|PM-Tool Recommendations" .tasks/001-pm-agent-gap-analysis/plan/phase-6-validation-and-conductor-checkpoints.md
rg -n "phase-6-validation-summary.md|phase-6-signoff-package.md|Residual Risk Register Schema" .tasks/001-pm-agent-gap-analysis/plan/phase-6-validation-and-conductor-checkpoints.md
```

### Windows PowerShell Alternatives

Run from repository root:

```powershell
$file = ".tasks/001-pm-agent-gap-analysis/plan/phase-6-validation-and-conductor-checkpoints.md"
Select-String -Path $file -Pattern "phase: 6|phase_name: Validation and Conductor Checkpoints|status: Done"
Select-String -Path $file -Pattern "PH6-SCN-001|PH6-SCN-002|PH6-SCN-003|PH6-SCN-004"
Select-String -Path $file -Pattern "BAS-GATE-001|BAS-GATE-002|BAS-GATE-003|BAS-GATE-010"
Select-String -Path $file -Pattern "Coordination/Orchestration|Learning-Base Ingestion|Planner Format Compliance|PM-Tool Recommendations"
Select-String -Path $file -Pattern "phase-6-validation-summary.md|phase-6-signoff-package.md|Residual Risk Register Schema"
```

### Windows Runtime Artifact Existence and Freshness Checks

Run from repository root:

```powershell
$artifacts = @(
  @{ Id = "PH6-ART-001"; Path = "C:/Users/s1058662/OneDrive - Syngenta/workspace/Projects/2026_01_VIP/.tasks/005-pm-agent-system/artifacts/phase-11/e2e-execution-log.md" },
  @{ Id = "PH6-ART-002"; Path = "C:/Users/s1058662/OneDrive - Syngenta/workspace/Projects/2026_01_VIP/.tasks/005-pm-agent-system/artifacts/phase-11/pilot-readiness-report.md" },
  @{ Id = "PH6-ART-003"; Path = "C:/Users/s1058662/OneDrive - Syngenta/workspace/Projects/2026_01_VIP/learning_base/ideas/chat_logs/pm_agent_improvements" },
  @{ Id = "PH6-ART-004"; Path = "C:/Users/s1058662/OneDrive - Syngenta/workspace/Projects/2026_01_VIP/.tasks/005-pm-agent-system/artifacts/phase-11/phase-6-validation-summary.md" },
  @{ Id = "PH6-ART-005"; Path = "C:/Users/s1058662/OneDrive - Syngenta/workspace/Projects/2026_01_VIP/.tasks/005-pm-agent-system/artifacts/phase-11/phase-6-signoff-package.md" }
)

$freshnessHours = 24
$cutoff = (Get-Date).AddHours(-$freshnessHours)

foreach ($a in $artifacts) {
  $exists = Test-Path -Path $a.Path
  if (-not $exists) {
    Write-Output ("{0}: MISSING -> {1}" -f $a.Id, $a.Path)
    continue
  }

  if ($a.Id -eq "PH6-ART-003") {
    $latest = Get-ChildItem -Path $a.Path -Filter *.json -File -ErrorAction SilentlyContinue |
      Sort-Object LastWriteTime -Descending |
      Select-Object -First 1
    if (-not $latest) {
      Write-Output ("{0}: PRESENT but no JSON snapshot found -> {1}" -f $a.Id, $a.Path)
      continue
    }
    $isFresh = $latest.LastWriteTime -ge $cutoff
    Write-Output ("{0}: PRESENT latest={1:o} fresh={2}" -f $a.Id, $latest.LastWriteTime, $isFresh)
  } else {
    $item = Get-Item -Path $a.Path
    $isFresh = $item.LastWriteTime -ge $cutoff
    Write-Output ("{0}: PRESENT lastWrite={1:o} fresh={2}" -f $a.Id, $item.LastWriteTime, $isFresh)
  }
}
```

### Non-Windows Runtime Artifact Existence and Freshness Checks (Bash)

Run from repository root:

```bash
artifacts=(
  "PH6-ART-001|/mnt/c/Users/s1058662/OneDrive - Syngenta/workspace/Projects/2026_01_VIP/.tasks/005-pm-agent-system/artifacts/phase-11/e2e-execution-log.md"
  "PH6-ART-002|/mnt/c/Users/s1058662/OneDrive - Syngenta/workspace/Projects/2026_01_VIP/.tasks/005-pm-agent-system/artifacts/phase-11/pilot-readiness-report.md"
  "PH6-ART-003|/mnt/c/Users/s1058662/OneDrive - Syngenta/workspace/Projects/2026_01_VIP/learning_base/ideas/chat_logs/pm_agent_improvements"
  "PH6-ART-004|/mnt/c/Users/s1058662/OneDrive - Syngenta/workspace/Projects/2026_01_VIP/.tasks/005-pm-agent-system/artifacts/phase-11/phase-6-validation-summary.md"
  "PH6-ART-005|/mnt/c/Users/s1058662/OneDrive - Syngenta/workspace/Projects/2026_01_VIP/.tasks/005-pm-agent-system/artifacts/phase-11/phase-6-signoff-package.md"
)

freshness_hours=24
cutoff_epoch=$(date -u -d "-${freshness_hours} hours" +%s 2>/dev/null || date -u -v-${freshness_hours}H +%s)

for row in "${artifacts[@]}"; do
  id="${row%%|*}"
  path="${row#*|}"

  if [ ! -e "$path" ]; then
    printf "%s: MISSING -> %s\n" "$id" "$path"
    continue
  fi

  if [ "$id" = "PH6-ART-003" ]; then
    latest_json=$(find "$path" -maxdepth 1 -type f -name "*.json" -print0 2>/dev/null | xargs -0 ls -1t 2>/dev/null | head -n 1)
    if [ -z "$latest_json" ]; then
      printf "%s: PRESENT but no JSON snapshot found -> %s\n" "$id" "$path"
      continue
    fi
    latest_epoch=$(stat -c %Y "$latest_json" 2>/dev/null || stat -f %m "$latest_json")
    if [ "$latest_epoch" -ge "$cutoff_epoch" ]; then fresh=true; else fresh=false; fi
    latest_iso=$(date -u -d "@$latest_epoch" +%Y-%m-%dT%H:%M:%SZ 2>/dev/null || date -u -r "$latest_epoch" +%Y-%m-%dT%H:%M:%SZ)
    printf "%s: PRESENT latest=%s fresh=%s\n" "$id" "$latest_iso" "$fresh"
  else
    item_epoch=$(stat -c %Y "$path" 2>/dev/null || stat -f %m "$path")
    if [ "$item_epoch" -ge "$cutoff_epoch" ]; then fresh=true; else fresh=false; fi
    item_iso=$(date -u -d "@$item_epoch" +%Y-%m-%dT%H:%M:%SZ 2>/dev/null || date -u -r "$item_epoch" +%Y-%m-%dT%H:%M:%SZ)
    printf "%s: PRESENT lastWrite=%s fresh=%s\n" "$id" "$item_iso" "$fresh"
  fi
done
```

### Manual Verification Steps

1. Confirm `.tasks/001-pm-agent-gap-analysis/task.md` marks Phase 6 as `✅ Done` with a valid plan link.
2. Confirm the Phase 6 plan explicitly states it consumes the Phase 5 handoff matrix and deterministic scenario set.
3. Confirm all four acceptance domains have explicit pass and fail criteria.
4. Confirm Conductor evidence requirements are defined for BAS-GATE-001/002/003/010.
5. Confirm final sign-off package requirements include no-go rules for unresolved high-severity defects and unresolved high-impact risks.

### Success Criteria

- SC-PH6-001: Phase 6 plan file exists and is complete with execution checklist and scenario matrix.
- SC-PH6-002: Domain pass/fail criteria are explicit for coordination, ingestion, planner format, and PM-tool recommendations.
- SC-PH6-003: Conductor gate evidence requirements are complete for all required gates.
- SC-PH6-004: Sign-off package and residual risk recording schema are documented and actionable.
- SC-PH6-005: Automated and manual verification instructions are executable on Windows and non-Windows setups, including artifact existence/freshness checks for PH6-ART-001..005.
