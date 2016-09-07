-- Try adding the ability to crouch or to land on top of the crate.


module Main exposing (..)

-- import Html.App as Html

import Gherkin
import GherkinHtml
import GherkinParser
import Task exposing (Task)
import Html exposing (Html, text, div, textarea, button, ul, li)
import Html.Attributes exposing (value, name)
import Html.Events exposing (onClick, onInput)
import Http
import TimeTravel.Html.App as TimeTravel
import List exposing (map, repeat)


-- MODEL


type alias Model =
    { source : Maybe String
    , feature : Maybe Gherkin.Feature
    , errors : List String
    }


type Msg
    = Load String
    | Input String
    | Format
    | Run
    | FeatureError Http.Error
    | FeatureLoaded String



-- UPDATE


get : String -> Cmd Msg
get source =
    Task.perform FeatureError FeatureLoaded (Http.getString ("/" ++ source))


init : ( Model, Cmd Msg )
init =
    { source = Nothing
    , feature = Nothing
    , errors = []
    }
        ! [ get "CucumberFiddle.feature" ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Load source ->
            model ! [ get source ]

        Input source ->
            { model | source = Just source } ! []

        Format ->
            case model.source of
                Nothing ->
                    model ! []

                Just feature ->
                    case GherkinParser.parse GherkinParser.feature feature of
                        Ok feature ->
                            { model | feature = Just feature } ! []

                        Err error ->
                            { model
                                | errors = error :: model.errors
                                , feature = Nothing
                            }
                                ! []

        Run ->
            model ! []

        FeatureError error ->
            { model
                | errors = displayError error :: model.errors
                , source = Nothing
                , feature = Nothing
            }
                ! []

        FeatureLoaded source ->
            { model | source = Just source } ! []



-- VIEW


displayError : Http.Error -> String
displayError err =
    toString err


view : Model -> Html Msg
view model =
    div []
        [ textarea
            [ value (Maybe.withDefault "waiting..." model.source)
            , onInput Input
            ]
            []
        , case model.feature of
            Nothing ->
                text "waiting..."

            Just feature ->
                GherkinHtml.featureHtml feature
        , ul [] (map (li [] << repeat 1 << text) model.errors)
        , button [ onClick Format ] [ text "Format" ]
        , button [ onClick Run ] [ text "Run" ]
        ]



-- MAIN


main : Program Never
main =
    -- Html.program
    TimeTravel.program
        { init = init
        , view = view
        , update = update
        , subscriptions = always Sub.none
        }
