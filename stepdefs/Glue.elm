module CucumberTest.Glue exposing (..)

{-| Note that we don't really need to invoke any *real* business code here.
-}

import Cucumber.Glue exposing (..)
import Regex


-- type alias GlueFunction state =
--     String -> StepArg -> state -> GlueFunctionResult state


alwaysPass : GlueFunction state
alwaysPass description stepArg initialState =
    Ok initialState


alwaysFail : GlueFunction String
alwaysFail description stepArg initialState =
    Err ("Always fail " ++ description)


failIfDescriptionContainsFail : GlueFunction String
failIfDescriptionContainsFail description stepArg initialState =
    if
        Regex.contains (Regex.regex "[Ff]ail")
            (Debug.log "Step description"
                description
            )
    then
        Err ("Failing because description contains 'fail'" ++ description)
    else
        Ok initialState
