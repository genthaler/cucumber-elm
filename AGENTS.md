# AGENTS

## Session Summary

This session focused on requirements elicitation and repository guidance rather than product code changes.

Completed work:

- scanned the repository and identified the current shape as an Elm-native Gherkin/Cucumber library rather than a complete working app
- clarified the intended project direction as Cucumber-style BDD for Elm, adapted to Elm's constraints
- captured the key constraint that the design should work with existing Elm tooling and editor integrations where possible, especially through `elm-test`
- created a project vision document at `docs/project-vision.md`
- created a requirements document at `docs/requirements.md`
- created a repo-local git skill at `.agents/skills/git/`
- committed the documentation and the local git skill on branch `codex/requirements-elicitation`

## Current Direction

The current intended direction is:

- use Gherkin as the authoring format
- use explicit Elm step handlers rather than reflection-based discovery
- prefer compatibility with standard Elm test workflows over building a separate bespoke runtime
- treat additional IDE integration as optional follow-on work, not a requirement for the core experience

## Current Branch

- `codex/requirements-elicitation`

## Notable Repo Observations

- the core value of the repo is in the parser, AST, runner, and tests
- the repository still targets Elm `0.18`
- the frontend scaffold appears stale and incomplete relative to the library code

## Relevant Files Added This Session

- `docs/project-vision.md`
- `docs/requirements.md`
- `.agents/skills/git/SKILL.md`
- `.agents/skills/git/agents/openai.yaml`
