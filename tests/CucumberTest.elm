module CucumberTest exposing (all, expectFeatureWith2ScenariosWithTagsContent, expectFeatureWithScenarioWithTags, expectFeatureWithTags, testTestFeature, testTestFeatureText)

import Cucumber exposing (..)
import CucumberTest.StepDefs as StepDefs
import Expect
import Gherkin exposing (..)
import GherkinFixtures exposing (..)
import Result.Extra
import Test exposing (..)
 

expectFeatureWith2ScenariosWithTagsContent : Test
expectFeatureWith2ScenariosWithTagsContent =
    describe "testing tags on Scenarios "
        [ test "successfully runs a Feature against a StepDef function that could fail if the wrong scenarios are selected throw tags"
            (\() ->
                Expect.false "Expecting true" <|
                    Result.Extra.isOk <|
                        expectFeatureText
                            ( "initial state"
                            , [ StepDefs.failIfDescriptionContainsFail ]
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
                        expectFeature ( "initial state", [ StepDefs.alwaysFail ] )
                            [ [ Tag "blah" ] ]
                            featureWithTags
            )
        , test "other feature"
            (\() ->
                Expect.true "Expecting true" <|
                    Result.Extra.isOk <|
                        expectFeature ( "initial state", [ StepDefs.alwaysPass ] )
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
                            ( "initial state", [ StepDefs.alwaysFail ] )
                            [ [ Tag "blah" ] ]
                            featureWithScenarioWithTags
            )
        , test "otjer"
            (\() ->
                Expect.true "Expecting true" <|
                    Result.Extra.isOk <|
                        expectFeature ( "initial state", [ StepDefs.alwaysPass ] )
                            [ [ Tag "foo" ] ]
                            featureWithScenarioWithTags
            )
        ]


testTestFeatureText : Test
testTestFeatureText =
    describe "testing expectFeatureText "
        [ test "successfully runs a Feature against a StepDefs function"
            (\() ->
                Expect.true "Expecting true" <|
                    Result.Extra.isOk <|
                        expectFeatureText ( "initial state", [ StepDefs.alwaysPass ] ) [ noTags ] simpleFeatureContent
            )
        ]


testTestFeature : Test
testTestFeature =
    describe "testing expectFeature "
        [ test "successfully runs a Feature against a StepDefs function"
            (\() ->
                Expect.true "Expecting true" <|
                    Result.Extra.isOk <|
                        expectFeature ( "initial state", [ StepDefs.alwaysPass ] ) [ noTags ] simpleFeature
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
