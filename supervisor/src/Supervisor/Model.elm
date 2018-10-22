module Supervisor.Model exposing (Model(..), elmiModuleListDecoder, toInitCopyingTemplate, toInitGettingCurrentDirListing, toInitGettingModuleDir, toInitStart, toRunCompilingRunner, toRunGettingCurrentDirListing, toRunGettingModuleDir, toRunGettingModulePackageInfo, toRunGettingTypes, toRunGettingUserCucumberPackageInfo, toRunGettingUserPackageInfo, toRunResolvingGherkinFiles, toRunStart, toRunStartingRunner, toRunTestingGherkinFiles, toRunUpdatingUserCucumberElmJson, toRunWatching)

import Dict
import Elm.Project exposing (..)
import Json.Decode as D
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
    | RunGettingUserPackageInfo (State { runGettingUserCucumberPackageInfo : Allowed } { runOptions : RunOptions })
    | RunGettingUserCucumberPackageInfo (State { runGettingModuleDir : Allowed } { runOptions : RunOptions, userProject : Project })
    | RunGettingModuleDir (State { runGettingModulePackageInfo : Allowed } { runOptions : RunOptions, userProject : Project, userCucumberProject : Project })
    | RunGettingModulePackageInfo (State { runUpdatingUserCucumberElmJson : Allowed } { runOptions : RunOptions, userProject : Project, userCucumberProject : Project })
    | RunUpdatingUserCucumberElmJson (State { runGettingTypes : Allowed } { runOptions : RunOptions })
    | RunGettingTypes (State { runCompilingRunner : Allowed } { runOptions : RunOptions })
    | RunCompilingRunner (State { runStartingRunner : Allowed } { runOptions : RunOptions })
    | RunStartingRunner (State { runResolvingGherkinFiles : Allowed } { runOptions : RunOptions })
    | RunResolvingGherkinFiles (State { runTestingGherkinFiles : Allowed } { runOptions : RunOptions })
    | RunTestingGherkinFiles (State { runWatching : Allowed } { runOptions : RunOptions, remainingGherkinFiles : List String, testedGherkinFiles : List String })
    | RunWatching (State { runResolvingGherkinFiles : Allowed, runCompilingRunner : Allowed } { runOptions : RunOptions })



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


toRunGettingCurrentDirListing : State { a | runGettingCurrentDirListing : Allowed } { runOptions : RunOptions } -> Model
toRunGettingCurrentDirListing (State state) =
    RunGettingCurrentDirListing <| State state


toRunGettingUserPackageInfo : State { a | runGettingUserPackageInfo : Allowed } { runOptions : RunOptions } -> Model
toRunGettingUserPackageInfo (State state) =
    RunGettingUserPackageInfo <| State state


toRunGettingUserCucumberPackageInfo : State { a | runGettingUserCucumberPackageInfo : Allowed } { runOptions : RunOptions } -> Project -> Model
toRunGettingUserCucumberPackageInfo (State state) userProject =
    RunGettingUserCucumberPackageInfo <| State { runOptions = state.runOptions, userProject = userProject }


toRunGettingModuleDir : State { a | runGettingModuleDir : Allowed } { runOptions : RunOptions, userProject : Project } -> Project -> Model
toRunGettingModuleDir (State state) userCucumberProject =
    RunGettingModuleDir <| State { runOptions = state.runOptions, userProject = state.userProject, userCucumberProject = userCucumberProject }


toRunGettingModulePackageInfo : State { a | runGettingModulePackageInfo : Allowed } { runOptions : RunOptions, userProject : Project, userCucumberProject : Project } -> Model
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


{-
   Decodes the output of elmi-to-json into a list of tuples of module name and list of names of methods for the module that implement Stepdefs
-}


elmiModuleListDecoder : D.Decoder (List ( String, List String ))
elmiModuleListDecoder =
    D.list <|
        D.map2 Tuple.pair
            (D.field "moduleName" D.string)
            (D.field "interface" <|
                D.field "types" <|
                    D.map
                        (List.filterMap
                            (\( typeName, argTypeList ) ->
                                argTypeList
                                    |> List.reverse
                                    |> List.head
                                    |> Maybe.andThen
                                        (\( moduleName, name ) ->
                                            case ( moduleName, name ) of
                                                ( "Cucumber.StepDefs", "StepDefFunctionResult" ) ->
                                                    Just typeName

                                                _ ->
                                                    Nothing
                                        )
                            )
                        )
                    <|
                        D.keyValuePairs <|
                            D.field "annotation" <|
                                D.field "lambda" <|
                                    D.list <|
                                        D.map2 Tuple.pair
                                            (D.field "moduleName" <| D.field "module" D.string)
                                            (D.field "name" D.string)
            )
