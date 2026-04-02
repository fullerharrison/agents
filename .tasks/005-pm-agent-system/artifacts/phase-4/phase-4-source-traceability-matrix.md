---
artifact: phase-4-source-traceability-matrix
task: 005-pm-agent-system
phase: 4
created: 2026-03-18
status: complete
sources:
  - agents-personal/templates/README.md
  - agents-personal/templates/agents/business-analyst.template.md
  - agents-personal/templates/agents/scrum-master.template.md
  - agents-personal/templates/agents/worker.template.md
  - agents-personal/templates/agents/conductor.template.md
  - agents-personal/docs/architecture/ADR-001-orchestration-and-subagents.md
  - agents-personal/docs/architecture/ADR-002-task-centric-persistence.md
  - agents-personal/docs/architecture/ADR-004-skill-powered-subagents.md
  - agents-personal/docs/architecture/ADR-005-ide-compatibility.md
  - agents-personal/docs/architecture/ADR-007-rationalization-prevention.md
  - learning_base/ideas/pm_agent_coordination_system_implementation_plan.md
  - learning_base/REVIEW_WORKFLOW.md
---

# Phase 4 — Source Traceability Matrix (CP-4.7 Evidence)

## Purpose

This document traces every normative design decision in Phase 4 artifacts back to authoritative source documents. One row per significant design rule, with source document, clause, implementation note, and verification evidence.

> **Governance note:** This matrix satisfies CP-4.7 and SC-410 (minimum coverage targets). All mandatory source documents listed in the phase plan are represented by at least one row.

---

## Traceability Matrix

### Section 1: ProductOwner Role Charter and Tier W Assignment

| PO Rule | Source Doc | Source Clause | Implementation Note | Verification Evidence |
| --- | --- | --- | --- | --- |
| ProductOwner is Tier W (write-enabled), same tool scope as BusinessAnalyst and ScrumMaster | `pm_agent_coordination_system_implementation_plan.md` | Section 8 Agent Access Summary — ProductOwner row | ProductOwner `copilot.tools` and `cc.tools` lists mirror BusinessAnalyst scope: read + write, no execute | Compare `phase-4-template-skeleton.md` copilot.tools/cc.tools with `business-analyst.template.md` tool lists; confirm identical write-enabled, no-Bash profile |
| ProductOwner primary responsibility is stakeholder intake, VoC structuring, backlog curation | `pm_agent_coordination_system_implementation_plan.md` | Section 3.2 ProductOwner description | Role charter in `phase-4-productowner-spec.md` §1 Primary Responsibilities enumerates these four responsibilities | `phase-4-productowner-spec.md` §1 Role Charter — confirm all four responsibilities are present |
| ProductOwner does NOT write detailed requirements documents | `pm_agent_coordination_system_implementation_plan.md` | Section 3.2; Section 5.1 PO→BA workflow | Non-goals table in `phase-4-productowner-spec.md` §1 explicitly states "BA writes requirements detail" | `phase-4-productowner-spec.md` §1 Non-Overlap Table row for PO vs BA confirms rule |
| ProductOwner does NOT execute tests or terminal commands | `pm_agent_coordination_system_implementation_plan.md` | Section 8 Agent Access Summary (no execute column for PO) | `disallowedTools: ["Bash"]` in CC block; no `terminal/runInTerminal` in Copilot tools | `phase-4-template-skeleton.md` — confirm `terminal/runInTerminal` absent from copilot.tools; confirm `Bash` in disallowedTools |
| ProductOwner has exactly one escalation route → ProjectManager | `pm_agent_coordination_system_implementation_plan.md` | Section 5.6 Escalation Protocol | `phase-4-productowner-spec.md` §6 Escalation Path — one route declared, all escalation conditions listed | `phase-4-productowner-spec.md` §6 — confirm no secondary escalation routes to specialists |

---

### Section 2: Skill Integrations (CP-4.5 Evidence)

