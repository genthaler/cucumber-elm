module Supervisor.Model exposing (Model(..), makeState, toCompiling, toConstructingFolder, toEnding, toGettingPackageInfo, toInitStart, toResolvingGherkinFiles, toStartingRunner, toTestingGherkinFile, toWatching)

import Elm.Project exposing (..)
import StateMachine exposing (Allowed, State(..), map, untag)
import Supervisor.Options exposing (CliOptions, RunOptions)


makeState : model -> State trans model
makeState =
    State



{-
   The State's first type argument enforces the States that can be transitioned to, from this State
   So taking the first one as an example, if we're in Starting state, we can only transition to the Helping state,
   which is done in the toHelping function, where you can see the type signature matching.

   The only way to transition from one state to another is through one of the state transition methods in this module.
-}


type Model
    = InitStart (State { ending : Allowed } { folder : String })
    | InitGettingCurrentDir (State { ending : Allowed } { folder : String })
    | InitGettingModuleDir (State { ending : Allowed } { folder : String, currentDir: String })
    | InitCopyingTemplate (State { ending : Allowed } { folder : String, currentDir: String, moduleDir:String })
    | GettingPackageInfo (State { constructingFolder : Allowed } { runOptions : RunOptions })
    | ConstructingFolder (State { compiling : Allowed } { runOptions : RunOptions, project : Project })
    | Compiling (State { startingRunner : Allowed } { gherkinFiles : List String })
    | StartingRunner (State { resolvingGherkinFiles : Allowed } { gherkinFiles : List String })
    | ResolvingGherkinFiles (State { testingGherkinFile : Allowed } { gherkinFiles : List String })
    | TestingGherkinFiles (State { ending : Allowed, watching : Allowed } { remainingGherkinFiles : List String, testedGherkinFiles : List String })
    | Watching (State { resolvingGherkinFiles : Allowed } { testedGherkinFiles : List String, remainingGherkinFiles : List String })
    | Ending (State { ending : Allowed } Int)



-- Initial state constructors.


toInitStart : String -> Model
toInitStart folder =
    InitStart <| makeState { folder = folder }


toGettingPackageInfo : RunOptions -> Model
toGettingPackageInfo runOptions =
    GettingPackageInfo <| makeState { runOptions = runOptions }



-- Init state transition functions 


toConstructingFolder : Project -> State { a | constructingFolder : Allowed } { runOptions : RunOptions } -> Model
toConstructingFolder project state =
    ConstructingFolder <| makeState <| { runOptions = state |> untag |> .runOptions, project = project }


toCompiling : State { a | compiling : Allowed } { gherkinFiles : List String } -> Model
toCompiling state =
    Compiling <| makeState <| untag <| state


toStartingRunner : List String -> State { a | startingRunner : Allowed } {} -> Model
toStartingRunner gherkinFiles state =
    StartingRunner <| makeState { gherkinFiles = gherkinFiles }


toResolvingGherkinFiles : List String -> State { a | resolvingGherkinFiles : Allowed } {} -> Model
toResolvingGherkinFiles gherkinFiles state =
    ResolvingGherkinFiles <| makeState { gherkinFiles = gherkinFiles }


toTestingGherkinFile : List String -> State { a | testingGherkinFile : Allowed } {} -> Model
toTestingGherkinFile gherkinFiles state =
    TestingGherkinFiles <| makeState { remainingGherkinFiles = gherkinFiles, testedGherkinFiles = [] }


toWatching : List String -> State { a | watching : Allowed } {} -> Model
toWatching gherkinFiles state =
    Watching <| makeState { remainingGherkinFiles = gherkinFiles, testedGherkinFiles = [] }


toEnding : Int -> State { a | ending : Allowed } b -> Model
toEnding exitCode state =
    Ending <| makeState exitCode
