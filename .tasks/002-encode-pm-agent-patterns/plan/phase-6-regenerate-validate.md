---
phase: 6
task: encode-pm-agent-patterns
created: 2026-03-27
status: planned
---

# Phase 6 — Regenerate + Validate

Confirm all 5 pattern categories from Phases 1–5 propagated correctly into both platform output directories (`generated/copilot/` and `generated/claude/`), then update documentation and close out the task.

---

## Step 1 — Regenerate

Run the generator from the repo root to produce a clean output from current templates:

```powershell
node scripts/generate.js
```

Expected outcome: no errors; `generated/copilot/` and `generated/claude/` directories updated in place.

> Note: `make` is not available on Windows native. Use `node scripts/generate.js` directly.  
> `./install.sh` is a bash script and requires WSL or Git Bash if user-installation is also needed — this is optional for validation purposes.

---

## Step 2 — Validation Checklist

Run each check with PowerShell `Select-String` (or `grep` in bash). All checks target the generated files, not templates. A passing check prints at least one match line; a failing check prints nothing.

### 2.1 Phase 1: Conductor Gate Pattern

**Target files:**
- `generated/copilot/agents/conductor.agent.md`
- `generated/copilot/agents/project-manager.agent.md`
- `generated/claude/agents/conductor.md`
- `generated/claude/agents/project-manager.md`

**Checks:**

| # | Check | PowerShell command | Expected |
|---|-------|--------------------|----------|
| 1.1 | `BAS-GATE-NNN` format present in conductor | `Select-String "BAS-GATE-NNN" generated\copilot\agents\conductor.agent.md` | ≥ 1 match |
| 1.2 | Wave sequencing rule in conductor | `Select-String "Wave" generated\copilot\agents\conductor.agent.md` | ≥ 1 match |
| 1.3 | L1/L2/L3 escalation levels in conductor | `Select-String "L1.*L2.*L3|Level 1.*Level 2" generated\copilot\agents\conductor.agent.md` | ≥ 1 match |
| 1.4 | BAS-GATE-001/002/003 table in project-manager | `Select-String "BAS-GATE-001" generated\copilot\agents\project-manager.agent.md` | ≥ 1 match |
| 1.5 | Wave sequencing rule in project-manager | `Select-String "Wave.*begin.*after|Wave.*may not.*until" generated\copilot\agents\project-manager.agent.md` | ≥ 1 match |
| 1.6 | Same in Claude CC conductor | `Select-String "BAS-GATE-NNN" generated\claude\agents\conductor.md` | ≥ 1 match |
| 1.7 | Same in Claude CC project-manager | `Select-String "BAS-GATE-001" generated\claude\agents\project-manager.md` | ≥ 1 match |

### 2.2 Phase 2: PM-Tool Recommendations Skill + Wiring

**Target files:**
- `generated/copilot/skills/pm-tool-recommendations/SKILL.md`
- `generated/claude/skills/pm-tool-recommendations/SKILL.md`
- `generated/copilot/agents/project-manager.agent.md`
- `generated/copilot/agents/product-owner.agent.md`
- `generated/copilot/agents/business-analyst.agent.md`
- `generated/copilot/agents/scrum-master.agent.md`
- `generated/claude/agents/project-manager.md`
- `generated/claude/agents/product-owner.md`
- `generated/claude/agents/business-analyst.md`
- `generated/claude/agents/scrum-master.md`

**Checks:**

