---
artifact: phase-2-skill-contracts
task: 005-pm-agent-system
phase: 2
created: 2026-03-18
status: complete
sources:
  - agents-personal/README.md
  - agents-personal/templates/README.md
  - agents-personal/docs/architecture/ADR-001-orchestration-and-subagents.md
  - agents-personal/docs/architecture/ADR-002-task-centric-persistence.md
  - agents-personal/docs/architecture/ADR-004-skill-powered-subagents.md
  - agents-personal/docs/architecture/ADR-005-ide-compatibility.md
  - agents-personal/docs/architecture/ADR-007-rationalization-prevention.md
  - agents-personal/docs/synthesis/skills.md
  - phase-1-reuse-map.md
  - phase-1-interface-map.md
  - phase-1-orchestration-skill-invocation-guidelines.md
---

# Phase 2 Skill Contracts

## Purpose

This document defines the five skill contracts required for the 2026_01_VIP PM agent system. Each contract specifies the skill's objective, trigger phrases, input schema, output schema, and handoff contract. These contracts are planning-only specifications; no production template files are created here.

> **Governance note:** All rules in this document trace to the mandatory agents-personal source set. See `phase-2-source-traceability-matrix.md` for per-row citations.

---

## Common Contract Schema

Every skill contract in this document uses the following schema fields:

| Field | Description |
|-------|-------------|
| **Skill ID** | Unique identifier used in agent frontmatter `cc.skills` |
| **Objective** | Single-sentence primary purpose |
| **Non-Goals** | Explicitly out-of-scope behaviors for this skill |
| **Trigger Catalog** | Minimum 5 phrase variants that activate the skill |
| **Trigger Exclusions** | Phrases that look similar but should NOT activate this skill |
| **Input Schema** | Required and optional input fields with accepted sources |
| **Output Schema** | Artifact paths, naming conventions, required metadata keys |
| **Checkpoint Touchpoints** | Where skill execution must pause for approval |
| **Invocation Patterns** | How the skill is invoked (direct vs. subagent) |
| **Handoff Contract** | Upstream callers, downstream consumers, escalation path |
| **Failure / Escalation Conditions** | When skill output is invalid and what happens next |

---

## Skill 1: resource-ingestion

### Objective

Normalize and classify inbound resources (emails, documents, links, raw notes, chat extracts) into structured ingestion summaries with source attribution for placement into `learning_base/`.

### Non-Goals

- Does NOT process stakeholder feedback into structured VoC records (→ `stakeholder-feedback`)
- Does NOT update requirements documents or trigger cascade logic (→ `requirements-cascade`)
- Does NOT generate sprint or backlog artifacts (→ `backlog-management`)
- Does NOT produce diagram specifications (→ `diagram-generation`)
- Does NOT apply semantic analysis beyond classification and normalization

### Trigger Catalog

| # | Trigger Phrase |
|---|----------------|
| T1.1 | "ingest this document" |
| T1.2 | "ingest this email" |
| T1.3 | "ingest this link" |
| T1.4 | "process this resource" |
| T1.5 | "add this to the knowledge base" |
| T1.6 | "store this chat extract" |
| T1.7 | "classify and save this material" |
| T1.8 | "log this reference document" |
| T1.9 | "record this meeting output" |

### Trigger Exclusions

| Phrase | Route Instead To |
|--------|-----------------|
| "process stakeholder feedback" | `stakeholder-feedback` |
| "update the backlog" | `backlog-management` |
| "update the requirements" | `requirements-cascade` |
| "generate a diagram" | `diagram-generation` |

### Input Schema

| Field | Required? | Accepted Sources |
|-------|-----------|-----------------|
| `resource_content` | Required | Email text, document body, URL, raw notes, chat transcript |
| `resource_type` | Required | `email` \| `document` \| `link` \| `notes` \| `chat` \| `meeting_output` |
| `source_attribution` | Required | Author, sender, original URL, or "unknown" if unavailable |
| `date_received` | Required | ISO 8601 date or "unknown" |
| `domain_context` | Optional | One of: `requirements`, `decisions`, `technical`, `stakeholder`, `operations` |
| `target_subdirectory` | Optional | Override for `learning_base/` placement; defaults to classification output |

**Classification rules (when `target_subdirectory` is not provided):**

