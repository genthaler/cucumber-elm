# AGENTS

## Scope

This file should stay concise and repository-specific.
Use it for durable project context, architecture direction, and local conventions.
Do not use it as a session log or a checklist of completed work.

## Project Direction

This repository is intended to become an Elm-native Cucumber-style BDD library, not a general application.

Current direction:

- use Gherkin as the authoring format
- use explicit Elm step handlers rather than reflection-based discovery
- integrate with standard Elm test workflows where possible, especially `elm-test`
- treat extra IDE integration as optional follow-on work rather than a core requirement

The source-of-truth documents for this direction are:

- `docs/project-vision.md`
- `docs/requirements.md`

## Repo-Specific Guidance

- Prioritize work in the parser, AST, runner, and tests; that is where the core value of the repository currently sits.
- Treat the frontend scaffold as stale unless the task explicitly requires touching it.
- Keep Elm `0.18` compatibility in mind when proposing or implementing changes.
- Prefer changes that preserve or improve compatibility with normal Elm tooling and editor workflows rather than introducing a separate bespoke runtime.

## Maintenance

- Keep this file focused on stable repository context and conventions.
- Move reusable procedures, personal workflow preferences, thread-routing habits, and tool-specific playbooks into user-level or repo-local skills instead of expanding this file.
