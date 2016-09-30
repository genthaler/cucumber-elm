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


background : Background'
background =
    Background "pack my box" [ step1, step2 ]


scenario : Scenario
scenario =
    Scenario [] "with five dozen liquor jugs" [ step1, step2 ]


feature : Feature
feature =
    Feature []
        "Feature Runner"
        (AsA "regular person")
        (InOrderTo "verify a feature")
        (IWantTo "supply some glue code and run it against the feature")
        background
        [ scenario ]


testTestFeatureText : Test
testTestFeatureText =
    describe "testing testFeatureText "
        [ describe "successfully runs a Feature against a Glue function"
            [ testFeatureText [ Glue.myGlue ] "initial state" """Feature: Feature Runner
As a regular person
In order to verify a feature
I want to supply some glue code and run it against the feature
Background: pack my box
Given the quick brown fox
Scenario: with five dozen liquor jugs
Given the quick brown fox
When jumps over the lazy dog
            """
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
            [ testScenario [ Glue.myGlue ] "initial state" background scenario
            ]
        ]


testTestBackground : Test
testTestBackground =
    describe "testing testBackground"
        [ describe "successfully runs Background against a Glue function"
            [ testBackground [ Glue.myGlue ] "initial state" background |> snd
            ]
        ]


testTestSteps : Test
testTestSteps =
    describe "testing testBackground"
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
        , testTestBackground
        , testTestScenario
        , testTestFeature
        , testTestFeatureText
        ]
