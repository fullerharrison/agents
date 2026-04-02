# Phase 3 Appendix Sources — Staging Artifact

**Date:** 2026-03-17  
**Purpose:** Pre-validation artifact verifying that all appendix data sources in phase-3-setup-guidance.md are traceable to Phase 1 evidence and Phase 2 requirements.  
**Status:** Verification Complete

---

## Appendix A: Mandatory Fields Quick Reference — Source Validation

| Table Entry | Source | Verified? |
| --- | --- | --- |
| Agent template required fields (name, description, copilot:, cc:) | Phase 2 Req. 1.1–1.3 | ✅ |
| Skill template fields (name, description, optional cc:) | Phase 2 Req. 1.4 | ✅ |
| Instruction template fields (name, description, applyTo:) | Phase 2 Req. 1.5 | ✅ |
| Output platform mapping | Phase 2 Req. 3.1, Phase 1 Evidence | ✅ |

---

## Appendix B: Directive Nesting Matrix — Source Validation

| Matrix Entry | Source | Verified? |
| --- | --- | --- |
| COPILOT-ONLY ↔ CC-ONLY nesting forbidden | Phase 2 Req. 2.2 (No nesting constraint) | ✅ |
| SHARED inside platform blocks forbidden | Phase 2 Req. 2.2 (SHARED inside block forbidden) | ✅ |
| Content before directives is implicitly SHARED | Phase 2 Req. 2.1–2.2 (Implementation Guidance) | ✅ |

---

## Appendix C: Template-to-Output File Mapping — Source Validation

| Mapping Line | Source | Verified? |
| --- | --- | --- |
| Agent: `.template.md` → `.agent.md` (Copilot), `.md` (CC) | Phase 2 Req. 3.1; Phase 1 Evidence (Template-to-Output Mapping section) | ✅ |
| Skill: `SKILL.template.md` → `SKILL.md` (both) | Phase 2 Req. 3.1; Phase 1 Evidence | ✅ |
| Instruction: `.template.md` → `.instructions.md` (Copilot), `rules/*.md` (CC) | Phase 2 Req. 3.1; Phase 1 Evidence | ✅ |

---

## Appendix D: Discovery Paths Reference — Source Validation

| Path Entry | Source | Verified? |
| --- | --- | --- |
| Copilot agents: `~/.copilot/agents/` | Phase 2 Req. 5.1; Phase 1 Evidence (Install Destination Paths) | ✅ |
| CC agents: `~/.claude/agents/` | Phase 2 Req. 5.1; Phase 1 Evidence | ✅ |
| Copilot instructions: `~/.copilot/instructions/` | Phase 2 Req. 5.1; Phase 1 Evidence | ✅ |
| CC rules: `~/.claude/rules/` | Phase 2 Req. 5.1; Phase 1 Evidence | ✅ |
| IntelliJ Copilot global: `~/.config/github-copilot/intellij/global-copilot-instructions.md` | Phase 2 Req. 5.1; Phase 1 Evidence | ✅ |

---

## Appendix E: Tool Availability Matrix — Source Validation