| # | Check | PowerShell command | Expected |
|---|-------|--------------------|----------|
| 2.1 | Skill file exists (Copilot) | `Test-Path generated\copilot\skills\pm-tool-recommendations\SKILL.md` | `True` |
| 2.2 | Skill file exists (Claude CC) | `Test-Path generated\claude\skills\pm-tool-recommendations\SKILL.md` | `True` |
| 2.3 | PM-TOOL-RECOMMENDATION block schema in skill | `Select-String "PM-TOOL-RECOMMENDATION" generated\copilot\skills\pm-tool-recommendations\SKILL.md` | ≥ 1 match |
| 2.4 | Trigger contract table in skill (7 frameworks) | `Select-String "Fishbone|RACI|RAID|BCG|RAPID|Stakeholder Analysis|Project Charter" generated\copilot\skills\pm-tool-recommendations\SKILL.md` | ≥ 1 match |
| 2.5 | Skill referenced in PM body | `Select-String "pm-tool-recommendations" generated\copilot\agents\project-manager.agent.md` | ≥ 1 match |
| 2.6 | Skill referenced in PO body | `Select-String "pm-tool-recommendations" generated\copilot\agents\product-owner.agent.md` | ≥ 1 match |
| 2.7 | Skill referenced in BA body | `Select-String "pm-tool-recommendations" generated\copilot\agents\business-analyst.agent.md` | ≥ 1 match |
| 2.8 | Skill referenced in SM body | `Select-String "pm-tool-recommendations" generated\copilot\agents\scrum-master.agent.md` | ≥ 1 match |
| 2.9 | Skill in CC PM frontmatter skills list | `Select-String "pm-tool-recommendations" generated\claude\agents\project-manager.md` | ≥ 1 match |
| 2.10 | Skill in CC PO frontmatter skills list | `Select-String "pm-tool-recommendations" generated\claude\agents\product-owner.md` | ≥ 1 match |
| 2.11 | Skill in CC BA frontmatter skills list | `Select-String "pm-tool-recommendations" generated\claude\agents\business-analyst.md` | ≥ 1 match |
| 2.12 | Skill in CC SM frontmatter skills list | `Select-String "pm-tool-recommendations" generated\claude\agents\scrum-master.md` | ≥ 1 match |

### 2.3 Phase 3: INGESTION-DECISION Blocks

**Target files:**
- `generated/copilot/agents/product-owner.agent.md`
- `generated/copilot/agents/business-analyst.agent.md`
- `generated/claude/agents/product-owner.md`
- `generated/claude/agents/business-analyst.md`

**Checks:**

| # | Check | PowerShell command | Expected |
|---|-------|--------------------|----------|
| 3.1 | INGESTION-DECISION block in PO (Copilot) | `Select-String "INGESTION-DECISION:" generated\copilot\agents\product-owner.agent.md` | ≥ 1 match |
| 3.2 | INGESTION-DECISION block in BA (Copilot) | `Select-String "INGESTION-DECISION:" generated\copilot\agents\business-analyst.agent.md` | ≥ 1 match |
| 3.3 | INGESTION-DECISION in PO (Claude CC) | `Select-String "INGESTION-DECISION:" generated\claude\agents\product-owner.md` | ≥ 1 match |
| 3.4 | INGESTION-DECISION in BA (Claude CC) | `Select-String "INGESTION-DECISION:" generated\claude\agents\business-analyst.md` | ≥ 1 match |
| 3.5 | `status: blocked` field in PO decision block | `Select-String "status: blocked" generated\copilot\agents\product-owner.agent.md` | ≥ 1 match |
| 3.6 | `next_action` field present in both agents | `Select-String "next_action:" generated\copilot\agents\business-analyst.agent.md` | ≥ 1 match |

### 2.4 Phase 4: Teams Planner Output / PLANNER-OUTPUT

**Target files:**
- `generated/copilot/agents/business-analyst.agent.md`
- `generated/claude/agents/business-analyst.md`

**Checks:**

