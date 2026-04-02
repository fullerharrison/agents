# Phase 2 Baseline Source Index

Baseline access check: direct read access to C:/Users/s1058662/repos/agents was successful on 2026-03-19.

## ID Conventions

- BAS-SRC-* = baseline source provenance entries
- BAS-CONTRACT-* = orchestration handoff contracts
- BAS-TRIG-* = transition trigger predicates and guards
- BAS-ROLE-* = role boundary obligations
- BAS-MEM-* = persistence and write path contracts
- BAS-SCHEMA-* = output schema and formatting contracts
- BAS-GATE-* = conductor checkpoint gates
- BAS-XREF-* = Phase 1 to baseline crosswalk entries

## Provenance Rules

- Baseline Path is fixed to C:/Users/s1058662/repos/agents.
- Relative File Path is the path under baseline root.
- Captured Timestamp is UTC capture time of source metadata.
- Immutable Identifier is SHA-256 file hash.
- Relevance Tags use: coordination, ingestion, planner, pm-recommendation.

| Source ID | Baseline Path | Relative File Path | Captured Timestamp (UTC) | Immutable Identifier | Inclusion Rationale | Relevance Tags |
|---|---|---|---|---|---|---|
| BAS-SRC-001 | C:/Users/s1058662/repos/agents | generated/copilot/agents/conductor.agent.md | 2026-03-18T04:08:04Z | 7C5ED77761D38C5755F445C49713D1DC70F87F828B67740E3DED4F2C7F5CE6E6 | Primary orchestration state machine and checkpoint contract source. | coordination |
| BAS-SRC-002 | C:/Users/s1058662/repos/agents | generated/copilot/agents/explorer.agent.md | 2026-03-18T04:08:04Z | 23649DBD0574133D646743648AEE542D2857847FA43BD703F376DC8FA470194D | Defines task planning writes and phase state transitions in .tasks lifecycle. | coordination, ingestion |
| BAS-SRC-003 | C:/Users/s1058662/repos/agents | generated/copilot/agents/builder.agent.md | 2026-03-18T04:08:04Z | 23E7624625287A1A02B45EDD0067261AF4CD0C06F49BE5A57F7F9F7D0119686B | Defines implementation execution, phase-state progression, and save-progress behavior. | coordination |
| BAS-SRC-004 | C:/Users/s1058662/repos/agents | generated/copilot/agents/reviewer.agent.md | 2026-03-18T04:08:04Z | F8B197362FA4C2E7D199DFD83AFC2416D9717C537776B19F2E79A62C4DF6935C | Defines verification obligations before a phase is accepted as complete. | coordination, planner |
| BAS-SRC-005 | C:/Users/s1058662/repos/agents | templates/agents/business-analyst.template.md | 2026-03-18T10:35:56Z | 564BD3BB4B45EC74A97E25CB59DD293A28C6510642078E2CAF1B22FCD6814D1D | Defines BA output ownership, handoff to planning role, and save locations including learning base paths. | ingestion, planner |
| BAS-SRC-006 | C:/Users/s1058662/repos/agents | templates/agents/scrum-master.template.md | 2026-03-18T10:35:56Z | 4B853AB434E5DAC2024300DB73DD295BB3AFD12EEAA7604320F2D67E22C1F21E | Defines sprint/implementation planning outputs, save locations, and builder handoff trigger phrases. | coordination, planner |
| BAS-SRC-007 | C:/Users/s1058662/repos/agents | templates/skills/breakdown-plan/SKILL.template.md | 2026-03-18T09:44:47Z | FF94D87ABD1EEABBC4807EC6E0BE1E353DDA2CB1A9F88CF8B19B7284E70D21A6 | Defines structured planning output schema including project plan, issue checklist, risk, dependencies, and sprint template sections. | planner, pm-recommendation |
| BAS-SRC-008 | C:/Users/s1058662/repos/agents | templates/skills/breakdown-epic-pm/SKILL.template.md | 2026-03-18T09:44:47Z | 3218C730B5E4D73D15A4DD9A538511E81A0EAFB7B6C44A38B3EB2D4BC4A43CDE | Defines PM epic PRD schema and stakeholder context requirements. | planner, pm-recommendation |
| BAS-SRC-009 | C:/Users/s1058662/repos/agents | templates/skills/prd/SKILL.template.md | 2026-03-18T09:44:47Z | 08806815BF7CE8D93E8DCF283DBE731E512029D31B5451DE68076F951AB396F5 | Defines strict PRD output sections with risks and measurable success criteria. | planner, pm-recommendation |
| BAS-SRC-010 | C:/Users/s1058662/repos/agents | AGENTS.md | 2026-03-18T02:44:34Z | 0161F3F965F926F94FE069EC14F04BBAAA4A0EA963073131A6D9DDC3E5C4B34F | Documents canonical orchestrated workflow and role sequencing (Explorer -> Builder -> Reviewer -> Committer). | coordination |
| BAS-SRC-011 | C:/Users/s1058662/repos/agents | README.md | 2026-03-18T10:58:52Z | 5DE3CEE587B1E5A7F075E505C93A8FA1AE7F24BE64BEEF66B3009D2B37E8107E | Documents role responsibilities and handoff model for user-facing baseline behavior. | coordination |

## Scan Notes

- Token scan over BAS-SRC-005 through BAS-SRC-009 found strong coverage for planning, risk assessment, and stakeholder context, but no explicit canonical list of framework names (for example RACI, RAID, or DACI) in baseline template text.
- PM-framework recommendation obligations in Phase 2 schema are therefore captured as baseline-implicit from risk/stakeholder requirements plus trigger context in planning skills.