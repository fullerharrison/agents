# Phase 1 Plan: Repo Reconnaissance

## Objective
Build a reliable map of the `mcouthon/agents` repository areas required for authoring and validating a new agent setup guide, with source-backed references that later phases can use directly.

## Scope
- In scope: read-only inspection of repository structure, template system, generation pipeline, and installation/discovery paths.
- Out of scope: editing the target external repository, generating artifacts, or installing agents.

## Detailed File/Repo Inspection Steps
For every step below, record at least one source citation (file path + line anchor or section heading) in the Phase 1 evidence table.

1. Confirm top-level layout and key workflow entry points in the target repo:
   - `README.md`
   - `Makefile`
   - `package.json`
   - `install.sh`
   - `scripts/`
   - `tests/`
   - `templates/`
   - `generated/`
2. Inspect template authoring guidance:
   - `templates/README.md` (frontmatter contract, directives, mapping rules, validation constraints)
3. Inspect at least two existing agent templates to identify conventions reused by maintainers:
   - `templates/agents/explorer.template.md`
   - `templates/agents/builder.template.md`
   - optional third comparator: `templates/agents/reviewer.template.md`
4. Trace template-to-output mapping and generated artifact conventions:
   - verify corresponding outputs in `generated/agents/`, `generated/skills/`, and `generated/instructions/` where applicable
5. Identify generation and validation commands from build tooling:
   - parse `Makefile` targets for generation/validation flow
   - parse `package.json` scripts used by generation or checks
   - inspect any generation scripts under `scripts/` referenced by build targets
6. Inspect install/discovery behavior for agent availability:
   - `install.sh` and root docs for install destination and expected post-install discoverability
7. Review tests that protect template correctness:
   - inspect `tests/` for frontmatter/directive validation expectations and failure conditions

## Implementation/Research Steps
1. Capture authoritative references (file + section/line anchors) for:
   - required frontmatter keys
   - required `copilot` and `cc` blocks
   - valid directives and formatting constraints
2. Build a minimal “new agent creation path” draft from source evidence:
   - choose template filename pattern
   - required metadata fields
   - body structure rules
   - generation command sequence
   - install/discovery path
3. Record mismatches/ambiguities found between docs and scripts:
   - note where behavior is implied by tooling but absent in docs
   - mark assumptions explicitly for Phase 2 resolution
4. Produce an evidence table for handoff to Phase 2:
   - each requirement mapped to exact source file location

## Concrete Outputs Expected
- Output destination (all Phase 1 outputs must be written under this task folder):
   - `.tasks/002-new-agent-setup-guide/artifacts/phase-1/phase-1-recon-summary.md`
   - `.tasks/002-new-agent-setup-guide/artifacts/phase-1/phase-1-evidence-table.md`
   - `.tasks/002-new-agent-setup-guide/artifacts/phase-1/phase-1-ambiguity-log.md`
- A reconnaissance summary artifact containing:
  - verified directory and workflow map
  - command inventory for build/generation/install
  - template contract checklist (frontmatter + directives)
- An evidence table artifact (requirement -> source file -> citation) ready to drive Phase 2 extraction.
- A standardized ambiguity log artifact listing unresolved questions discovered in source documents.
   - Required fields for each entry:
      - `ambiguity`
      - `source_files_checked`
      - `current_assumption`
      - `follow_up_owner_action`

## Success Criteria
- All Phase 1 findings are traceable to explicit repository sources (no guesswork).
- Required files and commands for agent-template authoring are identified and documented.
- Template contract elements are enumerated with enough precision to draft setup guidance in Phase 3 without re-discovery.
- Ambiguities are isolated and clearly labeled for next-phase follow-up.

## Verification
### Automated Checks
- `rg --files` from `C:/Users/s1058662/repos/agents` confirms referenced files exist.
- `rg "frontmatter|directive|copilot:|cc:" templates/README.md` confirms key contract terms are discoverable.
- `rg "make|install|generate|template" README.md Makefile package.json` confirms workflow command references are captured.

### Manual Checks
1. Verify inspection coverage: each of the 7 Detailed File/Repo Inspection Steps has at least one corresponding citation recorded in `.tasks/002-new-agent-setup-guide/artifacts/phase-1/phase-1-evidence-table.md`.
2. Cross-check each evidence row against the actual source file section to ensure references are accurate.
3. Ensure at least two agent templates were inspected and differences/commonalities are captured with citations.
4. Validate that the documented command sequence (authoring -> generation -> installation/discovery) is coherent and citation-backed.
5. Confirm `.tasks/002-new-agent-setup-guide/artifacts/phase-1/phase-1-ambiguity-log.md` entries use all required fields: `ambiguity`, `source_files_checked`, `current_assumption`, `follow_up_owner_action`.

### Success Evidence
- Recon summary, evidence table, and ambiguity log are present at the specified task-folder destinations and internally consistent.
- Another reviewer can reconstruct the setup path using only the documented references.

## Tests
Not applicable for this phase because it is research/planning only and does not introduce executable behavior changes.
