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


{-| Parse a comment; everything from a `#` symbol to the end of the line
-}
comment : Parser String
comment =
    regex "#.*"
        <* newline


{-| Parse any number of whitespace (except for newlines).
-}
spaces : Parser String
spaces =
    regex "[^\\r\\n\\S]+"


{-| Parse a newline
-}
newline : Parser String
newline =
    regex "(\\r\\n|\\r|\\n)"


{-| Parse any amount of space that might separate tokens, that isn't context
sensitive.
-}
interspace : Parser (List String)
interspace =
    newline <|> spaces <|> comment |> many


{-| Parse detail text, typically after a Gherkin keyword until the effective
end of line.
-}
detailText : Parser String
detailText =
    regex "[^#\\r\\n]+"
        <* optional "" comment


{-| Parse a tag.
-}
tag : Parser Tag
tag =
    string "@" *> detailText


{-| Parse `Tag`s on a line.
-}
andTags : Parser Tag
andTags =
    string "@" *> detailText


{-| Parse `Tag`s on separate lines.
-}
orTags : Parser Tag
orTags =
    string "@" *> detailText


{-| Parse a list of tag lines.
-}
tags : Parser (List Tag)
tags =
    sepBy interspace tag


{-| Parse an `As a` line.
-}
asA : Parser AsA
asA =
    string "As a"
        *> spaces
        *> (AsA <$> detailText)


{-| Parse an `In order to` line.
-}
inOrderTo : Parser InOrderTo
inOrderTo =
    string "In order to"
        *> spaces
        *> (InOrderTo <$> detailText)


{-| Parse an `I want to` line.
-}
iWantTo : Parser IWantTo
iWantTo =
    string "I want to"
        *> spaces
        *> (IWantTo <$> detailText)


{-| Parse a docstring quote token.
-}
docStringQuotes : Parser String
docStringQuotes =
    string "\"\"\""


{-| Parse a docstring step argument.
-}
docString : Parser StepArg
docString =
    optional "" newline
        *> docStringQuotes
        *> (DocString <$> regex "(([^\"]|\"(?!\"\")))*")
        <* docStringQuotes


{-| Parse a step argument table cell delimiter.

This is saying, optional whitespace *> pipe character <* optional whitespace,
where whitespace here excludes newlines
-}
tableCellDelimiter : Parser String
tableCellDelimiter =
    regex "[^\\r\\n\\S|]*\\|[^\\r\\n\\S|]*"


{-| Parse a step argument table cell content.

This is saying, any text bookended by non-pipe, non-whitespace characters
-}
tableCellContent : Parser String
tableCellContent =
    regex "[^|\\s]([^|\\r\\n]*[^|\\s])?"


{-| Parse a step argument table row.

This is saying, any text bookended by non-pipe, non-whitespace characters
-}
tableRow : Parser Row
tableRow =
    tableCellDelimiter
        *> sepBy tableCellDelimiter tableCellContent
        <* tableCellDelimiter


{-| Parse a step argument table rows.

This is saying, any text bookended by non-pipe, non-whitespace characters
-}
tableRows : Parser (List Row)
tableRows =
    sepBy1 newline tableRow


{-| Parse a step argument table.

This is saying, any text bookended by non-pipe, non-whitespace characters
-}
table : Parser Table
table =
    Table <$> tableRow <* newline <*> tableRows


{-| Parse an absent step argument.
-}
noArg : Parser StepArg
noArg =
    NoArg <$ succeed ()


{-| Parse a step.
-}
step : Parser Step
step =
    Step
        <$> choice
                [ (Given <$ string "Given")
                , (When <$ string "When")
                , (Then <$ string "Then")
                , (And <$ string "And")
                , (But <$ string "But")
                ]
        <* spaces
        <*> (detailText <* interspace)
        <*> (docString <|> (DataTable <$> table) <|> noArg)


{-| Parse a scenario outline example section.
-}
examples : Parser Examples
examples =
    Examples
        <$> (tags <* interspace)
        <*> (string "Examples:" *> interspace *> table)


{-| Parse a scenario.
-}
scenario : Parser Scenario
scenario =
    Scenario
        <$> (tags <* interspace)
        <*> (string "Scenario:" *> spaces *> detailText <* interspace)
        <*> sepBy1 interspace step


{-| Parse a scenario outline.
-}
scenarioOutline : Parser Scenario
scenarioOutline =
    ScenarioOutline
        <$> (tags <* interspace)
        <*> (string "Scenario Outline:" *> spaces *> detailText <* interspace)
        <*> ((sepBy1 interspace step) <* interspace)
        <*> sepBy1 interspace examples


{-| Parse a background section.
-}
background : Parser Background
background =
    Background
        <$> (string "Background:"
                *> spaces
                *> (optional "" detailText)
                <* interspace
            )
        <*> sepBy1 interspace step


{-| Parse an absent background section.
-}
noBackground : Parser Background
noBackground =
    NoBackground <$ succeed ()


{-| Parse an entire.
-}
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


{-| Nicely format a parsing error.
-}
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


{-| Parse using an arbitrary parser combinator.
-}
parse : Parser res -> String -> Result String res
parse parser s =
    case Combine.parse parser (s ++ "\n") of
        ( Ok es, _ ) ->
            Ok es

        ( Err ms, cx ) ->
            Err <| formatError s ms cx
