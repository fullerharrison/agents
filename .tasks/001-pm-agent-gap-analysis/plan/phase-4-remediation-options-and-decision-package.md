---
phase: 4
phase_name: Remediation Options and Decision Package
task: Investigate PM custom-agent coordination failures vs known-good baseline
status: Planned
created: 2026-03-23
owner: Explorer
---

# Phase 4 Plan: Remediation Options and Decision Package

## Objective

Translate Phase 3 root-cause findings (7 RC-* entries) into 2+ concrete remediation options, each with defined scope, risk, effort, rollback strategy, and tradeoff analysis. Design a decision framework to select the optimal option based on stakeholder constraints (timeline, risk tolerance, acceptance criteria priority) and produce a Remediation Options Package ready for Phase 5 implementation planning.

## Scope

- In scope:
  - Group the 7 Phase 3 root causes (RC-001 through RC-007) into remediation-coherent option packages.
  - For each option, define:
    - **Target gap set**: Which GAP-* rows each option addresses and to what degree.
    - **Affected systems**: Which VIP artifacts, agent configs, instruction files, and baseline contracts are impacted.
    - **Effort estimate**: Delivery effort category (Low/Moderate/High) with line count and relative complexity rationale.
    - **Risk assessment**: Technical, integration, and rollback risk categories with mitigation strategies.
    - **Acceptance criteria delivery**: Which of the 4 acceptance domains (coordination, ingestion, planner-output, pm-recommendation) are addressed per option.
    - **Recommendation criteria**: Decision logic for when to choose this option.
  - Produce a remediation decision matrix comparing all options side-by-side.
  - Define a single recommended option with explicit rationale tied to baseline-parity goals and the acceptance criteria definitions.
  - Trace each option back to the Phase 3 GAP-RC-* links to ensure no root cause is orphaned or double-counted.
- Out of scope:
  - Implementing or executing any remediation (Phase 5).
  - Modifying VIP agent configuration or instruction files in this phase.
  - Retroactively revising Phase 3 gap analysis; only consume Phase 3 outputs as-is.

---

## Phase Dependencies

| Dependency ID | Source Phase | Artifact Required | Consumed In Phase 4 |
|---|---|---|---|
| DEP-PHASE4-001 | Phase 3 | `evidence/phase-3-gap-register.md` | Row classification into option buckets; traceability to GAP-001 through GAP-007 |
| DEP-PHASE4-002 | Phase 3 | `evidence/phase-3-root-cause-catalog.md` | RC-001 through RC-007 grouping into option scope; priority classification |
| DEP-PHASE4-003 | Phase 3 | `evidence/phase-3-gap-rc-links.md` | Link-based traceability for option coverage validation |
| DEP-PHASE4-004 | Phase 3 | `evidence/phase-3-coverage-summary.md` | Acceptance domain mapping; used to verify option cross-domain impact |
| DEP-PHASE4-005 | Phase 2 | `evidence/phase-2-orchestration-contract-map.md` | BAS-CONTRACT-001 through BAS-CONTRACT-010 for effort/rollback baseline scope |

**Pre-condition gate**: All DEP-PHASE4-* artifacts must be present and non-empty before Phase 4 begins. If any artifact is missing or header-only, record a dependency blocker and halt Phase 4.

---

## Detailed Artifacts to Produce

### 1. Remediation Option Scope Matrix

- **File**: `evidence/phase-4-remediation-option-scopes.md`
- **Purpose**: Define the boundaries of each remediation option (REMOPT-A, REMOPT-B, etc.) and which root causes and gaps each option addresses.
- **Required columns**:

  | Option ID | Option Name | RC IDs Targeted | RC IDs Deferred | Gap IDs Fully Addressed | Gap IDs Partially Addressed | Acceptance Domains Addressed | Out-of-Scope Decisions | Option Characterization |

- **Minimum scope required**:
  - At least 2 options (usually **Option A: Minimal/Risk-Contained** and **Option B: Comprehensive/Baseline-Aligned**).
  - **Option A** addresses at least the Critical-priority and High-priority root causes required to unblock the highest-impact acceptance domain (coordination handoffs or ingestion).
  - **Option B** addresses all 7 observed root causes (RC-001 through RC-007) and all 4 acceptance domains.
  - Every RC-* entry appears in exactly one option's "RC IDs Targeted" or "RC IDs Deferred" column (no orphans).
  - Every GAP-* entry is classified as "Fully Addressed" or "Partially Addressed" or left as belonging to deferred root causes in each option.

---

### 2. Remediation Effort and Risk Assessment Matrix

- **File**: `evidence/phase-4-effort-risk-matrix.md`
- **Purpose**: For each remediation option, quantify delivery effort, estimate risk vectors, and define rollback strategy.
- **Required columns**:

  | Option ID | Effort Category | Estimated Lines | Complexity Rationale | Technical Risk | Integration Risk | Rollback Strategy | Mitigation Approach |

- **Effort categories**: 
  - `Low` (20–100 lines changed/added, mostly instruction/prompt updates, single-system impact)
  - `Moderate` (100–500 lines, multiple files or agents affected, some cross-system dependencies)
  - `High` (500+ lines, architectural changes, full orchestration rewrite, or cross-cutting changes)
- **Risk vectors**:
  - **Technical Risk**: Likelihood of implementation failure (e.g., file-path resolution complexity, binary tooling issues). Rate as Low/Medium/High with mitigation strategy.
  - **Integration Risk**: Risk of unintended side effects on other PM workflows or acceptance criteria. Rate as Low/Medium/High.
  - **Rollback Risk**: Difficulty of reverting changes if post-fix issues appear in production. Rate as Low/Medium/High.
- **Rollback strategy**: Concrete steps to revert changes (e.g., restore baseline instruction files, reset VIP agent config, restore prior learning-base state).

