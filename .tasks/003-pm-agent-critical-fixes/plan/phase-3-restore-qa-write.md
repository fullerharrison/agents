# Phase 3 — Restore QAEngineer Write for Test Artifacts

**Task:** 003-pm-agent-critical-fixes  
**Target file:** `docs/pm-agents.md`  
**Date:** 2026-03-27

---

## Problem

QAEngineer holds `Tier RE (read + execute)` — no write access. Workflow F requires QAEngineer to produce a quality gate report that ProjectManager uses for a go/no-go decision. Without write access:

- Test results exist only in agent memory
- ProjectManager has no stable artifact to reference for the proceed/hold decision
- There is no audit trail for quality decisions, violating the spec's traceability principle

The fix introduces a controlled write scope (`RE+W-QA`) limited to `docs/qa/` only, and adds a structured output block (`QUALITY-GATE-REPORT:`) that QAEngineer emits when Workflow F completes. This follows the same "observable state" pattern already established by `INGESTION-DECISION:` (Workflow A) and `PLANNER-OUTPUT:` (Workflow E).

---

## Exact Changes to `docs/pm-agents.md`

### Change 1 — Agent Roster: QAEngineer tier

In the Agent Roster table, update the QAEngineer `Permission Tier` cell.

**Replace:**
```
| **QAEngineer** | Tier RE (read + execute) | Test planning, test execution, coverage analysis, quality gates | Yes |
```

**With:**
```
| **QAEngineer** | Tier RE+W-QA (read + execute + qa write) | Test planning, test execution, coverage analysis, quality gates | Yes |
```

*Role Summary is unchanged.*

---

### Change 2 — Permission Tiers table: new RE+W-QA row

In the Permission Tiers table, add a new row **immediately after** the existing `RE` row.

**After:**
```
| **RE** | All project files | ❌ | Tests only | QAEngineer |
```

**Insert:**
```
| **RE+W-QA** | All project files | docs/qa/ only (test-report-*.md, coverage-*.json, gate-result-*.md) | Tests only | QAEngineer |
```

The full table after this change:

| Tier | Read | Write | Execute | Who |
|---|---|---|---|---|
| **R** | All project files | ❌ | ❌ | FrontendDev, BackendDev |
| **W** | All project files | learning_base/, docs/, specs/ | ❌ | ProductOwner, BusinessAnalyst, ScrumMaster |
| **RE** | All project files | ❌ | Tests only | QAEngineer |
| **RE+W-QA** | All project files | docs/qa/ only (test-report-*.md, coverage-*.json, gate-result-*.md) | Tests only | QAEngineer |
| **RW-D** | All project files | diagrams/, images/diagrams/ only | ❌ | UIUXDesigner |
| **F** | All | All | Controlled | Builder |
| **F** *(scoped per invocation)* | All | All — WORKER-INVOCATION required | Controlled — HITL gate before write | Worker |
| **Orchestrator** | .tasks/, project files | ❌ | ❌ | ProjectManager |

**Note on RE vs RE+W-QA:** QAEngineer is the only agent that occupies both the `RE` and `RE+W-QA` entries — the `RE` row is kept as the base tier definition; `RE+W-QA` is the actual assigned tier that extends it. This mirrors the existing pattern where `F` has two rows for Builder and Worker.

---

### Change 3 — Workflow F: add file write step after CP-F3

In the Workflow F code block, replace the final output line.

**Replace:**
```
→ Quality gate report → ProjectManager decision → proceed or hold
```

**With:**
```
→ QAEngineer writes: docs/qa/gate-report-[epic-id]-[date].md
→ ProjectManager reads gate report → proceed or hold decision
```

---

### Change 4 — Workflow F: add QUALITY-GATE-REPORT observable state block

**Placement:** Immediately after the closing triple-backtick of the Workflow F code block, before the `---` separator that begins the Orchestration Routing section. This follows the exact pattern established by Workflow A's `INGESTION-DECISION:` "Observable state" paragraph.

**Insert after the Workflow F code block:**

````
**Observable state**: QAEngineer emits a `QUALITY-GATE-REPORT:` block for every completed quality gate assessment and writes it to `docs/qa/`. ProjectManager reads the file — quality gate results never exist only in agent memory.

