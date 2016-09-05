-- Try adding the ability to crouch or to land on top of the crate.


module Main exposing (..)

-- import Gherkin
-- import GherkinHtml
-- import GherkinParser

import Task exposing (Task)
import Html exposing (Html, text, div, textarea, button)


-- import Html.App as Html

import Html.Attributes exposing (value, name)
import Html.Events exposing (onClick, onInput)
import Http
import TimeTravel.Html.App as TimeTravel


-- MODEL


type alias Model =
    { feature : Maybe String
    , features : Maybe (List String)
    , pretty : Maybe String
    , errors : Maybe (List String)
    }


type Msg
    = Load String
    | Input String
    | Format
    | Run
    | FeatureError Http.Error
    | FeatureLoaded String
    | FeaturesLoaded (List String)



-- UPDATE


get : String -> Cmd Msg
get feature =
    Task.perform FeatureError FeatureLoaded (Http.getString ("/" ++ feature))


init : ( Model, Cmd Msg )
init =
    { feature = Nothing
    , features = Nothing
    , pretty = Nothing
    , errors = Nothing
    }
        ! [ get "CucumberFiddle.feature" ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Load feature ->
            model ! [ get feature ]

        Input feature ->
            { model | feature = Just feature } ! []

        Format ->
            model ! []

        Run ->
            model ! []

        FeatureError error ->
            { model
                | errors = Just (displayError error :: Maybe.withDefault [] model.errors)
                , feature = Nothing
            }
                ! []

        FeatureLoaded feature ->
            { model | feature = Just feature } ! []

        FeaturesLoaded features ->
            { model | features = Just features } ! []



-- VIEW


displayError : Http.Error -> String
displayError _ =
    ""


view : Model -> Html Msg
view model =
    div []
        [ textarea
            [ value (Maybe.withDefault "waiting..." model.feature)
            , onInput Input
            ]
            []
        , textarea
            [ value (Maybe.withDefault "waiting..." model.pretty)
            , onInput Input
            ]
            []
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
