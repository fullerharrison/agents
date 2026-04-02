---
task: PM Agent System Critical Fixes
slug: pm-agent-critical-fixes
created: 2026-03-27
status: done
---

# PM Agent System Critical Fixes

Three targeted fixes for broken or under-specified contracts in `docs/pm-agents.md`.

## Phases

| #   | Phase                                      | Status         | Plan | Notes                                                  |
| --- | ------------------------------------------ | -------------- | ---- | ------------------------------------------------------ |
| 1   | Resolve Missing Builder Agent              | ✅ Done        | [phase-1-fix-builder-agent.md](plan/phase-1-fix-builder-agent.md) | Builder added to Agent Roster (Tier F), Permission Tiers, Handoff Contracts (2 outbound rows), and Role Boundaries; agent count updated to ten-agent. Committed: 44d8970 |
| 2   | Constrain the Worker Agent (Tier F)        | ✅ Done        | [phase-2-constrain-worker-agent.md](plan/phase-2-constrain-worker-agent.md) | Worker constrained with WORKER-INVOCATION, WORKER-SCOPE-DECLARATION (HITL gate), and WORKER-ACTION-LOG; Tier F split into Builder (full) and Worker (scoped per invocation); delegated scope undefined risk closed. Committed: a60ea0b |
| 3   | Restore QAEngineer Write for Test Artifacts | ✅ Done        | [phase-3-restore-qa-write.md](plan/phase-3-restore-qa-write.md) | QAEngineer upgraded to RE+W-QA, QUALITY-GATE-REPORT block added, template disallowedTools updated, 40 validation checks pass. Committed: b709837, 2a40775. ADR-010 created: 17dfbc3 |

**Status:** ⬜ Not Started → 📋 Planned → ⭐ Reviewed → 🔄 In Progress → ✅ Done

## Overview

The PM Agent System spec (`docs/pm-agents.md`) has three specification-level defects:
1. The Handoff Contracts reference a Builder agent not present in the Agent Roster
2. Worker (Tier F) has unrestricted "delegated scope" with no guardrails
3. QAEngineer cannot produce the quality gate reports Workflow F requires

All changes target `docs/pm-agents.md`. Template files in `templates/agents/` may need corresponding updates if patterns are encoded there.

## Goal

All agent names in handoff contracts resolve to roster entries. Worker scope is constrained and auditable per invocation. QAEngineer can produce test artifacts in a controlled write scope.

---

## Research Findings

### Current State of `docs/pm-agents.md`

- **Agent Roster** (9 agents): ProjectManager, ProductOwner, ScrumMaster, BusinessAnalyst, FrontendDev, BackendDev, QAEngineer, UIUXDesigner, Worker
- **Permission Tiers**: R, W, RE, RW-D, F, Orchestrator
- **Handoff Contracts** (8 rows) — see audit below
- **Six Workflows**: A–F, with Workflow F (Quality Gate Review) relying on QAEngineer

### Handoff Contract Audit

| From → To                          | Defined in Roster? | Status |
| ---------------------------------- | ------------------- | ------ |
| ProductOwner → BusinessAnalyst     | ✅ Both defined     | OK     |
| ProductOwner → ScrumMaster         | ✅ Both defined     | OK     |
| ProductOwner → Worker              | ✅ Both defined     | OK     |
| ScrumMaster → **Builder**          | ❌ Builder missing  | BROKEN |
| QAEngineer → ProjectManager        | ✅ Both defined     | OK     |
| FrontendDev / BackendDev → PM      | ✅ All defined      | OK     |
| UIUXDesigner → ProjectManager      | ✅ Both defined     | OK     |
| Any agent → ProjectManager         | ✅ Catch-all        | OK     |

**Only one broken reference**: `Builder` in the ScrumMaster → Builder handoff.

### Builder Agent in the Framework

- **Template exists**: `templates/agents/builder.template.md` — full implementation agent with Tier F access, Worker as subagent, handoffs to Reviewer and Committer
- **Generated agent exists**: `generated/copilot/agents/builder.agent.md`
- **ScrumMaster template already hands off to Builder**: `handoffs: [{ label: "Implement Phase", agent: Builder }]`
- **Builder's role**: Execute approved implementation plans — reads `.tasks/` plans, has full file access, runs tests, delegates to Worker for isolated sub-tasks
- **Worker's role**: Context-isolated task execution — binary conversion, small fixes, no orchestration

