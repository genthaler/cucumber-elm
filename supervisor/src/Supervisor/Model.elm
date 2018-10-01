module Supervisor.Model exposing (Model(..), makeState, toEnding, toInitCopyingTemplate, toInitGettingCurrentDir, toInitGettingModuleDir, toRunCompiling, toRunConstructingFolder, toRunGettingPackageInfo, toRunResolvingGherkinFiles, toRunStartingRunner, toRunTestingGherkinFile, toRunWatching)

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
    = InitGettingCurrentDir (State { initGettingModuleDir : Allowed } { folder : String })
    | InitGettingModuleDir (State { initCopyingTemplate : Allowed } { folder : String, currentDir : String })
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
    InitGettingCurrentDir <|
        makeState
            { folder = folder
            }


toInitGettingModuleDir : State { a | initGettingModuleDir : Allowed } { folder : String } -> String -> Model
toInitGettingModuleDir state currentDir =
    InitGettingModuleDir <|
        makeState <|
            { folder = (untag state).folder
            , currentDir = currentDir
            }


toInitCopyingTemplate : State { a | initCopyingTemplate : Allowed } { folder : String, currentDir : String } -> String -> Model
toInitCopyingTemplate state moduleDir =
    InitCopyingTemplate <|
        makeState <|
            { folder = (untag state).folder
            , currentDir = (untag state).currentDir
            , moduleDir = moduleDir
            }



-- Run state constructors

-- get current package info for project
-- confirm that cucumber-elm is there
-- construct an elm-json with project and cucumber dependencies


toRunGettingPackageInfo : RunOptions -> Model
toRunGettingPackageInfo runOptions =
    RunGettingPackageInfo <| makeState { runOptions = runOptions }


toRunConstructingFolder : State { a | constructingFolder : Allowed } { runOptions : RunOptions } -> Project -> Model
toRunConstructingFolder state project =
    RunConstructingFolder <| makeState <| { runOptions = state |> untag |> .runOptions, project = project }


toRunCompiling : State { a | compiling : Allowed } { gherkinFiles : List String } -> Model
toRunCompiling state =
    RunCompiling <| makeState <| untag state


toRunStartingRunner : State { a | startingRunner : Allowed } {} -> List String -> Model
toRunStartingRunner state gherkinFiles =
    RunStartingRunner <| makeState { gherkinFiles = gherkinFiles }


toRunResolvingGherkinFiles : State { a | resolvingGherkinFiles : Allowed } {} -> List String -> Model
toRunResolvingGherkinFiles state gherkinFiles =
    RunResolvingGherkinFiles <| makeState { gherkinFiles = gherkinFiles }


toRunTestingGherkinFile : State { a | testingGherkinFile : Allowed } {} -> List String -> Model
toRunTestingGherkinFile state gherkinFiles =
    RunTestingGherkinFiles <| makeState { remainingGherkinFiles = gherkinFiles, testedGherkinFiles = [] }


toRunWatching : State { a | watching : Allowed } {} -> List String -> Model
toRunWatching state gherkinFiles =
    RunWatching <| makeState { remainingGherkinFiles = gherkinFiles, testedGherkinFiles = [] }



-- End state constructor


toEnding : State { a | ending : Allowed } b -> Int -> Model
toEnding state exitCode =
    Ending <| makeState exitCode
