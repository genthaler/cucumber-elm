module SupervisorOptions exposing (CliOptions(..), ReportFormat(..), RunTestsRecord, config)

import Cli.Option as Option
import Cli.OptionsParser as OptionsParser exposing (with)
import Cli.Program as Program
import Json.Decode exposing (..)
import Ports


type CliOptions
    = Init (Maybe String)
    | RunTests RunTestsRecord


type alias RunTestsRecord =
    { maybeFuzz : Maybe Int
    , maybeSeed : Maybe Int
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


config : Program.Config CliOptions
config =
    Program.config { version = "1.2.3" }
        |> Program.add
            (OptionsParser.buildSubCommand "init" Init
                |> OptionsParser.withOptionalPositionalArg
                    (Option.optionalPositionalArg "folder to initialise")
                |> OptionsParser.end
            )
        |> Program.add
            (OptionsParser.build RunTestsRecord
                |> with
                    (Option.optionalKeywordArg "glue-arguments-function"
                        |> Option.validateMapIfPresent (String.toInt >> maybeToResult)
                    )
                |> with
                    (Option.optionalKeywordArg "tags"
                        |> Option.validateMapIfPresent (String.toInt >> maybeToResult)
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


maybeToResult : Maybe value -> Result String value
maybeToResult maybe =
    case maybe of
        Just value ->
            Ok value

        Nothing ->
            Err "Could not convert."