| Tool Category | Source | Verified? |
| --- | --- | --- |
| Copilot tools (vscode/* paths) | Phase 2 Req. 1.2 (Copilot Section Example) | ✅ |
| CC tools (Read, Write, Grep, Glob, Edit) | Phase 2 Req. 1.3 (CC Section Example) | ✅ |
| CC disallowed tools | Phase 2 Req. 1.3 (`disallowedTools` field) | ✅ |

---

## Appendix F: Common Agent Patterns — Source Validation

| Pattern | Source | Verified? |
| --- | --- | --- |
| User-invokable agent (default: true) | Phase 2 Req. 1.2 (`user-invokable` field) | ✅ |
| Internal worker agent (user-invokable: false) | Phase 2 Req. 1.2 (optional field) | ✅ |
| Orchestrator/Conductor agent (disable-model-invocation, agents, handoffs) | Phase 2 Req. 1.2 (optional fields) | ✅ |
| Skill integration pattern (skills: field in cc:) | Phase 2 Req. 1.3 (`skills` field in CC section) | ✅ |

---

## Appendix G: Quick Command Reference — Source Validation

| Command | Source | Verified? |
| --- | --- | --- |
| `make` (generate all) | Phase 2 Req. 4.2; Phase 1 Evidence (Makefile references) | ✅ |
| `make copilot` | Phase 2 Req. 4.2; Phase 1 Evidence | ✅ |
| `make cc` | Phase 2 Req. 4.2; Phase 1 Evidence | ✅ |
| `npm run generate` | Phase 2 Req. 4.2; Phase 1 Evidence (package.json) | ✅ |
| `make validate` | Phase 2 Req. 4.3; Phase 1 Evidence (Makefile) | ✅ |
| `./install.sh` | Phase 2 Req. 4.4; Phase 1 Evidence (install.sh) | ✅ |
| `./install.sh uninstall` | Phase 2 Req. 4.4; Phase 1 Evidence | ✅ |

---

## Appendix H: Generator Error Reference — Source Validation

| Error Message | Source (Phase 2 Req.) | Verified? |
| --- | --- | --- |
| `Error: Missing required field 'name'` | 1.1 (mandatory field enforcement) | ✅ |
| `Error: Missing required field 'description'` | 1.1 (mandatory field enforcement) | ✅ |
| `Error: Unknown directive 'COPILOT_ONLY'` | 2.1–2.2 (valid directives, unknown directive error) | ✅ |
| `Error: Unclosed 'COPILOT-ONLY' block` | 2.2 (block closure constraint) | ✅ |
| `Error: Orphan closing tag '/COPILOT-ONLY'` | 2.2 (orphan closing tag constraint) | ✅ |
| `Error: Nested directive 'CC-ONLY' inside 'COPILOT-ONLY'` | 2.2 (no nesting constraint) | ✅ |

---

## CustomReviewer Worked Example — Validation Result

**Template location:** `templates/agents/custom-reviewer.template.md`  
**Generated Copilot output:** `generated/copilot/agents/custom-reviewer.agent.md`  
**Generated CC output:** `generated/claude/agents/custom-reviewer.md`  
**Generation date:** 2026-03-17  
**Repository commit baseline:** (current HEAD at test time)

### Validation Checklist

| Validation Step | Result | Evidence |
| --- | --- | --- |
| Template file created in correct location | ✅ PASS | File exists at `templates/agents/custom-reviewer.template.md` |
| Frontmatter includes all required fields | ✅ PASS | name, description, copilot:, cc: all present |
| YAML syntax valid | ✅ PASS | Generation succeeded without syntax errors |
| Copilot output file generated | ✅ PASS | `generated/copilot/agents/custom-reviewer.agent.md` exists |
| CC output file generated | ✅ PASS | `generated/claude/agents/custom-reviewer.md` exists |
| Frontmatter transformation (copilot: → top-level) | ✅ PASS | Copilot output shows flattened tools, model, user-invokable |
| Frontmatter transformation (cc: → top-level) | ✅ PASS | CC output shows flattened tools, disallowedTools, model |
| Directive structure preserved in body | ✅ PASS | Both outputs contain COPILOT-ONLY and CC-ONLY directive comments |
| Body content integrity | ✅ PASS | Shared capabilities, workflow, and platform-specific sections present |
| No validation errors during generation | ✅ PASS | `npm run generate` completed without errors |

### Generation Output Summary

```
Generating Copilot files...
  generated\copilot\agents\custom-reviewer.agent.md ✓ (created)
  [... other agents/skills/instructions ...]

Generating CC files...
  generated\claude\agents\custom-reviewer.md ✓ (created)
  [... other agents/rules/skills ...]

Summary: 24 Copilot files, 24 CC files generated (48 updated, 0 unchanged)
```

**Result:** ✅ **PASS** — CustomReviewer template is functionally correct and follows all Phase 2 requirements. Generation succeeded and both platform outputs created without errors.

---

## Overall Appendix Source Traceability Summary

| Appendix Section | # Sources | Traceability | Status |
| --- | --- | --- | --- |
| A (Mandatory Fields) | 3 | Phase 2 Req. 1.1–1.5 | ✅ 100% |
| B (Directive Nesting) | 3 | Phase 2 Req. 2.1–2.2 | ✅ 100% |
| C (File Mapping) | 3 | Phase 2 Req. 3.1 + Phase 1 Evidence | ✅ 100% |
| D (Discovery Paths) | 5 | Phase 2 Req. 5.1 + Phase 1 Evidence | ✅ 100% |
| E (Tool Matrix) | 3 | Phase 2 Req. 1.2–1.3 | ✅ 100% |
| F (Agent Patterns) | 4 | Phase 2 Req. 1.2–1.3 | ✅ 100% |
| G (Commands) | 7 | Phase 2 Req. 4.2–4.4 + Phase 1 Evidence | ✅ 100% |
| H (Error Reference) | 6 | Phase 2 Req. 1.1, 2.1–2.2 | ✅ 100% |
| CustomReviewer Example | N/A | Phase 2 Req. 1.1–1.3 (tested) | ✅ 100% |

**Total Appendix Traceability:** ✅ **100%** — All appendix data sources are traceable to Phase 2 requirements and/or Phase 1 evidence. All reconciliation complete.

---

**Artifact Status:** Ready for Phase 3 artifact submission. Phase 3 setup guidance document is fully supported by evidence-backed sources in all appendices.
