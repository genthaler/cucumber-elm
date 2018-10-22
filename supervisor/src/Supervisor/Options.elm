module Supervisor.Options exposing (CliOptions(..), ReportFormat(..), RunOptions, config)

import Cli.Option as Option
import Cli.OptionsParser as OptionsParser exposing (with)
import Cli.Program as Program
import Json.Decode exposing (..)


type CliOptions
    = Init
    | RunTests RunOptions


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


version : String
version ="1.2.3"


config : Program.Config CliOptions
config =
    Program.config { version = version }
        |> Program.add
            (OptionsParser.buildSubCommand "init" Init
                |> OptionsParser.end
            )
        |> Program.add
            (OptionsParser.build RunOptions
                |> with
                    (Option.optionalKeywordArg "glue-arguments-function"
                        |> Option.validateMapIfPresent Ok
                    )
                |> with
                    (Option.optionalKeywordArg "tags"
                        |> Option.validateMapIfPresent Ok
                    )
                |> with (Option.optionalKeywordArg "compiler")
                |> with (Option.optionalKeywordArg "add-dependencies")
                |> with (Option.flag "watch")
                |> with
                    (Option.optionalKeywordArg "report"
                        |> Option.withDefault "console"
                        |> Option.oneOf Console
                            [ ( "json", Json )
                            , ( "junit", Junit )
                            , ( "console", Console )
                            ]
                    )
                |> OptionsParser.withRestArgs (Option.restArgs "TESTFILES")
                |> OptionsParser.map RunTests
            )
