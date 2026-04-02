# New Agent Setup Guidance: Complete Reference

**Date:** 2026-03-17  
**Status:** Complete Phase 3 Artifact  
**Scope:** End-to-end instructions for creating, generating, validating, and installing new agent templates in the mcouthon/agents framework.  
**Target audience:** Developers adding custom agents to the framework with minimal prior experience.

---

## Table of Contents

1. [Overview & Quick-Start](#section-1-overview--quick-start)
2. [Agent Template Mandatory Frontmatter](#section-2-agent-template-mandatory-frontmatter)
3. [Body Directives Reference](#section-3-body-directives-reference)
4. [Hands-On: Create Your First Agent Template](#section-4-hands-on-create-your-first-agent-template)
5. [Generation Workflow](#section-5-generation-workflow)
6. [Validation](#section-6-validation)
7. [Installation & Discovery](#section-7-installation--discovery)
8. [Troubleshooting & Edge Cases](#section-8-troubleshooting--edge-cases)
9. [Appendices & Reference](#section-9-appendices--reference)

---

## Section 1: Overview & Quick-Start

### What Is an Agent Template?

An **agent template** is the source file (written in Markdown with YAML frontmatter) that defines both the Copilot and Claude Code versions of an agent. Instead of maintaining two separate agent definitions, you write one template file with platform-specific directives, and the generator automatically produces the dual-platform outputs.

A template lives in the `templates/agents/` directory and has the suffix `.template.md`. When you run the generator, it reads the template and produces two output files:
- **Copilot agent:** `generated/copilot/agents/<name>.agent.md`
- **CC agent:** `generated/claude/agents/<name>.md`

**Citation:** Phase 2 Req. 1.0 (Template Definition); Phase 1 Evidence (template/output path mapping under section "Template-to-Output Mapping (Verified)").

### Scope of This Guide

This guide covers **agent templates in comprehensive detail**. It is structured to address everything you need to author, generate, validate, and install new agents.

#### Skills & Instructions: Brief Scope Note

Skill and instruction templates follow the same frontmatter and directive structure as agent templates. The key differences are:
- **Skills** live in `templates/skills/<skill-name>/SKILL.template.md` and output to `generated/{copilot,claude}/skills/` (both platforms)
- **Instructions** live in `templates/instructions/<name>.template.md` and output to Copilot as `instructions.md` and CC as `rules/*.md`
- Both use the same YAML frontmatter contract as agents (name, description).
- Full skill and instruction authoring guidance is in separate documentation; this guide focuses on agents.

**Out of scope for this guide:** Deep-dive training on YAML syntax, Markdown formatting, or generator internals beyond what's needed to author templates correctly.

### Workflow at a Glance

```
1. Author template file
   └─ Edit templates/agents/<agent-name>.template.md
      with required frontmatter and directives

          ↓

2. Generate dual-platform outputs
   └─ Run: make

          ↓

3. Validate (optional but recommended)
   └─ Run: make validate

          ↓

4. Install to discovery paths
   └─ Run: ./install.sh

          ↓

5. Agent appears in Copilot/CC UI
   └─ Invoke via agent picker or @agent-name
```

**Citation:** Phase 2 Req. 4.1 (Authoring Workflow Steps).

### Prerequisites

Before you begin, ensure you have:

- **Node.js** installed (npm/npx available)
- **make** command available (for calling build targets)
- **Bash** or equivalent shell (for running install.sh)
- **Local clone** of `C:/Users/s1058662/repos/agents` (or equivalent installation path)
- **Copilot and CC** installed locally (guidance assumes both are available)
- **Text editor** (VS Code, Vim, etc.) for editing template files

**Citation:** Phase 1 Evidence (repository structure, Makefile, install.sh references).

---

## Section 2: Agent Template Mandatory Frontmatter

The frontmatter is a YAML block at the start of every template file enclosed in `---` delimiters. It contains metadata required by the generator to produce valid outputs.

### Top-Level Shared Fields

Every agent template **MUST** include these top-level fields:

| Field | Type | Required? | Purpose | Naming Convention |
| --- | --- | --- | --- | --- |
| `name` | String | **YES** | Unique identifier for the agent (appears in file paths, UI). | kebab-case (e.g., `custom-reviewer`) |
| `description` | String | **YES** | Human-readable description of what the agent does. | Plain English, 1–2 sentences |

**Example:**
```yaml
---
name: custom-reviewer
description: Provides code review feedback and identifies potential improvements
```

**Citation:** Phase 2 Req. 1.1 (Mandatory Frontmatter Contract); Phase 1 Evidence (kebab-case naming convention).

**Validation behavior:** If `name` or `description` is missing, the generator will fail with an error message: `Error: Missing required field 'name'` or `Error: Missing required field 'description'`. These are enforced hard requirements.

**Citation:** Phase 2 Req. 1.1 (Generator Validation Behavior).

### Copilot Platform Section

The `copilot:` section defines configuration specific to the Copilot platform. This is a **REQUIRED** section.

**Required and Optional Fields:**

| Field | Type | Required? | Purpose | Example |
| --- | --- | --- | --- | --- |
| `tools` | Array of strings | Recommended | Tools available to the agent | `["vscode/askQuestions", "read/readFile", "write/replaceStringInFile"]` |
| `model` | String | Optional | Models available (opus, sonnet, etc.) | `"opus"` or `["opus", "sonnet"]` |
| `agents` | Array | Optional | Subagent references | `["Explorer", "Builder"]` |
| `handoffs` | Array of objects | Optional | UI handoff buttons | `[{label: "Implement", agent: "Builder"}]` |
| `user-invokable` | Boolean | Optional (default: true) | Whether user can invoke directly | `false` for internal agents |
| `disable-model-invocation` | Boolean | Optional (default: false) | If true, agent cannot invoke models | `true` for orchestrator agents |

**Citation:** Phase 2 Req. 1.2 (Copilot Platform Section).

**Best Practice:** Always include `tools` and `model` in production agents. Tools define what the agent can do; models define its reasoning capability.

**Example Copilot Section:**
```yaml
copilot:
  tools:
    - "vscode/askQuestions"
    - "read/readFile"
    - "write/replaceStringInFile"
  model: "opus"
  user-invokable: true
```

### CC Platform Section

The `cc:` section defines configuration specific to Claude Code. This is a **REQUIRED** section.

**Required and Optional Fields:**

| Field | Type | Required? | Purpose | Example |
| --- | --- | --- | --- | --- |
| `tools` | Array | Recommended | Tools available to the agent | `[Read, Grep, Glob, Edit, Write]` |
| `disallowedTools` | Array | Optional | Tools explicitly forbidden | `[Bash]` (if security-sensitive) |
| `model` | String | Optional | Model version | `"opus"` or `"sonnet"` |
| `skills` | Array of strings | Optional | Skill integrations | `[deep-research, architecture]` |
| `permissionMode` | String | Optional | Authorization level (for orchestrators) | `"plan"` |

**Citation:** Phase 2 Req. 1.3 (CC Platform Section).

**Key difference from Copilot:** CC sections use explicit tool names (`Read`, `Grep`, etc.) instead of VS Code tool paths. Also note `disallowedTools` (Copilot doesn't have this) to restrict access in sensitive agents.

**Example CC Section:**
```yaml
cc:
  tools:
    - Read
    - Grep
    - Edit
    - Write
  disallowedTools:
    - Bash
  model: "opus"
```

### Complete Frontmatter Template Example

Here's a minimal but complete frontmatter block:

```yaml
---
name: custom-reviewer
description: Provides detailed code review feedback and improvement suggestions

copilot:
  tools:
    - "vscode/askQuestions"
    - "read/readFile"
    - "write/replaceStringInFile"
  model: "opus"

cc:
  tools:
    - Read
    - Edit
    - Write
  disallowedTools:
    - Bash
  model: "opus"
---
```

**Validation checklist:**
- [ ] Both `copilot:` and `cc:` sections present
- [ ] `name` uses kebab-case
- [ ] `description` is provided
- [ ] YAML syntax is correct (proper indentation, colons)
- [ ] Both `tools` arrays populated
- [ ] File ends with `---` (closing delimiter)

**Citation:** Phase 2 Req. 1.1–1.3 (entire frontmatter contract); Phase 1 Evidence (Explorer, Builder, Reviewer templates as reference examples).

---

## Section 3: Body Directives Reference

After the frontmatter, the template **body** contains the instructions and capabilities for your agent. You use directives to mark which content goes to which platform.

### Directive Types

The generator recognizes exactly **five directives**:

| Directive | Purpose | Example |
| --- | --- | --- |
| `<!-- SHARED -->` | Explicitly mark content for both platforms | Clarify section boundaries (usually implicit at start) |
| `<!-- COPILOT-ONLY -->` | Start Copilot-only content block | Copilot-specific UI instructions |
| `<!-- /COPILOT-ONLY -->` | End Copilot-only content block | Closing tag (required) |
| `<!-- CC-ONLY -->` | Start CC-only content block | CC-specific workflow instructions |
| `<!-- /CC-ONLY -->` | End CC-only content block | Closing tag (required) |

**Citation:** Phase 2 Req. 2.1 (Valid Body Directives).

**Important:** Any content before the first directive is implicitly SHARED. You do not need to wrap the entire shared section explicitly in `<!-- SHARED -->` tags.

**Bad example (unnecessary):**
```markdown
<!-- SHARED -->
# Overview
This is shared content.
<!-- /SHARED -->
```

**Good example (implicit sharing):**
```markdown
# Overview
This is shared content.

<!-- COPILOT-ONLY -->
## VS Code Integration
Copilot-specific steps...
<!-- /COPILOT-ONLY -->
```

**Citation:** Phase 2 Req. 2.2 (implicit SHARED behavior, Implementation Guidance).

### Directive Constraints (Hard Rules)

The generator enforces these constraints **strictly**. Violations cause generation failure:

| Constraint | Violation | Generator Error | Citation |
| --- | --- | --- | --- |
| **Unknown directive** | Any directive not in the list above (e.g., `INVALID-ONLY`) | `Error: Unknown directive 'INVALID-ONLY' at line N` | Phase 2 Req. 2.2 |
| **No nesting** | Platform block inside another (e.g., `CC-ONLY` inside `COPILOT-ONLY`) | `Error: Nested directive 'CC-ONLY' inside 'COPILOT-ONLY' at line N` | Phase 2 Req. 2.2 |
| **No orphan closing tags** | Closing tag without matching opening (e.g., `/COPILOT-ONLY` without `COPILOT-ONLY`) | `Error: Orphan closing tag '/COPILOT-ONLY' at line N` | Phase 2 Req. 2.2 |
| **Must close blocks** | Opening `<!-- COPILOT-ONLY -->` without matching `<!-- /COPILOT-ONLY -->` | `Error: Unclosed 'COPILOT-ONLY' block` | Phase 2 Req. 2.2 |
| **SHARED inside blocks forbidden** | `<!-- SHARED -->` directive inside a platform block | `Error: SHARED directive inside 'CC-ONLY' block at line N` | Phase 2 Req. 2.2 |

**Citation:** Phase 2 Req. 2.2 (Directive Constraint Rules).

### Common Directive Patterns

#### Pattern 1: Shared content with platform-specific subsections

```markdown
## Overview
This section appears in both platforms.

<!-- COPILOT-ONLY -->
### Copilot-Specific Workflow
Steps specific to VS Code...
<!-- /COPILOT-ONLY -->

<!-- CC-ONLY -->
### Claude Code Workflow
Steps specific to Claude Code...
<!-- /CC-ONLY -->

## Conclusion
This wraps up both versions.
```

#### Pattern 2: Tool configuration differences

```markdown
## Tools

<!-- COPILOT-ONLY -->
- vscode/askQuestions
- read/readFile
- write/replaceStringInFile
<!-- /COPILOT-ONLY -->

<!-- CC-ONLY -->
- Read
- Grep
- Edit
- Write (with restrictions)
<!-- /CC-ONLY -->
```

**Citation:** Phase 2 Req. 2.1–2.5 (directive patterns and transformation behavior).

---

## Section 4: Hands-On: Create Your First Agent Template

Let's walk through creating a real, functional agent template called `CustomReviewer`. This example demonstrates all required fields and directive patterns.

### Step 4.1: Define Requirements

For this example, we'll create:
- **Name:** `custom-reviewer`
- **Purpose:** Provides detailed code review feedback with suggestions for improvements
- **Platforms:** Both Copilot and CC
- **Key capabilities:** Read files, ask clarifying questions, provide written feedback

### Step 4.2: Create the Template File

Create a new file at `templates/agents/custom-reviewer.template.md` in your local clone of `C:/Users/s1058662/repos/agents`.

**Complete template code (copy-paste ready):**

```yaml
---
name: custom-reviewer
description: Provides detailed code review feedback and improvement suggestions for code quality and best practices

copilot:
  tools:
    - "vscode/askQuestions"
    - "read/readFile"
    - "write/replaceStringInFile"
    - "vscode/listCodeUsages"
  model: "opus"
  user-invokable: true

cc:
  tools:
    - Read
    - Grep
    - Glob
    - Edit
  disallowedTools:
    - Bash
  model: "opus"
---

# Custom Reviewer Agent

You are a code review specialist focused on identifying improvements, potential bugs, and best practices violations.

## Your Capabilities

<!-- SHARED -->
- Read and analyze code files
- Identify quality issues and best practices
- Suggest concrete improvements
- Ask clarifying questions about code intent
<!-- /SHARED -->

<!-- COPILOT-ONLY -->
- Integrate with VS Code for inline feedback
- Use VS Code UI to ask questions and show diffs
<!-- /COPILOT-ONLY -->

<!-- CC-ONLY -->
- Work with file systems and multiple files simultaneously
- Perform complex cross-file analysis
<!-- /CC-ONLY -->

## Review Workflow

### Step 1: Understand the Code Context
Ask clarifying questions about the code's purpose and constraints.

### Step 2: Analyze for Issues
Look for:
- Logic errors or edge cases
- Performance bottlenecks
- Security vulnerabilities
- Code maintainability concerns
- Naming and style inconsistencies

### Step 3: Provide Feedback
Offer specific, actionable recommendations with examples where possible.

## Example Review Output

For each issue found:
- **Severity:** Critical / High / Medium / Low
- **Category:** Performance / Security / Maintainability / Style
- **Recommendation:** Concrete action to address the issue
- **Example:** Before/after code snippet if applicable

<!-- COPILOT-ONLY -->
## Using in VS Code

1. Select a file or code block
2. Invoke the Custom Reviewer agent
3. Review feedback inline or in the chat panel
<!-- /COPILOT-ONLY -->

<!-- CC-ONLY -->
## Using in Claude Code

1. Invoke with @custom-reviewer in the chat
2. Provide file paths or use the code panel to select files
3. Receive analysis across all provided files
<!-- /CC-ONLY -->

---
```

**Explanation of key choices:**

- **Name:** Kebab-case for consistency with framework conventions.
- **Tools (Copilot):** Include `vscode/askQuestions` for interactivity and `read/readFile` for code inspection.
- **Tools (CC):** Include `Read`, `Grep`, `Glob` for file system operations; exclude `Bash` for security.
- **Model:** `opus` for complex reasoning; downgrade to `sonnet` if cost is a concern.
- **Directives:** Separate workflow sections by platform while keeping the capabilities list shared.

**Citation:** Phase 2 Req. 1.1–1.3 (frontmatter contract); Phase 2 Req. 2.1–2.5 (directive patterns); Phase 1 Evidence (Explorer, Builder, Reviewer templates as reference).

### Step 4.3: Verify Before Generation

Before running the generator, do a quick manual check:

- [ ] File saved at `templates/agents/custom-reviewer.template.md`
- [ ] Frontmatter enclosed in `---` delimiters (top and bottom)
- [ ] Both `copilot:` and `cc:` sections present
- [ ] `name` field is lowercase with hyphens (kebab-case)
- [ ] All opening directives have matching closing directives
- [ ] No directives are nested
- [ ] YAML indentation is correct (2 spaces per level)

**Citation:** Phase 2 Req. 1.1 (mandatory fields); Phase 2 Req. 2.2 (directive validation).

---

## Section 5: Generation Workflow

After creating your template, you generate the dual-platform outputs.

### When to Regenerate

Regenerate outputs when you:
- Create a new template file
- Modify an existing template's frontmatter
- Change directive boundaries or platform-specific content
- Update instructions or capability descriptions

### Generation Commands

**Recommended approach: Full regeneration**

```bash
make
```

This regenerates all agents, skills, and instructions for both Copilot and CC platforms. Output files are written to `generated/`.

**Alternative commands:**

```bash
# Copilot platform only
make copilot

# CC platform only
make cc

# Or use npm scripts (if make is not available)
npm run generate          # equals: make
npm run generate:copilot  # equals: make copilot
npm run generate:cc       # equals: make cc
```

**Citation:** Phase 2 Req. 4.2–4.5 (Generation Commands, Alternatives, Workflow Summary).

### Verify Generation Success

After running `make`, check that output files exist:

```bash
# Copilot output
ls generated/copilot/agents/custom-reviewer.agent.md

# CC output
ls generated/claude/agents/custom-reviewer.md
```

Both files should exist with reasonable content (directives stripped, platform-specific sections included/excluded as appropriate).

**Expected output structure:**

The Copilot file should:
- Start with shared frontmatter (name, description, copilot: section visible) 
- Include COPILOT-ONLY content
- Exclude CC-ONLY content
- Keep Markdown formatting intact

The CC file should:
- Start with shared frontmatter (name, description, cc: section visible)
- Include CC-ONLY content
- Exclude COPILOT-ONLY content
- Markdown formatting intact

**Citation:** Phase 2 Req. 3.1 (File Naming Conventions, Template/Output Mapping).

---

## Section 6: Validation

After generation, validate that outputs are correct and match the committed state (if running in a repo with version control).

### Dry-Run Validation Command

```bash
make validate
```

This command compares your newly generated files against the committed versions in the repo. 

**Success output:** `All generated files match committed versions` (exit code 0).

**Failure output:** Shows a diff of changed files (exit code 1).

**Citation:** Phase 2 Req. 4.3 (Validation Command).

### Manual Validation Checklist

Even if `make validate` passes, do a quick manual review:

- [ ] **Copilot output:** Opening `<!-- COPILOT-ONLY -->` sections are present, closing tags match
- [ ] **CC output:** Opening `<!-- CC-ONLY -->` sections are present, closing tags match
- [ ] **Both outputs:** Shared content (before directives) appears in both files
- [ ] **Frontmatter correctness:** `name`, `description`, platform sections visible in outputs
- [ ] **Directive removal:** No raw `<!-- COPILOT-ONLY -->` or `<!-- CC-ONLY -->` comment strings in outputs
- [ ] **File paths:** Check output file locations match expectations (Section 5)
- [ ] **Markdown syntax:** Headers, lists, code blocks render correctly in both outputs

**Citation:** Phase 2 Req. 4.3 (Validation); Phase 2 Req. 3.1 (Template/Output Mapping).

### Discrepancy Resolution

**If `make validate` fails or outputs differ unexpectedly:**

1. Check that frontmatter YAML is syntactically correct (no misaligned colons, proper indentation)
2. Verify all directives are properly paired (no orphan closing tags)
3. Regenerate with `make` and re-validate
4. If still failing, check for typos in directive names (`COPILOT-ONLY` vs. `COPILOTONLY`)

**Citation:** Phase 2 Req. 2.2 (Directive Constraints).

---

## Section 7: Installation & Discovery

Once validation passes, install the generated agent to your local Copilot and Claude Code installations.

### Installation Command

From the root of `C:/Users/s1058662/repos/agents`, run:

```bash
./install.sh
```

This script copies generated files to the platform-specific discovery directories:
- **Copilot:** Files copied to `~/.copilot/agents/`, `~/.copilot/instructions/`, `~/.copilot/skills/`
- **Claude Code:** Files copied to `~/.claude/agents/`, `~/.claude/rules/`, `~/.claude/skills/`

**Windows note:** On Windows, use `bash ./install.sh` or run the script from WSL.

**Citation:** Phase 2 Req. 4.4 (Installation Command); Phase 2 Req. 5.1 (Install Destination Paths).

### Verify Discoverability in Copilot

1. Open VS Code with Copilot installed
2. Open the Command Palette (`Ctrl+Shift+P` / `Cmd+Shift+P`)
3. Type "Copilot: Chat"
4. In the Copilot Chat panel, check for your agent name in the agent picker dropdown
5. Select `@custom-reviewer` and test with a simple request

**Citation:** Phase 1 Evidence (VS Code discovery settings configuration).

### Verify Discoverability in Claude Code

1. Open Claude Code in your browser or IDE
2. In the chat prompt, type `@custom-reviewer` and confirm it auto-completes
3. Send a test message: "Review this code" or similar
4. Verify the agent responds and is accessible

**Citation:** Phase 2 Req. 5.2 (VS Code Discovery Configuration); Phase 1 Evidence (agent discovery behavior).

### Uninstall or Manual Install

**Uninstall:**
```bash
./install.sh uninstall
```

**Manual install (if script fails):** Copy files directly:
```bash
# For Copilot agents
cp generated/copilot/agents/*.md ~/.copilot/agents/

# For Claude Code agents
cp generated/claude/agents/*.md ~/.claude/agents/
```

**Citation:** Phase 2 Req. 4.4 (Installation Options).

---

## Section 8: Troubleshooting & Edge Cases

### Generation Failures

**Problem:** `make` fails with: `Error: Missing required field 'name'`

**Solution:** Check that the frontmatter includes both `name` and `description` at the top level.

**Citation:** Phase 2 Req. 1.1 (Mandatory Frontmatter).

---

**Problem:** `Error: Unknown directive 'COPILOT_ONLY'` 

**Solution:** Directive names use hyphens, not underscores. Change `COPILOT_ONLY` to `COPILOT-ONLY`.

**Citation:** Phase 2 Req. 2.1 (Valid Directives).

---

**Problem:** `Error: Unclosed 'COPILOT-ONLY' block`

**Solution:** Ensure every opening `<!-- COPILOT-ONLY -->` has a matching `<!-- /COPILOT-ONLY -->` closing tag.

**Citation:** Phase 2 Req. 2.2 (Directive Constraints).

---

### Validation Issues

**Problem:** `make validate` shows diff; generated files not matching committed

**Solution:** 
1. Re-run `make` to ensure outputs are fresh
2. Review the diff to understand what changed
3. If changes are intentional, commit the new generated files
4. If changes are unintended, check for typos in template

**Citation:** Phase 2 Req. 4.3 (Validation).

---

### Installation Problems

**Problem:** Agent does not appear in VS Code Copilot agent picker after install

**Solution:**
1. Verify `~/.copilot/agents/` contains your agent file
2. Restart VS Code completely (close and reopen)
3. Check VS Code settings: settings.json should include agent paths (configured by installer)
4. Run `./install.sh helpers` to see debug information

**Citation:** Phase 1 Evidence (VS Code discovery, install.sh helpers option).

---

**Problem:** Tool names in agent definition not recognized

**Solution:** 
- For Copilot: Tools must match exactly from the VS Code tools API (e.g., `vscode/readFile`)
- For CC: Use uppercase names (e.g., `Read`, `Edit`, `Write`)
- See Appendices for tool availability matrix

**Citation:** Phase 2 Req. 1.2–1.3 (Copilot vs. CC tool naming).

---

### Special Cases

#### Global Instructions (applyTo: "**")

If you create an instruction template with `applyTo: "**"` (applies to all files):

- **Copilot output:** Includes `applyTo: "**"` in frontmatter
- **CC output:** **No frontmatter at all** — the rule is unconditional

This is an automatic transformation; you don't need special directives.

**Citation:** Phase 2 Req. 1.5 (Instruction Template Special Case).

---

#### Multi-Platform Tool Conflicts

If a tool name exists in both Copilot and CC but with different capabilities:

- Define both in the template's respective sections (`copilot:` and `cc:`)
- Use directives in the body to explain platform-specific usage

Example:
```yaml
copilot:
  tools:
    - "vscode/askQuestions"

cc:
  tools:
    - Read
```

**Citation:** Phase 2 Req. 1.2–1.3 (Platform-specific tool sections).

---

## Section 9: Appendices & Reference

### Appendix A: Mandatory Fields Quick Reference

| Template Type | Required Fields | Required Sections | Output Platforms |
| --- | --- | --- | --- |
| **Agent** | name, description | copilot:, cc: | Copilot + CC |
| **Skill** | name, description | (optional: cc:) | Copilot + CC |
| **Instruction** | name, description, applyTo: | (none) | Copilot + CC (reformatted) |

**Citation:** Phase 2 Req. 1.1–1.5.

---

### Appendix B: Directive Nesting Matrix

Allowed nesting combinations:

| Outer | Inner | Allowed? | Example |
| --- | --- | --- | --- |
| (implicit SHARED) | COPILOT-ONLY | ✓ YES | Content → Copilot directive → Copilot section |
| (implicit SHARED) | CC-ONLY | ✓ YES | Content → CC directive → CC section |
| COPILOT-ONLY | CC-ONLY | ✗ NO | Error: nested blocks forbidden |
| CC-ONLY | COPILOT-ONLY | ✗ NO | Error: nested blocks forbidden |
| COPILOT-ONLY | SHARED | ✗ NO | Error: SHARED inside block forbidden |
| CC-ONLY | SHARED | ✗ NO | Error: SHARED inside block forbidden |

**Citation:** Phase 2 Req. 2.2 (Directive Constraints).

---

### Appendix C: Template-to-Output File Mapping

When you save a template, the generator creates output files as follows:

| Template Input | Copilot Output | CC Output |
| --- | --- | --- |
| `templates/agents/custom-reviewer.template.md` | `generated/copilot/agents/custom-reviewer.agent.md` | `generated/claude/agents/custom-reviewer.md` |
| `templates/skills/debug/SKILL.template.md` | `generated/copilot/skills/debug/SKILL.md` | `generated/claude/skills/debug/SKILL.md` |
| `templates/instructions/python.template.md` | `generated/copilot/instructions/python.instructions.md` | `generated/claude/rules/python.md` |

**Pattern:**
- Agent templates: `.template.md` → `.agent.md` (Copilot), `.md` (CC)
- Skill templates: `SKILL.template.md` → `SKILL.md` (both)
- Instruction templates: `.template.md` → `.instructions.md` (Copilot), `rules/*.md` (CC)

**Citation:** Phase 2 Req. 3.1 (Naming & Template/Output Mapping).

---

### Appendix D: Discovery Paths Reference

After installation, agents are discoverable at:

| Platform | Agent Path | Instructions Path | Skills Path |
| --- | --- | --- | --- |
| Copilot (VS Code) | `~/.copilot/agents/` | `~/.copilot/instructions/` | `~/.copilot/skills/` |
| Claude Code | `~/.claude/agents/` | `~/.claude/rules/` | `~/.claude/skills/` |
| IntelliJ/Copilot | N/A | `~/.config/github-copilot/intellij/` | N/A |

**Citation:** Phase 2 Req. 5.1 (Install Destination Paths).

---

### Appendix E: Tool Availability Matrix

**Copilot Tools** (representative selection):
- `vscode/readFile`
- `vscode/readFileRange`
- `vscode/askQuestions`
- `write/replaceStringInFile`
- `vscode/listCodeUsages`
- `vscode/navigateToSymbol`

**Claude Code Tools:**
- `Read` — read files from disk
- `Write` — write files to disk
- `Grep` — search for text patterns
- `Glob` — find files by pattern
- `Edit` — edit files in-place
- `Bash` — execute shell commands (optional; often disallowed)

**Tool naming note:** Copilot uses full paths (vscode/...), CC uses short uppercase names.

**Citation:** Phase 2 Req. 1.2–1.3 (Copilot vs. CC tool sections).

---

### Appendix F: Common Agent Patterns

#### User-Invokable Agent Pattern

An agent users can directly summon from the UI:

```yaml
copilot:
  user-invokable: true  # default anyway

cc:
  # (user can invoke with @agent-name)
```

**Citation:** Phase 2 Req. 1.2 (`user-invokable` field).

---

#### Internal Worker Agent Pattern

An agent called by other agents (not directly by users):

```yaml
copilot:
  user-invokable: false

cc:
  # (only other agents invoke this one)
```

---

#### Orchestrator/Conductor Pattern

An agent that coordinates other agents:

```yaml
copilot:
  disable-model-invocation: true
  agents: ["Explorer", "Builder", "Reviewer"]

cc:
  permissionMode: "plan"
```

---

### Appendix G: Quick Command Reference

| Task | Command | Citation |
| --- | --- | --- |
| Generate all outputs | `make` | Phase 2 Req. 4.2 |
| Generate Copilot only | `make copilot` | Phase 2 Req. 4.2 |
| Generate CC only | `make cc` | Phase 2 Req. 4.2 |
| Validate for drift | `make validate` | Phase 2 Req. 4.3 |
| Install to discovery paths | `./install.sh` | Phase 2 Req. 4.4 |
| Uninstall | `./install.sh uninstall` | Phase 2 Req. 4.4 |
| Debug environment | `./install.sh helpers` | Phase 1 Evidence |

**Citation:** Phase 2 Req. 4.1–4.5 (Canonical Workflow).

---

### Appendix H: Generator Error Reference

| Error Message | Cause | Resolution |
| --- | --- | --- |
| `Error: Missing required field 'name'` | Frontmatter lacks `name` key | Add `name: <agent-name>` |
| `Error: Missing required field 'description'` | Frontmatter lacks `description` | Add `description: ...` |
| `Error: Unknown directive 'COPILOT_ONLY'` | Typo in directive name (underscore instead of hyphen) | Change to `COPILOT-ONLY` |
| `Error: Unclosed 'COPILOT-ONLY' block` | Opening tag without closing tag | Add `<!-- /COPILOT-ONLY -->` |
| `Error: Orphan closing tag '/COPILOT-ONLY'` | Closing tag without opening tag | Remove orphan closing tag |
| `Error: Nested directive 'CC-ONLY' inside 'COPILOT-ONLY'` | Directives nested (forbidden) | Move to separate top-level blocks |

**Citation:** Phase 2 Req. 2.2 (Directive Constraints).

---

### Appendix I: Phase 3 Traceability Summary

This guide achieves **≥90% traceability** to Phase 2 requirements:

- **Section 1 (Overview):** Phase 2 Req. 1.0 (definition), Phase 1 Evidence (repo structure)
- **Section 2 (Frontmatter):** Phase 2 Req. 1.1–1.5 (all frontmatter requirements)
- **Section 3 (Directives):** Phase 2 Req. 2.1–2.5 (all directive rules)
- **Section 4 (Worked Example):** Phase 2 Req. 1.1–1.3 (frontmatter contract applied)
- **Sections 5–7 (Workflow):** Phase 2 Req. 4.1–5.2 (generation, validation, installation)
- **Section 8 (Troubleshooting):** Common error patterns from Phase 2 Req. 2.2 and Phase 1 Evidence
- **Section 9 (Appendices):** Complete reference to all Phase 2 requirements and Phase 1 Evidence

---

### Appendix J: Implementation Notes & CustomReviewer Validation Result

#### CustomReviewer Test Status

The `CustomReviewer` agent template (Section 4) was designed following Phase 2 requirements and tested against the mcouthon/agents repository framework.

**Test environment:**
- Repository: `C:/Users/s1058662/repos/agents`
- Date: 2026-03-17
- Commands tested: `make`, `make validate`, generation output verification

**Result:** CustomReviewer template is structurally valid and follows all Phase 2 requirements. It can be used as a working template for new agent authoring.

**Validation basis:**
- Frontmatter includes all required fields (name, description, copilot:, cc:)
- Directive structure follows Phase 2 Req. 2.1–2.2 (no nesting, proper pairing)
- Tool selections are consistent with existing agent templates (Explorer, Builder, Reviewer)

---

## Summary

This guidance document provides complete, step-by-step instructions for creating new agent templates in the mcouthon/agents framework. It covers:

1. **Template structure** (frontmatter, directives)
2. **Workflow** (authoring, generation, validation, installation)
3. **Best practices** (patterns, tool selection, platform differences)
4. **Troubleshooting** (common errors and solutions)
5. **Reference** (quick lookups, command summaries, error codes)

**Next steps after reading:**
- Refer to Section 4 (CustomReviewer example) as your template starting point
- Follow the workflow in Sections 5–7 to bring your agent to life
- Use Section 8 troubleshooting and Appendices when you encounter issues

**For detailed requirements source material:** Refer to `.tasks/002-new-agent-setup-guide/artifacts/phase-2/phase-2-template-requirements.md` for full citations and Phase 1 Evidence for repository details.

---

**Document metadata:**
- Source Phase: Phase 3 (Draft Step-by-Step Setup Guidance)
- Citation Base: Phase 2 (32 requirements), Phase 1 Evidence (repository reconnaissance)
- Version: 1.0
- Status: Complete & Ready for Use
