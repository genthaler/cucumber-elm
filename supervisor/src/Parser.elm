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
                        Nothing ->
                            []

                        Just nextValue ->
                            [ State rest (value nextValue) ]


customList : (String -> Maybe a) -> Parser (List a -> b) b
customList stringToSomething =
    Parser <|
        \{ unvisited, value } ->
            let
                accum (( unvisited1, accumulated ) as arg) =
                    case unvisited1 of
                        [] ->
                            arg

                        next :: rest ->
                            case stringToSomething next of
                        Nothing ->
                                    arg

                                Just nextValue ->
                                    accum ( rest, nextValue :: accumulated )

                ( newUnvisited, found ) =
                    accum ( unvisited, [] )
            in
                [ State newUnvisited (value found) ]


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
                (\state ->
                    (parseAfter state)
                        |> List.map (mapStateValue (always state.value))
                )
            >> List.concat
infixl 7 |.


(<$>) : a -> Parser a b -> Parser (b -> c) c
(<$>) subValue (Parser parse) =
    Parser <|
        \state ->
            List.map (mapStateValue state.value) <|
                parse <|
                    (mapStateValue (always subValue) state)
infixr 6 <$>


mapStateValue : (a -> b) -> State a -> State b
mapStateValue f state =
    { state | value = f state.value }


oneOf : List (Parser a b) -> Parser a b
oneOf parsers =
    Parser <|
        \state ->
            List.concatMap (\(Parser parser) -> parser state) parsers


-- manyOf : Parser (a -> b) b -> Parser (List a -> b) b
-- manyOf (Parser parser) =
--     Parser <|
--         \state1 ->
--             let
--                 do : ( List String, List b ) -> List ( List String, List b )
--                 do ( unvisited, accumulated ) =
--                     case parser <| State unvisited state1.value of
--                         [] ->
--                             []

--                         list ->
--                             list
--                                 |> List.map (\state2 -> do ( state2.unvisited, accumulated ++ [ [ state2.value ] ] ))
--                                 |> List.concat
--             in
--                 do ( state1.unvisited, [] ) |> List.concat |> List.map (\( unvisitedFinal, accumulatedFinal ) -> State unvisitedFinal (state1.value accumulatedFinal))



-- manyOfInt : Parser (List Int -> a) a
-- manyOfInt =
--     Parser <|
--         \state1 ->
--             let
--                 (Parser intParser) =
--                     int
--                 do : ( List String, List b ) -> List ( List String, List b )
--                 do ( unvisited, accumulated ) =
--                     case intParser <| State unvisited state1.value of
--                         [] ->
--                             []
--                         list ->
--                             list
--                                 |> List.map (\state2 -> do ( state2.unvisited, state2.value::accumulated ))
--                                 |> List.concat
--             in
--                 do ( state1.unvisited, [] ) |> List.map (\( unvisitedFinal, accumulatedFinal ) -> State unvisitedFinal (state1.value accumulatedFinal))
-- manyOfInt : Parser (List -> a) a
-- manyOfInt =
--     manyOf int


foo : Parser (List Int -> a) a
foo =
    (\a -> a :: []) <$> int


bar : Parser (Int -> Int -> a) a
bar =
    int |= int


start : Parser a a
start =
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
