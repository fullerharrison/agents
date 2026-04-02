# Phase 1: Resolve Missing Builder Agent

**Task:** 003-pm-agent-critical-fixes  
**Phase:** 1 of 3  
**File to edit:** `docs/pm-agents.md`  
**Status:** 📋 Planned

---

## Problem

The Handoff Contracts table in `docs/pm-agents.md` contains:

> `ScrumMaster → Builder: "Implementation plan approved, ready to execute"`

However, **Builder does not appear in the Agent Roster or Permission Tiers table**.  
This is a broken reference — the PM system documents a handoff to an agent that is not specified.

---

## Resolution: Add Builder to the Agent Roster

Builder already exists as a full framework agent (`templates/agents/builder.template.md`,  
`generated/copilot/agents/builder.agent.md`). The fix is documentation — add Builder to the spec.

---

## Exact Changes to `docs/pm-agents.md`

### Change 1 — Agent Roster table: Add Builder row

**Location:** `## Agent Roster` section, table after the heading.

Add the following row **after the `Worker` row** (Worker is currently the last row):

```markdown
| **Builder** | Tier F (full access) | Execute approved implementation plans: file edits, code generation, test runs, terminal commands | Yes |
```

**Rationale for each column value:**
- `Tier F (full access)`: builder.template.md grants all edit/write/execute tools (createFile, editFiles, runInTerminal, runTests, Bash, Write). Matches Worker's tier.
- `Role Summary`: sourced directly from builder.template.md description and capabilities section.
- `User-Invokable: Yes`: builder.template.md does NOT include `user-invokable: false` (unlike Worker which has `user-invokable: false`). Builder is invoked directly by users via `@Builder` or `--agent Builder`.
  > **Override note:** This overrides the earlier recommendation in `task.md` (which suggested non-user-invokable). The override is justified because: (1) builder.template.md carries no `user-invokable: false` flag, unlike Worker which explicitly sets it; (2) Builder's description reads as user-facing; and (3) the PM workflow context (ScrumMaster → Builder) does not preclude Builder from also being directly invokable.

The full updated roster table for reference:

| Agent | Permission Tier | Role Summary | User-Invokable |
|---|---|---|---|
| **ProjectManager** | Read-only orchestrator | Routes tasks, enforces checkpoints, coordinates all six workflows | No |
| **ProductOwner** | Tier W (targeted write) | Stakeholder intake, VoC creation, backlog grooming, cascade triggering | Yes |
| **ScrumMaster** | Tier W (targeted write) | Sprint planning, epic breakdown, implementation plan management | Yes |
| **BusinessAnalyst** | Tier W (targeted write) | Requirements authoring, PRD creation, specification updates, Teams Planner output | Yes |
| **FrontendDev** | Tier R (read-only) | UI/frontend advisory, accessibility, component pattern guidance | Yes |
| **BackendDev** | Tier R (read-only) | Backend/API advisory, infrastructure analysis, data pipeline guidance | Yes |
| **QAEngineer** | Tier RE (read + execute) | Test planning, test execution, coverage analysis, quality gates | Yes |
| **UIUXDesigner** | Tier RW-D (diagrams only) | Diagram lifecycle, Mermaid workflow, UX design guidance | Yes |
| **Worker** | Tier F (full access) | Binary conversion, resource transformation, context-isolated tasks | No |
| **Builder** | Tier F (full access) | Execute approved implementation plans: file edits, code generation, test runs, terminal commands | Yes |

---

### Change 2 — Permission Tiers table: Update Tier F "Who" column

**Location:** `### Permission Tiers` section, Tier F row.

**Current row:**
```markdown
| **F** | All | All (delegated scope) | Controlled | Worker |
```

**Updated row:**
```markdown
| **F** | All | All (delegated scope) | Controlled | Worker, Builder |
```

No new tier is needed. Builder's toolset (read/write all files, run terminal commands, run tests) matches the existing Tier F definition exactly. The only change is adding Builder to the "Who" column.

---

### Change 3 — Handoff Contracts table: Verify existing row + add Builder outbound handoffs

**Existing row (correct — no change needed):**
```markdown
| ScrumMaster | Builder | Implementation plan approved, ready to execute |
```
This row accurately reflects the `templates/agents/scrum-master.template.md` handoff:
```yaml
- label: Implement Phase
  agent: Builder
  prompt: Implement the plan that was just created, referencing the saved plan file.
```

**Add two outbound rows from Builder** immediately after the `ScrumMaster → Builder` row:

