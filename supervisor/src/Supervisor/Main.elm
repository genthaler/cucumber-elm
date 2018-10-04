module Supervisor.Main exposing (main)

import Cli.Program as Program
import Elm.Project exposing (..)
import Json.Decode
import StateMachine exposing (map, untag)
import Supervisor.Model exposing (..)
import Supervisor.Options exposing (..)
import Supervisor.Ports exposing (..)
import Task


message : msg -> Cmd msg
message msg =
    Task.perform identity (Task.succeed msg)


init : Program.FlagsIncludingArgv flags -> CliOptions -> ( Model, Cmd Response )
init flags options =
    case options of
        Init folder ->
            let
                initMessage =
                    "Initializing test suite in folder " ++ folder
            in
            ( toInitStart folder, echoRequest initMessage )

        RunTests runOptions ->
            let
                runMessage =
                    [ "Running the following test files: " ++ Debug.toString runOptions.testFiles |> Just
                    , "watch: " ++ Debug.toString runOptions.watch |> Just
                    , runOptions.maybeGlueArgumentsFunction |> Maybe.map (\glueArgumentsFunction -> "glue-arguments-function: " ++ Debug.toString glueArgumentsFunction)
                    , runOptions.maybeTags |> Maybe.map (\tags -> "tags: " ++ Debug.toString tags)
                    , runOptions.reportFormat |> Debug.toString |> Just
                    , runOptions.maybeCompilerPath |> Maybe.map (\compilerPath -> "compiler: " ++ Debug.toString compilerPath)
                    , runOptions.maybeDependencies |> Maybe.map (\dependencies -> "dependencies: " ++ Debug.toString dependencies)
                    ]
                        |> List.filterMap identity
                        |> String.join "\n"
            in
            ( toRunStart runOptions, echoRequest runMessage )


update : CliOptions -> Response -> Model -> ( Model, Cmd Response )
update cliOptions msg model =
    let
        noOp =
            ( model, Cmd.none )
    in
    case ( model, msg ) of
        ( _, Stderr stderr ) ->
            ( model, logAndExit 1 stderr )

        ( InitGettingCurrentDir state, FileList fileList ) ->
            case fileList of
                [ currentDir ] ->
                    ( toInitGettingModuleDir state currentDir, fileListRequest "." )

                _ ->
                    ( model, logAndExit 1 "expecting a single file as current directory" )

        ( InitGettingModuleDir state, FileList fileList ) ->
            case fileList of
                [ moduleDir ] ->
                    ( toInitCopyingTemplate state moduleDir, fileListRequest "." )

                _ ->
                    ( model, logAndExit 1 "expecting a single file as module directory" )

        ( InitCopyingTemplate state, Stdout stdout ) ->
            ( toExiting state 0, Cmd.none )

        ( RunGettingPackageInfo state, NoOp ) ->
            ( toRunConstructingFolder state (), Cmd.none )

        ( RunConstructingFolder state, NoOp ) ->
            ( toRunCompiling state, Cmd.none )

        ( RunCompiling state, NoOp ) ->
            ( toRunStartingRunner state [], Cmd.none )

        ( RunStartingRunner state, NoOp ) ->
            ( toRunResolvingGherkinFiles state [], Cmd.none )

        ( RunResolvingGherkinFiles state, NoOp ) ->
            ( toRunTestingGherkinFiles state [], Cmd.none )

        ( RunTestingGherkinFiles state, NoOp ) ->
            ( toRunWatching state [], Cmd.none )

        ( RunWatching state, NoOp ) ->
            ( toRunCompiling state, Cmd.none )

        ( Exiting state, NoOp ) ->
            ( model, exit (state |> untag) )

        ( _, _ ) ->
            ( model, logAndExit 1 "Invalid State Transition" )


subscriptions : Model -> Sub Response
subscriptions model =
    response


main : Program.StatefulProgram Model Response CliOptions {}
main =
    Program.stateful
        { printAndExitFailure = logAndExit 1
        , printAndExitSuccess = logAndExit 0
        , init = init
        , config = config
        , update = update
        , subscriptions = subscriptions
        }
