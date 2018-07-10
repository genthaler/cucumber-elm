module Options exposing (Option, optionParser)

import Help
import PackageInfo.Version exposing (Version)
import Dict exposing (Dict)


type Option
    = Help
    | Init
    | Version
    | Run { feature : Maybe String, glueArgumentsFunction : String }


initParser : Parser s Option
initParser =
    map Init (s "--init")


helpParser : Parser s Option
helpParser =
    map Help (s "--help")


versionParser : Parser s Option
versionParser =
    map Help (s "--version")


runParser : Parser s Option
runParser =
    map Run (s "--glue-arguments-function")


optionParser : Parser s Option
optionParser =
    oneOf
        [ initParser
        , versionParser
        , runParser
        ]



-- PARSERS


{-| Turn URLs like `/blog/42/cat-herding-techniques` into nice Elm data.
-}
type Parser a b
    = Parser (State a -> List (State b))


type alias State value =
    { visited : List String
    , unvisited : List String
    , params : Dict String String
    , value : value
    }



-- PARSE SEGMENTS


{-| Parse a segment of the path as a `String`.

    parsePath string location
    -- /alice/  ==>  Just "alice"
    -- /bob     ==>  Just "bob"
    -- /42/     ==>  Just "42"
-}
string : Parser (String -> a) a
string =
    custom "STRING" Ok


{-| Parse a segment of the path as an `Int`.

    parsePath int location
    -- /alice/  ==>  Nothing
    -- /bob     ==>  Nothing
    -- /42/     ==>  Just 42
-}
int : Parser (Int -> a) a
int =
    custom "NUMBER" String.toInt


{-| Parse a segment of the path if it matches a given string.

    s "blog"  -- can parse /blog/
              -- but not /glob/ or /42/ or anything else
-}
s : String -> Parser a a
s str =
    Parser <|
        \{ visited, unvisited, params, value } ->
            case unvisited of
                [] ->
                    []

                next :: rest ->
                    if next == str then
                        [ State (next :: visited) rest params value ]
                    else
                        []


{-| Create a custom path segment parser. Here is how it is used to define the
`int` and `string` parsers:

    int =
      custom "NUMBER" String.toInt

    string =
      custom "STRING" Ok

You can use it to define something like “only CSS files” like this:

    css : Parser (String -> a) a
    css =
      custom "CSS_FILE" <| \segment ->
        if String.endsWith ".css" then
          Ok segment
        else
          Err "Does not end with .css"
-}
custom : String -> (String -> Result String a) -> Parser (a -> b) b
custom tipe stringToSomething =
    Parser <|
        \{ visited, unvisited, params, value } ->
            case unvisited of
                [] ->
                    []

                next :: rest ->
                    case stringToSomething next of
                        Ok nextValue ->
                            [ State (next :: visited) rest params (value nextValue) ]

                        Err msg ->
                            []



-- COMBINING PARSERS


{-| Parse a path with multiple segments.

    parsePath (s "blog" </> int) location
    -- /blog/35/  ==>  Just 35
    -- /blog/42   ==>  Just 42
    -- /blog/     ==>  Nothing
    -- /42/       ==>  Nothing

    parsePath (s "search" </> string) location
    -- /search/cats/  ==>  Just "cats"
    -- /search/frog   ==>  Just "frog"
    -- /search/       ==>  Nothing
    -- /cats/         ==>  Nothing
-}
(</>) : Parser a b -> Parser b c -> Parser a c
(</>) (Parser parseBefore) (Parser parseAfter) =
    Parser <|
        \state ->
            List.concatMap parseAfter (parseBefore state)
infixr 7 </>


