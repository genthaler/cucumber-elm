port module Runner exposing (..)

import Platform exposing (program)
import Cucumber
import Cucumber.StepDefs


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


update : Msg -> Model -> ( Model, Cmd msg )
update (Feature feature) model =
    ( model, feature |> Cucumber.expectFeatureText |> Result.toMaybe |> reportFeature )


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
