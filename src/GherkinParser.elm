module GherkinParser exposing (asA, background, comment, detailText, docString, effectiveEndOfLine, examples, feature, iWantTo, inOrderTo, interspace, loops, loopsHelp, newline, noArg, noBackground, parse, scenario, scenarioOutline, spaces, step, table, tableCellContent, tableRow, tableRows, tag, tags)

-- (asA, background, comment, detailText, docString, effectiveEndOfLine, examples, feature, iWantTo, inOrderTo, interspace, loops, loopsHelp, newline, noArg, noBackground, parse, scenario, scenarioOutline, spaces, step, table, tableCellContent, tableRow, tableRows, tag, tags)

import Gherkin exposing (..)
import Parser exposing ((|.), (|=), Parser, Trailing(..), chompUntilEndOr, chompWhile, deadEndsToString, end, getChompedString, keyword, lazy, lineComment, loop, map, oneOf, run, sequence, succeed, symbol, token, variable)
import Set
import String


{-| Parse a comment; everything from a `#` symbol to the end of the line
-}
comment : Parser ()
comment =
    lineComment "#"


{-| Parse any number of whitespace (except for newlines).
-}
spaces : Parser ()
spaces =
    chompWhile (\c -> c == ' ' || c == '\t')


{-| Parse a newline
-}
newline : Parser ()
newline =
    oneOf [ end, token "\u{000D}\n", token "\u{000D}", token "\n" ]


{-| Parse a newline
-}
effectiveEndOfLine : Parser ()
effectiveEndOfLine =
    oneOf [ comment, newline ]


{-| Parse any amount of space that might separate tokens, that isn't context
sensitive.
-}
interspace : Parser ()
interspace =
    oneOf [ spaces, effectiveEndOfLine ]


{-| Parse detail text, typically after a Gherkin keyword until the effective
end of line.
-}
detailText : Parser String
detailText =
    getChompedString <|
        succeed ()
            |. chompWhile (\c -> c /= '#' && c /= '\n' && c /= '\u{000D}')


{-| Parse a tag.
-}
tag : Parser Tag
tag =
    succeed Tag
        |. symbol "@"
        |= variable
            { start = Char.isAlphaNum
            , inner = Char.isAlphaNum
            , reserved = Set.empty
            }


{-| Parse a list of tag lines.
-}
tags : Parser (List Tag)
tags =
    Parser.sequence
        { start = ""
        , separator = ""
        , end = ""
        , spaces = spaces
        , item = tag
        , trailing = Optional -- demand a trailing semi-colon
        }


{-| Parse an `As a` line.
-}
asA : Parser AsA
asA =
    succeed AsA
        |. keyword "As a"
        |. spaces
        |= detailText


{-| Parse an `In order to` line.
-}
inOrderTo : Parser InOrderTo
inOrderTo =
    succeed InOrderTo
        |. keyword "In order to"
        |. spaces
        |= detailText


{-| Parse an `I want to` line.
-}
iWantTo : Parser IWantTo
iWantTo =
    succeed IWantTo
        |. keyword "I want to"
        |. spaces
        |= detailText


{-| Parse a docstring step argument.
-}
docString : Parser StepArg
docString =
    succeed DocString
        |. spaces
        |. token "\"\"\""
        |= (getChompedString <| chompUntilEndOr "\"\"\"")


{-| Parse a step argument table cell content.

This is saying, any text bookended by non-pipe, non-whitespace characters

-}
tableCellContent : Parser String
tableCellContent =
    map String.trim <| getChompedString <| chompWhile (\c -> c /= '|')


{-| Parse a step argument table row.

This is saying, any text bookended by non-pipe, non-whitespace characters

-}
tableRow : Parser Row
tableRow =
    succeed identity
        |. spaces
        |. symbol "|"
        |. spaces
        |= oneOf
            [ succeed []
                |. newline
            , succeed (::)
                |= tableCellContent
                |= lazy (\_ -> tableRow)
            ]


{-| Parse a step argument table rows.

This is saying, any text bookended by non-pipe, non-whitespace characters

-}
tableRows : Parser (List Row)
tableRows =
    loops tableRow newline


{-| Parse a step argument table.

This is saying, any text bookended by non-pipe, non-whitespace characters

-}
table : Parser Table
table =
    succeed Table
        |= tableRow
        |. newline
        |= tableRows


{-| Parse an absent step argument.
-}
noArg : Parser StepArg
noArg =
    succeed NoArg


{-| Parse a step.
-}
step : Parser Step
step =
    succeed Step
        |= oneOf
            [ succeed Given |. keyword "Given"
            , succeed When |. keyword "When"
            , succeed Then |. keyword "Then"
            , succeed And |. keyword "And"
            , succeed But |. keyword "But"
            ]
        |. spaces
        |= detailText
        |. interspace
        |= oneOf [ docString, map DataTable table, noArg ]


{-| Parse a scenario outline example section.
-}
examples : Parser Examples
examples =
    succeed Examples
        |= tags
        |. interspace
        |. keyword "Examples:"
        |. interspace
        |= table


{-| Parse a scenario.
-}
scenario : Parser Scenario
scenario =
    succeed Scenario
        |= tags
        |. interspace
        |. keyword "Scenario:"
        |. spaces
        |= detailText
        |. interspace
        |= loops step newline


{-| Parse a scenario outline.
-}
scenarioOutline : Parser Scenario
scenarioOutline =
    succeed ScenarioOutline
        |= tags
        |. interspace
        |. keyword "Scenario Outline:"
        |. spaces
        |= detailText
        |. interspace
        |= loops step newline
        |. interspace
        |= loops examples newline


{-| Parse a background section.
-}
background : Parser Background
background =
    succeed Background
        |. keyword "Background:"
        |. spaces
        |= detailText
        |. interspace
        |= loops step newline


{-| Parse an absent background section.
-}
noBackground : Parser Background
noBackground =
    succeed NoBackground


{-| Parse an entire.
-}
feature : Parser Feature
feature =
    succeed Feature
        |= tags
        |. interspace
        |. token "Feature:"
        |. spaces
        |= detailText
        |. interspace
        |= asA
        |. interspace
        |= inOrderTo
        |. interspace
        |= iWantTo
        |. interspace
        |= oneOf [ background, noBackground ]
        |. interspace
        |= loops (oneOf [ scenario, scenarioOutline ]) newline
        |. interspace
        |. end


{-| Parse using an arbitrary parser combinator.
-}
parse : Parser res -> String -> Result String res
parse parser s =
    case run parser s of
        Ok result ->
            Ok result

        Err deadEnds ->
            Err <| Debug.toString deadEnds


loops : Parser a -> Parser () -> Parser (List a)
loops statementParser separatorParser =
    loop [] (loopsHelp statementParser separatorParser)


loopsHelp : Parser a -> Parser () -> List a -> Parser (Parser.Step (List a) (List a))
loopsHelp statementParser separatorParser statements =
    oneOf
        [ succeed (\statement -> Parser.Loop (statement :: statements))
            |= statementParser
            |. spaces
            |. separatorParser
            |. spaces
        , succeed ()
            |> map (\_ -> Parser.Done (List.reverse statements))
        ]