~~~yaml
QUALITY-GATE-REPORT:
  epic:              <epic ID>
  sprint:            <sprint number>
  cp_f1_passed:      true | false
  cp_f2_passed:      true | false
  cp_f3_passed:      true | false
  critical_failures: [list or "none"]
  coverage_pct:      <number>
  recommendation:    proceed | hold | conditional-proceed
  report_path:       docs/qa/gate-report-[epic-id]-[date].md
~~~
````

---

### Change 5 — Handoff Contracts: QAEngineer → ProjectManager row

In the Handoff Contracts table, update the `QAEngineer → ProjectManager` row to reference the written artifact.

**Replace:**
```
| QAEngineer | ProjectManager | Quality gate result (pass/fail) for PM decision |
```

**With:**
```
| QAEngineer | ProjectManager | Gate report written to docs/qa/ — PM reads for proceed/hold decision |
```

---

## Implementation Checklist

1. [ ] Read `docs/pm-agents.md` — confirm current state matches pre-conditions below
2. [ ] **Change 1**: In the Agent Roster table, update QAEngineer Permission Tier cell from `Tier RE (read + execute)` → `Tier RE+W-QA (read + execute + qa write)`
3. [ ] **Change 2**: In the Permission Tiers table, insert the `RE+W-QA` row after the `RE` row — verify table renders correctly (7 data rows + Orchestrator = 8 rows total after the change)
4. [ ] **Change 3**: In Workflow F code block, replace the last `→` line with two `→` lines (file write + PM reads)
5. [ ] **Change 4**: After the Workflow F closing ` ``` `, insert the **Observable state** paragraph and the `QUALITY-GATE-REPORT:` YAML block
6. [ ] **Change 5**: In the Handoff Contracts table, update the `QAEngineer → ProjectManager` row to reference the written artifact
7. [ ] Read back the modified section to verify no formatting was broken
8. [ ] Run `scripts/validate-pm-patterns.ps1` — must pass all 39 existing checks (no regressions, before new check is added)
9. [ ] **Step A — Update template (mandatory)**: In `templates/agents/qa-engineer.template.md`:
   - In the `cc:` frontmatter block, remove `"Write"` and `"Edit"` from `disallowedTools` (keep `"MultiEdit"` and `"Task"` if present)
   - Add a note in the template body: "Write access is scoped to `docs/qa/` only per Tier RE+W-QA — do not write to other paths."
   - Update the `description` field to reflect `RE+W-QA` tier
10. [ ] **Step B — Regenerate agents (mandatory)**: Check `Makefile` for correct target (`make copilot`, `make all`, or `node scripts/generate.js`) and run it:
    - Verify `generated/copilot/agents/qa-engineer.agent.md` no longer has `"Write"` or `"Edit"` in `disallowedTools`
    - Verify `generated/claude/agents/qa-engineer.md` no longer has `"Write"` or `"Edit"` in `disallowedTools`
11. [ ] **Add QUALITY-GATE-REPORT validator check (mandatory)**: Add a new check to `scripts/validate-pm-patterns.ps1` that searches for `QUALITY-GATE-REPORT:` in `docs/pm-agents.md`, following the same pattern as existing checks — expected pass count becomes 40
12. [ ] Commit with message: `docs: Fix 3 — Restore QAEngineer write for test artifacts (RE+W-QA tier + QUALITY-GATE-REPORT)`

---

## Pre-Conditions (verify before implementing)

| Location | Expected Current Value |
|---|---|
| Agent Roster, QAEngineer tier | `Tier RE (read + execute)` |
| Permission Tiers table | No `RE+W-QA` row exists |
| Workflow F last `→` line | `→ Quality gate report → ProjectManager decision → proceed or hold` |
| No QUALITY-GATE-REPORT block | Confirmed absent |
| Handoff Contracts, QAEngineer → ProjectManager | `Quality gate result (pass/fail) for PM decision` |

---

## CHANGE-RECORD (Fix 3)

```
CHANGE-RECORD:
  fix:               3 of 3
  target_file:       docs/pm-agents.md
  problem:           QAEngineer (Tier RE) cannot write quality gate reports required by Workflow F;
                     results exist only in agent memory with no audit trail.
  root_cause:        Permission tier RE explicitly denies write access; no file output step
                     defined in Workflow F; no structured output block for gate results.
  fix_summary:       Introduce Tier RE+W-QA (write to docs/qa/ only); add file write step to
                     Workflow F; define QUALITY-GATE-REPORT structured output block.
  changes:
    - agent_roster:  QAEngineer tier updated from "Tier RE (read + execute)" to "Tier RE+W-QA (read + execute + qa write)"
    - permission_tiers: new RE+W-QA row added after RE row
    - workflow_f:    final step updated to show explicit file write + PM reads artifact
    - observable_state: QUALITY-GATE-REPORT YAML block added after Workflow F
    - handoff_contracts: QAEngineer → ProjectManager row updated to reference docs/qa/ artifact
    - template_update: templates/agents/qa-engineer.template.md disallowedTools and description updated
    - validator_check: new QUALITY-GATE-REPORT: pattern check added to scripts/validate-pm-patterns.ps1
  validation:        scripts/validate-pm-patterns.ps1 — all 40 checks pass (39 original + 1 new QUALITY-GATE-REPORT check)
  committed_by:      Builder
  commit:            <to be filled>
