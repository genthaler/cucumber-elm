module SupervisorState exposing (..)

import StateMachine
    exposing
        ( Allowed
        , State(State)
        , map
        , untag
        )
import Options exposing (Option, RunOptions)


makeState : model -> State trans model
makeState =
    State


type SupervisorState
    = Starting (State { help : Allowed, init : Allowed, version : Allowed } { option : Option })
    | Ending (State {} { exitCode : Int })
    | Helping (State { end : Allowed } { exitCode : Int })
    | Versioning (State { end : Allowed } { exitCode : Int })
    | Initialising (State { end : Allowed } { folder : String })
    | GettingPackageInfo (State { gameOver : Allowed } { runOptions : RunOptions })
    | ConstructingFolder (State { ready : Allowed } { runOptions : RunOptions })
    | Compiling (State { ready : Allowed } { gherkinFiles : List String })
    | ShuttingDownExistingRunner (State { ready : Allowed } { gherkinFiles : List String })
    | RequiringRunner (State { ready : Allowed } { gherkinFiles : List String })
    | StartingRunner (State { ready : Allowed } { gherkinFiles : List String })
    | ResolvingGherkinFiles (State { ready : Allowed } { gherkinFiles : List String })
    | TestingGherkinFile (State { ready : Allowed } { remainingGherkinFiles : List String, testedGherkinFiles : List String })
    | Watching (State { ready : Allowed } { testedGherkinFiles : List String, remainingGherkinFiles : List String })



-- State constructors.


toStarting : Option -> SupervisorState
toStarting option =
    Starting <| makeState { option = option }



-- State transition functions that can be applied only to states that are permitted
-- to make a transition.


toHelping : State { a | ending : Allowed } {} -> SupervisorState
toHelping {} =
    Helping <| makeState { exitCode = 0 }


toVersioning : State { a | ending : Allowed } {} -> SupervisorState
toVersioning model =
    Versioning <| makeState { exitCode = 0 }


toInitialising : String -> State { a | ending : Allowed } {} -> SupervisorState
toInitialising folder model =
    Initialising <| makeState { folder = folder }


toGettingPackageInfo : RunOptions -> SupervisorState
toGettingPackageInfo runOptions =
    GettingPackageInfo <| makeState { runOptions = runOptions }


toConstructingFolder : RunOptions -> SupervisorState
toConstructingFolder runOptions =
    ConstructingFolder <| makeState { runOptions = runOptions }


toCompiling : List String -> SupervisorState
toCompiling gherkinFiles =
    Compiling <| makeState { gherkinFiles = gherkinFiles }


toShuttingDownExistingRunner : List String -> SupervisorState
toShuttingDownExistingRunner gherkinFiles =
    ShuttingDownExistingRunner <| makeState { gherkinFiles = gherkinFiles }


toRequiringRunner : List String -> SupervisorState
toRequiringRunner gherkinFiles =
    RequiringRunner <| makeState { gherkinFiles = gherkinFiles }


toStartingRunner : List String -> SupervisorState
toStartingRunner gherkinFiles =
    StartingRunner <| makeState { gherkinFiles = gherkinFiles }


toResolvingGherkinFiles : List String -> SupervisorState
toResolvingGherkinFiles gherkinFiles =
    ResolvingGherkinFiles <| makeState { gherkinFiles = gherkinFiles }


toTestingGherkinFile : List String -> SupervisorState
toTestingGherkinFile gherkinFiles =
    TestingGherkinFile <| makeState { remainingGherkinFiles = gherkinFiles, testedGherkinFiles = [] }


toWatching : List String -> SupervisorState
toWatching gherkinFiles =
    Watching <| makeState { remainingGherkinFiles = gherkinFiles, testedGherkinFiles = [] }