| # | Check | PowerShell command | Expected |
|---|-------|--------------------|----------|
| 4.1 | `## Teams Planner Output` section header | `Select-String "## Teams Planner Output" generated\copilot\agents\business-analyst.agent.md` | ≥ 1 match |
| 4.2 | `PLANNER-OUTPUT:` YAML block schema | `Select-String "PLANNER-OUTPUT:" generated\copilot\agents\business-analyst.agent.md` | ≥ 1 match |
| 4.3 | Qualification signals (sprint planning / backlog) | `Select-String "sprint planning|backlog grooming|task breakdown" generated\copilot\agents\business-analyst.agent.md` | ≥ 1 match |
| 4.4 | No-op / suppress condition present | `Select-String "no planning intent|suppress.*PLANNER-OUTPUT|PLANNER-OUTPUT.*skipped" generated\copilot\agents\business-analyst.agent.md` | ≥ 1 match |
| 4.5 | Mandatory Planner fields present (title/bucket/due) | `Select-String "title:\|bucket:\|due_date:" generated\copilot\agents\business-analyst.agent.md` | ≥ 1 match |
| 4.6 | Same in Claude CC | `Select-String "## Teams Planner Output" generated\claude\agents\business-analyst.md` | ≥ 1 match |

### 2.5 Phase 5: ROLE-BOUNDARY Sections

**Target files:**
- `generated/copilot/agents/project-manager.agent.md`
- `generated/copilot/agents/product-owner.agent.md`
- `generated/copilot/agents/business-analyst.agent.md`
- `generated/copilot/agents/scrum-master.agent.md`
- All four Claude CC counterparts

**Checks:**

| # | Check | PowerShell command | Expected |
|---|-------|--------------------|----------|
| 5.1 | ROLE-BOUNDARY block in PM (Copilot) | `Select-String "ROLE-BOUNDARY:" generated\copilot\agents\project-manager.agent.md` | ≥ 1 match |
| 5.2 | ROLE-BOUNDARY block in PO (Copilot) | `Select-String "ROLE-BOUNDARY:" generated\copilot\agents\product-owner.agent.md` | ≥ 1 match |
| 5.3 | ROLE-BOUNDARY block in BA (Copilot) | `Select-String "ROLE-BOUNDARY:" generated\copilot\agents\business-analyst.agent.md` | ≥ 1 match |
| 5.4 | ROLE-BOUNDARY block in SM (Copilot) | `Select-String "ROLE-BOUNDARY:" generated\copilot\agents\scrum-master.agent.md` | ≥ 1 match |
| 5.5 | ROLE-BOUNDARY in PM (Claude CC) | `Select-String "ROLE-BOUNDARY:" generated\claude\agents\project-manager.md` | ≥ 1 match |
| 5.6 | ROLE-BOUNDARY in PO (Claude CC) | `Select-String "ROLE-BOUNDARY:" generated\claude\agents\product-owner.md` | ≥ 1 match |
| 5.7 | ROLE-BOUNDARY in BA (Claude CC) | `Select-String "ROLE-BOUNDARY:" generated\claude\agents\business-analyst.md` | ≥ 1 match |
| 5.8 | ROLE-BOUNDARY in SM (Claude CC) | `Select-String "ROLE-BOUNDARY:" generated\claude\agents\scrum-master.md` | ≥ 1 match |
| 5.9 | Role boundary rejection pattern (❌ Out of scope) in PM | `Select-String "Out of scope" generated\copilot\agents\project-manager.agent.md` | ≥ 1 match |
| 5.10 | Must NOT do section present in all 4 | `Select-String "Must NOT do\|Must-NOT-do" generated\copilot\agents\scrum-master.agent.md` | ≥ 1 match |

### 2.6 Platform Purity