```

---

## Success Criteria

- [ ] QAEngineer row in Agent Roster shows `Tier RE+W-QA (read + execute + qa write)`
- [ ] Permission Tiers table contains an `RE+W-QA` row with `docs/qa/ only` write scope
- [ ] Workflow F final step shows `QAEngineer writes: docs/qa/gate-report-[epic-id]-[date].md`
- [ ] `QUALITY-GATE-REPORT:` block appears immediately after Workflow F with all 9 fields
- [ ] Handoff Contracts table shows `docs/qa/` reference in QAEngineer → ProjectManager row
- [ ] `templates/agents/qa-engineer.template.md` has `"Write"` and `"Edit"` removed from `disallowedTools` and `description` updated to `RE+W-QA` tier
- [ ] Generated agent files no longer have `"Write"` or `"Edit"` in `disallowedTools`
- [ ] `scripts/validate-pm-patterns.ps1` exits 0 with 40 checks passing (39 original + 1 new QUALITY-GATE-REPORT check)
- [ ] No other section of `docs/pm-agents.md` is modified

---

## Verification

### Automated Checks

```powershell
# Regression check — all 39 existing patterns must still pass
scripts/validate-pm-patterns.ps1

# Spot-check new content
Select-String -Path "docs/pm-agents.md" -Pattern "RE\+W-QA"
Select-String -Path "docs/pm-agents.md" -Pattern "QUALITY-GATE-REPORT"
Select-String -Path "docs/pm-agents.md" -Pattern "docs/qa/gate-report"
```

### Manual Verification Steps

1. Open `docs/pm-agents.md` — skim Agent Roster table: QAEngineer tier cell reads `Tier RE+W-QA`
2. skim Permission Tiers table: `RE+W-QA` row present with correct write scope
3. Locate Workflow F: final `→` lines show file write then PM reads (two lines, not one)
4. Immediately after Workflow F code block: `QUALITY-GATE-REPORT:` block visible with all fields

### Success Criteria (observable)

- `Select-String` for `RE\+W-QA` returns at least 3 matches (Agent Roster row, Permission Tiers table row, and the Note paragraph below the tier table)
- `Select-String` for `QUALITY-GATE-REPORT` returns at least 2 matches (observable state paragraph + YAML block key)
- `validate-pm-patterns.ps1` outputs `✅ All checks passed.`

---

## Tests

This phase modifies documentation only — no executable code changes. Validation is handled by:

- `scripts/validate-pm-patterns.ps1` for regression (40 checks total: 39 original + 1 new QUALITY-GATE-REPORT check added in step 11)
- Manual grep spot-checks (see Verification section above)

New automated test case: a `QUALITY-GATE-REPORT:` pattern check is added to `scripts/validate-pm-patterns.ps1` in step 11 of the implementation checklist.

---

## Out of Scope

- Updating Phase 1 and Phase 2 commit references
- Creating `docs/qa/` directory (directory creation happens at first file write, not spec time)
