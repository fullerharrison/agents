# Phase 2 Output Schema and Formatting Contracts

| Schema ID | Output Domain | Required Fields | Failure Signal Criteria | Evidence Source |
|---|---|---|---|---|
| BAS-SCHEMA-001 | Planner-ready project plan artifact | project overview summary; success criteria; milestones; risk assessment; hierarchy graph (epic-feature-story/enabler-test-task); issue breakdown with labels/milestones/DoD; priority matrix; dependency map; sprint planning template; board configuration guidance. | Missing one or more mandatory plan sections prevents downstream planning import or execution tracking consistency. | BAS-SRC-007 |
| BAS-SCHEMA-002 | Planner-ready issue checklist artifact | pre-creation checks; epic-level checks; feature-level checks; story/enabler-level checks; completion criteria references. | Checklist omits level-specific checks or does not map to hierarchy levels required by planning workflow. | BAS-SRC-007 |
| BAS-SCHEMA-003 | PM recommendation block for risk-governance context | recommendation title; trigger rationale tied to observed risk or stakeholder complexity; selected framework category; expected application timing; expected decision output artifact. | Response contains risk or stakeholder concerns but no explicit recommendation block or no rationale-to-context link. | BAS-SRC-007, BAS-SRC-008, BAS-SRC-009 |
| BAS-SCHEMA-004 | BA requirement output package | document type declaration; scope and goals; role-specific user context; acceptance criteria; saved location link. | BA output lacks save-target alignment or omits acceptance-level requirement details needed for planning handoff. | BAS-SRC-005, BAS-SRC-009 |

## PM Recommendation Contract Notes

- Baseline templates explicitly require risk assessment and stakeholder-context handling.
- Baseline templates do not prescribe a fixed named-framework list string; recommendation formatting above is normalized from those baseline obligations so Phase 3 can compare whether recommendation behavior appears at all when risk-governance context is present.
