---
artifact: phase-4-worker-vs-productowner-conversion-decision-matrix
task: 005-pm-agent-system
phase: 4
created: 2026-03-18
status: complete
sources:
  - agents-personal/templates/agents/worker.template.md
  - agents-personal/docs/architecture/ADR-001-orchestration-and-subagents.md
  - learning_base/ideas/pm_agent_coordination_system_implementation_plan.md
---

# Phase 4 — Worker vs. ProductOwner Conversion Decision Matrix (CP-4.4 Evidence)

## Purpose

This document defines the explicit decision rules for when Worker handles resource format conversion versus when ProductOwner processes resources directly. It satisfies CP-4.4 (conversion boundary clarity) and REQ-406/REQ-407 (Worker and PO handoff contract specification).

---

## 1. Conversion Responsibility Matrix

| Resource Type | Owner | Tool Required | ProductOwner Action | Worker Action |
| --- | --- | --- | --- | --- |
| `.md`, `.txt` | **ProductOwner — direct** | None (already text) | Classify and route directly | Not invoked |
| `.csv` | **ProductOwner — direct** | None (text format) | Classify and route; may restructure table | Not invoked |
| URL / web link | **ProductOwner — direct** | WebSearch/WebFetch | Fetch content, summarize, and classify | Not invoked |
| Plain text paste (chat extract) | **ProductOwner — direct** | None | Structure and classify | Not invoked |
| `.pdf` (text-extractable) | **ProductOwner — direct** | Reader tools | Extract text content, classify | Not invoked |
| `.docx` | **Worker — conversion required** | `pandoc` (Bash) | Review converted output, then classify | Convert to `.md` with metadata header |
| `.eml` | **Worker — conversion required** | Email parser (Bash) | Review converted output, then classify | Extract subject/sender/body to `.md` |
| `.msg` | **Worker — conversion required** | Outlook parser (Bash) | Review converted output, then classify | Extract message content to `.md` |
| `.jpg`, `.png`, `.gif`, `.bmp` | **Worker — conversion required** | OCR or reference (Bash) | Review extracted text or placeholder, then classify | Extract text via OCR or create reference placeholder |
| `.zip`, `.tar`, `.rar` | **Worker — conversion required** | Extraction tools (Bash) | Review extracted contents list, then classify each item per above rules | Extract archive and catalog contents |
| `.pdf` (scanned/image-based) | **Worker — conversion required** | OCR (Bash) | Review OCR output quality, then classify | Apply OCR to extract text |
| Other binary/proprietary format | **Worker — conversion required** | Format-specific tool (Bash) | Escalate to ProjectManager if Worker cannot convert | Attempt conversion; report failure if format unsupported |

---

## 2. Decision Process Flow

### Step 1 — ProductOwner: Detect Resource Type

ProductOwner receives inbound resource (from user, ingestion inbox, or ProjectManager delegation).

**Detection protocol:**
1. Check file extension: `.md`, `.txt`, `.csv` → already text → go to **Step 3 (PO direct)**.
2. Check for URL pattern → already accessible → go to **Step 3 (PO direct)**.
3. Check for `.docx`, `.eml`, `.msg`, image files, archives → binary format → go to **Step 2 (Worker delegation)**.
4. Unknown or ambiguous format → ask user for clarification before deciding. Do not guess.
5. If resource is already in `learning_base/_inbox/` as a markdown file → Worker already ran → go to **Step 4 (checkpoint review)**.

### Step 2 — ProductOwner → Worker: Binary Conversion Delegation

ProductOwner invokes Worker via `Convert Resources` handoff button with:
- File path(s) to convert.
- Intended classification for each file (provides context for metadata headers).
- Optional: conversion quality threshold (`best effort` or `strict`).

**Worker conversion protocol:**
1. Apply appropriate tool per file type (pandoc, email parser, OCR, archive extractor).
2. Output markdown file(s) to `learning_base/_inbox/`.
3. Include `## Conversion Notes` section in each output file describing:
   - Conversion tool used.
   - Any content truncated, garbled, or skipped.
   - Confidence level for OCR or complex extractions.
4. Return summary to ProductOwner via `Classify and Route` handoff button.

### Step 3 — ProductOwner: Direct Classification (Already-Text Resources)

For resources that do not require format conversion:
1. Apply `resource-ingestion` skill to classify resource type (meeting notes, VoC, requirements input, idea, reference document, etc.).
2. Apply appropriate learning_base template for the category.
3. Write classified resource to correct `learning_base/` folder.
4. If classification is ambiguous → apply to `_inbox/` and escalate to ProjectManager for routing decision.

**Skip to Step 5** (no Worker conversion needed).

### Step 4 — Checkpoint: ProductOwner Reviews Worker Conversion Output

**MANDATORY PAUSE.** ProductOwner MUST review Worker conversion output before classifying.

| Review Check | Pass Condition | Fail Action |
| --- | --- | --- |
| Markdown is readable | No garbled characters, encoding errors, or Unicode replacement blocks | Request Worker re-conversion with format hint |
| Content is complete | No obvious truncation (document ends mid-sentence, missing sections) | Request Worker re-conversion with specific section to re-check |
| Metadata headers are correct | `source_file`, `source_type`, `ingested_date`, `classification` fields present | Worker must be asked to fix metadata before PO proceeds |
| Conversion notes reviewed | `## Conversion Notes` section reviewed and quality flags assessed | If "low confidence" noted for OCR → PO escalates to ProjectManager |

