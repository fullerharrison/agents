# Cascade Review — 2026-04-02: VoC-008 + VoC-009 Mural Screen Feedback

## Source Documents

- `learning_base/11_voice_of_customer/voc_008_mural_review_mar30_screen_feedback.md` (NEW)
- `learning_base/11_voice_of_customer/voc_009_mural_review_apr04_screen_feedback.md` (NEW)
- `learning_base/05_technical_specs/05_5_mobile_app_screens_figma_make_v3.md` (NEW)

## Change Type: Major

Two new VoC records introducing 20 feature requests (8 from VoC-008, 12 from VoC-009), 9 pain points, 2 blockers, and a scope-affecting decision (weight entry in-app vs EzCapture/Phenome).

---

## Cascade Impact Summary

Per `REVIEW_WORKFLOW.md` dependency matrix, VoC changes cascade to:
- `02_requirements/` — New requirements
- `01_project_overview/` — Scope changes
- `12_roadblocks/` — New blockers

Additionally, `05_technical_specs/` changes cascade to:
- `06_implementation/` — Implementation guides
- `07_testing/` — Test strategies

---

## Document Status

| Document | Status | Action Needed |
|----------|--------|---------------|
| `02_requirements/02_1_requirements_matrix_summary.md` | 🔴 REVIEW NEEDED | Add 15+ new requirements from VoC-008 FR1-FR8 and VoC-009 FR1-FR12. Key additions: trial QR initiation, delete-after-upload, QR-per-row weight entry, LOCSL location filter, real-time plot ID, Excel export format. |
| `01_project_overview/` | 🟡 REVIEW NEEDED | SPIRIT integration scope is expanding (LOCSL location filter, EPPYCap workflow naming). Weight entry may be removed from MVP if Quentin's concern (VoC-008 FR8) prevails. |
| `05_technical_specs/screen_inventory_one_pager_prototypeSession.md` | 🔴 REVIEW NEEDED | Major updates: S1/S2 (username/PW, user-specific trials), S3 (LOCSL filter, consolidated screen, EPPYCap naming), S4 (temp indicator, real-time plot ID, remove zoom, audio cues), S6/S7 (delete-after-upload, WiFi-first, Excel export), S9 (QR-per-row, max 30, kg) |
| `05_technical_specs/guardrails_one_pager_prototypeSession.md` | 🟡 REVIEW NEEDED | Add: delete-after-upload guardrail, trial/plot count separation rule, audio notification for non-English operators, LOCSL metadata integrity |
| `04_data_models/` | 🟡 REVIEW NEEDED | Add weight entry export schema (TRIALID, BARCD, PLOTID, WEIGHT_1) per Roy's specification |
| `12_roadblocks/` | 🔴 REVIEW NEEDED | New: (1) Weight entry duplication with EzCapture/Phenome — decision needed by 2026-04-07. (2) User-specific trial filtering complexity — creator ID may not always be accurate per Roy. |
| `diagrams/current_protocols_workflow.md` | 🟡 REVIEW NEEDED | Workflow terminology change: "Physiological Stage" → "Workflow" |
| `06_implementation/` | ⚪ No change needed | Pending requirements cascade completion |
| `07_testing/` | ⚪ No change needed | Pending requirements cascade completion |

---

## Key Decisions Required

| Decision | Stakeholders | Deadline | Impact |
|----------|-------------|----------|--------|
| **Weight entry scope**: Keep in-app (spec per Roy) or defer to EzCapture/Phenome (per Quentin)? | ProductOwner, Quentin, Roy, Soumitra | 2026-04-07 | Affects S9/S10 design, data model, and testing scope |
| **User-specific trial filtering logic**: Filter by creator ID (may not be accurate) or by assignment? | ProductOwner, Roy, Architect | 2026-04-07 | Affects home screen data queries and SPIRIT integration |
| **Regional language timeline**: Backlog for Phase 2 or Phase 3? | ProductOwner, Ramón | 2026-04-14 | Affects MoSCoW prioritization |

---

## Diagrams Flagged for Update

| Changed Content | Diagram(s) to Update |
|-----------------|---------------------|
| Workflow terminology ("Physiological Stage" → "Workflow") | `diagrams/current_protocols_workflow.md` — any Mermaid blocks referencing this term |
| Screen flow changes (consolidated trial selection, weight entry scope) | Screen inventory diagrams in `05_technical_specs/` |
| Weight entry data model (TRIALID, BARCD, PLOTID, WEIGHT_1) | `diagrams/data_model_erd.md` — weight export entity |

---

## Cascade Review Checklist

**Document Updated:** VoC-008, VoC-009, 05_5_mobile_app_screens_figma_make_v3.md
**Change Type:** Major
**Changed By:** ProductOwner Agent

### Downstream Review
- [x] Identified all downstream dependencies
- [x] Reviewed each dependent document (status assessed)
- [ ] Updated affected sections (**→ Delegate to BusinessAnalyst**)
- [x] Added REVIEW NEEDED flags for deferred updates

### Diagrams
- [ ] System architecture diagram current (no change expected)
- [ ] ERD diagrams reflect data model (**→ weight export schema needed**)
- [ ] Roadmap/Gantt reflects timeline (no change expected)

### Validation
- [ ] No broken internal links (**→ verify after BA updates**)
- [ ] Terminology consistent across documents (**→ "Workflow" rename pending**)
- [ ] Version/date updated in document headers (**→ after BA updates**)

### Changelog
- [x] Entry added to REVIEW_WORKFLOW.md CHANGELOG

---

## Handoff → BusinessAnalyst

**Delegate**: "Incorporate VoC-008 and VoC-009 requirements into `02_requirements/02_1_requirements_matrix_summary.md` and dependent specs. Verify no secondary impacts. Prioritize the weight entry scope decision — schedule stakeholder alignment by 2026-04-07."

**Input provided**:
- VoC-008: 8 feature requests, 4 pain points, guardrail mappings
- VoC-009: 12 feature requests, 5 pain points, guardrail mappings
- 3 open decisions requiring stakeholder input

**Expected completion**: CP-C2 (requirements updated) and CP-C3 (secondary impacts checked) by 2026-04-07.

---

## Handoff → ProjectManager

**Escalation**: CP-C4 (stakeholder approval) needed for:
1. Weight entry scope decision (keep vs defer)
2. User-specific trial filtering approach
3. Regional language phase placement
