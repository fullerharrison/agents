# Phase 3: Draft Step-by-Step Setup Guidance

**Date:** 2026-03-17  
**Objective:** Translate Phase 2's 32 requirements into clear, actionable user guidance for creating a new agent template in the mcouthon/agents framework.

---

## 1. Objective

Convert extracted requirements (Phase 2 artifact) into a comprehensive, user-facing setup guidance document that enables a developer to:
1. Understand the agent template structure and naming conventions
2. Create a new agent template file with correct frontmatter and body directives
3. Generate dual-platform outputs (Copilot + CC)
4. Validate and install the new agent
5. Verify discoverability in both platforms

---

## 2. Inputs

| Input | Source | Description |
| --- | --- | --- |
| **Phase 2 Requirements** | `artifacts/phase-2/phase-2-template-requirements.md` | 32 citation-backed requirements across 9 sections (frontmatter, directives, generation, validation, installation, etc.) |
| **Phase 1 Evidence** | `artifacts/phase-1/phase-1-evidence-table.md` | Repository structure, tools info, naming patterns, validation/generation/installation behavior |
| **Template Examples** | `C:/Users/s1058662/repos/agents/templates/agents/` | Existing agent templates (explorer, builder, reviewer) as live reference patterns |
| **Relevant Docs** | `C:/Users/s1058662/repos/agents/templates/README.md` + `README.md` | Generator function, validation rules, installation flows |

---

## 2.5 Ambiguity Decision Rule

**During Phase 3 implementation, escalate ambiguities as follows:**
- **Type-1 (Missing required field, syntax error):** Escalate to Phase 4; document in Appendix
- **Type-2 (Conflicting Phase 1 evidence vs. Phase 2 req):** Escalate to Phase 4; document root cause in Appendix
- **Type-3 (Source documentation is ambiguous, not Phase 1/2 data issue):** Defer to Phase 4; note in Appendix that resolution requires clarification from mcouthon/agents repo maintainers
- **Type-4 (Guidance itself is unclear to reader, not underlying ambiguity in reqs):** Revise Phase 3 step text; do NOT escalate

---

## 2.6 Verification Gates (Informational Checks)

**Phase 3 verification gates track traceability and completeness; they are informational targets, not hard blockers:**
- **Target:** ≥90% traceability (each guidance step cites a Phase 2 requirement or Phase 1 evidence)
- **Acceptable:** 85%+ traceability is acceptable if gaps are Phase 2 requirements (Phase 2 research gaps do not block Phase 3)
- **Hard blocker (≥95% required):** Factual errors in guidance (e.g., wrong command syntax, wrong directory path)

Missing traceability below 85% → revisit Phase 2 or add Appendix clarification note.

---

## 3. Detailed Implementation Steps

### Step 3.1: Create Overview & Quick-Start Section
**Task:** Write "Overview & Quick-Start" section that addresses:
- What is an agent template? (definition, context in framework)
- This guide's scope and boundaries (Option A adopted):
  - **In scope:** Agent templates (comprehensive walkthrough)
  - **Skills/instructions brief note (~75 lines subsection):**
    - Skill and instruction templates share the same frontmatter/directive structure as agents
    - Key difference: different applyTo patterns and namespace separation
    - Full skill/instruction authoring guidance is in separate docs; this guide focuses on agents
    - Brief reference only: template type naming (`.template.md` suffix for all types)
  - **Not in scope:** Training on YAML, Markdown, generators internals
- Workflow at a glance: author template → generate → validate → install
- Prerequisites check: Node.js, `make`, local repo clone at `C:/Users/s1058662/repos/agents`

**Output expectations:**
- ~175 lines (includes ~75-line skills/instructions subsection)
- Plain language, no jargon assumptions
- Links to repo structure for reference
- Include one conceptual diagram (text-based or reference existing)

**Citation base:** Phase 2 reqs 1.1 (Agent Template Definition), Phase 1 Evidence (repo location, tools)

---

### Step 3.2: Create Agent Template Mandatory Frontmatter Section
**Task:** Draft comprehensive, single-step walkthrough of agent frontmatter (YAML) requirements:
1. **Top-Level Fields** (name, description)
   - Explanation of each field
   - Naming conventions (kebab-case from Phase 1)
   - Examples (reference explorer, builder agents)
   
