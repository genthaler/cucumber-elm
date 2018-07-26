module RpnCalculatorStepdefs exposing (..)

import Cucumber.StepDefs exposing (..)
import Gherkin exposing (..)
import RpnCalculator exposing (..)


type StepArgParsed
    = Text String


type alias State =
    ( Model, Cmd Msg )


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
            -- assertEquals(expected, calc.value());
            Ok state

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


input : Int -> State -> State
input int ( model, _ ) =
    update (Input <| toString int) model


push : State -> State
push ( model, _ ) =
    update (Press Push) model


press : OperationType -> State -> State
press op ( model, _ ) =
    update (Press (Operation op)) model


assert : Int -> State -> Result String State
assert int (( { stack, numStr, message }, _ ) as state) =
    if message /= "" then
        Err message
    else
        case stack of
            [] ->
                Err "Empty stack"

            [ int ] ->
                Ok state

            _ ->
                Err "More than one entry on the stack"
