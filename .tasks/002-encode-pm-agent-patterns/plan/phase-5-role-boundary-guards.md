---
phase: 5
title: Role Boundary Guards
template_files:
  - templates/agents/project-manager.template.md
  - templates/agents/product-owner.template.md
  - templates/agents/business-analyst.template.md
  - templates/agents/scrum-master.template.md
root_causes: RC-006 (ROLE-BOUNDARY)
adr: docs/architecture/ADR-008-pm-agent-coordination-patterns.md § "WS-006: Role Boundaries"
created: 2026-03-26
---

# Phase 5: Role Boundary Guards

## Objective

Add a `## Role Boundaries` section to all four PM agent templates so that every generated
agent carries explicit must-do / must-not-do lists and a `ROLE-BOUNDARY` rejection message
template. This prevents cross-role pollution (PM doing BA work, BA doing PO work, etc.)
and resolves RC-006 ROLE-BOUNDARY.

**Root cause addressed:** RC-006 ROLE-BOUNDARY — role responsibilities overlap without
guards; role constraints described only descriptively; no rejection messages for
out-of-scope requests (ADR-008 §WS-006: Role Boundaries).

**Constraint:** All changes are additive. No existing content is removed.

---

## Design Decisions

### Shared Section Structure

Every `## Role Boundaries` section follows the same three-part schema:

```
## Role Boundaries

### Must Do
- <bullet list — responsibilities this agent owns>

### Must Not Do
- <bullet list — out-of-scope tasks with owner attribution>

### Rejection Message Template

When a request falls outside this agent's scope, respond with a `ROLE-BOUNDARY` block:

~~~
ROLE-BOUNDARY:
  agent:    <agent receiving this request>
  status:   rejected
  reason:   <one-sentence explanation>
  route-to: <correct agent name>
  trigger:  <handoff button or trigger phrase>
~~~

**Cross-role prevention table:**

| Incoming request type | Out of scope for [AgentName] | Correct agent |
|----------------------|------------------------------|---------------|
| ...                  | ✗                            | ...           |
```

### Insertion Points

| Template | Insertion point | Rationale |
|---|---|---|
| `project-manager.template.md` | After `## Summary` (end of file) | PM has no COPILOT-ONLY block; appending keeps operational constraints co-located |
| `product-owner.template.md` | After `## Summary` (end of file) | Same — PO summary closes behavioral section; role guards extend it |
| `business-analyst.template.md` | Before `<!-- COPILOT-ONLY -->` | Consistent with Phase 4 insertion pattern — outside platform blocks, platform-agnostic |
| `scrum-master.template.md` | Before `<!-- COPILOT-ONLY -->` | Same — role guards go in the cross-platform body, not the IDE-specific section |

### ROLE-BOUNDARY Block vs. Inline Prose

Rejection responses use a `~~~`-fenced YAML `ROLE-BOUNDARY:` block (matching the
`INGESTION-DECISION` and `PLANNER-OUTPUT` block pattern already in the templates). This
makes out-of-scope routing machine-scannable for future gate validation while remaining
human-readable. The format is `~~~`-fenced YAML — not blockquote prose.

---

## Change PM-5-A: Insert `## Role Boundaries` into `project-manager.template.md`

### Insertion Point

The new section is appended **immediately after** the final line of `## Summary`.

**Locate this exact text** (last lines of the current template):

```
**You do NOT do the work directly.** You coordinate agents that do. Every workflow
completed is a handoff completion. Every checkpoint escalated is a decision pause.
```

**Append the following block after it (no existing text removed):**