2. **Copilot Section** (`copilot:`)
   - List all fields from Phase 2 req 1.2 (tools, model, agents, handoffs, user-invokable, disable-model-invocation)
   - Explain each: what it does, when required, when optional
   - Provide example configurations for different agent types (e.g., user-invokable explorer vs. internal worker)
   
3. **CC Section** (`cc:`)
   - List fields from Phase 2 req 1.3 (tools, disallowedTools, model, skills, permissionMode)
   - Explain each with examples
   - Call out differences from copilot: section (e.g., `disallowedTools`, `permissionMode`)

4. **Validation Notes**
   - Generator will fail if required fields missing (Phase 2 req 1.1)
   - Show example error message expectations

5. **Worked Examples**
   - Brief inline examples for each field type
   - Compare explorer vs. builder frontmatter configurations
   - Annotated YAML showing best practices

**Output expectations:**
- **300–450 lines** (consolidated single step with worked examples)
- Structured with subsections (one per field or logical grouping)
- Real examples from existing templates (explorer.template.md, builder.template.md, etc.)
- Clear emphasis on **required** vs. **optional**
- Table format for field reference + inline yaml examples

**Citation base:** Phase 2 reqs 1.1–1.3, template examples from Phase 1

---

### Step 3.3: Create Body Directives Reference Section
**Task:** Explain how to structure template body with directives:
1. **Directive Types** (from Phase 2 req 2.x)
   - `<!-- SHARED -->` — content in both outputs
   - `<!-- COPILOT-ONLY -->` → `<!-- /COPILOT-ONLY -->` — Copilot output only
   - `<!-- CC-ONLY -->` → `<!-- /CC-ONLY -->` — CC output only
   
2. **Valid Nesting**
   - Which directives can nest (e.g., SHARED inside COPILOT-ONLY vs. impossible nests)
   - Examples of valid and invalid nesting
   
3. **Content Guidelines**
   - Markdown preservation rules (Phase 2 req 2.x details)
   - "Soft strip" vs. "hard strip" (from templates/README.md)
   - Platform-specific config references (e.g., `$CC_TOOL_NAME` in CC-ONLY sections)

4. **Common Patterns**
   - Example: tool configuration that differs by platform
   - Example: workflow instructions that differ (Copilot UI vs. CC function calls)

**Output expectations:**
- ~150–200 lines
- Multiple worked examples (before/after transformation)
- Clear visual markup for directive boundaries
- Quick-reference table of incompatible nesting

**Citation base:** Phase 2 reqs 2.1–2.5, templates/README.md:229+

---

### Step 3.4: Create Template Creation Walkthrough (Hands-On Example)
**Task:** Provide step-by-step worked example: create a minimal "CustomReviewer" agent template
1. **Define Requirements**
   - Agent name, description, purpose (for this example)
   - Which platforms (Copilot, CC)
   - Key tools needed
   
2. **Author Template File**
   - Show full file structure (frontmatter + body)
   - Fill in frontmatter step-by-step (name → description → copilot: → cc:)
   - Add sample body content with directives
   - Explain any choices (e.g., why certain tools chosen)
   
3. **Save to Correct Location**
   - Path: `templates/agents/custom-reviewer.template.md`
   - Naming convention confirmation
   
4. **Verify Before Generation**
   - Quick manual checks (all required fields present, valid YAML syntax)

5. **Optional: Test CustomReviewer Against Actual Repository (INFORMATIONAL)**
   - **Requirement:** Complete the full generation → validation → installation workflow with the CustomReviewer template against the actual mcouthon/agents repository
   - **Rationale:** Validates that the step-by-step example is accurate and implementable; catches undocumented field requirements or platform-specific gotchas
   - **Success criteria:** Generated outputs appear in `generated/agents/copilot/` and `generated/agents/cc/` with correct directives stripped and platform-specific content preserved
   - **Important escalation policy:** If CustomReviewer test fails:
     - **Escalate to Phase 4** — do NOT block Phase 3 completion
     - Document failure + root cause analysis in Appendix (Section 3.9)
     - Phase 3 remains complete; Phase 4 will address undocumented gotchas or edge cases
   - **Repo version baseline:** Tested against agents repo commit [TO BE RECORDED at start of Phase 3 implementation]

**Output expectations:**
- ~200–250 lines
- Complete, copy-paste-ready template code
- Annotations in comments explaining each section
- Clear line-by-line breakdown
- Repo version baseline recorded in preamble