| Resource Type | Default Target Path |
|--------------|-------------------|
| `email` / `chat` / `meeting_output` | `learning_base/10_meeting_notes/` |
| `document` with `domain_context: requirements` | `learning_base/02_requirements/` |
| `document` with `domain_context: technical` | `learning_base/05_technical_specs/` |
| `document` with `domain_context: decisions` | `learning_base/09_decisions/` |
| `link` | `learning_base/01_project_overview/` |
| `notes` | `learning_base/01_project_overview/` |

### Output Schema

| Field | Type | Required? | Notes |
|-------|------|-----------|-------|
| `artifact_path` | string | Required | Full relative path; e.g., `learning_base/10_meeting_notes/ingestion_{YYYYMMDD}_{slug}.md` |
| `source_attribution` | string | Required | Original source preserved verbatim |
| `ingestion_date` | string | Required | ISO 8601 date |
| `resource_type` | string | Required | Preserved from input |
| `classification_rationale` | string | Required | Why this subdirectory was selected |
| `summary` | string | Required | ≤150 words structured summary of the resource |
| `key_themes` | list | Required | 3–7 domain terms extracted from content |
| `action_flags` | list | Optional | `requires_review`, `potential_requirement`, `decision_signal`, `stakeholder_input` |

**Naming convention:** `{resource_type}_{YYYYMMDD}_{slug}.md` where `slug` is 2–4 hyphenated words from the resource title or subject.

**Example:**
```
learning_base/10_meeting_notes/meeting_output_20260318_sprint-kickoff-notes.md
```

### Checkpoint Touchpoints

| Checkpoint | Condition | Action |
|------------|-----------|--------|
| CP-RI-1 | Classification target differs from user-indicated location | Present classification rationale and proposed path; await approval before writing |
| CP-RI-2 | `action_flags` includes `potential_requirement` or `decision_signal` | Surface flag to ProductOwner before finalizing ingestion summary |
| CP-RI-3 | Duplicate detected (file with same slug already exists) | Pause and present both existing and incoming artifact for merge or overwrite decision |

### Invocation Patterns

**Direct (user prompt):**
User addresses ProductOwner with trigger phrase. Skill auto-activates from trigger keywords in `description`.

**Via subagent (agent-to-agent):**
```markdown
Run the Worker agent as a subagent: Use resource-ingestion mode to normalize this document.
Content: [resource content or file path]
Resource type: [email|document|link|notes|chat]
Source: [attribution string]
Return: Ingestion summary with artifact path and action_flags.
```

**Disallowed invocation contexts:**
- ProjectManager MUST NOT invoke this skill directly (PM is read-only, delegates to ProductOwner)
- FrontendDev and BackendDev cannot invoke this skill (advisory roles only)
- QAEngineer cannot invoke this skill (test-execution scope only)

### Handoff Contract

| Direction | Agent | Condition |
|-----------|-------|-----------|
| **Upstream callers** | ProductOwner | Primary invoker for stakeholder and resource intake |
| **Upstream callers** | BusinessAnalyst | Secondary invoker for research document ingestion |
| **Downstream consumers** | ProductOwner | Reads ingestion output to assess `action_flags` |
| **Downstream consumers** | `stakeholder-feedback` skill | Triggered when `action_flags: stakeholder_input` is set |
| **Downstream consumers** | `requirements-cascade` skill | Triggered when `action_flags: potential_requirement` is set |
| **Escalation path** | ProjectManager (read-only) | Receives checkpoint summary; issues routing decision |

### Failure / Escalation Conditions

| Condition | Action |
|-----------|--------|
| Source attribution is `unknown` and resource content is ambiguous | Pause with CP-RI-2; do not write artifact without ProductOwner confirmation |
| Resource cannot be classified into any known subdirectory | Default to `learning_base/01_project_overview/`; set `action_flags: requires_review` |
| Target file already exists | Trigger CP-RI-3; do not overwrite silently |
| Resource content is empty or unintelligible | Return error summary; do not produce an ingestion artifact |

---

## Skill 2: stakeholder-feedback

### Objective

Process stakeholder comments, meeting notes, and issue records into structured Voice of Customer (VoC) records and prioritized requirement signals for ProductOwner backlog grooming.

### Non-Goals

