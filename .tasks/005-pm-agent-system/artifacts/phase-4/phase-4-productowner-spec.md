---
artifact: phase-4-productowner-spec
task: 005-pm-agent-system
phase: 4
created: 2026-03-18
status: complete
sources:
  - agents-personal/templates/agents/business-analyst.template.md
  - agents-personal/templates/agents/scrum-master.template.md
  - agents-personal/templates/agents/worker.template.md
  - agents-personal/templates/agents/conductor.template.md
  - agents-personal/templates/README.md
  - agents-personal/docs/architecture/ADR-001-orchestration-and-subagents.md
  - agents-personal/docs/architecture/ADR-002-task-centric-persistence.md
  - agents-personal/docs/architecture/ADR-004-skill-powered-subagents.md
  - agents-personal/docs/architecture/ADR-005-ide-compatibility.md
  - agents-personal/docs/architecture/ADR-007-rationalization-prevention.md
  - learning_base/ideas/pm_agent_coordination_system_implementation_plan.md
  - learning_base/REVIEW_WORKFLOW.md
---

# Phase 4 — ProductOwner Specification

## Purpose

This document defines the implementation-ready role charter, permission tier, skill integrations, output contract, and invocation patterns for the ProductOwner agent in the 2026_01_VIP PM agent system.

> **Governance note:** All normative design decisions trace to the mandatory agents-personal source set. See `phase-4-source-traceability-matrix.md` for per-row citations.

---

## 1. Role Charter (CP-4.1 Evidence)

ProductOwner is the primary voice of stakeholder intent in the 2026_01_VIP PM agent system. It serves as the gateway for external resources into the learning_base, curates the strategic backlog, structures Voice of Customer (VoC) inputs, and coordinates downstream handoffs to BusinessAnalyst and ScrumMaster for requirements refinement and sprint planning. ProductOwner acts as the strategic interface between stakeholders and the technical execution layer — it captures *what* stakeholders want and *why*, without descending into *how* to implement it.

### Primary Responsibilities

| Responsibility | Description |
| --- | --- |
| **Stakeholder intake triage** | Receive, classify, and route inbound resources (emails, meeting notes, documents, links, chat extracts) via the `resource-ingestion` skill. |
| **Voice of Customer (VoC) structuring** | Extract verbatim quotes, pain points, guardrail mappings, and feature requests from stakeholder communication via the `stakeholder-feedback` skill. |
| **Backlog curation and prioritization** | Maintain the groomed backlog with MoSCoW prioritization, phase alignment, and estimated effort via the `backlog-management` skill. |
| **Requirements cascade triggering** | Initiate cascade review after VoC changes or backlog shifts to identify impacted requirements and dependent documents via the `requirements-cascade` skill. |
| **Handoff coordination** | Delegate to BusinessAnalyst (requirements update), ScrumMaster (sprint planning), and Worker (binary format conversion) at well-defined checkpoints. |

### Explicit Non-Goals

ProductOwner does NOT:

- **Write detailed requirements documents** — that is BusinessAnalyst's responsibility (requirements criteria, acceptance conditions, architecture alignment).
- **Make architecture decisions** — no authority over technical design, API design, or infrastructure choices (→ BusinessAnalyst, BackendDev).
- **Execute tests or terminal commands** — no Bash, no `runInTerminal`; execution is Worker's domain.
- **Generate diagrams or visual artifacts** — that is UIUXDesigner's responsibility.
- **Convert binary file formats** — `.docx`, `.eml`, `.msg` conversion is Worker's domain (requires Bash/pandoc).
- **Break down sprint tasks into effort estimates** — final breakdown and dependency sequencing belongs to ScrumMaster.
- **Directly invoke specialist advisors** (FrontendDev, BackendDev, QAEngineer) — all cross-specialist coordination routes through ProjectManager.

### Non-Overlap Table (CP-4.1 Direct Evidence)