**Citation base:** Phase 2 reqs 1.1–1.3, existing template examples

---

### Step 3.5: Create Generation Workflow Section
**Task:** Explain how to regenerate outputs from the template:
1. **When to Regenerate**
   - After creating/editing template
   - After changing directive structure
   - Full regeneration vs. single-agent regeneration
   
2. **Generation Command Walkthrough**
   - Basic: `make` (regenerates all agents, skills, instructions)
   - Advanced: `npm run generate -- --agent custom-reviewer` (single agent)
   - Expected output files in `generated/` directory
   
3. **Verify Generation Success**
   - Check output files exist: `generated/agents/copilot/custom-reviewer.md`, `generated/agents/cc/custom-reviewer.md`
   - Quick content sanity check (directives stripped, platform-specific content correct)
   - No error messages in build log

**Output expectations:**
- ~100–120 lines
- Exact command syntax (from Makefile, Phase 1 evidence)
- Expected file tree snapshot
- Troubleshooting subsection for common generation errors

**Citation base:** Phase 1 Evidence (Makefile, scripts/generate.js), Phase 2 req 3.x

---

### Step 3.6: Create Validation Section
**Task:** Explain validation checks to confirm generated outputs are correct:
1. **Dry-Run Validation**
   - Command: `npm run validate` (or `make validate`)
   - What it checks: generated/ vs. committed files
   - Success output: "All files valid"
   - Failure handling: understand diff, regenerate if needed
   
2. **Manual Validation Checklist**
   - Check Copilot output: directives removed, platform-specific content present
   - Check CC output: directives removed, CC-specific fields flattened/included
   - Check naming conventions (kebab-case files, correct directories)
   - Check frontmatter in output vs. template (validation rules from Phase 2 req 1.x)
   
3. **Discrepancy Resolution**
   - If generated/ ≠ committed files: regenerate + commit
   - If validation fails: check frontmatter syntax, directive structure

**Output expectations:**
- ~100–150 lines
- Step-by-step validation checklist
- Example passing/failing scenarios
- Clear action items for each failure type

**Citation base:** Phase 2 req 4.x, README.md (validate command), Phase 1 Evidence

---

### Step 3.7: Create Installation & Discovery Section
**Task:** Guide user to install generated agent into platform discovery paths:
1. **Installation Workflow**
   - Command: `./install.sh` (or `bash install.sh` on Windows)
   - What it does: copies generated files to:
     - Copilot: `~/.copilot/agents/`
     - CC: `~/.claude/agents/`
   - Output confirmation: agent discoverable in UI
   
2. **Verify Discoverability**
   - Copilot: Command Palette → "Copilot: Get Help" → list includes your agent
   - CC: Agent prompt prefix invocation (e.g., `@CustomReviewer`)
   - Quick UX test: invoke agent, confirm it responds
   
3. **Uninstall / Manual Install**
   - If needed, manually copy files
   - Directory structure inside ~/.copilot/, ~/.claude/
   - File naming requirements for discovery

**Output expectations:**
- ~100–120 lines
- Exact commands for all OSs (Windows batch note from Phase 1)
- Screenshots or UI navigation tips (if applicable)
- Troubleshooting: agent doesn't appear, etc.

**Citation base:** Phase 2 req 5.x, Phase 1 Evidence (install.sh, ~/.copilot paths), README.md

---

### Step 3.8: Create Troubleshooting & Edge Cases Section
**Task:** Address common issues and special scenarios:
1. **Generation Failures**
   - Missing required fields → add them, regenerate
   - Invalid YAML syntax → validate YAML, fix, regenerate
   - Unrecognized directive → check spelling, correct nesting
   
2. **Validation Issues**
   - Generated files not in committed artifacts → run validate, regenerate if needed
   - Frontmatter mismatch in output → check transform rules (Phase 2 req 1.5 for instructions, etc.)
   
3. **Installation Problems**
   - Agent not discoverable → verify install.sh ran, check ~/.copilot/ structure
   - Tool names not recognized → validate against Phase 2 req 1.2 (Copilot tool list)
   
4. **Special Cases**
   - Global instructions (applyTo: "**") → no frontmatter in CC output (Phase 2 req 1.5 special case)
   - Skill templates vs. agent templates (different frontmatter structure)
   - Multi-platform conflicts (same tool name, different availability)