```markdown
| Builder | QAEngineer | Implementation phase complete — trigger quality gate review (Workflow F) |
| Builder | ProjectManager | Phase complete or blocker encountered — status update or escalation |
```

**Rationale:**
- Builder → QAEngineer: When Builder completes implementation, Workflow F (Quality Gate Review) is the natural next step. This closes the ScrumMaster→Builder→QAEngineer chain.
- Builder → ProjectManager: Builder may hit unresolvable blockers (conflicting specs, scope ambiguity) that require orchestrator intervention. Also appropriate for a completion status report when no QA gate is needed.

The updated Handoff Contracts table for reference:

| From | To | Trigger |
|---|---|---|
| ProductOwner | BusinessAnalyst | Requirements need formal authoring |
| ProductOwner | ScrumMaster | Groomed backlog items ready for sprint breakdown |
| ProductOwner | Worker | Binary resource conversion needed (.docx, .eml) |
| ScrumMaster | Builder | Implementation plan approved, ready to execute |
| Builder | QAEngineer | Implementation phase complete — trigger quality gate review (Workflow F) |
| Builder | ProjectManager | Phase complete or blocker encountered — status update or escalation |

> **Note:** Builder→ScrumMaster handoff omitted: ScrumMaster picks up phase completion via `.tasks/` status updates rather than an active handoff trigger.

| QAEngineer | ProjectManager | Quality gate result (pass/fail) for PM decision |
| FrontendDev / BackendDev | ProjectManager | Advisory complete — implementation action needed |
| UIUXDesigner | ProjectManager | Diagram ready for render script execution |
| Any agent | ProjectManager | Escalation required: ambiguous scope, unresolvable conflict |

---

### Change 4 — Role Boundaries section: Add Builder to cross-role boundaries table

**Location:** `## Role Boundaries` section, "Common cross-role boundaries" table.

The table currently lists 5 boundaries for the four PM agents. Add one row routing implementation requests to Builder:

```markdown
| Execute implementation / write production code | Builder | ScrumMaster, QAEngineer, any PM agent |
```

This prevents PM agents (especially ScrumMaster) from attempting to write code themselves and instead routes the request to Builder.

**Note on the section header:** The current text reads "All four PM agents (ProjectManager, ProductOwner, BusinessAnalyst, ScrumMaster) enforce explicit role boundaries." This text describes the ROLE-BOUNDARY enforcement block output, which is a PM-agent pattern. Builder is not one of the four PM agents — it does not emit a ROLE-BOUNDARY block using the same format. No change to the body text is required; the cross-role boundaries table extension is sufficient to register Builder in the routing guidance.

---

### Change 5 — Opening paragraph: Update agent count

**Location:** Opening paragraph of `docs/pm-agents.md`.

**Current text:**
```
A **seven-agent** coordination layer
```

**Updated text:**
```
A **ten-agent** coordination layer
```

**Rationale:** The current roster lists 9 agents (ProjectManager, ProductOwner, ScrumMaster, BusinessAnalyst, FrontendDev, BackendDev, QAEngineer, UIUXDesigner, Worker). After adding Builder, the count becomes 10. The opening paragraph must reflect the actual roster size.

---

## Builder Permission Tier Determination

**Conclusion: Tier F — no new tier required.**

Evidence from `templates/agents/builder.template.md`:

| Capability | Builder has it? | Matches Tier F? |
|---|---|---|
| Read all files | ✅ (read/readFile, Read, Grep, Glob) | ✅ |
| Write / create files | ✅ (edit/createFile, edit/editFiles, Write) | ✅ |
| Execute commands | ✅ (execute/runInTerminal, Bash) | ✅ |
| Run tests | ✅ (execute/runTests, execute/testFailure) | ✅ |
| Delegate to Worker | ✅ (agents: ["Worker"], Task(Worker)) | ✅ |

The existing Tier F description ("All | All (delegated scope) | Controlled") accurately describes Builder's access profile. Tier F's "delegated scope" phrasing means the access is granted only for the task at hand (delegated by the user or orchestrator), which applies cleanly to both Worker (context-isolated tasks) and Builder (executing a specific approved plan).

> **Note for future phases:** Phase 2 of this task will address the vagueness of "delegated scope" in Tier F for Worker specifically. That work should extend the tier description to apply equally to Builder (both operate under explicit plan/task constraints).

---

## Handoff Reference Audit

All agent names referenced in the `docs/pm-agents.md` Handoff Contracts table, checked against the Agent Roster:

