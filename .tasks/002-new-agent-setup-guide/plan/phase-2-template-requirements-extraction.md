# Phase 2 Plan: Template Requirements Extraction

## Objective
Extract and normalize the authoritative requirements for creating a new agent template in `mcouthon/agents`, producing a source-cited requirement set with complete citation coverage (100% of extracted requirements) that Phase 3 can convert directly into step-by-step setup guidance.

## Scope
- In scope: requirements extraction from Phase 1 evidence and source references, including frontmatter contract, directives, naming/mapping, and workflow command expectations.
- In scope: mandatory direct-source reconciliation of extracted requirements against primary sources (`templates/README.md`, `scripts/generate.js`, representative existing template files under `templates/agents/`, and any additional source that materially defines authoring/validation behavior).
- Out of scope: writing end-user setup guide prose (Phase 3), editing external repo files, running generation/install commands, or validating actual generated artifacts.

## Inputs
- `.tasks/002-new-agent-setup-guide/artifacts/phase-1/phase-1-evidence-table.md`
- `.tasks/002-new-agent-setup-guide/artifacts/phase-1/phase-1-recon-summary.md`
- `.tasks/002-new-agent-setup-guide/artifacts/phase-1/phase-1-ambiguity-log.md`
- Primary sources for direct reconciliation:
  - `templates/README.md`
  - `scripts/generate.js`
  - Representative existing template examples (required reconciliation inputs), at minimum:
    - `templates/agents/engineering-lead-agent.md`
    - `templates/agents/product-manager-agent.md`
    - `templates/agents/sre-agent.md`
  - Additional high-authority source files identified in Phase 1 evidence (as applicable)

## Detailed Steps
1. Confirm Phase 2 artifact output location before extraction.
- Create or confirm `.tasks/002-new-agent-setup-guide/artifacts/phase-2/` exists before writing any Phase 2 outputs.
- Treat this as a hard precondition to avoid partial output placement or path drift.

2. Build the requirement taxonomy for agent authoring.
- Create sections for: required frontmatter keys, platform-specific blocks (`copilot`, `cc`), valid body directives, directive constraints, filename/path conventions, template-to-output mapping, and command workflow requirements.
- Ensure each section can be consumed independently by Phase 3 without further discovery.

3. Extract mandatory frontmatter and structural requirements.
- Use Phase 1 evidence tied to `templates/README.md` and `scripts/generate.js` to list mandatory keys and required sections.
- Include explicit error-triggering omissions (missing `name`, `description`, `copilot`, `cc`) so guidance can prevent invalid templates.

4. Extract directive and content-block rules.
- Enumerate allowed directives and strict constraints (no unknown directive, no nesting, no orphan closing tag, balanced open/close blocks).
- Capture implementation-backed enforcement points from generator logic where documentation is less explicit.

5. Extract naming and template/output mapping requirements.
- Define required template naming and target generated filenames for both platforms.
- Include mapping for agents and note adjacent mappings (skills/instructions) only where needed to explain shared conventions.

6. Extract workflow command requirements for downstream guide authoring.
- Capture canonical contributor workflow as action + commands: author/create the template file, then run `make`, then run `make validate`, then run `./install.sh`.
- Explicitly treat "create template" as an authoring action (editing/adding a template file), not as an executable shell command literal.
- Keep fallback command notes for environments without `rg` as an optional operational caveat, not a core extraction requirement.

7. Perform mandatory direct-source reconciliation before finalizing requirements.
- Reconcile each extracted requirement directly against `templates/README.md`, `scripts/generate.js`, and representative existing template files under `templates/agents/`.
- For any requirement with nuance, corroborate against additional high-authority source files from Phase 1 evidence and record the reconciliation basis.

8. Resolve or annotate ambiguities for Phase 3.
- Review each ambiguity from Phase 1 and classify as: resolved rule, explicit caveat, or deferred note.
- Prioritize generator-enforced behavior when documentation and implementation nuance differ.

9. Produce the Phase 2 output artifact.
- Write a concise, citation-backed requirements extraction document under task artifacts, grouped by requirement category and including traceability to source evidence.

10. Maintain task tracking status flow consistency.
- Keep phase tracking aligned with project status flow: `⬜ Not Started` -> `📋 Planned` -> `⭐ Reviewed` -> `🔄 In Progress` -> `✅ Done`.
- During execution, move Phase 2 from `📋 Planned` to `🔄 In Progress`, then to `✅ Done` only after verification passes.

