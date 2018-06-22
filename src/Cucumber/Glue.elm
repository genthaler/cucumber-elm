module Cucumber.Glue exposing (..)

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


type alias Thunk a =
    () -> a


type alias ExpectationThunk =
    Thunk Expectation


{-| defer execution
-}
defer : a -> Thunk a
defer x =
    \() -> x


{-| A glue function transforms an initial state, a list of Strings extracted
from the matched regular expression, and any `StepArg`, into a tuple of
modified state and `Expectation`.

In OOP implementations of Cucumber, the state is usually the Step class itself.
Elm is a pure functional language, so we pass the state around explicitly.

Return either Nothing (no match between Step and GlueFunction), or new state + pass
Note that if no matching GlueFunctions are found, (i.e. every function returns Nothing state),
then execution stops. Remember that only one GlueFunction should match a given Step description

-}
type alias GlueFunctionResult state =
    ( Maybe state, Maybe ExpectationThunk )


type alias GlueFunction state =
    String -> StepArg -> state -> GlueFunctionResult state


{-| A glue function can send some output to be displayed inline in the
pretty-print of the Gherkin text. Right now only support text, but eventually
want to support images, in particular screenshots from webdriver.

Currently not supported #22.

-- | GlueOutputImage Blob

-}
type GlueOutput
    = GlueOutputString String
