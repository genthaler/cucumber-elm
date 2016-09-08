module GherkinParserTest exposing (..)

import Gherkin exposing (..)
import GherkinParser
import ElmTestBDDStyle exposing (..)


all : Test
all =
    describe "parsing Gherkin"
        [ it "parses comments correctly"
            <| let
                comment =
                    "# some comment"
               in
                expect (GherkinParser.parse GherkinParser.comment comment)
                    toBe
                    <| Result.Ok comment
        , it "parses spaces correctly"
            <| let
                whitespace =
                    "  "
               in
                expect (GherkinParser.parse GherkinParser.spaces whitespace)
                    toBe
                    <| Result.Ok whitespace
        , it "parses AsA correctly"
            <| let
                asA =
                    "super dev"

                asADesc =
                    "As a" ++ " " ++ asA ++ "\n"
               in
                expect (GherkinParser.parse GherkinParser.asA asADesc)
                    toBe
                    <| Result.Ok (AsA asA)
        , it "parses InOrderTo correctly"
            <| let
                inOrderTo =
                    "write super apps"

                inOrderToDesc =
                    "In order to" ++ " " ++ inOrderTo ++ "\n"
               in
                expect (GherkinParser.parse GherkinParser.inOrderTo inOrderToDesc)
                    toBe
                    <| Result.Ok (InOrderTo inOrderTo)
        , it "parses IWantTo correctly"
            <| let
                iWantTo =
                    "use Elm"

                iWantToDesc =
                    "I want to" ++ " " ++ iWantTo ++ "\n"
               in
                expect (GherkinParser.parse GherkinParser.iWantTo iWantToDesc)
                    toBe
                    <| Result.Ok (IWantTo iWantTo)
          -- , it "parses Background correctly"
          --     <| let
          --         backgroundContent =
          --             """Background:
          --                 Given The world is round
          --             """
          --        in
          --         expect (GherkinParser.parse GherkinParser.background backgroundContent)
          --             toBe
          --             <| Result.Ok
          --             <| Background [ Given "The world is round" NoArg ]
        , it "parses DocString \"\"\" quotes correctly"
            <| let
                docStringQuotes =
                    "\"\"\""
               in
                expect (GherkinParser.parse GherkinParser.docStringQuotes docStringQuotes)
                    toBe
                    <| Result.Ok docStringQuotes
        , it "parses DocString correctly"
            <| let
                docStringQuotes =
                    "\"\"\""

                docStringContent =
                    "Now is the time"

                docString =
                    docStringQuotes ++ docStringContent ++ docStringQuotes
               in
                expect (GherkinParser.parse GherkinParser.docString docString)
                    toBe
                    <| Result.Ok
                    <| DocString docStringContent
        , it "parses dataTableCellDelimiter correctly"
            <| expect (GherkinParser.parse GherkinParser.dataTableCellDelimiter "|")
                toBe
            <| Result.Ok "|"
        , it "parses dataTableCellContent correctly"
            <| expect (GherkinParser.parse GherkinParser.dataTableCellContent "asdf | ")
                toBe
            <| Result.Ok "asdf"
        , it "parses DataTable row correctly"
            <| let
                dataTableContent =
                    "| Now | is | the | time | "
               in
                expect (GherkinParser.parse GherkinParser.dataTableRow dataTableContent)
                    toBe
                    <| Result.Ok [ "Now", "is", "the", "time" ]
        , it "parses DataTable correctly"
            <| let
                dataTableContent =
                    """ | Now | is | the | time |
                              | For | all | good | men | """
               in
                expect (GherkinParser.parse GherkinParser.dataTable dataTableContent)
                    toBe
                    <| Result.Ok
                    <| DataTable
                        [ [ "Now", "is", "the", "time" ]
                        , [ "For", "all", "good", "men" ]
                        ]
        , it "parses Given Step with DataTable correctly"
            <| let
                stepContent =
                    """Given I am trying to have fun
                      | Now | is | the | time |
                      | For | all | good | men | """
               in
                expect (GherkinParser.parse GherkinParser.step stepContent)
                    toBe
                    <| Result.Ok
                    <| Given "I am trying to have fun"
                    <| DataTable
                        [ [ "Now", "is", "the", "time" ]
                        , [ "For", "all", "good", "men" ]
                        ]
        , it "parses But Step with NoArg correctly"
            <| let
                stepContent =
                    "But I am trying not to be a fool\n"
               in
                expect (GherkinParser.parse GherkinParser.step stepContent)
                    toBe
                    <| Result.Ok
                    <| But "I am trying not to be a fool" NoArg
        , it "parses Scenario correctly"
            <| let
                scenarioContent =
                    """Scenario: Have fun
                      Given I am trying to have fun
                        | Now | is | the | time |
                        | For | all | good | men |
                      But I am trying not to be a fool
                    """
               in
                expect (GherkinParser.parse GherkinParser.scenario scenarioContent)
                    toBe
                    <| Result.Ok
                    <| Scenario "Have fun"
                        [ Given "I am trying to have fun"
                            <| DataTable
                                [ [ "Now", "is", "the", "time" ]
                                , [ "For", "all", "good", "men" ]
                                ]
                        , But "I am trying not to be a fool"
                            NoArg
                        ]
          -- , it "parses Feature correctly"
          --     <| let
          --         featureContent =
          --             """Feature: Living life
          --             As a person
          --             In order to get through life
          --             I want to be able to do stuff
          --             Background:
          --               Given the world is round
          --             Scenario: Have fun
          --               Given I am trying to have fun
          --                 | Now | is | the | time |
          --                 | For | all | good | men |
          --               But I am trying not to be a fool
          --             """
          --        in
          --         expect (GherkinParser.parse GherkinParser.feature featureContent)
          --             toBe
          --             <| Result.Ok
          --             <| Feature "Living life"
          --                 (AsA "person")
          --                 (InOrderTo "get through life")
          --                 (IWantTo "be able to do stuff")
          --                 (Background [ Given "Given the world is round" NoArg ])
          --                 [ Scenario "Have fun"
          --                     [ Given "I am trying to have fun"
          --                         <| DataTable
          --                             [ [ "Now", "is", "the", "time" ]
          --                             , [ "For", "all", "good", "men" ]
          --                             ]
          --                     , But "I am trying not to be a fool" NoArg
          --                     ]
          --                 ]
        ]
