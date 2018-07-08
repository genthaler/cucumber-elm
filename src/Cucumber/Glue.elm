module Cucumber.Glue exposing (..)

{-| This module defines types and functions for use by Glue functions.

The functions need to have the type signature of
Regex -> String ->

These types describe a glue function

@docs GlueFunction, GlueOutput, GlueFunctionResult, GlueArgs

-}

import Gherkin exposing (StepArg)


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
    Result String state


{-| The full type signature of a `GlueFunction`
-}
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


{-| A tuple containing the list of `Glue` functions and an initial state function
-}
type alias GlueArgs state =
    ( List (GlueFunction state), state )
