# Git Skill

## When to use
- Suggest a commit message after file changes.
- Inspect git status or diff to understand what changed.
- Check whether the working tree contains unrelated changes before summarising work.

## When not to use
- Staging, committing, or rewriting history unless the user explicitly asks for git actions.
- Non-git summary tasks where repository state is irrelevant.

## Workflow
1. Inspect the current git state.
   - Read `git status --short` first.
   - Check `git diff --stat` or equivalent to understand the scope quickly.
   - Use the diff against `HEAD` when forming a commit summary.
2. Check branch context before suggesting git actions.
   - If the task involves creating a branch for new work, use a branch name that starts with `codex/`.
   - If the current branch does not follow that rule, call it out before committing.
   - Treat `main` as PR-only. New work should not be committed directly to `main`.
3. After a PR merges, encourage branch cleanup.
   - Suggest switching back to `main`, fast-forwarding it to `origin/main`, and deleting the merged `codex/*` branch locally.
   - If the branch has been pushed and merged, suggest deleting the remote branch too.
   - Treat this as follow-up cleanup guidance, not as implicit permission to run destructive git commands without the user asking.
4. Call out unrelated changes before suggesting a commit message.
5. Distinguish message suggestion from git actions.
   - Suggest the commit message without assuming files should be staged or committed.
6. Prefer short imperative commit messages.
7. Prefix commit messages with a change type such as `Feature:`, `Refactor:`, `Style:`, `Documentation:`, `Fix:`, or `Chore:`.
   - If you would normally default to Conventional Commits like `feat:`, `fix:`, or `refactor:`, override that habit here and use the initial-cap prefixes above instead.

## Fixing guidance

- Base the suggestion on the full current diff against `HEAD`, not only the most recent edit.
- Keep branch guidance aligned with the repo rule that new work should happen on `codex/*` branches unless the user says otherwise.
- Keep guidance aligned with the protected-branch rule that `main` changes land via PR rather than direct commits or pushes.
- After a merged PR, suggest the normal local and remote branch cleanup steps unless the user indicates they want to keep the branch around.
- Do not hide unrelated changes in the working tree.
- Mention when unrelated changes should not be included in the suggested commit scope.
- Keep the suggested message compact and descriptive.

## Final checks

- Base the suggestion on the full current diff against `HEAD`, not only the most recent edit.
- Branch guidance matches the repo's `codex/*` and PR-only `main` rules.
- Unrelated changes in the working tree are called out explicitly.
- Any suggested commit message is compact, descriptive, and uses the repo's preferred prefix style.
