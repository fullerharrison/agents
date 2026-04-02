---
artifact: phase-1-interface-map
task: 005-pm-agent-system
phase: 1
created: 2026-03-18
status: complete
sources:
  - agents-personal/README.md
  - agents-personal/templates/agents/business-analyst.template.md
  - agents-personal/docs/architecture/ADR-001-orchestration-and-subagents.md
  - agents-personal/docs/architecture/ADR-002-task-centric-persistence.md
  - 2026_01_VIP repository structure (actual paths verified)
---

# Phase 1 Interface Map — agents-personal ↔ 2026_01_VIP Artifact Paths

## Purpose

This document maps the input/output contracts between the agents-personal framework and the 2026_01_VIP repository structure.  
It defines where agents read source context, where they write outputs, and which paths are confirmed to exist in 2026_01_VIP vs. which are future artifact locations (not yet created).

> **Scope boundary (CON-001):** Phase 1 artifacts write only to `.tasks/005-pm-agent-system/`. Production agent templates live in agents-personal (out of scope for this task). 2026_01_VIP path analysis is read-only mapping for Phase 2+ implementation guidance.

---

## 1. 2026_01_VIP Repository Structure (Verified Paths)

The following paths were confirmed to exist in the 2026_01_VIP repository at task creation time:

### `docs/` — Primary Documentation

| Path | Exists | Content |
|------|--------|---------|
| `docs/architecture.md` | ✅ | Technical boundaries and stack |
| `docs/htp_vip_vision.md` | ✅ | Strategic context and germplasm lifecycle |
| `docs/roadmap.md` | ✅ | Phase/delivery context (MVP → Phase 4) |
| `docs/project_goals.md` | ✅ | Project goals |
| `docs/stakeholder_brief_v1.md` | ✅ | Stakeholder brief |
| `docs/stakeholder_questions_v1.md` | ✅ | Stakeholder questions |
| `docs/development_timeline_phases_1_2.md` | ✅ | Timeline |
| `docs/figma_prompts_phase1_mvp.md` | ✅ | Design prompts |
| `docs/README.md` | ✅ | Docs index |
| `docs/architecture/` | ✅ (dir) | Architecture subdirectory |
| `docs/deployment/` | ✅ (dir) | Deployment subdirectory |
| `docs/implementation/` | ✅ (dir) | Implementation subdirectory |
| `docs/technical_features/` | ✅ (dir) | Technical features subdirectory |
| `docs/user_journeys/` | ✅ (dir) | User journeys subdirectory |
| `docs/vision/` | ✅ (dir) | Vision subdirectory |
| `docs/workflows/` | ✅ (dir) | Workflow documentation subdirectory |

> **Future artifact locations** (to be created in Phase 2+):  
> `docs/ways-of-work/plan/{epic-name}/epic.md` — Epic breakdown outputs (BusinessAnalyst/breakdown-epic-pm skill)  
> `docs/ways-of-work/plan/{epic-name}/{feature-name}.md` — Feature spec outputs (breakdown-feature-prd skill)

### `learning_base/` — Research and Requirements Baseline

| Path | Exists | Content |
|------|--------|---------|
| `learning_base/README.md` | ✅ | Index |
| `learning_base/REVIEW_WORKFLOW.md` | ✅ | Documentation cascade review obligations |
| `learning_base/01_project_overview/` | ✅ (dir) | Project overview documents |
| `learning_base/02_requirements/` | ✅ (dir) | Requirements baseline (BRD, matrices) |
| `learning_base/02_requirements/HTP-VIP-Requirements-BRD-v1-1.md` | ✅ | Primary BRD |
| `learning_base/02_requirements/ADS-HTP-VIP-Requirements-Matrix-v2.csv` | ✅ | Requirements CSV matrix |
| `learning_base/03_architecture/` | ✅ (dir) | Architecture documents |
| `learning_base/04_data_models/` | ✅ (dir) | Data model documents |
| `learning_base/05_technical_specs/` | ✅ (dir) | Technical specs |
| `learning_base/06_implementation/` | ✅ (dir) | Implementation notes |
| `learning_base/07_testing/` | ✅ (dir) | Testing artifacts |
| `learning_base/08_operations/` | ✅ (dir) | Operations documents |
| `learning_base/09_decisions/` | ✅ (dir) | Decision records |
| `learning_base/10_meeting_notes/` | ✅ (dir) | Meeting notes |
| `learning_base/11_voice_of_customer/` | ✅ (dir) | VoC outputs |
| `learning_base/11_voice_of_customer/voc_001_video_processor_zakaria.md` | ✅ | VoC example 1 |
| `learning_base/11_voice_of_customer/voc_002_video_collector_ling.md` | ✅ | VoC example 2 |
| `learning_base/12_roadblocks/` | ✅ (dir) | Roadblocks and issues |
| `learning_base/13_deprecated/` | ✅ (dir) | Deprecated documents |
| `learning_base/ideas/` | ✅ (dir) | Ideas and planning |
| `learning_base/ideas/pm_agent_coordination_system_implementation_plan.md` | ✅ | PM agent system source plan |
| `learning_base/planner_updates/` | ✅ (dir) | Planner integration updates |
| `learning_base/templates/` | ✅ (dir) | Document templates |

