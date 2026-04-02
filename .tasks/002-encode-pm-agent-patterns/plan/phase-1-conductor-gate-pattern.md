# Phase 1 — Conductor Gate Pattern

**Status:** 📋 Planned  
**Files:** `templates/agents/conductor.template.md`, `templates/agents/project-manager.template.md`  
**ADR reference:** ADR-008 §Key Architectural Patterns §2 (Conductor Gate Pattern), §WS-002 (Gate Enforcement), BAS-GATE-001/002/003

---

## Overview

This phase adds two things:

1. **`conductor.template.md`** — a general-purpose `## PM Workflow Gate Enforcement` section that defines the named-gate schema, L1→L3 fail-fast escalation levels, wave sequencing rule, and a `GATE-FAILURE` output block.
2. **`project-manager.template.md`** — a `## Gate Enforcement` section that instantiates the gate pattern for PM workflows: maps BAS-GATE-NNN IDs to Workflow A–F checkpoints, adds explicit pass/fail conditions and fail-fast escalation paths to each checkpoint.

The gate pattern framework lives in the Conductor because it is the orchestration layer responsible for enforcing phase boundaries. The PM-specific instantiation lives in ProjectManager because it is the PM orchestration agent that defines *which* gates exist and *what* the conditions are.

---

## File 1: `templates/agents/conductor.template.md`

### Where to insert

After the `## Agent Capabilities` table (which ends with the **Selection guidance** sub-block) and before `## First Action Protocol`.

Specifically, insert the new section between:
```
- Need file changes (or might need them)? → **Builder**
- Research only? → **Explorer** (cannot run commands)
```
...and...
```
## First Action Protocol
```

### Content to add

```markdown
## PM Workflow Gate Enforcement

When orchestrating PM workflows (ProjectManager, ProductOwner, BusinessAnalyst, ScrumMaster),
each workstream boundary requires an explicit named gate. Gates define observable pass/fail
conditions before the next workstream may begin.

### Named-Gate Schema

Each gate follows this structure:

```
Gate ID:       BAS-GATE-NNN
Phase:         <workstream or phase number>
Pass condition: <observable state that must be true to continue>
Fail condition: <observable state that blocks progression>
Fail-fast escalation: L1 → L2 → L3
```

### Fail-Fast Escalation Levels

| Level | Name                    | Trigger                                       | Action                                                                               |
| ----- | ----------------------- | --------------------------------------------- | ------------------------------------------------------------------------------------ |
| L1    | Workstream owner retry  | Gate condition unmet; failure may be transient | Return to the delegated agent with explicit failure reason; attempt resolution once  |
| L2    | Conductor re-plan       | L1 retry did not resolve the failure           | Conductor revises the phase plan and re-delegates to a different agent or approach   |
| L3    | Halt + surface to user  | L2 re-plan failed OR failure is unrecoverable  | Halt the workflow; emit `GATE-FAILURE` block; present to user and await direction    |

**Never skip escalation levels.** L2 is not available without an L1 attempt. L3 is not available without an L2 re-plan.

### Gate Failure Output

When a gate fails at L3, emit this structured block before halting:

```
GATE-FAILURE:
  gate_id: BAS-GATE-NNN
  phase: <N>
  condition: fail | blocked
  reason: <human-readable explanation>
  escalation_level: L3
  next_action: <explicit instruction to user — e.g. "Resolve PATH-* blocker in WS-001 before resuming Wave 2">
```

### Wave Sequencing Rule

When tasks are organized into dependency waves, a wave may NOT begin until all gates for
the preceding wave have passed:

- Verify all `BAS-GATE-NNN` pass conditions for Wave N before assigning the first task of Wave N+1
- If any Wave N gate is in `fail` or `blocked` state, the wave N+1 task MUST NOT be delegated
- Record each gate resolution in `task.md` before proceeding

**Rationalization prevention for gate sequencing:**

| Excuse                                              | Reality                                            | Required Action                                     |
| --------------------------------------------------- | -------------------------------------------------- | --------------------------------------------------- |
| "This gate failure is minor, Wave 2 can start"      | Unresolved gates propagate failures downstream     | Complete L1→L2→L3 escalation before progressing     |
| "The agent said it was done, that's good enough"    | Agent reports are not gate-pass evidence           | Check observable pass condition explicitly          |
| "We can fix the gate issue in parallel with Wave 2" | Wave 2 depends on Wave 1 outputs                   | Wave 2 is blocked until gate resolves               |
```

---

## File 2: `templates/agents/project-manager.template.md`

