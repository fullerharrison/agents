---
name: estimation
description: "Complexity analysis and effort estimation. Use when sizing work, estimating effort, assessing complexity, or deciding how to decompose tasks. Triggers on: 'use estimation mode', 'estimate this', 'how big is this', 'how long will this take', 'size this', 'complexity', 't-shirt size', 'effort'. Read-only mode — analyzes but doesn't modify."
---

# Estimation

Assess complexity and effort. Produce calibrated estimates, not guesses.

> "The cone of uncertainty narrows as you learn more. Early estimates are ranges, not commitments."

## Core Principle

Estimates are communication tools, not contracts. A good estimate communicates:
1. **Expected effort** — how much work is involved
2. **Uncertainty** — how confident you are
3. **Risks** — what could make it take longer
4. **Assumptions** — what must be true for the estimate to hold

## T-Shirt Sizing Framework

| Size | Complexity | Typical Scope | Phase Count |
| --- | --- | --- | --- |
| **XS** | Trivial — single file, well-understood | Config change, copy fix, simple bug fix | 1 |
| **S** | Low — follows existing patterns | Single feature, known approach, limited scope | 1–2 |
| **M** | Moderate — some unknowns | Multi-file feature, new pattern needed, integration work | 2–3 |
| **L** | High — significant unknowns | Cross-cutting feature, new subsystem, significant refactor | 3–5 |
| **XL** | Very high — research required | Architecture change, new technology, data migration | 5+ |

### Sizing Decision Tree

```
Can you describe the exact files and changes needed?
├─ Yes → Do you need to change more than 3 files?
│        ├─ No → Does it follow an existing pattern exactly?
│        │        ├─ Yes → XS
│        │        └─ No → S
│        └─ Yes → Do any changes require new patterns or abstractions?
│                 ├─ No → S or M
│                 └─ Yes → M or L
└─ No → Do you know which subsystem is affected?
         ├─ Yes → Are there unknowns you can list specifically?
         │        ├─ Yes (< 3 unknowns) → M
         │        └─ Yes (3+ unknowns) → L
         └─ No → XL (research needed first)
```

## Complexity Factor Checklist

Score each factor. Any "High" factor pulls the estimate up by one size.

| Factor | Low | Medium | High |
| --- | --- | --- | --- |
| **Code familiarity** | Well-known area | Touched before | Never seen this code |
| **Pattern novelty** | Follows existing pattern | Adapts existing pattern | New pattern needed |
| **Integration points** | 0–1 external touchpoints | 2–3 touchpoints | 4+ touchpoints |
| **Test coverage** | Well-tested area | Some tests exist | No tests / need new framework |
| **State complexity** | Stateless or simple | Local state | Shared/distributed state |
| **Data changes** | No schema changes | Additive schema change | Migration required |
| **Dependencies** | No external deps | Stable external deps | Unstable / new external deps |

## Risk Multipliers

Apply after base sizing. Multipliers stack (multiply together), capped at 4x.

| Factor | Multiplier | Applies When |
| --- | --- | --- |
| **Unfamiliar technology** | 2x | First time using this stack/library/tool |
| **No existing tests** | 1.5x | Area lacks test coverage, need to build test infrastructure |
| **Shared/global state** | 1.5x | Changes affect multiple consumers or global state |
| **External dependencies** | 2x | Relies on 3rd-party APIs, services, or approval processes |
| **Data migration** | 2x | Must transform or move existing production data |
| **Concurrent access** | 1.5x | Multiple users/processes access the same resource |
| **Security sensitivity** | 1.5x | Auth, crypto, PII, financial data involved |

**Cap rule**: If multiplied risk exceeds 4x, the item should be decomposed further rather than estimated as a single unit.

## Estimation Report Format

```markdown
## Estimation: [Title]

### Base Assessment
- **Size**: [XS|S|M|L|XL]
- **Phases**: ~[N] phases estimated

### Complexity Factors
| Factor | Level | Notes |
|--------|-------|-------|
| Code familiarity | [Low/Med/High] | [specific context] |
| Pattern novelty | [Low/Med/High] | [specific context] |
| Integration points | [Low/Med/High] | [N] touchpoints: [list] |
| Test coverage | [Low/Med/High] | [specific context] |
| [other relevant] | [Low/Med/High] | [specific context] |

### Risk Multipliers
| Factor | Multiplier | Rationale |
|--------|-----------|-----------|
| [factor] | [Nx] | [why this applies] |
| **Combined** | **[Nx]** | |

### Adjusted Estimate
- **Base size**: [size]
- **After risk**: [adjusted size]
- **Confidence**: [Low|Medium|High] — [what would increase confidence]

### Assumptions
- [What must be true for this estimate to hold]
- [Another assumption]

### Unknowns
- [What you don't know that could change the estimate]
- [Research needed to reduce uncertainty]
```

## Estimation Anti-Patterns

| ❌ Anti-Pattern | ✅ Do Instead |
| --- | --- |
| Single point estimate ("2 days") | Range with confidence ("S–M, 80% confidence") |
| Padding silently (doubling without saying) | Call out risks explicitly with multipliers |
| Anchoring on first impression | Walk the complexity checklist systematically |
| Ignoring testing effort | Testing is part of the work — include it in size |
| Estimating without seeing the code | Read the affected areas before sizing |
| "Same as last time" | Every context is different — check the factors |
| Estimating a whole epic as one number | Decompose first, then sum the parts |

## Calibration

When estimating, compare against completed tasks:

1. Check `.tasks/` for similar completed work
2. How many phases did it actually take?
3. Were there surprises? (risk factors you missed)
4. Use completed work to calibrate future estimates

**The cone of uncertainty**: Early estimates (before code research) should be expressed as ranges. After Explorer research, estimates should narrow significantly. If they don't narrow, there are still too many unknowns — research more before estimating.
