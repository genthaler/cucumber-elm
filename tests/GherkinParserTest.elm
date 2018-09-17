module GherkinParserTest exposing (all)

import Expect
import Gherkin exposing (..)
import GherkinFixtures exposing (..)
import GherkinParser
import Test exposing (..)
import Parser exposing ((|.))

all : Test
all =
    describe "parsing Gherkin"
        [ test "parses comments correctly" <|
            \_ ->
                let
                    comment =
                        "# some comment"
                in
                Expect.equal (GherkinParser.parse GherkinParser.comment comment)
                    (Result.Ok ())
        , only <|
            test "parse whitespace correctly" <|
                \_ ->
                    Expect.equal (GherkinParser.parse (Parser.succeed () |. GherkinParser.zeroOrMore (Parser.oneOf [GherkinParser.space, GherkinParser.tab]) |. Parser.end) "  ")
                        (Result.Ok ())
        , test "parses AsA correctly" <|
            \_ ->
                let
                    asA =
                        "super dev"

                    asADesc =
                        "As a" ++ " " ++ asA ++ "\n"
                in
                Expect.equal (GherkinParser.parse GherkinParser.asA asADesc)
                    (Result.Ok (AsA asA))
        , test "parses InOrderTo correctly" <|
            \_ ->
                let
                    inOrderTo =
                        "write super apps"

                    inOrderToDesc =
                        "In order to" ++ " " ++ inOrderTo ++ "\n"
                in
                Expect.equal (GherkinParser.parse GherkinParser.inOrderTo inOrderToDesc)
                    (Result.Ok (InOrderTo inOrderTo))
        , test "parses IWantTo correctly" <|
            \_ ->
                let
                    iWantTo =
                        "use Elm"

                    iWantToDesc =
                        "I want to" ++ " " ++ iWantTo ++ "\n"
                in
                Expect.equal (GherkinParser.parse GherkinParser.iWantTo iWantToDesc) <|
                    Result.Ok (IWantTo iWantTo)
        , test "parses Background correctly" <|
            \_ ->
                Expect.equal (GherkinParser.parse GherkinParser.background backgroundContent2) <|
                    Result.Ok <|
                        background2
        , test "parses DocString correctly" <|
            \_ ->
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
            \_ ->
                Expect.equal (GherkinParser.parse GherkinParser.tableCellContent "asdf | ") <|
                    Result.Ok "asdf"
        , test "parses DataTable row correctly" <|
            \_ ->
                Expect.equal (GherkinParser.parse GherkinParser.tableRow tableRowContent) <|
                    Result.Ok [ "Now", "is", "the", "time" ]
        , test "parses DataTable correctly" <|
            \_ ->
                Expect.equal (GherkinParser.parse GherkinParser.table tableContent1) <|
                    Result.Ok table1
        , test "parses Given Step with DataTable correctly" <|
            \_ ->
                Expect.equal (GherkinParser.parse GherkinParser.step stepContent) <|
                    Result.Ok givenIAmTryingToHaveFun
        , test "parses But Step with NoArg correctly" <|
            \_ ->
                Expect.equal (GherkinParser.parse GherkinParser.step stepContent2) <|
                    Result.Ok butIAmTryingNotToBeAFool
        , test "parses Examples correctly" <|
            \_ ->
                Expect.equal (GherkinParser.parse GherkinParser.examples examplesContentWithTag) <|
                    Result.Ok examplesWithTag
        , test "parses Scenario correctly" <|
            \_ ->
                Expect.equal (GherkinParser.parse GherkinParser.scenario scenarioContent) <|
                    Result.Ok scenario
        , test "parses Scenario with tagsFooBar correctly" <|
            \_ ->
                Expect.equal (GherkinParser.parse GherkinParser.scenario scenarioWithTagsContent) <|
                    Result.Ok scenarioWithTags
        , test "parses Scenario Outline correctly" <|
            \_ ->
                Expect.equal (GherkinParser.parse GherkinParser.scenarioOutline scenarioOutlineContent) <|
                    Result.Ok scenarioOutline
        , test "parses Scenario Outline with tagsFooBar correctly" <|
            \_ ->
                Expect.equal (GherkinParser.parse GherkinParser.scenarioOutline scenarioOutlineWithTagsContent) <|
                    Result.Ok scenarioOutlineWithTags
        , test "parses Feature correctly" <|
            \_ ->
                Expect.equal (GherkinParser.parse GherkinParser.feature featureContent) <|
                    Result.Ok feature
        , test "parses Feature with tagsFooBar correctly" <|
            \_ ->
                Expect.equal (GherkinParser.parse GherkinParser.feature featureWithTagsAndScenarioWithTagsAndScenarioOutlineWithTagsWithExamplesWithTagsContent) <|
                    Result.Ok featureWithTagsAndScenarioWithTagsAndScenarioOutlineWithTagsWithExamplesWithTags
        ]
