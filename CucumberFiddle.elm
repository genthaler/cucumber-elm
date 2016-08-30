-- Try adding the ability to crouch or to land on top of the crate.


module Main exposing (..)

-- import Task exposing (Task)
-- import Html.Attributes exposing (width, height, style)
-- import Gherkin
-- import GherkinHtml
-- import GherkinParser

import Html exposing (Html, text, div, textarea)
import Html.App as Html


-- MODEL


type alias Model =
    { feature : Maybe String
    , features : Maybe (List String)
    , errors : Maybe (List String)
    }


type Msg
    = Load
    | Format
    | Run
    | ResourceError String
    | ResourceLoaded String



-- INIT


init : ( Model, Cmd Msg )
init =
    { feature = Nothing
    , features = Nothing
    , errors = Nothing
    }
        ! []



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Load ->
            model ! []

        Format ->
            model ! []

        Run ->
            model ! []

        ResourceError err ->
            { model
                | errors = Just (err :: Maybe.withDefault [] model.errors)
                , feature = Nothing
            }
                ! []

        ResourceLoaded feature ->
            { model | feature = Just feature } ! []



-- MAIN


main : Program Never
main =
    Html.program
        { init = init
        , view = view
        , subscriptions = always Sub.none
        , update = update
        }



-- VIEW


view : Model -> Html Msg
view model =
    div [] [ div [] [ textarea [] [] ] ]
