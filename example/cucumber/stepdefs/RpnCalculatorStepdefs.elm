module RpnCalculatorStepdefs exposing (..)

import Cucumber.StepDefs exposing (..)
import Gherkin exposing (..)
import RpnCalculator exposing (..)
import RpnCalculatorHelper exposing (..)


type StepArgParsed
    = Text String


parseRegex : String -> StepArg -> StepArgParsed
parseRegex str stepArg =
    Text str



-- type alias StepDefFunction state =
--     String -> StepArg -> state -> StepDefFunctionResult state
-- type alias StepDefFunctionResult state =
--     Result String state


stepDef : StepDefFunction State
stepDef regex stepArg state =
    case parseRegex regex stepArg of
        Text "a calculator I just turned on" ->
            Ok init

        Text "I add {int} and {int}" ->
            state
                |> input 1
                |> push
                |> input 2
                |> push
                |> press Add
                |> Ok

        Text "I press (.+)" ->
            state
                |> press Add
                |> Ok

        Text "the result is {int}" ->
            assertState 1 state

        -- Text "the previous entries:" ->
        --     -- for (Entry entry : entries) {
        --     --     calc.push(entry.first);
        --     --     calc.push(entry.second);
        --     --     calc.push(entry.operation);
        --     -- }
        --     Ok state
        -- before "Runs before scenarios *not* tagged with @foo"
        -- after "HELLLLOO"
        state ->
            Err <| "Unexpected input" ++ (toString state)
