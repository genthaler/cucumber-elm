module CucumberTest.Glue exposing (..)

import Expect
import Cucumber exposing (..)
import CucumberTest.Fixture as Fixture


myGlue : GlueFunction String
myGlue initialState tags description stepArg =
    Just ( description, Expect.pass )
