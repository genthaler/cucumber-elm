module Options exposing (Mode(..), RunOptions, parseArgs)

import Parser exposing (..)


type alias RunOptions =
    { feature : String, glueArgumentsFunction : String, tags : String }


type Option
    = HelpOption
    | VersionOption
    | InitOption String
    | GlueFunctionsOption
    | TagsOption (List String)
    | WatchOption
    | DefaultOption String


type Mode
    = Help
    | Version
    | Init String
    | Run RunOptions


initParser : Parser (Mode -> c) c
initParser =
    Init
        <$> start
        |. string
        |. string
        |. (s "--init")
        |= string


helpParser : Parser (Mode -> c) c
helpParser =
    always Help
        <$> always HelpOption
        <$> start
        |= s "--help"


versionParser : Parser (Mode -> c) c
versionParser =
    always Version
        <$> start
        |. string
        |. string
        |= s "--version"


runParser : Parser (Mode -> c) c
runParser =
    Run
        <$> RunOptions
        <$> (start
                |. string
                |. string
            )
        |= (string
                |. (s "--glue-arguments-function")
           )
        |= (string
                |. (s "--tags")
           )
        |= string


foo : Parser (String -> Int -> a) (Int -> a)
foo =
    (s "--tags") |. int


optionParser : Parser (Mode -> c) c
optionParser =
    start
        |= oneOf
            [ initParser
            , helpParser
            , versionParser
            , runParser
            ]


parseArgs : List String -> Maybe Mode
parseArgs =
    parse optionParser
