# Project Vision

## Summary

Build an Elm-native Cucumber-style BDD library that lets teams write Gherkin features and execute them through ordinary Elm test workflows, with minimal dependence on custom IDE tooling.

The project should preserve the core value of Cucumber:

- human-readable behavior specifications
- scenario-based execution
- reusable step definitions
- feature and scenario reporting

The implementation should adapt those ideas to Elm's constraints:

- no metaprogramming-based step discovery
- explicit state threading
- pure, typed execution model
- compatibility with `elm-test` rather than a separate bespoke runtime where possible

## Key Constraints

- Existing Elm tooling should keep working, especially `elm-test` and editor integrations that already understand Elm tests.
- The system should not require a custom VS Code extension or new IDE plugin for the core developer workflow.
- Step definitions will likely need explicit registration rather than reflection-based discovery.
- Failure output needs to map cleanly onto standard test reporting so CI and editors can surface useful results.
- Additional editor integrations are allowed later, but they should be additive rather than required.

## Product Direction

The most viable initial form is not a full reimplementation of Cucumber exactly as found in Ruby, JavaScript, or Java. The stronger direction is:

- Gherkin as the specification language
- Elm functions as explicit step handlers
- feature and scenario expansion into normal Elm test structures
- execution and reporting through standard Elm test tooling

In practice, this should feel like BDD on top of Elm tests rather than a completely separate test ecosystem.

## MVP Requirements

- Parse `.feature` text into a typed Elm representation.
- Support core Gherkin concepts:
  - `Feature`
  - `Scenario`
  - `Scenario Outline`
  - `Examples`
  - `Background`
  - `Tags`
  - step arguments such as tables and doc strings
- Allow explicit registration of step handlers in Elm.
- Match feature steps to handlers deterministically.
- Thread scenario state explicitly through execution.
- Convert features into `elm-test`-compatible tests or equivalent standard test output.
- Produce readable test names such as `Feature / Scenario / Example`.
- Report failures at a useful level of granularity, ideally including the failing step text.
- Support tag-based filtering in a way that works within normal test workflows.

## Non-Goals For MVP

- Full parity with reflection-heavy Cucumber implementations.
- Automatic discovery of step definitions.
- Mandatory custom IDE integration.
- A standalone browser UI or demo as a primary product goal.
- Reproducing every Cucumber plugin or reporting feature from other ecosystems.

## Success Criteria

The MVP is successful if a developer can:

1. Write a `.feature` file.
2. Register Elm step handlers explicitly.
3. Run the result via normal Elm test tooling.
4. See scenarios represented clearly in editor and CI test output.
5. Diagnose failures without needing special-purpose tooling.

## Open Product Questions

- Should features be parsed at runtime from strings, or represented or generated in Elm source for tighter tooling integration?
- How much of the Gherkin spec needs to be supported initially versus later?
- Should the primary API produce `elm-test` test trees directly, or a runner result that can be adapted into tests?
- How important is preserving line and file traceability back to the `.feature` source?