**Output expectations:**
- ~120–150 lines
- Flowchart or decision tree (text-based is OK)
- Concrete error messages + resolutions
- Cross-references to relevant requirement sections

**Citation base:** Phase 2 req sections 1–5, existing examples showing edge case handling

---

### Step 3.9: Create Appendices & Reference
**Task:** Provide quick lookup tables and summaries:
1. **Pre-Validation Substep: Verify Appendix Data Sources (STAGING ARTIFACT)**
   - Before drafting final appendix tables, create a staging artifact listing source data:
     - Which Phase 1 evidence row supplies required fields for agents/skills/instructions?
     - Which Phase 2 requirements define tool availability matrix?
     - Where in templates/README.md are naming conventions documented?
   - **Verification:** Cross-check all table rows against source; document any discrepancies or clarifications needed
   - **Output:** `artifacts/phase-3/appendix-sources.md` (staging artifact — remains in task artifacts folder; used for verification traceability only, not deleted after Phase 3)

2. **Quick Reference: Mandatory Fields by Template Type**
   - Agent template required fields
   - Skill template required fields (brief note that full detail is out-of-scope; link to separate guidance)
   - Instruction template required fields (brief note that full detail is out-of-scope; link to separate guidance)
   
3. **Tool Availability Matrix**
   - Which tools available in Copilot vs. CC (from Phase 1)
   - Common tool names and usage contexts
   
4. **Naming Convention Cheat Sheet**
   - File names: kebab-case with .template.md suffix
   - Directory structure: templates/agents/, templates/skills/, templates/instructions/
   - Output file naming: generated/agents/copilot/name.md vs. generated/agents/cc/name.md
   
5. **Link Directory**
   - Links to templates/README.md sections (frontmatter, directives, generation)
   - Links to generator source (scripts/generate.js key functions)
   - Links to existing template examples

**Output expectations:**
- ~100–120 lines
- Dense tables, minimal prose
- High scannability
- All citations traceable to Phase 2 or Phase 1

**Citation base:** All Phase 2 requirements (taxonomy), Phase 1 Evidence table

---

## 4. Phase 3 Completion Criteria

**Phase 3 is complete when ALL of the following are true:**

1. ✅ **Artifact exists:** `draft-setup-guidance.md` with all 9 steps fully written, no placeholder sections
2. ✅ **Traceability:** ≥85% of guidance text cites Phase 1 evidence or Phase 2 requirements; gaps documented in Appendix
3. ✅ **Scope adherence:** All in-scope steps completed (Steps 3.1–3.9); skills/instructions use Option A (~75-line subsection); out-of-scope items omitted
4. ✅ **Examples are accurate:** "CustomReviewer" worked example matches required fields from Phase 2; if test fails, failure documented in Appendix; Phase 3 does NOT wait for success
5. ✅ **Ambiguities resolved:** Type-1/2/3 ambiguities escalated and documented; no ambiguous guidance statements remain

**Handoff:** Phase 3 complete when user reviews artifact, confirms traceability gaps are acceptable, and approves `draft-setup-guidance.md` for Phase 4 (optional validation checklist & integration testing).

---

## 4. Sequencing & Drafting Order

### Timeline Reality Check: Part-Time / Distributed Effort
**⚠️ Note:** The sequence below assumes full-time, continuous focus. If Phase 3 work is part-time or distributed across a team:
- Add 50–100% buffer to each day's estimate
- Budget extra time for async reviews/feedback loops
- Steps 3.1, 3.2, 3.9 are highest-priority; complete these first for early feedback
- Steps 3.3–3.8 can be parallelized across contributors (low dependency across sections)
- Plan for 1–2 days of consolidation and cross-linking at the end (not just "morning")

**Recommended draft sequence (can be parallelized):**

1. **Day 1 morning:** Steps 3.1 + 3.9 (Structure, roadmap, reference tables)
2. **Day 1 afternoon:** Step 3.2 (Frontmatter walkthrough; heaviest citation work)
3. **Day 2 morning:** Step 3.3 (Directives; moderate complexity)
4. **Day 2 afternoon:** Steps 3.4 + 3.5 (Worked example + generation; concrete examples)
   - *Note: Step 3.4 includes validation substep; allow extra time for testing against actual repo*