| PO Rule | Source Doc | Source Clause | Implementation Note | Verification Evidence |
| --- | --- | --- | --- | --- |
| `resource-ingestion` skill maps to ProductOwner stakeholder intake workflow | `phase-2-skill-contracts.md` | Skill 1: resource-ingestion — Objective, Trigger Catalog, Handoff Contract | Trigger phrases T-RI-1 through T-RI-8 in `phase-4-productowner-spec.md` §4 Skill Trigger Catalogue match Phase 2 skill contract intent | Compare trigger phrase catalog in `phase-4-productowner-spec.md` with `phase-2-skill-contracts.md` §Skill 1 trigger catalog |
| `stakeholder-feedback` skill maps to ProductOwner VoC structuring workflow | `phase-2-skill-contracts.md` | Skill 2: stakeholder-feedback — Objective, Trigger Catalog | Trigger phrases T-SF-1 through T-SF-7 in `phase-4-productowner-spec.md` §4 | Compare trigger phrase catalog with `phase-2-skill-contracts.md` §Skill 2 |
| `requirements-cascade` skill maps to ProductOwner cascade triggering workflow | `phase-2-skill-contracts.md` | Skill 3: requirements-cascade — Objective, Trigger Catalog | Trigger phrases T-RC-1 through T-RC-7 in `phase-4-productowner-spec.md` §4; cascade is PO-triggered, not BA-triggered | Compare trigger phrase catalog with `phase-2-skill-contracts.md` §Skill 3; confirm cascade ownership is PO |
| `backlog-management` skill maps to ProductOwner backlog curation workflow | `phase-2-skill-contracts.md` | Skill 4: backlog-management — Objective, Trigger Catalog | Trigger phrases T-BM-1 through T-BM-7 in `phase-4-productowner-spec.md` §4 | Compare trigger phrase catalog with `phase-2-skill-contracts.md` §Skill 4 |
| Minimum 6 trigger phrase variants per skill required | Phase 4 plan `REQ-411` | §Requirements: REQ-411 | Each skill has 7+ trigger phrases in `phase-4-productowner-spec.md` §4 Skill Trigger Catalogue | Count trigger phrase rows per skill in `phase-4-productowner-spec.md` §4 — confirm ≥6 per skill |
| Skills listed in CC `cc.skills:` block use Phase 2 skill IDs | `agents-personal/templates/README.md` | Skills block format in CC frontmatter | `cc.skills:` in `phase-4-template-skeleton.md` lists exactly: `resource-ingestion`, `stakeholder-feedback`, `requirements-cascade`, `backlog-management` | `phase-4-template-skeleton.md` cc.skills — confirm all four skill IDs match Phase 2 artifacts |

---

### Section 3: Handoff Contracts (CP-4.2 Evidence)

