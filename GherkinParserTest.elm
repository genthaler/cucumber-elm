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
               in
                expect (Combine.parse GherkinParser.comment (comment ++ newline))
                    toBe
                    ( Result.Ok comment, Combine.Context "" 15 )
        , it "parses spaces correctly"
            <| let
                whitespace =
                    "  "
               in
                expect (Combine.parse GherkinParser.spaces whitespace)
                    toBe
                    ( Result.Ok whitespace, Combine.Context "" 2 )
        , it "parses AsA correctly"
            <| let
                asA =
                    "super dev"
               in
                expect (Combine.parse GherkinParser.asA ("As a" ++ " " ++ asA ++ "\n"))
                    toBe
                    ( Result.Ok (AsA asA), Combine.Context "" 15 )
        , it "parses InOrderTo correctly"
            <| let
                inOrderTo =
                    "write super apps"
               in
                expect (Combine.parse GherkinParser.inOrderTo ("In order to" ++ " " ++ inOrderTo ++ "\n"))
                    toBe
                    ( Result.Ok (InOrderTo inOrderTo), Combine.Context "" 29 )
        , it "parses IWantTo correctly"
            <| let
                iWantTo =
                    "use Elm"
               in
                expect (Combine.parse GherkinParser.iWantTo ("I want to" ++ " " ++ iWantTo ++ "\n"))
                    toBe
                    ( Result.Ok (IWantTo iWantTo), Combine.Context "" 18 )
        , it "parses DocString \"\"\" quotes correctly"
            <| let
                docStringQuotes =
                    "\"\"\""
               in
                expect (Combine.parse GherkinParser.docStringQuotes docStringQuotes)
                    toBe
                    ( Result.Ok docStringQuotes, Combine.Context "" (String.length docStringQuotes) )
        , it "parses DocString correctly"
            <| let
                docStringQuotes =
                    "\"\"\""

                docStringContent =
                    "Now is the time"
               in
                expect (Combine.parse GherkinParser.docString (docStringQuotes ++ docStringContent ++ docStringQuotes))
                    toBe
                    ( Result.Ok (DocString docStringContent)
                    , Combine.Context "" 21
                    )
        , it "parses dataTableCellDelimiter correctly"
            <| expect (Combine.parse GherkinParser.dataTableCellDelimiter "|")
                toBe
                ( Result.Ok "|", Combine.Context "" 1 )
        , it "parses dataTableCellContent correctly"
            <| expect (Combine.parse GherkinParser.dataTableCellContent "asdf | ")
                toBe
                ( Result.Ok "asdf", Combine.Context " | " 4 )
        , it "parses DataTable row correctly"
            <| let
                dataTableContent =
                    "| Now | is | the | time | "
               in
                expect (Combine.parse GherkinParser.dataTableRow dataTableContent)
                    toBe
                    ( Result.Ok [ "Now", "is", "the", "time" ]
                    , Combine.Context "" (String.length dataTableContent)
                    )
        , it "parses DataTable correctly"
            <| let
                dataTableContent =
                    """ | Now | is | the | time |
                              | For | all | good | men | """
               in
                expect (Combine.parse GherkinParser.dataTable dataTableContent)
                    toBe
                    ( Result.Ok
                        (DataTable
                            [ [ "Now", "is", "the", "time" ]
                            , [ "For", "all", "good", "men" ]
                            ]
                        )
                    , Combine.Context "" (String.length dataTableContent)
                    )
        , it "parses Given Step with DataTable correctly"
            <| let
                stepContent =
                    """Given I am trying to have fun
                      | Now | is | the | time |
                      | For | all | good | men | """
               in
                expect (Combine.parse GherkinParser.step stepContent)
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
               in
                expect (Combine.parse GherkinParser.step stepContent)
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
               in
                expect (Combine.parse GherkinParser.scenario scenarioContent)
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
        , it "parses Feature correctly"
            <| let
                featureContent =
                    """Feature: Living life
                    As a person
                    In order to get through life
                    I want to be able to do stuff
                    Scenario: Have fun
                      Given I am trying to have fun
                        | Now | is | the | time |
                        | For | all | good | men |
                      But I am trying not to be a toolie
"""
               in
                expect (Combine.parse GherkinParser.feature featureContent)
                    toBe
                    ( Result.Ok
                        (Feature "Living life"
                            (AsA "person")
                            (InOrderTo "get through life")
                            (IWantTo "be able to do stuff")
                            NoBackground
                            [ Scenario "Have fun"
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
                            ]
                        )
                    , Combine.Context "" (String.length featureContent)
                    )
        ]
