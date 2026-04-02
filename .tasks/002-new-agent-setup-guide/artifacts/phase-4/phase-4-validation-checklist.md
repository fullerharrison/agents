---
date: 2026-03-17
status: Complete
scope: Agent templates only (`.template.md` files in `templates/agents/`)
phase: 4
back-link: ../phase-3/phase-3-setup-guidance.md
---

# Agent Setup Validation Checklist

**How to Use:** Work through sections A–F in order after completing your agent setup. Tick each checkbox when the criterion passes. If an item fails, follow the `Fix:` anchor to the relevant Phase 3 section — remediation instructions live there, not here. Use Section G to record the overall pass/fail status per section before signing off.

---

## Section A — Pre-Flight: Template File Checks

> Verify the `.template.md` source file is correctly named, located, and structured before running `make`.

- [ ] **A1 — File placement** · Fail: template file is not in `templates/agents/` · Fix: [§4 Hands-On: Create Your First Agent Template](../phase-3/phase-3-setup-guidance.md#section-4-hands-on-create-your-first-agent-template)
- [ ] **A2 — File name convention** · Fail: filename does not match `<slug>.template.md` (e.g. `my-agent.template.md`) · Fix: [§4 Hands-On: Create Your First Agent Template](../phase-3/phase-3-setup-guidance.md#section-4-hands-on-create-your-first-agent-template)
- [ ] **A3 — Frontmatter opens on line 1** · Fail: `---` is not the very first line of the file (blank lines precede it) · Fix: [§2 Agent Template Mandatory Frontmatter](../phase-3/phase-3-setup-guidance.md#section-2-agent-template-mandatory-frontmatter)
- [ ] **A4 — `name:` present and non-empty** · Fail: `name:` key is absent or has a blank/null value · Fix: [§2 Agent Template Mandatory Frontmatter](../phase-3/phase-3-setup-guidance.md#section-2-agent-template-mandatory-frontmatter)
- [ ] **A5 — `description:` present and non-empty** · Fail: `description:` key is absent or has a blank/null value · Fix: [§2 Agent Template Mandatory Frontmatter](../phase-3/phase-3-setup-guidance.md#section-2-agent-template-mandatory-frontmatter)
- [ ] **A6 — `copilot:` section present** · Fail: frontmatter contains no `copilot:` block (even an empty one is required) · Fix: [§2 Copilot Platform Section](../phase-3/phase-3-setup-guidance.md#section-2-agent-template-mandatory-frontmatter)
- [ ] **A7 — `cc:` section present** · Fail: frontmatter contains no `cc:` block · Fix: [§2 CC Platform Section](../phase-3/phase-3-setup-guidance.md#section-2-agent-template-mandatory-frontmatter)
- [ ] **A8 — At least one body content block present** · Fail: body is empty — no `<!-- COPILOT-ONLY -->`, `<!-- CC-ONLY -->`, `<!-- SHARED -->` directive, and no shared prose outside directives either · Fix: [§3 Body Directives Reference](../phase-3/phase-3-setup-guidance.md#section-3-body-directives-reference)

---

## Section B — Directive Validity Checks

> Verify that all body directive tags are syntactically correct and structurally valid.

- [ ] **B1 — COPILOT-ONLY tags paired** · Fail: one or more `<!-- COPILOT-ONLY -->` opening tags have no matching `<!-- /COPILOT-ONLY -->` closing tag (or vice-versa) · Fix: [§3 Body Directives Reference](../phase-3/phase-3-setup-guidance.md#section-3-body-directives-reference)
- [ ] **B2 — CC-ONLY tags paired** · Fail: one or more `<!-- CC-ONLY -->` opening tags have no matching `<!-- /CC-ONLY -->` closing tag (or vice-versa) · Fix: [§3 Body Directives Reference](../phase-3/phase-3-setup-guidance.md#section-3-body-directives-reference)
- [ ] **B3 — SHARED tags paired** · Fail: a `<!-- SHARED -->` opening tag exists without a matching `<!-- /SHARED -->` closing tag (or vice-versa) · Fix: [§3 Body Directives Reference](../phase-3/phase-3-setup-guidance.md#section-3-body-directives-reference)
- [ ] **B4 — Hyphen syntax (no underscores)** · Fail: template contains `COPILOT_ONLY` or `CC_ONLY` (underscore variants) — hyphens are required · Fix: [§3 Directive Constraints (Hard Rules)](../phase-3/phase-3-setup-guidance.md#section-3-body-directives-reference)
- [ ] **B5 — No nested directive blocks** · Fail: a directive block contains another directive opening tag before the parent's closing tag · Fix: [§3 Directive Constraints (Hard Rules)](../phase-3/phase-3-setup-guidance.md#section-3-body-directives-reference)
- [ ] **B6 — No raw directive tags in expected outputs** · Fail: generated files still contain literal `<!-- COPILOT-ONLY -->` or `<!-- CC-ONLY -->` strings — generator did not strip them · Fix: [§5 Generation Workflow](../phase-3/phase-3-setup-guidance.md#section-5-generation-workflow)

---

## Section C — Generation Output Checks

> Confirm `make` ran successfully and each output file contains exactly the right content.

- [ ] **C1 — Copilot output file exists** · Fail: `generated/copilot/agents/<name>.agent.md` is absent after running `make` · Fix: [§5 Generation Workflow](../phase-3/phase-3-setup-guidance.md#section-5-generation-workflow)
- [ ] **C2 — CC output file exists** · Fail: `generated/claude/agents/<name>.md` is absent after running `make` · Fix: [§5 Generation Workflow](../phase-3/phase-3-setup-guidance.md#section-5-generation-workflow)
- [ ] **C3 — Copilot output contains COPILOT-ONLY content** · Fail: content written inside `<!-- COPILOT-ONLY -->` blocks does not appear in the Copilot output · Fix: [§3 Body Directives Reference](../phase-3/phase-3-setup-guidance.md#section-3-body-directives-reference)
- [ ] **C4 — Copilot output excludes CC-ONLY content** · Fail: content written inside `<!-- CC-ONLY -->` blocks appears in the Copilot output · Fix: [§3 Body Directives Reference](../phase-3/phase-3-setup-guidance.md#section-3-body-directives-reference)
- [ ] **C5 — CC output contains CC-ONLY content** · Fail: content written inside `<!-- CC-ONLY -->` blocks does not appear in the CC output · Fix: [§3 Body Directives Reference](../phase-3/phase-3-setup-guidance.md#section-3-body-directives-reference)
- [ ] **C6 — CC output excludes COPILOT-ONLY content** · Fail: content written inside `<!-- COPILOT-ONLY -->` blocks appears in the CC output · Fix: [§3 Body Directives Reference](../phase-3/phase-3-setup-guidance.md#section-3-body-directives-reference)
- [ ] **C7 — Shared body content appears in both outputs** · Fail: prose written outside all directive blocks is absent from either the Copilot or CC output · Fix: [§3 Common Directive Patterns](../phase-3/phase-3-setup-guidance.md#section-3-body-directives-reference)
- [ ] **C8 — Raw directive tags absent from both outputs** · Fail: either generated file contains a literal `<!-- COPILOT-ONLY -->`, `<!-- /COPILOT-ONLY -->`, `<!-- CC-ONLY -->`, or `<!-- /CC-ONLY -->` string · Fix: [§5 Generation Workflow](../phase-3/phase-3-setup-guidance.md#section-5-generation-workflow)

---

## Section D — Automated Validation Gate

> Run the built-in `make validate` gate and confirm it reports a clean state.

- [ ] **D1 — `make validate` exits with code 0** · Fail: command exits with a non-zero code and prints diff output or an error message · Fix: [§6 Validation — Dry-Run Validation Command](../phase-3/phase-3-setup-guidance.md#section-6-validation)
- [ ] **D2 — Diff (if any) is intentional** · Fail: `make validate` reports differences that were not deliberately authored (regenerate with `make` to sync) · Fix: [§6 Validation](../phase-3/phase-3-setup-guidance.md#section-6-validation)
- [ ] **D3 — No uncommitted generated files** · Fail: `git status` shows untracked or modified files under `generated/` that have not been staged or committed · Fix: [§6 Validation](../phase-3/phase-3-setup-guidance.md#section-6-validation)

---

## Section E — Installation Checks

> Confirm `./install.sh` completed and deposited files in the correct locations.

- [ ] **E1 — Copilot agent file installed** · Fail: `~/.copilot/agents/<name>.agent.md` does not exist · Fix: [§7 Installation & Discovery](../phase-3/phase-3-setup-guidance.md#section-7-installation--discovery)
- [ ] **E2 — CC agent file installed** · Fail: `~/.claude/agents/<name>.md` does not exist · Fix: [§7 Installation & Discovery](../phase-3/phase-3-setup-guidance.md#section-7-installation--discovery)
- [ ] **E3 — No stale files from previous name** · Fail: an old `<previous-name>.agent.md` or `<previous-name>.md` still exists in the install directories after a rename · Fix: [§7 Installation & Discovery](../phase-3/phase-3-setup-guidance.md#section-7-installation--discovery)
- [ ] **E4 — Install script exited cleanly** · Fail: `./install.sh` printed an error or exited with a non-zero code · Fix: [§8 Troubleshooting & Edge Cases](../phase-3/phase-3-setup-guidance.md#section-8-troubleshooting--edge-cases)
- [ ] **E5 — Windows: correct shell used** · Fail: script was run via PowerShell or CMD instead of `bash ./install.sh` from WSL or Git Bash, causing path or permission errors · Fix: [§7 Installation & Discovery](../phase-3/phase-3-setup-guidance.md#section-7-installation--discovery)

---

## Section F — Discoverability Checks

> Confirm the agent is live and invokable. The detailed *how-to* steps for each check are in [§7 Installation & Discovery](../phase-3/phase-3-setup-guidance.md#section-7-installation--discovery) — this section records only pass/fail criteria.

- [ ] **F1 — Agent appears in Copilot agent picker** · Fail: agent name is absent from the VS Code Copilot agent picker dropdown after a VS Code window reload · Fix: [§7 Verify Discoverability in Copilot](../phase-3/phase-3-setup-guidance.md#section-7-installation--discovery)
- [ ] **F2 — `@<agent-name>` auto-completes in Copilot Chat** · Fail: typing `@` in Copilot Chat does not surface the agent name in the completion menu · Fix: [§7 Verify Discoverability in Copilot](../phase-3/phase-3-setup-guidance.md#section-7-installation--discovery)
- [ ] **F3 — Agent responds in Copilot Chat** · Fail: invoking `@<agent-name>` with a minimal test prompt (e.g. "Hello, confirm you are active") produces no response or an error · Fix: [§8 Troubleshooting & Edge Cases](../phase-3/phase-3-setup-guidance.md#section-8-troubleshooting--edge-cases)
- [ ] **F4 — `@<agent-name>` auto-completes in Claude Code** · Fail: typing `@` in the Claude Code chat input does not surface the agent name · Fix: [§7 Verify Discoverability in Claude Code](../phase-3/phase-3-setup-guidance.md#section-7-installation--discovery)
- [ ] **F5 — Agent responds in Claude Code** · Fail: invoking `@<agent-name>` with a minimal test prompt produces no response or an error · Fix: [§8 Troubleshooting & Edge Cases](../phase-3/phase-3-setup-guidance.md#section-8-troubleshooting--edge-cases)

---

## Section G — Summary Table

Complete this table once all sections are checked. Mark each row ✅ if all items in the section passed, or ❌ with a note if any item failed.

| Section | Area | Items | Pass? | Notes |
|---------|------|-------|-------|-------|
| A | Template File Checks | 8 | ☐ | |
| B | Directive Validity Checks | 6 | ☐ | |
| C | Generation Output Checks | 8 | ☐ | |
| D | Automated Validation Gate | 3 | ☐ | |
| E | Installation Checks | 5 | ☐ | |
| F | Discoverability Checks | 5 | ☐ | |
| **Total** | | **35** | | |

**Reviewer:** ___________________________  **Date:** _______________
