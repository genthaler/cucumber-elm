module GherkinHtmlTest exposing (..)

import Expect
import Gherkin exposing (..)
import GherkinFixtures exposing (..)
import GherkinParser
import GherkinHtml
import Test exposing (..)


all : Test
all =
    describe "pretty printing Gherkin as HTML"
        [ test "parses Feature with tagsFooBar correctly"
            <| defer
            <| Expect.equal (GherkinParser.parse GherkinParser.feature featureWithTagsAndScenarioWithTagsAndScenarioOutlineWithTagsWithExamplesWithTagsContent)
            <| Result.Ok featureWithTagsAndScenarioWithTagsAndScenarioOutlineWithTagsWithExamplesWithTags
        ]