---

### 3. Acceptance Criteria Delivery Matrix

- **File**: `evidence/phase-4-acceptance-delivery-matrix.md`
- **Purpose**: Explicitly map each remediation option to the 4 acceptance domains from task.md and rate coverage per domain.
- **Required columns**:

  | Option ID | Coordination Domain | Ingestion Domain | Planner-Output Domain | PM-Recommendation Domain | Coverage Summary |

- **Acceptance domain values** (per task.md §4):
  1. Reliable agent coordination/orchestration (handoff order, Conductor gates, phase progression)
  2. Learning-base ingestion (ProjectOwner writes, no silent failures, observable state)
  3. Planner-friendly BA output format (BAS-SCHEMA-001/002/004 compliance, Planner-import capability)
  4. PM-tool recommendation behavior (framework selection, context evaluation, proactive suggestion)
- **Coverage rating per domain**:
  - `✅ Full` — Option fully addresses all gaps and acceptance criteria in this domain.
  - `⚠️ Partial` — Option addresses some gaps but leaves residual formatting or logic gaps.
  - `❌ Deferred` — Option defers this domain to future phases.
  - Include one-line explanation for each rating.
- **Requirement**: Option B must show `✅ Full` for all 4 domains; Option A may show `⚠️ Partial` or `❌ Deferred` in lower-priority domains.

---

### 4. Remediation Decision Matrix (Executive Summary)

- **File**: `evidence/phase-4-decision-matrix.md`
- **Purpose**: Side-by-side comparison of all options to support selection decision.
- **Required contents**:
  - Simple comparison table: Option ID, Effort, Risk Level, Acceptance Domain Coverage (✅/⚠️/❌), Key Trade-offs, Selection Recommendation Flag.
  - Narrative section explaining when to choose each option (e.g., "Choose Option A if timeline is critical and coordination domain is priority; choose Option B if baseline parity is required within 4 weeks").
  - Explicit recommendation section: **"Recommended Option: [REMOPT-X] based on [rationale tied to stakeholder constraints and acceptance criteria]"**.

---

### 5. Root-Cause-to-Remediation Traceability Map

- **File**: `evidence/phase-4-rc-remediation-traceability.md`
- **Purpose**: Ensure every Phase 3 root cause is assigned to exactly one remediation option (no orphans, no double-counts).
- **Required columns**:

  | RC ID | RC Category | Priority | Option ID (Targeted) | Option ID (Deferred) | Traceability Rationale | Phase 5 Workstream |

- **Validation requirement**: 
  - All 7 RC-* entries (RC-001 through RC-007) must appear exactly once in the "Option ID (Targeted)" or "Option ID (Deferred)" column.
  - Every "Targeted" RC must have a traceability rationale explaining why it is included in that option.
  - Every "Deferred" RC must have a rationale explaining why it is deferred and under what conditions it would be addressed later.

---

### 6. Gap-to-Remediation Coverage Log

- **File**: `evidence/phase-4-gap-remediation-coverage-log.md`
- **Purpose**: Verify that every Phase 3 gap row (GAP-001 through GAP-007) is addressed by at least one remediation option and is not left unresolved.
- **Required columns**:

  | Gap ID | Gap Domain | Root Causes (from Phase 3 links) | Fully Addressed By | Partially Addressed By | Not Addressed | Coverage Status |

- **Coverage status values**:
  - `✅ Fully Covered` — At least one option fully addresses this gap (all linked RCs targeted).
  - `⚠️ Partially Covered` — At least one option addresses some but not all linked RCs.
  - `❌ Unresolved` — No option addresses this gap (should not occur; if it does, flag as analysis error and escalate).
- **Validation requirement**: All 7 GAP-* entries must show `✅ Fully Covered` or `⚠️ Partially Covered` in the recommended option; no `❌ Unresolved` gaps should remain for the recommended option.

---

### 7. Remediation Decision Recommendation

- **File**: `evidence/phase-4-recommendation-and-rationale.md`
- **Purpose**: Document the final remediation option selection and provide explicit decision rationale tied to task acceptance criteria and stakeholder constraints.
- **Required contents**:
  - **Selected Option**: `[REMOPT-X]` with full name.
  - **Selection Rationale**: Narrative explaining why this option was selected over alternatives, tied explicitly to:
    - Acceptance criteria from task.md (reliability, ingestion, planner-output, pm-recommendation).
    - Phase 3 findings (which root causes dominate failure risk).
    - Stakeholder constraints (timeline, risk tolerance, baseline-parity goal).
  - **Expected Outcome**: Narrative describing the expected behavior improvements per acceptance domain once the selected option is implemented.
  - **Residual Risk**: List any gaps that remain after recommended option implementation and note when they would be addressed (future phases/backlog).
  - **Implementation Readiness Check**: Confirm that the selected option is implementable within known tool and path constraints (no blockers from tooling or environment).

---

### 8. task.md Update

- **File**: `.tasks/001-pm-agent-gap-analysis/task.md`
- **Required change**: Update Phase 4 row to `📋 Planned` with plan link.

---

## Step-by-Step Implementation Actions

### Step 1: Verify Phase 3 dependency artifacts and read root-cause catalog

1. Confirm all DEP-PHASE4-* artifacts exist and are non-empty.
2. Read `evidence/phase-3-root-cause-catalog.md` to extract:
   - All 7 RC-* IDs and their priority classification (Phase4-Critical, Phase4-High).
   - Root-cause categories: PATH-RESOLUTION, GATE-MISSING, CONFIG-DRIFT, TRIGGER-MISSING, FORMAT-CONTRACT, ROLE-BOUNDARY, PM-TOOL-LOGIC.
3. Read `evidence/phase-3-gap-rc-links.md` to understand the many-to-many mapping of gaps to root causes.
4. Read `evidence/phase-3-coverage-summary.md` to confirm all 4 acceptance domains are represented.

