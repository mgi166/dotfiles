---
name: fix-pr-review
description: Fetch unresolved review comments from the GitHub PR associated with the current branch, apply fixes, run test/lint, and report the results.
allowed-tools:
  - Bash(git:*)
  - Bash(gh:*)
  - Bash(jq:*)
  - Bash(command -v gh:*)
  - Bash(mise:*)
  - Bash(task:*)
  - Bash(just:*)
  - Bash(make test:*)
  - Bash(make lint:*)
  - Bash(npm run test:*)
  - Bash(npm run lint:*)
  - Bash(pnpm test:*)
  - Bash(pnpm lint:*)
  - Bash(yarn test:*)
  - Bash(yarn lint:*)
---

# Fix PR Review Skill

## Role

Identify the GitHub PR associated with the current branch, address all unresolved review comments (thread comments, PR body comments, and review bodies), run test/lint where possible, and report the outcomes and changes to the user.

## Safety Policy

- Do not run `git commit`.
- Do not run `git push` (including `--force`).
- Do not automatically reply to PR comments or resolve threads.
- Do not revert changes unrelated to the review feedback.
- Always report every command executed and its result.

## Execution Steps

### 1. Prerequisites check

Verify the following.

```bash
git rev-parse --is-inside-work-tree
command -v gh
gh auth status
```

If any check fails, report the missing condition to the user and stop.

### 2. Identify the target PR

Fetch the PR associated with the current branch.

```bash
BRANCH="$(git branch --show-current)"
PR_JSON="$(gh pr view --json number,title,url,headRefName,baseRefName 2>/dev/null)"
```

If `gh pr view` fails, search by head branch name.

```bash
PR_JSON="$(gh pr list --head "$BRANCH" --state open --limit 1 --json number,title,url,headRefName,baseRefName)"
```

If no PR is found, stop and report to the user.

### 3. Fetch unresolved review comments

Extract `PR_NUMBER` and retrieve threads via GraphQL.

```bash
PR_NUMBER="$(printf '%s' "$PR_JSON" | jq -r '.number // .[0].number')"
OWNER_REPO="$(gh repo view --json nameWithOwner -q .nameWithOwner)"
OWNER="${OWNER_REPO%/*}"
REPO="${OWNER_REPO#*/}"

gh api graphql -f query='\
query($owner:String!, $repo:String!, $number:Int!) {\
  repository(owner:$owner, name:$repo) {\
    pullRequest(number:$number) {\
      number\
      title\
      url\
      headRefName\
      baseRefName\
      comments(first: 100) {\
        nodes {\
          body\
          url\
          createdAt\
          author { login }\
        }\
      }\
      reviewThreads(first: 100) {\
        nodes {\
          isResolved\
          isOutdated\
          path\
          line\
          comments(first: 50) {\
            nodes {\
              body\
              url\
              createdAt\
              author { login }\
            }\
          }\
        }\
      }\
      reviews(first: 50) {\
        nodes {\
          state\
          body\
          submittedAt\
          author { login }\
        }\
      }\
    }\
  }\
}' -f owner="$OWNER" -f repo="$REPO" -F number="$PR_NUMBER"
```

Extraction rules:

- PR body comments (`comments`): include all, including GitHub Actions bot comments.
- Thread comments (`reviewThreads`): include only `isResolved == false` and `isOutdated == false`.
- Review bodies (`reviews`): include `state` of `CHANGES_REQUESTED` or `COMMENTED`.
- Skip empty bodies or emoji-only comments with no actionable feedback — report the reason.

### 4. Classify comments and decide on an action plan

Priority order:

1. Bugs, security issues, spec violations
2. Missing tests, type/boundary condition gaps
3. Readability and maintainability improvements
4. Minor wording and nit-level feedback

For ambiguous comments, flag them as "needs clarification" and surface them to the user — do not silently change behavior.

### 5. Present the action plan to the user and get approval

**Before making any changes**, present the following table and wait for the user's approval.

| # | Priority | File:Line | Comment | Planned action |
|---|----------|-----------|---------|----------------|
| 1 | Bug | `foo.dart:30` | Exception not caught | Add `on FooException` |
| 2 | Improvement | `bar.dart:59` | No log on catch | Add `Log.xxx` |

- Also list any comments you plan to skip, with the reason.
- If the user requests modifications, additions, or skips, update the plan before proceeding.

### 6. Apply fixes

- Read the context around each comment location before editing.
- Make minimal changes — do not refactor or touch unrelated files.
- When renaming or changing signatures, propagate the change to all references.

### 7. Verify (test/lint)

Run verification starting from the scope closest to the changed code. Detection order:

1. `mise tasks`
2. `task -l`
3. `just --list`
4. `make test` / `make lint`
5. `test` / `lint` scripts in `package.json`

If no applicable command is found or it cannot be run, report the reason and skip.

### 8. Report

Return results in the following format.

```markdown
## PR Review Fix Results

### Target PR
- #<number> <title>
- <head> -> <base>
- <url>

### Addressed comments
- [Priority] <file:line> <summary> -> <action taken>

### Skipped / Needs clarification
- <category>: <reason>

### Commands run
- <command>

### Test result
- ✅ Passed / ⚠️ Partial failure or skipped (reason) / ❌ Failed

### Lint result
- ✅ Passed / ⚠️ Partial failure or skipped (reason) / ❌ Failed

### Changed files
- <path>
- commit / push not executed
```

## Trigger Examples

- `/fix-pr-review`
- "Fix the review comments on this branch's PR"
- "Address the PR comments and run the tests"