5. **Day 3 morning:** Steps 3.6 + 3.7 (Validation + installation; operational guidance)
6. **Day 3 afternoon:** Step 3.8 (Troubleshooting; consolidate patterns)
7. **Day 4 morning:** Consolidate, cross-link, final editing

---

## 5. Expected Output Artifact

**Filename:** `artifacts/phase-3/phase-3-setup-guidance.md`

**Structure:**
```
# New Agent Setup Guidance: Complete Reference

## Table of Contents
1. Overview & Quick-Start
2. Agent Template Mandatory Frontmatter
3. Body Directives Reference
4. Hands-On: Create Your First Agent Template
5. Generation Workflow
6. Validation
7. Installation & Discovery
8. Troubleshooting & Edge Cases
9. Appendices & Reference

[Estimated ~600–800 lines of formatted markdown]
```

**Key properties:**
- **Clarity:** Plain language, step-by-step, minimal jargon
- **Traceability:** Every major statement cited to Phase 2 requirement or Phase 1 evidence
- **Completeness:** All 6 template types covered (agents, skills, instructions, split by Copilot/CC)
- **Usability:** Hands-on example walkable by end user; troubleshooting accessible

**Success criteria:**
- No unresolved ambiguities (cross-check against Phase 2 req 6-9 open questions)
- All ~32 Phase 2 requirements addressed or explicitly marked out-of-scope
- Every guided section traceable to at least one Phase 2 requirement
- Worked example is complete and functional (can be copy-pasted)

---

## 6. Success Criteria

### Clarity & Usability
- [ ] Each section uses plain language; no undefined jargon
- [ ] Code examples are complete and copy-paste ready
- [ ] Step-by-step sequences are unambiguous to a developer new to the framework
- [ ] Terminology consistent with Phase 2 glossary (req 1.0)

### Traceability & Citation
- [ ] Every major claim cites at least one Phase 2 requirement or Phase 1 evidence
- [ ] Requirement → guidance mapping is explicit (can create traceability audit)
- [ ] No statements present without source (verify against artifact completeness)

### Completeness vs. Scope
- [ ] All agent template aspects covered (frontmatter, directives, generation, validation, installation)
- [ ] Skill + instruction guidance mentioned (brief; full detail out of scope for Phase 3)
- [ ] Edge cases documented (global instructions, multi-platform conflicts, etc.)
- [ ] Known limitations called out explicitly

### No Unresolved Ambiguities
- [ ] All Phase 2 req 6-9 "ambiguity log" items addressed or marked out-of-scope
- [ ] If tool availability varies, clearly mapped (Phase 1 evidence)
- [ ] Validation rules are unambiguous and testable (can user verify their agent is valid?)

---

## 7. Verification

### Readability Gate (WHO: Phase 3 Drafter and 1+ Peer Reviewer | WHAT: Clarity & Usability | WHEN: Before marking verification complete)
1. **Skim test:** Can a developer new to agents skim overview, understand agent concept, and follow quick-start in <5 min?
2. **Example walkthrough:** Can same developer follow worked example (3.4) and create functional template without external help?
3. **Reference check:** Can user find quick answers in appendix for common questions (field requirements, naming, tool names)?
4. **Peer feedback:** At least one independent reviewer confirms: clear language, accurate examples, no undefined jargon

### Phase 2 Traceability Audit (WHO: Phase 3 Drafter | WHAT: Citation Coverage | WHEN: After all sections drafted)
1. **Requirement coverage:** Create mapping of 32 Phase 2 requirements → guidance sections
2. **Citation density:** ≥90% of requirements cited in guidance document
3. **No false claims:** No guidance statement contradicts Phase 2 requirements
4. **Evidence crosswalk:** All Phase 1 evidence references (tool names, paths, commands) match actual repo state

### Completeness vs. Scope Verification (WHO: Phase 3 Drafter | WHAT: Scope Boundary Enforcement | WHEN: After each major section)
1. **Scope validation:** Does guidance cover all agent template aspects? (Yes = check scope in 3.1 above)
2. **Skill/Instruction mention:** Are they briefly mentioned as out-of-scope for Phase 3? (Yes = clarify scope limits; link to separate guidance where applicable)
3. **Edge case coverage:** Are known special cases documented? (Yes = check 3.8 list against Phase 2 req 2.1–2.5)

