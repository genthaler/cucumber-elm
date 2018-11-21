module RpnCalculator exposing (Entry(..), Model, Msg(..), OperationType(..), init, main, update, view)

import Html exposing (Html, br, button, div, h1, img, input, li, text, ul)
import Html.Attributes exposing (..)
import Html.Events exposing (..)



---- MODEL ----


type OperationType
    = Subtract
    | Add
    | Multiply
    | Divide


type Entry
    = Push
    | Operation OperationType


type alias Model =
    { stack : List Int, numStr : String, message : String }


type Msg
    = Input String
    | Press Entry


init : ( Model, Cmd Msg )
init =
    ( { stack = [], numStr = "", message = "" }, Cmd.none )



---- UPDATE ----


update : Msg -> Model -> ( Model, Cmd Msg )
update msg ({ stack, numStr, message } as model) =
    let
        newModel =
            case ( msg, stack ) of
                ( Press (Operation op), [] ) ->
                    { model | message = "You can't apply an operation on an empty stack" }

                ( Press (Operation op), head :: [] ) ->
                    { model | message = "You can't apply an operation on a stack with only one number" }

                ( Press (Operation op), first :: second :: rest ) ->
                    let
                        fn : Int -> Int -> Int
                        fn =
                            case op of
                                Add ->
                                    (+)

                                Subtract ->
                                    (-)

                                Multiply ->
                                    (*)

                                Divide ->
                                    (//)
                    in
                    { stack = fn first second :: rest, numStr = "", message = "" }

                ( Input str, stack ) ->
                    { model | numStr = str }

                ( Press Push, stack ) ->
                    case String.toInt numStr of
                        Ok number ->
                            { model | numStr = "", stack = number :: stack }

                        Err err ->
                            { model | numStr = "", message = err }
    in
    ( newModel, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view ({ stack, numStr, message } as model) =
    div []
        [ input [ type_ "number", placeholder "Type a number here", value numStr, onInput Input ] []
        , br [] []
        , button [ type_ "button", onClick (Press <| Push) ] [ text "Push onto stack" ]
        , br [] []
        , button [ type_ "button", onClick (Press <| Operation Add) ] [ text "+" ]
        , button [ type_ "button", onClick (Press <| Operation Subtract) ] [ text "-" ]
        , button [ type_ "button", onClick (Press <| Operation Multiply) ] [ text "*" ]
        , button [ type_ "button", onClick (Press <| Operation Divide) ] [ text "/" ]
        , br [] []
        , ul [] (List.map (li [] << List.singleton << text << toString) stack)
        , br [] []
        , text message
        ]



---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }
