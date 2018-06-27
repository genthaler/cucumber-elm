module CucumberTest.Glue exposing (..)

{-| Note that we don't really need to invoke any *real* business code here.
-}

import Expect
import Test exposing (test)
import Cucumber.Glue exposing (..)
import Regex


-- type alias GlueFunction state =
--     String -> StepArg -> state -> GlueFunctionResult state


alwaysPass : GlueFunction String
alwaysPass description stepArg initialState =
    ( Just (initialState), Just (test description <| defer <| Expect.pass) )


alwaysFail : GlueFunction String
alwaysFail description stepArg initialState =
    ( Just (initialState), Just (test description <| defer <| Expect.fail "Always fail") )


failIfDescriptionContainsFail : GlueFunction String
failIfDescriptionContainsFail description stepArg initialState =
    ( Just
        initialState
    , Just
        (test description <|
            defer <|
                if
                    Regex.contains (Regex.regex "[Ff]ail")
                        (Debug.log "Step description"
                            description
                        )   
                then
                    Expect.fail "Failing because description contains 'fail'"
                else
                    Expect.pass
        ) 
    )


neverMatch : GlueFunction String
neverMatch description stepArg initialState =
    ( Just initialState, Nothing )
