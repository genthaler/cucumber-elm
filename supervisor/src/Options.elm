module Options exposing (Option(..), RunOptions, parseArgs)

import Parser exposing (..)


type alias RunOptions =
    { feature : String, glueArgumentsFunction : String, tags : String }


type Option
    = Help
    | Version
    | Init String
    | Run RunOptions


initParser : Parser (Option -> c) c
initParser =
    Init
        <$> start
        |. string
        |. string
        |. (s "--init")
        |= string


helpParser : Parser (Option -> c) c
helpParser =
    always Help
        <$> start
        |. string
        |. string
        |= s "--help"


versionParser : Parser (Option -> c) c
versionParser =
    always Version
        <$> start
        |. string
        |. string
        |= s "--version"


runParser : Parser (Option -> c) c
runParser =
    Run
        <$> RunOptions
        <$> start
        |. string
        |. string
        |= string
        |. (s "--glue-arguments-function")
        |= string
        |. (s "--tags")
        |= string


optionParser : Parser (Option -> c) c
optionParser =
    start
        |= oneOf
            [ initParser
            , helpParser
            , versionParser
            , runParser
            ]


parseArgs : List String -> Maybe Option
parseArgs =
    parse optionParser
