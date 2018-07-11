port module Runner exposing (..)

import Options
import PackageInfo
import Platform exposing (programWithFlags)
import Ports exposing (..)
import SupervisorState exposing (..)
import Platform exposing (programWithFlags)
import PackageInfo
import Options


-- 	1. parse options
--  1. get elm-package info
-- 		- node-elm-interface-to-json
-- 		- elm-interface-to-json
-- 		- Janiczek/package-info/1.0.0
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


type Action
    = NoOp
    | FileRead
    | FileWrite


type alias Model =
    SupervisorState


init : List String -> ( Model, Cmd msg )
init flags =
    ( start, Cmd.none )


update : Msg -> Model -> ( Mode, Cmd msg )
update msg model =
    case ( model, (Debug.log "update" msg) ) of
        ( Loading loading, Loaded gameDefinition ) ->
            ( { model | game = toReadyWithGameDefinition gameDefinition loading }
            , message StartGame
            )

        ( Ready ready, StartGame ) ->
            ( { model | game = toInPlayWithPlayState { score = 0, position = [] } ready }
            , message <| Die 123
            )

        ( InPlay inPlay, Die finalScore ) ->
            ( { model | game = toGameOver <| (updatePlayState <| updateScore finalScore) inPlay }
            , message AnotherGo
            )

        ( GameOver gameOver, AnotherGo ) ->
            ( { model | game = toReady gameOver }
            , message StartGame
            )

        ( _, _ ) ->
            ( [], Cmd.none )


subscriptions : a -> Sub Action
subscriptions model =
    case model of
        Starting _ ->
            Sub.none

        Ending _ ->
            Sub.none

        Helping _ ->
            Sub.none

        Versioning _ ->
            Sub.none

        Initialising _ ->
            Sub.none

        GettingPackageInfo _ ->
            Sub.none

        ConstructingFolder _ ->
            Sub.none

        Compiling _ ->
            Sub.none

        ShuttingDownExistingRunner _ ->
            Sub.none

        RequiringRunner _ ->
            Sub.none

        StartingRunner _ ->
            Sub.none

        ResolvingGherkinFiles _ ->
            Sub.none

        TestingGherkinFile _ ->
            Sub.none

        Watching _ ->
            Sub.none



-- Sub.batch [ input <| always NoOp, close <| always NoOp ]


main : Program Never (List a) Action
main =
    programWithFlags
        { init = init
        , update = update
        , subscriptions = subscriptions
        }
