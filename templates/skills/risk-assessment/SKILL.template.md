---
name: risk-assessment
description: "Risk identification, probability/impact analysis, and mitigation planning. Use when evaluating risks for a project, feature, or technical decision. Triggers on: 'use risk-assessment mode', 'risk assessment', 'what are the risks', 'risk analysis', 'mitigation', 'what could go wrong', 'risk register'. Read-only mode — identifies and classifies risks but doesn't fix them."

cc:
  context: fork
  allowed-tools: [Read, Grep, Glob, LSP]
---

# Risk Assessment

Identify risks before they become problems. Classify, score, and plan mitigations.

> "Risk management is project management for adults." — Tim Lister

## Core Principle

Every technical decision carries risk. The goal isn't to eliminate risk — it's to:
1. **See it clearly** — identify risks before they surprise you
2. **Score it honestly** — probability × impact, not gut feel
3. **Mitigate deliberately** — choose a strategy and verify it works
4. **Accept explicitly** — if you accept a risk, document why

## Risk Identification Checklist

Systematically scan each category. Don't stop at the first risk you find.

### Technical Risks
- [ ] **Complexity**: Is the solution more complex than necessary?
- [ ] **Novelty**: Are we using technology we haven't used before?
- [ ] **Performance**: Could this degrade under load?
- [ ] **Scalability**: Does this approach work at 10x? 100x?
- [ ] **Technical debt**: Are we taking shortcuts that will cost later?

### Integration Risks
- [ ] **API compatibility**: Do external APIs match our assumptions?
- [ ] **Data format**: Do systems agree on data shape and encoding?
- [ ] **Version compatibility**: Do dependency versions align?
- [ ] **Migration**: Does existing data need transformation?
- [ ] **Backwards compatibility**: Does this break existing consumers?

### Dependency Risks
- [ ] **External services**: Do we rely on third-party uptime?
- [ ] **Library stability**: Are dependencies actively maintained?
- [ ] **Approval processes**: Do we need sign-off from others?
- [ ] **Shared resources**: Are we competing for shared infrastructure?
- [ ] **Supply chain**: Could a dependency introduce vulnerabilities?

### Data Risks
- [ ] **Data loss**: Could this destroy or corrupt data?
- [ ] **Data consistency**: Can race conditions create inconsistency?
- [ ] **Privacy**: Does this expose PII or sensitive data?
- [ ] **Volume**: Can storage and processing handle the data volume?
- [ ] **Backup/Recovery**: Can we recover if something goes wrong?

### Security Risks
- [ ] **Authentication**: Are identity checks in the right places?
- [ ] **Authorization**: Are permission checks comprehensive?
- [ ] **Input validation**: Is untrusted input sanitized?
- [ ] **Secrets management**: Are credentials properly protected?
- [ ] **Attack surface**: Does this change introduce new entry points?

### Operational Risks
- [ ] **Monitoring**: Will we know if this breaks in production?
- [ ] **Rollback**: Can we undo this change quickly?
- [ ] **Deployment**: Is the deployment process reliable?
- [ ] **Documentation**: Will the team know how to maintain this?
- [ ] **Knowledge concentration**: Is only one person understanding this?

## Probability × Impact Matrix

Score each identified risk:

```
               LOW IMPACT     MEDIUM IMPACT    HIGH IMPACT
HIGH PROB    │  Medium (4)  │   High (6)    │  Critical (9)  │
MEDIUM PROB  │  Low (2)     │   Medium (4)  │  High (6)      │
LOW PROB     │  Low (1)     │   Low (2)     │  Medium (3)    │
```

### Probability Guide

| Level | Likelihood | Indicators |
| --- | --- | --- |
| **High** | >70% chance | Has happened before, known weak area, no safeguards |
| **Medium** | 30–70% | Could happen, some safeguards exist, not fully tested |
| **Low** | <30% | Unlikely, strong safeguards, well-tested area |

### Impact Guide