| Agent Referenced | In Roster? | Notes |
|---|---|---|
| ProductOwner | ✅ Yes | — |
| BusinessAnalyst | ✅ Yes | — |
| ScrumMaster | ✅ Yes | — |
| Worker | ✅ Yes | — |
| **Builder** | ❌ **NO** | Primary defect — this phase fixes it |
| QAEngineer | ✅ Yes | — |
| ProjectManager | ✅ Yes | — |
| FrontendDev | ✅ Yes | — |
| BackendDev | ✅ Yes | — |
| UIUXDesigner | ✅ Yes | — |

**Result: Builder is the only undefined agent.** No other broken references exist in the current handoff table.

> **Out of scope for this phase:** Builder's own template (`builder.template.md`) references handoffs to `Reviewer` and `Committer` agents. Those agents are not referenced in `docs/pm-agents.md` and are framework-level agents outside the PM system scope. They may warrant their own task if the PM docs need to document them.

---

## Implementation Checklist

Steps for Builder to execute when implementing this phase:

1. [ ] Read `docs/pm-agents.md` in full (confirm current state matches this plan)
2. [ ] **Agent Roster table**: Insert the Builder row after the Worker row (Change 1)
3. [ ] **Permission Tiers table**: Update Tier F "Who" column from `Worker` to `Worker, Builder` (Change 2)
4. [ ] **Handoff Contracts table**: Add two Builder outbound rows after `ScrumMaster | Builder` row (Change 3)
5. [ ] **Role Boundaries cross-role table**: Append the Builder routing row (Change 4)
6. [ ] **Opening paragraph**: Update agent count from "seven-agent" to "ten-agent" (Change 5)
7. [ ] Run `make validate` — verify no schema/lint errors
8. [ ] Grep for all occurrences of "Builder" in `docs/pm-agents.md` — confirm each reference resolves to the roster (`grep -i "builder" docs/pm-agents.md`)
9. [ ] Emit the CHANGE-RECORD block (see below)
10. [ ] Update `task.md` phase 1 status to ✅ Done

---

## Verification

### Automated Checks

```bash
# From workspace root
make validate

# Confirm Builder appears in roster
grep -A2 "Builder" docs/pm-agents.md

# Count Builder references — should be > 1 (roster + tiers + handoffs)
grep -ic "builder" docs/pm-agents.md
```

**Expected:** `make validate` passes. `grep` returns Builder in: the roster table, the Permission Tiers "Who" column, the Handoff Contracts section (≥3 rows: ScrumMaster→Builder, Builder→QAEngineer, Builder→ProjectManager), and the Role Boundaries table.

### Manual Verification Steps

1. Open `docs/pm-agents.md` — scan the Agent Roster table — Builder row appears with Tier F
2. Scan the Handoff Contracts table — `ScrumMaster | Builder` row exists AND two `Builder |` outbound rows appear below it
3. Cross-check: every agent name in the Handoff Contracts table appears in the Agent Roster

### Success Criteria

- [ ] Builder appears in Agent Roster table with `Tier F (full access)` and `User-Invokable: Yes`
- [ ] Tier F "Who" column reads `Worker, Builder`
- [ ] Handoff Contracts table has 3 Builder rows (1 inbound, 2 outbound)
- [ ] Role Boundaries cross-role table has a Builder row
- [ ] Zero agent names in any handoff row are absent from the roster (re-run audit mentally)
- [ ] `make validate` passes

---

## Tests

This phase modifies documentation only — no functional code. Tests are:

1. **Structural:** All agent names in Handoff Contracts resolve to a roster row (manual scan or grep)
2. **Completeness:** Builder has both inbound (ScrumMaster) and outbound (QAEngineer, ProjectManager) handoffs — the chain is closed
3. **Consistency:** Permission Tiers "Who" column lists all Tier F agents (Worker and Builder)
4. **No regressions:** No existing rows or content were removed or altered beyond the five targeted changes

---

## Change-Record Template

Emit this block at the end of the implementation response:

```
CHANGE-RECORD:
  task:    003-pm-agent-critical-fixes
  phase:   1 — Resolve Missing Builder Agent
  file:    docs/pm-agents.md
  changes:
    - section: Agent Roster
      action:  Added Builder row (Tier F, User-Invokable: Yes)
    - section: Permission Tiers
      action:  Updated Tier F Who column to "Worker, Builder"
    - section: Handoff Contracts
      actions:
        - Added Builder → QAEngineer row
        - Added Builder → ProjectManager row
    - section: Role Boundaries
      action:  Added "Execute implementation / write production code → Builder" row
    - section: Opening paragraph
      action:  Updated agent count from "seven-agent" to "ten-agent"
  audit:
    undefined_agents_before: [Builder]
    undefined_agents_after:  []
  status: complete
```