### Artifact Validation Checklist (WHO: Builder / Implementer | WHAT: Technical Correctness | WHEN: After Phase 3 implementation)
- [ ] File saved to `artifacts/phase-3/phase-3-setup-guidance.md`
- [ ] Optional staging artifact `artifacts/phase-3/appendix-sources.md` exists and is cross-referenced
- [ ] File is valid Markdown (no syntax errors)
- [ ] Table of contents links resolve
- [ ] All code blocks are syntactically valid (check frontmatter YAML, directives)
- [ ] Total line count ~600–800 (within expected range)
- [ ] CustomReviewer worked example tested against actual mcouthon/agents repo and passes generation → validation → installation workflow (from Step 3.4)

---

## 8. Dependencies & Assumptions

### Prerequisites Met
- Phase 1 reconnaissance complete (repo structure, tool inventory, validation/generation behaviors known)
- Phase 2 requirements extracted (32 requirements with 100% citation coverage)
- mcouthon/agents repo cloned locally at `C:/Users/s1058662/repos/agents`

### Assumptions
- End user has Node.js, `make`, and basic Markdown editing familiarity
- End user can navigate to repo and run commands (Makefile, install.sh)
- Copilot and CC are already installed locally (guidance assumes this)

### Out of Scope for Phase 3
- Creating an actual production agent template in the repo (implementer's task, not this guidance doc)
- Troubleshooting installation on exotic platforms (guidance covers standard Windows/macOS/Linux only)
- Deep dives into generator internals (scripts/generate.js reference, not full code walkthrough)
- Training on YAML, Markdown, or other prerequisites (assumed learner skill)
- Comprehensive guidance for skill and instruction templates (brief scope clarification only; full detail deferred to future phase)

### Ambiguity Escalation Decision Rule
**IF new ambiguities surface during Phase 3 drafting:**
- **Ambiguity type 1 (Phase 2 requirement conflict or unclear):** Documented in `artifacts/phase-3/ambiguity-log.md` with evidence from Phase 1 or Phase 2; escalate to Phase 4 planning (do not delay Phase 3 completion)
- **Ambiguity type 2 (Phase 1 evidence outdated or missing):** Validate against actual mcouthon/agents repo; document discrepancy and corrected fact; reference correction in Phase 3 guidance
- **Ambiguity type 3 (CustomReviewer example reveals undocumented requirement):** Fix example and add clarification to relevant guidance section; do not mark Phase 3 complete until example is validated
- **Escalation:** If >3 ambiguities of type 2–3 identified, flag for team review before finalizing Phase 3

---

## 9. Handoff Criteria: Phase 3 Complete When...

**Phase 3 is COMPLETE and ready for handoff when ALL of the following are true:**

1. **✅ Primary artifact exists:** `artifacts/phase-3/phase-3-setup-guidance.md` with ~600–800 lines, covering Steps 3.1–3.9
2. **✅ Step 3.4 validation passed:** CustomReviewer worked example tested end-to-end against mcouthon/agents repo; generated outputs verified in `generated/agents/copilot/` and `generated/agents/cc/`; no validation errors
3. **✅ Traceability audit passed:** ≥90% of Phase 2 reqs cited in guidance; mapping document `artifacts/phase-3/phase-2-traceability-mapping.md` created and reviewed
4. **✅ Readability verified:** At least one independent peer review completed confirming clarity, accuracy, and no undefined jargon; OR self-check passed against skim/walkthrough tests (section 7.0)
5. **✅ No contradictions:** Guidance aligns with Phase 2 requirements; no conflicts between requirements and guidance statements
6. **✅ Scope boundaries clear:** Section 3.1 (Overview) explicitly states agent template in-scope; skills/instructions marked as out-of-scope for Phase 3 with links to deferred guidance
7. **✅ Ambiguities resolved:** All ambiguities from Phase 3 drafting documented in `artifacts/phase-3/ambiguity-log.md`; none block Phase 3 completion (type-1 ambiguities deferred to Phase 4)
8. **✅ Task.md updated:** Phase 3 status set to ✅ Done; phase table updated with links to primary artifact(s); dependencies and out-of-scope items re-confirmed

---

## 10. Notes

- Leverage Phase 1 evidence table heavily for specific tool names, path conventions, command syntax
- Use existing templates (explorer, builder, reviewer) as worked examples throughout
- Maintain citation style consistency (link format, section references) for treaceability
- Consider generating a quick-reference PDF or single-page printout target for end users (low priority)

