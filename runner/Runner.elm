port module Runner exposing (..)

import Platform exposing (program)
import Cucumber


port runFeature : (String -> msg) -> Sub msg


port reportFeature : Maybe () -> Cmd msg


type Msg
    = Run String


type alias Model =
    { pendingRequests : List String }


init : ( Model, Cmd a )
init =
    ( { pendingRequests = [] }, Cmd.none )



-- fromResult : Result x a -> Task x a
-- fromResult result =
--     case result of
--         Ok value ->
--             succeed value
--         Err msg ->
--             fail msg


update : Msg -> Model -> ( Model, Cmd msg )
update (Run feature) model =
    ( model, feature |> Cucumber.expectFeatureText |> Result.toMaybe |> reportFeature )


subscriptions : Model -> Sub Msg
subscriptions model =
    runFeature Run


main : Program Never Model Msg
main =
    program
        { init = init
        , update = update
        , subscriptions = subscriptions
        }
