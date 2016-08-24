-- Try adding the ability to crouch or to land on top of the crate.


module Main exposing (..)

import Task exposing (Task)
import Html exposing (Html, text, div, textarea)
import Html.App as Html
import Html.Attributes exposing (width, height, style)
import Gherkin
import GherkinHtml
import GherkinParser


-- MODEL


type alias Model =
    { resource : Maybe String
    , feature : Maybe Gherkin.Feature
    }


type Msg
    = Load
    | Format
    | Run
    | ResourceError String
    | ResourceLoaded String



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update action model =
    case action of
        Load ->
            ( model, Cmd.none )

        Format ->
            ( model, Cmd.none )

        Run ->
            ( model, Cmd.none )

        ResourceError err ->
            ( model, Cmd.none )

        ResourceLoaded resource ->
            ( { model | resource = Just resource }, Cmd.none )



-- INIT


init : ( Model, Cmd Msg )
init =
    { resource = Nothing
    , feature = Nothing
    }
        ! []



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
view { resource, feature } =
    div [] [ div [] [ textarea [] [] ] ]
