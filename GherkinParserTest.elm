module GherkinParserTest exposing (..)

import Combine
import Gherkin exposing (..)
import GherkinParser
import ElmTestBDDStyle exposing (..)
import String


all : Test
all =
    describe "Example Text"
        [ it "parses comments correctly"
            <| let
                comment =
                    "# some comment"

                newline =
                    "\n"

                result =
                    Combine.parse GherkinParser.comment (comment ++ newline)
               in
                expect result toBe ( Result.Ok comment, Combine.Context "" 15 )
        , it "parses spaces correctly"
            <| let
                whitespace =
                    "  "

                result =
                    Combine.parse GherkinParser.spaces whitespace
               in
                expect result toBe ( Result.Ok whitespace, Combine.Context "" 2 )
        , it "parses AsA correctly"
            <| let
                asA =
                    "super dev"

                result =
                    Combine.parse GherkinParser.asA ("As a" ++ " " ++ asA ++ "\n")
               in
                expect result toBe ( Result.Ok (AsA asA), Combine.Context "" 15 )
        , it "parses InOrderTo correctly"
            <| let
                inOrderTo =
                    "write super apps"

                result =
                    Combine.parse GherkinParser.inOrderTo ("In order to" ++ " " ++ inOrderTo ++ "\n")
               in
                expect result toBe ( Result.Ok (InOrderTo inOrderTo), Combine.Context "" 29 )
        , it "parses IWantTo correctly"
            <| let
                iWantTo =
                    "use Elm"

                result =
                    Combine.parse GherkinParser.iWantTo ("I want to" ++ " " ++ iWantTo ++ "\n")
               in
                expect result toBe ( Result.Ok (IWantTo iWantTo), Combine.Context "" 18 )
        , it "parses DocString \"\"\" quotes correctly"
            <| let
                docStringQuotes =
                    "\"\"\""

                result =
                    Combine.parse GherkinParser.docStringQuotes docStringQuotes
               in
                expect result toBe ( Result.Ok docStringQuotes, Combine.Context "" (String.length docStringQuotes) )
        , it "parses DocString correctly"
            <| let
                docStringQuotes =
                    "\"\"\""

                docStringContent =
                    "Now is the time"

                result =
                    Combine.parse GherkinParser.docString (docStringQuotes ++ docStringContent ++ docStringQuotes)
               in
                expect result toBe ( Result.Ok (DocString docStringContent), Combine.Context "" 21 )
        , it "parses dataTableCellDelimiter correctly"
            <| expect (Combine.parse GherkinParser.dataTableCellDelimiter "|") toBe ( Result.Ok "|", Combine.Context "" 1 )
        , it "parses dataTableCellContent correctly"
            <| expect (Combine.parse GherkinParser.dataTableCellContent "asdf | ") toBe ( Result.Ok "asdf", Combine.Context " | " 4 )
        , it "parses DataTable row correctly"
            <| let
                dataTableContent =
                    "| Now | is | the | time | "

                result =
                    Combine.parse GherkinParser.dataTableRow dataTableContent
               in
                expect result toBe ( Result.Ok [ "Now", "is", "the", "time" ], Combine.Context "" (String.length dataTableContent) )
        , it "parses DataTable correctly"
            <| let
                dataTableContent =
                    """ | Now | is | the | time |
                              | For | all | good | men | """

                result =
                    Combine.parse GherkinParser.dataTable dataTableContent
               in
                expect result toBe ( Result.Ok (DataTable [ [ "Now", "is", "the", "time" ], [ "For", "all", "good", "men" ] ]), Combine.Context "" (String.length dataTableContent) )
        , it "parses Given Step with DataTable correctly"
            <| let
                stepContent =
                    """Given I am trying to have fun
                      | Now | is | the | time |
                      | For | all | good | men | """

                result =
                    Combine.parse GherkinParser.step stepContent
               in
                expect result
                    toBe
                    ( Result.Ok
                        (Given "I am trying to have fun"
                            <| DataTable
                                [ [ "Now", "is", "the", "time" ]
                                , [ "For", "all", "good", "men" ]
                                ]
                        )
                    , Combine.Context "" (String.length stepContent)
                    )
        , it "parses But Step with NoArg correctly"
            <| let
                stepContent =
                    "But I am trying not to be a toolie\n"

                result =
                    Combine.parse GherkinParser.step stepContent
               in
                expect result
                    toBe
                    ( Result.Ok
                        (But "I am trying not to be a toolie"
                            <| NoArg
                        )
                    , Combine.Context "" (String.length stepContent)
                    )
        , it "parses Scenario correctly"
            <| let
                scenarioContent =
                    """Scenario: Have fun
                      Given I am trying to have fun
                        | Now | is | the | time |
                        | For | all | good | men |
                      But I am trying not to be a toolie
"""

                result =
                    Combine.parse GherkinParser.scenario scenarioContent
               in
                expect result
                    toBe
                    ( Result.Ok
                        (Scenario "Have fun"
                            [ (Given "I am trying to have fun"
                                <| DataTable
                                    [ [ "Now", "is", "the", "time" ]
                                    , [ "For", "all", "good", "men" ]
                                    ]
                              )
                            , (But "I am trying not to be a toolie"
                                <| NoArg
                              )
                            ]
                        )
                    , Combine.Context "" (String.length scenarioContent)
                    )
        ]