Confirm `CC-ONLY` content blocks are stripped from Copilot output, and `COPILOT-ONLY` blocks stripped from Claude CC output where applicable. (Note: HTML comment markers themselves may be left in depending on generator behaviour — the key check is that the enclosed content is not rendered in the wrong platform's agent body.)

| # | Check | PowerShell command | Expected |
|---|-------|--------------------|----------|
| 6.1 | No raw CC-ONLY narrative content in Copilot BA | `Select-String "Task\(Explorer" generated\copilot\agents\business-analyst.agent.md` | 0 matches |
| 6.2 | No Copilot handoff button syntax in Claude BA | `Select-String "handoffs:" generated\claude\agents\business-analyst.md` | 0 matches |

---

## Step 3 — Batch Validation Script

Save as `scripts/validate-pm-patterns.ps1` and execute. This script is required for the Verification section:

```powershell
$errors = 0

function Check($label, $file, $pattern, $expectMatch) {
    $result = Select-String -Path $file -Pattern $pattern -Quiet
    if ($expectMatch -and -not $result) {
        Write-Host "[FAIL] $label — pattern '$pattern' not found in $file" -ForegroundColor Red
        $script:errors++
    } elseif (-not $expectMatch -and $result) {
        Write-Host "[FAIL] $label — pattern '$pattern' unexpectedly found in $file" -ForegroundColor Red
        $script:errors++
    } else {
        Write-Host "[PASS] $label" -ForegroundColor Green
    }
}

# --- Phase 1: Gate Pattern ---
Check "1.1 BAS-GATE-NNN in conductor (Copilot)" `
    "generated\copilot\agents\conductor.agent.md" "BAS-GATE-NNN" $true
Check "1.2 Wave sequencing in conductor" `
    "generated\copilot\agents\conductor.agent.md" "Wave" $true
Check "1.3 L1/L2/L3 escalation in conductor" `
    "generated\copilot\agents\conductor.agent.md" "L1.*L2.*L3|Level 1.*Level 2" $true
Check "1.4 BAS-GATE-001 table in PM (Copilot)" `
    "generated\copilot\agents\project-manager.agent.md" "BAS-GATE-001" $true
Check "1.5 Wave sequencing rule in PM" `
    "generated\copilot\agents\project-manager.agent.md" "Wave.*begin.*after|Wave.*may not.*until" $true
Check "1.6 BAS-GATE-NNN in conductor (Claude)" `
    "generated\claude\agents\conductor.md" "BAS-GATE-NNN" $true
Check "1.7 BAS-GATE-001 in Claude PM" `
    "generated\claude\agents\project-manager.md" "BAS-GATE-001" $true

# --- Phase 2: PM-Tool Skill ---
Check "2.1 Skill file exists (Copilot)" `
    "generated\copilot\skills\pm-tool-recommendations\SKILL.md" "PM-TOOL-RECOMMENDATION" $true
Check "2.4 7-framework trigger table in skill" `
    "generated\copilot\skills\pm-tool-recommendations\SKILL.md" "Fishbone|RACI|RAID|BCG|RAPID|Stakeholder Analysis|Project Charter" $true
Check "2.5 Skill in PM body (Copilot)" `
    "generated\copilot\agents\project-manager.agent.md" "pm-tool-recommendations" $true
Check "2.6 Skill in PO body (Copilot)" `
    "generated\copilot\agents\product-owner.agent.md" "pm-tool-recommendations" $true
Check "2.7 Skill in BA body (Copilot)" `
    "generated\copilot\agents\business-analyst.agent.md" "pm-tool-recommendations" $true
Check "2.8 Skill in SM body (Copilot)" `
    "generated\copilot\agents\scrum-master.agent.md" "pm-tool-recommendations" $true
Check "2.10 Skill in PO frontmatter (Claude)" `
    "generated\claude\agents\product-owner.md" "pm-tool-recommendations" $true
Check "2.12 Skill in SM frontmatter (Claude)" `
    "generated\claude\agents\scrum-master.md" "pm-tool-recommendations" $true

# --- Phase 3: INGESTION-DECISION ---
Check "3.1 INGESTION-DECISION in PO (Copilot)" `
    "generated\copilot\agents\product-owner.agent.md" "INGESTION-DECISION:" $true
Check "3.2 INGESTION-DECISION in BA (Copilot)" `
    "generated\copilot\agents\business-analyst.agent.md" "INGESTION-DECISION:" $true
Check "3.3 INGESTION-DECISION in PO (Claude)" `
    "generated\claude\agents\product-owner.md" "INGESTION-DECISION:" $true
Check "3.4 INGESTION-DECISION in BA (Claude)" `
    "generated\claude\agents\business-analyst.md" "INGESTION-DECISION:" $true
Check "3.5 status: blocked in PO decision block" `
    "generated\copilot\agents\product-owner.agent.md" "status: blocked" $true
Check "3.6 next_action field in BA" `
    "generated\copilot\agents\business-analyst.agent.md" "next_action:" $true

# --- Phase 4: Teams Planner Output ---
Check "4.1 Teams Planner Output section (Copilot)" `
    "generated\copilot\agents\business-analyst.agent.md" "## Teams Planner Output" $true
Check "4.2 PLANNER-OUTPUT block schema (Copilot)" `
    "generated\copilot\agents\business-analyst.agent.md" "PLANNER-OUTPUT:" $true
Check "4.3 Qualification signals in BA" `
    "generated\copilot\agents\business-analyst.agent.md" "sprint planning|backlog grooming|task breakdown" $true
Check "4.4 No-op suppress condition (Copilot)" `
    "generated\copilot\agents\business-analyst.agent.md" "no planning intent|suppress.*PLANNER-OUTPUT|PLANNER-OUTPUT.*skipped" $true
Check "4.5 Mandatory Planner fields in BA" `
    "generated\copilot\agents\business-analyst.agent.md" "title:|bucket:|due_date:" $true
Check "4.6 Teams Planner Output section (Claude)" `
    "generated\claude\agents\business-analyst.md" "## Teams Planner Output" $true

# --- Phase 5: ROLE-BOUNDARY ---
foreach ($agent in @("project-manager","product-owner","business-analyst","scrum-master")) {
    Check "5.x ROLE-BOUNDARY in $agent (Copilot)" `
        "generated\copilot\agents\$agent.agent.md" "ROLE-BOUNDARY:" $true
    Check "5.x ROLE-BOUNDARY in $agent (Claude)" `
        "generated\claude\agents\$agent.md" "ROLE-BOUNDARY:" $true
}
Check "5.9 Out of scope pattern in PM" `
    "generated\copilot\agents\project-manager.agent.md" "Out of scope" $true
Check "5.10 Must NOT do in SM" `
    "generated\copilot\agents\scrum-master.agent.md" "Must NOT do|Must-NOT-do" $true

# --- Phase 6: Platform Purity ---
Check "6.1 No CC-ONLY narrative in Copilot BA" `
    "generated\copilot\agents\business-analyst.agent.md" "Task\(Explorer" $false
Check "6.2 No Copilot handoff syntax in Claude BA" `
    "generated\claude\agents\business-analyst.md" "handoffs:" $false

# --- Summary ---
if ($errors -eq 0) {
    Write-Host "`n✅ All checks passed." -ForegroundColor Green
} else {
    Write-Host "`n❌ $errors check(s) failed." -ForegroundColor Red
    exit 1
}
```

Run from repo root:

```powershell
powershell.exe -ExecutionPolicy Bypass -File scripts\validate-pm-patterns.ps1
```

---

## Step 4 — CHANGELOG.md Update

Add the following block under `## [Unreleased]` → `### Added` in `CHANGELOG.md`:

```markdown
- **Encode ADR-008 PM agent coordination patterns (task 002)** — All 5 pattern categories from ADR-008 are now encoded into shared templates and propagated to `generated/copilot/` and `generated/claude/`:
  - **Phase 1 — Conductor gate pattern**: `BAS-GATE-NNN` schema with pass/fail conditions and L1→L2→L3 escalation levels added to `conductor` and `project-manager` templates; wave sequencing rule blocks Wave N+1 until Wave N gates pass.
  - **Phase 2 — PM-tool recommendations skill**: New `templates/skills/pm-tool-recommendations/SKILL.template.md` with 7-framework trigger contract (RACI, RAID, Fishbone/Ishikawa, RAPID/DACI, BCG, Stakeholder Analysis, Project Charter). Skill wired into `project-manager`, `product-owner`, `business-analyst`, and `scrum-master` templates (body sections + CC frontmatter `skills:` list).
  - **Phase 3 — Observable ingestion error paths**: `INGESTION-DECISION` structured block (status/reason/artifact/next_action) added to ProductOwner and BusinessAnalyst templates; replaces implicit silent-failure handoffs.
  - **Phase 4 — Planner-friendly BA output**: `## Teams Planner Output` section with `PLANNER-OUTPUT` YAML schema added to BusinessAnalyst template; qualification-signal gating and no-op condition included.
  - **Phase 5 — Role boundary guards**: `## Role Boundaries` section with Must Do / Must NOT Do lists and `ROLE-BOUNDARY` YAML rejection block added to `project-manager`, `product-owner`, `business-analyst`, and `scrum-master` templates.
```

---

## Step 5 — Task Close-Out via consolidate-task

After the CHANGELOG update, invoke the `consolidate-task` skill to produce an ADR summarising the completed work and reducing `.tasks/` clutter:

1. Open the `consolidate-task` skill (`c:\Users\s1058662\.copilot\skills\consolidate-task\SKILL.md`)
2. Trigger: _"Consolidate task `.tasks/002-encode-pm-agent-patterns`"_
3. The skill will produce a summary ADR under `docs/architecture/` and mark `.tasks/002-encode-pm-agent-patterns/task.md` status as consolidated.
4. Verify that `.tasks/002-encode-pm-agent-patterns/task.md` frontmatter `status:` is set to `consolidated`.

> The consolidate-task skill determines the exact ADR number and file path at run time. Suggested name: `ADR-009-pm-pattern-implementation.md`.

---

## Verification

### Automated Checks

> Requires `scripts/validate-pm-patterns.ps1` created in Step 3.

```powershell
# Regenerate
node scripts/generate.js

# Validate all patterns
powershell.exe -ExecutionPolicy Bypass -File scripts\validate-pm-patterns.ps1
```

### Success Criteria

| Criterion | Pass condition |
|-----------|---------------|
| Generator runs clean | `node scripts/generate.js` exits with no errors |
| All 30+ pattern checks pass | `validate-pm-patterns.ps1` reports `✅ All checks passed` |
| CHANGELOG updated | `[Unreleased]` section contains all 5 phase descriptions |
| Task consolidated | ADR created and task status marked consolidated |

### Manual Spot-Check (4 critical flows)

1. Open `generated/copilot/agents/business-analyst.agent.md` — confirm `## Teams Planner Output`, `INGESTION-DECISION:`, `ROLE-BOUNDARY:`, and `pm-tool-recommendations` skill reference all appear in the rendered file.
2. Open `generated/copilot/agents/conductor.agent.md` — confirm `BAS-GATE-NNN` format schema and wave sequencing rule are visible.
3. Open `generated/copilot/skills/pm-tool-recommendations/SKILL.md` — confirm the 7-framework trigger table and `PM-TOOL-RECOMMENDATION:` block schema are present.
4. Open `generated/copilot/agents/product-owner.agent.md` — confirm `silently fail` does not appear except within a Must-NOT-do list. (Cannot be reliably automated: a regex cannot distinguish the phrase appearing as an anti-pattern example vs. as active instruction text.)

---

## Tests

No new template logic is introduced in Phase 6 — this is a pure validation phase. The existing `tests/validate-skills.sh` and `tests/test-generate.sh` cover generator integrity; the new `validate-pm-patterns.ps1` script covers PM pattern propagation specifically.

After Phase 6, run:

```powershell
node scripts/generate.js
powershell.exe -ExecutionPolicy Bypass -File scripts\validate-pm-patterns.ps1
```

And optionally (in bash/WSL):

```bash
./tests/test-generate.sh
./tests/validate-skills.sh
```
