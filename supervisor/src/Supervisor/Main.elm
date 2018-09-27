module Supervisor.Main exposing (main)

import Cli.Program as Program
import Elm.Project exposing (..)
import Json.Decode
import StateMachine exposing (map, untag)
import Supervisor.Model exposing (..)
import Supervisor.Options exposing (..)
import Supervisor.Ports exposing (..)
import Task


type Msg
    = NoOp
    | FileRead String
    | FileWrite String
    | FileList (List String)
    | Shell Int
    | Require Int
    | Cucumber String

type InitActions
    = GetCurrentDir
    | GetModuleDir
    | CopyModuleDir
    | InitEnd

type RunActions
    = GetPackageInfo

message : msg -> Cmd msg
message msg =
    Task.perform identity (Task.succeed msg)


init : Program.FlagsIncludingArgv flags -> CliOptions -> ( Model, Cmd Msg )
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
            ( toRunGettingPackageInfo runOptions, echoRequest runMessage )


update : CliOptions -> Msg -> Model -> ( Model, Cmd Msg )
update cliOptions msg model =
    let
        noOp =
            ( model, Cmd.none )
    in
    case ( model, msg ) of
        ( InitStart state, NoOp ) ->
            let
                folder = state |> untag |> .folder
            in
            -- Need to get current directory, module directory, copy template directory to destination
            -- Maybe test compile?
            -- Is this better done with a list of Taskish things to be done?
            -- Problem is, you can't pass functions around in a model
            -- So define a type with actions
            -- create a list of those actions
            -- on each update, match the top of the list and its expected message
            -- if no match, error, else compute model and send message off and send a message
            -- sounds a bit simpler than the state machine

            ( toInitGettingCurrentDir ) 

        ( RunGettingPackageInfo state, NoOp ) ->
            let
                runOptions =
                    state |> untag |> .runOptions
            in 
            noOp
            -- ( toRunConstructingFolder { runOptions = runOptions, project = project } state, )

        ( RunConstructingFolder _, NoOp ) ->
            noOp

        ( RunCompiling _, NoOp ) ->
            noOp

        ( RunStartingRunner _, NoOp ) ->
            noOp

        ( RunResolvingGherkinFiles _, NoOp ) ->
            noOp

        ( RunTestingGherkinFiles _, NoOp ) ->
            noOp

        ( RunWatching _, NoOp ) ->
            noOp

        ( Ending state, NoOp ) ->
            ( model, end (state |> untag) )

        ( _, _ ) ->
            ( model, logAndExit 1 
                "Invalid State Transition")

subscriptions : Model -> Sub Msg
subscriptions model =
    case model of
        InitStart _ ->
            fileReadResponse FileRead

        RunGettingPackageInfo _ ->
            Sub.none

        RunConstructingFolder _ ->
            fileWriteResponse FileWrite

        RunCompiling _ ->
            shellResponse Shell

        RunStartingRunner _ ->
            Sub.none

        RunResolvingGherkinFiles _ ->
            Sub.none

        RunTestingGherkinFiles _ ->
            cucumberTestResponse Cucumber

        _ ->
            Sub.none


main : Program.StatefulProgram Model Msg CliOptions {}
main =
    Program.stateful
        { printAndExitFailure = logAndExit 1
        , printAndExitSuccess = logAndExit 0
        , init = init
        , config = config
        , update = update
        , subscriptions = subscriptions
        }
