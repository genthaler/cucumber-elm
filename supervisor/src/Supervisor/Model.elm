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
    = InitStart (State { initGettingCurrentDir : Allowed } { folder : String })
    | InitGettingCurrentDir (State { initGettingModuleDir : Allowed } { folder : String })
    | InitGettingModuleDir (State { ending : Allowed } { folder : String, currentDir : String })
    | InitCopyingTemplate (State { ending : Allowed } { folder : String, currentDir : String, moduleDir : String })
    | RunGettingPackageInfo (State { constructingFolder : Allowed } { runOptions : RunOptions })
    | RunConstructingFolder (State { compiling : Allowed } { runOptions : RunOptions, project : Project })
    | RunCompiling (State { startingRunner : Allowed } { gherkinFiles : List String })
    | RunStartingRunner (State { resolvingGherkinFiles : Allowed } { gherkinFiles : List String })
    | RunResolvingGherkinFiles (State { testingGherkinFile : Allowed } { gherkinFiles : List String })
    | RunTestingGherkinFiles (State { ending : Allowed, watching : Allowed } { remainingGherkinFiles : List String, testedGherkinFiles : List String })
    | RunWatching (State { resolvingGherkinFiles : Allowed } { testedGherkinFiles : List String, remainingGherkinFiles : List String })
    | Ending (State { ending : Allowed } Int)



-- Init state constructors.


toInitGettingCurrentDir : String -> Model
toInitGettingCurrentDir folder =
    InitStart <| makeState { folder = folder }


toInitGettingModuleDir : Project -> State { a | constructingFolder : Allowed } { runOptions : RunOptions } -> Model
toInitGettingModuleDir project state =
    InitGettingModuleDir <| makeState <| { runOptions = state |> untag |> .runOptions, project = project }


toInitCopyingTemplate : Project -> State { a | constructingFolder : Allowed } { runOptions : RunOptions } -> Model
toInitCopyingTemplate project state =
    InitCopyingTemplate <| makeState <| { runOptions = state |> untag |> .runOptions, project = project }


-- Run state constructors


toRunGettingPackageInfo : RunOptions -> Model
toRunGettingPackageInfo runOptions =
    RunGettingPackageInfo <| makeState { runOptions = runOptions }


toRunConstructingFolder : Project -> State { a | constructingFolder : Allowed } { runOptions : RunOptions } -> Model
toRunConstructingFolder project state =
    RunConstructingFolder <| makeState <| { runOptions = state |> untag |> .runOptions, project = project }


toRunCompiling : State { a | compiling : Allowed } { gherkinFiles : List String } -> Model
toRunCompiling state =
    RunCompiling <| makeState <| untag <| state


toRunStartingRunner : List String -> State { a | startingRunner : Allowed } {} -> Model
toRunStartingRunner gherkinFiles state =
    RunStartingRunner <| makeState { gherkinFiles = gherkinFiles }


toRunResolvingGherkinFiles : List String -> State { a | resolvingGherkinFiles : Allowed } {} -> Model
toRunResolvingGherkinFiles gherkinFiles state =
    RunResolvingGherkinFiles <| makeState { gherkinFiles = gherkinFiles }


toRunTestingGherkinFile : List String -> State { a | testingGherkinFile : Allowed } {} -> Model
toRunTestingGherkinFile gherkinFiles state =
    RunTestingGherkinFiles <| makeState { remainingGherkinFiles = gherkinFiles, testedGherkinFiles = [] }


toRunWatching : List String -> State { a | watching : Allowed } {} -> Model
toRunWatching gherkinFiles state =
    RunWatching <| makeState { remainingGherkinFiles = gherkinFiles, testedGherkinFiles = [] }

-- End state constructor

toEnding : Int -> State { a | ending : Allowed } b -> Model
toEnding exitCode state =
    Ending <| makeState exitCode
