-- Try adding the ability to crouch or to land on top of the crate.


module Main exposing (..)

-- import Html.Attributes exposing (width, height, style)
-- import Gherkin
-- import GherkinHtml
-- import GherkinParser

import Task exposing (Task)
import Html exposing (Html, text, div, textarea)
import Html.App as Html
import Http


-- MODEL


type alias Model =
    { feature : Maybe String
    , features : Maybe (List String)
    , errors : Maybe (List String)
    }


type Msg
    = Load String
    | Format
    | Run
    | FeatureError Http.Error
    | FeatureLoaded String
    | FeaturesLoaded (List String)



-- INIT


init : ( Model, Cmd Msg )
init =
    { feature = Nothing
    , features = Nothing
    , errors = Nothing
    }
        ! [ Task.perform FeatureError FeatureLoaded (Http.getString ("/CucumberFiddle.feature")) ]



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Load feature ->
            model ! [ Task.perform FeatureError FeatureLoaded (Http.getString ("/" ++ feature)) ]

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
    div [] [ div [] [ textarea [] [] ] ]



-- MAIN


main : Program Never
main =
    Html.program
        { init = init
        , view = view
        , subscriptions = always Sub.none
        , update = update
        }
