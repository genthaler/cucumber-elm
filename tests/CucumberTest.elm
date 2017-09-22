module CucumberTest exposing (..)

import Cucumber exposing (..)
import CucumberTest.Glue as Glue
import Expect exposing (..)
import GherkinFixtures exposing (..)
import Test exposing (..)


testFeatureWith2ScenariosWithTagsContent : Test
testFeatureWith2ScenariosWithTagsContent =
    describe "testing tags on Scenarios "
        [ describe "successfully runs a Feature against a Glue function that could fail if the wrong scenarios are selected throw tags"
            [ testFeatureText
                [ Glue.failIfDescriptionContainsFail
                ]
                "initial state"
                [ [ "bar" ] ]
                featureWith2ScenariosWithTagsContent
            ]
        ]


testFeatureWithTags : Test
testFeatureWithTags =
    describe "testing tagsFooBar on features"
        [ describe "successfully applies tags"
            [ testFeature [ Glue.alwaysFail ]
                "initial state"
                [ [ "blah" ] ]
                featureWithTags
            , testFeature [ Glue.alwaysPass ]
                "initial state"
                [ [ "foo" ] ]
                featureWithTags
            ]
        ]


testFeatureWithScenarioWithTags : Test
testFeatureWithScenarioWithTags =
    describe "testing tagsFooBar on features"
        [ describe "successfully applies tags"
            [ testFeature [ Glue.alwaysFail ]
                "initial state"
                [ [ "blah" ] ]
                featureWithScenarioWithTags
            , testFeature [ Glue.alwaysPass ]
                "initial state"
                [ [ "foo" ] ]
                featureWithScenarioWithTags
            ]
        ]


testTestFeatureText : Test
testTestFeatureText =
    describe "testing testFeatureText "
        [ describe "successfully runs a Feature against a Glue function"
            [ testFeatureText [ Glue.alwaysPass ] "initial state" [ noTags ] simpleFeatureContent
            ]
        ]


testTestFeature : Test
testTestFeature =
    describe "testing testFeature "
        [ describe "successfully runs a Feature against a Glue function"
            [ testFeature [ Glue.alwaysPass ] "initial state" [ noTags ] simpleFeature
            ]
        ]


testTestScenario : Test
testTestScenario =
    describe "testing testScenario"
        [ describe "successfully runs a Background and Scenario against a Glue function"
            [ testScenario [ Glue.alwaysPass ] "initial state" background1 [ noTags ] simpleScenario
            ]
        ]


testTestBackground : Test
testTestBackground =
    describe "testing testBackground"
        [ describe "successfully runs Background against a Glue function"
            [ testBackground [ Glue.alwaysPass ] "initial state" background1 |> Tuple.second
            ]
        ]


testTestSteps : Test
testTestSteps =
    describe "testing testBackground"
        [ describe "successfully runs Steps against a Glue function"
            [ testSteps [ Glue.alwaysPass ] "initial state" [ givenTheQuickBrownFox, givenJumpsOverTheLazyDog ] |> Tuple.second
            ]
        ]


testTestStep : Test
testTestStep =
    describe "testing testStep"
        [ describe "successfully runs a Step against a Glue function"
            [ testStep [ Glue.alwaysPass ] "initial state" givenTheQuickBrownFox
                |> Tuple.second
              -- , testStep [ Glue.alwaysPass, Glue.alwaysPass ] "initial state" givenTheQuickBrownFox
              --     |> snd
              --     |> test "expect multiple glue functions that return a Just Expectation to fail testing"
            ]
        ]


testMatchTags : Test
testMatchTags =
    describe "testing matchTags"
        [ test "no element tags" <|
            \() ->
                Expect.true "if the element list is empty, then return True" <|
                    matchTags [ tagsFooBar ] []
        , test "a matching tag" <|
            \() ->
                Expect.true "if there's at least one match, then return True" <|
                    matchTags [ [ "e" ] ] [ "e", "r", "t" ]
        , test "more matching tags" <|
            \() ->
                Expect.true "if there's at least one match, then return True" <|
                    matchTags [ [ "e", "r" ], [ "z" ] ] [ "e", "r", "t" ]
        , test "more matching tags" <|
            \() ->
                Expect.true "if some and-ed tags don't match, but some do, then return True" <|
                    matchTags [ [ "e", "x" ], [ "t" ] ] [ "e", "r", "t" ]
        , test "not enough matching tags" <|
            \() ->
                Expect.false "if and-ed tags don't match, then return False" <|
                    matchTags [ [ "e", "x" ], [ "z" ] ] [ "e", "r", "t" ]
        , test "no filter tags" <|
            \() ->
                Expect.true "if there are filter tags, but no element tags, then return True" <|
                    matchTags [ tagsFooBar ] []
        , test "no matching tags" <|
            \() ->
                Expect.false "if there's at least one match, then return True" <|
                    matchTags [ [ "q", "w", "e" ] ] [ "a", "s", "d" ]
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
        , testFeatureWithTags
        , testFeatureWithScenarioWithTags
        , testFeatureWith2ScenariosWithTagsContent
        ]
