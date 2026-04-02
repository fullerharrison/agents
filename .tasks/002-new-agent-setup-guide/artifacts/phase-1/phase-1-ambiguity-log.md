# Phase 1 Ambiguity Log

Date: 2026-03-17
Target repository: C:/Users/s1058662/repos/agents

## Entry 1
- ambiguity: Phase plan verification commands require `rg`, but this environment does not have `rg` in PATH.
- source_files_checked:
  - C:/Users/s1058662/repos/agents/templates/README.md
  - C:/Users/s1058662/repos/agents/README.md
  - C:/Users/s1058662/repos/agents/Makefile
  - C:/Users/s1058662/repos/agents/package.json
- current_assumption: PowerShell fallback (`Get-ChildItem`, `Select-String`) is acceptable for equivalent verification until `rg` is installed.
- follow_up_owner_action: In Phase 2, either install `rg` or explicitly document accepted fallback command equivalents in task verification notes.

## Entry 2
- ambiguity: README says contributors should run `make` before install, while install.sh can generate internally using user config and temp output.
- source_files_checked:
  - C:/Users/s1058662/repos/agents/README.md:149-153
  - C:/Users/s1058662/repos/agents/install.sh:289-309
- current_assumption: Canonical contributor flow remains `make` then `./install.sh`; internal generation inside installer is a safety mechanism, not the primary author workflow.
- follow_up_owner_action: Phase 2 should call out both behaviors and specify recommended primary path for new-agent guidance.

## Entry 3
- ambiguity: templates/README documents strict validation errors for directives, but enforcement details are split between documentation examples and generator implementation logic.
- source_files_checked:
  - C:/Users/s1058662/repos/agents/templates/README.md:221-229
  - C:/Users/s1058662/repos/agents/scripts/generate.js:579-625
- current_assumption: Generator implementation is source of truth for enforcement semantics; README remains normative guidance.
- follow_up_owner_action: Phase 2 should prioritize generator behavior when docs and implementation nuance diverge.

## Entry 4
- ambiguity: README install destination table mentions IntelliJ global instructions support, while templates/README focuses on copilot/cc template mapping and does not discuss IntelliJ behavior.
- source_files_checked:
  - C:/Users/s1058662/repos/agents/README.md:158-170
  - C:/Users/s1058662/repos/agents/install.sh:329-337
  - C:/Users/s1058662/repos/agents/templates/README.md
- current_assumption: IntelliJ installation is installer-level behavior only and not part of template authoring contract.
- follow_up_owner_action: Phase 2 should keep IntelliJ notes in an install/discovery section, separate from template authoring requirements.

## Entry 5
- ambiguity: Resolved path mismatch between earlier plan wording and implementation destination for Phase 1 artifacts.
- source_files_checked:
  - .tasks/002-new-agent-setup-guide/plan/phase-1-repo-reconnaissance.md
  - User request in current implementation session
- current_assumption: Resolved. Phase 1 authoritative destination is `.tasks/002-new-agent-setup-guide/artifacts/phase-1/`, and artifacts were produced there.
- follow_up_owner_action: Keep downstream phase references aligned to `artifacts/phase-1` as the canonical Phase 1 location.
