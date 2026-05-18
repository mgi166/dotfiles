---
allowed-tools: Bash(git:*), Bash(grep:*), Bash(awk:*), Bash(pbcopy:*)
argument-hint: -c: Generate PR title and description, copy to clipboard
description: Generate PR description or title and automatically create pull request on GitHub
---

## Context

- PR template: @.github/pull_request_template.md

## Your task

**IMPORTANT: Before starting, you MUST gather the following information in parallel:**

1. Get the default branch name: `git remote show origin | grep 'HEAD branch' | awk '{print $NF}'`
2. Get current git status: `git status`

**Then, using the main branch name from step 1, gather:**

3. Changes in this PR: `git diff <default-branch>...HEAD`
4. Commits in this PR: `git log --oneline <default-branch>..HEAD`


5. Based on the provided option, perform one of the following actions:

### Options:

- **No option or default**: Generate PR description and create pull request
- **`-c` option**: Generate PR title and description, copy to clipboard
- **`-b {branchName}` option**: Generate PR from target branch name to HEAD

#### Default behavior (no option):

1. Create a PR description following the **exact format** of the PR template in Japanese
2. Execute `gh pr create --draft` with the generated title and description
3. If PR is already exists, Update description from the git changes

#### `-c` option:

1. Create a PR title that has summary of description in Japanese
2. Create a PR description following the **exact format** of the PR template in Japanese
3. Copy clipboard the following formated text: `{title}\n{description}`

#### `-b {branchName}` option:

1. Create PR description from target `{branchName}` to HEAD
2. This option is compatible with `-c` option

### Requirements:

1. Follow the template structure exactly
2. Use Japanese for all content
   - if PR template exists, fill the contents in the template
   - Otherwise, create PR description the following format
       ```
       ## Overview

       ## Why

       ## What

       ## Scope of influence


3. Be comprehensive but concise