### Phase 1 Decision: Option A vs Option B

**Recommendation: Option A — Add Builder to the roster.**

Reasoning:
1. **Builder already exists** as a template and generated agent in this framework
2. **ScrumMaster template already defines the handoff** (`label: Implement Phase, agent: Builder`) — the pm-agents.md handoff contract is documenting real behavior
3. **Builder ≠ Worker** — they serve fundamentally different purposes:
   - Builder: orchestrates full implementation plans, manages phases, has Reviewer/Committer handoffs
   - Worker: executes small isolated tasks (binary conversion, resource transformation), no orchestration
4. **Replacing Builder with Worker (Option B) would be semantically wrong** — when ScrumMaster approves an implementation plan, it needs Builder (the implementation orchestrator), not Worker (isolated task executor)
5. **Precedent exists** — Worker is already in the roster despite being a framework agent, not a PM-specific role. Builder follows the same pattern as a cross-system handoff target.

Builder should be added as a non-user-invokable agent (like Worker) since users interact with ScrumMaster, who hands off to Builder when ready.

### Worker Tier F Analysis

- Current tier: `F` — "All | All (delegated scope) | Controlled"
- "Delegated scope" is referenced but never defined anywhere in the document
- No mechanism exists to constrain what Worker can do on a per-invocation basis
- No audit trail for Worker actions
- Worker template (`worker.template.md`) says "Full access: Can read, edit, and create files" and "Complete ONLY the task given by your parent" — but this is an honor-system constraint, not an enforced one

### QAEngineer Tier RE Analysis

- Current tier: `RE` — "All project files | ❌ | Tests only"
- No write capability at all
- Workflow F says: `→ Quality gate report → ProjectManager decision → proceed or hold`
- But QAEngineer cannot produce written artifacts — it can only report inline
- Template (`qa-engineer.template.md`): explicit `disallowedTools: ["Write", "Edit", "MultiEdit", "Task"]`
- The template and spec are consistent (no write), but Workflow F implicitly requires write capability for gate reports

---

## Phase 1 — Resolve Missing Builder Agent

### Problem
`ScrumMaster → Builder` handoff contract references an agent not in the Agent Roster or Permission Tiers table.

### Fix (Option A — Add Builder)

**Sections to modify in `docs/pm-agents.md`:**

1. **Agent Roster table** (line ~10): Add row:
   ```
   | **Builder** | Tier F (full access) | Implementation plan execution, code changes, test runs | No |
   ```

2. **Permission Tiers table** (line ~25): Add/update Tier F row to list both Worker and Builder:
   ```
   | **F** | All | All (delegated scope) | Controlled | Worker, Builder |
   ```

3. **Handoff Contracts table** (line ~205): No change needed — the `ScrumMaster → Builder` row is now valid.

4. **Opening sentence**: Update "seven-agent" count if it was based on the original count (currently says "seven-agent" but roster has 9 agents). After adding Builder, roster will have 10. Verify the intended count and update.

