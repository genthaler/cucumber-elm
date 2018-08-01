module Options exposing (Mode(..), RunOption(..), parseArgs)

import Parser exposing (..)


type RunOption
    = GlueFunctionsOption
    | TagsOption (List String)
    | WatchOption
    | DefaultOption String


type Mode
    = Help
    | Version
    | Init String
    | Run (List RunOption)


initParser : Parser (Mode -> c) c
initParser =
    Init
        <$> start
        |. (s "--init")
        |= string
        |. end


helpParser : Parser (Mode -> c) c
helpParser =
    always Help
        <$> start
        |= s "--help"


versionParser : Parser (Mode -> c) c
versionParser =
    always Version
        <$> s "--version"


runParser : Parser (Mode -> c) c
runParser =
    Run
        <$> RunOptions
        <$> start
        |= string
        |. (s "--glue-arguments-function")
        |= string
        |. (s "--tags")
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
