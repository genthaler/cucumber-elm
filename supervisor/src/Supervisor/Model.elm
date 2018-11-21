module Supervisor.Model exposing (CliOptions(..), InitOptions, Model(..), ReportFormat(..), RunOptions, toInitGettingCurrentDirListing, toInitGettingUserProjectInfo, toInitMakingDirectories, toInitStart, toInitWritingTemplates, toRunCompilingRunner, toRunGettingCurrentDirListing, toRunGettingModuleDir, toRunGettingModulePackageInfo, toRunGettingTypes, toRunGettingUserCucumberProjectInfo, toRunGettingUserProjectInfo, toRunResolvingGherkinFiles, toRunStart, toRunStartingRunner, toRunTestingGherkinFiles, toRunUpdatingUserCucumberElmJson, toRunWatching)

import Dict
import Elm.Constraint
import Elm.Package
import Elm.Project
import Elm.Version
import Json.Decode as D
import Set
import StateMachine exposing (Allowed, State(..), map)
import String.Format
import Supervisor.Package exposing (..)



{-
   The State's first type argument enforces the States that can be transitioned to, from this State
   So taking the first one as an example, if we're in Starting state, we can only transition to the Helping state,
   which is done in the toHelping function, where you can see the type signature matching.

   The only way to transition from one state to another is through one of the state transition methods in this module.
-}


type CliOptions
    = Init InitOptions
    | RunTests RunOptions


type alias InitOptions =
    { maybeCompilerPath : Maybe String }


type alias RunOptions =
    { maybeGlueArgumentsFunction : Maybe String
    , maybeTags : Maybe String
    , maybeCompilerPath : Maybe String
    , maybeDependencies : Maybe String
    , watch : Bool
    , reportFormat : ReportFormat
    , testFiles : List String
    }


type ReportFormat
    = Json
    | Junit
    | Console


type Model
    = InitStart (State { initGettingCurrentDirListing : Allowed } { maybeCompilerPath : Maybe String })
    | InitGettingCurrentDirListing (State { initMakingDirectories : Allowed } { maybeCompilerPath : Maybe String })
    | InitMakingDirectories (State { initGettingUserProjectInfo : Allowed } { maybeCompilerPath : Maybe String })
    | InitGettingUserProjectInfo (State { initWritingTemplates : Allowed } { maybeCompilerPath : Maybe String })
    | InitWritingTemplates (State {} {maybeCompilerPath : Maybe String})
    | RunStart (State { runGettingCurrentDirListing : Allowed } { runOptions : RunOptions })
    | RunGettingCurrentDirListing (State { runGettingUserProjectInfo : Allowed } { runOptions : RunOptions })
    | RunGettingUserProjectInfo (State { runGettingUserCucumberProjectInfo : Allowed } { runOptions : RunOptions })
    | RunGettingUserCucumberProjectInfo (State { runGettingModuleDir : Allowed } { runOptions : RunOptions, userProject : Elm.Project.Project })
    | RunGettingModuleDir (State { runGettingModulePackageInfo : Allowed } { runOptions : RunOptions, userProject : Elm.Project.Project, userCucumberProject : Elm.Project.Project })
    | RunGettingModulePackageInfo (State { runUpdatingUserCucumberElmJson : Allowed } { runOptions : RunOptions, userProject : Elm.Project.Project, userCucumberProject : Elm.Project.Project })
    | RunUpdatingUserCucumberElmJson (State { runGettingTypes : Allowed } { runOptions : RunOptions })
    | RunGettingTypes (State { runCompilingRunner : Allowed } { runOptions : RunOptions })
    | RunCompilingRunner (State { runStartingRunner : Allowed } { runOptions : RunOptions })
    | RunStartingRunner (State { runResolvingGherkinFiles : Allowed } { runOptions : RunOptions })
    | RunResolvingGherkinFiles (State { runTestingGherkinFiles : Allowed } { runOptions : RunOptions })
    | RunTestingGherkinFiles (State { runWatching : Allowed } { runOptions : RunOptions, remainingGherkinFiles : List String, testedGherkinFiles : List String })
    | RunWatching (State { runResolvingGherkinFiles : Allowed, runCompilingRunner : Allowed } { runOptions : RunOptions })

 

-- Init state constructors.


toInitStart : InitOptions -> Model
toInitStart initOptions =
    InitStart <| State { maybeCompilerPath = initOptions.maybeCompilerPath }