### Where to insert

After the `## Checkpoint Decision Options` section (which ends with "Do not auto-resume the workflow; wait for explicit user direction.") and before `## Checkpoint Enforcement Rules`.

Specifically, insert between:
```
**PM Responsibility at Escalation:** Upon escalation, pause the workflow, document the escalation reason, and present the decision point to a human reviewer (user or domain expert) with context and options. Do not auto-resume the workflow; wait for explicit user direction.
```
...and...
```
---

## Checkpoint Enforcement Rules
```

### Content to add

```markdown
---

## Gate Enforcement

PM workflows follow the Conductor Gate Pattern (see Conductor agent). Each workflow boundary
carries a named gate (BAS-GATE-NNN) with explicit pass/fail conditions and a L1→L2→L3
fail-fast escalation path.

### Gate Definitions

| Gate ID      | Workstream                   | Pass Condition                                                              | Fail Condition                                                    | Wave   |
| ------------ | ---------------------------- | --------------------------------------------------------------------------- | ----------------------------------------------------------------- | ------ |
| BAS-GATE-001 | WS-001: Path Contracts       | All tool-invocation paths verified as absolute; no pending PATH-* blockers  | Any path unresolved or relative; PATH-* blocker still open        | Wave 1 |
| BAS-GATE-002 | WS-002: Gate Enforcement     | Gate preconditions active in all PM agents; L1/L2/L3 recovery routes tested | Gate structure absent or untested in any PM agent                 | Wave 2 |
| BAS-GATE-003 | WS-003: Ingestion Pipeline   | Ingestion paths resolved; INGESTION-DECISION blocks emitted on failures     | Any ingestion step silently fails; no decision block emitted      | Wave 1 |

**Wave sequencing:** Wave 2 (WS-002: Gate Enforcement; WS-005: Handoff Triggers) may begin only after
BAS-GATE-001 and BAS-GATE-003 pass.

### Checkpoint Fail-Fast Escalation Map

Each checkpoint (CP-XX) maps to a gate and carries defined fail conditions and escalation paths:

#### Workflow A — Resource Ingestion

| Checkpoint | Gate      | Unrecoverable Fail Condition                          | L1 Retry Action                        | L2 Re-plan Trigger                             | L3 Halt Condition                              |
| ---------- | --------- | ----------------------------------------------------- | -------------------------------------- | ---------------------------------------------- | ---------------------------------------------- |
| CP-A1      | BAS-GATE-003 | Document type cannot be determined after 2 attempts | Return to ProductOwner: re-classify    | Conductor proposes alternate classification    | Resource type unknown and not in manifest; emit `GATE-FAILURE` |
| CP-A2      | BAS-GATE-003 | Template application errors (malformed metadata)    | Return to ProductOwner: fix metadata   | Conductor re-delegates with corrected template | Metadata schema unavailable; emit `GATE-FAILURE` |
| CP-A3      | BAS-GATE-001 | Target path does not exist after path validation    | Return to ProductOwner: resolve path   | Conductor checks path contracts (BAS-GATE-001) | Path fundamentally unresolvable; emit `GATE-FAILURE` |

#### Workflow B — Stakeholder Feedback

| Checkpoint | Gate      | Unrecoverable Fail Condition                             | L1 Retry Action                              | L2 Re-plan Trigger                           | L3 Halt Condition                             |
| ---------- | --------- | -------------------------------------------------------- | -------------------------------------------- | -------------------------------------------- | --------------------------------------------- |
| CP-B1      | —         | Feedback source unavailable / no verbatim content        | Return to ProductOwner: request re-submission | Conductor contacts stakeholder for clarification | No feedback content after L2; halt           |
| CP-B2      | —            | No guardrail matched after 2 mapping attempts         | Return to ProductOwner: remap with fresh context | Conductor revises guardrail reference set  | Guardrail taxonomy missing; emit `GATE-FAILURE` |
| CP-B3      | —         | Actionable insight count = 0 after two passes            | Return to ProductOwner: re-extract           | Conductor flags for manual insight extraction | Insight extraction impossible; halt and report |

#### Workflow C — Requirements Cascade

| Checkpoint | Gate      | Unrecoverable Fail Condition                               | L1 Retry Action                          | L2 Re-plan Trigger                         | L3 Halt Condition                              |
| ---------- | --------- | ---------------------------------------------------------- | ---------------------------------------- | ------------------------------------------ | ---------------------------------------------- |
| CP-C1      | BAS-GATE-001 | REVIEW_WORKFLOW.md dependency matrix not found           | Return to ProductOwner: locate file      | Conductor re-checks path contracts         | Dependency matrix absent; emit `GATE-FAILURE`  |
| CP-C2      | —         | Requirements document update fails (write error)           | Return to BusinessAnalyst: retry update   | Conductor re-delegates to Worker           | Cannot write requirements; halt                |
| CP-C3      | —         | Secondary impact identified that expands requirements scope | Return to BusinessAnalyst: scope decision | Escalate to human reviewer (scope change) | Scope change confirmed; halt for approval      |
| CP-C4      | —         | Stakeholder approval withheld with contradictory direction | Return clarifications to stakeholder     | Conductor documents conflict               | Unresolvable conflict; halt for user decision  |

#### Workflow D — Diagram Lifecycle

| Checkpoint | Gate      | Unrecoverable Fail Condition                         | L1 Retry Action                            | L2 Re-plan Trigger                        | L3 Halt Condition                              |
| ---------- | --------- | ---------------------------------------------------- | ------------------------------------------ | ----------------------------------------- | ---------------------------------------------- |
| CP-D1      | —         | Diagram content incorrect after reviewer feedback    | Return to UIUXDesigner: apply feedback     | Conductor reassigns diagram to new drafter | Diagram cannot be corrected; halt             |
| CP-D2      | BAS-GATE-001 | Render script fails; PNG not produced             | Return to UIUXDesigner: fix syntax         | Conductor checks render-script path       | Render tool absent; emit `GATE-FAILURE`        |
| CP-D3      | —         | Target document cannot receive diagram link          | Return to UIUXDesigner: fix doc reference  | Conductor re-checks document path         | Document path invalid; halt                    |
| CP-D4      | —         | Manifest update fails                                | Return to UIUXDesigner: update manifest    | Conductor re-checks manifest path         | Manifest path invalid; halt                    |

#### Workflow E — Backlog Planning

| Checkpoint | Gate      | Unrecoverable Fail Condition                             | L1 Retry Action                              | L2 Re-plan Trigger                            | L3 Halt Condition                              |
| ---------- | --------- | -------------------------------------------------------- | -------------------------------------------- | --------------------------------------------- | ---------------------------------------------- |
| CP-E1      | —         | Backlog items have no MoSCoW labels after revision       | Return to ProductOwner: apply labels         | Conductor re-delegates with label guidance    | No items can be prioritized; halt              |
| CP-E2      | —         | Phase alignment impossible (conflicting priorities)      | Return to ProductOwner: resolve conflict     | Escalate to human reviewer (phase decision)   | Conflict unresolvable; halt for user decision  |
| CP-E3      | —         | Sprint plan missing mandatory estimates                  | Return to ScrumMaster: add estimates         | Conductor re-delegates with estimate template | Estimation data unavailable; halt              |
| CP-E4      | —         | Capacity exceeded after scope reduction                  | Return to ScrumMaster: reduce further        | Conductor advises scope cut to human reviewer  | No viable scope fits capacity; halt            |

#### Workflow F — Quality Gate Review

| Checkpoint | Gate      | Unrecoverable Fail Condition                              | L1 Retry Action                           | L2 Re-plan Trigger                         | L3 Halt Condition                              |
| ---------- | --------- | --------------------------------------------------------- | ----------------------------------------- | ------------------------------------------ | ---------------------------------------------- |
| CP-F1      | —         | Test suite cannot execute (infra failure)                 | Return to QAEngineer: fix environment     | Conductor escalates to infra team          | Environment unrecoverable; halt                |
| CP-F2      | —         | Test results file missing or unreadable                   | Return to QAEngineer: re-run              | Conductor re-checks results path           | Results unrecoverable; halt                    |
| CP-F3      | —         | Tests fail with no reproducible fix path after 2 retries  | Return to developer: investigate failures | Conductor creates rework task              | Failure root cause unidentifiable; halt        |
| CP-F4      | —         | Acceptance criteria contradict test results (spec conflict) | Return to BusinessAnalyst: clarify spec  | Escalate spec conflict to human reviewer  | Spec unresolvable; halt for user decision      |

### Gate State Tracking

When reporting checkpoint results, record gate state transitions in `task.md`:

```
Gate BAS-GATE-001: ⬜ Not Checked → ✅ Pass | ❌ Fail (L1 in progress) | 🚫 Blocked (L3)
Gate BAS-GATE-002: ⬜ Not Checked → ✅ Pass | ❌ Fail (L1 in progress) | 🚫 Blocked (L3)
Gate BAS-GATE-003: ⬜ Not Checked → ✅ Pass | ❌ Fail (L1 in progress) | 🚫 Blocked (L3)
```
```

