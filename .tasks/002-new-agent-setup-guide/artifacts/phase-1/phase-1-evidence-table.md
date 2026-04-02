# Phase 1 Evidence Table

Date: 2026-03-17
Target repository: C:/Users/s1058662/repos/agents

| Requirement / Finding | Source File | Citation | Evidence Extract | Notes |
| --- | --- | --- | --- | --- |
| Top-level install entrypoint exists | C:/Users/s1058662/repos/agents/README.md | README.md:24 | `./install.sh` shown in quickstart workflow | Step 1 |
| Template changes require regeneration then install | C:/Users/s1058662/repos/agents/README.md | README.md:27 | `Modifying templates? Run make first...` | Step 1/5 |
| Build targets defined for generation/validation | C:/Users/s1058662/repos/agents/Makefile | Makefile:4-19 | `all`, `copilot`, `cc`, `validate` targets | Step 1/5 |
| package scripts expose generation commands | C:/Users/s1058662/repos/agents/package.json | package.json:7-9 | `generate`, `generate:copilot`, `generate:cc` | Step 1/5 |
| templates/, scripts/, tests/, generated/ present | C:/Users/s1058662/repos/agents | Get-ChildItem inventory | Recursive listing includes all required directories | Step 1 |
| Template directory mapping documented | C:/Users/s1058662/repos/agents/templates/README.md | templates/README.md:9-14 | maps templates -> generated/copilot and generated/claude outputs | Step 2/4 |
| Agent template frontmatter contract includes copilot and cc | C:/Users/s1058662/repos/agents/templates/README.md | templates/README.md:23-59 | shared metadata + `copilot:` + `cc:` sections | Step 2 |
| Skill template cc extension behavior documented | C:/Users/s1058662/repos/agents/templates/README.md | templates/README.md:61-80 | Copilot strips cc fields; CC keeps flattened fields | Step 2 |
| Instruction template `applyTo` behavior documented | C:/Users/s1058662/repos/agents/templates/README.md | templates/README.md:82-101 | `applyTo` maps to CC `paths`; global omits CC frontmatter | Step 2/4 |
| Valid directives list is explicit | C:/Users/s1058662/repos/agents/templates/README.md | templates/README.md:229 | SHARED, COPILOT-ONLY, /COPILOT-ONLY, CC-ONLY, /CC-ONLY | Step 2 |
| Directive error constraints documented | C:/Users/s1058662/repos/agents/templates/README.md | templates/README.md:225-226 | nested / unknown directive failures | Step 2 |
| Explorer template follows contract | C:/Users/s1058662/repos/agents/templates/agents/explorer.template.md | explorer.template.md:2-63 | name, description, copilot, handoffs, cc, tools, skills | Step 3 |
| Builder template follows contract | C:/Users/s1058662/repos/agents/templates/agents/builder.template.md | builder.template.md:2-69 | dual-platform blocks and handoffs present | Step 3 |
| Reviewer template follows contract | C:/Users/s1058662/repos/agents/templates/agents/reviewer.template.md | reviewer.template.md:2-58 | dual-platform blocks + disallowedTools in cc | Step 3 |
| Generator enforces known directives | C:/Users/s1058662/repos/agents/scripts/generate.js | generate.js:251-257,277,593 | KNOWN_DIRECTIVES set and unknown-directive checks | Step 5 |
| Generator enforces required name/description for agents/skills | C:/Users/s1058662/repos/agents/scripts/generate.js | generate.js:647-649 | validation adds missing field errors | Step 5 |
| Generator enforces required copilot/cc sections for agents | C:/Users/s1058662/repos/agents/scripts/generate.js | generate.js:656-659 | missing copilot/cc sections are errors | Step 5 |
| Generator enforces applyTo for instructions | C:/Users/s1058662/repos/agents/scripts/generate.js | generate.js:675 | missing applyTo is error | Step 5 |
| Output naming mapping for agents | C:/Users/s1058662/repos/agents/scripts/generate.js | generate.js:729-737 | Copilot -> `.agent.md`, CC -> `.md` | Step 4/5 |
| Output naming mapping for skills | C:/Users/s1058662/repos/agents/scripts/generate.js | generate.js:739-747 | both platforms -> `SKILL.md` in skill dir | Step 4/5 |
| Output naming mapping for instructions/rules | C:/Users/s1058662/repos/agents/scripts/generate.js | generate.js:749-760 | Copilot -> `.instructions.md`; CC -> `.md` rule | Step 4/5 |
| Global CC instruction has no frontmatter behavior in generator | C:/Users/s1058662/repos/agents/scripts/generate.js | generate.js:554-574 | CC instruction formatter omits frontmatter when no scoped cc section | Step 4/5 |
| Installer target paths for discovery | C:/Users/s1058662/repos/agents/install.sh | install.sh:30-37 | ~/.copilot and ~/.claude destination directories defined | Step 6 |
| Installer verifies generated files before install | C:/Users/s1058662/repos/agents/install.sh | install.sh:221-257,297 | check_generated_files with explicit expected artifacts | Step 6 |
| Installer copies generated outputs to destinations | C:/Users/s1058662/repos/agents/install.sh | install.sh:320-325 | copy_tree for copilot/claude agents, skills, instructions/rules | Step 6 |
| Installer configures VS Code discovery settings | C:/Users/s1058662/repos/agents/install.sh | install.sh:363 | runs `scripts/configure-vscode-settings.js` | Step 6 |
| README documents install destinations and discoverability | C:/Users/s1058662/repos/agents/README.md | README.md:158-170 | installed-to table and VS Code settings mention | Step 6 |
| generated/copilot agent outputs exist | C:/Users/s1058662/repos/agents/generated/copilot/agents | directory listing | builder.agent.md ... worker.agent.md present | Step 4 |
| generated/claude agent outputs exist | C:/Users/s1058662/repos/agents/generated/claude/agents | directory listing | builder.md ... worker.md present | Step 4 |
| generated/copilot instructions exist | C:/Users/s1058662/repos/agents/generated/copilot/instructions | directory listing | global/python/terminal/typescript instructions present | Step 4 |
| generated/claude rules exist | C:/Users/s1058662/repos/agents/generated/claude/rules | directory listing | global/python/terminal/typescript rules present | Step 4 |
| Test suite checks generated artifact counts | C:/Users/s1058662/repos/agents/tests/test-generate.sh | test-generate.sh:34-76 | expects >=7 agents, >=12 skills, >=4 instructions/rules per platform | Step 7 |
| Test suite checks global CC rule no frontmatter | C:/Users/s1058662/repos/agents/tests/test-generate.sh | test-generate.sh:94-101 | fails if first line is `---` for global rule | Step 7 |
| Test suite checks CC agent tools frontmatter | C:/Users/s1058662/repos/agents/tests/test-generate.sh | test-generate.sh:122-131 | each CC agent must contain `tools:` | Step 7 |
| Test suite checks CC rule paths frontmatter where applicable | C:/Users/s1058662/repos/agents/tests/test-generate.sh | test-generate.sh:133-145 | rules with frontmatter must include `paths:` | Step 7 |
| Install tests verify copy-not-symlink behavior | C:/Users/s1058662/repos/agents/tests/test-install.sh | test-install.sh:48-108 | validates installed files are copies | Step 7 |
| Install tests verify manifest and uninstall lifecycle | C:/Users/s1058662/repos/agents/tests/test-install.sh | test-install.sh:120-142,245-279 | manifest creation/count/removal and migration checks | Step 7 |
| Validator checks required frontmatter in generated agents | C:/Users/s1058662/repos/agents/tests/validate-skills.sh | validate-skills.sh:39-51,150-151 | enforces name/description/tools for copilot and CC agents | Step 7 |
| Validator checks global CC rule frontmatter constraint | C:/Users/s1058662/repos/agents/tests/validate-skills.sh | validate-skills.sh:198 | errors if global CC rule has frontmatter | Step 7 |
| Validator checks cross-platform parity | C:/Users/s1058662/repos/agents/tests/validate-skills.sh | validate-skills.sh:211-224 | agent and skill counts must match across platforms | Step 7 |
| Recommended contributor command sequence | C:/Users/s1058662/repos/agents/README.md | README.md:233-237 | create template -> `make` -> `./install.sh` | Phase 2 handoff |
| Validation command for generated drift | C:/Users/s1058662/repos/agents/README.md | README.md:344-345 | `make validate` then `make` if needed | Phase 2 handoff |

## Automated Verification Commands Run (Fallback)
- `rg` commands from phase plan could not run (`rg` unavailable in terminal PATH).
- Fallback command used for file existence: `Get-ChildItem -Recurse -File | Select-Object -ExpandProperty FullName`.
- Fallback command used for contract terms: `Select-String -Path templates/README.md -Pattern "frontmatter|directive|copilot:|cc:"`.
- Fallback command used for command terms: `Select-String -Path README.md,Makefile,package.json -Pattern "make|install|generate|template"`.
