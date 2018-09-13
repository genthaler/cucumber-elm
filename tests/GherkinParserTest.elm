module GherkinParserTest exposing (all)

import Expect
import Gherkin exposing (..)
import GherkinFixtures exposing (..)
import GherkinParser
import Parser exposing ((|.), (|=), Parser, Trailing(..), chompUntilEndOr, chompWhile, deadEndsToString, end, getChompedString, keyword, lineComment, loop, map, oneOf, run, sequence, succeed, symbol, token, variable)
import Test exposing (..)


all : Test
all =
    describe "parsing Gherkin"
        [ test "parses comments correctly" <|
            defer <|
                let
                    comment =
                        "# some comment"
                in
                Expect.equal (GherkinParser.parse GherkinParser.comment comment)
                    (Result.Ok ())
        , test "parses AsA correctly" <|
            defer <|
                let
                    asA =
                        "super dev"

                    asADesc =
                        "As a" ++ " " ++ asA ++ "\n"
                in
                Expect.equal (GherkinParser.parse GherkinParser.asA asADesc)
                    (Result.Ok (AsA asA))
        , test "parses InOrderTo correctly" <|
            defer <|
                let
                    inOrderTo =
                        "write super apps"

                    inOrderToDesc =
                        "In order to" ++ " " ++ inOrderTo ++ "\n"
                in
                Expect.equal (GherkinParser.parse GherkinParser.inOrderTo inOrderToDesc)
                    (Result.Ok (InOrderTo inOrderTo))
        , test "parses IWantTo correctly" <|
            defer <|
                let
                    iWantTo =
                        "use Elm"

                    iWantToDesc =
                        "I want to" ++ " " ++ iWantTo ++ "\n"
                in
                Expect.equal (GherkinParser.parse GherkinParser.iWantTo iWantToDesc) <|
                    Result.Ok (IWantTo iWantTo)
        , test "parses Background correctly" <|
            defer <|
                Expect.equal (GherkinParser.parse GherkinParser.background backgroundContent2) <|
                    Result.Ok <|
                        background2
        , test "parses DocString correctly" <|
            defer <|
                let
                    docStringQuotes =
                        "\"\"\""

                    docString =
                        docStringQuotes ++ nowIsTheTime ++ docStringQuotes
                in
                Expect.equal (GherkinParser.parse GherkinParser.docString docString) <|
                    Result.Ok <|
                        DocString nowIsTheTime
        , test "parses tableCellContent correctly" <|
            defer <|
                Expect.equal (GherkinParser.parse GherkinParser.tableCellContent "asdf | ") <|
                    Result.Ok "asdf"
        , only <|
            test "parses DataTable row correctly" <|
                defer <|
                    Expect.equal (GherkinParser.parse GherkinParser.tableRow tableRowContent) <|
                        Result.Ok [ "Now", "is", "the", "time" ]
        , test "parses DataTable correctly" <|
            defer <|
                Expect.equal (GherkinParser.parse GherkinParser.table tableContent1) <|
                    Result.Ok table1
        , test "parses Given Step with DataTable correctly" <|
            defer <|
                Expect.equal (GherkinParser.parse GherkinParser.step stepContent) <|
                    Result.Ok givenIAmTryingToHaveFun
        , test "parses But Step with NoArg correctly" <|
            defer <|
                Expect.equal (GherkinParser.parse GherkinParser.step stepContent2) <|
                    Result.Ok butIAmTryingNotToBeAFool
        , test "parses Examples correctly" <|
            defer <|
                Expect.equal (GherkinParser.parse GherkinParser.examples examplesContentWithTag) <|
                    Result.Ok examplesWithTag
        , test "parses Scenario correctly" <|
            defer <|
                Expect.equal (GherkinParser.parse GherkinParser.scenario scenarioContent) <|
                    Result.Ok scenario
        , test "parses Scenario with tagsFooBar correctly" <|
            defer <|
                Expect.equal (GherkinParser.parse GherkinParser.scenario scenarioWithTagsContent) <|
                    Result.Ok scenarioWithTags
        , test "parses Scenario Outline correctly" <|
            defer <|
                Expect.equal (GherkinParser.parse GherkinParser.scenarioOutline scenarioOutlineContent) <|
                    Result.Ok scenarioOutline
        , test "parses Scenario Outline with tagsFooBar correctly" <|
            defer <|
                Expect.equal (GherkinParser.parse GherkinParser.scenarioOutline scenarioOutlineWithTagsContent) <|
                    Result.Ok scenarioOutlineWithTags
        , test "parses Feature correctly" <|
            defer <|
                Expect.equal (GherkinParser.parse GherkinParser.feature featureContent) <|
                    Result.Ok feature
        , test "parses Feature with tagsFooBar correctly" <|
            defer <|
                Expect.equal (GherkinParser.parse GherkinParser.feature featureWithTagsAndScenarioWithTagsAndScenarioOutlineWithTagsWithExamplesWithTagsContent) <|
                    Result.Ok featureWithTagsAndScenarioWithTagsAndScenarioOutlineWithTagsWithExamplesWithTags
        ]
