port module Runner exposing (Model, Msg(..), cucumberRequest, cucumberResponse, glueFunctions, init, main, resultToString, subscriptions, update)

import Cucumber
import Cucumber.StepDefs
import Platform


port cucumberResponse : String -> Cmd msg


port cucumberRequest : (String -> msg) -> Sub msg


type Msg
    = Feature String


type alias Model =
    { pendingRequests : List String }


glueFunctions : Cucumber.StepDefs.StepDefArgs String
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
    ( model, feature |> Cucumber.expectFeatureText glueFunctions [] |> resultToString |> cucumberResponse )


subscriptions : Model -> Sub Msg
subscriptions model =
    cucumberRequest Feature


main : Program Never Model Msg
main =
    Platform.program
        { init = init
        , update = update
        , subscriptions = subscriptions
        }