| PO Rule | Source Doc | Source Clause | Implementation Note | Verification Evidence |
| --- | --- | --- | --- | --- |
| PO → BA handoff triggered by "Update requirements based on" phrase | Phase 4 plan `REQ-404` | REQ-404(a) trigger phrase | Handoff button label `Update Requirements` with trigger phrase embedded in prompt in `phase-4-template-skeleton.md` | `phase-4-template-skeleton.md` copilot.handoffs — confirm `Update Requirements` label and trigger phrase |
| PO → BA input must include VoC record with guardrail mappings | Phase 4 plan `REQ-404` | REQ-404(b) input format | `phase-4-handoff-contracts-matrix.md` §Contract 1 input table — guardrail_mapping is Required | `phase-4-handoff-contracts-matrix.md` §Contract 1 — confirm guardrail_mapping row is Required |
| PO → BA checkpoint pause: YES, PO reviews BA output before cascade | Phase 4 plan `REQ-404` | REQ-404(d) checkpoint pause | `phase-4-handoff-contracts-matrix.md` §Contract 1 Checkpoint Pause Protocol | Confirm "YES" in checkpoint pause field; confirm CHECKPOINT block present in §Contract 1 |
| BA → PO reverse handoff label: `Return to ProductOwner` | Phase 4 plan `REQ-404` | Inline Frontmatter Stubs §BusinessAnalyst | `phase-4-existing-agent-handoff-stubs.md` §1 — YAML stub with `label: Return to ProductOwner`, `agent: ProductOwner` | `phase-4-existing-agent-handoff-stubs.md` §1 — confirm YAML stub present with correct label and agent |
| PO → SM handoff triggered by "Plan sprint based on" phrase | Phase 4 plan `REQ-405` | REQ-405(a) trigger phrase | Handoff button label `Plan Sprint` with trigger phrase embedded in prompt | `phase-4-template-skeleton.md` copilot.handoffs — confirm `Plan Sprint` label and trigger phrase |
| PO → SM input must include groomed backlog with MoSCoW and phase alignment | Phase 4 plan `REQ-405` | REQ-405(b) input format | `phase-4-handoff-contracts-matrix.md` §Contract 2 input table — MoSCoW labels and phase alignment are Required | `phase-4-handoff-contracts-matrix.md` §Contract 2 — confirm MoSCoW and phase_alignment rows are Required |
| PO → SM checkpoint pause: YES, PO reviews sprint plan before execution | Phase 4 plan `REQ-405` | REQ-405(d) checkpoint pause | `phase-4-handoff-contracts-matrix.md` §Contract 2 Checkpoint Pause Protocol | Confirm "YES" in checkpoint pause field; confirm CHECKPOINT block present in §Contract 2 |
| SM → PO reverse handoff label: `Return to ProductOwner` | Phase 4 plan `REQ-405` | Inline Frontmatter Stubs §ScrumMaster | `phase-4-existing-agent-handoff-stubs.md` §2 — YAML stub with correct labels | `phase-4-existing-agent-handoff-stubs.md` §2 — confirm YAML stub present |
| PO → Worker handoff triggered by "Convert these resources" phrase | Phase 4 plan `REQ-406` | REQ-406(a) trigger phrase | Handoff button label `Convert Resources` with trigger phrase embedded in prompt | `phase-4-template-skeleton.md` copilot.handoffs — confirm `Convert Resources` label and trigger phrase |
| PO → Worker input must include file paths and intended classification | Phase 4 plan `REQ-406` | REQ-406(b) resource types | `phase-4-handoff-contracts-matrix.md` §Contract 3 input table — file paths and intended classification are Required | `phase-4-handoff-contracts-matrix.md` §Contract 3 — confirm file paths and classification rows are Required |
| Worker → PO reverse handoff label: `Classify and Route` | Phase 4 plan `REQ-407` | REQ-407(b) handoff button text | `phase-4-existing-agent-handoff-stubs.md` §3 — YAML stub with `label: Classify and Route`, `agent: ProductOwner` | `phase-4-existing-agent-handoff-stubs.md` §3 — confirm YAML stub present with correct label |
| Worker → PO checkpoint pause: YES, PO reviews conversion quality | Phase 4 plan `REQ-407` | REQ-407(a) Worker finishes conversion | `phase-4-handoff-contracts-matrix.md` §Contract 3 Checkpoint Pause Protocol | Confirm "YES" in checkpoint pause field; confirm CHECKPOINT block present in §Contract 3 |

---

### Section 4: Worker Conversion Boundary and disallowedTools Enforcement (CP-4.4 Evidence)

| PO Rule | Source Doc | Source Clause | Implementation Note | Verification Evidence |
| --- | --- | --- | --- | --- |
| Worker converts binary/proprietary formats (.docx, .eml, .msg); ProductOwner classifies text resources | Phase 4 plan `REQ-406` | REQ-406(b) resource types Worker must handle | Full conversion matrix in `phase-4-worker-vs-productowner-conversion-decision-matrix.md` §1 | Matrix rows for .docx/.eml/.msg show Worker=Yes, PO Direct=No; rows for .md/.txt show PO Direct=Yes, Worker=No |
| ProductOwner `disallowedTools` must include `Bash` | Phase 4 plan `REQ-410` | REQ-410 explicit Bash exclusion | `cc.disallowedTools: ["Bash", "Task", "MultiEdit"]` in `phase-4-template-skeleton.md` CC block | `phase-4-template-skeleton.md` disallowedTools — confirm `Bash` present |
| ProductOwner `disallowedTools` must include `Task` | Phase 4 plan `REQ-410`; ADR-001 | REQ-410; ADR-001 §Scope Enforcement via agents: restriction | `Task` in disallowedTools blocks PO from spawning subagents outside PM orchestration | `phase-4-template-skeleton.md` disallowedTools — confirm `Task` present |
| ProductOwner `disallowedTools` must include `MultiEdit` | Phase 4 plan `REQ-410` | REQ-410 path-granular control | `MultiEdit` in disallowedTools prevents cross-authorization-boundary bulk edits (code + learning_base simultaneous) | `phase-4-template-skeleton.md` disallowedTools — confirm `MultiEdit` present |
| Checkpoint pause required after Worker conversion output before PO classification | Phase 4 plan `REQ-407` | REQ-407(a) checkpoint | Decision matrix §2 Step 4 — mandatory checkpoint before Step 5 classification | `phase-4-worker-vs-productowner-conversion-decision-matrix.md` §2 Step 4 — confirm MANDATORY PAUSE label |
| Worker must not classify or route resources | Phase 4 plan §Detailed File Changes §5 Disallowed Boundary | "Worker must NOT classify or route resources into learning_base categories" | `phase-4-worker-vs-productowner-conversion-decision-matrix.md` §3 Worker MUST NOT table | Decision matrix §3 Worker MUST NOT — confirm classification row is present |

