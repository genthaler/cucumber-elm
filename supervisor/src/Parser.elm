module Parser exposing (Parser, string, int, s, csv, (|=), (|.), (<$>), start, end, oneOf, parse)

{-| This module parses a list of strings.

@docs Parser, string, int, s, (|=), (<$>), start, end, oneOf, parse

-}

import Regex


type Parser source value
    = Parser (State source -> List (State value))


type alias State value =
    { unvisited : List String
    , value : value
    }


string : Parser (String -> a) a
string =
    custom Just


int : Parser (Int -> a) a
int =
    custom <| Result.toMaybe << String.toInt


matcher : a -> a -> Maybe a
matcher a b =
    if a == b then
        Just a
    else
        Nothing


s : String -> Parser (String -> a) a
s str =
    custom <| matcher str


csv : Parser (List String -> a) a
csv =
    custom <| Just << (Regex.split Regex.All (Regex.regex ",\\s*"))


custom : (String -> Maybe a) -> Parser (a -> b) b
custom stringToSomething =
    Parser <|
        \{ unvisited, value } ->
            case unvisited of
                [] ->
                    []

                next :: rest ->
                    case stringToSomething next of
                        Just nextValue ->
                            [ State rest (value nextValue) ]

                        Nothing ->
                            []


(|=) : Parser a b -> Parser b c -> Parser a c
(|=) (Parser parseBefore) (Parser parseAfter) =
    Parser <|
        parseBefore
            -- >> List.concatMap parseAfter
            >> List.map parseAfter
            >> List.concat
infixl 7 |=


(|.) : Parser a b -> Parser b c -> Parser a b
(|.) (Parser parseBefore) (Parser parseAfter) =
    Parser <|
        parseBefore
            >> List.map
                (\({ value } as state) ->
                    (parseAfter state)
                        |> List.map (mapStateValue (always value))
                )
            >> List.concat
infixl 7 |.


(<$>) : a -> Parser a b -> Parser (b -> c) c
(<$>) subValue (Parser parse) =
    Parser <|
        \({ value } as state) ->
            List.map (mapStateValue value) <|
                parse <|
                    (mapStateValue (always subValue) state)
infixr 6 <$>


mapStateValue : (a -> b) -> State a -> State b
mapStateValue func ({ value } as state) =
    { state | value = func value }


oneOf : List (Parser a b) -> Parser a b
oneOf parsers =
    Parser <|
        \state ->
            List.concatMap (\(Parser parser) -> parser state) parsers


start : Parser a a
start =
    Parser <| List.singleton


end : Parser a ()
end =
    Parser <|
        \state ->
            if List.isEmpty state.unvisited then
                [ mapStateValue (always ()) state ]
            else
                []


parse : Parser (a -> a) a -> List String -> Maybe a
parse (Parser parser) args =
    parseHelp <|
        parser <|
            { unvisited = args
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
