module Supervisor.Main exposing (main)

import Cli.Program as Program
import Elm.Project exposing (..)
import Json.Decode as D
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
        Init ->
            let
                initMessage =
                    "Initializing test suite"
            in
            ( toInitStart, Cmd.batch [ echoRequest initMessage, message NoOp ] )

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
            ( toRunStart runOptions, Cmd.batch [ echoRequest runMessage, message NoOp ] )


update : CliOptions -> Response -> Model -> ( Model, Cmd Response )
update cliOptions msg model =
    let
        crash errorMessage =
            ( model, logAndExit 1 errorMessage )
    in
    case ( model, msg ) of
        ( _, Stderr stderr ) ->
            ( model, logAndExit 1 stderr )

        ( InitStart state, _ ) ->
            ( toInitGettingModuleDir state, fileListRequest "." )

        ( InitGettingModuleDir state, FileList fileList ) ->
            case fileList of
                [ moduleDir ] ->
                    ( toInitGettingCurrentDirListing state moduleDir, fileListRequest "." )

                _ ->
                    crash "expecting a single file as module directory"

        ( InitGettingCurrentDirListing state, FileList fileList ) ->
            case fileList of
                [ moduleDir ] ->
                    ( toInitCopyingTemplate state, shellRequest "cp -R" )

                _ ->
                    crash "expecting a single file as module directory"

        ( InitCopyingTemplate state, Stdout stdout ) ->
            ( toInitCopyingTemplate state,  exit 0)
 
        ( RunStart state, NoOp ) ->
            ( toRunGettingUserPackageInfo state, fileReadRequest "elm.json" )

        ( RunGettingUserPackageInfo state, Stdout stdout ) ->
            
            ( toRunConstructingFolder state (D.decodeString Elm.Project.decoder stdout), fileReadRequest "elm.json" )

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
