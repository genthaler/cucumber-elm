module CucumberTest exposing (..)

import Test exposing (..)
import Expect
import Gherkin exposing (..)
import Cucumber exposing (..)
import CucumberTest.Glue as Glue


step : Step
step =
    Given "Now is the time" (DocString "")


stepTest : Test
stepTest =
    describe "Steps"
        [ test "successfully runs a Step against a Glue function"
            <| \() ->
                let
                    ( _, _, assertion ) =
                        runStep step "" Glue.myGlue
                in
                    assertion
        ]


all : Test
all =
    describe "Features"
        [ stepTest
        ]
