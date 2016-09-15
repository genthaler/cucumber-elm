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
    describe "Features"
        [ test "successfully runs a Step against a Glue function"
            <| (runStep step "" Glue.myGlue
                    |> snd
               )
        ]


all : Test
all =
    suite "Features"
        [ stepTest
        ]
