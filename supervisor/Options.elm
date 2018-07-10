module Options exposing (Option(..), RunOptions, parseArgs)


type alias RunOptions =
    { feature : String, glueArgumentsFunction : String }


type Option
    = Help
    | Init
    | Version
    | Run RunOptions


parseArgs : List String -> Option
parseArgs =
    parse optionParser >> Maybe.withDefault Help


initParser : Parser (Option -> c) c
initParser =
    Init <$> (s "--init")


helpParser : Parser (Option -> c) c
helpParser =
    Help <$> (s "--help")


versionParser : Parser (Option -> c) c
versionParser =
    Help <$> (s "--version")


runParser : Parser (Option -> c) c
runParser =
    Run <$> RunOptions <$> string <*> (s "--glue-arguments-function") <*> string


optionParser : Parser (Option -> c) c
optionParser =
    oneOf
        [ initParser
        , helpParser
        , versionParser
        , runParser
        ]
        <*> end


type Parser source value
    = Parser (State source -> List (State value))


type alias State value =
    { visited : List String
    , unvisited : List String
    , value : value
    }


string : Parser (String -> a) a
string =
    custom "STRING" Ok


int : Parser (Int -> a) a
int =
    custom "NUMBER" String.toInt


s : String -> Parser a a
s str =
    Parser <|
        \{ visited, unvisited, value } ->
            case unvisited of
                [] ->
                    []

                next :: rest ->
                    if next == str then
                        [ State (next :: visited) rest value ]
                    else
                        []


custom : String -> (String -> Result String a) -> Parser (a -> b) b
custom tipe stringToSomething =
    Parser <|
        \{ visited, unvisited, value } ->
            case unvisited of
                [] ->
                    []

                next :: rest ->
                    case stringToSomething next of
                        Ok nextValue ->
                            [ State (next :: visited) rest (value nextValue) ]

                        Err msg ->
                            []


(<*>) : Parser a b -> Parser b c -> Parser a c
(<*>) (Parser parseBefore) (Parser parseAfter) =
    Parser <|
        List.concatMap parseAfter
            << parseBefore
infixr 7 <*>


(<$>) : a -> Parser a b -> Parser (b -> c) c
(<$>) subValue (Parser parse) =
    Parser <|
        \({ value } as state) ->
            List.map (mapHelp value) <|
                parse <|
                    { state | value = subValue }
infixr 6 <$>


mapHelp : (a -> b) -> State a -> State b
mapHelp func ({ value } as state) =
    { state | value = func value }


oneOf : List (Parser a b) -> Parser a b
oneOf parsers =
    Parser <|
        \state ->
            List.concatMap (\(Parser parser) -> parser state) parsers


empty : Parser a a
empty =
    Parser <| List.singleton


end : Parser a a
end =
    Parser <|
        \state ->
            if List.isEmpty state.unvisited then
                [ state ]
            else
                []


parse : Parser (a -> a) a -> List String -> Maybe a
parse (Parser parser) args =
    parseHelp <|
        parser <|
            { visited = []
            , unvisited = args
            , value = identity
            }


parseHelp : List (State a) -> Maybe a
parseHelp states =
    case states of
        [] ->
            Nothing

        state :: rest ->
            case state.unvisited of
                [] ->
                    Just state.value

                [ "" ] ->
                    Just state.value

                _ ->
                    parseHelp rest
