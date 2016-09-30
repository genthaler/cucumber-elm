module CucumberTest exposing (..)

import Test exposing (..)
import Expect
import Gherkin exposing (..)
import Cucumber exposing (..)
import CucumberTest.Glue as Glue
import GherkinFixtures exposing (..)


testTestFeatureText : Test
testTestFeatureText =
    describe "testing testFeatureText "
        [ describe "successfully runs a Feature against a Glue function"
            [ testFeatureText [ Glue.myGlue ] "initial state" featureContent
            ]
        ]


testTestFeature : Test
testTestFeature =
    describe "testing testFeature "
        [ describe "successfully runs a Feature against a Glue function"
            [ testFeature [ Glue.myGlue ] "initial state" feature
            ]
        ]


testTestScenario : Test
testTestScenario =
    describe "testing testScenario "
        [ describe "successfully runs a Background and Scenario against a Glue function"
            [ testScenario [ Glue.myGlue ] "initial state" background1 scenario1
            ]
        ]


testTestBackground : Test
testTestBackground =
    describe "testing testBackground"
        [ describe "successfully runs Background against a Glue function"
            [ testBackground [ Glue.myGlue ] "initial state" background1 |> snd
            ]
        ]


testTestSteps : Test
testTestSteps =
    describe "testing testBackground"
        [ describe "successfully runs Steps against a Glue function"
            [ testSteps [ Glue.myGlue ] "initial state" [] [ givenTheQuickBrownFox, givenJumpsOverTheLazyDog ] |> snd
            ]
        ]


testTestStep : Test
testTestStep =
    describe "testing testStep"
        [ describe "successfully runs a Step against a Glue function"
            [ testStep [ Glue.myGlue ] "initial state" [] givenTheQuickBrownFox
                |> snd
            ]
        ]


all : Test
all =
    describe "CucumberTest"
        [ testTestStep
        , testTestSteps
        , testTestBackground
        , testTestScenario
        , testTestFeature
        , testTestFeatureText
        ]
