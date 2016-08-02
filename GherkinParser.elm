module GherkinParser exposing (..)

import Combine exposing (..)
import Combine.Infix exposing (..)
import String
import Gherkin exposing (..)


-- import Combine.Char exposing (..)
-- import Combine.Num


{-| Some observations: the pattern \s includes \n
-}
type alias Ctx =
    List Int


lookahead : Parser res -> Parser res
lookahead lookaheadParser =
    let
        primitiveArg =
            app lookaheadParser
    in
        primitive primitiveArg


dropWhile : (a -> Bool) -> List a -> List a
dropWhile p xs =
    case xs of
        [] ->
            []

        x :: xs' ->
            if p x then
                dropWhile p xs'
            else
                xs


comment : Parser String
comment =
    regex "#.*"
        <* newline


spaces : Parser String
spaces =
    regex "[^\\r\\n\\S]+"


newline : Parser String
newline =
    regex "(\\r\\n|\\r|\\n)"


detailText : Parser String
detailText =
    regex "[^#\\r\\n]+"
        <* optional "" spaces
        <* optional "" comment


asA : Parser AsA
asA =
    string "As a"
        *> spaces
        *> (AsA <$> detailText)
        <* optional "" spaces
        <* (comment <|> newline)


inOrderTo : Parser InOrderTo
inOrderTo =
    string "In order to"
        *> spaces
        *> (InOrderTo <$> detailText)
        <* optional "" spaces
        <* (comment <|> newline)


iWantTo : Parser IWantTo
iWantTo =
    string "I want to"
        *> spaces
        *> (IWantTo <$> detailText)
        <* optional "" spaces
        <* (comment <|> newline)


docStringQuotes : Parser String
docStringQuotes =
    string "\"\"\""


docString : Parser StepArg
docString =
    optional "" newline
        *> docStringQuotes
        *> (DocString <$> regex "(([^\"]|\"(?!\"\")))*")
        <* docStringQuotes


{-| This is saying, optional whitespace *> pipe character <* optional whitespace,
where whitespace here excludes newlines
-}
dataTableCellDelimiter : Parser String
dataTableCellDelimiter =
    regex "[^\\r\\n\\S|]*\\|[^\\r\\n\\S|]*"


{-| This is saying, any text bookended by non-pipe, non-whitespace characters
-}
dataTableCellContent : Parser String
dataTableCellContent =
    regex "[^|\\s]([^|\\r\\n]*[^|\\s])?"


dataTableRow : Parser (List String)
dataTableRow =
    dataTableCellDelimiter
        *> sepBy dataTableCellDelimiter dataTableCellContent
        <* dataTableCellDelimiter


dataTableRows : Parser (List (List String))
dataTableRows =
    sepBy1 newline dataTableRow


dataTable : Parser StepArg
dataTable =
    DataTable <$> dataTableRows


noArg : Parser StepArg
noArg =
    NoArg <$ succeed ()


step : Parser Step
step =
    choice
        [ (Given <$ string "Given")
        , (When <$ string "When")
        , (Then <$ string "Then")
        , (And <$ string "And")
        , (But <$ string "But")
        ]
        <* spaces
        <*> detailText
        <* optional "" (comment <|> newline)
        <*> (docString <|> dataTable <|> noArg)


scenario : Parser Scenario
scenario =
    Scenario
        <$> (string "Scenario:"
                *> spaces
                *> detailText
                <* (comment <|> newline)
            )
        <* spaces
        <*> (sepBy1 (newline *> spaces) step)


background : Parser Background
background =
    string "Background: "
        *> optional "" spaces
        *> newline
        *> (Background <$> many1 step)


noBackground : Parser Background
noBackground =
    NoBackground <$ succeed ()


feature : Parser Feature
feature =
    Feature
        <$> detailText
        <*> asA
        <*> inOrderTo
        <*> iWantTo
        <*> (background <|> noBackground)
        <*> (sepBy1 newline scenario)


formatError : String -> List String -> Context -> String
formatError input ms cx =
    let
        lines =
            String.lines input

        lineCount =
            List.length lines

        ( line, lineNumber, lineOffset, _ ) =
            List.foldl
                (\line ( line', n, o, pos ) ->
                    if pos < 0 then
                        ( line', n, o, pos )
                    else
                        ( line, n + 1, pos, pos - 1 - String.length line' )
                )
                ( "", 0, 0, cx.position )
                lines

        separator =
            "|> "

        expectationSeparator =
            "\n  * "

        lineNumberOffset =
            floor (logBase 10 lineNumber) + 1

        separatorOffset =
            String.length separator

        padding =
            lineNumberOffset + separatorOffset + lineOffset + 1
    in
        "Parse error around line:\n\n"
            ++ (toString lineNumber)
            ++ separator
            ++ line
            ++ "\n"
            ++ String.padLeft padding ' ' "^"
            ++ "\nI expected one of the following:\n"
            ++ expectationSeparator
            ++ String.join expectationSeparator ms



-- format : Result
-- format result =
--     case result of
--         ( Ok es, _ ) ->
--             Ok es
--
--         ( Err ms, cx ) ->
--             Err <| formatError s ms cx
-- parse : String -> Result String (List C)
-- parse s =
--     case Combine.parse program (s ++ "\n") of
--         ( Ok es, _ ) ->
--             Ok es
--
--         ( Err ms, cx ) ->
--             Err <| formatError s ms cx
