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


makeState =
    State


type SupervisorState
    = Started (State { ready : Allowed } { args : List String })
    | Ready (State { inPlay : Allowed } {})
    | InPlay (State { gameOver : Allowed } {})
    | GameOver (State { ready : Allowed } {})



-- State constructors.


started : List String -> SupervisorState
started args =
    makeState {} |> Started args


ready : GameDefinition -> SupervisorState
ready definition =
    makeState { definition = definition } |> Ready


inPlay : GameDefinition -> PlayState -> SupervisorState
inPlay definition play =
    makeState { definition = definition, play = play } |> InPlay


gameOver : GameDefinition -> Int -> SupervisorState
gameOver definition score =
    makeState { definition = definition, finalScore = score } |> GameOver



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


toReady : State { a | ready : Allowed } { m | definition : GameDefinition } -> Game
toReady (State model) =
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
