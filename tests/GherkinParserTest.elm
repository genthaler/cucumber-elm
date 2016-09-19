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
                        """Background: Some basic facts\x0D
                          Given The world is round\x0D
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
        , test "parses tableCellDelimiter correctly"
            <| \() ->
                Expect.equal (GherkinParser.parse GherkinParser.tableCellDelimiter "|")
                    (Result.Ok "|")
        , test "parses tableCellContent correctly"
            <| \() ->
                Expect.equal (GherkinParser.parse GherkinParser.tableCellContent "asdf | ")
                    (Result.Ok "asdf")
        , test "parses DataTable row correctly"
            <| \() ->
                let
                    tableContent =
                        "| Now | is | the | time | "
                in
                    Expect.equal (GherkinParser.parse GherkinParser.tableRow tableContent)
                        (Result.Ok [ "Now", "is", "the", "time" ])
        , test "parses DataTable correctly"
            <| \() ->
                let
                    tableContent =
                        """ | Now | is | the | time |\x0D
                              | For | all | good | men | """
                in
                    Expect.equal (GherkinParser.parse GherkinParser.table tableContent)
                        (Result.Ok
                            <| [ [ "Now", "is", "the", "time" ]
                               , [ "For", "all", "good", "men" ]
                               ]
                        )
        , test "parses Given Step with DataTable correctly"
            <| \() ->
                let
                    stepContent =
                        """Given I am trying to have fun\x0D
                      | Now | is | the | time |\x0D
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
                        """Scenario: Have fun\x0D
                      Given I am trying to have fun\x0D
                        | Now | is | the | time |\x0D
                        | For | all | good | men |\x0D
                      But I am trying not to be a fool\x0D
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
        , test "parses Scenario with tags correctly"
            <| \() ->
                let
                    scenarioContent =
                        """@foo\x0D
                      @bar\x0D
                      Scenario: Have fun\x0D
                        Given I am trying to have fun\x0D
                          | Now | is | the | time |\x0D
                          | For | all | good | men |\x0D
                        But I am trying not to be a fool\x0D
                      """
                in
                    Expect.equal (GherkinParser.parse GherkinParser.scenario scenarioContent)
                        <| Result.Ok
                        <| Scenario [ "foo", "bar" ]
                            "Have fun"
                            [ Given "I am trying to have fun"
                                <| DataTable
                                    [ [ "Now", "is", "the", "time" ]
                                    , [ "For", "all", "good", "men" ]
                                    ]
                            , But "I am trying not to be a fool"
                                NoArg
                            ]
          -- , test "parses Scenario Outline with tags correctly"
          --     <| \() ->
          --         let
          --             scenarioContent =
          --                 """@foo
          --               @bar
          --               Scenario Outline: Have fun
          --                 Given I am trying to have fun
          --                   | Now | is | the | time |
          --                   | For | all | good | men |
          --                 But I am trying not to be a fool
          --                 @blah
          --                 Examples:
          --                   | Now |
          --                   | For |
          --               """
          --         in
          --             Expect.equal (GherkinParser.parse GherkinParser.scenario scenarioContent)
          --                 <| Result.Ok
          --                 <| ScenarioOutline [ "foo", "bar" ]
          --                     "Have fun"
          --                     [ Given "I am trying to have fun"
          --                         <| DataTable
          --                             [ [ "Now", "is", "the", "time" ]
          --                             , [ "For", "all", "good", "men" ]
          --                             ]
          --                     , But "I am trying not to be a fool"
          --                         NoArg
          --                     ]
          --                     [ Examples [ "blah" ]
          --                         [ [ "Now" ]
          --                         , [ "For" ]
          --                         ]
          --                     ]
        , test "parses Feature correctly"
            <| \() ->
                let
                    featureContent =
                        """@foo\x0D
                      @bar\x0D
                      Feature: Living life\x0D
                      As a person\x0D
                      In order to get through life\x0D
                      I want to be able to do stuff\x0D
\x0D
                      Background: Some basic info\x0D
                        Given the world is round\x0D
\x0D
                      Scenario: Have fun\x0D
                        Given I am trying to have fun\x0D
                        But I am trying not to be a fool\x0D
                      """
                in
                    Expect.equal (GherkinParser.parse GherkinParser.feature featureContent)
                        <| Result.Ok
                        <| Feature [ "foo", "bar" ]
                            "Living life"
                            (AsA "person")
                            (InOrderTo "get through life")
                            (IWantTo "be able to do stuff")
                            (Background "Some basic info" [ Given "the world is round" NoArg ])
                            [ Scenario []
                                "Have fun"
                                [ Given "I am trying to have fun" NoArg
                                , But "I am trying not to be a fool" NoArg
                                ]
                            ]
        , test "parses Feature with tags correctly"
            <| \() ->
                let
                    featureContent =
                        """Feature: Living life\x0D
                      As a person\x0D
                      In order to get through life\x0D
                      I want to be able to do stuff\x0D
\x0D
                      Background: Some basic info\x0D
                        Given the world is round\x0D
\x0D
                      Scenario: Have fun\x0D
                        Given I am trying to have fun\x0D
                          | Now | is | the | time |\x0D
                          | For | all | good | men |\x0D
                        But I am trying not to be a fool\x0D
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