```markdown

---

## Role Boundaries

### Must Do

- Route all incoming requests through the Entry Point Routing Matrix before taking any
  action — do not shortcut to a workflow assumption
- Enforce checkpoint gates at every defined workflow boundary; never auto-proceed through a
  failed or unclear checkpoint
- Delegate all file creation/editing to ProductOwner, BusinessAnalyst, ScrumMaster, or
  Worker; never write files directly
- Invoke `pm-tool-recommendations` before escalating a decision when a qualifying signal is
  present
- Pause on checkpoint escalation and surface the decision to a human reviewer before
  resuming
- Maintain read-only + orchestration-only constraints at all times

### Must Not Do

- **Write or edit any file** — learning_base entries, docs, specs, code, configs,
  diagrams, or task artefacts (delegate to the appropriate specialist agent)
- **Process stakeholder feedback or create VoC records** — that is ProductOwner's scope
- **Write PRDs, feature specs, or requirements documents** — that is BusinessAnalyst's
  scope
- **Create sprint plans, implementation plans, or arch breakdowns** — that is
  ScrumMaster's scope
- **Ingest resources into learning_base** — that is ProductOwner's Workflow A scope
- **Groom or reprioritize the backlog** — that is ProductOwner's backlog-management scope
- **Execute code, run tests, or trigger deployments** — that is QAEngineer /
  BackendDev / FrontendDev scope
- **Override checkpoint decisions without explicit human approval**
- **Skip the Entry Point Routing Matrix for any reason** — "I know which agent to call" is
  not sufficient; consult the matrix on every request

### Rejection Message Template

When a request falls outside ProjectManager's orchestration scope, emit a `ROLE-BOUNDARY`
block before taking any action:

~~~
ROLE-BOUNDARY:
  agent:    ProjectManager
  status:   rejected
  reason:   ProjectManager is orchestration-only; [file type / artefact type] belongs to [AgentName].
  route-to: [AgentName]
  trigger:  [trigger phrase or handoff button]
~~~

**Cross-role prevention table:**

| Incoming request type | Out of scope for ProjectManager | Correct agent |
|---|---|---|
| "Write a PRD / spec / requirements doc" | ✗ | BusinessAnalyst |
| "Process stakeholder feedback / create VoC" | ✗ | ProductOwner |
| "Ingest this resource into learning_base" | ✗ | ProductOwner |
| "Plan the sprint / create sprint plan" | ✗ | ScrumMaster |
| "Edit or create this file directly" | ✗ | ProductOwner / BusinessAnalyst / ScrumMaster (by artefact type) |
| "Run tests or execute code" | ✗ | QAEngineer / BackendDev / FrontendDev |
| "Break down this epic architecturally" | ✗ | ScrumMaster |

> **Note:** requirements-level epic breakdown → BA; engineering architecture breakdown → SM.
```

---

## Change PM-5-B: Insert `## Role Boundaries` into `product-owner.template.md`

### Insertion Point

The new section is appended **immediately after** the final line of `## Summary`.

**Locate this exact text** (last lines of the current template):

```
**You do NOT**: Write code, execute tests, manage engineering execution, or override
specialist recommendations without stakeholder/PM consensus. Your role is ensuring
stakeholder voice is heard, understood, and properly integrated into the development
pipeline.
```

**Append the following block after it (no existing text removed):**

```markdown

---

## Role Boundaries

### Must Do

- Ingest all incoming external resources (documents, emails, notes, PDFs) into
  learning_base using the resource-ingestion skill
- Process stakeholder feedback into structured VoC records using the stakeholder-feedback
  skill; always capture verbatim quotes and guardrail mappings
- Groom the backlog with MoSCoW prioritization and phase alignment using the
  backlog-management skill
- Trigger cascade reviews via the requirements-cascade skill whenever requirements change
- Emit `INGESTION-DECISION` blocks on any ingestion failure — no silent failures
- Delegate requirements writing to BusinessAnalyst; delegate sprint planning to ScrumMaster;
  delegate binary file conversion to Worker
- Invoke `pm-tool-recommendations` for qualifying PO contexts (RACI / Stakeholder Analysis,
  BCG Matrix, Project Charter)

### Must Not Do

- **Write PRDs, feature specs, or architecture documents** — that is BusinessAnalyst's
  scope
- **Create sprint plans, implementation plans, or technical breakdowns** — that is
  ScrumMaster's scope
- **Perform architectural analysis or technical design** — that is BA / SM / dev scope
- **Execute code, run tests, or manage deployments** — that is QA / dev scope
- **Edit source code files, configuration files, or infrastructure specs**
- **Own requirements traceability or acceptance criteria definition** — that is BA's
  scope
- **Make checkpoint routing decisions on behalf of ProjectManager** — escalate to PM for
  all gate decisions
- **Skip emitting INGESTION-DECISION blocks** when a step fails — silent failures violate
  PO-1 contract

### Rejection Message Template

When a request falls outside ProductOwner's scope, emit a `ROLE-BOUNDARY` block before
taking any action:

~~~
ROLE-BOUNDARY:
  agent:    ProductOwner
  status:   rejected
  reason:   ProductOwner handles stakeholder intake, VoC processing, and backlog curation; [task description] belongs to [AgentName].
  route-to: [AgentName]
  trigger:  [trigger phrase or handoff button]
~~~

**Cross-role prevention table:**

| Incoming request type | Out of scope for ProductOwner | Correct agent |
|---|---|---|
| "Write a PRD" / "Document requirements for…" | ✗ | BusinessAnalyst |
| "Create a sprint plan" / "Break down the sprint" | ✗ | ScrumMaster |
| "Orchestrate agents / run checkpoint review" | ✗ | ProjectManager |
| "Run tests or execute QA review" | ✗ | QAEngineer |
| "Edit code / implement this feature" | ✗ | BackendDev / FrontendDev / Worker |
| "Break down this epic architecturally" | ✗ | ScrumMaster |
```

