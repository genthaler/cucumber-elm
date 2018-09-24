port module SupervisorWorker exposing (Model, Msg(..), init, main, message, subscriptions, update)

import Cli.Program as Program
import Elm.Project exposing (..)
import Json.Decode
import Ports exposing (..)
import StateMachine exposing (map, untag)
import SupervisorOptions exposing (..)
import SupervisorState exposing (..)
import Task


type Msg
    = NoOp
    | FileRead String
    | FileWrite String
    | FileList (List String)
    | Shell Int
    | Require Int
    | Cucumber String


type alias Model =
    SupervisorState


message : msg -> Cmd msg
message msg =
    Task.perform identity (Task.succeed msg)


init : Program.FlagsIncludingArgv flags -> CliOptions -> ( Model, Cmd msg )
init flags options =
    ( toStarting options
    , (case options of
        Init folder ->
            "Initializing test suite..."

        RunTests runOptions ->
            [ "Running the following test files: " ++ Debug.toString runOptions.testFiles |> Just
            , "watch: " ++ Debug.toString runOptions.watch |> Just
            , runOptions.maybeFuzz |> Maybe.map (\glueArgumentsFunction -> "glue-arguments-function: " ++ Debug.toString glueArgumentsFunction)
            , runOptions.maybeSeed |> Maybe.map (\tags -> "tags: " ++ Debug.toString tags)
            , runOptions.reportFormat |> Debug.toString |> Just
            , runOptions.maybeCompilerPath |> Maybe.map (\compilerPath -> "compiler: " ++ Debug.toString compilerPath)
            , runOptions.maybeDependencies |> Maybe.map (\dependencies -> "dependencies: " ++ Debug.toString dependencies)
            ]
                |> List.filterMap identity
                |> String.join "\n"
      )
        |> echoRequest
    )


update : CliOptions -> Msg -> Model -> ( Model, Cmd Msg )
update cliOptions msg model =
    let
        noOp =
            ( model, Cmd.none )
    in
    case ( model, msg ) of
        ( Starting state, NoOp ) ->
            case state |> untag |> .option of
                -- Help ->
                --     ( toHelping state, message NoOp )
                -- Version ->
                --     ( toVersioning state, message NoOp )
                Init folder ->
                    ( toInitialising
                        (Maybe.withDefault "." folder)
                        state
                    , message NoOp
                    )

                RunTests runOption ->
                    ( model, message NoOp )

        ( Ending state, NoOp ) ->
            ( model, end (state |> untag) )

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
        { printAndExitFailure = (\msg -> Cmd.batch [echoRequest msg, end 1])
        , printAndExitSuccess = (\msg -> Cmd.batch [echoRequest msg, end 0])
        , init = init
        , config = config
        , update = update
        , subscriptions = subscriptions
        }
