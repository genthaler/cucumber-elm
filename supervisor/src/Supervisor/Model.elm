module Supervisor.Model exposing (Model(..), toExiting, toInitCopyingTemplate, toInitGettingCurrentDir, toInitGettingModuleDir, toInitStart, toRunCompiling, toRunConstructingFolder, toRunGettingPackageInfo, toRunResolvingGherkinFiles, toRunStart, toRunStartingRunner, toRunTestingGherkinFiles, toRunWatching)

import Elm.Project exposing (..)
import StateMachine exposing (Allowed, State(..), map, untag)
import Supervisor.Options exposing (RunOptions)



{-
   The State's first type argument enforces the States that can be transitioned to, from this State
   So taking the first one as an example, if we're in Starting state, we can only transition to the Helping state,
   which is done in the toHelping function, where you can see the type signature matching.

   The only way to transition from one state to another is through one of the state transition methods in this module.
-}


type Model
    = InitStart (State { initGettingCurrentDir : Allowed } { folder : String })
    | InitGettingCurrentDir (State { initGettingModuleDir : Allowed } { folder : String })
    | InitGettingModuleDir (State { initCopyingTemplate : Allowed } { folder : String, currentDir : String })
    | InitCopyingTemplate (State { exiting : Allowed } { folder : String, currentDir : String, moduleDir : String })
    | RunStart (State { runGettingPackageInfo : Allowed } { runOptions : RunOptions })
    | RunGettingPackageInfo (State { runConstructingFolder : Allowed } { runOptions : RunOptions })
    | RunConstructingFolder (State { runCompiling : Allowed } { runOptions : RunOptions, project : Project })
    | RunCompiling (State { runStartingRunner : Allowed } { gherkinFiles : List String })
    | RunStartingRunner (State { runResolvingGherkinFiles : Allowed } { gherkinFiles : List String })
    | RunResolvingGherkinFiles (State { runResolvingGherkinFiles : Allowed } { gherkinFiles : List String })
    | RunTestingGherkinFiles (State { exiting : Allowed, watching : Allowed } { remainingGherkinFiles : List String, testedGherkinFiles : List String })
    | RunWatching (State { runResolvingGherkinFiles : Allowed, runCompiling : Allowed } { testedGherkinFiles : List String, remainingGherkinFiles : List String })
    | Exiting (State { exiting : Allowed } Int)



-- Init state constructors.


toInitStart : String -> Model
toInitStart folder =
    InitStart <| State { folder = folder }


toInitGettingTargetDir : State { a | initGettingCurrentDir : Allowed } { folder : String } -> Model
toInitGettingTargetDir state =
    InitGettingCurrentDir <| State <| untag state


toInitGettingModuleDir : State { a | initGettingModuleDir : Allowed } { folder : String } -> String -> Model
toInitGettingModuleDir state currentDir =
    InitGettingModuleDir <|
        State <|
            { folder = (untag state).folder
            , currentDir = currentDir
            }


toInitCopyingTemplate : State { a | initCopyingTemplate : Allowed } { folder : String, currentDir : String } -> String -> Model
toInitCopyingTemplate state moduleDir =
    InitCopyingTemplate <|
        State <|
            { folder = (untag state).folder
            , currentDir = (untag state).currentDir
            , moduleDir = moduleDir
            }



-- Run state constructors


toRunStart : RunOptions -> Model
toRunStart runOptions =
    RunStart <| State { runOptions = runOptions }


toRunGettingPackageInfo : State { a | runConstructingFolder : Allowed } { runOptions : RunOptions } -> Model
toRunGettingPackageInfo state =
    RunGettingPackageInfo <| State <| untag state


toRunConstructingFolder : State { a | runConstructingFolder : Allowed } { runOptions : RunOptions } -> Project -> Model
toRunConstructingFolder state project =
    RunConstructingFolder <| State <| { runOptions = state |> untag |> .runOptions, project = project }


toRunCompiling : State { a | runCompiling : Allowed } { gherkinFiles : List String } -> Model
toRunCompiling state =
    RunCompiling <| State <| untag state


toRunStartingRunner : State { a | runStartingRunner : Allowed } {} -> List String -> Model
toRunStartingRunner state gherkinFiles =
    RunStartingRunner <| State { gherkinFiles = gherkinFiles }


toRunResolvingGherkinFiles : State { a | runResolvingGherkinFiles : Allowed } {} -> List String -> Model
toRunResolvingGherkinFiles state gherkinFiles =
    RunResolvingGherkinFiles <| State { gherkinFiles = gherkinFiles }


toRunTestingGherkinFiles : State { a | runTestingGherkinFile : Allowed } {} -> List String -> Model
toRunTestingGherkinFiles state gherkinFiles =
    RunTestingGherkinFiles <| State { remainingGherkinFiles = gherkinFiles, testedGherkinFiles = [] }


toRunWatching : State { a | runWatching : Allowed } {} -> List String -> Model
toRunWatching state gherkinFiles =
    RunWatching <| State { remainingGherkinFiles = gherkinFiles, testedGherkinFiles = [] }



-- End state constructor


toExiting : State { a | exiting : Allowed } b -> Int -> Model
toExiting state exitCode =
    Exiting <| State exitCode
