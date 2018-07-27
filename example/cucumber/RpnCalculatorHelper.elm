module RpnCalculatorHelper exposing (..)

import RpnCalculator exposing (..)


type alias State =
    ( Model, Cmd Msg )


input : Int -> State -> State
input int ( model, _ ) =
    update (Input <| toString int) model


push : State -> State
push ( model, _ ) =
    update (Press Push) model


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
