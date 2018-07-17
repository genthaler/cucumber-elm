module SupervisorState exposing (..)

import StateMachine exposing (Allowed, State(State), map, untag)
import Options exposing (Option, RunOptions)
import PackageInfo exposing (PackageInfo)


makeState : model -> State trans model
makeState =
    State



-- The State's first type argument enforces the States that can be transitioned to, from this State


type SupervisorState
    = Starting (State { helping : Allowed, initialising : Allowed, versioning : Allowed } { option : Option })
    | Ending (State { ending : Allowed } Int)
    | Helping (State { ending : Allowed } { exitCode : Int })
    | Versioning (State { ending : Allowed } { exitCode : Int })
    | Initialising (State { ending : Allowed } { folder : String })
    | GettingPackageInfo (State { constructingFolder : Allowed } { runOptions : RunOptions })
    | ConstructingFolder (State { compiling : Allowed } { runOptions : RunOptions, packageInfo : PackageInfo })
    | Compiling (State { startingRunner : Allowed } { gherkinFiles : List String })
    | StartingRunner (State { resolvingGherkinFiles : Allowed } { gherkinFiles : List String })
    | ResolvingGherkinFiles (State { testingGherkinFile : Allowed } { gherkinFiles : List String })
    | TestingGherkinFiles (State { ending : Allowed, watching : Allowed } { remainingGherkinFiles : List String, testedGherkinFiles : List String })
    | Watching (State { resolvingGherkinFiles : Allowed } { testedGherkinFiles : List String, remainingGherkinFiles : List String })



-- Initial state constructor.


toStarting : Option -> SupervisorState
toStarting option =
    Starting <| makeState { option = option }



-- State transition functions that can be applied only to states that are permitted
-- to make a transition.


toHelping : State { a | helping : Allowed } b -> SupervisorState
toHelping state =
    Helping <| makeState { exitCode = 0 }


toVersioning : State { a | versioning : Allowed } b -> SupervisorState
toVersioning state =
    Versioning <| makeState { exitCode = 0 }


toInitialising : String -> State { a | initialising : Allowed } b -> SupervisorState
toInitialising folder state =
    Initialising <| makeState { folder = folder }


toGettingPackageInfo : RunOptions -> State { a | gettingPackageInfo : Allowed } b -> SupervisorState
toGettingPackageInfo runOptions state =
    GettingPackageInfo <| makeState { runOptions = runOptions }


toConstructingFolder : PackageInfo -> State { a | constructingFolder : Allowed } { runOptions : RunOptions } -> SupervisorState
toConstructingFolder packageInfo state =
    ConstructingFolder <| makeState <| { runOptions = state |> untag |> .runOptions, packageInfo = packageInfo }


toCompiling : State { a | compiling : Allowed } { gherkinFiles : List String } -> SupervisorState
toCompiling state =
    Compiling <| makeState <| untag <| state


toStartingRunner : List String -> State { a | startingRunner : Allowed } {} -> SupervisorState
toStartingRunner gherkinFiles state =
    StartingRunner <| makeState { gherkinFiles = gherkinFiles }


toResolvingGherkinFiles : List String -> State { a | resolvingGherkinFiles : Allowed } {} -> SupervisorState
toResolvingGherkinFiles gherkinFiles state =
    ResolvingGherkinFiles <| makeState { gherkinFiles = gherkinFiles }


toTestingGherkinFile : List String -> State { a | testingGherkinFile : Allowed } {} -> SupervisorState
toTestingGherkinFile gherkinFiles state =
    TestingGherkinFiles <| makeState { remainingGherkinFiles = gherkinFiles, testedGherkinFiles = [] }


toWatching : List String -> State { a | watching : Allowed } {} -> SupervisorState
toWatching gherkinFiles state =
    Watching <| makeState { remainingGherkinFiles = gherkinFiles, testedGherkinFiles = [] }


toEnding : Int -> State { a | ending : Allowed } b -> SupervisorState
toEnding exitCode state =
    Ending <| makeState exitCode
