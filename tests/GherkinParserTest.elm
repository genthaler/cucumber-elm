module GherkinParserTest exposing (..)

import GherkinParser
import Test exposing (..)
import Expect
import GherkinFixtures
import GherkinFixtures


all : Test
all =
    describe "parsing Gherkin"
        [ test "parses Feature correctly" <|
            \() ->
                Expect.equal (GherkinParser.parse GherkinParser.feature GherkinFixtures.featureContent) <|
                    Result.Ok GherkinFixtures.feature
        , test "parses Feature with tagsFooBar correctly" <|
            \() ->
                Expect.equal (GherkinParser.parse GherkinParser.feature GherkinFixtures.featureWithTagsAndScenarioWithTagsAndScenarioOutlineWithTagsWithExamplesWithTagsContent) <|
                    Result.Ok GherkinFixtures.featureWithTagsAndScenarioWithTagsAndScenarioOutlineWithTagsWithExamplesWithTags
        ]
