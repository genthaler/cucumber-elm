module CucumberTest.Glue exposing (..)

{-| Note that we don't really need to invoke any *real* business code here.
-}

import Expect
import Cucumber exposing (..)
import Regex


alwaysPass : GlueFunction String
alwaysPass initialState description stepArg =
    Just ( description, Expect.pass )


alwaysFail : GlueFunction String
alwaysFail initialState description stepArg =
    Just ( initialState, Expect.fail "Always fail" )


failIfDescriptionContainsFail : GlueFunction String
failIfDescriptionContainsFail initialState description stepArg =
    Just
        ( initialState
        , if
            Regex.contains (Regex.regex "[Ff]ail")
                (Debug.log "Step description"
                    description
                )
          then
            Expect.fail "Failing because description contains 'fail'"
          else
            Expect.pass
        )


neverMatch : GlueFunction String
neverMatch initialState description stepArg =
    Nothing