**Decision gate:**
- All checks pass → proceed to **Step 5**.
- One or more checks fail → return to Worker with specific re-conversion request.
- Conversion unrecoverable (e.g., scanned image with no OCR text, password-protected file) → escalate to **ProjectManager**.

### Step 5 — ProductOwner: Classify and Route

1. Classify the resource into appropriate learning_base category using `resource-ingestion` skill.
2. Apply category template (VoC, meeting notes, requirements input, idea, reference doc).
3. Move/copy from `_inbox/` to correct `learning_base/` folder.
4. If resource contains VoC signals → trigger `stakeholder-feedback` skill next.
5. If resource impacts requirements → trigger `requirements-cascade` skill next.

---

## 3. Disallowed Boundaries

### ProductOwner MUST NOT:

| Disallowed Action | Reason | Correct Action |
| --- | --- | --- |
| Run `pandoc`, `python email`, or any Bash command to convert `.docx`, `.eml` | PO has no Bash access (`disallowedTools: [Bash]`); conversion is Worker's domain | Invoke Worker via `Convert Resources` handoff |
| Attempt to open binary files with Read tool | Binary files are unreadable without conversion; PO will get garbled output | Delegate to Worker first |
| Classify resources without reviewing conversion quality | Garbled conversion produces misleading knowledge-base entries | Mandatory checkpoint review before classification |
| Guess resource classification when type is ambiguous | Misclassification pollutes the knowledge base | Ask user for clarification or escalate to ProjectManager |

### Worker MUST NOT:

| Disallowed Action | Reason | Correct Action |
| --- | --- | --- |
| Classify resources into learning_base categories | Worker has no knowledge of learning_base strategy or category semantics | Return to ProductOwner via `Classify and Route` handoff |
| Decide which learning_base folder a resource belongs in | Category decisions require ProductOwner domain knowledge and stakeholder context | ProductOwner owns routing decisions |
| Apply VoC or requirements templates to converted content | Template application is a classification-layer decision, not a conversion-layer decision | Return to ProductOwner for template application |
| Make strategic decisions about resource relevance | Worker is a mechanical executor, not a strategic planner | ProductOwner owns relevance assessments |
| Re-classify or move previously classified resources | Once PO has classified a resource, Worker must not override it | If reclassification needed, ProductOwner makes the decision |

---

## 4. Failure and Escalation Cases

| Failure Scenario | First Responder | Action |
| --- | --- | --- |
| Worker returns garbled conversion | ProductOwner | Request re-conversion with specific format hint (e.g., encoding, template hint) |
| Worker returns truncated conversion | ProductOwner | Request re-conversion with specific section recovery instruction |
| File is password-protected | Worker (reports immediately) | ProductOwner escalates to ProjectManager with access request for stakeholder |
| File format not supported by available tools | Worker (reports immediately) | ProductOwner escalates to ProjectManager; stakeholder asked to re-provide in supported format |
| PO cannot determine correct learning_base category | ProductOwner | Escalate classification question to ProjectManager; leave resource in `_inbox/` until resolved |
| Cascade review reveals unexpected scope expansion after classification | ProductOwner | Pause cascade; escalate to ProjectManager before proceeding with requirements updates |
| Worker conversion output quality is "low confidence" for OCR | Worker (flags in Conversion Notes) | ProductOwner escalates to ProjectManager; stakeholder asked to provide higher-quality source |

---

## 5. Process Flow Diagram

```
User provides inbound resource
         │
         ▼
┌─────────────────────────────────────┐
│  ProductOwner: Detect resource type │
└─────────────────────────────────────┘
         │
    ┌────┴────────────────┐
    │                     │
Already text/URL    Binary/proprietary
(md, txt, csv,     (.docx, .eml, .msg,
URL, plain text)    images, archives)
    │                     │
    ▼                     ▼
PO classifies      PO invokes Worker
directly           "Convert Resources"
    │                     │
    │              Worker converts
    │              to markdown in
    │              learning_base/_inbox/
    │                     │
    │              Worker returns
    │              "Classify and Route"
    │                     │
    │         ┌───────────┘
    │         ▼
    │   CHECKPOINT: PO reviews
    │   conversion quality
    │         │
    │    ┌────┴──────────┐
    │  Pass            Fail
    │    │               │
    │    │         Request re-conversion
    │    │         or escalate to PM
    │    ▼
    └──► PO classifies and routes
         to learning_base category
              │
              ▼
         Apply template
              │
              ▼
     Trigger VoC / cascade
     skills if applicable
```

---

## 6. Resource Type Quick Reference

| Extension | Worker? | PO Direct? | Notes |
| --- | --- | --- | --- |
| `.md` | No | **Yes** | Already markdown |
| `.txt` | No | **Yes** | Plain text, no conversion needed |
| `.csv` | No | **Yes** | Text format; PO may reformat as table |
| `.pdf` (text) | No | **Yes** | PO uses reader/fetch tools |
| `.pdf` (scanned) | **Yes** | No | Requires OCR via Bash |
| `.docx` | **Yes** | No | Requires pandoc |
| `.eml` | **Yes** | No | Requires email parser |
| `.msg` | **Yes** | No | Requires Outlook parser |
| `.jpg/.png/.gif` | **Yes** | No | Requires OCR or reference placeholder |
| `.zip/.tar/.rar` | **Yes** | No | Requires extraction + per-file routing |
| URL | No | **Yes** | PO uses WebFetch/WebSearch |
| Pasted text | No | **Yes** | PO structures directly |
