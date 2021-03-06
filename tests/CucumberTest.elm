module CucumberTest exposing (..)

import Cucumber exposing (..)
import CucumberTest.Glue as Glue
import GherkinFixtures exposing (..)
import Test exposing (..)
import Expect
import Gherkin exposing (..)
import Result.Extra


expectFeatureWith2ScenariosWithTagsContent : Test
expectFeatureWith2ScenariosWithTagsContent =
    describe "testing tags on Scenarios "
        [ test "successfully runs a Feature against a Glue function that could fail if the wrong scenarios are selected throw tags"
            (\() ->
                Expect.false "Expecting true" <|
                    Result.Extra.isOk <|
                        expectFeatureText
                            [ Glue.failIfDescriptionContainsFail ]
                            "initial state"
                            [ [ Tag "bar" ] ]
                            featureWith2ScenariosWithTagsContent
            )
        ]


expectFeatureWithTags : Test
expectFeatureWithTags =
    describe "testing feature with tags"
        [ test "successfully applies tags"
            (\() ->
                Expect.false "Expecting true" <|
                    Result.Extra.isOk <|
                        expectFeature [ Glue.alwaysFail ]
                            "initial state"
                            [ [ Tag "blah" ] ]
                            featureWithTags
            )
        , test "other feature"
            (\() ->
                Expect.true "Expecting true" <|
                    Result.Extra.isOk <|
                        expectFeature [ Glue.alwaysPass ]
                            "initial state"
                            [ [ Tag "foo" ] ]
                            featureWithTags
            )
        ]


expectFeatureWithScenarioWithTags : Test
expectFeatureWithScenarioWithTags =
    describe "testing feature with scenario with tags"
        [ test "successfully applies tags to scenarios"
            (\() ->
                Expect.false "Expecting true" <|
                    Result.Extra.isOk <|
                        expectFeature
                            [ Glue.alwaysFail ]
                            "initial state"
                            [ [ Tag "blah" ] ]
                            featureWithScenarioWithTags
            )
        , test "otjer"
            (\() ->
                Expect.true "Expecting true" <|
                    Result.Extra.isOk <|
                        expectFeature [ Glue.alwaysPass ]
                            "initial state"
                            [ [ Tag "foo" ] ]
                            featureWithScenarioWithTags
            )
        ]


testTestFeatureText : Test
testTestFeatureText =
    describe "testing expectFeatureText "
        [ test "successfully runs a Feature against a Glue function"
            (\() ->
                Expect.true "Expecting true" <|
                    Result.Extra.isOk <|
                        expectFeatureText [ Glue.alwaysPass ] "initial state" [ noTags ] simpleFeatureContent
            )
        ]


testTestFeature : Test
testTestFeature =
    describe "testing expectFeature "
        [ test "successfully runs a Feature against a Glue function"
            (\() ->
                Expect.true "Expecting true" <|
                    Result.Extra.isOk <|
                        expectFeature [ Glue.alwaysPass ] "initial state" [ noTags ] simpleFeature
            )
        ]


all : Test
all =
    describe "Test the Cucumber API"
        [ testTestFeature
        , testTestFeatureText
        , expectFeatureWithTags
        , expectFeatureWithScenarioWithTags
        , expectFeatureWith2ScenariosWithTagsContent
        ]
