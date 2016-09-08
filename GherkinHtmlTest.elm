module GherkinHtmlTest exposing (..)

import Gherkin exposing (..)
import GherkinHtml exposing (..)
import ElmTestBDDStyle exposing (..)
import Html exposing (..)


all : Test
all =
    describe "HTML formatting"
        [ it "formats AsA correctly"
            <| let
                asADesc =
                    "super dev"

                asA =
                    AsA asADesc
               in
                expect (GherkinHtml.asAHtml asA asADesc)
                    toBe
                    <| text ("As a " ++ asADesc)
        , it "formats InOrderTo correctly"
            <| let
                inOrderToDesc =
                    "write super apps"

                inOrderTo =
                    InOrderTo inOrderToDesc
               in
                expect (GherkinHtml.inOrderToHtml inOrderTo)
                    toBe
                    <| text ("In order to" ++ inOrderToDesc)
        , it "formats IWantTo correctly"
            <| let
                iWantToDesc =
                    "use Elm"

                iWantTo =
                    iWantTo iWantToDesc
               in
                expect (GherkinHtml.iWantToHtml iWantTo)
                    toBe
                    <| text ("I want to " ++ iWantToDesc)
        , it "formats DocString correctly"
            <| let
                stepDesc =
                    "I am trying to have fun"

                docStringContent =
                    """
                    Here is a DocString
                    """

                docString =
                    DocString docStringContent
               in
                expect (GherkinHtml.stepArgHtml docString)
                    toBe
                    <| text (docStringContent)
        , it "formats DocString correctly"
            <| let
                docStringQuotes =
                    "\"\"\""

                docStringContent =
                    "Now is the time"

                docString =
                    docStringQuotes ++ docStringContent ++ docStringQuotes
               in
                expect (GherkinHtml.parse GherkinHtml.docString docString)
                    toBe
                    <| Result.Ok
                    <| DocString docStringContent
        , it "formats dataTableCellDelimiter correctly"
            <| expect (GherkinHtml.parse GherkinHtml.dataTableCellDelimiter "|")
                toBe
            <| Result.Ok "|"
        , it "formats dataTableCellContent correctly"
            <| expect (GherkinHtml.parse GherkinHtml.dataTableCellContent "asdf | ")
                toBe
            <| Result.Ok "asdf"
        , it "formats DataTable row correctly"
            <| let
                dataTableContent =
                    "| Now | is | the | time | "
               in
                expect (GherkinHtml.parse GherkinHtml.dataTableRow dataTableContent)
                    toBe
                    <| Result.Ok [ "Now", "is", "the", "time" ]
        , it "formats DataTable correctly"
            <| let
                dataTableContent =
                    """ | Now | is | the | time |
                              | For | all | good | men | """
               in
                expect (GherkinHtml.parse GherkinHtml.dataTable dataTableContent)
                    toBe
                    <| Result.Ok
                    <| DataTable
                        [ [ "Now", "is", "the", "time" ]
                        , [ "For", "all", "good", "men" ]
                        ]
        , it "formats Given Step with DataTable correctly"
            <| let
                stepContent =
                    """Given I am trying to have fun
                      | Now | is | the | time |
                      | For | all | good | men | """
               in
                expect (GherkinHtml.parse GherkinHtml.step stepContent)
                    toBe
                    <| Result.Ok
                    <| Given "I am trying to have fun"
                    <| DataTable
                        [ [ "Now", "is", "the", "time" ]
                        , [ "For", "all", "good", "men" ]
                        ]
        , it "formats But Step with NoArg correctly"
            <| let
                stepContent =
                    "But I am trying not to be a fool\n"
               in
                expect (GherkinHtml.parse GherkinHtml.step stepContent)
                    toBe
                    <| Result.Ok
                    <| But "I am trying not to be a fool" NoArg
        , it "formats Scenario correctly"
            <| let
                scenarioContent =
                    """Scenario: Have fun
                      Given I am trying to have fun
                        | Now | is | the | time |
                        | For | all | good | men |
                      But I am trying not to be a fool
                    """
               in
                expect (GherkinHtml.parse GherkinHtml.scenario scenarioContent)
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
        , it "formats Feature correctly"
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
                      But I am trying not to be a fool
                    """
               in
                expect (GherkinHtml.parse GherkinHtml.feature featureContent)
                    toBe
                    <| Result.Ok
                    <| Feature "Living life"
                        (AsA "person")
                        (InOrderTo "get through life")
                        (IWantTo "be able to do stuff")
                        NoBackground
                        [ Scenario "Have fun"
                            [ Given "I am trying to have fun"
                                <| DataTable
                                    [ [ "Now", "is", "the", "time" ]
                                    , [ "For", "all", "good", "men" ]
                                    ]
                            , But "I am trying not to be a fool" NoArg
                            ]
                        ]
        ]