**Blocking condition check**: If any DEP-PHASE4-* is missing or empty, create `evidence/phase-4-dependency-blockers.md` and halt Phase 4.

---

### Step 2: Group root causes into remediation options

Based on Phase 3 priorities and interdependencies, define at least 2 remediation options:

#### **Option A: Critical-Path Patch (Minimal Scope, Lower Risk)**

**Target these root causes:**
- **RC-002 (GATE-MISSING)** — Phase4-Critical
  - Rationale: Blocking coordinate handoffs (GAP-007) and ingestion state management (GAP-001, GAP-002). Most fundamental orchestration gap.
  - Effort: Moderate (Conductor config + gate definitions + agent handoff sequence updates)
  - Action: Define and inject 3 Conductor gates (BAS-GATE-001, BAS-GATE-002, BAS-GATE-003) into VIP orchestration.
  
- **RC-005 (FORMAT-CONTRACT)** — Phase4-Critical
  - Rationale: Blocks planner-output acceptance domain (GAP-003, GAP-004). Highest-impact output format gap.
  - Effort: Moderate (schema template updates in BA and Scrum Master agent instructions).
  - Action: Add BAS-SCHEMA-001/002/004 field definitions and emission requirements to agent instructions.
  
- **RC-001 (PATH-RESOLUTION)** — Phase4-Critical
  - Rationale: Blocks ingestion (GAP-001, GAP-002). Though technical (tooling path), is necessary fallback path enabler.
  - Effort: Low–Moderate (environment variable or tool-wrapper fix).
  - Action: Resolve binary-conversion tooling path in VIP; implement fallback logging.

**Defer these root causes to Phase 5/6:**
- RC-003 (CONFIG-DRIFT) — partially addressable via RC-002 gate enforcement
- RC-004 (TRIGGER-MISSING) — add as enhancement in follow-on phase
- RC-006 (ROLE-BOUNDARY) — enforced by RC-002 gate implementation
- RC-007 (PM-TOOL-LOGIC) — lowest-priority acceptance domain; defer to Phase 6  - Initial framework set: RAID, RACI, Fishbone (3 frameworks)
  - Context signals to evaluate: Unresolved blockers, stakeholder-alignment risk, governance gate violations
  - Scoring approach: Binary qualification → recommend applicable framework; if multiple qualify, order by frequency
**REMOPT-A Residual-Risk Table:**

| Acceptance Domain | Coverage | Residual Gap | Resolution Path |
|---|---|---|---|
| Coordination | ✅ Full | None | Implemented in Phase 5 |
| Ingestion | ✅ Full | None | Implemented in Phase 5 |
| Planner-Output | ✅ Full | None | Implemented in Phase 5 |
| PM-Recommendation | ❌ Deferred | Proactive framework recommendation logic absent; manual PM intervention required | Phase 6 enhancement after production validation |

**Gaps addressable:**
- `✅ Full`: GAP-001, GAP-002, GAP-003, GAP-004, GAP-007
- `⚠️ Partial`: GAP-005, GAP-006 (PM-recommendation domain deferred; gate infrastructure in place for future logic activation)

**Acceptance domains:**
- `✅ Full`: Coordination, Ingestion, Planner-Output
- `❌ Deferred`: PM-Recommendation (gates allow for future logic; logic itself not implemented)

**Residual gap acknowledgment**: PM-Recommendation domain remains non-operational in REMOPT-A. Proactive framework recommendation logic is absent; manual PM intervention required. **This residual gap requires explicit stakeholder confirmation before selecting REMOPT-A** — the PM workflow will not meet baseline operational expectations until Phase 6 enhancement.

**Gate pre-conditions for RC-006 (ROLE-BOUNDARY) enforcement:**
- **BAS-GATE-001 (plan-init)**: User role ∈ {BA, Product Owner} — enforces planning entry-point role requirement
- **BAS-GATE-002 (plan-review)**: Planner initiated from BA output AND Current phase ∈ {design, review} — ensures planning request has explicit BA origin
- **BAS-GATE-003 (impl-start)**: Scrum Master has reviewed and signed off — enforces role-boundary handoff completion

**Effort**: ~250–350 lines across VIP agent configs, instruction updates, Conductor definitions.

**Risk**: Lower (targeted changes, leverages existing Conductor patterns, no architectural refactor).

---

#### **Option B: Comprehensive Baseline Realignment (Full Scope, Higher Risk)**

**Target all 7 root causes:**
- **RC-002 (GATE-MISSING)**
  - Same as Option A implementation.
  
- **RC-005 (FORMAT-CONTRACT)**
  - Same as Option A implementation.
  
- **RC-001 (PATH-RESOLUTION)**
  - Same as Option A implementation.
  
- **RC-003 (CONFIG-DRIFT)**
  - Rationale: Completes PM instruction alignment with baseline.
  - Action: Full audit and align PM agent instruction content with BAS-SCHEMA-003 recommendation block obligation.
  - Effort: Low (primarily instruction prose/examples update).
  
- **RC-004 (TRIGGER-MISSING)**
  - Rationale: Activates both planning and PM-recommendation logic pathways.
  - Action: Implement two trigger conditions in agent orchestration:
    1. BA-to-planning-intent trigger (BAS-TRIG-006 equivalent) — routes planning requests through Scrum Master handoff channel.
    2. Risk/governance-context trigger — evaluates blocker/stakeholder-alignment signals and activates PM recommendation path.
  - Effort: Moderate (trigger predicate evaluation logic, agent routing condition updates).
  
- **RC-006 (ROLE-BOUNDARY)**
  - Rationale: Enforces full BA→Scrum Master→Builder handoff chain.
  - Action: Inject role-boundary enforcement into Conductor orchestration; prevent direct delegation bypass.
  - Effort: Moderate (Conductor role-gating logic, agent handoff enforcement).
  
