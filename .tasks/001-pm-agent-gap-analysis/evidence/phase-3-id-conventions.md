# Phase 3 ID Conventions

## Identifier Namespaces

| Prefix | Example | Scope | Used In |
|---|---|---|---|
| `GAP-` | GAP-001 | Single contract gap row | phase-3-gap-register.md |
| `RC-` | RC-001 | Root-cause record | phase-3-root-cause-catalog.md |
| `LINK-` | LINK-001 | Gap-to-root-cause mapping row | phase-3-gap-rc-links.md |
| `PHASE3-BLOCK-` | PHASE3-BLOCK-001 | Dependency-blocker record | phase-3-dependency-blockers.md |
| `COV-` | COV-001 | Acceptance-domain coverage row | phase-3-coverage-summary.md |

IDs are zero-padded to three digits within each namespace and are never reused or reordered once assigned.

---

## Root-Cause Category Vocabulary

| Category Code | Description |
|---|---|
| `CONFIG-DRIFT` | VIP instruction, skill, or prompt content diverged from baseline without a compensating change |
| `TRIGGER-MISSING` | A trigger condition or entry predicate from BAS-TRIG-* is absent or incorrectly specified in the VIP environment |
| `PATH-RESOLUTION` | A file path, memory-write target, or environment variable mismatch prevents expected VIP behavior |
| `FORMAT-CONTRACT` | A schema or template obligation from BAS-SCHEMA-* is missing, incomplete, or structurally incompatible in the VIP output |
| `PM-TOOL-LOGIC` | PM framework recommendation logic is absent, incomplete, or fails to activate under qualifying context in VIP |
| `ROLE-BOUNDARY` | VIP agent executes prohibited actions or omits required obligations per BAS-ROLE-* |
| `GATE-MISSING` | A Conductor checkpoint or progression gate from BAS-GATE-* is absent or not enforced in VIP |

---

## Severity Scale

| Severity | Meaning |
|---|---|
| `Critical` | Gap directly blocks an acceptance domain; the domain cannot pass without remediation |
| `High` | Gap materially degrades output quality or reliability across multiple runs |
| `Medium` | Gap degrades reliability or decision-support quality but does not fully block the domain |

---

## Confidence Scale

| Confidence | Meaning |
|---|---|
| `High` | Delta is directly traceable to specific lines or fields in captured Phase 1 artifact evidence |
| `Medium` | Delta is inferred from surrounding evidence patterns; specific field or line confirmation would require further access |
| `Low` | VIP artifacts partially inaccessible or runtime-only behavior; static comparison insufficient to confirm delta with certainty |

---

## Scope of this Phase

- Phase 3 is analysis-only: no VIP or baseline files are modified.
- Root-cause classification uses static artifact comparison; runtime re-execution is out of scope.
- Phase 3 does not propose fixes; those belong to Phase 4.
- `NOT-OBSERVED` is a valid root-cause status for any of the seven category codes, and must appear explicitly if a category is confirmed absent from the evidence.