toInitGettingCurrentDirListing : State { a | initGettingCurrentDirListing : Allowed } { maybeCompilerPath : Maybe String } -> Model
toInitGettingCurrentDirListing (State state) =
    InitGettingCurrentDirListing <| State state


toInitMakingDirectories : State { a | initMakingDirectories : Allowed } { maybeCompilerPath : Maybe String } -> Model
toInitMakingDirectories (State state) =
    InitMakingDirectories <| State state


toInitGettingUserProjectInfo : State { a | initGettingUserProjectInfo : Allowed } { maybeCompilerPath : Maybe String } -> Model
toInitGettingUserProjectInfo (State state) =
    InitGettingUserProjectInfo <| State state


toInitWritingTemplates : State { a | initWritingTemplates : Allowed } { maybeCompilerPath : Maybe String } -> Model
toInitWritingTemplates (State state) =
    InitWritingTemplates <| State state



-- Run state constructors


toRunStart : RunOptions -> Model
toRunStart runOptions =
    RunStart <| State { runOptions = runOptions }


toRunGettingCurrentDirListing : State { a | runGettingCurrentDirListing : Allowed } { runOptions : RunOptions } -> Model
toRunGettingCurrentDirListing (State state) =
    RunGettingCurrentDirListing <| State state


toRunGettingUserProjectInfo : State { a | runGettingUserProjectInfo : Allowed } { runOptions : RunOptions } -> Model
toRunGettingUserProjectInfo (State state) =
    RunGettingUserProjectInfo <| State state


toRunGettingUserCucumberProjectInfo : State { a | runGettingUserCucumberProjectInfo : Allowed } { runOptions : RunOptions } -> Elm.Project.Project -> Model
toRunGettingUserCucumberProjectInfo (State state) userProject =
    RunGettingUserCucumberProjectInfo <| State { runOptions = state.runOptions, userProject = userProject }


toRunGettingModuleDir : State { a | runGettingModuleDir : Allowed } { runOptions : RunOptions, userProject : Elm.Project.Project } -> Elm.Project.Project -> Model
toRunGettingModuleDir (State state) userCucumberProject =
    RunGettingModuleDir <| State { runOptions = state.runOptions, userProject = state.userProject, userCucumberProject = userCucumberProject }


toRunGettingModulePackageInfo : State { a | runGettingModulePackageInfo : Allowed } { runOptions : RunOptions, userProject : Elm.Project.Project, userCucumberProject : Elm.Project.Project } -> Model
toRunGettingModulePackageInfo (State state) =
    RunGettingModulePackageInfo <| State state


toRunUpdatingUserCucumberElmJson : State { a | runUpdatingUserCucumberElmJson : Allowed } { b | runOptions : RunOptions } -> Model
toRunUpdatingUserCucumberElmJson (State state) =
    RunUpdatingUserCucumberElmJson <| State { runOptions = state.runOptions }


toRunGettingTypes : State { a | runGettingTypes : Allowed } { runOptions : RunOptions } -> Model
toRunGettingTypes (State state) =
    RunGettingTypes <| State { runOptions = state.runOptions }


toRunCompilingRunner : State { a | runCompilingRunner : Allowed } { runOptions : RunOptions } -> Model
toRunCompilingRunner (State state) =
    RunCompilingRunner <| State <| state


toRunStartingRunner : State { a | runStartingRunner : Allowed } { runOptions : RunOptions } -> Model
toRunStartingRunner (State state) =
    RunStartingRunner <| State state


toRunResolvingGherkinFiles : State { a | runResolvingGherkinFiles : Allowed } { runOptions : RunOptions } -> Model
toRunResolvingGherkinFiles (State state) =
    RunResolvingGherkinFiles <| State state


toRunTestingGherkinFiles : State { a | runTestingGherkinFiles : Allowed } { runOptions : RunOptions } -> List String -> Model
toRunTestingGherkinFiles (State state) gherkinFiles =
    RunTestingGherkinFiles <|
        State
            { runOptions = state.runOptions
            , remainingGherkinFiles = gherkinFiles
            , testedGherkinFiles = []
            }


toRunWatching : State { a | runWatching : Allowed } { b | runOptions : RunOptions } -> List String -> Model
toRunWatching (State state) gherkinFiles =
    RunWatching <| State { runOptions = state.runOptions }