- Does NOT ingest raw resources or classify documents (→ `resource-ingestion`)
- Does NOT update requirements documents or produce cascade plans (→ `requirements-cascade`)
- Does NOT manage the sprint backlog directly (→ `backlog-management`)
- Does NOT produce diagrams (→ `diagram-generation`)
- Does NOT make priority decisions autonomously — it surfaces signals for human decision

### Trigger Catalog

| # | Trigger Phrase |
|---|----------------|
| T2.1 | "process stakeholder feedback" |
| T2.2 | "structure this voice of customer" |
| T2.3 | "capture stakeholder input" |
| T2.4 | "analyze this feedback" |
| T2.5 | "record stakeholder concerns" |
| T2.6 | "extract requirement signals from this feedback" |
| T2.7 | "create a VoC record" |
| T2.8 | "prioritize stakeholder issues" |
| T2.9 | "triage feedback into requirements" |

### Trigger Exclusions

| Phrase | Route Instead To |
|--------|-----------------|
| "ingest this email" | `resource-ingestion` |
| "update the backlog" | `backlog-management` |
| "cascade the requirements" | `requirements-cascade` |

### Input Schema

| Field | Required? | Accepted Sources |
|-------|-----------|-----------------|
| `feedback_content` | Required | Stakeholder comment text, meeting notes, email thread, issue record |
| `stakeholder_id` | Required | Name, role, or anonymized identifier |
| `feedback_date` | Required | ISO 8601 date |
| `feedback_channel` | Required | `meeting` \| `email` \| `chat` \| `issue_tracker` \| `survey` \| `direct` |
| `project_context` | Optional | Relevant phase, epic, or feature reference |
| `related_requirements` | Optional | Existing requirement IDs from `learning_base/02_requirements/` |

### Output Schema

| Field | Type | Required? | Notes |
|-------|------|-----------|-------|
| `artifact_path` | string | Required | `learning_base/11_voice_of_customer/voc_{NNN}_{slug}.md` |
| `voc_id` | string | Required | Sequential: `voc_NNN` (next available number) |
| `stakeholder_id` | string | Required | Preserved from input |
| `feedback_date` | string | Required | ISO 8601 |
| `feedback_channel` | string | Required | Preserved from input |
| `summary` | string | Required | ≤200 words structured summary |
| `pain_points` | list | Required | Each pain point with severity: `high` \| `medium` \| `low` |
| `requirement_signals` | list | Required | Candidate requirements with source quote, signal type (`functional`\|`non_functional`\|`constraint`) |
| `moscow_suggestion` | string | Optional | `must` \| `should` \| `could` \| `wont` — suggested, not binding |
| `escalation_flag` | boolean | Optional | `true` if stakeholder signal is urgent or safety-critical |

**Naming convention:** `voc_{NNN}_{stakeholder-slug-or-topic}.md`

**Existing VoC examples in 2026_01_VIP:**
- `learning_base/11_voice_of_customer/voc_001_video_processor_zakaria.md`
- `learning_base/11_voice_of_customer/voc_002_video_collector_ling.md`

Next VoC artifact must continue the sequence from the highest existing `NNN`.

### Checkpoint Touchpoints

| Checkpoint | Condition | Action |
|------------|-----------|--------|
| CP-SF-1 | `escalation_flag: true` | Immediately surface to ProductOwner before writing VoC artifact |
| CP-SF-2 | `requirement_signals` list is non-empty | Pause for ProductOwner review before routing to `requirements-cascade` |
| CP-SF-3 | `moscow_suggestion: must` for a new requirement | Pause for ProductOwner confirmation before flagging to backlog |

### Invocation Patterns

**Direct (user prompt):**
User addresses ProductOwner with trigger phrase. Skill auto-activates.

**Via subagent (agent-to-agent):**
```markdown
Run the Worker agent as a subagent: Use stakeholder-feedback mode to process this input.
Stakeholder: [name/role]
Channel: [meeting|email|chat|issue_tracker]
Content: [feedback text]
Return: VoC record summary with requirement_signals and escalation_flag.
```

**Disallowed invocation contexts:**
- ProjectManager MUST NOT invoke directly (routes through ProductOwner)
- Technical advisor roles (FrontendDev, BackendDev) cannot invoke
- QAEngineer cannot invoke (quality scope, not stakeholder scope)

### Handoff Contract

