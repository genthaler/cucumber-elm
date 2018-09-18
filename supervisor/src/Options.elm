module Options exposing (..)

import Cli.Option as Option
import Cli.OptionsParser as OptionsParser exposing (with)
import Cli.Program as Program
import Json.Decode exposing (..)
import Ports


type CliOptions
    = Init
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


programConfig : Program.Config CliOptions
programConfig =
    Program.config { version = "1.2.3" }
        |> Program.add
            (OptionsParser.buildSubCommand "init" Init
                |> OptionsParser.end
            )
        |> Program.add
            (OptionsParser.build RunTestsRecord
                |> with
                    (Option.optionalKeywordArg "glue-arguments-function"
                        |> Option.validateMapIfPresent String.toInt
                    )
                |> with
                    (Option.optionalKeywordArg "tags"
                        |> Option.validateMapIfPresent String.toInt
                    )
                |> with (Option.optionalKeywordArg "compiler")
                |> with (Option.optionalKeywordArg "add-dependencies")
                |> with (Option.flag "watch")
                |> with
                    (Option.optionalKeywordArg "report"
                        |> Option.withDefault "console"
                        |> Option.oneOf Console
                            [ ("json" , Json)
                            , ("junit" ,Junit)
                            , ("console" ,Console)
                            ]
                    )
                |> OptionsParser.withRestArgs (Option.restArgs "TESTFILES")
                |> OptionsParser.map RunTests
            )


dummy : Decoder String
dummy =
    -- this is a workaround for an Elm compiler bug
    Json.Decode.string


init : Flags -> CliOptions -> Cmd Never
init flags msg =
    (case msg of
        Init ->
            "Initializing test suite..."

        RunTests options ->
            [ "Running the following test files: " ++ toString options.testFiles |> Just
            , "watch: " ++ toString options.watch |> Just
            , options.maybeFuzz |> Maybe.map (\glueArgumentsFunction -> "glue-arguments-function: " ++ toString glueArgumentsFunction)
            , options.maybeSeed |> Maybe.map (\tags -> "tags: " ++ toString tags)
            , options.reportFormat |> toString |> Just
            , options.maybeCompilerPath |> Maybe.map (\compilerPath -> "compiler: " ++ toString compilerPath)
            , options.maybeDependencies |> Maybe.map (\dependencies -> "dependencies: " ++ toString dependencies)
            ]
                |> List.filterMap identity
                |> String.join "\n"
    )
        |> Ports.print


 

type alias Flags =
    Program.FlagsIncludingArgv {}
