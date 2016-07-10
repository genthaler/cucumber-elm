module CucumberTest exposing (..)

import ElmTest exposing (suite)
import Gherkin exposing (..)
import Cucumber exposing (..)
import CucumberTest.Glue as Glue
import ElmTestBDDStyle exposing (..)


step : Step
step =
    Given "Now is the time" (DocString "")


stepTest : Test
stepTest =
    describe "Features"
        [ it "successfully runs a Step against a Glue function"
            <| (runStep step "" Glue.myGlue
                    |> snd
               )
        ]


all : Test
all =
    suite "Features"
        [ stepTest
        ]