| Direction | Agent | Condition |
|-----------|-------|-----------|
| **Upstream callers** | ProductOwner | Primary invoker for all stakeholder feedback processing |
| **Upstream callers** | BusinessAnalyst | May invoke when reviewing stakeholder-sourced documents |
| **Downstream consumers** | ProductOwner | Reviews VoC output and assigns backlog priorities |
| **Downstream consumers** | `backlog-management` skill | Triggered when `requirement_signals` must be ranked |
| **Downstream consumers** | `requirements-cascade` skill | Triggered when requirement signals impact existing docs |
| **Escalation path** | ProjectManager (read-only) | Receives escalation summary if `escalation_flag: true`; decides routing |

### Failure / Escalation Conditions

| Condition | Action |
|-----------|--------|
| Stakeholder ID cannot be determined | Set to `unknown`; set `escalation_flag: false`; surface for ProductOwner review |
| No extractable requirement signals | Write VoC with empty `requirement_signals`; add `action_note: no signals detected` |
| `escalation_flag: true` | Do NOT write artifact autonomously; trigger CP-SF-1 first |
| Conflicting signals from same stakeholder | Include both; mark as `conflict: true`; surface at CP-SF-2 |

---

## Skill 3: requirements-cascade

### Objective

Given a changed requirement and an impacted-document registry, produce an ordered update plan by dependency sequence — without applying edits. The plan is handed to Worker/Builder execution queues and review obligations.

### Non-Goals

- Does NOT apply document edits autonomously (plan-only mode; edits delegated to Worker/Builder)
- Does NOT create new requirements from stakeholder feedback (→ `stakeholder-feedback`)
- Does NOT manage backlog priorities (→ `backlog-management`)
- Does NOT generate diagrams (→ `diagram-generation`)
- Does NOT ingest resources (→ `resource-ingestion`)
- Does NOT determine whether a requirement is valid — that is the human reviewer's decision

### Trigger Catalog

| # | Trigger Phrase |
|---|----------------|
| T3.1 | "cascade this requirement change" |
| T3.2 | "propagate this update across documents" |
| T3.3 | "which documents need updating after this change" |
| T3.4 | "requirement cascade" |
| T3.5 | "impact analysis for requirement change" |
| T3.6 | "update propagation plan" |
| T3.7 | "map downstream impacts of this requirement" |
| T3.8 | "trace dependencies for this specification change" |
| T3.9 | "what needs to change when this requirement changes" |

### Trigger Exclusions

| Phrase | Route Instead To |
|--------|-----------------|
| "ingest this requirement document" | `resource-ingestion` |
| "prioritize requirements in backlog" | `backlog-management` |
| "generate diagram for architecture change" | `diagram-generation` |

### Input Schema

| Field | Required? | Accepted Sources |
|-------|-----------|-----------------|
| `changed_requirement` | Required | Requirement ID + text of the change |
| `change_type` | Required | `add` \| `modify` \| `remove` \| `deprecate` |
| `impacted_document_registry` | Required | List of file paths known or suspected to reference the changed requirement |
| `change_context` | Optional | Business rationale or stakeholder reference |
| `priority` | Optional | `urgent` \| `normal` \| `deferred` (default: `normal`) |
| `reviewer_override` | Optional | Named agent or human to receive review obligation |

**Impacted Document Registry defaults (when not provided):**
Scan the following locations for references to the changed requirement ID:
- `docs/` (all `.md` files)
- `specs/` (all `.md` files)
- `learning_base/02_requirements/`
- `learning_base/05_technical_specs/`

### Output Schema

| Field | Type | Required? | Notes |
|-------|------|-----------|-------|
| `artifact_path` | string | Required | `.tasks/005-pm-agent-system/` or `learning_base/09_decisions/cascade_{YYYYMMDD}_{slug}.md` |
| `changed_requirement` | string | Required | Preserved from input |
| `change_type` | string | Required | Preserved from input |
| `dependency_sequence` | list | Required | Ordered list of `{file_path, reason, update_description, priority}` |
| `review_obligations` | list | Required | `{file_path, reviewer, review_type: content|accuracy|sign-off}` |
| `execution_queue` | list | Required | Ordered Worker/Builder delegation tasks: `{task_description, target_file, dependencies: []}` |
| `cascade_summary` | string | Required | ≤100 words summary of scope |
| `defer_list` | list | Optional | Files excluded from this cascade with rationale |

**Dependency sequence rule:** Files are ordered so that no file appears before its upstream dependencies. Circular dependencies must be flagged.