| Level | Consequences | Examples |
| --- | --- | --- |
| **High** | System down, data loss, security breach, major rework | Production outage, data corruption, credential leak |
| **Medium** | Feature broken, degraded performance, partial rework | Functionality impaired, slow response, incomplete migration |
| **Low** | Cosmetic issue, minor inconvenience, easy fix | UI glitch, log noise, small refactor needed |

## Mitigation Strategies

For each risk, choose one strategy:

| Strategy | When to Use | Example |
| --- | --- | --- |
| **Avoid** | Remove the risk entirely by changing approach | Use a proven library instead of rolling your own |
| **Reduce** | Lower probability or impact | Add input validation, write tests, create fallbacks |
| **Transfer** | Shift risk to another party | Use managed service instead of self-hosting |
| **Accept** | Consciously decide to take the risk | Document why the risk is acceptable, set a review date |

### Accept Requires Justification

If you accept a risk, you MUST document:
1. **Why** — what makes this acceptable (low probability? low impact? cost of mitigation too high?)
2. **Conditions** — under what conditions would this need revisiting
3. **Review date** — when to reassess this accepted risk
4. **Fallback** — what to do if the risk materializes despite acceptance

## Dependency Risk Scoring

Quick-score external dependencies:

| Factor | Low Risk (1) | Medium Risk (2) | High Risk (3) |
| --- | --- | --- | --- |
| **Maintenance** | Active, regular updates | Maintained but slow | Abandoned or sporadic |
| **Adoption** | Widely used, battle-tested | Moderate adoption | Niche or new |
| **Alternatives** | Easy to swap | Alternatives exist | Lock-in, no alternatives |
| **Blast radius** | Isolated usage | Used in several places | Core dependency |

Sum the scores: 4–5 = Low risk, 6–8 = Medium risk, 9–12 = High risk.

## Risk Register Format

```markdown
## Risk Register: [Project/Feature Name]

| ID | Risk | Category | Prob | Impact | Score | Strategy | Mitigation | Status |
|----|------|----------|------|--------|-------|----------|------------|--------|
| R1 | [Description] | [Tech/Integration/Dep/Data/Security/Ops] | [H/M/L] | [H/M/L] | [1-9] | [Avoid/Reduce/Transfer/Accept] | [Specific action] | [Open/Mitigated/Accepted/Closed] |
| R2 | [Description] | [Category] | [H/M/L] | [H/M/L] | [N] | [Strategy] | [Action] | [Status] |

### Critical Risks (Score ≥ 6)
[Expanded analysis for each critical risk]

#### R1: [Risk Name]
- **Description**: [Detailed description]
- **Probability**: [H/M/L] — [evidence/reasoning]
- **Impact**: [H/M/L] — [what happens if it materializes]
- **Mitigation**: [Specific steps to reduce]
- **Verification**: [How to confirm mitigation is working]
- **Fallback**: [What to do if risk materializes despite mitigation]
```

## Integration with Estimation

Identified risks should feed directly into estimates:

| Risk Score | Estimation Impact |
| --- | --- |
| Critical (7–9) | Apply 2x multiplier AND flag for decomposition |
| High (5–6) | Apply 1.5x–2x multiplier |
| Medium (3–4) | Apply 1.25x–1.5x multiplier |
| Low (1–2) | No adjustment needed |

Multiple risks compound — sum the adjustments, cap at 4x (beyond that, decompose).

## Anti-Patterns

| ❌ Don't | ✅ Do |
| --- | --- |
| Ignore risks because "we'll deal with it" | Document and assign a strategy now |
| Mark everything as High probability | Be honest — defend each probability rating |
| Mitigate risks without verifying | Each mitigation needs a verification step |
| Accept risks without documentation | "Accept" = document why + set review date |
| Only assess technical risks | Check all 6 categories (Tech, Integration, Dependency, Data, Security, Ops) |
| Treat the risk register as write-once | Review and update as the project progresses |
| Mix risk assessment with solutioning | Identify risks first, then plan mitigations separately |
