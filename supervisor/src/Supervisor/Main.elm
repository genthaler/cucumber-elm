module Supervisor.Main exposing (main)

import Cli.Program as Program
import Elm.Project exposing (..)
import Json.Decode as D
import Json.Encode as E
import Result.Extra
import StateMachine exposing (State(..), map, untag)
import Supervisor.Model exposing (..)
import Supervisor.Options exposing (config)
import Supervisor.Package exposing (..)
import Supervisor.Ports exposing (..)
import Supervisor.Template exposing (..)
import Task


message : msg -> Cmd msg
message msg =
    Task.perform identity (Task.succeed msg)


init : Program.FlagsIncludingArgv flags -> CliOptions -> ( Model, Cmd Response )
init flags options =
    case options of
        Init initOptions ->
            let
                initMessage =
                    "Initializing test suite"
            in
            ( toInitStart initOptions, Cmd.batch [ echoRequest initMessage, message NoOp ] )

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
update _ msg model =
    (case Debug.log (Debug.toString msg) ( model, msg ) of
        ( _, Stderr stderr ) ->
            Err stderr

        ( InitStart state, _ ) ->
            Ok ( toInitGettingCurrentDirListing state, fileListRequest [ "." ] "*" )

        ( InitGettingCurrentDirListing ((State data) as state), FileList fileList ) ->
            if not (List.member "elm.json" fileList) then
                Err "Couldn't find elm.json in the current directory"

            else if List.member "cucumber" fileList then
                Err "There is already a cucumber folder in the current directory"

            else
                Ok ( toInitMakingDirectories state, makeDirectoriesRequest [ [ "cucumber", "src" ], [ "cucumber", "features" ] ] )

        ( InitMakingDirectories state, Stdout stdout ) ->
            Ok ( toInitGettingUserProjectInfo state, fileReadRequest [ "elm.json" ] )

        ( InitGettingUserProjectInfo state, Stdout stdout ) ->
            stdout
                |> parseProject
                |> Result.andThen mapUserProjectToCucumberProject
                |> Result.map
                    (\cucumberProject ->
                        ( toInitWritingTemplates state
                        , fileWriteRequest
                            [ ( [ "cucumber", "elm.json" ], cucumberProject |> Elm.Project.encode |> E.encode 4 )
                            , ( [ "cucumber", "src", "ExampleStepDefs.elm" ], templateStepDefs )
                            , ( [ "cucumber", "features", "example.feature" ], templateFeature )
                            ]
                        )
                    )

        ( InitWritingTemplates (State state), Stdout stdout ) ->
            Ok ( toRunStart (RunOptions Nothing Nothing state.maybeCompilerPath Nothing False Console [ "example.feature" ]), message NoOp )

        ( RunStart state, NoOp ) ->
            Ok ( toRunGettingCurrentDirListing state, fileListRequest [ "." ] "*" )

        ( RunGettingCurrentDirListing state, FileList fileList ) ->
            if not (List.member "elm.json" fileList) then
                Err "Couldn't find elm.json in the current directory"

            else if not (List.member "cucumber" fileList) then
                Err "Couldn't find a cucumber folder in the current directory"

            else
                Ok
                    ( toRunGettingUserProjectInfo state
                    , fileReadRequest [ "elm.json" ]
                    )

        ( RunGettingUserProjectInfo state, Stdout stdout ) ->
            parseProject stdout
                |> Result.map
                    (\userProject ->
                        ( toRunGettingUserCucumberProjectInfo state userProject
                        , fileReadRequest [ "cucumber", "elm.json" ]
                        )
                    )

        ( RunGettingUserCucumberProjectInfo state, Stdout stdout ) ->
            parseProject stdout
                |> Result.map
                    (\userCucumberProject ->
                        ( toRunGettingModuleDir state userCucumberProject
                        , moduleDirectoryRequest
                        )
                    )

        ( RunGettingModuleDir state, FileList fileList ) ->
            case fileList of
                [ moduleDir ] ->
                    Ok ( toRunGettingModulePackageInfo state, fileReadRequest [ moduleDir, "elm.json" ] )

                _ ->
                    Err "expecting a single file as module directory"

        ( RunGettingModulePackageInfo state, Stdout stdout ) ->
            D.decodeString Elm.Project.decoder stdout
                |> Result.mapError D.errorToString
                |> Result.map
                    (\project ->
                        ( toRunUpdatingUserCucumberElmJson state
                        , fileWriteRequest [ ( [ "elm.json" ], E.encode 4 <| Elm.Project.encode project ) ]
                        )
                    )

        ( RunUpdatingUserCucumberElmJson state, Stdout typesJson ) ->
            Ok ( toRunGettingTypes state, exportedInterfacesRequest )

        ( RunGettingTypes ((State data) as state), Stdout typesJson ) ->
            typesJson
                |> D.decodeString elmiModuleListDecoder
                |> Result.mapError D.errorToString
                |> Result.map
                    (\project ->
                        ( toRunCompilingRunner state
                        , shellRequest "Runner.elm with stepdefs from typesJson"
                        )
                    )

        ( RunCompilingRunner state, NoOp ) ->
            Ok ( toRunStartingRunner state, Cmd.none )

        ( RunStartingRunner state, NoOp ) ->
            Ok ( toRunResolvingGherkinFiles state, Cmd.none )

        ( RunResolvingGherkinFiles state, NoOp ) ->
            Ok ( toRunTestingGherkinFiles state [], Cmd.none )

        ( RunTestingGherkinFiles state, NoOp ) ->
            Ok ( toRunWatching state [], Cmd.none )

        ( RunWatching state, NoOp ) ->
            Ok ( toRunCompilingRunner state, Cmd.none )

        ( state, cmd ) ->
            let
                _ =
                    Debug.log "( state, cmd )" ( state, cmd )
            in
            Err "Invalid State Transition"
    )
        |> Result.Extra.extract (\err -> ( model, exit 1 err ))


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