### Checkpoint Touchpoints

| Checkpoint | Condition | Action |
|------------|-----------|--------|
| CP-RC-1 | Dependency sequence contains ≥5 files | Pause for BusinessAnalyst or ProjectManager review of scope before creating execution_queue |
| CP-RC-2 | `change_type: remove` or `change_type: deprecate` | Mandatory pause; requires human sign-off before execution_queue is published |
| CP-RC-3 | Circular dependency detected | Surface dependency graph; do not produce execution_queue until cycle is resolved |
| CP-RC-4 | `priority: urgent` | Escalate to ProjectManager checkpoint before any execution begins |

### Invocation Patterns

**Direct (user prompt):**
User addresses BusinessAnalyst with trigger phrase. Skill auto-activates.

**Via subagent (agent-to-agent):**
```markdown
Run the Worker agent as a subagent: Use requirements-cascade mode to plan the update propagation.
Changed requirement: [requirement ID and text]
Change type: [add|modify|remove|deprecate]
Impacted documents: [comma-separated file paths or "scan defaults"]
Return: dependency_sequence, review_obligations, execution_queue summary.
```

**Disallowed invocation contexts:**
- ProjectManager MUST NOT invoke directly (delegates to BusinessAnalyst)
- ProductOwner may invoke only via subagent prompt through Worker; not directly
- Technical advisors (FrontendDev, BackendDev) cannot invoke
- Worker executing the cascade MUST NOT invoke this skill for further cascades (no recursive cascade)

### Handoff Contract

| Direction | Agent | Condition |
|-----------|-------|-----------|
| **Upstream callers** | BusinessAnalyst | Primary invoker for all requirement cascade planning |
| **Upstream callers** | ProductOwner | May trigger via subagent when stakeholder signal requires cascade |
| **Downstream consumers** | Worker/Builder | Execute `execution_queue` items in dependency order |
| **Downstream consumers** | Reviewer | Fulfils `review_obligations` items |
| **Downstream consumers** | ProjectManager | Receives cascade summary at CP-RC-1 or CP-RC-4 for approval |
| **Escalation path** | ProjectManager (read-only) | Mandatory for `change_type: remove/deprecate` and `priority: urgent` |

### Failure / Escalation Conditions

| Condition | Action |
|-----------|--------|
| Impacted document cannot be read | Mark as `status: unreadable`; include in `defer_list` |
| Circular dependency detected | Trigger CP-RC-3; do not produce execution_queue |
| More than 10 files in dependency_sequence | Auto-trigger CP-RC-1 regardless of other conditions |
| `change_type: remove` without `reviewer_override` | Default reviewer to BusinessAnalyst; still trigger CP-RC-2 |

---

## Skill 4: backlog-management

### Objective

Prioritize candidate stories, constraints, and phase targets using MoSCoW classification and phase mapping metadata, producing structured backlog slices for ScrumMaster planning flow.

### Non-Goals