- **RC-007 (PM-TOOL-LOGIC)**
  - Rationale: Enables proactive PM framework recommendation.
  - Action: Implement PM framework selection logic in PM agent; add context-evaluation loop per BAS-SCHEMA-003.
  - Effort: Moderate–High (framework context evaluation, scoring, recommendation output template).

**Gaps addressable:**
- `✅ Full`: All 7 gaps (GAP-001 through GAP-007)

**Acceptance domains:**
- `✅ Full`: All 4 domains (Coordination, Ingestion, Planner-Output, PM-Recommendation)

**Effort**: ~700–1000 lines across all agent configs, instructions, orchestration layer, and PM-tool logic.

**Risk**: Higher
- Technical risk: Moderate (trigger predicate implementation, PM-tool framework integration).
- Integration risk: Higher (changes span multiple agents, orchestration layer, learning-base write paths).
- Rollback risk: Higher (distributed changes require coordinated rollback; rollback plan must cover agent config reset, instruction file revert, and memory flush).

---

### Step 3: Create remediation option scope matrix

Generate `evidence/phase-4-remediation-option-scopes.md` with the following structure:

| Option ID | Option Name | RC IDs Targeted | RC IDs Deferred | Gap IDs Fully Addressed | Gap IDs Partially Addressed | Acceptance Domains Addressed | Out-of-Scope Decisions | Option Characterization |
|---|---|---|---|---|---|---|---|---|
| REMOPT-A | Critical-Path Patch | RC-001, RC-002, RC-005 | RC-003, RC-004, RC-006, RC-007 | GAP-001, GAP-002, GAP-003, GAP-004, GAP-007 | GAP-005, GAP-006 | Coordination, Ingestion, Planner-Output | No refactoring of learning-base write paths; PM logic deferred; role-boundary enforcement delegated to gate logic | Tactical patch addressing 3 critical RCs; unblocks 3/4 acceptance domains; lower timeline risk |
| REMOPT-B | Comprehensive Baseline Realignment | RC-001, RC-002, RC-003, RC-004, RC-005, RC-006, RC-007 | None | GAP-001, GAP-002, GAP-003, GAP-004, GAP-005, GAP-006, GAP-007 | None | Coordination, Ingestion, Planner-Output, PM-Recommendation | None | Strategic realignment of full PM agent orchestration; achieves baseline parity; higher implementation risk |

---

### Step 4: Assess effort and risk per option

Generate `evidence/phase-4-effort-risk-matrix.md`:

| Option ID | Effort Category | Estimated Lines | Complexity Rationale | Technical Risk | Integration Risk | Rollback Strategy | Mitigation Approach |
|---|---|---|---|---|---|---|---|
| REMOPT-A | Moderate | 250–350 | Targeted instruction updates (~100L), Conductor gate definitions (~80L), tool-path resolution (~30L), agent routing conditionals (~40L). Changes are additive and mostly in config/instruction layers, not core logic. Gate pre-conditions: BAS-GATE-001 enforces user role ∈ {BA, PO}; BAS-GATE-002 enforces BA-origin + phase qualification; BAS-GATE-003 enforces SM sign-off. **PM-Recommendation deferred: no framework evaluation logic implemented.** | Medium: Binary tooling path resolution may expose additional environment constraints. Tool availability must be verified; no fallback path currently exists. | Medium: Gate enforcement may interact with existing agent handoff logic; affects BAto-Scrum handoff sequencing. Requires testing at BA→Scrum boundary. Lower risk due to gate-logic precedent in baseline. | Revert VIP agent instruction files to prior version; reset Conductor gate config; restart agent orchestration session. Clear any cached task state. Estimated revert time: <15 min. | Test gate implementation in isolated scenario first; use feature flags for selective gate enforcement rollout. Document all VIP instruction changes for easy rollback. |
| REMOPT-B | High | 700–1000 | Full orchestration realignment: Conductor gate implementation (~150L), trigger predicate evaluation (~200L), PM-tool framework logic (~250L), role-boundary enforcement (~100L), instruction alignment (~150L), testing/validation (~150L). Changes span multiple agent-config files, orchestration layer, and output templates; interdependencies require coordinated updates. | Medium–High: Trigger predicate evaluation and framework selection logic are new and unversioned in VIP. PM-tool integration requires evaluation of framework contexts (blockers, stakeholder alignment) which introduce complexity. Fallback to baseline behavior must be assured. | High: Changes distributed across BA, Scrum Master, PM, and Conductor agents. Trigger logic affects multiple handoff points. PM-tool logic is new; integration with existing recommendation pipeline uncertain. Testing matrix required. | Full agent config reset; instruction file rollback to baseline; memory flush (learning-base recovery); Conductor orchestration reset. Requires coordinated rollback script and post-revert validation. Estimated revert time: 30–45 min. | Implement changes in phases: (1) Conductor gates, (2) trigger predicates, (3) PM-tool logic. Gate+trigger testing in isolation before PM-logic integration. Use A/B testing or feature-flag rollout to limit blast radius. |

---

### Step 5: Map acceptance criteria delivery per option

Generate `evidence/phase-4-acceptance-delivery-matrix.md`:

