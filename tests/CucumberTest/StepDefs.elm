module CucumberTest.StepDefs exposing (alwaysFail, alwaysPass, failIfDescriptionContainsFail)

{-| Note that we don't really need to invoke any _real_ business code here.
-}

import Cucumber.StepDefs exposing (..)
import Regex



-- type alias StepDefFunction state =
--     String -> StepArg -> state -> StepDefFunctionResult state


alwaysPass : StepDefFunction state
alwaysPass description stepArg initialState =
    Ok initialState


alwaysFail : StepDefFunction String
alwaysFail description stepArg initialState =
    Err ("Always fail " ++ description)


failIfDescriptionContainsFail : StepDefFunction String
failIfDescriptionContainsFail description stepArg initialState =
    if String.contains "fail" <| String.toLower <| Debug.log "Step description" description then
        Err ("Failing because description contains 'fail'" ++ description)

    else
        Ok initialState
