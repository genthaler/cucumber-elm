module Cucumber.StepDefs exposing (StepDefFunction, StepDefOutput(..), StepDefFunctionResult, StepDefArgs)

{-| This module defines types and functions for use by StepDef functions.

The functions need to have the type signature of
Regex -> String ->

These types describe a glue function

@docs StepDefFunction, StepDefOutput, StepDefFunctionResult, StepDefArgs

-}

import Gherkin exposing (StepArg)


{-| A glue function transforms an initial state, a list of Strings extracted
from the matched regular expression, and any `StepArg`, into a tuple of
modified state and `Expectation`.

In OOP implementations of Cucumber, the state is usually the Step class itself.
Elm is a pure functional language, so we pass the state around explicitly.

Return either Nothing (no match between Step and StepDefFunction), or new state + pass
Note that if no matching StepDefFunctions are found, (i.e. every function returns Nothing state),
then execution stops. Remember that only one StepDefFunction should match a given Step description

-}
type alias StepDefFunctionResult state =
    Result String state


{-| The full type signature of a `StepDefFunction`
-}
type alias StepDefFunction state =
    String -> StepArg -> state -> StepDefFunctionResult state


{-| A glue function can send some output to be displayed inline in the
pretty-print of the Gherkin text. Right now only support text, but eventually
want to support images, in particular screenshots from webdriver.

Currently not supported #22.

-- | StepDefOutputImage Blob

-}
type StepDefOutput
    = StepDefOutputString String


{-| A tuple containing the list of `StepDef` functions and an initial state function
-}
type alias StepDefArgs state =
    ( state, List (StepDefFunction state) )
