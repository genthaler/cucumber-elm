module SupervisorState exposing (..)

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
    = Starting (State { help : Allowed, init : Allowed, version : Allowed } { args : List String })
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


start : List String -> SupervisorState
start args =
    Starting <| makeState { args = args }


help : Int -> SupervisorState
help exitCode =
    Helping <| makeState { exitCode = exitCode }


version : Int -> SupervisorState
version exitCode =
    Versioning <| makeState { exitCode = exitCode }


initialise : String -> SupervisorState
initialise folder =
    Initialising <| makeState { folder = folder }


getPackageInfo : RunOptions -> SupervisorState
getPackageInfo runOptions =
    GettingPackageInfo <| makeState { runOptions = runOptions }


constructFolder : RunOptions -> SupervisorState
constructFolder runOptions =
    ConstructingFolder <| makeState { runOptions = runOptions }


compile : List String -> SupervisorState
compile gherkinFiles =
    Compiling <| makeState { gherkinFiles = gherkinFiles }


shutDownExistingRunner : List String -> SupervisorState
shutDownExistingRunner gherkinFiles =
    ShuttingDownExistingRunner <| makeState { gherkinFiles = gherkinFiles }


requireRunner : List String -> SupervisorState
requireRunner gherkinFiles =
    RequiringRunner <| makeState { gherkinFiles = gherkinFiles }


startRunner : List String -> SupervisorState
startRunner gherkinFiles =
    StartingRunner <| makeState { gherkinFiles = gherkinFiles }


resolveGherkinFiles : List String -> SupervisorState
resolveGherkinFiles gherkinFiles =
    ResolvingGherkinFiles <| makeState { gherkinFiles = gherkinFiles }


testGherkinFile : List String -> SupervisorState
testGherkinFile gherkinFiles =
    TestingGherkinFile <| makeState { remainingGherkinFiles = gherkinFiles, testedGherkinFiles = [] }


watch : List String -> SupervisorState
watch gherkinFiles =
    Watching <| makeState { remainingGherkinFiles = gherkinFiles, testedGherkinFiles = [] }



-- State transition functions that can be applied only to states that are permitted
-- to make a transition.


toHelp : State { a | started : Allowed } {} -> SupervisorState
toHelp (State { a } ({ exitCode } as model)) =
    help exitCode
