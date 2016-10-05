module Gherkin exposing (..)

{-| This library describes a datastructure for the [Gherkin][Gherkin] *ubiquitous language*.

It's intended eventually to be used as the output (AST) of a Gherkin parser,
but I've tried to make it usable as a DSL in its own right.

In proper Gherkin, it's possible to have multiple languages supported.
The intention is that this will be supported in the plain text version,
similarly to extant ports in other languages.

  [Gherkin]: https://github.com/cucumber/cucumber/wiki/Gherkin

# Feature
@docs Feature, AsA, InOrderTo, IWantTo, Background

# Scenario
@docs Scenario, Examples

# Step
@docs Step, StepArg, DataTable,
-}


{-| This is the top level datatype, which represents the entire contents of
a .feature document in BDD terms.
-}
type Feature
    = Feature (List Tag) String AsA InOrderTo IWantTo Background (List Scenario)


{-| This is the datatype for tags, which can be specified at Feature, Scenario &
Scenario Example levels
-}
type alias Tag =
    String


{-| From [User Stories](https://en.wikipedia.org/wiki/User_story)
-}
type AsA
    = AsA String


{-| From [User Stories](https://en.wikipedia.org/wiki/User_story)
-}
type InOrderTo
    = InOrderTo String


{-| From [User Stories](https://en.wikipedia.org/wiki/User_story)
-}
type IWantTo
    = IWantTo String


{-| Background describes common elements to each [Scenario](#Scenario) described.

When automating, each [Step](#Step) will be executed before each [Scenario](#Scenario)'s [Step](#Step)s
-}
type Background
    = Background String (List Step)
    | NoBackground


{-| A Scenario describes an example in the system.

A Scenario Outline describes a Scenario template with multiple examples;
the template is executed once per example, substituting tokens in the Scenario's
Steps
-}
type Scenario
    = Scenario (List Tag) String (List Step)
    | ScenarioOutline (List Tag) String (List Step) (List Examples)


{-| A Step describes an action or assertion.

When automated, the Steps are executed against a list of Glue functions;
the String and StepArg are passed to each Glue function; if there's a match,
the Glue function is executed with those as arguments.
There is no functional distinction between Given, When, Then, And or But

See the Cucumber module for examples.
-}
type Step
    = Given String StepArg
    | When String StepArg
    | Then String StepArg
    | And String StepArg
    | But String StepArg


{-| An argument to the Glue function, that's not extracted from the Step description.

Available options are DataTables and DocStrings.
-}
type StepArg
    = NoArg
    | DataTable Table
    | DocString String


{-| Used in Scenario Outlines
-}
type Examples
    = Examples (List Tag) Table


{-| Used in Steps i.e. a kind of StepArg.
-}
type alias Row =
    List String


{-| Used in Steps i.e. a kind of StepArg, and in Examples.

There must be at least one row.
-}
type Table
    = Table Row (List Row)