---

## Implementation Checklist

- [x] **conductor.template.md** — Insert `## PM Workflow Gate Enforcement` section after Agent Capabilities → Selection guidance block, before `## First Action Protocol`
- [x] **conductor.template.md** — Verify the section renders correctly in context (no heading level conflicts with surrounding `##` sections)
- [x] **project-manager.template.md** — Insert `## Gate Enforcement` section after Checkpoint Decision Options block (`...wait for explicit user direction.`), before `---\n\n## Checkpoint Enforcement Rules`
- [x] **project-manager.template.md** — Verify each CP-XX entry referenced in Gate Enforcement tables matches exactly the CP labels already in the Workflow step sequences above
- [x] **project-manager.template.md** — Confirm existing `**Failure Path:**` narrative entries in each workflow step remain; Gate Enforcement tables extend rather than replace them

---

## Out of Scope

- Phase 2 PM-tool recommendation logic (separate phase)
- INGESTION-DECISION block format in ProductOwner/BusinessAnalyst templates (Phase 3)
- Role boundary must-not-do guards (Phase 5)
- Regeneration and install (Phase 6)

---

## Tests

These are markdown template files — no automated test suite executes them. Behavioral verification follows the validate-skills.sh / test-generate.sh pattern from the repo. Tests for this phase cover:

