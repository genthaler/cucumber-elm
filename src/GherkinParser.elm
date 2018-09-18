module GherkinParser exposing (feature, parse)

{-| As a rule, all these parsers start with what they need i.e. commit to a path immediately, and consume all whitespace at the end.
-}

-- (asA, background, comment, detailText, docString, effectiveEndOfLine, examples,zeroOrMore, feature, iWantTo, inOrderTo, interspace, newline, noArg, noBackground, parse, scenario, scenarioOutline, space, spaces, step, tab, table, tableCellContent, tableRow, tableRows, tag, tags)
-- (asA, background, comment, detailText, docString, effectiveEndOfLine, examples, feature, iWantTo, inOrderTo, interspace, newline, noArg, noBackground, parse, scenario, scenarioOutline, spaces, step, table, tableCellContent, tableRow, tableRows, tag, tags)

import Gherkin exposing (..)
import Parser exposing ((|.), (|=), Parser, Trailing(..), backtrackable, chompUntilEndOr, chompWhile, commit, deadEndsToString, end, getChompedString, keyword, lazy, lineComment, map, oneOf, run, sequence, succeed, symbol, token, variable)
import Set
import String


{-| Apply a parser zero or more times
-}
zeroOrMore : Parser a -> Parser (List a)
zeroOrMore p =
    oneOf
        [ succeed (::)
            |= p
            |= lazy (\_ -> zeroOrMore p)
        , succeed []
        ]



-- Whitespace parsers


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


space : Parser ()
space =
    token " "


tab : Parser ()
tab =
    token "\t"


{-| Parse a newline
-}
newline : Parser ()
newline =
    oneOf [ token "\r\n", token "\r", token "\n" ]


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
    succeed ()
        |. zeroOrMore (oneOf [ space, tab, effectiveEndOfLine ])



-- Plain text parsers


{-| Parse detail text, typically after a Gherkin keyword until the effective
end of line.
-}
detailText : Parser String
detailText =
    (getChompedString <|
        succeed ()
            |. chompWhile (\c -> c /= '#' && c /= '\n' && c /= '\r')
    )
        |. effectiveEndOfLine


{-| Parse a docstring step argument.
-}
docString : Parser StepArg
docString =
    let
        tripleQuote =
            "\"\"\""
    in
    succeed DocString
        |. token tripleQuote
        |= (getChompedString <| chompUntilEndOr tripleQuote)
        |. token tripleQuote
        |. interspace



-- Table parsers


{-| Parse a step argument table cell content.

This is saying, any text bookended by non-pipe, non-whitespace characters

-}
tableCellContent : Parser String
tableCellContent =
    map String.trim <| getChompedString <| chompWhile (\c -> c /= '|')


{-| Parse a step argument table row.

This is saying, any text bookended by non-pipe, non-whitespace characters, punctuated by an end-of-line

-}
tableRow : Parser Row
tableRow =
    succeed identity
        |. symbol "|"
        |. spaces
        |= oneOf
            [ succeed []
                |. effectiveEndOfLine
            , succeed (::)
                |= tableCellContent
                |= lazy (\_ -> tableRow)
            ]
        |. interspace


{-| Parse step argument table rows.
-}
tableRows : Parser (List Row)
tableRows =
    zeroOrMore tableRow


{-| Parse a step argument table.

This is saying, any text bookended by non-pipe, non-whitespace characters

-}
table : Parser Table
table =
    succeed Table
        |= tableRow
        |= tableRows



-- Tag parsers


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
        |. interspace


{-| Parse a list of tag lines.
-}
tags : Parser (List Tag)
tags =
    zeroOrMore tag
        |. interspace



-- Gherkin keyword line parsers


{-| Parse an `As a` line.
-}
asA : Parser AsA
asA =
    succeed AsA
        |. keyword "As a"
        |. spaces
        |= detailText
        |. interspace


{-| Parse an `In order to` line.
-}
inOrderTo : Parser InOrderTo
inOrderTo =
    succeed InOrderTo
        |. keyword "In order to"
        |. spaces
        |= detailText
        |. interspace


{-| Parse an `I want to` line.
-}
iWantTo : Parser IWantTo
iWantTo =
    succeed IWantTo
        |. keyword "I want to"
        |. spaces
        |= detailText
        |. interspace


{-| Parse an absent step argument.
-}
noArg : Parser StepArg
noArg =
    succeed NoArg
        |. interspace


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
        |= oneOf
            [ docString
            , map DataTable table
            , noArg
            ]


{-| Parse a scenario outline example section.
-}
examples : Parser Examples
examples =
    succeed Examples
        |= backtrackable tags
        |. keyword "Examples:"
        |. spaces
        |. detailText
        |. interspace
        |= table
        |. interspace


{-| Parse a scenario.
-}
scenario : Parser Scenario
scenario =
    succeed Scenario
        |= backtrackable tags
        |. keyword "Scenario:"
        |. spaces
        |= detailText
        |. interspace
        |= zeroOrMore step


{-| Parse a scenario outline.
-}
scenarioOutline : Parser Scenario
scenarioOutline =
    succeed ScenarioOutline
        |= backtrackable tags
        |. keyword "Scenario Outline:"
        |. spaces
        |= detailText
        |. interspace
        |= zeroOrMore step
        |. interspace
        |= zeroOrMore examples
        |. interspace


{-| Parse a background section.
-}
background : Parser Background
background =
    succeed Background
        |. keyword "Background:"
        |. spaces
        |= detailText
        |. interspace
        |= zeroOrMore step


{-| Parse an absent background section.
-}
noBackground : Parser Background
noBackground =
    succeed NoBackground
        |. interspace



-- Public API


{-| Parse a feature.
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
        |= inOrderTo
        |= iWantTo
        |= oneOf [ background, noBackground ]
        |= zeroOrMore (oneOf [ scenario, scenarioOutline ])
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
