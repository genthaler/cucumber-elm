module Parser exposing (Parser, string, int, s, (<*>), (<$>), empty, end, oneOf, parse)


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
