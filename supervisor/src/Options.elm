module Options exposing (Option(..), RunOptions, parseArgs)

import Parser exposing (..)


type alias RunOptions =
    { feature : String, glueArgumentsFunction : String }


type Option
    = Help
    | Version
    | Init String
    | Run RunOptions


parseArgs : List String -> Option
parseArgs =
    parse optionParser >> Maybe.withDefault Help


initParser : Parser (Option -> c) c
initParser =
    Init
        <$> empty
        |. (s "--init")
        |= string


helpParser : Parser (Option -> c) c
helpParser =
    Help
        <$> (empty
                |. (s "--help")
            )


versionParser : Parser (Option -> c) c
versionParser =
    Version
        <$> empty
        |. (s "--version")


runParser : Parser (Option -> c) c
runParser =
    Run
        <$> RunOptions
        <$> empty
        |= string
        |. (s "--glue-arguments-function")
        |= string


optionParser : Parser (Option -> c) c
optionParser =
    oneOf
        [ initParser
        , helpParser
        , versionParser
        , runParser
        ]
        |. end
