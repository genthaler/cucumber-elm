module Supervisor.Model exposing (Model(..), toInitCopyingTemplate, toInitGettingCurrentDirListing, toInitGettingModuleDir, toInitStart, toRunCompiling, toRunConstructingFolder, toRunGettingModuleDir, toRunGettingModulePackageInfo, toRunGettingUserCucumberPackageInfo, toRunGettingUserPackageInfo, toRunResolvingGherkinFiles, toRunStart, toRunStartingRunner, toRunTestingGherkinFiles, toRunWatching)

import Elm.Project exposing (..)
import StateMachine exposing (Allowed, State(..), map)
import Supervisor.Options exposing (RunOptions)



{-
   The State's first type argument enforces the States that can be transitioned to, from this State
   So taking the first one as an example, if we're in Starting state, we can only transition to the Helping state,
   which is done in the toHelping function, where you can see the type signature matching.

   The only way to transition from one state to another is through one of the state transition methods in this module.
-}


type Model
    = InitStart (State { initGettingModuleDir : Allowed } {})
    | InitGettingModuleDir (State { initGettingCurrentDirListing : Allowed } {})
    | InitGettingCurrentDirListing (State { initCopyingTemplate : Allowed } { moduleDir : String })
    | InitCopyingTemplate (State {} {})
    | RunStart (State { runGettingCurrentDirListing : Allowed } { runOptions : RunOptions })
    | RunGettingCurrentDirListing (State { runGettingUserPackageInfo : Allowed } { runOptions : RunOptions })
    | RunGettingUserPackageInfo (State { runConstructingFolder : Allowed } { runOptions : RunOptions })
    | RunGettingUserCucumberPackageInfo (State { runConstructingFolder : Allowed } { runOptions : RunOptions, userProject : Project })
    | RunGettingModuleDir (State { runConstructingFolder : Allowed } { runOptions : RunOptions, userProject : Project, userCucumberProject : Project })
    | RunGettingModulePackageInfo (State { runConstructingFolder : Allowed } { runOptions : RunOptions, userProject : Project, userCucumberProject : Project })
    | RunConstructingFolder (State { runCompiling : Allowed } { runOptions : RunOptions, project : Project })
    | RunCompiling (State { runStartingRunner : Allowed } { gherkinFiles : List String })
    | RunStartingRunner (State { runResolvingGherkinFiles : Allowed } { gherkinFiles : List String })
    | RunResolvingGherkinFiles (State { runResolvingGherkinFiles : Allowed } { gherkinFiles : List String })
    | RunTestingGherkinFiles (State { runWatching : Allowed } { remainingGherkinFiles : List String, testedGherkinFiles : List String })
    | RunWatching (State { runResolvingGherkinFiles : Allowed, runCompiling : Allowed } { testedGherkinFiles : List String, remainingGherkinFiles : List String })



-- Init state constructors.


toInitStart : Model
toInitStart =
    InitStart <| State {}


toInitGettingModuleDir : State { a | initGettingModuleDir : Allowed } {} -> Model
toInitGettingModuleDir (State state) =
    InitGettingModuleDir <| State state


toInitGettingCurrentDirListing : State { a | initGettingCurrentDirListing : Allowed } {} -> String -> Model
toInitGettingCurrentDirListing state moduleDir =
    InitGettingCurrentDirListing <| State { moduleDir = moduleDir }


toInitCopyingTemplate : State { a | initCopyingTemplate : Allowed } b -> Model
toInitCopyingTemplate state =
    InitCopyingTemplate <| State <| {}



-- Run state constructors


toRunStart : RunOptions -> Model
toRunStart runOptions =
    RunStart <| State { runOptions = runOptions }


toRunGettingUserPackageInfo : State { a | runGettingPackageInfo : Allowed } { runOptions : RunOptions } -> Model
toRunGettingUserPackageInfo (State state) =
    RunGettingUserPackageInfo <| State state


toRunGettingUserCucumberPackageInfo : State { a | runGettingPackageInfo : Allowed } { runOptions : RunOptions } -> Project -> Model
toRunGettingUserCucumberPackageInfo (State state) userProject =
    RunGettingUserCucumberPackageInfo <| State { runOptions = state.runOptions, userProject = userProject }

 
toRunGettingModuleDir : State { a | runGettingModuleDir : Allowed } {runOptions : RunOptions , userProject : Project} -> Project -> Model
toRunGettingModuleDir (State state) userCucumberProject=
    RunGettingModuleDir <| State { runOptions = state.runOptions, userProject = state.userProject, userCucumberProject = userCucumberProject }


toRunGettingModulePackageInfo : State { a | runGettingPackageInfo : Allowed } { runOptions : RunOptions, userProject : Project, userCucumberProject : Project } -> Model
toRunGettingModulePackageInfo (State state) =
    RunGettingModulePackageInfo <| State state


toRunConstructingFolder : State { a | runConstructingFolder : Allowed } { runOptions : RunOptions } -> Project -> Model
toRunConstructingFolder (State state) project =
    RunConstructingFolder <| State { runOptions = state.runOptions, project = project }


toRunCompiling : State { a | runCompiling : Allowed } { gherkinFiles : List String } -> Model
toRunCompiling (State state) =
    RunCompiling <| State <| state


toRunStartingRunner : State { a | runStartingRunner : Allowed } {} -> List String -> Model
toRunStartingRunner (State state) gherkinFiles =
    RunStartingRunner <| State { gherkinFiles = gherkinFiles }


toRunResolvingGherkinFiles : State { a | runResolvingGherkinFiles : Allowed } {} -> List String -> Model
toRunResolvingGherkinFiles (State state) gherkinFiles =
    RunResolvingGherkinFiles <| State { gherkinFiles = gherkinFiles }


toRunTestingGherkinFiles : State { a | runTestingGherkinFile : Allowed } {} -> List String -> Model
toRunTestingGherkinFiles (State state) gherkinFiles =
    RunTestingGherkinFiles <| State { remainingGherkinFiles = gherkinFiles, testedGherkinFiles = [] }


toRunWatching : State { a | runWatching : Allowed } {} -> List String -> Model
toRunWatching (State state) gherkinFiles =
    RunWatching <| State { remainingGherkinFiles = gherkinFiles, testedGherkinFiles = [] }