### `specs/` — Specification Files

| Path | Exists | Content |
|------|--------|---------|
| `specs/data_models.md` | ✅ | Entity and domain model |
| `specs/technical_features.md` | ✅ | Feature inventory and scope |

### `diagrams/` and `images/` — Visual Artifacts

| Path | Exists | Content |
|------|--------|---------|
| `diagrams/` | ✅ (dir) | Diagram files (Mermaid and draw.io source) |
| `images/` | ✅ (dir) | Image assets |
| `images/diagrams/` | ❓ Future | Rendered diagram exports (to be created by UIUXDesigner in Phase 3) |

> **Note:** `images/` root exists with PNG files (`app_ui_mockup.png`, `data_quality_journey.png`, etc.). A dedicated `images/diagrams/` subdirectory for rendered diagram exports has not been created yet.

### `.tasks/` — Planning State

| Path | Exists | Content |
|------|--------|---------|
| `.tasks/005-pm-agent-system/` | ✅ (dir) | This task's planning artifacts |
| `.tasks/005-pm-agent-system/task.md` | ✅ | Phase table, research findings |
| `.tasks/005-pm-agent-system/plan/` | ✅ (dir) | Phase plans |
| `.tasks/005-pm-agent-system/artifacts/` | ✅ (dir) | Phase execution artifacts |
| `.tasks/005-pm-agent-system/artifacts/phase-1/` | ✅ (dir) | Phase 1 outputs (this file) |

---

## 2. Agent Input Contract Map

This table defines where each PM agent reads source context before producing outputs.

### Context Read Paths per Agent Role

| PM Agent | Reads From | Key Files / Paths | Source Reference |
|---|---|---|---|
| **ProjectManager** | `.tasks/` (only) | `.tasks/005-pm-agent-system/task.md`, active phase plan | ADR-001 §CC constraint; SCP-007 |
| **BusinessAnalyst** | `docs/`, `learning_base/`, `specs/` | `docs/htp_vip_vision.md`, `docs/architecture.md`, `docs/roadmap.md`, `learning_base/02_requirements/`, `specs/data_models.md`, `specs/technical_features.md` | business-analyst.template.md §Project Context |
| **ProductOwner** | `docs/`, `learning_base/`, incoming resources | `docs/roadmap.md`, `learning_base/02_requirements/`, `learning_base/11_voice_of_customer/`, stakeholder inputs | business-analyst.template.md pattern; task.md §Phase 4 |
| **ScrumMaster** | `docs/`, `learning_base/`, `.tasks/` | `docs/roadmap.md`, phase plans, backlog artifacts | task.md §Phase 3; ADR-001 |
| **FrontendDev** | `docs/`, `specs/`, `diagrams/` | `docs/architecture.md`, `specs/technical_features.md`, current diagram state | task.md §Phase 3 (read-only advisory) |
| **BackendDev** | `docs/`, `specs/`, `learning_base/` | `docs/architecture.md`, `specs/data_models.md`, `specs/technical_features.md` | task.md §Phase 3 (read-only advisory) |
| **QAEngineer** | `docs/`, `specs/`, `learning_base/07_testing/` | `specs/technical_features.md`, `docs/workflows/`, test specs | task.md §Phase 3 |
| **UIUXDesigner** | `docs/`, `diagrams/`, `images/` | `docs/architecture.md`, current diagram sources in `diagrams/` | task.md §Phase 3 |
| **Worker** | Caller-provided context only | File paths provided in subagent invocation prompt | ADR-004 §Subagent Prompt Structure |

---

## 3. Agent Output Contract Map

This table defines where each PM agent writes its outputs. Paths marked `🔮 Future` are not yet created in the repository.

### Output Write Paths per Agent Role

