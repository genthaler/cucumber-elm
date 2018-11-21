module Supervisor.Template exposing (templateElmJson, templateFeature, templateStepDefs)

import Elm.Constraint
import Elm.Package
import Elm.Project
import Elm.Version
import Json.Encode as E
import String.Format


templateFeature : String
templateFeature =
    """@foo
Feature: Basic Arithmetic

  Background: A Calculator
    Given a calculator I just turned on

  Scenario: Addition
  # Try to change one of the values below to provoke a failure
    When I add 4 and 5
    Then the result is 9

  Scenario: Another Addition
  # Try to change one of the values below to provoke a failure
    When I add 4 and 7
    Then the result is 11

  Scenario Outline: Many additions
    Given the previous entries:
      | first | second | operation |
      | 1     | 1      | +         |
      | 2     | 1      | +         |
    When I press +
    And I add <a> and <b>
    And I press +
    Then the result is <c>

  Examples: Single digits
    | a | b | c  |
    | 1 | 2 | 8  |
    | 2 | 3 | 10 |

  Examples: Double digits
    | a  | b  | c  |
    | 10 | 20 | 35 |
    | 20 | 30 | 55 |
"""


templateElmJson : Elm.Project.Project -> String
templateElmJson project =
    """
"""


templateStepDefs : String
templateStepDefs =
    """module RpnCalculatorStepdefs exposing (StepArgParsed(..), parseRegex, stepDef)

import Cucumber.StepDefs exposing (..)
import Gherkin exposing (..)
import RpnCalculator exposing (..)
import RpnCalculatorHelper exposing (..)


type StepArgParsed
    = Text String
    | TextAndTable String (List (List String))


parseRegex : String -> StepArg -> StepArgParsed
parseRegex str stepArg =
    Text str


stepDef : StepDefFunction State
stepDef regex stepArg state =
    case parseRegex regex stepArg of
        Text "a calculator I just turned on" ->
            Ok init

        Text "I add {int} and {int}" ->
            state
                |> enter 1
                |> enter 2
                |> press Add
                |> Ok

        Text "I press (.+)" ->
            state
                |> press Add
                |> Ok

        Text "the result is {int}" ->
            assertStackTop 1 state

        TextAndTable "the previous entries:" table ->
            let
                doRow : List String -> State -> Result String State
                doRow list state =
                    case list of
                        [ firstStr, secondStr, operationStr ] ->
                            case ( String.toInt firstStr, String.toInt secondStr, stringToOperation operationStr ) of
                                ( Ok firstInt, Ok secondInt, Ok operation ) ->
                                    state
                                        |> enter firstInt
                                        |> enter secondInt
                                        |> press operation
                                        |> Ok

                                _ ->
                                    Err <| "Expecting two integers and an operation, got " ++ toString list ++ " instead."

                        _ ->
                            Err <| "Expecting a row 3 items wide, got " ++ toString list ++ " instead."
            in
            case List.tail table of
                Nothing ->
                    Err <| "Expecting a table with at least a header row, got" ++ toString table

                Just tableContent ->
                    List.foldl (doRow >> Result.andThen) (Ok state) tableContent

        state ->
            Err <| "Unexpected input, description: " ++ regex ++ ", stepArg: " ++ toString stepArg
"""
