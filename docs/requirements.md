# Requirements

## Purpose

This project should provide a practical Elm-native implementation of Cucumber-style behavior-driven development.

Its purpose is not to mimic mainstream Cucumber runtimes feature-for-feature. Its purpose is to let Elm developers write behavior specifications in Gherkin and execute them through familiar Elm testing workflows.

## Problem Statement

Elm does not naturally support the standard implementation techniques used by Cucumber in other languages:

- no runtime reflection for discovering step definitions
- no metaprogramming for generating test bindings automatically in the usual style
- no mutable scenario world object
- a strong preference for pure and typed program structure

Without an Elm-specific design, teams that want BDD-style specifications must either abandon Gherkin entirely or maintain a workflow that is disconnected from normal Elm testing and editor tooling.

## Vision

The project should make Gherkin a useful authoring surface for Elm projects while preserving compatibility with standard tools such as `elm-test`, CI pipelines, and existing editor integrations.

The design should lean into Elm's strengths:

- explicit data structures
- deterministic execution
- explicit state threading
- typed step handler APIs

## Primary Users

- Elm developers who want specification-style tests.
- Teams already familiar with Gherkin or Cucumber from other ecosystems.
- Projects that want readable business-facing scenarios without giving up ordinary Elm testing workflows.

## Core Use Cases

1. A developer writes a `.feature` file describing behavior in Gherkin.
2. The developer registers Elm step handlers explicitly in test code.
3. The library parses the feature and expands it into executable tests.
4. The tests run via normal Elm tooling and appear in standard test output.
5. When a scenario fails, the failure is understandable at the feature, scenario, and step level.

## Functional Requirements

### Parsing

- The system must parse `.feature` text into a typed Elm representation.
- The parser must support:
  - `Feature`
  - `Scenario`
  - `Scenario Outline`
  - `Examples`
  - `Background`
  - `Tags`
  - doc strings
  - data tables
- The parser should provide useful error messages when feature text is invalid.

### Step Registration And Matching

- Developers must be able to register step handlers explicitly in Elm.
- Step registration must not rely on reflection or automatic runtime discovery.
- Matching must be deterministic.
- The system must define what happens when:
  - no handler matches a step
  - more than one handler matches a step
  - a handler returns a failure

### Execution Model

- Scenario execution must thread state explicitly from step to step.
- `Background` steps must run before each scenario invocation.
- `Scenario Outline` examples must expand into distinct scenario executions.
- Tag filters should be supported during execution or test generation.
- The execution model should be pure where possible and fit normal Elm test patterns.

### Test Integration

- The primary developer workflow should integrate with `elm-test`.
- Generated or adapted tests should appear as standard tests to existing tooling where feasible.
- Test names must be stable and readable, ideally reflecting:
  - feature name
  - scenario name
  - example row identity where relevant
- Failures should surface the failing step text and enough context to diagnose the problem quickly.

### Reporting

- The system must provide structured pass or fail outcomes.
- Reporting should be sufficient for CI and editor test explorers even if custom rich reporting is not implemented initially.
- More advanced reporting can be deferred if the basic test output remains useful.

## Non-Functional Requirements

- The API should be understandable to Elm developers without requiring Cucumber internals knowledge.
- The library should favor explicitness over magic.
- The approach should minimize the need for custom IDE plugins in the initial release.
- The design should leave room for later editor integrations without depending on them.
- The implementation should be testable with ordinary Elm test techniques.

## Constraints

- Elm language constraints prevent direct cloning of reflection-heavy Cucumber implementations.
- Existing Elm editor and test-runner integrations are a major compatibility target.
- New IDE plugins are allowed, but they should not be necessary for the core experience.
- The project may need to choose between runtime parsing, compile-time generation, or a hybrid model.

## Out Of Scope For MVP

- Automatic discovery of step definitions.
- Full compatibility with every feature of other Cucumber ecosystems.
- Rich standalone browser tooling as a required part of the product.
- Mandatory custom reporters, IDE extensions, or language-server changes.
- Reimplementation of the broader Cucumber plugin ecosystem.

## Acceptance Criteria

The MVP is acceptable if all of the following are true:

1. A developer can define feature text using core Gherkin syntax.
2. The feature text can be parsed into Elm data structures.
3. The developer can supply explicit Elm step handlers.
4. Scenarios can be executed with explicit state threading.
5. Results can be surfaced through normal Elm test workflows.
6. Scenario names are visible and understandable in test output.
7. Failures identify at least the scenario and failing step.
8. The workflow is useful without writing a custom IDE plugin.

## Open Questions

- Should the primary interface accept raw `.feature` strings, pre-parsed Elm values, or both?
- Should the main public API generate `elm-test` `Test` values directly, or expose a runner that users adapt into tests?
- How should example rows be named in test output?
- How much of the full Gherkin grammar should be treated as MVP versus later work?
- How should line and file provenance be preserved for better editor diagnostics?
- What is the desired story for side effects in step handlers, if any?

## Suggested Delivery Sequence

1. Stabilize the core parser and AST surface.
2. Define the step registration and matching API.
3. Define the execution semantics for state, background, examples, and tags.
4. Add first-class `elm-test` integration.
5. Improve diagnostics and reporting.
6. Evaluate whether additional editor support is still needed after the standard tooling path works.