## Expected Outputs
- Primary output:
  - `.tasks/002-new-agent-setup-guide/artifacts/phase-2/phase-2-template-requirements.md`
- Required content in the output artifact:
  - Requirement taxonomy and glossary for template authoring terms
  - Mandatory frontmatter/section requirements for agent templates
  - Valid directives and directive constraints
  - Naming and output mapping matrix (template path -> generated path)
  - Canonical command workflow requirements and caveats
  - Ambiguity resolution notes with final assumptions for Phase 3
  - Source traceability table (requirement -> source file -> citation)

## Success Criteria
- 100% of extracted requirements are backed by at least one explicit citation from Phase 1 evidence (full citation audit, no sampling).
- 100% of extracted requirements are directly reconciled against primary sources (`templates/README.md`, `scripts/generate.js`, and representative existing template examples under `templates/agents/`), with additional source reconciliation documented where used.
- Requirements are written in implementation-ready language (normative "must/should" statements), not exploratory notes.
- Phase 3 can draft user-facing setup guidance without reopening repository discovery.
- Ambiguities that affect authoring guidance are either resolved or clearly labeled with constrained assumptions.

## Verification
### Automated Checks
- Confirm Phase 1 inputs exist:
  - `Test-Path .tasks/002-new-agent-setup-guide/artifacts/phase-1/phase-1-evidence-table.md`
  - `Test-Path .tasks/002-new-agent-setup-guide/artifacts/phase-1/phase-1-recon-summary.md`
  - `Test-Path .tasks/002-new-agent-setup-guide/artifacts/phase-1/phase-1-ambiguity-log.md`
- Confirm Phase 2 artifact directory exists before writing output:
  - `Test-Path .tasks/002-new-agent-setup-guide/artifacts/phase-2`
- Confirm Phase 2 output exists after extraction:
  - `Test-Path .tasks/002-new-agent-setup-guide/artifacts/phase-2/phase-2-template-requirements.md`
- Confirm required section content is present (not heading-only):
  - Mandatory frontmatter content includes key requirements:
    - `Select-String -Path .tasks/002-new-agent-setup-guide/artifacts/phase-2/phase-2-template-requirements.md -Pattern "name|description|copilot|cc"`
  - Directive section content includes concrete constraints:
    - `Select-String -Path .tasks/002-new-agent-setup-guide/artifacts/phase-2/phase-2-template-requirements.md -Pattern "unknown directive|no nesting|orphan|balanced"`
  - Mapping section content includes explicit template-to-output examples:
    - `Select-String -Path .tasks/002-new-agent-setup-guide/artifacts/phase-2/phase-2-template-requirements.md -Pattern "templates/agents/.+ -> .+\.agent\.md|template path -> generated path"`
  - Workflow section content distinguishes action vs commands:
    - `Select-String -Path .tasks/002-new-agent-setup-guide/artifacts/phase-2/phase-2-template-requirements.md -Pattern "author/create the template file|not .* executable shell command|make validate|./install.sh"`
  - Traceability/reconciliation content includes all required primary-source families:
    - `Select-String -Path .tasks/002-new-agent-setup-guide/artifacts/phase-2/phase-2-template-requirements.md -Pattern "templates/README.md|scripts/generate.js|templates/agents/"`

### Manual Verification Steps
1. Perform a full citation audit of all extracted requirements (100% coverage) against the Phase 1 evidence table and confirm there are no uncited requirements.
2. Reconcile every extracted requirement directly against `templates/README.md`, `scripts/generate.js`, and representative existing templates under `templates/agents/`; confirm any additional source used is explicitly documented in traceability.
3. Verify all mandatory agent-template fields and section requirements are included and match generator enforcement behavior.
4. Verify canonical workflow language explicitly distinguishes the authoring action (create template file) from executable commands (`make`, `make validate`, `./install.sh`), is consistent with README guidance and installer behavior notes, and labels any `rg` fallback as optional operational guidance.
5. Confirm each Phase 1 ambiguity has a Phase 2 disposition (resolved/caveat/deferred) and rationale.

### Success Evidence
- `.tasks/002-new-agent-setup-guide/artifacts/phase-2/phase-2-template-requirements.md` is present and complete.
- Requirement coverage is fully traceable (100% cited and reconciled), non-duplicative, and ready to feed Phase 3 drafting.

## Tests
Not applicable for this phase because it is documentation/planning extraction work and does not change executable behavior.
