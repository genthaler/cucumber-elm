module RpnCalculatorStepdefs exposing (StepArgParsed(..), parseRegex, stepDef)

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



-- before "Runs before scenarios *not* tagged with @foo"
-- after "HELLLLOO"
