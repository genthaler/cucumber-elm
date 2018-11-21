module CucumberFiddle exposing (Model, Msg(..), displayError, get, init, main, update, view)

import Gherkin
import GherkinMd
import GherkinParser
import Html exposing (Html, button, div, li, text, textarea, ul)
import Html.Attributes exposing (name, value)
import Html.Events exposing (onClick, onInput)
import Http
import List exposing (map, repeat)
import Markdown
import Task exposing (Task)



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
    { source = Just """Feature: Cucumber Fiddle application\u{000D}
    As a BDD practitioner\u{000D}
    In order to work in a BDD Elm environment\u{000D}
    I want to be able to run Gherkin features against an Elm codebase and see how well the codebase implements the features\u{000D}
\u{000D}
    Background: The world is round\u{000D}
        Given I have loaded the CucumberFiddle application\u{000D}
        | Now | is | the | time |\u{000D}
        | For | all | good | men |\u{000D}
\u{000D}
    Scenario: Format a feature\u{000D}
        Given I have entered a feature in the feature editor\u{000D}
        When I format the feature\u{000D}
        Then I see the formatted feature\u{000D}
\u{000D}
    Scenario: Run a feature\u{000D}
        Given I have entered a feature in the feature editor\u{000D}
        When I run the feature\u{000D}
        Then I see any errors interleaved in the output\u{000D}
\u{000D}
    Scenario: Show list of available features on the server\u{000D}
        Then I can see the list of available features\u{000D}
\u{000D}
    Scenario: Selecting a feature from the server\u{000D}
        When I select a feature from the list of available features\u{000D}
        Then I can see the feature\u{000D}
\u{000D}
    Scenario: Selecting a feature from the client\u{000D}
        When I select a feature file from local\u{000D}
        Then I can see the feature \"\"\" Here's a DocString \"\"\"\u{000D}
\u{000D}
    @foo\u{000D}
    @bar\u{000D}
    Scenario Outline: Have fun\u{000D}
      Given I am trying to have fun\u{000D}
        | Now | is | the | time |\u{000D}
        | For | all | good | men |\u{000D}
      But I am trying not to be a fool\u{000D}
      @blah\u{000D}
      Examples:\u{000D}
        | Now |\u{000D}
        | For |\u{000D}
    """
    , feature = Nothing
    , errors = []
    }
        -- ! [ get "CucumberFiddle.feature" ]
        ! []


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
                    feature |> GherkinMd.featureMd |> Markdown.toHtml []
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
