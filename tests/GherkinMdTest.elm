module GherkinMdTest exposing (..)

import Expect
import GherkinFixtures exposing (..)
import GherkinMd exposing (..)
import GherkinParser
import Test exposing (..)


all : Test
all =
    describe "pretty printing Gherkin as HTML"
        [ test "parses Feature with tagsFooBar correctly" <|
            defer <|
                (let
                    x =
                        1
                 in
                    Expect.equal (GherkinParser.parse GherkinParser.feature featureWithTagsAndScenarioWithTagsAndScenarioOutlineWithTagsWithExamplesWithTagsContent) <|
                        Result.Ok featureWithTagsAndScenarioWithTagsAndScenarioOutlineWithTagsWithExamplesWithTags
                )
        ]
