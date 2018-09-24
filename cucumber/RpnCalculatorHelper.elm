module RpnCalculatorHelper exposing (State, assertStackTop, enter, input, press, push, stringToOperation)

import RpnCalculator exposing (..)


type alias State =
    ( Model, Cmd Msg )


input : Int -> State -> State
input int ( model, _ ) =
    update (Input <| toString int) model


push : State -> State
push ( model, _ ) =
    update (Press Push) model


enter : Int -> State -> State
enter int =
    input int >> push


press : OperationType -> State -> State
press op ( model, _ ) =
    update (Press (Operation op)) model


assertStackTop : Int -> State -> Result String State
assertStackTop int (( { stack }, _ ) as state) =
    case stack of
        [] ->
            Err "Empty stack"

        [ top ] ->
            if top == int then
                Ok state

            else
                Err <| "Expected " ++ toString int ++ ", got " ++ toString top

        _ ->
            Err "More than one entry on the stack"


stringToOperation : String -> Result String OperationType
stringToOperation str =
    case str of
        "+" ->
            Ok Add

        "-" ->
            Ok Subtract

        "*" ->
            Ok Multiply

        "/" ->
            Ok Divide

        _ ->
            Err <| "Expection an operation, got " ++ str