| Option ID | Coordination Domain | Ingestion Domain | Planner-Output Domain | PM-Recommendation Domain | Coverage Summary |
|---|---|---|---|---|---|
| REMOPT-A | ✅ Full: Conductor gates (BAS-GATE-001, 002, 003) enforce handoff sequencing; BA→Scrum→Builder chain re-enabled via gate pre-conditions. | ✅ Full: Path resolution (RC-001) unblocks binary-conversion tooling; gate enforcement (RC-002) surfaces dependency blockers via BAS-CONTRACT-010 checkpoint. | ✅ Full: Schema enforcement (RC-005) via agent instruction updates; BA and Scrum Master output fields aligned to BAS-SCHEMA-001/002/004. | ❌ Deferred: Gate enforcement allows future PM-recommendation logic handoff; instruction clarity improved re: BAS-SCHEMA-003 obligation. However, PM-tool evaluation loop and trigger predicate not implemented; recommendations remain absent. Residual gap: GAP-005 and GAP-006 unresolved; qualify as "ready for PM-logic enhancement" but not operationally active. | 3/4 domains at ✅ Full; 1/4 at ❌ Deferred; all 4 acceptance criteria identified but 1 deferred. |
| REMOPT-B | ✅ Full: All coordination mechanisms (gates, trigger predicates, role boundaries, orchestration sequencing) implemented per baseline; BAS-ROLE-005/006 handoff chain enforced; full Conductor checkpoint compliance. | ✅ Full: Same as REMOPT-A plus RC-004 trigger implementation ensures planning requests route correctly and ingestion state is persisted with explicit handoff signal. | ✅ Full: Same as REMOPT-A. | ✅ Full: RC-003 instruction alignment + RC-004 trigger activation + RC-007 PM-tool logic implementation enable proactive framework recommendation per BAS-SCHEMA-003 and BAS-CONTRACT-010. PM-recommendation output confirmed to activate when risk context present; selection logic operational. | 4/4 domains at ✅ Full; all acceptance criteria fully addressed. Baseline-parity target achieved. |

---

### Step 6: Build remediation decision matrix

Generate `evidence/phase-4-decision-matrix.md` with a side-by-side comparison table and narrative guidance:

**Comparison Table:**

| Attribute | REMOPT-A (Critical-Path Patch) | REMOPT-B (Comprehensive Realignment) |
|---|---|---|
| **Effort** | Moderate (250–350 lines) | High (700–1000 lines) |
| **Risk Level** | Lower | Higher |
| **Timeline** | 2–3 weeks | 4–6 weeks |
| **Coordination Domain** | ✅ Full | ✅ Full |
| **Ingestion Domain** | ✅ Full | ✅ Full |
| **Planner-Output Domain** | ✅ Full | ✅ Full |
| **PM-Recommendation Domain** | ⚠️ Partial | ✅ Full |
| **Baseline Parity** | 75% | 100% |
| **Rollback Complexity** | Low | High |
| **Production Risk** | Lower (additive changes, tested predecessors) | Higher (distributed, novel logic) |
| **Key Trade-off** | Defers PM-tool logic; planner and coordination restored; ingestion unblocked | Full restoration; higher integration risk; requires coordinated multi-agent rollout |

**Narrative Decision Guidance:**

- **Choose REMOPT-A if:**
  - Timeline pressure is acute (2–3 weeks required).
  - Risk tolerance is conservative (prefer additive vs distributed changes).
  - PM-recommendation domain can be deferred to follow-on phase (Phase 6).
  - Ingestion and planner-output unblocking is the immediate business driver.
  
- **Choose REMOPT-B if:**
  - Baseline parity and acceptance-criteria fulfilment are mandatory (no deferred domains).
  - Timeline allows 4–6 weeks for end-to-end implementation and validation.
  - Integration risk can be managed via phased rollout and A/B testing.
  - PM-tool recommendation behavior is a priority for downstream PM-workflow reliability.

---

### Step 7: Trace root causes to remediation and verify coverage

Generate `evidence/phase-4-rc-remediation-traceability.md` with all 7 RC-* entries mapped:

| RC ID | RC Category | Priority | Option ID (Targeted) | Option ID (Deferred) | Traceability Rationale | Phase 5 Workstream |
|---|---|---|---|---|---|---|
| RC-001 | PATH-RESOLUTION | Phase4-Critical | REMOPT-A, REMOPT-B | None | Binary-conversion tooling path failure blocks ingestion (GAP-001, GAP-002). Both options target for immediate resolution. Action: Fix environment-variable binding or tool-wrapper configuration. | Workstream-Ingestion-Path-Fix |
| RC-002 | GATE-MISSING | Phase4-Critical | REMOPT-A, REMOPT-B | None | Conductor checkpoint gates (BAS-GATE-001, 002, 003) not enforced; core blocker for coordination domain (GAP-007) and ingestion state management (GAP-002). Both options include full gate implementation. Action: Inject Conductor gate definitions and enforce pre-conditions. | Workstream-Conductor-Gates |
| RC-003 | CONFIG-DRIFT | Phase4-High | REMOPT-B | REMOPT-A | VIP PM instruction content diverged from baseline (BAS-SCHEMA-003 obligation absent). REMOPT-A defers this as non-blocking for 3/4 acceptance domains. REMOPT-B includes instruction audit and alignment. Action: Align PM instruction with recommendation-block obligation. | Workstream-PM-Instruction-Alignment |
| RC-004 | TRIGGER-MISSING | Phase4-High | REMOPT-B | REMOPT-A | Two trigger conditions absent: (1) BA-to-planning-intent trigger (BAS-TRIG-006 equiv.), (2) risk/governance-context trigger. Both block dynamic logic activation in planning and PM pathways (GAP-004, GAP-005, GAP-006). REMOPT-A defers; REMOPT-B includes full trigger implementation. Action: Define trigger predicates and inject into orchestration layer. | Workstream-Trigger-Predicates |
| RC-005 | FORMAT-CONTRACT | Phase4-Critical | REMOPT-A, REMOPT-B | None | BAS-SCHEMA-001/002/004 field sets absent from VIP planning outputs (GAP-003, GAP-004). Both options include schema-conformance updates to BA and Scrum Master instructions. Action: Add schema field definitions and emission requirements. | Workstream-Schema-Conformance |
| RC-006 | ROLE-BOUNDARY | Phase4-High | REMOPT-B | REMOPT-A | Planning delegation bypassed BA→Scrum Master→Builder chain (GAP-007 coordination violation). REMOPT-A delegates role enforcement to gate logic; REMOPT-B adds explicit role-boundary rules in Conductor. Action: Enforce handoff chain via role-gating. | Workstream-Role-Boundary-Enforcement |
| RC-007 | PM-TOOL-LOGIC | Phase4-High | REMOPT-B | REMOPT-A | PM recommendation evaluation loop absent; qualifying context does not activate framework recommendation (GAP-005, GAP-006). **Initial framework set**: RAID, RACI, Fishbone (3 frameworks). **Context signals to evaluate**: Unresolved blockers, stakeholder-alignment risk, governance gate violations. **Scoring approach**: Binary qualification → recommend applicable framework; if multiple qualify, order by frequency. REMOPT-A defers (gate-ready but no logic); REMOPT-B includes full PM-tool logic implementation. Action: Implement context-evaluation and framework-selection logic. | Workstream-PM-Tool-Logic |

