module CucumberTest.Glue exposing (..)

import Expect
import Cucumber exposing (..)
import CucumberTest.Fixture as Fixture


glue : GlueFunction String
glue initialState description stepArg =
    Just ( description, Expect.pass )


passGlue : GlueFunction String
passGlue initialState description stepArg =
    Just ( initialState, Expect.fail "Always fail" )


failGlue : GlueFunction String
failGlue initialState description stepArg =
    Just ( initialState, Expect.pass )


noMatchGlue : GlueFunction String
noMatchGlue initialState description stepArg =
    Nothing
