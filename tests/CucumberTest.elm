module CucumberTest exposing (..)

import Test exposing (..)
import Expect
import Gherkin exposing (..)
import Cucumber exposing (..)
import CucumberTest.Glue as Glue


step1 : Step
step1 =
    Given "the quick brown fox" NoArg


step2 : Step
step2 =
    Given "jumps over the lazy dog" NoArg


testTestSteps : Test
testTestSteps =
    describe "testing testSteps"
        [ describe "successfully runs Steps against a Glue function"
            [ testSteps [ Glue.myGlue ] "initial state" [] [ step1, step2 ] |> snd
            ]
        ]


testTestStep : Test
testTestStep =
    describe "testing testStep"
        [ describe "successfully runs a Step against a Glue function"
            [ testStep [ Glue.myGlue ] "initial state" [] step1
                |> snd
            ]
        ]


all : Test
all =
    describe "CucumberTest"
        [ testTestStep
        , testTestSteps
        ]