| PM Agent | Output Document Type | Write Path | Exists? |
|---|---|---|---|
| **BusinessAnalyst** | PRD | `docs/` or `learning_base/02_requirements/` | ✅ |
| **BusinessAnalyst** | Epic breakdown | `docs/ways-of-work/plan/{epic-name}/epic.md` | 🔮 Future |
| **BusinessAnalyst** | Feature spec | `docs/ways-of-work/plan/{epic-name}/{feature-name}.md` | 🔮 Future |
| **BusinessAnalyst** | Specification update | `specs/data_models.md` or `specs/technical_features.md` | ✅ |
| **BusinessAnalyst** | Architecture blueprint | `docs/architecture/` or `docs/` | ✅ |
| **ProductOwner** | Voice of Customer document | `learning_base/11_voice_of_customer/voc_{NNN}_{slug}.md` | ✅ (pattern exists) |
| **ProductOwner** | Backlog item | `learning_base/planner_updates/` or future backlog dir | ✅ (planner_updates/) |
| **ProductOwner** | Stakeholder intake | `learning_base/10_meeting_notes/` | ✅ |
| **ScrumMaster** | Sprint plan | `learning_base/planner_updates/` or `docs/ways-of-work/sprints/` | 🔮 Future (sprints dir) |
| **ScrumMaster** | Retrospective | `learning_base/10_meeting_notes/` | ✅ |
| **QAEngineer** | Test plan | `learning_base/07_testing/` | ✅ |
| **QAEngineer** | Test results | `learning_base/07_testing/` | ✅ |
| **UIUXDesigner** | Mermaid diagram source | `diagrams/` | ✅ |
| **UIUXDesigner** | Rendered diagram export | `images/diagrams/` | 🔮 Future |
| **UIUXDesigner** | Design spec | `docs/` | ✅ |
| **FrontendDev** | Advisory note | `learning_base/09_decisions/` | ✅ |
| **BackendDev** | Advisory note | `learning_base/09_decisions/` | ✅ |
| **ProjectManager** | Checkpoint decision record | `.tasks/005-pm-agent-system/` (planning scope) | ✅ |
| **Worker** | Execution output | Caller-specified path (any writable path) | Varies |

---

## 4. Skill-to-Path Binding Map

This table maps PM system skills (Phase 2) to their expected output locations in 2026_01_VIP.

| Skill | Invoking Agent(s) | Trigger Phrase(s) | Output Path | Path Exists? |
|---|---|---|---|---|
| `prd` | BusinessAnalyst | "write a PRD", "document requirements" | `docs/` or `learning_base/02_requirements/` | ✅ |
| `breakdown-epic-pm` | BusinessAnalyst | "break down this epic", "PM breakdown" | `docs/ways-of-work/plan/{epic-name}/epic.md` | 🔮 Future |
| `breakdown-feature-prd` | BusinessAnalyst | "spec out this feature", "feature PRD" | `docs/ways-of-work/plan/{epic-name}/{feature-name}.md` | 🔮 Future |
| `update-specification` | BusinessAnalyst | "update the spec", "add to data model" | `specs/data_models.md` or `specs/technical_features.md` | ✅ |
| `architecture-blueprint-generator` | BusinessAnalyst | "document the architecture of" | `docs/architecture/` | ✅ |
| `resource-ingestion` | ProductOwner | "ingest this email/doc/link" | `learning_base/` (appropriate subdirectory by content type) | ✅ |
| `stakeholder-feedback` | ProductOwner | "process stakeholder feedback", "structure VoC" | `learning_base/11_voice_of_customer/voc_{NNN}_{slug}.md` | ✅ |
| `backlog-management` | ProductOwner, ScrumMaster | "prioritize backlog", "sprint planning" | `learning_base/planner_updates/` | ✅ |
| `requirements-cascade` | BusinessAnalyst | "cascade requirement update", "propagate change" | Reads `specs/`, `docs/`; writes to changed file | ✅ |
| `diagram-generation` | UIUXDesigner | "generate diagram", "update Mermaid" | `diagrams/` (source); `images/diagrams/` (export) | ✅ / 🔮 |

---

## 5. agents-personal Output Mapping

This table maps agents-personal generated outputs to the install locations used by 2026_01_VIP agents.

