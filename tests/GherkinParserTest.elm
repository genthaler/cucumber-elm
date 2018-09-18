module GherkinParserTest exposing (all)

import Expect
import Gherkin exposing (..)
import GherkinFixtures exposing (..)
import GherkinParser
import Parser exposing ((|.))
import Test exposing (..)

 
all : Test
all =
    describe "parsing Gherkin"
        [ test "parses Feature correctly" <|
            \_ ->
                Expect.equal (GherkinParser.parse GherkinParser.feature featureContent) <|
                    Result.Ok feature
        , test "parses Feature with tagsFooBar correctly" <|
            \_ ->
                Expect.equal (GherkinParser.parse GherkinParser.feature featureWithTagsAndScenarioWithTagsAndScenarioOutlineWithTagsWithExamplesWithTagsContent) <|
                    Result.Ok featureWithTagsAndScenarioWithTagsAndScenarioOutlineWithTagsWithExamplesWithTags
        ]