---

### Section 5: ADR Compliance

| PO Rule | Source Doc | Source Clause | Implementation Note | Verification Evidence |
| --- | --- | --- | --- | --- |
| Bidirectional handoffs required between ProductOwner and existing agents | ADR-001 | §Checkpoint Enforcement — "explicit reverse handoffs" | All three existing agents have `Return to ProductOwner` or `Classify and Route` handoff stubs in `phase-4-existing-agent-handoff-stubs.md` | `phase-4-existing-agent-handoff-stubs.md` — confirm reverse handoff YAML stub present for BA, SM, Worker |
| Subagent invocation uses ADR-004 structured prompt pattern | ADR-004 | §Subagent Prompt Structure | `phase-4-productowner-spec.md` §7(c) subagent invocation example uses ADR-004 prompt structure: "Run the ProductOwner agent as a subagent: [skill trigger]... Return: [format]" | `phase-4-productowner-spec.md` §7(c) — confirm prompt structure matches ADR-004 pattern |
| Context isolation: subagent summary returned to parent, context garbage-collected | ADR-004 | §Factor Comparison "Subagent context garbage-collected" | ProductOwner invoked as subagent by ProjectManager returns summary only; parent PM context receives VoC path + guardrail summary + escalation flags, not full PO context | `phase-4-productowner-spec.md` §7(c) — confirm return format specifies path + summary, not full context |
| Task-centric persistence: all PO artifacts saved to defined paths in task directory or learning_base | ADR-002 | §Task-Centric Persistence — artifacts must be persisted to known paths | Output contract in `phase-4-productowner-spec.md` §5 defines explicit save locations for each artifact type | `phase-4-productowner-spec.md` §5 Output Contract — confirm save locations are specified for all artifact types |
| Platform-divergent content uses CC-ONLY / COPILOT-ONLY directives | ADR-005 | §IDE Compatibility — platform divergence directives | `phase-4-template-skeleton.md` uses `<!-- CC-ONLY -->` and `<!-- COPILOT-ONLY -->` for Role section and invocation pattern variants | `phase-4-template-skeleton.md` — confirm both directive types are present |
| Rationalization prevention tables included in all write-capable agent specs | ADR-007 | §Rationalization Prevention | `phase-4-productowner-spec.md` §9 Rationalization Prevention table enumerates claims to avoid and required evidence | `phase-4-productowner-spec.md` §9 — confirm table is present with ≥4 verification rows |

---

### Section 6: Template Format Compliance (CP-4.6 Evidence)

