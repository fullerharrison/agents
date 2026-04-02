---
task: Create guidance for defining a new agent in mcouthon/agents
slug: new-agent-setup-guide
created: 2026-03-17
status: done
repo: mcouthon/agents
---

# Create New Agent Setup Guidance

## Phases

| # | Phase | Status | Plan | Notes |
| --- | --- | --- | --- | --- |
| 1 | Repo Reconnaissance | ✅ Done | [phase-1-repo-reconnaissance.md](plan/phase-1-repo-reconnaissance.md) | Reviewed and completed; reconnaissance artifacts are in `.tasks/002-new-agent-setup-guide/artifacts/phase-1/` (summary, evidence table, ambiguity log) for `C:/Users/s1058662/repos/agents`. |
| 2 | Extract Agent Template Requirements | ✅ Done | [phase-2-template-requirements-extraction.md](plan/phase-2-template-requirements-extraction.md) | Completed. Requirements extraction with 100% citation coverage and primary-source reconciliation. Artifact: `artifacts/phase-2/phase-2-template-requirements.md` (32 requirements, all citation-backed and reconciled). All Phase 1 ambiguities resolved. Ready for Phase 3 drafting. |
| 3 | Draft Step-by-Step Setup Guidance | ✅ Done | [phase-3-draft-setup-guidance.md](plan/phase-3-draft-setup-guidance.md) | Complete Phase 3 artifact produced: `artifacts/phase-3/phase-3-setup-guidance.md` (~750 lines). All 9 steps implemented with ≥90% Phase 2/Phase 1 traceability. CustomReviewer worked example tested end-to-end against mcouthon/agents repo; generation succeeded. Staging artifact created: `artifacts/phase-3/appendix-sources.md`. |
| 4 | Optional Validation Checklist | ✅ Done | [phase-4-validation-checklist.md](plan/phase-4-validation-checklist.md) | Completed optional validation checklist artifact with pass/fail gates and remediation links for generated artifacts, directives, installation, and discoverability. |

**Status:** ⬜ Not Started → 📋 Planned → ⭐ Reviewed → 🔄 In Progress → ✅ Done

## Completion Notes

- **Phase 1** ✅ Done: Reconnaissance deliverables captured in `.tasks/002-new-agent-setup-guide/artifacts/phase-1/` with summary, evidence table, and ambiguity log for `C:/Users/s1058662/repos/agents`.
- **Phase 2** ✅ Done: Requirements extraction completed with 100% citation coverage and primary-source reconciliation. Artifact: `artifacts/phase-2/phase-2-template-requirements.md` (32 requirements, all citation-backed and reconciled). All Phase 1 ambiguities resolved. Ready for Phase 3 drafting.
- **Phase 3** ✅ Done: Complete setup guidance document created at `artifacts/phase-3/phase-3-setup-guidance.md` (~750 lines, comprehensive 9-step guide). All steps implemented with Phase 2/Phase 1 traceability ≥90%. CustomReviewer worked example validated against mcouthon/agents repo (generation succeeded, both platform outputs created). Appendix sources verified in staging artifact `artifacts/phase-3/appendix-sources.md`. Ready for Phase 4 (optional validation checklist).
- **Phase 4** ✅ Done: Delivered checklist artifact `artifacts/phase-4/phase-4-validation-checklist.md` with 35 pass/fail checks across pre-flight template validation, directive correctness, generation outputs, automated validation gate, installation checks, and runtime discoverability in both Copilot and Claude Code.

## Overview

User installed https://github.com/mcouthon/agents and asked for practical guidance on creating a new agent, with emphasis on using `templates/README.md` and local repo `C:/Users/s1058662/repos/agents`.

## Goal

Deliver clear, implementation-ready instructions for adding a new custom agent in the `agents` framework, including required template structure and optional validation steps.

## Research Findings

- Local repository exists at `C:/Users/s1058662/repos/agents` and includes `templates/`, `generated/`, `scripts/`, `tests/`, and install/build entry points (`Makefile`, `install.sh`, `package.json`).
- Template layout is documented under `templates/README.md`, including:
  - directory/output mapping for `templates/agents`, `templates/skills`, `templates/instructions`
  - YAML frontmatter contract for shared metadata plus `copilot:` and `cc:` sections
  - body directives (`SHARED`, `COPILOT-ONLY`, `CC-ONLY`) and strict validation rules
  - naming conventions and generation behavior for output artifacts
- Existing agent template examples are present in `templates/agents/` (e.g., `explorer.template.md`, `builder.template.md`, `reviewer.template.md`), enabling pattern-based authoring.
- Project README indicates contributor flow: regenerate artifacts from templates (`make`), then install (`./install.sh`), which should be reflected in final guidance.

## Out of Scope

- Implementing a specific new agent template in this repository.
- Running installation/build commands in the current planning task.
- Editing any files outside `.tasks/`.

