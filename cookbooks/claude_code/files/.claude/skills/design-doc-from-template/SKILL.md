---
name: design-doc-from-template
description: Create or update a design doc using the template at ~/.claude/skills/design-doc-from-template/design-doc-template.md. Use when you want to structure a doc following the standard template, ensure coverage of key design concerns (requirements, architecture, testing, security, release/operations), or convert existing information into a template-compliant document.
---

# Design Doc From Template

## Overview

Use `~/.claude/skills/design-doc-from-template/design-doc-template.md` as the single authoritative template to create design docs.
Do not fill in missing information speculatively — manage unknowns with `[TBD]` and follow-up questions.

## Invocation

- Invocation format: `/design-doc-from-template "topic of the design doc"`
- Interpret the quoted string as the subject of this design doc.
- If the argument is empty or ambiguous, ask the user to clarify the topic in one sentence before proceeding.

## Workflow

### 1. Read the template

Always read the following file first.

- `~/.claude/skills/design-doc-from-template/design-doc-template.md`

Follow the guidance at the top of the template. If a section does not fit the content, adjusting the format or removing unnecessary sections is acceptable.

### 2. Confirm inputs

Confirm the following at the start.

- The topic passed as an argument (e.g., `idempotency handling for the payment API`)
- Background of the target feature or project
- Constraints (deadlines, non-functional requirements, operational requirements, compatibility)
- Intended audience (engineers, PMs, SREs, security team, etc.)

### 3. Apply the template structure

- Follow the heading order in the template as-is by default.
- Do not rename sections unless strictly necessary.
- Only remove or reorganize sections when the content genuinely does not fit — leave a note explaining why.

Always apply any inline instructions found within the template.

### 4. Read the active repository's code

Immediately after confirming inputs, gather design evidence from the current repository.

- Identify entry points, related directories, and key modules.
- Read existing implementations related to the topic (APIs, data models, jobs, configuration).
- Check code and config related to existing tests, monitoring, authorization, and release procedures.
- Base all statements on code you actually read, not assumptions.

Leave items without code evidence as `- [TBD] ...` and move them to follow-up questions.

### 5. Map information to each section

For each section:

- Write known information concisely.
- Clearly state the specification or assumption it is based on.
- List unknowns in `- [TBD] ...` format.

Before diving into implementation details, fill every section once to surface any gaps.

Prioritize the template's core sections: Purpose, Out of Scope, Background, Requirements, Performance Requirements, Architecture, Test Strategy/Design, Monitoring, Security, Release Plan, Operations, Discussion Points, Side Notes.

### 6. Ensure design quality

At minimum, verify the following.

- The problem statement and the goal are aligned.
- Non-goals are clearly stated.
- Alternatives and the reasoning for the chosen approach are present.
- Risks and mitigations are addressed.
- Release procedure, monitoring, and rollback plan are present.
- Open Questions are explicitly listed as outstanding items.

### 7. Produce output

Present the final output in this order.

1. The template-compliant design doc body (with unnecessary sections trimmed as needed)
2. List of undecided items (`[TBD]`)
3. Follow-up questions requiring clarification (only when needed)
4. Key code locations referenced (file paths)

## File Output Rules

- Write to `docs/{design-doc-title}.md` under the current repository.
- Create the `docs` directory first if it does not exist.
- Normalize `design-doc-title` from the invocation argument into a filename:
  - Prefer lowercase alphanumerics and `-`.
  - Replace spaces with `-`.
  - Remove symbols except where minimally necessary.
- If the file already exists, review the diff and update rather than overwriting blindly.

## Writing Rules

- Do not state uncertain content as fact.
- Avoid vague language ("appropriately", "as needed", "nicely").
- Prefer bullet points and short sentences over lengthy prose.
- Express metrics, thresholds, and deadlines numerically wherever possible.
- If adding a section not in the template, state why it is necessary.
