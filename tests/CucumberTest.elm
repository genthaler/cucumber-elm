module CucumberTest exposing (..)

import Test exposing (..)
import Expect exposing (..)
import Cucumber exposing (..)
import CucumberTest.Glue as Glue
import GherkinFixtures exposing (..)


testFeatureWithTags : Test
testFeatureWithTags =
    describe "testing tags on features"
        [ describe "successfully applies tags"
            [ testSteps [ Glue.glue ] "initial state" [ givenTheQuickBrownFox, givenJumpsOverTheLazyDog ] |> snd
            ]
        ]


testTestFeatureText : Test
testTestFeatureText =
    describe "testing testFeatureText "
        [ describe "successfully runs a Feature against a Glue function"
            [ testFeatureText [ Glue.glue ] "initial state" noTags simpleFeatureContent
            ]
        ]


testTestFeature : Test
testTestFeature =
    describe "testing testFeature "
        [ describe "successfully runs a Feature against a Glue function"
            [ testFeature [ Glue.glue ] "initial state" noTags simpleFeature
            ]
        ]


testTestScenario : Test
testTestScenario =
    describe "testing testScenario"
        [ describe "successfully runs a Background and Scenario against a Glue function"
            [ testScenario [ Glue.glue ] "initial state" background1 noTags simpleScenario
            ]
        ]


testTestBackground : Test
testTestBackground =
    describe "testing testBackground"
        [ describe "successfully runs Background against a Glue function"
            [ testBackground [ Glue.glue ] "initial state" background1 |> snd
            ]
        ]


testTestSteps : Test
testTestSteps =
    describe "testing testBackground"
        [ describe "successfully runs Steps against a Glue function"
            [ testSteps [ Glue.glue ] "initial state" [ givenTheQuickBrownFox, givenJumpsOverTheLazyDog ] |> snd
            ]
        ]


testTestStep : Test
testTestStep =
    describe "testing testStep"
        [ describe "successfully runs a Step against a Glue function"
            [ testStep [ Glue.glue ] "initial state" givenTheQuickBrownFox
                |> snd
            ]
        ]


testMatchTags : Test
testMatchTags =
    describe "testing matchTags"
        [ test "no filter tags"
            <| \() ->
                Expect.true "if either of the supplied tag lists are empty, then return True"
                    <| matchTags [] tags
        , test "no element tags"
            <| \() ->
                Expect.true "if either of the supplied tag lists are empty, then return True"
                    <| matchTags tags []
        , test "a matching tag"
            <| \() ->
                Expect.true "if there's at least one match, then return True"
                    <| matchTags [ "q", "w", "e" ] [ "e", "r", "t" ]
        , test "no matching tags"
            <| \() ->
                Expect.false "if there's at least one match, then return True"
                    <| matchTags [ "q", "w", "e" ] [ "a", "s", "d" ]
        ]


all : Test
all =
    describe "CucumberTest"
        [ testMatchTags
        , testTestStep
        , testTestSteps
        , testTestBackground
        , testTestScenario
        , testTestFeature
        , testTestFeatureText
        ]
