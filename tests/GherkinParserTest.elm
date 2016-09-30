module GherkinParserTest exposing (..)

import Gherkin exposing (..)
import GherkinParser
import Test exposing (..)
import Expect
import GherkinFixtures exposing (..)


all : Test
all =
    describe "parsing Gherkin"
        [ test "parses comments correctly"
            <| defer
            <| let
                comment =
                    "# some comment"
               in
                Expect.equal (GherkinParser.parse GherkinParser.comment comment)
                    (Result.Ok comment)
        , test "parses spaces correctly"
            <| defer
            <| let
                whitespace =
                    "  "
               in
                Expect.equal (GherkinParser.parse GherkinParser.spaces whitespace)
                    (Result.Ok whitespace)
        , test "parses AsA correctly"
            <| defer
            <| let
                asA =
                    "super dev"

                asADesc =
                    "As a" ++ " " ++ asA ++ "\n"
               in
                Expect.equal (GherkinParser.parse GherkinParser.asA asADesc)
                    (Result.Ok (AsA asA))
        , test "parses InOrderTo correctly"
            <| defer
            <| let
                inOrderTo =
                    "write super apps"

                inOrderToDesc =
                    "In order to" ++ " " ++ inOrderTo ++ "\n"
               in
                Expect.equal (GherkinParser.parse GherkinParser.inOrderTo inOrderToDesc)
                    (Result.Ok (InOrderTo inOrderTo))
        , test "parses IWantTo correctly"
            <| defer
            <| let
                iWantTo =
                    "use Elm"

                iWantToDesc =
                    "I want to" ++ " " ++ iWantTo ++ "\n"
               in
                Expect.equal (GherkinParser.parse GherkinParser.iWantTo iWantToDesc)
                    <| Result.Ok (IWantTo iWantTo)
        , test "parses Background correctly"
            <| defer
            <| Expect.equal (GherkinParser.parse GherkinParser.background backgroundContent2)
            <| Result.Ok
            <| background2
        , test "parses DocString \"\"\" quotes correctly"
            <| defer
            <| let
                docStringQuotes =
                    "\"\"\""
               in
                Expect.equal (GherkinParser.parse GherkinParser.docStringQuotes docStringQuotes)
                    (Result.Ok docStringQuotes)
        , test "parses DocString correctly"
            <| defer
            <| let
                docStringQuotes =
                    "\"\"\""

                docString =
                    docStringQuotes ++ nowIsTheTime ++ docStringQuotes
               in
                Expect.equal (GherkinParser.parse GherkinParser.docString docString)
                    <| Result.Ok
                    <| DocString nowIsTheTime
        , test "parses tableCellDelimiter correctly"
            <| defer
            <| Expect.equal (GherkinParser.parse GherkinParser.tableCellDelimiter "|")
            <| Result.Ok "|"
        , test "parses tableCellContent correctly"
            <| defer
            <| Expect.equal (GherkinParser.parse GherkinParser.tableCellContent "asdf | ")
            <| Result.Ok "asdf"
        , test "parses DataTable row correctly"
            <| defer
            <| Expect.equal (GherkinParser.parse GherkinParser.tableRow tableRowContent)
            <| Result.Ok [ "Now", "is", "the", "time" ]
        , test "parses DataTable correctly"
            <| defer
            <| Expect.equal (GherkinParser.parse GherkinParser.table tableContent1)
            <| Result.Ok table1
        , test "parses Given Step with DataTable correctly"
            <| defer
            <| Expect.equal (GherkinParser.parse GherkinParser.step stepContent)
            <| Result.Ok givenIAmTryingToHaveFun
        , test "parses But Step with NoArg correctly"
            <| defer
            <| Expect.equal (GherkinParser.parse GherkinParser.step stepContent2)
            <| Result.Ok butIAmTryingNotToBeAFool
        , test "parses Examples correctly"
            <| defer
            <| Expect.equal (GherkinParser.parse GherkinParser.examples examplesContentWithTag)
            <| Result.Ok examplesWithTag
        , test "parses Scenario correctly"
            <| defer
            <| Expect.equal (GherkinParser.parse GherkinParser.scenario scenarioContent)
            <| Result.Ok scenario
        , test "parses Scenario with tags correctly"
            <| defer
            <| Expect.equal (GherkinParser.parse GherkinParser.scenario scenarioWithTagsContent)
            <| Result.Ok scenarioWithTags
        , test "parses Scenario Outline correctly"
            <| defer
            <| Expect.equal (GherkinParser.parse GherkinParser.scenarioOutline scenarioOutlineContent)
            <| Result.Ok scenarioOutline
        , test "parses Scenario Outline with tags correctly"
            <| defer
            <| Expect.equal (GherkinParser.parse GherkinParser.scenarioOutline scenarioOutlineWithTagsContent)
            <| Result.Ok scenarioOutlineWithTags
        , test "parses Feature correctly"
            <| defer
            <| Expect.equal (GherkinParser.parse GherkinParser.feature featureContent2)
            <| Result.Ok feature2
        , test "parses Feature with tags correctly"
            <| defer
            <| Expect.equal (GherkinParser.parse GherkinParser.feature featureContent3)
            <| Result.Ok feature3
        ]
