# Phase 2 — Constrain the Worker Agent (Tier F)

**Task:** 003-pm-agent-critical-fixes  
**Target file:** `docs/pm-agents.md`  
**Date:** 2026-03-27

---

## Problem

Worker is listed as Tier F ("full access") with the only constraint being `All (delegated scope)` — but "delegated scope" is never defined anywhere in the spec. This is the highest-risk agent in the system (non-user-invokable, no orchestration role, full read/write/execute) and currently has no:

- Per-invocation scope declaration
- HITL gate before write actions
- Action audit trail
- Defined forbidden actions

Builder also holds Tier F but is a trusted framework agent operating under Conductor oversight with user-visible phase plans. Worker receives raw delegation with no equivalent safeguard.

---

## Tier Row Decision

The current single `Tier F` row (`Worker, Builder`) must be **split into two rows**:

| Tier | Read | Write | Execute | Who |
|---|---|---|---|---|
| **F** | All | All | Controlled | Builder |
| **F** *(scoped per invocation)* | All | All — WORKER-INVOCATION required | Controlled — HITL gate before write | Worker |

**Rationale:** Builder runs full implementation phases under Conductor oversight with user-visible `.tasks/` plans — its full access is accepted risk. Worker receives ad-hoc delegation with no pre-existing plan artifact; it needs a mandatory invocation envelope to compensate. Keeping both in "Tier F" preserves the permission level (both can read/write/execute everything) while distinguishing the _constraint mechanism_ that applies to each.

---

## Exact Changes to `docs/pm-agents.md`

### Change 1 — Agent Roster: Worker row description

**Line 20.** Replace:

```
| **Worker** | Tier F (full access) | Binary conversion, resource transformation, context-isolated tasks | No |
```

With:

```
| **Worker** | Tier F (scoped per invocation) | Binary conversion, resource transformation, context-isolated tasks — requires WORKER-INVOCATION scope declaration and HITL approval before any write action | No |
```

---

### Change 2 — Permission Tiers: Split Tier F row

**Line 30.** Replace the single Tier F row:

```
| **F** | All | All (delegated scope) | Controlled | Worker, Builder |
```

With two rows:

```
| **F** | All | All | Controlled | Builder |
| **F** *(scoped per invocation)* | All | All — WORKER-INVOCATION required | Controlled — HITL gate before write | Worker |
```

---

### Change 3 — New section: Worker Invocation Protocol

Add a new `## Worker Invocation Protocol` section immediately **after the Permission Tiers table** (after `---` that follows the Permission Tiers table, before `## How to Invoke`).

Insert the following block:

````markdown
## Worker Invocation Protocol

Worker is **not user-invokable**. It is invoked by delegating agents (ProductOwner, ScrumMaster, Builder, or Conductor). Every invocation must include a WORKER-INVOCATION scope block regardless of which agent delegates. Worker must emit a `WORKER-SCOPE-DECLARATION` gate before any write or execute action.

### WORKER-INVOCATION (emitted by parent agent)

The delegating agent must emit this block before handing off to Worker:

```yaml
WORKER-INVOCATION:
  invoked_by:        <agent name>
  authorized_by:     ProjectManager
  allowed_actions:   [explicit list]
  forbidden_actions:
    - write to docs/, specs/, templates/, generated/
    - execute test suites
    - modify agent config files
    - invoke other agents or spawn subagents
  scope_expires:     on task completion
```

### WORKER-SCOPE-DECLARATION (emitted by Worker before any write or execute)

Before Worker takes any write or execute action, it must emit this block and **halt until the user approves**:

```yaml
WORKER-SCOPE-DECLARATION:
  task:              <one-sentence task description>
  write_targets:     [list of files/directories to be written]
  invoked_by:        <agent name>
  awaiting_approval: true
```

Worker must not proceed until an approval keyword is received. On rejection, Worker emits a `WORKER-ACTION-LOG` with `status: partial` and halts.

### WORKER-ACTION-LOG (emitted by Worker after every write or execute)

After each write or execute action (approved or failed), Worker must emit:

```yaml
WORKER-ACTION-LOG:
  action:      <what was done>
  target:      <file or resource affected>
  invoked_by:  <delegating agent>
  timestamp:   <ISO 8601>
  status:      success | failed | partial
```

### Default Forbidden Actions

Unless explicitly overridden in `forbidden_actions` by ProjectManager, Worker may never:

- Write to `docs/`, `specs/`, `templates/`, `generated/`
- Execute test suites
- Modify agent config files (`.instructions.md`, `.agent.md`, `SKILL.md`)
- Invoke other agents or spawn subagents

### Approval / Rejection Keywords

| Intent | Keywords |
|---|---|
| Approve | `proceed`, `confirm`, `approved` |
| Reject | `cancel`, `stop`, `reject` |

---
````

---

### Change 4 — Handoff Contracts: Augment ProductOwner → Worker row

**Line 205.** Replace:

```
| ProductOwner | Worker | Binary resource conversion needed (.docx, .eml) |
```

With:

```
| ProductOwner | Worker | Binary resource conversion needed (.docx, .eml) — Worker emits WORKER-SCOPE-DECLARATION before acting |
```