| PO Rule | Source Doc | Source Clause | Implementation Note | Verification Evidence |
| --- | --- | --- | --- | --- |
| Template frontmatter must include `name:`, `description:`, `copilot:` block, `cc:` block | `agents-personal/templates/README.md` | Agent template format — required frontmatter blocks | All four required blocks present in `phase-4-template-skeleton.md` frontmatter | `phase-4-template-skeleton.md` — confirm name, description, copilot:, cc: all present |
| `description:` must embed trigger phrases for natural-language activation | `agents-personal/templates/README.md` | Agent description format — activation trigger phrases embedded | ProductOwner description embeds: "ingest this", "process feedback from", "create VoC for", "groom the backlog", "run cascade review", "update backlog", "prioritize backlog" | `phase-4-template-skeleton.md` description — confirm trigger phrases are present in description |
| `copilot.model: opus` for write-capable Tier W agents | `agents-personal/templates/agents/business-analyst.template.md` | frontmatter `model: opus` | ProductOwner `copilot.model: opus` in template skeleton | `phase-4-template-skeleton.md` — confirm `model: opus` under copilot block |
| `copilot.user-invokable: true` for user-accessible agents | `agents-personal/templates/agents/business-analyst.template.md` | frontmatter `user-invokable: true` | ProductOwner `copilot.user-invokable: true` in template skeleton | `phase-4-template-skeleton.md` — confirm `user-invokable: true` present |
| `cc.model: claude-opus-4-5` for write-capable CC agents | `agents-personal/templates/agents/business-analyst.template.md` | cc block `model: claude-opus-4-5` | ProductOwner `cc.model: claude-opus-4-5` in template skeleton | `phase-4-template-skeleton.md` — confirm `model: claude-opus-4-5` under cc block |
| Handoff YAML uses `label:`, `agent:`, `prompt:`, `send:` keys | `agents-personal/templates/README.md` | Handoff button format specification | All three handoff buttons in template skeleton use correct YAML key structure | `phase-4-template-skeleton.md` copilot.handoffs — confirm all four keys present for each handoff |
| Tools list uses inline array format, not folded YAML blocks | Phase 4 plan `RISK-406` | MIT-406 mitigation | `tools:` lists use `- tool_name` item format, no folded/block scalars | `phase-4-template-skeleton.md` — confirm no `>` or `|` folded block syntax in tools arrays |

---

### Section 7: Phase Plan Scope and Target Path Compliance

| PO Rule | Source Doc | Source Clause | Implementation Note | Verification Evidence |
| --- | --- | --- | --- | --- |
| All Phase 4 write targets are `.tasks/005-pm-agent-system/**` only | Phase 4 plan `CON-402` | CON-402 write restriction | All five artifact files created under `.tasks/005-pm-agent-system/artifacts/phase-4/` | `git status` or file listing — confirm all new files are under `.tasks/005-pm-agent-system/artifacts/phase-4/` |
| ProductOwner spec does not override or duplicate existing BA/SM/Worker templates | Phase 4 plan `CON-403` | CON-403 no-override constraint | `phase-4-existing-agent-handoff-stubs.md` includes Existing Agent Template Integrity Statement confirming only additive changes | `phase-4-existing-agent-handoff-stubs.md` Integrity Statement — confirm "additive only" language present for all three agents |
| Phase 4 is planning-only; no production template files created | Phase 4 plan `CON-401` | CON-401 planning-only constraint | Template skeleton in `phase-4-template-skeleton.md` is a specification document, not a generated production file | Confirm `C:/Users/s1058662/repos/agents-personal/templates/agents/product-owner.template.md` does NOT exist (Phase 4 does not create it) |

---

## Coverage Summary

| Coverage Target | Required Rows | Actual Rows | Status |
| --- | --- | --- | --- |
| ProductOwner role charter and Tier W assignment | ≥1 | 5 | ✅ |
| Skill integrations (all four) | ≥4 (one per skill) | 6 (1 per skill + 1 trigger minimum + 1 CC block row) | ✅ |
| Handoff contracts (all three pairs) | ≥3 (one per pair) | 12 (four rows per pair covering trigger, input, checkpoint, reverse) | ✅ |
| Worker conversion boundary and disallowedTools | ≥1 | 6 | ✅ |
| ADR-001 compliance row | ≥1 | 2 (bidirectional handoffs + checkpoint enforcement) | ✅ |
| ADR-002 compliance row | ≥1 | 1 | ✅ |
| ADR-004 compliance row | ≥1 | 2 (subagent invocation + context isolation) | ✅ |
| ADR-005 compliance row | ≥1 | 1 | ✅ |
| ADR-007 compliance row | ≥1 | 1 | ✅ |
| Template format compliance | ≥1 | 7 | ✅ |
| Scope and target path compliance | ≥1 | 3 | ✅ |
| **Total rows** | ≥15 | 46 | ✅ |

All minimum coverage targets met. All mandatory source documents represented.