---

### Step 8: Verify gap-to-remediation coverage

Generate `evidence/phase-4-gap-remediation-coverage-log.md` with all 7 GAP-* entries:

| Gap ID | Gap Domain | Root Causes (Links) | Fully Addressed By | Partially Addressed By | Not Addressed | Coverage Status |
|---|---|---|---|---|---|---|
| GAP-001 | ingestion | RC-001, RC-002 | REMOPT-A, REMOPT-B | None | None | ✅ Fully Covered (both options address all linked RCs) |
| GAP-002 | ingestion | RC-001, RC-002 | REMOPT-A, REMOPT-B | None | None | ✅ Fully Covered |
| GAP-003 | planner-output | RC-005, RC-006, RC-002 | REMOPT-A [RC-005, RC-002], REMOPT-B [all 3] | REMOPT-A (RC-006 deferred but gate-enforced implicitly) | None | ✅ Fully Covered in REMOPT-A (gate enforcement substitutes for explicit role logic); ✅ Fully Covered in REMOPT-B |
| GAP-004 | planner-output | RC-005, RC-004 | REMOPT-B | REMOPT-A (RC-005 fully; RC-004 deferred) | None | ⚠️ Partially Covered in REMOPT-A (schema fixed, but trigger-based routing deferred); ✅ Fully Covered in REMOPT-B |
| GAP-005 | pm-recommendation | RC-007, RC-003 | REMOPT-B | REMOPT-A (gate-ready but logic deferred) | None | ⚠️ Partially Covered in REMOPT-A (gate allows future logic, but active evaluation loop absent); ✅ Fully Covered in REMOPT-B |
| GAP-006 | pm-recommendation | RC-007, RC-004 | REMOPT-B | REMOPT-A (gate-ready but logic deferred) | None | ⚠️ Partially Covered in REMOPT-A; ✅ Fully Covered in REMOPT-B |
| GAP-007 | coordination handoffs | RC-002, RC-006 | REMOPT-A [RC-002], REMOPT-B [both] | REMOPT-A (RC-006 deferred but gate-enforced implicitly) | None | ✅ Fully Covered in REMOPT-A (gate enforcement sufficient); ✅ Fully Covered in REMOPT-B |

---

### Step 9: Formulate the remediation recommendation

Generate `evidence/phase-4-recommendation-and-rationale.md`:

**Selected Option: REMOPT-B (Comprehensive Baseline Realignment)**

**Selection Rationale:**

The task acceptance criteria explicitly require restoration of reliable agent coordination, learning-base ingestion, planner-friendly BA output, and PM-tool recommendation behavior. Phase 3 evidence identifies that these four domains are interdependent: coordination gates (RC-002) enable ingestion state management and planner-output handoff; trigger predicates (RC-004) enable both planning routing and PM-recommendation logic activation; and PM-tool logic (RC-007) depends on coordination gates and trigger predicates being enforceable.

REMOPT-A addresses 3 of 4 domains fully and leaves the PM-recommendation domain in a "gate-ready but logic-absent" state. This creates a residual operational risk: the PM agent will not proactively recommend frameworks even when context signals (unresolved blockers, stakeholder alignment risk) are present. This violates the task acceptance criterion ("PM agents proactively recommend...where context supports it") and leaves the PM workflow less reliable than the baseline.

REMOPT-B addresses all 4 domains at ✅ Full coverage and achieves baseline-parity status. The higher effort (700–1000 lines vs 250–350) and longer timeline (4–6 weeks vs 2–3) are justified because:

1. **Acceptance criteria are non-negotiable**: The task goal is "restore reliable multi-agent coordination...ensure PM workflow outputs are operationally useful." REMOPT-B delivers that; REMOPT-A leaves a gap.

2. **Phase 3 evidence demonstrates that all 7 RCs are active blockers**: Each RC is traced to at least one acceptance domain. Deferring any RC (as REMOPT-A does with RC-003, RC-004, RC-006, RC-007) creates technical debt and makes the PM workflow partially dependent on external manual intervention.

3. **Baseline-parity goal is achievable**: The baseline successfully implements all 7 root-cause categories. REMOPT-B replicates that alignment. REMOPT-A does not.

4. **Risk can be managed via phased implementation**: REMOPT-B should be decomposed in Phase 5 into sequenced workstreams with intermediate validation gates (gates first, then triggers, then PM-logic). This limits blast radius and enables rollback at logical boundaries.

**Expected Outcome (Post-Implementation):**

- **Coordination domain**: Full Conductor gate enforcement at task-init (BAS-GATE-001), plan-review (BAS-GATE-002), and implementation-start (BAS-GATE-003) checkpoints. BA→Scrum Master→Builder handoff chain fully operational with explicit user-facing pauses. GAP-007 resolved.

