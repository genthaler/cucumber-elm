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
    { source = Just """Feature: Cucumber Fiddle application
    As a BDD practitioner
    In order to work in a BDD Elm environment
    I want to be able to run Gherkin features against an Elm codebase and see how well the codebase implements the features

    Background:
        Given I have loaded the CucumberFiddle application

    Scenario: Format a feature
        Given I have entered a feature in the feature editor
        When I format the feature
        Then I see the formatted feature

    Scenario: Run a feature
        Given I have entered a feature in the feature editor
        When I run the feature
        Then I see any errors interleaved in the output

    Scenario: Show list of available features on the server
        Then I can see the list of available features

    Scenario: Selecting a feature from the server
        When I select a feature from the list of available features
        Then I can see the feature

    Scenario: Selecting a feature from the client
        When I select a feature file from local
        Then I can see the feature"""
    , feature = Nothing
    , errors = []
    }
        -- ! [ get "CucumberFiddle.feature" ]
        !
            []


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
                                | errors = error :: []
                                , feature = Nothing
                            }
                                ! []

        Run ->
            model ! []

        FeatureError error ->
            { model
                | errors = displayError error :: []
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
        , div []
            [ case model.feature of
                Nothing ->
                    text "waiting..."

                Just feature ->
                    GherkinHtml.featureHtml feature
            ]
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
