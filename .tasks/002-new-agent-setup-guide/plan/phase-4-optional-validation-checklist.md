# Phase 4 Plan: Optional Validation Checklist

## Objective
Create a standalone, optional validation checklist artifact that users can run after following the setup guide to confirm generated artifacts, directive validity, and discoverability in Copilot and Claude Code.

## Scope
- In scope: planning and authoring a concise, execution-ready checklist document under Phase 4 artifacts.
- In scope: checklist coverage for generated file existence, directive transform correctness, frontmatter sanity, install path confirmation, and runtime discoverability checks.
- In scope: a small cross-reference update in the Phase 3 guidance so users can find the optional checklist.
- Out of scope: changing generator logic, installer behavior, or template schema in `C:/Users/s1058662/repos/agents`.

## Inputs
- `.tasks/002-new-agent-setup-guide/artifacts/phase-3/phase-3-setup-guidance.md`
- `.tasks/002-new-agent-setup-guide/artifacts/phase-3/appendix-sources.md`
- `.tasks/002-new-agent-setup-guide/artifacts/phase-2/phase-2-template-requirements.md`
- `.tasks/002-new-agent-setup-guide/artifacts/phase-1/phase-1-evidence-table.md`

## Detailed File Changes
1. Create `.tasks/002-new-agent-setup-guide/artifacts/phase-4/phase-4-optional-validation-checklist.md`.
- Add a compact, task-oriented checklist with sections:
  - Preconditions
  - Generated artifacts validation
  - Directive and frontmatter validation
  - Installation path validation
  - Discoverability validation (Copilot + Claude Code)
  - Failure triage and next actions

2. Update `.tasks/002-new-agent-setup-guide/artifacts/phase-3/phase-3-setup-guidance.md`.
- Add a short "Optional advanced validation" pointer in the Validation or Installation section referencing the new Phase 4 checklist artifact.
- Keep edits minimal and non-duplicative (link out instead of restating checklist details).

3. Update `.tasks/002-new-agent-setup-guide/task.md` when implementation of this phase is complete.
- Move Phase 4 status from `📋 Planned` to `🔄 In Progress` and then to `✅ Done` after verification is complete.
- Add a completion note summarizing checklist artifact delivery.

## Implementation Steps
1. Create the Phase 4 artifact directory.
- Ensure `.tasks/002-new-agent-setup-guide/artifacts/phase-4/` exists.

2. Draft the optional checklist artifact.
- Write a short intro explaining this checklist is optional and intended for high-confidence validation.
- Organize checks so they can be run in order, each with:
  - The command or action
  - Expected passing result
  - What to do when it fails

3. Add generated artifact checks.
- Include checks for expected generated outputs for both platforms.
- Include checks that outputs align with expected naming/path conventions.

4. Add directive/frontmatter checks.
- Include grep/select-string checks for malformed or unstripped directives.
- Include required frontmatter key checks (`name`, `description`, platform-specific blocks in expected output shape).

5. Add installation/discoverability checks.
- Include install-path existence checks for Copilot and Claude Code agent directories.
- Include manual runtime invocation checks for agent discoverability in both platforms.

6. Add a triage matrix.
- Map common failure signals to likely cause and corrective action.
- Keep entries aligned with Phase 3 troubleshooting terminology.

7. Link Phase 3 guidance to the new checklist.
- Add one brief reference line in Phase 3 to avoid duplicate maintenance.

8. Verify and finalize.
- Run automated validation commands in this plan.
- Confirm artifact readability and command correctness.

## Expected Outputs
- `.tasks/002-new-agent-setup-guide/artifacts/phase-4/phase-4-optional-validation-checklist.md` (primary deliverable)
- Minor pointer update in `.tasks/002-new-agent-setup-guide/artifacts/phase-3/phase-3-setup-guidance.md`

## Success Criteria
- A reader can run the checklist end-to-end without consulting additional internal notes.
- Checklist commands and manual checks cover the three Phase 4 intents:
  - Generated artifact correctness
  - Directive/frontmatter validity
  - Agent discoverability after install
- Checklist avoids redundancy with Phase 3 by linking where needed instead of copying full sections.
- All referenced file paths and commands match evidence gathered in Phases 1-3.

## Verification
### Automated Checks
- `Test-Path .tasks/002-new-agent-setup-guide/artifacts/phase-4/phase-4-optional-validation-checklist.md`
- `Select-String -Path .tasks/002-new-agent-setup-guide/artifacts/phase-4/phase-4-optional-validation-checklist.md -Pattern "generated|directive|frontmatter|discoverability|Copilot|Claude"`
- `Select-String -Path .tasks/002-new-agent-setup-guide/artifacts/phase-4/phase-4-optional-validation-checklist.md -Pattern "make|make validate|install.sh|Test-Path|Select-String"`
- `Select-String -Path .tasks/002-new-agent-setup-guide/artifacts/phase-3/phase-3-setup-guidance.md -Pattern "Optional advanced validation|phase-4-optional-validation-checklist"`

### Manual Verification Steps
1. Read checklist top-to-bottom and confirm each item has an action, a pass condition, and a failure action.
2. Confirm the checklist can be followed independently by a user who completed Phase 3 guidance.
3. Confirm Phase 3 references the Phase 4 checklist once, with no duplicate long-form validation prose.

### Success Evidence
- Phase 4 checklist file exists and includes all validation sections.
- Phase 3 includes a pointer to Phase 4 optional checklist.
- Commands in the checklist are syntactically valid and aligned with prior phase artifacts.

## Tests
Not applicable for this phase because it is documentation/planning work and does not change executable behavior.