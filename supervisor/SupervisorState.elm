module SupervisorState
    exposing
        ( SupervisorState(..)
        , loading
        , updateGameDefinition
        , updatePlayState
        , updateScore
        , toReady
        , toReadyWithGameDefinition
        , toInPlayWithPlayState
        , toGameOver
        )

import StateMachine
    exposing
        ( Allowed
        , State(State)
        , map
        , untag
        )
import Options exposing (Option, RunOptions)


makeState =
    State


type SupervisorState
    = Started (State { help : Allowed, init : Allowed, version : Allowed } { args : List String })
    | Ending (State {} { exitCode : Int })
    | Help (State { end : Allowed } { exitCode : Int })
    | Init (State { end : Allowed } {})
    | GettingPackageInfo (State { gameOver : Allowed } { runOptions : RunOptions })
    | ConstructingFolder (State { ready : Allowed } {})
    | Compiling (State { ready : Allowed } {})
    | ShuttingDownExistingRunner (State { ready : Allowed } {})
    | RequiringRunner (State { ready : Allowed } {})
    | StartingRunner (State { ready : Allowed } {})
    | ResolvingGherkinFiles (State { ready : Allowed } {})
    | TestingGherkinFile (State { ready : Allowed } { testedGherkinFiles : List String, remainingGherkinFiles : List String })



-- State constructors.


started : List String -> SupervisorState
started args =
    makeState {} |> Started args


help : Int -> SupervisorState
help exitCode =
    makeState { exitCode = exitCode } |> Help


version : Int -> SupervisorState
version exitCode =
    makeState { exitCode = exitCode } |> Help


initStart : Int -> SupervisorState
initStart exitCode =
    makeState { exitCode = exitCode } |> Help



-- Update functions that can be applied when parts of the model are present.


mapDefinition : (a -> b) -> ({ m | definition : a } -> { m | definition : b })
mapDefinition func =
    \model -> { model | definition = func model.definition }


mapPlay : (a -> b) -> ({ m | play : a } -> { m | play : b })
mapPlay func =
    \model -> { model | play = func model.play }


updateGameDefinition :
    (GameDefinition -> GameDefinition)
    -> State p { m | definition : GameDefinition }
    -> State p { m | definition : GameDefinition }
updateGameDefinition func state =
    map (mapDefinition func) state


updatePlayState :
    (PlayState -> PlayState)
    -> State p { m | play : PlayState }
    -> State p { m | play : PlayState }
updatePlayState func state =
    map (mapPlay func) state


updateScore : Int -> PlayState -> PlayState
updateScore score play =
    { play | score = score }



-- State transition functions that can be applied only to states that are permitted
-- to make a transition.


toHelp : State { a | started : Allowed } { m | definition : GameDefinition } -> Game
toHelp (State model) =
    ready model.definition


toReadyWithGameDefinition : GameDefinition -> State { a | ready : Allowed } m -> Game
toReadyWithGameDefinition definition game =
    ready definition


toInPlayWithPlayState : PlayState -> State { a | inPlay : Allowed } { m | definition : GameDefinition } -> Game
toInPlayWithPlayState play (State model) =
    inPlay model.definition play


toGameOver : State { a | gameOver : Allowed } { m | definition : GameDefinition, play : PlayState } -> Game
toGameOver (State model) =
    gameOver model.definition model.play.score
