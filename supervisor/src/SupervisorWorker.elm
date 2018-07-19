port module SupervisorWorker exposing (..)

import Options exposing (..)
import PackageInfo exposing (decoder)
import Platform exposing (programWithFlags)
import Ports exposing (..)
import SupervisorState exposing (..)
import Task
import StateMachine exposing (untag, map)
import Json.Decode
import Help exposing (..)


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


init : List String -> ( Model, Cmd Msg )
init flags =
    ( toStarting <|
        Maybe.withDefault Help <|
            (parseArgs flags)
    , message NoOp
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        noOp =
            ( model, Cmd.none )
    in
        case Debug.log "( model, msg ) = " ( model, msg ) of
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
                ( toEnding 0 state, echoRequest helpText )

            ( Versioning state, msg ) ->
                case msg of
                    NoOp ->
                        ( model, fileReadRequest "elm-package.json" )

                    FileRead content ->
                        case Json.Decode.decodeString PackageInfo.decoder content of
                            Ok packageInfo ->
                                ( toEnding 0 state
                                , echoRequest
                                    ("Version: "
                                        ++ (String.join "." <|
                                                List.map
                                                    (toString << (\f -> f packageInfo.version))
                                                    [ .major, .minor, .patch ]
                                           )
                                    )
                                )

                            Err err ->
                                ( toEnding 1 state, echoRequest ("Version: " ++ (err)) )

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
            cucumberTestResponse Cucumber

        _ ->
            Sub.none


main : Program (List String) Model Msg
main =
    programWithFlags
        { init = init
        , update = update
        , subscriptions = subscriptions
        }