| Boundary | ProductOwner | Peer Agent | Rule |
| --- | --- | --- | --- |
| **PO vs BusinessAnalyst — requirements** | Writes VoC records, backlog items, and cascade change summaries (what stakeholders want) | Writes requirements specifications, acceptance criteria, architecture alignment (how to deliver it) | PO triggers BA; BA does not rework backlog priority |
| **PO vs ScrumMaster — planning** | Grooms strategic backlog: MoSCoW priority, phase alignment, rough effort opinion | Breaks down backlog into sprint tasks: story points, dependencies, acceptance criteria, task sequence | PO prioritizes; SM decomposes. Checkpoint pause between grooming and sprint planning enforces handoff |
| **PO vs Worker — resource processing** | Classifies and routes already-text/markdown resources; decides where resources belong | Converts binary/proprietary formats (`.docx`, `.eml`, `.msg`) to markdown using Bash/pandoc | PO handles strategy; Worker handles mechanics. PO never touches Bash |
| **PO vs UIUXDesigner — diagrams** | Provides feature intent and scope for diagrams | Generates and maintains Mermaid/draw.io artifacts | PO feeds requirements; UIUXDesigner executes diagram work |

---

## 2. Permission Tier: Tier W (Write-Enabled)

ProductOwner is assigned **Tier W** — identical tool scope to BusinessAnalyst and ScrumMaster per `pm_agent_coordination_system_implementation_plan.md` Section 8 Agent Access Summary.

**Source:** `business-analyst.template.md` (Tier W reference baseline); `pm_agent_coordination_system_implementation_plan.md` §8.

### Copilot Tool Scope

| Category | Included Tools | Excluded Tools |
| --- | --- | --- |
| **Read** | `read/readFile` | — |
| **Search** | `search/semanticSearch`, `search/textSearch`, `workspace/fileSearch`, `search/webSearch` | — |
| **Write** | `workspace/createDirectory`, `workspace/createFile`, `edit/editFile` | — |
| **Interaction** | `vscode/askQuestions` | — |
| **Execute** | *(none)* | `terminal/runInTerminal` — Worker handles binary conversion with Bash |

### CC Tool Scope

| Category | Included Tools | Excluded Tools |
| --- | --- | --- |
| **Read** | `Read`, `LS`, `Glob`, `Grep`, `WebSearch` | — |
| **Write** | `Write`, `Edit` | `MultiEdit` — path-agnostic bulk edits blocked (PO scope: `learning_base/` and `docs/ways-of-work/` only) |
| **Task tracking** | `TodoRead`, `TodoWrite` | — |
| **Execute** | *(none)* | `Bash` — Worker handles conversion; `Task` — PM orchestrates subagent spawning |

### CC `disallowedTools` Rationale

| Disallowed Tool | Boundary Reason |
| --- | --- |
| `Bash` | Prevents direct PowerShell/terminal execution. Worker owns `.docx`/`.eml` format conversion via pandoc/email parsers. Machine-enforced per REQ-410. |
| `Task` | Prevents subagent spawning outside PM orchestration. All external agent coordination routes through ProjectManager, not ProductOwner. Machine-enforced per REQ-410. |
| `MultiEdit` | Prevents cross-authorization-boundary bulk edits. Simultaneous edits across `code/` + `learning_base/` are disallowed. PO scope is `learning_base/` and `docs/ways-of-work/` only. |

### Permission Scope Write Boundaries

ProductOwner may write ONLY to:
- `learning_base/11_voice_of_customer/` — VoC records
- `learning_base/_inbox/` — intake staging (classification pending)
- `docs/ways-of-work/backlog.md` — backlog artifact
- `.tasks/005-pm-agent-system/` — cascade review summaries and task notes

ProductOwner must NOT write to:
- `code/` — no code, no configs, no test files
- `specs/` — no architecture specs (→ BusinessAnalyst)
- `diagrams/` or `images/diagrams/` — no diagram files (→ UIUXDesigner)
- `learning_base/02_requirements/` — no requirements documents (→ BusinessAnalyst)

---

## 3. Skill Integration Summary (CP-4.5 Evidence)

ProductOwner integrates exactly four Phase 2 skills:

| Skill ID | Objective | ProductOwner Workflow Step | Trigger Condition | Escalation |
| --- | --- | --- | --- | --- |
| `resource-ingestion` | Normalize and classify inbound resources into structured summaries for `learning_base/` | Step 1: Receive inbound resource → classify type → apply template → route to category folder | Inbound binary resource detected → delegate to Worker first; inbound text/markdown → PO processes directly | Worker conversion failure → PO escalates to ProjectManager |
| `stakeholder-feedback` | Extract VoC records with verbatim quotes, guardrail mappings, and actionable insights | Step 2: After resource classification → extract structured VoC → map to guardrails → produce VoC record | After stakeholder meeting notes or email ingestion is complete | Ambiguous stakeholder intent → PO pauses and asks clarifying question before VoC creation |
| `requirements-cascade` | Trigger cascade check identifying impacted requirements and downstream docs after VoC or backlog changes | Step 3: After VoC creation or backlog priority change → run cascade → identify impacted docs → delegate requirements update to BA | After VoC record is created; after backlog strategic priority shift | Cascade identifies unknown dependency → PO escalates to ProjectManager |
| `backlog-management` | Maintain groomed backlog with MoSCoW prioritization and phase alignment | Step 4: Groom backlog → MoSCoW → phase align → delegate to SM for sprint breakdown | User request to update/groom backlog; after requirements cascade completes | Conflicting priorities from multiple stakeholders → PO escalates to ProjectManager |

**Skill execution sequence note:** Skills are invoked in the order above for a complete intake-to-planning workflow; however, individual skills can be invoked independently when only a subset of the workflow is needed (e.g., backlog grooming without new VoC input).

---

## 4. Skill Trigger Catalogue (REQ-411)

### `resource-ingestion`

| # | Trigger Phrase | Use Case |
| --- | --- | --- |
| T-RI-1 | "ingest this document" | User provides a file path or attachment for classification |
| T-RI-2 | "add this to the learning_base" | User wants a resource placed into the knowledge repository |
| T-RI-3 | "process this stakeholder feedback" | User provides an email or message for resource processing |
| T-RI-4 | "classify and route this resource" | Action-oriented trigger for routing after type detection |
| T-RI-5 | "drop this in the inbox" | Informal trigger for staging before classification |
| T-RI-6 | "log this meeting output" | After a meeting, user wants minutes ingested |
| T-RI-7 | "store this chat extract" | User pastes chat content for knowledge-base addition |
| T-RI-8 | "process this email" | Explicit email ingestion request |

### `stakeholder-feedback`

| # | Trigger Phrase | Use Case |
| --- | --- | --- |
| T-SF-1 | "process feedback from [name/role]" | Named stakeholder feedback available for VoC creation |
| T-SF-2 | "create VoC for [stakeholder]" | Explicit VoC record request with stakeholder identification |
| T-SF-3 | "extract insights from this input" | Semi-structured input that needs VoC normalization |
| T-SF-4 | "summarize stakeholder input" | Multiple inputs to be consolidated into one VoC record |
| T-SF-5 | "map this feedback to guardrails" | User wants explicit guardrail traceability in VoC output |
| T-SF-6 | "build VoC record" | Direct VoC artifact creation request |
| T-SF-7 | "normalize stakeholder pain points" | When raw notes need VoC structure applied |

### `requirements-cascade`

| # | Trigger Phrase | Use Case |
| --- | --- | --- |
| T-RC-1 | "run cascade review" | Explicit cascade check after VoC or backlog change |
| T-RC-2 | "check what's impacted" | Informal trigger for impact analysis |
| T-RC-3 | "verify requirements alignment" | After a VoC record changes known requirements |
| T-RC-4 | "update dependent docs" | User wants downstream docs flagged for update |
| T-RC-5 | "check cascade after this change" | Change-specific cascade trigger |
| T-RC-6 | "find all impacted specifications" | Broader impact analysis across specs and docs |
| T-RC-7 | "trace requirements impact" | Traceability-oriented cascade trigger |

### `backlog-management`

| # | Trigger Phrase | Use Case |
| --- | --- | --- |
| T-BM-1 | "groom the backlog" | Standard backlog grooming session |
| T-BM-2 | "prioritize backlog" | MoSCoW re-prioritization after new inputs |
| T-BM-3 | "update sprint backlog" | Backlog update before sprint planning begins |
| T-BM-4 | "estimate effort for [item]" | Rough effort sizing for backlog items |
| T-BM-5 | "phase-align items" | Align backlog items to correct phase roadmap |
| T-BM-6 | "add new backlog item" | New item creation with immediate prioritization |
| T-BM-7 | "re-rank backlog after VoC" | Post-VoC grooming trigger for updated priorities |

---

## 5. Output Contract

