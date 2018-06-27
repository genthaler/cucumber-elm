module CucumberTest exposing (..)

import Cucumber exposing (..)
import CucumberTest.Glue as Glue
import GherkinFixtures exposing (..)
import Test exposing (..)
import Gherkin exposing (..)


expectFeatureWith2ScenariosWithTagsContent : Test
expectFeatureWith2ScenariosWithTagsContent =
    describe "testing tags on Scenarios "
        [ describe "successfully runs a Feature against a Glue function that could fail if the wrong scenarios are selected throw tags"
            [ expectFeatureText
                [ Glue.failIfDescriptionContainsFail
                ]
                "initial state"
                [ [ Tag "bar" ] ]
                featureWith2ScenariosWithTagsContent
            ]
        ]


expectFeatureWithTags : Test
expectFeatureWithTags =
    describe "testing feature with tags"
        [ describe "successfully applies tags"
            [ expectFeature [ Glue.alwaysFail ]
                "initial state"
                [ [ Tag "blah" ] ]
                featureWithTags
            , expectFeature [ Glue.alwaysPass ]
                "initial state"
                [ [ Tag "foo" ] ]
                featureWithTags
            ]
        ]


expectFeatureWithScenarioWithTags : Test
expectFeatureWithScenarioWithTags =
    describe "testing feature with scenario with tags"
        [ describe "successfully applies tags"
            [ expectFeature [ Glue.alwaysFail ]
                "initial state"
                [ [ Tag "blah" ] ]
                featureWithScenarioWithTags
            , expectFeature [ Glue.alwaysPass ]
                "initial state"
                [ [ Tag "foo" ] ]
                featureWithScenarioWithTags
            ]
        ]


testTestFeatureText : Test
testTestFeatureText =
    describe "testing expectFeatureText "
        [ describe "successfully runs a Feature against a Glue function"
            [ expectFeatureText [ Glue.alwaysPass ] "initial state" [ noTags ] simpleFeatureContent
            ]
        ]



-- testTestFeature : Test
-- testTestFeature =
--     describe "testing expectFeature "
--         [ describe "successfully runs a Feature against a Glue function"
--             [ expectFeature [ Glue.alwaysPass ] "initial state" [ noTags ] simpleFeature
--             ]
--         ]
--
-- all : Test
-- all =
--     describe "Test the Cucumber API"
--         [ --testTestFeature
--           -- ,
--           testTestFeatureText
--         , expectFeatureWithTags
--         , expectFeatureWithScenarioWithTags
--         , expectFeatureWith2ScenariosWithTagsContent
--         ]