**1. Gate schema completeness (static analysis)**  
After implementation, all three BAS-GATE-NNN IDs must appear in the gate definitions table in `project-manager.template.md`. Check:
```bash
grep -c "BAS-GATE-00[123]" templates/agents/project-manager.template.md
# Expected: 3 (one match per gate ID minimum; more OK)
```

**2. Escalation level presence in conductor.template.md**  
All three escalation level labels must appear:
```bash
grep -cE "L1|L2|L3" templates/agents/conductor.template.md
# Expected: ≥ 3
```

**3. GATE-FAILURE block present in conductor.template.md**
```bash
grep -c "GATE-FAILURE" templates/agents/conductor.template.md
# Expected: ≥ 1
```

**4. Wave sequencing rule present**
```bash
grep -c "Wave 2 may begin" templates/agents/project-manager.template.md
# Expected: 1
```

**5. Propagation to generated files (post Phase 6)**  
After `make && ./install.sh`, the generated agents should carry the gate pattern text:
```bash
grep -c "BAS-GATE-001" generated/copilot/agents/project-manager.agent.md
# Expected: ≥ 1
grep -c "PM Workflow Gate Enforcement" generated/copilot/agents/conductor.agent.md
# Expected: ≥ 1
```

---

## Verification

### Automated Checks

```bash
# 1. Static grep checks (run after Builder completes)
grep "BAS-GATE-001" templates/agents/project-manager.template.md
grep "BAS-GATE-002" templates/agents/project-manager.template.md
grep "BAS-GATE-003" templates/agents/project-manager.template.md
grep "GATE-FAILURE" templates/agents/conductor.template.md
grep "L3" templates/agents/conductor.template.md
grep "Wave 2 may begin" templates/agents/project-manager.template.md

# 2. Ensure no existing template markers broken
make validate
```

### Manual Verification Steps

1. **Open `templates/agents/conductor.template.md`** — confirm `## PM Workflow Gate Enforcement` appears between `## Agent Capabilities` and `## First Action Protocol` with correct heading level (`##`).

2. **Open `templates/agents/project-manager.template.md`** — confirm `## Gate Enforcement` appears between the Checkpoint Decision Options block and the `## Checkpoint Enforcement Rules` heading. Confirm the Gate Definitions table renders the three BAS-GATE-NNN rows correctly.

3. **Scan each workflow (A–F)** in `project-manager.template.md` — confirm existing `**Failure Path:**` narratives are intact (Gate Enforcement tables are additive; nothing removed).

### Success Criteria

- `## PM Workflow Gate Enforcement` present in `conductor.template.md` with all three components: named-gate schema, L1/L2/L3 escalation levels, and `GATE-FAILURE` output block
- `## Gate Enforcement` present in `project-manager.template.md` with BAS-GATE-001/002/003 gate definitions table and checkpoint escalation maps for all 6 workflows (CP-A through CP-F)
- Wave sequencing rule encoded in both templates
- No existing content removed or reformatted; all changes are additive
- `make validate` passes with no errors
