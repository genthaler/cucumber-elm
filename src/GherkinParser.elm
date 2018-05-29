module GherkinParser exposing (feature, formatError)

import Combine exposing (..)
import String
import Gherkin exposing (..)


{-| Parse a comment; everything from a `#` symbol to the end of the line
-}
comment : Parser s String
comment =
    regex "#.*"
        <* newline


{-| Parse any number of whitespace (except for newlines).
-}
spaces : Parser s String
spaces =
    regex "[^\\r\\n\\S]+"


{-| Parse a newline
-}
newline : Parser s String
newline =
    regex "(\\r\\n|\\r|\\n)"


{-| Parse any amount of space that might separate tokens, that isn't context
sensitive.
-}
interspace : Parser s (List String)
interspace =
    newline <|> spaces <|> comment |> many


{-| Parse detail text, typically after a Gherkin keyword until the effective
end of line.
-}
detailText : Parser s String
detailText =
    regex "[^#\\r\\n]+"
        <* optional "" comment


{-| Parse a tag.
-}
tag : Parser s Tag
tag =
    Tag <$> (string "@" *> detailText)


{-| Parse a list of tag lines.
-}
tags : Parser s (List Tag)
tags =
    sepBy interspace tag


{-| Parse an `As a` line.
-}
asA : Parser s AsA
asA =
    string "As a"
        *> spaces
        *> (AsA <$> detailText)


{-| Parse an `In order to` line.
-}
inOrderTo : Parser s InOrderTo
inOrderTo =
    string "In order to"
        *> spaces
        *> (InOrderTo <$> detailText)


{-| Parse an `I want to` line.
-}
iWantTo : Parser s IWantTo
iWantTo =
    string "I want to"
        *> spaces
        *> (IWantTo <$> detailText)


{-| Parse a docstring quote token.
-}
docStringQuotes : Parser s String
docStringQuotes =
    string "\"\"\""


{-| Parse a docstring step argument.
-}
docString : Parser s StepArg
docString =
    optional "" newline
        *> docStringQuotes
        *> (DocString <$> regex "(([^\"]|\"(?!\"\")))*")
        <* docStringQuotes


{-| Parse a step argument table cell delimiter.

This is saying, optional whitespace *> pipe character <* optional whitespace,
where whitespace here excludes newlines

-}
tableCellDelimiter : Parser s String
tableCellDelimiter =
    regex "[^\\r\\n\\S|]*\\|[^\\r\\n\\S|]*"


{-| Parse a step argument table cell content.

This is saying, any text bookended by non-pipe, non-whitespace characters

-}
tableCellContent : Parser s String
tableCellContent =
    regex "[^|\\s]([^|\\r\\n]*[^|\\s])?"


{-| Parse a step argument table row.

This is saying, any text bookended by non-pipe, non-whitespace characters

-}
tableRow : Parser s Row
tableRow =
    tableCellDelimiter
        *> sepBy tableCellDelimiter tableCellContent
        <* tableCellDelimiter


{-| Parse a step argument table rows.

This is saying, any text bookended by non-pipe, non-whitespace characters

-}
tableRows : Parser s (List Row)
tableRows =
    sepBy1 newline tableRow


{-| Parse a step argument table.

This is saying, any text bookended by non-pipe, non-whitespace characters

-}
table : Parser s Table
table =
    Table <$> tableRow <* newline <*> tableRows


{-| Parse an absent step argument.
-}
noArg : Parser s StepArg
noArg =
    NoArg <$ succeed ()


{-| Parse a step.
-}
step : Parser s Step
step =
    Step
        <$> choice
                [ Given <$ string "Given"
                , When <$ string "When"
                , Then <$ string "Then"
                , And <$ string "And"
                , But <$ string "But"
                ]
        <* spaces
        <*> (detailText <* interspace)
        <*> (docString <|> (DataTable <$> table) <|> noArg)


{-| Parse a scenario outline example section.
-}
examples : Parser s Examples
examples =
    Examples
        <$> (tags <* interspace)
        <*> (string "Examples:" *> interspace *> table)


{-| Parse a scenario.
-}
scenario : Parser s Scenario
scenario =
    Scenario
        <$> (tags <* interspace)
        <*> (string "Scenario:" *> spaces *> detailText <* interspace)
        <*> sepBy1 interspace step


{-| Parse a scenario outline.
-}
scenarioOutline : Parser s Scenario
scenarioOutline =
    ScenarioOutline
        <$> (tags <* interspace)
        <*> (string "Scenario Outline:" *> spaces *> detailText <* interspace)
        <*> (sepBy1 interspace step <* interspace)
        <*> sepBy1 interspace examples


{-| Parse a background section.
-}
background : Parser s Background
background =
    Background
        <$> (string "Background:"
                *> spaces
                *> optional "" detailText
                <* interspace
            )
        <*> sepBy1 interspace step


{-| Parse an absent background section.
-}
noBackground : Parser s Background
noBackground =
    NoBackground <$ succeed ()


{-| Parse an entire.
-}
feature : Parser s Feature
feature =
    Feature
        <$> (tags <* interspace)
        <*> (string "Feature:"
                *> optional "" spaces
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
formatError : String -> List String -> ParseContext state res -> String
formatError input ms cx =
    let
        ( _, inputStream, _ ) =
            cx

        lines =
            String.lines input

        ( formattedLine, lineNumber, lineOffset, _ ) =
            List.foldl
                (\line ( line_, n, o, pos ) ->
                    if pos < 0 then
                        ( line_, n, o, pos )
                    else
                        ( line, n + 1, pos, pos - 1 - String.length line_ )
                )
                ( "", 0, 0, inputStream.position )
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
            ++ toString lineNumber
            ++ separator
            ++ formattedLine
            ++ "\n"
            ++ String.padLeft padding ' ' "^"
            ++ "\nI expected one of the following:\n"
            ++ expectationSeparator
            ++ String.join expectationSeparator ms



-- {-| Parse using an arbitrary parser combinator.
-- -}
-- parse : Parser () res -> String -> Result String res
-- parse parser s =
--     case Combine.parse parser (s ++ "\n") of
--         Ok ( _, _, result ) ->
--             Ok result
--
--         Err ( _, _, _ ) ->
--             Err <| ""
-- lookahead : Parser res -> Parser res
-- lookahead lookaheadParser =
--     let
--         primitiveArg =
--             app lookaheadParser
--     in
--         primitive primitiveArg