5. **"How to Invoke" section**: Confirm Builder is NOT listed (it's not user-invokable). No change needed.

### Verification
- Every agent name in the Handoff Contracts table resolves to a row in the Agent Roster
- Builder appears in Agent Roster, Permission Tiers
- No duplicate tier definitions
- Count in opening paragraph matches roster size

### Tests
- `scripts/validate-pm-patterns.ps1` should still pass (39 checks)
- `make validate` clean
- Manual: grep all agent names in handoff contracts, confirm each exists in roster

---

## Phase 2 — Constrain the Worker Agent (Tier F)

### Problem
Worker has Tier F (full access) with "delegated scope" that is never defined. No mechanism constrains what Worker does or logs what it did.

### Fix

**Sections to modify in `docs/pm-agents.md`:**

1. **Permission Tiers table**: Change Worker's Tier F entry:
   ```
   | **F** | All | All (scoped per invocation) | Controlled | Worker, Builder |
   ```

2. **New section after Permission Tiers** — "Worker Invocation Protocol":

   Add a `WORKER-SCOPE-DECLARATION` structured block specification:
   ```
   WORKER-SCOPE-DECLARATION:
     invoking_agent: <parent agent name>
     task:           <one-sentence task description>
     write_scope:    <list of allowed paths/patterns>
     execute_scope:  <list of allowed commands>
     approval:       required | pre-approved
   ```
   - HITL gate: If `approval: required`, Worker must pause for user confirmation before any write/execute action
   - Pre-approved: Only for well-known operations already listed (e.g., binary conversion to learning_base/)

3. **New structured block** — `WORKER-ACTION-LOG`:
   ```
   WORKER-ACTION-LOG:
     task:       <original task>
     actions:
       - type: write | execute | read
         target: <file path or command>
         result: success | failed
     summary:    <one-sentence outcome>
   ```
   - Emitted after every Worker invocation completes

4. **Update Worker row in Agent Roster**: Change "Tier F (full access)" to "Tier F (scoped per invocation)"

5. **Update Handoff Contract** for `ProductOwner → Worker`: Add note about scope declaration requirement

### Verification
- Permission Tiers table shows "scoped per invocation" for Worker
- WORKER-SCOPE-DECLARATION block is fully specified with all fields
- WORKER-ACTION-LOG block is fully specified
- Worker row in Agent Roster reflects new tier label
- Existing Worker invocation paths (ProductOwner → Worker for binary conversion) still work under the new protocol

### Tests
- `scripts/validate-pm-patterns.ps1` — verify it doesn't break (may need update if it checks Worker tier)
- Manual: trace ProductOwner → Worker binary conversion path through new protocol to confirm it's coherent

---

## Phase 3 — Restore QAEngineer Write Capability for Test Artifacts

### Problem
QAEngineer has Tier RE (read + execute, no write) but Workflow F requires producing quality gate reports. QAEngineer can run tests but cannot save results as artifacts.

### Fix

**Sections to modify in `docs/pm-agents.md`:**

1. **Permission Tiers table**: Add new tier row:
   ```
   | **RE+W-QA** | All project files | docs/qa/ only | Tests only | QAEngineer |
   ```

2. **Agent Roster table**: Update QAEngineer row:
   ```
   | **QAEngineer** | Tier RE+W-QA | Test planning, test execution, coverage analysis, quality gates | Yes |
   ```

3. **Workflow F section** (~line 170): Update to show QAEngineer writes gate-report files:
   ```
   QAEngineer: Define acceptance criteria → run test suite
     → Collect pass/fail metrics and coverage report
     → Write quality gate report to docs/qa/gate-report-<sprint>.md
     → Assess readiness against quality gates
     CP-F1: Test suite passed?
     CP-F2: Coverage threshold met?
     CP-F3: No critical failures?
   → Quality gate report in docs/qa/ → ProjectManager decision → proceed or hold
   ```

4. **New structured block** — `QUALITY-GATE-REPORT`:
   ```
   QUALITY-GATE-REPORT:
     sprint:          <sprint identifier>
     date:            <ISO date>
     test_summary:
       total:         <N>
       passed:        <N>
       failed:        <N>
       skipped:       <N>
       coverage:      <percentage>
     acceptance_criteria:
       met:           <list>
       unmet:         <list>
     gate_decision:   pass | fail | conditional
     blockers:        <list or "none">
     recommendation:  <one-sentence recommendation for PM>
     output_file:     docs/qa/gate-report-<sprint>.md
   ```

5. **Template consideration**: `templates/agents/qa-engineer.template.md` currently has `disallowedTools: ["Write", "Edit", "MultiEdit", "Task"]` (CC config). If the spec change is approved, the template will also need updating to allow limited write tools. This is a downstream change to track but is NOT part of this spec fix — the spec defines the desired behavior; template enforcement follows separately.

### Verification
- Permission Tiers table has RE+W-QA row
- Agent Roster shows QAEngineer with Tier RE+W-QA
- Workflow F references `docs/qa/` as output location
- QUALITY-GATE-REPORT block is fully specified with all fields
- Write scope is constrained to `docs/qa/` only — no broader write access

### Tests
- `scripts/validate-pm-patterns.ps1` — verify it doesn't break
- Manual: trace Workflow F from entry to gate report output, confirm QAEngineer can produce the artifact
- Manual: confirm no other section grants QAEngineer broader write access than `docs/qa/`

---

## Out of Scope

- Template file changes (`templates/agents/*.template.md`) — these are downstream of the spec and should be handled in a separate task after spec approval
- Changes to `generated/` files — these are auto-generated from templates via `make`
- Workflow restructuring beyond what's needed for these three fixes
- Adding new workflows or agents beyond Builder