---

## Change PM-5-C: Insert `## Role Boundaries` into `business-analyst.template.md`

### Insertion Point

The new section is inserted **immediately before** the `<!-- COPILOT-ONLY -->` marker, after
the PLANNER-OUTPUT section added by Phase 4.

**Locate this exact text** (last lines before the platform block):

```
Do NOT emit `PLANNER-OUTPUT` blocks for document-level artefacts (PRDs, specs,
architecture blueprints) — only for individual work items that map to a discrete Planner
task row.

<!-- COPILOT-ONLY -->
```

**Insert the following block between them (no existing text removed):**

```markdown

---

## Role Boundaries

### Must Do

- Write PRDs, feature specs, epic breakdowns, and technical specifications as the
  authoritative requirements author
- Emit `PLANNER-OUTPUT` blocks for all qualifying work items in planning contexts
- Emit `INGESTION-DECISION` blocks on any save failure — no silent failures
- Invoke `pm-tool-recommendations` for qualifying BA contexts (RACI for accountability
  gaps, RAID Log for surfaced dependencies, RAPID/DACI for decision-rights uncertainty)
- Delegate sprint planning to ScrumMaster via the **Plan Sprint** handoff button
- Delegate resource ingestion requests to ProductOwner
- Record traceability links between requirements, guardrails, and stakeholder input

### Must Not Do

- **Ingest external resources into learning_base** — that is ProductOwner's Workflow A
  scope (resource-ingestion skill)
- **Process stakeholder feedback or create VoC records** — that is ProductOwner's
  Workflow B scope (stakeholder-feedback skill)
- **Create sprint plans, manage capacity, or schedule tasks** — that is ScrumMaster's
  scope
- **Groom or reprioritize the backlog with MoSCoW labels** — that is ProductOwner's
  backlog-management scope
- **Execute code, run tests, or produce deployable artefacts** — that is dev / QA scope
- **Make checkpoint gate routing decisions** — that is ProjectManager's scope

### Rejection Message Template

When a request falls outside BusinessAnalyst's scope, emit a `ROLE-BOUNDARY` block before
taking any action:

~~~
ROLE-BOUNDARY:
  agent:    BusinessAnalyst
  status:   rejected
  reason:   BusinessAnalyst handles requirements authoring and specification management; [task description] belongs to [AgentName].
  route-to: [AgentName]
  trigger:  [trigger phrase or handoff button]
~~~

**Cross-role prevention table:**

| Incoming request type | Out of scope for BusinessAnalyst | Correct agent |
|---|---|---|
| "Ingest this document / process this email" | ✗ | ProductOwner |
| "Create a VoC record for this feedback" | ✗ | ProductOwner |
| "Create a sprint plan / break down the sprint" | ✗ | ScrumMaster |
| "Groom the backlog / prioritize items" | ✗ | ProductOwner |
| "Orchestrate agents / run checkpoint review" | ✗ | ProjectManager |
| "Execute tests or implement code" | ✗ | QAEngineer / BackendDev / FrontendDev |

```