- **Ingestion domain**: Binary-conversion tooling path operational (RC-001 fixed); unresolved dependencies surfaced as blockers at BAS-CONTRACT-010 checkpoints (RC-002 gates enforce). ProjectOwner writes persisted with explicit state transitions. GAP-001 and GAP-002 resolved.

- **Planner-output domain**: BA and Scrum Master outputs conform to BAS-SCHEMA-001/002/004 field sets; planner-import capability confirmed end-to-end. BA-to-planning routing via trigger predicate (RC-004) ensures explicit handoff path. GAP-003 and GAP-004 resolved.

- **PM-recommendation domain**: PM agent evaluates context conditions (blockers, stakeholder signals) and selects applicable PM framework (RAID, RACI, Fishbone, DACI/RAPID, stakeholder analysis, charter) per BAS-SCHEMA-003. Recommendation block emitted proactively when context qualifies. GAP-005 and GAP-006 resolved.

**Residual Risk:**

- **Integration edge cases**: Cross-agent handoff sequencing (especially BA→Scrum→Builder) may have unanticipated interaction patterns when trigger predicates and gates are live simultaneously. Mitigation: Phase 5 implementation plan includes cross-handoff scenario testing.

- **PM-tool framework context evaluation**: New logic to classify blockers, stakeholder signals, and governance conditions as qualifying contexts. Initial implementation may miss edge cases. Mitigation: Start with conservative evaluation rules; expand coverage in Phase 6 based on real-world usage patterns.

- **Rollback complexity**: Distributed changes require coordinated rollback. Mitigation: Phase 5 must include detailed rollback runbook and feature-flag controls for selective rollback.

**Implementation Readiness Check:**

- ✅ Binary-conversion tooling path: Environment variable access confirmed in Phase 1 evidence; fallback executable resolution protocol definable.
- ✅ Conductor gate framework: Baseline implementation exists and is proven; VIP requires injection of gate definitions and sequencing logic, both well-understood patterns.
- ✅ Trigger predicate evaluation: Similar to existing agent-routing conditions in baseline; logic signature known and implementable.
- ✅ PM-tool framework selection: Baseline includes framework recommendations in documentation; logic structure known; requires instruction-prompt augmentation and output-template definition.
- ✅ No critical path blockers identified for REMOPT-B implementation.

---

### Expected Phase 5 Workstreams (from Phase 4 RC Assignments)

The following workstreams are derived from the RC-remediation-traceability map and represent the implementation activities for Phase 5:

1. **Workstream-Ingestion-Path-Fix** — Resolve binary-conversion tooling path failure; fix environment-variable binding or tool-wrapper configuration (RC-001)
2. **Workstream-Conductor-Gates** — Implement Conductor checkpoint gates (BAS-GATE-001, BAS-GATE-002, BAS-GATE-003) with enforced pre-conditions (RC-002)
3. **Workstream-Schema-Conformance** — Add BAS-SCHEMA-001/002/004 field definitions and emission requirements to BA and Scrum Master agent instructions (RC-005)
4. **Workstream-PM-Instruction-Alignment** — Audit and align VIP PM instruction content with baseline; restore BAS-SCHEMA-003 recommendation-block obligation (RC-003, deferred in REMOPT-A; included in REMOPT-B)
5. **Workstream-Trigger-Predicates** — Define and inject trigger predicates for BA-to-planning-intent routing and risk/governance-context evaluation (RC-004, included in REMOPT-B)
6. **Workstream-Role-Boundary-Enforcement** — Enforce BA→Scrum Master→Builder handoff chain via role-gating in Conductor (RC-006, deferred in REMOPT-A; included in REMOPT-B)
7. **Workstream-PM-Tool-Logic** — Implement PM framework selection logic with context-evaluation loop (blocking conditions, stakeholder-alignment signals, governance violations); activate proactive recommendations per BAS-SCHEMA-003 (RC-007, deferred in REMOPT-A; included in REMOPT-B)

**For REMOPT-A implementation**: Workstreams 1–3 are required; workstreams 4–7 are deferred to Phase 6.

**For REMOPT-B implementation**: All 7 workstreams are required and should be sequenced in Phase 5 as:
  - Phase 5a: Workstreams 1–2 (Ingestion path + Conductor gates)
  - Phase 5b: Workstreams 3, 6 (Schema + Role boundaries)
  - Phase 5c: Workstreams 4, 5, 7 (PM instruction, triggers, PM-tool logic)

---

Update `.tasks/001-pm-agent-gap-analysis/task.md` Phase 4 row:
- Status → `📋 Planned`
- Plan column → `[phase-4-remediation-options-and-decision-package.md](plan/phase-4-remediation-options-and-decision-package.md)`

---

## Tests

This phase is analysis and recommendation only; no production behavior changes are implemented.

- **TEST-1 (Root-cause grouping completeness)**: Every RC-* entry (001–007) must appear in exactly one option's "Targeted" or "Deferred" column.
- **TEST-2 (Gap coverage)**: Every GAP-* entry (001–007) must show coverage status of either ✅ or ⚠️; no ❌ gaps in recommended option.
- **TEST-3 (Effort consistency)**: Effort estimates must be correlated to line counts and complexity rationale; no value estimates without supporting detail.
- **TEST-4 (Risk-mitigation pairing)**: Every identified technical and integration risk must have a corresponding mitigation strategy in the effort-risk matrix.
- **TEST-5 (Acceptance criterion mapping)**: All 4 acceptance domains from task.md must appear in every option's acceptance-delivery matrix with explicit coverage ratings (✅/⚠️/❌).
- **TEST-6 (Recommendation rationale traceability)**: Final recommendation must cite at least one Phase 3 finding and at least one acceptance criterion to justify option selection.
- **TEST-7 (No placeholders)**: No required field in any table row contains `TBD`, `TODO`, `N/A`, or `placeholder` as its sole value.