| Artifact Type | Save Location | Naming Convention | Required Metadata Keys |
| --- | --- | --- | --- |
| VoC record | `learning_base/11_voice_of_customer/` | `voc_NNN_[stakeholder]_[date].md` | `author`, `date`, `stakeholder`, `related_feature`, `guardrail_mapping`, `tags` |
| Resource ingestion summary | `learning_base/_inbox/` | `inbox_NNN_[source]_[date].md` | `source_file`, `source_type`, `ingested_date`, `classification`, `tags` |
| Backlog update | `docs/ways-of-work/backlog.md` | Single canonical file (append/update) | `last_updated`, `moscow_label`, `phase_alignment`, `effort_estimate` |
| Cascade change summary | `.tasks/005-pm-agent-system/cascade-review-*.md` | `cascade-review-[YYYY-MM-DD]-[slug].md` | `triggered_by`, `impacted_docs`, `action_required`, `owner`, `resolution_status` |

**Artifact integrity requirement:** Every PO-produced artifact must include a `related_feature` or `triggered_by` link to ensure requirements traceability back to source stakeholder input (provenance-as-file-record per ADR-002).

---

## 6. Escalation Path

ProductOwner has **exactly one escalation route: → ProjectManager**.

| Escalation Condition | Required PO Action |
| --- | --- |
| Stakeholder deadlock (conflicting priorities from multiple stakeholders) | Pause workflow; escalate to ProjectManager with summary of conflicting signals and recommended resolution options |
| Resource constraint (backlog exceeds available capacity for planned phase) | Flag to ProjectManager with capacity gap analysis and deferral candidates |
| Cross-team conflict (requirements impact affects another team's workstream) | Escalate to ProjectManager for cross-team coordination before proceeding |
| Ambiguous conversion output (Worker returns garbled or truncated markdown) | Review output; if unrecoverable, escalate to ProjectManager for stakeholder contact or skip decision |
| VoC creates scope expansion risk | Flag to ProjectManager before triggering cascade review; scope expansion requires explicit approval |

ProductOwner MUST NOT:
- Escalate directly to specialists (FrontendDev, BackendDev, QAEngineer) — all external coordination routes through PM.
- Resolve cross-team conflicts without PM involvement.
- Approve scope expansion unilaterally.

---

## 7. Invocation Patterns

### (a) Direct User Invocation (Copilot)

```
@ProductOwner process feedback from the field agronomist — extract insights and create VoC record
```

```
@ProductOwner groom the backlog and phase-align items for Q2 sprint planning
```

```
@ProductOwner ingest this stakeholder email and classify it into the learning_base
```

### (b) Direct User Invocation (CC)

```
use ProductOwner to process stakeholder feedback from the trial manager meeting and create a VoC record
```

```
use ProductOwner to run cascade review after today's guardrail update
```

### (c) Subagent Invocation by ProjectManager (ADR-004 pattern)

```
Run the ProductOwner agent as a subagent: process stakeholder feedback and create a VoC record.
The stakeholder is [name], the input is at [path]. Extract verbatim quotes, map to guardrails,
and identify feature requests. Create VoC record at learning_base/11_voice_of_customer/.
Return: VoC record path, guardrail mapping summary, and any escalation flags.
```

### (d) Disallowed Invocation Contexts

- ProductOwner MUST NOT be invoked by FrontendDev, BackendDev, QAEngineer, or UIUXDesigner (no peer-to-peer invocation — all cross-specialist coordination routes through ProjectManager).
- ProductOwner MUST NOT be asked to execute terminal commands, run scripts, or convert binary files directly.
- ProductOwner MUST NOT write to `code/`, `specs/`, `diagrams/`, or `learning_base/02_requirements/` paths.

---

## 8. Canonical Invocation Examples

### Resource Ingestion (resource-ingestion skill)

**Copilot example:**
```
Allowed caller: User (direct) or ProjectManager (subagent delegation)
Disallowed caller: QAEngineer, UIUXDesigner (peer-to-peer disallowed)
@ProductOwner ingest this document: [file path]
Expected output: Classified resource in learning_base/_inbox/ with metadata header
Checkpoint pause: After Worker conversion (if binary) → PO reviews quality → PO classifies and routes
```

**CC example:**
```
Allowed caller: User (direct) or ProjectManager (via Task delegation)
use ProductOwner to ingest this stakeholder email: [email content or path]
Expected output: Ingestion summary at learning_base/_inbox/inbox_NNN_[source]_[date].md
Checkpoint pause: PO reviews classification before routing to final learning_base category
```

### VoC Processing (stakeholder-feedback skill)

**Copilot example:**
```
Allowed caller: User (direct) or ProjectManager
@ProductOwner process feedback from [stakeholder name] — map to guardrails and create VoC record
Expected output: VoC record at learning_base/11_voice_of_customer/voc_NNN_*.md
Checkpoint pause: PO confirms VoC accuracy with user before triggering cascade review
```

**CC example:**
```
use ProductOwner to create VoC for the [stakeholder] — extract pain points, map guardrails, identify feature requests
Expected output: Structured VoC record with verbatim quotes, guardrail mapping, and prioritized feature requests
Checkpoint pause: Human review of VoC record before cascade is triggered
```

### Backlog Grooming (backlog-management skill)

**Copilot example:**
```
Allowed caller: User (direct) or ProjectManager
@ProductOwner groom the backlog — apply MoSCoW, align to Phase 2, add effort estimates
Expected output: Updated backlog.md with sorted priority, MoSCoW labels, and phase assignments
Checkpoint pause: PO review before handing to ScrumMaster for sprint planning
```

**CC example:**
```
use ProductOwner to prioritize backlog after today's stakeholder feedback
Expected output: Groomed backlog with MoSCoW labels, phase alignment, and rationale for priority changes
Checkpoint pause: Human approval before SM creates sprint plan from groomed backlog
```

### Requirements Cascade (requirements-cascade skill)

**Copilot example:**
```
Allowed caller: User (direct) or ProjectManager
@ProductOwner run cascade review after the VoC update
Expected output: Cascade review summary at .tasks/005-pm-agent-system/cascade-review-[date].md
Checkpoint pause: PO reviews impacted documents list before delegating requirements updates to BA
```

---

## 9. Domain Language Reference

| Term | Definition |
| --- | --- |
| **Trial** | A controlled agricultural experiment with defined plots, treatments, and measurement protocols |
| **Plot** | The smallest spatial unit within a Trial; receives a single treatment combination |
| **Germplasm** | Genetic material (seed variety, accession, cultivar) assigned to a Trial plot |
| **Phenotypic Trait** | A measurable plant characteristic (e.g., yield, height, disease resistance) recorded per plot |
| **Guardrail** | A non-negotiable constraint on product behavior or data handling, derived from regulatory, safety, or business requirements |
| **Voice of Customer (VoC)** | Structured representation of stakeholder-expressed needs, pain points, and feature requests with verbatim evidence |
| **MoSCoW** | Priority classification framework: Must Have, Should Have, Could Have, Won't Have |
| **Cascade** | The process of identifying and updating downstream dependent documents after a source document changes |
| **Backlog Item** | A unit of planned work with stakeholder value, priority, effort estimate, and phase alignment |
| **Sprint** | A time-boxed delivery cycle (typically 2 weeks) with committed backlog items and acceptance criteria |
| **Ingestion** | The process of normalizing, classifying, and placing inbound resources into the learning_base |
| **Phase Alignment** | Assignment of a backlog item to the roadmap phase (Phase 1–4) where it will be delivered |

---

## Rationalization Prevention

The following verification table is included per ADR-007 to prevent post-hoc rationalization during Builder execution:

| Claim to Avoid | Verification Required |
| --- | --- |
| "ProductOwner tool scope is correct" | Read `pm_agent_coordination_system_implementation_plan.md` §8 and compare tool lists; cite mismatch if found |
| "All four skills are correctly mapped" | Confirm phase-2-skill-contracts.md lists `resource-ingestion`, `stakeholder-feedback`, `requirements-cascade`, `backlog-management` and that PO trigger phrases are consistent |
| "Tier W is the correct assignment" | Confirm `business-analyst.template.md` and `scrum-master.template.md` both use identical read/write/no-execute scopes; verify `pm_agent_coordination_system_implementation_plan.md` §8 row for ProductOwner |
| "disallowedTools are correctly set" | Confirm `Bash`, `Task`, `MultiEdit` are in disallowed list and that reasons are traceable to REQ-410 and ADR-001 boundary rules |
| "Handoff contracts are complete" | Check phase-4-handoff-contracts-matrix.md: each of the three pairs has trigger phrase, input format, output format, and checkpoint pause |
