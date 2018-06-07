module Cucumber.Glue exposing (GlueFunction, GlueFunctions, GlueFunctionResult, extract)

{-| This module defines types and functions for use by Glue functions.

The functions need to have the type signature of
Regex -> String ->


These types describe a glue function

@docs GlueFunction, GlueOutput


# Running
@docs expectFeature

These functions are for running glue functions with the step arguments as arguments.

It's the glue function's responsibility to decide whether it can handle a
particular step, though we can certainly help with pulling out matching groups.

The execution order is:

  - for each `Scenario` or `Scenario Outline`+`Example`
      - execute each `Background` `Step`
      - `andThen`
      - execute each `Scenario` `Step`


# Reporting
-}

import Expect exposing (Expectation)
import Gherkin exposing (StepArg)


extract : String -> List String
extract _ =
    []


{-| A glue function transforms an initial state, a list of Strings extracted
from the matched regular expression, and any `StepArg`, into a tuple of
modified state and `Expectation`.

In OOP implementations of Cucumber, the state is usually the Step class itself.
Elm is a pure functional language, so we pass the state around explicitly.
-}
type alias GlueFunction state =
    state -> String -> StepArg -> GlueFunctionResult state


type alias GlueFunctions state =
    List (GlueFunction state)


{-| A glue function returns a tuple of modified state, list of GlueOutput and `Expectation`.
-}
type alias GlueFunctionResult a =
    Maybe ( a, Expectation )
