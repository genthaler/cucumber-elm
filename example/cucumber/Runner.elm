port module Runner exposing (..)

import Platform exposing (program)
import Cucumber exposing (..)
import Cucumber.StepDefs exposing (..)


port cucumberResponse : String -> Cmd msg


port cucumberRequest : (String -> msg) -> Sub msg


type Msg
    = Feature String


type alias Model =
    { pendingRequests : List String }


glueFunctions : StepDefArgs String
glueFunctions =
    ( "", [] )


init : ( Model, Cmd a )
init =
    ( { pendingRequests = [] }, Cmd.none )


resultToString : Result String () -> String
resultToString result =
    case result of
        Ok ok ->
            "ok"

        Err err ->
            err


update : Msg -> Model -> ( Model, Cmd msg )
update (Feature feature) model =
    ( model, feature |> (Cucumber.expectFeatureText glueFunctions [] ) |> resultToString |> cucumberResponse )


subscriptions : Model -> Sub Msg
subscriptions model =
    cucumberRequest Feature


main : Program Never Model Msg
main =
    program
        { init = init
        , update = update
        , subscriptions = subscriptions
        }
