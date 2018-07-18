module Options exposing (Option(..), RunOptions, parseArgs)

import Parser exposing (..)


type alias RunOptions =
    { feature : String, glueArgumentsFunction : String }


type Option
    = Help
    | Version
    | Init String
    | Run RunOptions


initParser : Parser (Option -> c) c
initParser =
    Init
        <$> empty
        |. string
        |. string
        |. (s "--init")
        |= string


helpParser : Parser (Option -> c) c
helpParser =
    always Help
        <$> empty
        |. string
        |. string
        |= s "--help"


versionParser : Parser (Option -> c) c
versionParser =
    always Version
        <$> empty
        |. string
        |. string
        |= s "--version"


runParser : Parser (Option -> c) c
runParser =
    Run
        <$> RunOptions
        <$> empty
        |. string
        |. string
        |= string
        |. (s "--glue-arguments-function")
        |= string


optionParser : Parser (Option -> c) c
optionParser =
    empty
        |= oneOf
            [ initParser
            , helpParser
            , versionParser
            , runParser
            ]


parseArgs : List String -> Maybe Option
parseArgs =
    parse optionParser
