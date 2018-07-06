module CucumberFiddle exposing (..)

import Markdown
import Gherkin
import GherkinMd
import GherkinParser
import Task exposing (Task)
import Html exposing (Html, text, div, textarea, button, ul, li)
import Html.Attributes exposing (value, name)
import Html.Events exposing (onClick, onInput)
import Http
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
    { source = Just """Feature: Cucumber Fiddle application\x0D
    As a BDD practitioner\x0D
    In order to work in a BDD Elm environment\x0D
    I want to be able to run Gherkin features against an Elm codebase and see how well the codebase implements the features\x0D
\x0D
    Background: The world is round\x0D
        Given I have loaded the CucumberFiddle application\x0D
        | Now | is | the | time |\x0D
        | For | all | good | men |\x0D
\x0D
    Scenario: Format a feature\x0D
        Given I have entered a feature in the feature editor\x0D
        When I format the feature\x0D
        Then I see the formatted feature\x0D
\x0D
    Scenario: Run a feature\x0D
        Given I have entered a feature in the feature editor\x0D
        When I run the feature\x0D
        Then I see any errors interleaved in the output\x0D
\x0D
    Scenario: Show list of available features on the server\x0D
        Then I can see the list of available features\x0D
\x0D
    Scenario: Selecting a feature from the server\x0D
        When I select a feature from the list of available features\x0D
        Then I can see the feature\x0D
\x0D
    Scenario: Selecting a feature from the client\x0D
        When I select a feature file from local\x0D
        Then I can see the feature \"\"\" Here's a DocString \"\"\"\x0D
\x0D
    @foo\x0D
    @bar\x0D
    Scenario Outline: Have fun\x0D
      Given I am trying to have fun\x0D
        | Now | is | the | time |\x0D
        | For | all | good | men |\x0D
      But I am trying not to be a fool\x0D
      @blah\x0D
      Examples:\x0D
        | Now |\x0D
        | For |\x0D
    """
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
                    feature |> GherkinMd.featureMd |> (Markdown.toHtml [])
            ]
        , ul [] (map (li [] << repeat 1 << text) model.errors)
        , button [ onClick Format ] [ text "Format" ]
        , button [ onClick Run ] [ text "Run" ]
        ]



-- MAIN


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }
