port module Runner exposing (..)

import Options exposing (..)
import PackageInfo exposing (decoder)
import Platform exposing (programWithFlags)
import Ports exposing (..)
import SupervisorState exposing (..)
import Task
import StateMachine exposing (untag, map)
import Json.Decode
import Help exposing (..)


-- 	1. parse options
--  1. get elm-package info
-- 	1. create new folder under elm-stuff to do compilation in
-- 	1. construct new elm-package.json
-- 		- glue function path
-- 	1. compile
-- 	1. if any compilation errors, report those, otherwise:
-- 	1. shut down any existing runner
-- 	1. (re-)require the built elm.js file
-- 	1. start up the runner
-- 	1. resolve list of Gherkin files
-- 	1. for each file, ask Node for the text
-- 	1. test the gherkin file, with timing information
-- 	1. if successful, replace the stats for the gherkin file in the report


type Msg
    = NoOp
    | FileRead String
    | FileWrite String
    | FileList (List String)
    | Shell Int
    | Cucumber String
    | Require Int


type alias Model =
    SupervisorState


message : msg -> Cmd msg
message msg =
    Task.perform identity (Task.succeed msg)


init : List String -> ( Model, Cmd Msg )
init flags =
    ( toStarting <| parseArgs flags, message NoOp )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        noOp =
            ( model, Cmd.none )
    in
        case ( model, msg ) of
            ( Starting state, NoOp ) ->
                case state |> untag |> .option of
                    Help ->
                        ( toHelping state, message NoOp )

                    Version ->
                        ( toVersioning state, message NoOp )

                    Init folder ->
                        ( toInitialising folder state, message NoOp )

                    Run runOption ->
                        ( model, message NoOp )

            ( Ending state, NoOp ) ->
                ( model, end (state |> untag) )

            ( Helping state, NoOp ) ->
                Debug.log helpText ( toEnding 0 state, message NoOp )

            ( Versioning state, msg ) ->
                case msg of
                    NoOp ->
                        ( model, fileReadRequest "elm-package.json" )

                    FileRead content ->
                        case Json.Decode.decodeString PackageInfo.decoder content of
                            Ok packageInfo ->
                                Debug.log ("Version: " ++ (toString packageInfo.version)) ( toEnding 0 state, message NoOp )

                            Err err ->
                                Debug.log ("Version: " ++ (err)) ( toEnding 1 state, message NoOp )

                    _ ->
                        noOp

            ( Initialising _, NoOp ) ->
                noOp

            ( GettingPackageInfo _, NoOp ) ->
                noOp

            ( ConstructingFolder _, NoOp ) ->
                noOp

            ( Compiling _, NoOp ) ->
                noOp

            ( StartingRunner _, NoOp ) ->
                noOp

            ( ResolvingGherkinFiles _, NoOp ) ->
                noOp

            ( TestingGherkinFiles _, NoOp ) ->
                noOp

            ( Watching _, NoOp ) ->
                noOp

            ( _, _ ) ->
                Debug.crash "Invalid State Transition" noOp


subscriptions : Model -> Sub Msg
subscriptions model =
    case model of
        Versioning _ ->
            fileReadResponse FileRead

        Initialising _ ->
            fileReadResponse FileRead

        GettingPackageInfo _ ->
            Sub.none

        ConstructingFolder _ ->
            fileWriteResponse FileWrite

        Compiling _ ->
            shellResponse Shell

        StartingRunner _ ->
            Sub.none

        ResolvingGherkinFiles _ ->
            Sub.none

        TestingGherkinFiles _ ->
            cucumberResponse Cucumber

        _ ->
            Sub.none


main : Program (List String) Model Msg
main =
    programWithFlags
        { init = init
        , update = update
        , subscriptions = subscriptions
        }
