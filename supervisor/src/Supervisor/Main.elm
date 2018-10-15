module Supervisor.Main exposing (main)

import Cli.Program as Program
import Elm.Project exposing (..)
import Json.Decode as D
import Json.Encode as E
import StateMachine exposing (State(..), map, untag)
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
            ( model, exit 1 errorMessage )
    in
    case ( model, msg ) of
        ( _, Stderr stderr ) ->
            ( model, exit 1 stderr )

        ( InitStart state, _ ) ->
            ( toInitGettingModuleDir state, moduleDirectoryRequest )

        ( InitGettingModuleDir state, FileList fileList ) ->
            case fileList of
                [ moduleDir ] ->
                    ( toInitGettingCurrentDirListing state moduleDir, fileListRequest [ moduleDir ] "*" )

                _ ->
                    crash "expecting a single file as module directory"

        ( InitGettingCurrentDirListing ((State data) as state), FileList fileList ) ->
            ( toInitCopyingTemplate state, copyRequest [ data.moduleDir, "cucumber" ] [ "." ] )

        ( InitCopyingTemplate state, Stdout stdout ) ->
            ( model, exit 0 "Init complete" )

        ( RunStart state, NoOp ) ->
            Debug.log "RunStart" ( toRunGettingCurrentDirListing state, fileListRequest [ "." ] "*" )

        ( RunGettingCurrentDirListing state, FileList fileList ) ->
            ( toRunGettingUserPackageInfo state
            , fileReadRequest [ "elm.json" ]
            )

        ( RunGettingUserPackageInfo state, Stdout stdout ) ->
            case D.decodeString Elm.Project.decoder stdout of
                Ok project ->
                    ( toRunGettingUserCucumberPackageInfo state project
                    , fileReadRequest [ "elm.json" ]
                    )

                Err error ->
                    ( model, exit 1 (D.errorToString error) )

        ( RunGettingUserCucumberPackageInfo state, Stdout stdout ) ->
            case D.decodeString Elm.Project.decoder stdout of
                Ok project ->
                    ( toRunGettingModuleDir state project
                    , moduleDirectoryRequest
                    )

                Err error ->
                    ( model, exit 1 (D.errorToString error) )

        ( RunGettingModuleDir state, FileList fileList ) ->
            case fileList of
                [ moduleDir ] ->
                    ( toRunGettingModulePackageInfo state, fileReadRequest [ moduleDir, "elm.json" ] )

                _ ->
                    crash "expecting a single file as module directory"

        ( RunGettingModulePackageInfo state, Stdout stdout ) ->
            case D.decodeString Elm.Project.decoder stdout of
                Ok project ->
                    ( toRunUpdatingUserCucumberElmJson state
                    , fileWriteRequest [ "elm.json" ] (E.encode 4 <| Elm.Project.encode project)
                    )

                Err error ->
                    ( model, exit 1 (D.errorToString error) )

        ( RunUpdatingUserCucumberElmJson state, Stdout typesJson ) ->
            ( toRunGettingTypes state, shellRequest "npm run elmi" )

        ( RunGettingTypes ((State data) as state), Stdout typesJson ) ->
            case D.decodeString elmiModuleListDecoder typesJson of
                Ok project ->
                    ( toRunCompilingRunner state
                    , shellRequest "runner.elm with stepdefs from typesJson"
                    )

                Err error ->
                    ( model, exit 1 (D.errorToString error) )

        ( RunCompilingRunner state, NoOp ) ->
            ( toRunStartingRunner state, Cmd.none )

        ( RunStartingRunner state, NoOp ) ->
            ( toRunResolvingGherkinFiles state, Cmd.none )

        ( RunResolvingGherkinFiles state, NoOp ) ->
            ( toRunTestingGherkinFiles state [], Cmd.none )

        ( RunTestingGherkinFiles state, NoOp ) ->
            ( toRunWatching state [], Cmd.none )

        ( RunWatching state, NoOp ) ->
            ( toRunCompilingRunner state, Cmd.none )

        ( state, cmd ) ->
            let
                _ =
                    Debug.log "( state, cmd )" ( state, cmd )
            in
            ( model, exit 1 "Invalid State Transition" )


subscriptions : Model -> Sub Response
subscriptions model =
    response


main : Program.StatefulProgram Model Response CliOptions {}
main =
    Program.stateful
        { printAndExitFailure = exit 1
        , printAndExitSuccess = exit 0
        , init = init
        , config = config
        , update = update
        , subscriptions = subscriptions
        }
