module GherkinParser exposing (..)

import Combine exposing (..)
import Combine.Infix exposing (..)
import String
import Gherkin exposing (..)


-- lookahead : Parser res -> Parser res
-- lookahead lookaheadParser =
--     let
--         primitiveArg =
--             app lookaheadParser
--     in
--         primitive primitiveArg


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


interspace : Parser (List String)
interspace =
    newline <|> spaces <|> comment |> many


detailText : Parser String
detailText =
    regex "[^#\\r\\n]+"
        <* optional "" comment


asA : Parser AsA
asA =
    string "As a"
        *> spaces
        *> (AsA <$> detailText)


tag : Parser Tag
tag =
    string "@" *> detailText


tags : Parser (List Tag)
tags =
    sepBy interspace tag


inOrderTo : Parser InOrderTo
inOrderTo =
    string "In order to"
        *> spaces
        *> (InOrderTo <$> detailText)


iWantTo : Parser IWantTo
iWantTo =
    string "I want to"
        *> spaces
        *> (IWantTo <$> detailText)


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
tableCellDelimiter : Parser String
tableCellDelimiter =
    regex "[^\\r\\n\\S|]*\\|[^\\r\\n\\S|]*"


{-| This is saying, any text bookended by non-pipe, non-whitespace characters
-}
tableCellContent : Parser String
tableCellContent =
    regex "[^|\\s]([^|\\r\\n]*[^|\\s])?"


tableRow : Parser (List String)
tableRow =
    tableCellDelimiter
        *> sepBy tableCellDelimiter tableCellContent
        <* tableCellDelimiter


tableRows : Parser (List (List String))
tableRows =
    sepBy1 newline tableRow


table : Parser Table
table =
    tableRows


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
        <*> (detailText <* interspace)
        <*> (docString <|> (DataTable <$> table) <|> noArg)


examples : Parser Examples
examples =
    Examples
        <$> (tags <* interspace)
        <*> (string "Examples:" *> interspace *> table)


scenario : Parser Scenario
scenario =
    Scenario
        <$> (tags <* interspace)
        <*> (string "Scenario:" *> spaces *> detailText <* interspace)
        <*> sepBy1 interspace step


scenarioOutline : Parser Scenario
scenarioOutline =
    ScenarioOutline
        <$> (tags <* interspace)
        <*> (string "Scenario Outline:" *> spaces *> detailText <* interspace)
        <*> ((sepBy1 interspace step) <* interspace)
        <*> sepBy1 interspace examples


background : Parser Background'
background =
    Background
        <$> (string "Background:"
                *> spaces
                *> (optional "" detailText)
                <* interspace
            )
        <*> sepBy1 interspace step


noBackground : Parser Background'
noBackground =
    NoBackground <$ succeed ()


feature : Parser Feature
feature =
    Feature
        <$> (tags <* interspace)
        <*> (string "Feature:"
                *> (optional "" spaces)
                *> detailText
                <* interspace
            )
        <*> (asA <* interspace)
        <*> (inOrderTo <* interspace)
        <*> (iWantTo <* interspace)
        <*> (background <|> noBackground <* interspace)
        <*> sepBy1 interspace (scenario <|> scenarioOutline)


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


parse : Parser res -> String -> Result String res
parse parser s =
    case Combine.parse parser (s ++ "\n") of
        ( Ok es, _ ) ->
            Ok es

        ( Err ms, cx ) ->
            Err <| formatError s ms cx