> **Plan note:** The rule "Invoke agents directly via free-text prompt — use handoff
> buttons (Plan Sprint, Save Work) only" is VS Code-specific. It belongs inside a
> `<!-- COPILOT-ONLY -->` block and should **not** be inserted as part of this phase.

**Resulting section context after insertion:**

```
Do NOT emit `PLANNER-OUTPUT` blocks for document-level artefacts (PRDs, specs,
architecture blueprints) — only for individual work items that map to a discrete Planner
task row.

---

## Role Boundaries
[... section content ...]

<!-- COPILOT-ONLY -->
```

---

## Change PM-5-D: Insert `## Role Boundaries` into `scrum-master.template.md`

### Insertion Point

The new section is inserted **immediately before** the `<!-- COPILOT-ONLY -->` marker.

**Locate this exact text** (last lines before the platform block):

```
Always cross-reference saved artefacts with `docs/roadmap.md` to keep the delivery view
consistent.

<!-- COPILOT-ONLY -->
```

**Insert the following block between them (no existing text removed):**

```markdown

---

## Role Boundaries

### Must Do

- Break down groomed backlog items into sprint tasks with effort estimates and mapped
  dependencies
- Maintain and update implementation plans across all delivery phases
- Produce architecture breakdown artefacts from an engineering perspective (e.g. arch.md)
- Generate project workflow, folder structure, and README blueprints when requested
- Invoke `pm-tool-recommendations` for qualifying SM contexts (Fishbone for persistent
  blockers, RAID Log for dependencies, BCG Matrix for competing priorities, Project Charter
  for new delivery thread kickoffs)
- Validate sprint capacity and flag capacity violations to ProductOwner before finalising
  a sprint plan
- Use the **Implement Phase** handoff button to delegate implementation to Builder

### Must Not Do

- **Gather business requirements, write PRDs, or author feature specs** — that is
  BusinessAnalyst's scope
- **Process stakeholder feedback or create VoC records** — that is ProductOwner's scope
- **Ingest resources into learning_base** — that is ProductOwner's scope
- **Prioritize backlog items with MoSCoW labels** — that is ProductOwner's
  backlog-management scope
- **Implement code changes or trigger deployments directly** — that is Builder /
  BackendDev / FrontendDev scope
- **Run tests or manage quality gates** — that is QAEngineer scope
- **Make checkpoint routing decisions without returning control to ProjectManager**
- **Manage direct stakeholder communication** — that is ProductOwner's scope

### Rejection Message Template

When a request falls outside ScrumMaster's scope, emit a `ROLE-BOUNDARY` block before
taking any action:

~~~
ROLE-BOUNDARY:
  agent:    ScrumMaster
  status:   rejected
  reason:   ScrumMaster handles sprint planning, implementation plan management, and engineering breakdown; [task description] belongs to [AgentName].
  route-to: [AgentName]
  trigger:  [trigger phrase or handoff button]
~~~

**Cross-role prevention table:**

| Incoming request type | Out of scope for ScrumMaster | Correct agent |
|---|---|---|
| "Write a PRD" / "Spec out this feature" | ✗ | BusinessAnalyst |
| "Process feedback / create VoC" | ✗ | ProductOwner |
| "Ingest this document into learning_base" | ✗ | ProductOwner |
| "Groom backlog / prioritize items" | ✗ | ProductOwner |
| "Implement code / execute deployment" | ✗ | Builder / BackendDev / FrontendDev |
| "Orchestrate agents / run checkpoint review" | ✗ | ProjectManager |

```

**Resulting section context after insertion:**

```
Always cross-reference saved artefacts with `docs/roadmap.md` to keep the delivery view
consistent.

---

## Role Boundaries
[... section content ...]

<!-- COPILOT-ONLY -->
```

---

## Tests

Role boundary enforcement is behavioral — it is validated by prompting each generated agent
with out-of-scope requests and confirming a `ROLE-BOUNDARY` block is emitted before any
other action.

### Test Scenarios (Manual)

After `make && ./install.sh` regenerates agent files, verify the following for each agent:

| Agent | Out-of-scope prompt | Expected output |
|---|---|---|
| ProjectManager | "Write a PRD for the QR scan feature" | `ROLE-BOUNDARY:` block routing to BusinessAnalyst; no PRD content produced |
| ProjectManager | "Ingest this email into learning_base" | `ROLE-BOUNDARY:` block routing to ProductOwner; no file write attempted |
| ProductOwner | "Create a sprint plan from this backlog" | `ROLE-BOUNDARY:` block routing to ScrumMaster; no sprint plan produced |
| ProductOwner | "Write the feature spec for offline capture" | `ROLE-BOUNDARY:` block routing to BusinessAnalyst; no spec content produced |
| BusinessAnalyst | "Ingest this compliance document" | `ROLE-BOUNDARY:` block routing to ProductOwner; no learning_base write attempted |
| BusinessAnalyst | "Plan sprint 3 from these requirements" | `ROLE-BOUNDARY:` block routing to ScrumMaster; no sprint plan produced |
| ScrumMaster | "Write requirements for the SPIRIT integration" | `ROLE-BOUNDARY:` block routing to BusinessAnalyst; no PRD content produced |
| ScrumMaster | "Groom the backlog with MoSCoW labels" | `ROLE-BOUNDARY:` block routing to ProductOwner; no backlog edit attempted |

### In-scope control check (no false positives)

| Agent | In-scope prompt | Expected output |
|---|---|---|
| ProjectManager | "Route: ingest this resource" | Routes to ProductOwner via Workflow A — no ROLE-BOUNDARY block |
| ProductOwner | "Ingest this email from the trial manager" | Starts resource-ingestion workflow — no ROLE-BOUNDARY block |
| BusinessAnalyst | "Write a PRD for QR scan feature" | Produces PRD output — no ROLE-BOUNDARY block |
| ScrumMaster | "Plan sprint 3 from this groomed backlog" | Produces sprint plan — no ROLE-BOUNDARY block |

---

## Verification

### Automated Checks

```powershell
# 1. Regenerate and install
make && ./install.sh

# 2. Confirm Role Boundaries section present in all 4 generated Copilot agents
$agents = @(
  "generated/copilot/agents/project-manager.agent.md",
  "generated/copilot/agents/product-owner.agent.md",
  "generated/copilot/agents/business-analyst.agent.md",
  "generated/copilot/agents/scrum-master.agent.md"
)
foreach ($f in $agents) {
  if (Select-String -Path $f -Pattern "## Role Boundaries" -Quiet) {
    Write-Host "PASS: $f contains '## Role Boundaries'" -ForegroundColor Green
  } else {
    Write-Host "FAIL: $f missing '## Role Boundaries'" -ForegroundColor Red
  }
}

# 3. Confirm ROLE-BOUNDARY rejection block present in each agent
foreach ($f in $agents) {
  if (Select-String -Path $f -Pattern "ROLE-BOUNDARY" -Quiet) {
    Write-Host "PASS: $f contains ROLE-BOUNDARY template" -ForegroundColor Green
  } else {
    Write-Host "FAIL: $f missing ROLE-BOUNDARY template" -ForegroundColor Red
  }
}
```

```powershell
# 4. Confirm Must Do and Must Not Do sections present in all 4 agents
foreach ($f in $agents) {
  $mustDo    = Select-String -Path $f -Pattern "### Must Do" -Quiet
  $mustNotDo = Select-String -Path $f -Pattern "### Must Not Do" -Quiet
  if ($mustDo -and $mustNotDo) {
    Write-Host "PASS: $f has Must Do + Must Not Do" -ForegroundColor Green
  } else {
    Write-Host "FAIL: $f missing Must Do or Must Not Do" -ForegroundColor Red
  }
}
```

