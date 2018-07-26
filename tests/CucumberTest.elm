module CucumberTest exposing (..)

import Cucumber exposing (..)
import CucumberTest.StepDef as StepDef
import GherkinFixtures exposing (..)
import Test exposing (..)
import Expect
import Gherkin exposing (..)
import Result.Extra


expectFeatureWith2ScenariosWithTagsContent : Test
expectFeatureWith2ScenariosWithTagsContent =
    describe "testing tags on Scenarios "
        [ test "successfully runs a Feature against a StepDef function that could fail if the wrong scenarios are selected throw tags"
            (\() ->
                Expect.false "Expecting true" <|
                    Result.Extra.isOk <|
                        expectFeatureText
                            ( "initial state"
                            , [ StepDef.failIfDescriptionContainsFail ]
                            )
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
                        expectFeature ( "initial state", [ StepDef.alwaysFail ] )
                            [ [ Tag "blah" ] ]
                            featureWithTags
            )
        , test "other feature"
            (\() ->
                Expect.true "Expecting true" <|
                    Result.Extra.isOk <|
                        expectFeature ( "initial state", [ StepDef.alwaysPass ] )
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
                            ( "initial state", [ StepDef.alwaysFail ] )
                            [ [ Tag "blah" ] ]
                            featureWithScenarioWithTags
            )
        , test "otjer"
            (\() ->
                Expect.true "Expecting true" <|
                    Result.Extra.isOk <|
                        expectFeature ( "initial state", [ StepDef.alwaysPass ] )
                            [ [ Tag "foo" ] ]
                            featureWithScenarioWithTags
            )
        ]


testTestFeatureText : Test
testTestFeatureText =
    describe "testing expectFeatureText "
        [ test "successfully runs a Feature against a StepDef function"
            (\() ->
                Expect.true "Expecting true" <|
                    Result.Extra.isOk <|
                        expectFeatureText ( "initial state", [ StepDef.alwaysPass ] ) [ noTags ] simpleFeatureContent
            )
        ]


testTestFeature : Test
testTestFeature =
    describe "testing expectFeature "
        [ test "successfully runs a Feature against a StepDef function"
            (\() ->
                Expect.true "Expecting true" <|
                    Result.Extra.isOk <|
                        expectFeature ( "initial state", [ StepDef.alwaysPass ] ) [ noTags ] simpleFeature
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