- Does NOT create sprint execution plans (planning execution is ScrumMaster's responsibility)
- Does NOT process raw stakeholder feedback (→ `stakeholder-feedback`)
- Does NOT manage requirement document updates (→ `requirements-cascade`)
- Does NOT generate diagrams (→ `diagram-generation`)
- Does NOT ingest new resources (→ `resource-ingestion`)
- Does NOT make final sprint commitment decisions autonomously — produces ranked inputs for human review

### Trigger Catalog

| # | Trigger Phrase |
|---|----------------|
| T4.1 | "prioritize the backlog" |
| T4.2 | "manage backlog items" |
| T4.3 | "apply MoSCoW to these stories" |
| T4.4 | "create a backlog slice for this sprint" |
| T4.5 | "rank these user stories" |
| T4.6 | "groom the backlog" |
| T4.7 | "assign phase targets to these items" |
| T4.8 | "sprint backlog planning" |
| T4.9 | "backlog triage" |
| T4.10 | "map stories to phases" |

### Trigger Exclusions

| Phrase | Route Instead To |
|--------|-----------------|
| "process stakeholder feedback" | `stakeholder-feedback` |
| "cascade requirements" | `requirements-cascade` |
| "update sprint plan" | ScrumMaster direct execution (no skill) |

### Input Schema

| Field | Required? | Accepted Sources |
|-------|-----------|-----------------|
| `candidate_stories` | Required | List of user story texts or IDs from `learning_base/planner_updates/` or inline |
| `constraints` | Required | Phase constraints, capacity bounds, hard dependencies |
| `phase_targets` | Required | Active phase(s) from `docs/roadmap.md` or `docs/development_timeline_phases_1_2.md` |
| `existing_backlog` | Optional | Path to current backlog artifact in `learning_base/planner_updates/` |
| `stakeholder_priorities` | Optional | VoC IDs from `learning_base/11_voice_of_customer/` for weighting |
| `moscow_overrides` | Optional | Manual MoSCoW assignments to honor (not override) |

### Output Schema

| Field | Type | Required? | Notes |
|-------|------|-----------|-------|
| `artifact_path` | string | Required | `learning_base/planner_updates/backlog_{YYYYMMDD}_{sprint-or-phase-slug}.md` |
| `backlog_date` | string | Required | ISO 8601 |
| `phase_target` | string | Required | Phase reference from `docs/roadmap.md` |
| `must_items` | list | Required | MoSCoW `Must` stories with: `{id, story, rationale, dependencies, estimate_flag}` |
| `should_items` | list | Required | MoSCoW `Should` stories (same schema) |
| `could_items` | list | Required | MoSCoW `Could` stories (same schema) |
| `wont_items` | list | Required | MoSCoW `Won't` stories with explicit deferral rationale |
| `capacity_note` | string | Required | Free-text capacity constraint summary |
| `dependency_map` | list | Optional | `{story_id, depends_on: [story_id]}` for sequencing |
| `stakeholder_weight_applied` | boolean | Optional | `true` if VoC IDs were used in prioritization |

**Naming convention:** `backlog_{YYYYMMDD}_{sprint-or-phase-slug}.md`

### Checkpoint Touchpoints

| Checkpoint | Condition | Action |
|------------|-----------|--------|
| CP-BM-1 | Any `must_items` item conflicts with existing `wont_items` from prior backlog | Surface conflict for ProductOwner decision before writing artifact |
| CP-BM-2 | `must_items` count exceeds capacity estimate | Pause for ScrumMaster review of scope before finalizing |
| CP-BM-3 | `stakeholder_weight_applied: true` and VoC signal `escalation_flag: true` | Escalate to ProductOwner for sign-off before publishing backlog slice |
| CP-BM-4 | Phase change detected (stories from prior phase re-entering current phase) | Surface rollover list; await ScrumMaster confirmation |

### Invocation Patterns

**Direct (user prompt):**
User addresses ProductOwner or ScrumMaster with trigger phrase. Skill auto-activates.

**Via subagent (agent-to-agent):**
```markdown
Run the Worker agent as a subagent: Use backlog-management mode to prioritize these stories.
Stories: [comma-separated story texts or IDs]
Phase target: [phase reference]
Constraints: [capacity, dependencies]
Return: MoSCoW backlog slice with must/should/could/wont classification and artifact path.
```

**Disallowed invocation contexts:**
- ProjectManager MUST NOT invoke directly (delegates to ProductOwner or ScrumMaster)
- Technical advisors cannot invoke (advisory scope only)
- QAEngineer cannot invoke

### Handoff Contract

| Direction | Agent | Condition |
|-----------|-------|-----------|
| **Upstream callers** | ProductOwner | Invokes during stakeholder intake and backlog grooming |
| **Upstream callers** | ScrumMaster | Invokes during sprint planning flow |
| **Downstream consumers** | ScrumMaster | Reads backlog slice to drive sprint commitment decisions |
| **Downstream consumers** | ProjectManager | Reads backlog artifacts for orchestration status |
| **Escalation path** | ProductOwner | Conflict resolution for MoSCoW disputes at CP-BM-1 and CP-BM-3 |

### Failure / Escalation Conditions

| Condition | Action |
|-----------|--------|
| No `must_items` after MoSCoW analysis | Flag as `empty_must_warning: true`; surface to ScrumMaster before writing |
| `candidate_stories` list is empty | Return error; do not write backlog artifact |
| Phase target not found in `docs/roadmap.md` | Halt and return error with instruction to verify phase name |
| All stories classified as `wont_items` | Trigger CP-BM-1 equivalent; do not write artifact without ScrumMaster sign-off |

---

## Skill 5: diagram-generation

### Objective

Given workflow or content deltas requiring visual update, produce diagram change specifications (required `.mmd`/`.drawio` changes and render steps), and surface manifest touchpoints for UIUXDesigner execution with Mermaid lifecycle compliance.

### Non-Goals

- Does NOT execute diagram rendering commands (execution delegated to UIUXDesigner via Worker)
- Does NOT modify architecture or requirements documents (→ `requirements-cascade`)
- Does NOT make design decisions about diagram content — specifies changes only
- Does NOT create diagrams for entirely new systems without an existing source file (first creation requires UIUXDesigner with explicit scope)
- Does NOT manage any non-diagram visual assets (images, mockups, etc.)

### Trigger Catalog

| # | Trigger Phrase |
|---|----------------|
| T5.1 | "generate a diagram" |
| T5.2 | "update the Mermaid diagram" |
| T5.3 | "update the draw.io diagram" |
| T5.4 | "add this flow to the diagram" |
| T5.5 | "diagram this workflow" |
| T5.6 | "update the architecture diagram" |
| T5.7 | "create a visual for this process" |
| T5.8 | "render this as a Mermaid chart" |
| T5.9 | "update diagrams/ after this change" |
| T5.10 | "diagram lifecycle update" |

### Trigger Exclusions

| Phrase | Route Instead To |
|--------|-----------------|
| "update requirements document" | `requirements-cascade` |
| "update the sprint plan" | ScrumMaster direct (no skill) |
| "design the UI mockup" | UIUXDesigner direct (no skill) |

### Input Schema

| Field | Required? | Accepted Sources |
|-------|-----------|-----------------|
| `change_description` | Required | Text description of what changed (workflow step, entity, relationship) |
| `diagram_type` | Required | `mermaid` \| `drawio` \| `unknown` |
| `existing_diagram_path` | Optional | Path to source file in `diagrams/`; if absent, indicates new diagram creation |
| `content_delta` | Optional | Structured diff or prose description of changes to apply |
| `target_render_path` | Optional | Path in `images/diagrams/` for rendered export; defaults to matching name |
| `mermaid_lifecycle_ref` | Optional | Reference to `.github/copilot-instructions.md` Mermaid lifecycle rules |

**Mermaid lifecycle compliance:** Outputs must comply with Mermaid lifecycle rules defined in `.github/copilot-instructions.md` (read-only reference; not modified by this skill).

### Output Schema

| Field | Type | Required? | Notes |
|-------|------|-----------|-------|
| `artifact_path` | string | Required | Change spec path: `.tasks/005-pm-agent-system/` or `learning_base/09_decisions/diagram_spec_{YYYYMMDD}_{slug}.md` |
| `diagram_type` | string | Required | `mermaid` or `drawio` |
| `source_file` | string | Required | Full path in `diagrams/` |
| `render_target` | string | Required | Full path in `images/diagrams/` |
| `change_spec` | string | Required | Exact `.mmd` or `.drawio` block with changes marked as `# ADD:`, `# REMOVE:`, `# MODIFY:` comments |
| `render_commands` | list | Required | Ordered commands for UIUXDesigner to execute (e.g., `mmdc -i diagrams/foo.mmd -o images/diagrams/foo.png`) |
| `manifest_touchpoints` | list | Required | Files that reference this diagram and may need link updates |
| `lifecycle_compliance_check` | string | Required | Confirmation that spec complies with `.github/copilot-instructions.md` Mermaid rules, or list of exceptions |
| `new_diagram_flag` | boolean | Optional | `true` if this specifies creation of a new file rather than update |

**Naming convention for source files:** `diagrams/{type}_{slug}.mmd` or `diagrams/{slug}.drawio`
**Naming convention for rendered exports:** `images/diagrams/{slug}.png` or `.svg`

### Checkpoint Touchpoints

| Checkpoint | Condition | Action |
|------------|-----------|--------|
| CP-DG-1 | `new_diagram_flag: true` | Pause for UIUXDesigner and ProjectManager confirmation before spec is finalized |
| CP-DG-2 | `manifest_touchpoints` list is non-empty | Surface touchpoints for review before delegating render execution |
| CP-DG-3 | `lifecycle_compliance_check` lists exceptions | Pause for human review; diagram spec must not violate Mermaid lifecycle rules |
| CP-DG-4 | `render_commands` includes destructive operations (overwrite of existing rendered export) | Pause for UIUXDesigner confirmation |

### Invocation Patterns

**Direct (user prompt):**
User addresses UIUXDesigner with trigger phrase. Skill auto-activates.

**Via subagent (agent-to-agent):**
```markdown
Run the Worker agent as a subagent: Use diagram-generation mode to specify this diagram update.
Change: [description of what changed]
Diagram type: [mermaid|drawio]
Existing diagram: [path in diagrams/ or "new"]
Return: change_spec, render_commands, manifest_touchpoints, lifecycle_compliance_check.
```

**Disallowed invocation contexts:**
- ProjectManager MUST NOT invoke directly (delegates to UIUXDesigner)
- FrontendDev and BackendDev cannot invoke execution steps (advisory only; may request diagram update via UI)
- QAEngineer cannot invoke
- BusinessAnalyst cannot invoke for purely technical diagrams; must route through UIUXDesigner

### Handoff Contract

| Direction | Agent | Condition |
|-----------|-------|-----------|
| **Upstream callers** | UIUXDesigner | Primary invoker for all diagram lifecycle work |
| **Upstream callers** | BusinessAnalyst | May trigger when architecture or requirements change requires diagram update |
| **Downstream consumers** | UIUXDesigner (via Worker) | Executes `render_commands` using diagram spec |
| **Downstream consumers** | Worker | Executes render commands and returns output evidence |
| **Downstream consumers** | Reviewer | Validates rendered output against manifest_touchpoints |
| **Escalation path** | ProjectManager (read-only) | Receives CP-DG-1 escalation for new diagram creation scope |

### Failure / Escalation Conditions

| Condition | Action |
|-----------|--------|
| `existing_diagram_path` provided but file does not exist | Set `new_diagram_flag: true`; trigger CP-DG-1 |
| Mermaid syntax error detected in `change_spec` | Return error with line reference; do not produce `render_commands` |
| `lifecycle_compliance_check` finds violations | Trigger CP-DG-3; halt execution |
| `render_commands` would overwrite an existing file | Trigger CP-DG-4; do not execute silently |

---

## Cross-Skill Overlap Disambiguation Table

This table defines how to resolve ambiguous user prompts that could match multiple skills. The first matching rule applies.

| User Prompt Pattern | Primary Skill | Exclude | Disambiguation Rule |
|---------------------|--------------|---------|---------------------|
| "ingest this feedback email" | `resource-ingestion` | `stakeholder-feedback` | Generic ingestion takes priority when no stakeholder analysis is requested. If analysis is requested, route to `stakeholder-feedback` after ingestion. |
| "process this stakeholder email" | `stakeholder-feedback` | `resource-ingestion` | "stakeholder" + "process" keyword combination routes to `stakeholder-feedback`. If pure filing is needed, caller must explicitly say "ingest". |
| "update requirements after stakeholder feedback" | `stakeholder-feedback` → `requirements-cascade` | None | Two-skill sequence: VoC first, then cascade. Neither skill is excluded; they chain. |
| "prioritize backlog based on stakeholder input" | `backlog-management` | `stakeholder-feedback` | Prioritization keyword dominates. Input VoC is a parameter, not a trigger for re-processing. |
| "diagram the new requirement flow" | `diagram-generation` | `requirements-cascade` | Visual output keyword dominates. Requirements context is input, not cascade trigger. |
| "cascade changes and update diagrams" | `requirements-cascade` → `diagram-generation` | None | Both skills apply in sequence: cascade plan first, diagram spec second. |
| "groom backlog after requirement change" | `requirements-cascade` → `backlog-management` | None | Cascade plan informs backlog update; sequence matters. |
| "update the Mermaid diagram after sprint planning" | `diagram-generation` | `backlog-management` | Sprint planning output is diagram input parameter; `diagram-generation` owns the output. |

### Disambiguation Priority Rules

1. Output artifact type determines primary skill:
   - VoC record → `stakeholder-feedback`
   - Ingestion summary → `resource-ingestion`
   - Cascade plan → `requirements-cascade`
   - Backlog slice → `backlog-management`
   - Diagram spec → `diagram-generation`
2. When two skills are both triggered, execute in dependency order (ingestion → feedback → cascade → backlog → diagram).
3. When ambiguous and output type is unclear, ProductOwner or invoking agent must disambiguate before skill activation.
4. No skill may autonomously invoke another skill inline. Agent must explicitly route to the next skill after the first completes.
