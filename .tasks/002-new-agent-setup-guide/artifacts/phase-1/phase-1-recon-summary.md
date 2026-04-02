# Phase 1 Recon Summary

Date: 2026-03-17
Target repository inspected: C:/Users/s1058662/repos/agents
Task: 002-new-agent-setup-guide

## Scope Executed
- Completed read-only reconnaissance for repository layout, template contract, generation flow, install/discovery flow, and test safeguards.
- Did not edit files in C:/Users/s1058662/repos/agents.
- Produced citation-backed evidence for all 7 inspection steps in the phase plan.

## Verified Directory and Workflow Map
- Top-level workflow entry points exist: README.md, Makefile, package.json, install.sh, scripts/, tests/, templates/, generated/.
  - Evidence: C:/Users/s1058662/repos/agents/README.md:24, C:/Users/s1058662/repos/agents/Makefile:1, C:/Users/s1058662/repos/agents/package.json:1, C:/Users/s1058662/repos/agents/install.sh:11
- Template source-of-truth and generated outputs are documented in README structure.
  - Evidence: C:/Users/s1058662/repos/agents/README.md:304-309
- Generator script and build targets are explicitly mapped.
  - Evidence: C:/Users/s1058662/repos/agents/README.md:320-324, C:/Users/s1058662/repos/agents/Makefile:9-19
- Generated output structure present in repo:
  - generated/copilot/{agents,instructions,skills}
  - generated/claude/{agents,rules,skills}
  - Evidence: recursive file listing captured via Get-ChildItem output.

## Command Inventory (Build/Generate/Install/Validate)
- Generation:
  - make (all platforms): C:/Users/s1058662/repos/agents/README.md:152
  - make copilot: C:/Users/s1058662/repos/agents/Makefile:9-11
  - make cc: C:/Users/s1058662/repos/agents/Makefile:13-15
  - npm scripts: generate, generate:copilot, generate:cc
    - Evidence: C:/Users/s1058662/repos/agents/package.json:7-9
- Validation:
  - make validate (dry-run check against committed generated files)
    - Evidence: C:/Users/s1058662/repos/agents/Makefile:17-19, C:/Users/s1058662/repos/agents/README.md:344
- Installation:
  - ./install.sh (global install)
  - ./install.sh uninstall
  - ./install.sh helpers
  - Evidence: C:/Users/s1058662/repos/agents/README.md:24, C:/Users/s1058662/repos/agents/README.md:351, C:/Users/s1058662/repos/agents/README.md:225

## Template Contract Checklist (Frontmatter + Directives)
- Required top-level shared fields for agent templates: name, description.
  - Evidence: C:/Users/s1058662/repos/agents/templates/README.md:23-59
- Required platform blocks for agent templates: copilot: and cc:.
  - Evidence: C:/Users/s1058662/repos/agents/templates/README.md:32,46; C:/Users/s1058662/repos/agents/scripts/generate.js:656-659
- Valid directives:
  - SHARED, COPILOT-ONLY, /COPILOT-ONLY, CC-ONLY, /CC-ONLY
  - Evidence: C:/Users/s1058662/repos/agents/templates/README.md:229; C:/Users/s1058662/repos/agents/scripts/generate.js:251-257
- Directive constraints:
  - no nesting, no orphan closing tags, no unknown directives, blocks must close
  - Evidence: C:/Users/s1058662/repos/agents/templates/README.md:121-126,225-229; C:/Users/s1058662/repos/agents/scripts/generate.js:593-625
- Instruction special case:
  - applyTo: "**" maps to CC output without frontmatter
  - Evidence: C:/Users/s1058662/repos/agents/templates/README.md:100-101; C:/Users/s1058662/repos/agents/scripts/generate.js:554-574

## Existing Agent Template Conventions (Inspected)
- Explorer template includes full dual-platform frontmatter with handoffs and CC disallowed tools.
  - Evidence: C:/Users/s1058662/repos/agents/templates/agents/explorer.template.md:2-63
- Builder template includes dual-platform tools and skills mapping.
  - Evidence: C:/Users/s1058662/repos/agents/templates/agents/builder.template.md:2-69
- Reviewer template confirms same pattern and includes CC disallowed edit/write tools.
  - Evidence: C:/Users/s1058662/repos/agents/templates/agents/reviewer.template.md:2-58