---

## Success Criteria

- **SC-1**: Seven Phase 4 evidence files created under `.tasks/001-pm-agent-gap-analysis/evidence/`:
  - `phase-4-remediation-option-scopes.md`
  - `phase-4-effort-risk-matrix.md`
  - `phase-4-acceptance-delivery-matrix.md`
  - `phase-4-decision-matrix.md`
  - `phase-4-rc-remediation-traceability.md`
  - `phase-4-gap-remediation-coverage-log.md`
  - `phase-4-recommendation-and-rationale.md`

- **SC-2**: All 7 root causes (RC-001 through RC-007) are assigned to at least one remediation option (both targeted and deferred roles explicitly accounted for).

- **SC-3**: At least 2 remediation options (REMOPT-A and REMOPT-B) are defined with distinct scope, risk, and tradeoff profiles.

- **SC-4**: Recommended option achieves `✅ Full` coverage on all 4 acceptance domains (coordination, ingestion, planner-output, pm-recommendation) OR explicitly documents residual gaps and their resolution path.

- **SC-5**: All 7 gaps (GAP-001 through GAP-007) are mapped to remediation coverage with status ✅ or ⚠️ (no ❌ unresolved gaps in recommended option).

- **SC-6**: Effort, risk, and rollback strategy estimates are substantive and grounded in concrete implementation detail (not placeholder language).

- **SC-7**: Final recommendation includes explicit rationale tied to task acceptance criteria and Phase 3 evidence.

- **SC-8**: `task.md` shows Phase 4 as `📋 Planned` with valid plan link.

---

## Verification

### Automated Checks

- **Verify-SC1**: Count evidence files in `evidence/phase-4-*` directory; confirm ≥7 files present.
- **Verify-SC2**: Grep all evidence files for RC-001 through RC-007; confirm each appears exactly once in an Option ID column (Targeted or Deferred).
- **Verify-SC3**: Count REMOPT-* rows in phase-4-remediation-option-scopes.md; confirm ≥2 options defined.
- **Verify-SC4**: Count ✅ symbols in phase-4-acceptance-delivery-matrix.md for recommended option; confirm all 4 domains show ✅ or are documented in phase-4-recommendation-and-rationale.md as deferred with explicit resolution path.
- **Verify-SC5**: Count rows in phase-4-gap-remediation-coverage-log.md with coverage status ✅ or ⚠️; confirm 7/7 gaps mapped for recommended option (no ❌ unresolved).
- **Verify-SC6**: Search phase-4-effort-risk-matrix.md for placeholders (`TBD`, `TODO`, `N/A`); confirm zero instances in Effort Category, Risk, or Mitigation columns.
- **Verify-SC7**: Search phase-4-recommendation-and-rationale.md for citations to Phase 3 evidence and task.md acceptance criteria; confirm ≥1 citation per criterion.
- **Verify-SC8**: Grep task.md Phase 4 row; confirm status = `📋 Planned` and Plan column contains valid markdown link.

### Manual Verification Steps

1. **Option comparison review**: Read phase-4-decision-matrix.md; confirm that narrative guidance ("Choose REMOPT-A if..." and "Choose REMOPT-B if...") aligns with the tradeoff claims (effort, risk, timeline, domain coverage).

2. **Remediation traceability spot-check**: Pick 2 random RC-* entries from phase-4-rc-remediation-traceability.md; verify that the traceability rationale cites specific GAP-* rows and that those gap-to-rc links appear in phase-3-gap-rc-links.md.

3. **Gap coverage validation**: Pick 2 random GAP-* entries from phase-4-gap-remediation-coverage-log.md; verify that the "Root Causes (Links)" column cites an RC-* that appears in phase-3-root-cause-catalog.md.

4. **Recommendation rationale audit**: Read phase-4-recommendation-and-rationale.md "Selection Rationale" section; confirm that the recommendation:
   - Explicitly states which option is selected (e.g., "REMOPT-B").
   - Provides at least 2 reasons tied to task acceptance criteria or Phase 3 evidence.
   - Includes expected outcomes per acceptance domain.
   - Documents residual risk and resolution path.

### Success Validation

All automated checks pass AND all manual steps confirm substantive analysis output with no placeholder content OR unresolved gaps.

---

## Risks and Assumptions

- **RISK-1**: Remediation option grouping may conflate unrelated root causes or miss legitimate option variants.
  - Mitigation: Use Phase 3 link-based traceability to validate that each gap is addressed by at least one option; iterate if coverage is incomplete.

- **RISK-2**: Effort estimates may be inaccurate if VIP environment contains unanticipated tooling or path constraints.
  - Mitigation: Phase 5 implementation plan refines effort estimates with actual code-level detail; Phase 4 estimates are order-of-magnitude guidance.

- **RISK-3**: The recommended option may not align with stakeholder timeline or risk tolerance constraints if those are not explicitly documented in the task scope.
  - Mitigation: Phase 4 recommendation includes decision criteria ("Choose REMOPT-A if timeline is X..."). Stakeholder feedback before Phase 5 can override recommendation if justified.

- **ASSUMPTION-1**: Phase 3 root-cause catalog is complete and traces all observed gaps to root causes.
- **ASSUMPTION-2**: Remediation options are not required to introduce new acceptance criteria; they address existing task.md criteria only.
- **ASSUMPTION-3**: Implementation effort estimates assume standard coding practices and available development resources; no resource scarcity is factored.
- **ASSUMPTION-4**: This phase does not execute any remediation; it creates only analysis and recommendation artifacts.

---

## Tests

This phase is analysis and documentation only; no production behavior changes are implemented. See Success Criteria and Verification sections above for full test and validation matrix.