| agents-personal Source | Generated Output | Install Path | Format |
|---|---|---|---|
| `templates/agents/*.template.md` | VS Code agent | `generated/copilot/agents/*.agent.md` → `~/.copilot/agents/` | `.agent.md` |
| `templates/agents/*.template.md` | CC subagent | `generated/claude/agents/*.md` → `~/.claude/agents/` | `.md` |
| `templates/skills/*/SKILL.template.md` | VS Code skill | `generated/copilot/skills/*/SKILL.md` → `~/.copilot/skills/` | `SKILL.md` |
| `templates/skills/*/SKILL.template.md` | CC skill | `generated/claude/skills/*/SKILL.md` → `~/.claude/skills/` | `SKILL.md` |
| `templates/instructions/*.template.md` | VS Code instruction | `generated/copilot/instructions/*.instructions.md` → `~/.copilot/instructions/` | `.instructions.md` |
| `templates/instructions/*.template.md` | CC rule | `generated/claude/rules/*.md` → `~/.claude/rules/` | `.md` |

Source: ADR-005 §Build and Install; templates/README.md §Output Directory Mapping

> **2026_01_VIP context:** New PM system agent templates for this project will be created in agents-personal `templates/agents/` and regenerated via `make && ./install.sh`. This work is scoped to Phases 3–5 in agents-personal (outside this task's `.tasks/` write boundary).

---

## 6. Handoff Compatibility Matrix

This table maps the handoff contracts between PM agents and confirms compatibility with existing agents-personal handoff patterns.

| From Agent | To Agent | Trigger | Handoff Mechanism | Compatibility |
|---|---|---|---|---|
| ProductOwner | BusinessAnalyst | Requirements need PRD/spec write | `agents: ["BusinessAnalyst"]` + `Plan Sprint` equivalent button | ✅ Reuse BA handoff pattern |
| ProductOwner | ScrumMaster | Backlog ready for sprint | `agents: ["ScrumMaster"]` + handoff button | ✅ BA→SM handoff exists |
| ProductOwner | Worker | File conversion / data processing | `agents: ["Worker"]` + skill-powered subagent prompt | ✅ ADR-004 pattern |
| ScrumMaster | ProjectManager | Sprint plan checkpoint | AskUserQuestion pause point | ✅ ADR-001 checkpoint |
| ScrumMaster | Worker | Task execution delegation | `agents: ["Worker"]` | ✅ ADR-001 pattern |
| BusinessAnalyst | ProjectManager | Document ready for cascade review | AskUserQuestion pause point | ✅ ADR-001 checkpoint |
| ProjectManager | Any Specialist | Route work request | `Task(AgentName, ...)` (CC) / `agents:` restriction (Copilot) | ✅ Conductor pattern |
| QAEngineer | ProjectManager | Test results checkpoint | AskUserQuestion (pass/fail gate) | ✅ ADR-001 §Verification Layer |

Source: ADR-001 §Mandatory Pause Points; business-analyst.template.md §handoffs; ADR-004 §Pattern

---

## 7. Boundary Verification

### Write Boundary Confirmation (SC-008 / CON-001)

All Phase 1 deliverables listed in the phase plan are under `.tasks/005-pm-agent-system/`:

| Deliverable | Path | Compliant? |
|---|---|---|
| `phase-1-reuse-map.md` | `.tasks/005-pm-agent-system/artifacts/phase-1/phase-1-reuse-map.md` | ✅ |
| `phase-1-orchestration-skill-invocation-guidelines.md` | `.tasks/005-pm-agent-system/artifacts/phase-1/phase-1-orchestration-skill-invocation-guidelines.md` | ✅ |
| `phase-1-interface-map.md` | `.tasks/005-pm-agent-system/artifacts/phase-1/phase-1-interface-map.md` | ✅ |
| `task.md` status update | `.tasks/005-pm-agent-system/task.md` | ✅ |

No files outside `.tasks/005-pm-agent-system/` were modified in Phase 1. ✅

### agents-personal Boundary Confirmation

No files in `C:/Users/s1058662/repos/agents-personal/` were modified in Phase 1. All reads from agents-personal were input-only. ✅

---

## 8. Future Artifact Locations Summary

Locations that do not yet exist in 2026_01_VIP but are required for Phase 2+ implementation:

| Future Path | Purpose | Created In Phase |
|---|---|---|
| `docs/ways-of-work/plan/` | Epic and feature spec output directory | Phase 3 (BusinessAnalyst skill outputs) |
| `images/diagrams/` | Rendered diagram export directory | Phase 3 (UIUXDesigner diagram-generation skill) |
| `docs/ways-of-work/sprints/` | Sprint plan output directory | Phase 3 (ScrumMaster outputs) |

> These locations should be created as part of Phase 3 agent template development, not Phase 1 scope.