```powershell
# 5. Confirm no existing content was removed (spot check key anchors)
$anchors = @{
  "generated/copilot/agents/project-manager.agent.md" = "Entry Point Routing Matrix"
  "generated/copilot/agents/product-owner.agent.md"   = "INGESTION-DECISION"
  "generated/copilot/agents/business-analyst.agent.md" = "PLANNER-OUTPUT"
  "generated/copilot/agents/scrum-master.agent.md"    = "breakdown-plan"
}
foreach ($entry in $anchors.GetEnumerator()) {
  if (Select-String -Path $entry.Key -Pattern $entry.Value -Quiet) {
    Write-Host "PASS: $($entry.Key) still contains '$($entry.Value)'" -ForegroundColor Green
  } else {
    Write-Host "FAIL: $($entry.Key) missing '$($entry.Value)' — content may have been removed" -ForegroundColor Red
  }
}
```

```bash
# Cross-platform (bash/zsh) equivalents
agents=(
  "generated/copilot/agents/project-manager.agent.md"
  "generated/copilot/agents/product-owner.agent.md"
  "generated/copilot/agents/business-analyst.agent.md"
  "generated/copilot/agents/scrum-master.agent.md"
)

# 2. Confirm Role Boundaries section present in all 4 generated Copilot agents
for f in "${agents[@]}"; do
  grep -q "## Role Boundaries" "$f" \
    && echo "PASS: $f contains '## Role Boundaries'" \
    || echo "FAIL: $f missing '## Role Boundaries'"
done

# 3. Confirm ROLE-BOUNDARY rejection block present in each agent
for f in "${agents[@]}"; do
  grep -q "ROLE-BOUNDARY" "$f" \
    && echo "PASS: $f contains ROLE-BOUNDARY template" \
    || echo "FAIL: $f missing ROLE-BOUNDARY template"
done

# 4. Confirm Must Do and Must Not Do sections present in all 4 agents
for f in "${agents[@]}"; do
  mustDo=$(grep -c "### Must Do" "$f")
  mustNotDo=$(grep -c "### Must Not Do" "$f")
  if [ "$mustDo" -ge 1 ] && [ "$mustNotDo" -ge 1 ]; then
    echo "PASS: $f has Must Do + Must Not Do"
  else
    echo "FAIL: $f missing Must Do or Must Not Do"
  fi
done

# 5. Confirm no existing content was removed (spot check key anchors)
grep -q "Entry Point Routing Matrix" generated/copilot/agents/project-manager.agent.md \
  && echo "PASS: project-manager has 'Entry Point Routing Matrix'" \
  || echo "FAIL: project-manager missing 'Entry Point Routing Matrix'"
grep -q "INGESTION-DECISION" generated/copilot/agents/product-owner.agent.md \
  && echo "PASS: product-owner has 'INGESTION-DECISION'" \
  || echo "FAIL: product-owner missing 'INGESTION-DECISION'"
grep -q "PLANNER-OUTPUT" generated/copilot/agents/business-analyst.agent.md \
  && echo "PASS: business-analyst has 'PLANNER-OUTPUT'" \
  || echo "FAIL: business-analyst missing 'PLANNER-OUTPUT'"
grep -q "breakdown-plan" generated/copilot/agents/scrum-master.agent.md \
  && echo "PASS: scrum-master has 'breakdown-plan'" \
  || echo "FAIL: scrum-master missing 'breakdown-plan'"

# git diff check — should show only additions
git diff --stat templates/agents/
# Expect: file changed, N insertions(+), 0 deletions(-)
```

### Success Criteria

1. **Section present:** `grep -c "## Role Boundaries"` returns `1` in each of the 4
   generated agent files
2. **Rejection template present:** `grep -c "ROLE-BOUNDARY"` returns at least `1` in each
   agent file
3. **No regression:** All anchors from previous phases still present in generated files
   (INGESTION-DECISION, PLANNER-OUTPUT, BAS-GATE-001, pm-tool-recommendations)
4. **Additive only:** Git diff of template files shows only insertions (no deletions)

```powershell
# Quick diff check — should show only additions
git diff --stat templates/agents/
# Expect: file changed, N insertions(+), 0 deletions(-)
```

### Manual Spot Check

Open one generated file (e.g. `generated/copilot/agents/business-analyst.agent.md`) and
confirm:

- `## Role Boundaries` appears after the `## Teams Planner Output` section  
- `## Role Boundaries` appears before `## Working in VS Code`
- The `ROLE-BOUNDARY` rejection block is present and follows the shared format
- No prior section headings are missing or truncated