{-| Transform a path parser.

    type alias Comment = { author : String, id : Int }

    rawComment : Parser (String -> Int -> a) a
    rawComment =
      s "user" </> string </> s "comments" </> int

    comment : Parser (Comment -> a) a
    comment =
      map Comment rawComment

    parsePath comment location
    -- /user/bob/comments/42  ==>  Just { author = "bob", id = 42 }
    -- /user/tom/comments/35  ==>  Just { author = "tom", id = 35 }
    -- /user/sam/             ==>  Nothing
-}
map : a -> Parser a b -> Parser (b -> c) c
map subValue (Parser parse) =
    Parser <|
        \{ visited, unvisited, params, value } ->
            List.map (mapHelp value) <|
                parse <|
                    { visited = visited
                    , unvisited = unvisited
                    , params = params
                    , value = subValue
                    }


mapHelp : (a -> b) -> State a -> State b
mapHelp func { visited, unvisited, params, value } =
    { visited = visited
    , unvisited = unvisited
    , params = params
    , value = func value
    }


oneOf : List (Parser a b) -> Parser a b
oneOf parsers =
    Parser <|
        \state ->
            List.concatMap (\(Parser parser) -> parser state) parsers


empty : Parser a a
empty =
    Parser <| \state -> [ state ]



-- QUERY PARAMETERS


{-| Turn query parameters like `?name=tom&age=42` into nice Elm data.
-}
type QueryParser a b
    = QueryParser (State a -> List (State b))


{-| Parse some query parameters.

    type Route = BlogList (Maybe String) | BlogPost Int

    route : Parser (Route -> a) a
    route =
      oneOf
        [ map BlogList (s "blog" <?> stringParam "search")
        , map BlogPost (s "blog" </> int)
        ]

    parsePath route location
    -- /blog/              ==>  Just (BlogList Nothing)
    -- /blog/?search=cats  ==>  Just (BlogList (Just "cats"))
    -- /blog/42            ==>  Just (BlogPost 42)
-}
(<?>) : Parser a b -> QueryParser b c -> Parser a c
(<?>) (Parser parser) (QueryParser queryParser) =
    Parser <|
        \state ->
            List.concatMap queryParser (parser state)
infixl 8 <?>


{-| Parse a query parameter as a `String`.

    parsePath (s "blog" <?> stringParam "search") location
    -- /blog/              ==>  Just (Overview Nothing)
    -- /blog/?search=cats  ==>  Just (Overview (Just "cats"))
-}
stringParam : String -> QueryParser (Maybe String -> a) a
stringParam name =
    customParam name identity


{-| Parse a query parameter as an `Int`. Maybe you want to show paginated
search results. You could have a `start` query parameter to say which result
should appear first.

    parsePath (s "results" <?> intParam "start") location
    -- /results           ==>  Just Nothing
    -- /results?start=10  ==>  Just (Just 10)
-}
intParam : String -> QueryParser (Maybe Int -> a) a
intParam name =
    customParam name intParamHelp


intParamHelp : Maybe String -> Maybe Int
intParamHelp maybeValue =
    case maybeValue of
        Nothing ->
            Nothing

        Just value ->
            Result.toMaybe (String.toInt value)


{-| Create a custom query parser. You could create parsers like these:

    jsonParam : String -> Decoder a -> QueryParser (Maybe a -> b) b
    enumParam : String -> Dict String a -> QueryParser (Maybe a -> b) b

It may be worthwhile to have these in this library directly. If you need
either one in practice, please open an issue [here][] describing your exact
scenario. We can use that data to decide if they should be added.

[here]: https://github.com/evancz/url-parser/issues
-}
customParam : String -> (Maybe String -> a) -> QueryParser (a -> b) b
customParam key func =
    QueryParser <|
        \{ visited, unvisited, params, value } ->
            [ State visited unvisited params (value (func (Dict.get key params))) ]



-- PARSER HELPERS


parse : Parser (a -> a) a -> String -> Dict String String -> Maybe a
parse (Parser parser) url params =
    parseHelp <|
        parser <|
            { visited = []
            , unvisited = splitUrl url
            , params = params
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


parsePath : Parser (a -> a) a -> Navigation.Location -> Maybe a
parsePath parser location =
    parse parser location.pathname (parseParams location.search)