## Template-to-Output Mapping (Verified)
- Agents:
  - templates/agents/*.template.md -> generated/copilot/agents/*.agent.md
  - templates/agents/*.template.md -> generated/claude/agents/*.md
  - Evidence: C:/Users/s1058662/repos/agents/templates/README.md:9-10,175-176; C:/Users/s1058662/repos/agents/scripts/generate.js:729-737
- Skills:
  - templates/skills/*/SKILL.template.md -> generated/copilot/skills/*/SKILL.md
  - templates/skills/*/SKILL.template.md -> generated/claude/skills/*/SKILL.md
  - Evidence: C:/Users/s1058662/repos/agents/templates/README.md:11-12,176-177; C:/Users/s1058662/repos/agents/scripts/generate.js:739-747
- Instructions:
  - templates/instructions/*.template.md -> generated/copilot/instructions/*.instructions.md
  - templates/instructions/*.template.md -> generated/claude/rules/*.md
  - Evidence: C:/Users/s1058662/repos/agents/templates/README.md:13-14,177-178; C:/Users/s1058662/repos/agents/scripts/generate.js:749-760

## Install and Discovery Behavior
- Installer target locations:
  - ~/.copilot/agents, ~/.copilot/instructions, ~/.copilot/skills
  - ~/.claude/agents, ~/.claude/rules, ~/.claude/skills
  - ~/.config/github-copilot/intellij/global-copilot-instructions.md
  - Evidence: C:/Users/s1058662/repos/agents/install.sh:30-37,329; C:/Users/s1058662/repos/agents/README.md:158-166
- VS Code discovery settings are configured by installer.
  - Evidence: C:/Users/s1058662/repos/agents/install.sh:363; C:/Users/s1058662/repos/agents/README.md:170
- Installer requires generated files to be present (check_generated_files).
  - Evidence: C:/Users/s1058662/repos/agents/install.sh:221-257,297

## Test Coverage Protecting Template Correctness
- test-generate.sh checks counts, CC global rule frontmatter omission, tools: and paths: constraints.
  - Evidence: C:/Users/s1058662/repos/agents/tests/test-generate.sh:34-76,94-101,122-145
- test-install.sh validates copy-based install, manifest correctness, and uninstall behavior.
  - Evidence: C:/Users/s1058662/repos/agents/tests/test-install.sh:48-108,120-142,245-279
- validate-skills.sh validates frontmatter presence and cross-platform parity.
  - Evidence: C:/Users/s1058662/repos/agents/tests/validate-skills.sh:39-51,150-151,198,211-224

## Minimal New Agent Creation Path Draft (Citation-Backed)
1. Create new template at templates/agents/<agent-name>.template.md using dual-platform frontmatter contract.
   - Evidence: C:/Users/s1058662/repos/agents/README.md:233; C:/Users/s1058662/repos/agents/templates/README.md:23-59
2. Include required fields (name, description, copilot:, cc:) and valid directives only.
   - Evidence: C:/Users/s1058662/repos/agents/scripts/generate.js:647-659; C:/Users/s1058662/repos/agents/templates/README.md:229
3. Regenerate outputs with make (or platform-specific generate commands).
   - Evidence: C:/Users/s1058662/repos/agents/README.md:152-153; C:/Users/s1058662/repos/agents/Makefile:9-19
4. Validate with make validate.
   - Evidence: C:/Users/s1058662/repos/agents/README.md:344; C:/Users/s1058662/repos/agents/Makefile:17-19
5. Install/discover with ./install.sh (and optional helpers), then rely on configured VS Code locations.
   - Evidence: C:/Users/s1058662/repos/agents/README.md:24,170,225; C:/Users/s1058662/repos/agents/install.sh:30-37,363

## Coverage Against Phase Plan Steps
- Step 1 top-level layout and entry points: covered.
- Step 2 template authoring guidance: covered.
- Step 3 at least two templates inspected: covered (3 templates inspected).
- Step 4 template-output mapping and generated conventions: covered.
- Step 5 generation/validation commands and script trace: covered.
- Step 6 install/discovery behavior: covered.
- Step 7 tests that protect correctness: covered.

## Verification Notes for Phase Plan Automated Checks
- Planned command `rg --files` could not run because rg is not installed in this environment.
- Equivalent fallback checks executed using PowerShell:
  - Get-ChildItem -Recurse -File (file existence inventory)
  - Select-String for contract/workflow terms in templates/README.md, README.md, Makefile, package.json
- This tooling gap is recorded in ambiguity log with current assumption and follow-up action.
