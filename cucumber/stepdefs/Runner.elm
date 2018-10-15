port module Runner exposing (Model, Msg(..), cucumberRequest, cucumberResponse, glueFunctions, init, main, resultToString, subscriptions, update)

import Cucumber
import Cucumber.StepDefs
import Platform



{-
   Don't modify or rely on this file. It will be overwritten when you run elm-cuke.
   There's no need to keep this in source control either.
-}


port cucumberResponse : String -> Cmd msg


port cucumberRequest : (String -> msg) -> Sub msg


type Msg
    = Feature String


type alias Model =
    { pendingRequests : List String }


glueFunctions : Cucumber.StepDefs.StepDefArgs String
glueFunctions =
    ( "", [] )


init : () -> ( Model, Cmd a )
init _ =
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
    ( model, feature |> Cucumber.expectFeatureText glueFunctions [] |> resultToString |> cucumberResponse )


subscriptions : Model -> Sub Msg
subscriptions model =
    cucumberRequest Feature


main : Program () Model Msg
main =
    Platform.worker
        { init = init
        , update = update
        , subscriptions = subscriptions
        }
