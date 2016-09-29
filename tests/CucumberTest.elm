module CucumberTest exposing (..)

import Test exposing (..)
import Expect
import Gherkin exposing (..)
import Cucumber exposing (..)
import CucumberTest.Glue as Glue


step : Step
step =
    Given "Now is the time" (DocString "")


testTestStep : Test
testTestStep =
    describe "Steps"
        [ test "successfully runs a Step against a Glue function"
            <| \() ->
                let
                    ( _, assertion ) =
                        testStep [ Glue.myGlue ] "initial state" step
                in
                    assertion
        ]


all : Test
all =
    describe "Features"
        [ testTestStep
        ]