---

## Implementation Checklist

Builder should apply changes in this order:

1. **Read `docs/pm-agents.md`** in full to confirm current state matches the "before" strings above (Phase 1 already applied — Builder row is in the roster).

2. **Change 1 — Worker row in Agent Roster (line ~20):**  
   Replace the Worker description text as specified above.

3. **Change 2 — Permission Tiers table (line ~30):**  
   Replace the single `Tier F | ... | Worker, Builder` row with two rows (Builder first, Worker second).

4. **Change 3 — Worker Invocation Protocol section:**  
   Insert the full section block immediately after the Permission Tiers closing `---` divider and before `## How to Invoke`.

5. **Change 4 — Handoff Contracts table (line ~205):**  
   Augment the ProductOwner → Worker trigger text.

6. **Verify** no remaining occurrences of "delegated scope" in `docs/pm-agents.md`.

7. **Update `task.md`** phase status for Phase 2 to `✅ Done` and record commit hash.

---

## Tests

No executable test suite covers `docs/pm-agents.md` prose content. The following behavioral checks serve as the test specification:

| Check | Pass Condition |
|---|---|
| "delegated scope" removed | `grep "delegated scope" docs/pm-agents.md` → no matches |
| WORKER-INVOCATION defined | `grep "WORKER-INVOCATION" docs/pm-agents.md` → ≥1 match |
| WORKER-SCOPE-DECLARATION defined | `grep "WORKER-SCOPE-DECLARATION" docs/pm-agents.md` → ≥1 match |
| WORKER-ACTION-LOG defined | `grep "WORKER-ACTION-LOG" docs/pm-agents.md` → ≥1 match |
| Worker tier updated in roster | `grep "Tier F (scoped per invocation)" docs/pm-agents.md` → ≥1 match |
| Tier F split: Builder row exists | `grep "Controlled \| Builder" docs/pm-agents.md` → 1 match |
| Forbidden actions listed | `grep "forbidden_actions" docs/pm-agents.md` → ≥1 match |
| Approval keywords defined | `grep "proceed.*confirm.*approved" docs/pm-agents.md` → ≥1 match |

---

## Verification

### Automated Checks

```bash
# 1. No residual "delegated scope" language
grep -c "delegated scope" docs/pm-agents.md   # expect 0

# 2. All three Worker protocol blocks are defined
grep -c "WORKER-INVOCATION\|WORKER-SCOPE-DECLARATION\|WORKER-ACTION-LOG" docs/pm-agents.md   # expect ≥ 3

# 3. Worker tier label updated in roster  
grep "Tier F (scoped per invocation)" docs/pm-agents.md  # expect 1 match

# 4. Two Tier F rows in Permission Tiers (Builder + Worker)
grep -c "^\| \*\*F\*\*" docs/pm-agents.md   # expect 2
```

### Manual Verification Steps

1. Open `docs/pm-agents.md` → Agent Roster table: confirm Worker row reads "Tier F (scoped per invocation)" and description includes "HITL approval before any write action".
2. Permission Tiers table: confirm two separate Tier F rows — one for Builder (plain), one for Worker (scoped).
3. New `## Worker Invocation Protocol` section: confirm all three blocks (WORKER-INVOCATION, WORKER-SCOPE-DECLARATION, WORKER-ACTION-LOG), default forbidden actions, and approval/rejection keyword table are present.
4. Handoff Contracts: confirm ProductOwner → Worker row includes "Worker emits WORKER-SCOPE-DECLARATION before acting".

### Success Criteria

- Zero occurrences of "delegated scope" remaining in the document
- All three WORKER-* structured blocks fully defined with required fields
- Permission Tiers table has exactly two Tier F rows (Builder / Worker)
- No undefined references: every term introduced in the Worker Invocation Protocol is self-contained within the new section

---

## CHANGE-RECORD

Append this block to the **Source Traceability** section of `docs/pm-agents.md` after Phase 2 is committed:

```yaml
CHANGE-RECORD:
  phase:            "003-phase-2"
  change-type:      security-constraint
  target:           docs/pm-agents.md
  sections-modified:
    - Agent Roster (Worker row description updated)
    - Permission Tiers (Tier F split: Builder row + Worker scoped row)
    - Worker Invocation Protocol (new section added)
    - Handoff Contracts (ProductOwner → Worker row augmented)
  defect-fixed:     "Worker (Tier F) had unrestricted 'All (delegated scope)' with no guardrails"
  patterns-introduced:
    - WORKER-INVOCATION
    - WORKER-SCOPE-DECLARATION
    - WORKER-ACTION-LOG
  date:             2026-03-27
  commit:           <to be filled on commit>
```

---

## Out of Scope

- `templates/agents/worker.template.md` — the template currently has no invocation protocol. This is a follow-on: once the spec is accepted, encode `WORKER-INVOCATION` / `WORKER-SCOPE-DECLARATION` / `WORKER-ACTION-LOG` into the worker template so generated agents carry these patterns. Track as a future task (suggest: Phase 2.5 or a separate task).
- `scripts/validate-pm-patterns.ps1` — new grep checks for the three WORKER-* patterns should be added after the template is updated. Not in scope for this phase.
