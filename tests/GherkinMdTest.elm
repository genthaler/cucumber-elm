module GherkinMdTest exposing (..)

import Expect exposing (equal, fail, pass)
import GherkinFixtures exposing (..)
import GherkinMd exposing (featureMd)
import GherkinParser
import Test exposing (..)


all : Test
all =
    describe "pretty printing Gherkin as HTML"
        [ test "parses Feature with tagsFooBar correctly" <|
            defer <|
                let
                    res =
                        GherkinParser.parse
                            GherkinParser.feature
                            featureWithTagsAndScenarioWithTagsAndScenarioOutlineWithTagsWithExamplesWithTagsContent
                in
                    case res of
                        Ok myFeature ->
                            equal (featureMd myFeature) ""

                        Err error ->
                            fail error
        ]
