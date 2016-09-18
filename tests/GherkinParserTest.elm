module GherkinParserTest exposing (..)

import Gherkin exposing (..)
import GherkinParser
import Test exposing (..)
import Expect


all : Test
all =
    describe "parsing Gherkin"
        [ test "parses comments correctly"
            <| \() ->
                let
                    comment =
                        "# some comment"
                in
                    Expect.equal (GherkinParser.parse GherkinParser.comment comment)
                        (Result.Ok comment)
        , test "parses spaces correctly"
            <| \() ->
                let
                    whitespace =
                        "  "
                in
                    Expect.equal (GherkinParser.parse GherkinParser.spaces whitespace)
                        (Result.Ok whitespace)
        , test "parses AsA correctly"
            <| \() ->
                let
                    asA =
                        "super dev"

                    asADesc =
                        "As a" ++ " " ++ asA ++ "\n"
                in
                    Expect.equal (GherkinParser.parse GherkinParser.asA asADesc)
                        (Result.Ok (AsA asA))
        , test "parses InOrderTo correctly"
            <| \() ->
                let
                    inOrderTo =
                        "write super apps"

                    inOrderToDesc =
                        "In order to" ++ " " ++ inOrderTo ++ "\n"
                in
                    Expect.equal (GherkinParser.parse GherkinParser.inOrderTo inOrderToDesc)
                        (Result.Ok (InOrderTo inOrderTo))
        , test "parses IWantTo correctly"
            <| \() ->
                let
                    iWantTo =
                        "use Elm"

                    iWantToDesc =
                        "I want to" ++ " " ++ iWantTo ++ "\n"
                in
                    Expect.equal (GherkinParser.parse GherkinParser.iWantTo iWantToDesc)
                        (Result.Ok (IWantTo iWantTo))
        , test "parses Background correctly"
            <| \() ->
                let
                    backgroundContent =
                        """Background: Some basic facts
                          Given The world is round
                      """
                in
                    Expect.equal (GherkinParser.parse GherkinParser.background backgroundContent)
                        (Result.Ok
                            <| Background "Some basic facts"
                                [ Given "The world is round" NoArg ]
                        )
        , test "parses DocString \"\"\" quotes correctly"
            <| \() ->
                let
                    docStringQuotes =
                        "\"\"\""
                in
                    Expect.equal (GherkinParser.parse GherkinParser.docStringQuotes docStringQuotes)
                        (Result.Ok docStringQuotes)
        , test "parses DocString correctly"
            <| \() ->
                let
                    docStringQuotes =
                        "\"\"\""

                    docStringContent =
                        "Now is the time"

                    docString =
                        docStringQuotes ++ docStringContent ++ docStringQuotes
                in
                    Expect.equal (GherkinParser.parse GherkinParser.docString docString)
                        (Result.Ok <| DocString docStringContent)
        , test "parses dataTableCellDelimiter correctly"
            <| \() ->
                Expect.equal (GherkinParser.parse GherkinParser.dataTableCellDelimiter "|")
                    (Result.Ok "|")
        , test "parses dataTableCellContent correctly"
            <| \() ->
                Expect.equal (GherkinParser.parse GherkinParser.dataTableCellContent "asdf | ")
                    (Result.Ok "asdf")
        , test "parses DataTable row correctly"
            <| \() ->
                let
                    dataTableContent =
                        "| Now | is | the | time | "
                in
                    Expect.equal (GherkinParser.parse GherkinParser.dataTableRow dataTableContent)
                        (Result.Ok [ "Now", "is", "the", "time" ])
        , test "parses DataTable correctly"
            <| \() ->
                let
                    dataTableContent =
                        """ | Now | is | the | time |
                              | For | all | good | men | """
                in
                    Expect.equal (GherkinParser.parse GherkinParser.dataTable dataTableContent)
                        (Result.Ok
                            <| DataTable
                                [ [ "Now", "is", "the", "time" ]
                                , [ "For", "all", "good", "men" ]
                                ]
                        )
        , test "parses Given Step with DataTable correctly"
            <| \() ->
                let
                    stepContent =
                        """Given I am trying to have fun
                      | Now | is | the | time |
                      | For | all | good | men | """
                in
                    Expect.equal (GherkinParser.parse GherkinParser.step stepContent)
                        (Result.Ok
                            <| Given "I am trying to have fun"
                            <| DataTable
                                [ [ "Now", "is", "the", "time" ]
                                , [ "For", "all", "good", "men" ]
                                ]
                        )
        , test "parses But Step with NoArg correctly"
            <| \() ->
                let
                    stepContent =
                        "But I am trying not to be a fool\n"
                in
                    Expect.equal (GherkinParser.parse GherkinParser.step stepContent)
                        (Result.Ok
                            <| But "I am trying not to be a fool"
                                NoArg
                        )
        , test "parses Scenario correctly"
            <| \() ->
                let
                    scenarioContent =
                        """Scenario: Have fun
                      Given I am trying to have fun
                        | Now | is | the | time |
                        | For | all | good | men |
                      But I am trying not to be a fool
                    """
                in
                    Expect.equal (GherkinParser.parse GherkinParser.scenario scenarioContent)
                        <| Result.Ok
                        <| Scenario []
                            "Have fun"
                            [ Given "I am trying to have fun"
                                <| DataTable
                                    [ [ "Now", "is", "the", "time" ]
                                    , [ "For", "all", "good", "men" ]
                                    ]
                            , But "I am trying not to be a fool"
                                NoArg
                            ]
          -- , test "parses Scenario with tags correctly"
          --     <| \() ->
          --         let
          --             scenarioContent =
          --                 """@foo
          --             @bar
          --             Scenario: Have fun
          --               Given I am trying to have fun
          --                 | Now | is | the | time |
          --                 | For | all | good | men |
          --               But I am trying not to be a fool
          --             """
          --         in
          --             Expect.equal (GherkinParser.parse GherkinParser.scenario scenarioContent)
          --                 <| Result.Ok
          --                 <| Scenario [ "foo", "bar" ]
          --                     "Have fun"
          --                     [ Given "I am trying to have fun"
          --                         <| DataTable
          --                             [ [ "Now", "is", "the", "time" ]
          --                             , [ "For", "all", "good", "men" ]
          --                             ]
          --                     , But "I am trying not to be a fool"
          --                         NoArg
          --                     ]
        , test "parses Feature correctly"
            <| \() ->
                let
                    featureContent =
                        """Feature: Living life
                      As a person
                      In order to get through life
                      I want to be able to do stuff

                      Background: Some basic info
                        Given the world is round

                      Scenario: Have fun
                        Given I am trying to have fun
                          | Now | is | the | time |
                          | For | all | good | men |
                        But I am trying not to be a fool
                      """
                in
                    Expect.equal (GherkinParser.parse GherkinParser.feature featureContent)
                        <| Result.Ok
                        <| Feature []
                            "Living life"
                            (AsA "person")
                            (InOrderTo "get through life")
                            (IWantTo "be able to do stuff")
                            (Background "Some basic info" [ Given "the world is round" NoArg ])
                            [ Scenario []
                                "Have fun"
                                [ Given "I am trying to have fun"
                                    <| DataTable
                                        [ [ "Now", "is", "the", "time" ]
                                        , [ "For", "all", "good", "men" ]
                                        ]
                                , But "I am trying not to be a fool" NoArg
                                ]
                            ]
        ]
