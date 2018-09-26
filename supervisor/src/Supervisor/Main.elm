module Supervisor.Main exposing (main)
 
import Cli.Program as Program
import Elm.Project exposing (..)
import Json.Decode
import Supervisor.Ports exposing (..)
import StateMachine exposing (map, untag)
import Supervisor.Options exposing (..)
import Supervisor.Model exposing (..)
import Task


type Msg 
    = NoOp
    | FileRead String
    | FileWrite String
    | FileList (List String)
    | Shell Int
    | Require Int
    | Cucumber String



message : msg -> Cmd msg
message msg =
    Task.perform identity (Task.succeed msg)


init : Program.FlagsIncludingArgv flags -> CliOptions -> ( Model, Cmd Msg )
init flags options =
    case options of
        Init folder -> 
                    ( toInitialising folder , message NoOp )
 
        RunTests runOptions ->
            (toGettingPackageInfo runOptions, message NoOp)


update : CliOptions -> Msg -> Model -> ( Model, Cmd Msg )
update cliOptions msg model =
    let
        noOp =
            ( model, Cmd.none )
    in
    case ( model, msg ) of

        ( Initialising state, NoOp ) ->
            let 
                initMessage = "Initializing test suite in folder" ++ (state |> untag |> .folder)
            in 
                (toEnding 0 state, message NoOp)

 
        ( GettingPackageInfo state, NoOp ) ->
            let 
                runOptions = state |> untag |> .runOptions
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
                (toConstructingFolder {runOptions =runOptions} state , echoRequest runMessage) 


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

        ( Ending state, NoOp ) ->
            ( model, end (state |> untag) )

        ( _, _ ) ->
            Debug.log "Invalid State Transition" noOp


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
            cucumberTestResponse Cucumber

        _ ->
            Sub.none


main : Program.StatefulProgram Model Msg CliOptions {}
main =
    Program.stateful
        { printAndExitFailure = \msg -> Cmd.batch [ echoRequest msg, end 1 ]
        , printAndExitSuccess = \msg -> Cmd.batch [ echoRequest msg, end 0 ]
        , init = init
        , config = config
        , update = update
        , subscriptions = subscriptions
        }
