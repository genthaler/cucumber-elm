module GherkinParser exposing (feature, formatError, parse)
 
import Gherkin exposing (..)
import Parser exposing ((|.), (|=), Parser, chompUntilEndOr, lineComment, succeed, symbol, chompWhile, token, oneOf, getChompedString, variable,keyword, sequence, map, Trailing(..))
import String
import Set

{-| Parse a comment; everything from a `#` symbol to the end of the line
-}
comment : Parser String
comment =
    lineComment "#"


{-| Parse any number of whitespace (except for newlines).
-}
spaces : Parser ()
spaces = 
    chompWhile (\c -> c == ' ' || c == '\t' || c == '\n' || c == '\r')


{-| Parse a newline
-}
newline : Parser String
newline = oneOf([token "\r\n", token "\r", token "\r"])

{-| Parse a newline
-}
effectiveEndOfLine : Parser String
effectiveEndOfLine = oneOf([comment, newline])



{-| Parse any amount of space that might separate tokens, that isn't context
sensitive.
-}
interspace : Parser (List String)
interspace =
    oneOf([newline, spaces, comment ])


{-| Parse detail text, typically after a Gherkin keyword until the effective
end of line.
-}
detailText : Parser String
detailText =
  getChompedString <|
    succeed ()
      |. chompWhile (\c -> c /= '#' || c /= '\n' || c /= '\r')


{-| Parse a tag.
-}
tag : Parser  Tag
tag =
    succeed Tag
    |. symbol "@"
    |=  variable
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
asA : Parser  AsA
asA =
    succeed AsA
        |. keyword "As a"
        |. spaces
        |= detailText


{-| Parse an `In order to` line.
-}
inOrderTo : Parser  InOrderTo
inOrderTo =
    succeed InOrderTo
        |. keyword "In order to"
        |. spaces
        |= detailText


{-| Parse an `I want to` line.
-}
iWantTo : Parser  IWantTo
iWantTo =
    succeed IWantTo
        |. keyword "I want to"
        |. spaces
        |= detailText


{-| Parse a docstring quote token.
-}
docStringQuotes : Parser  String
docStringQuotes =
    token "\"\"\""


{-| Parse a docstring step argument.
-}
docString : Parser  StepArg
docString =
    succeed DocString
        |. spaces
        |. docStringQuotes
        |= chompUntilEndOr docStringQuotes



{-| Parse a step argument table cell content.
 
This is saying, any text bookended by non-pipe, non-whitespace characters

-}
tableCellContent : Parser  String
tableCellContent =
    chompWhile (\c -> c /= '|' )


{-| Parse a step argument table row.

This is saying, any text bookended by non-pipe, non-whitespace characters

-}
tableRow : Parser  Row
tableRow =
    Parser.sequence
        { start = "|"
        , separator = "|"
        , end = "|"
        , spaces = spaces
        , item = tableCellContent
        , trailing = Forbidden
        }


{-| Parse a step argument table rows.

This is saying, any text bookended by non-pipe, non-whitespace characters

-}
tableRows : Parser (List Row)
tableRows =
    Parser.sequence
    { start = ""
    , separator = newline
    , end = ""
    , spaces = spaces
    , item = tableRow
    , trailing = Optional
    }


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
step : Parser  Step
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
        |= oneOf [docString, map DataTable table, noArg]


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
        |=   sequence
            { start = ""
            , separator = newline
            , end = ""
            , spaces = spaces
            , item = step
            , trailing = Optional -- demand a trailing semi-colon
            }


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
        |=  sequence
            { start = ""
            , separator = newline
            , end = ""
            , spaces = interspace
            , item = step
            , trailing = Optional -- demand a trailing semi-colon
            }
        |. interspace
        |=  sequence
            { start = ""
            , separator = newline
            , end = ""
            , spaces = interspace
            , item = examples
            , trailing = Optional -- demand a trailing semi-colon
            }


{-| Parse a background section.
-}
background : Parser  Background
background =
    succeed Background
        |. keyword "Background:"
        |. spaces
        |= detailText
        |. interspace
        |=  sequence
            { start = ""
            , separator = newline
            , end = ""
            , spaces = interspace
            , item = step
            , trailing = Optional -- demand a trailing semi-colon
            }


{-| Parse an absent background section.
-}
noBackground : Parser Background
noBackground =
    succeed NoBackground


{-| Parse an entire.
-}
feature : Parser  Feature
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
        |= oneOf [background, noBackground]
        |. interspace
        |=  sequence
            { start = ""
            , separator = newline
            , end = ""
            , spaces = interspace
            , item = oneOf [scenario , scenarioOutline]
            , trailing = Optional -- demand a trailing semi-colon
            }


-- {-| Nicely format a parsing error.
-- -}
-- formatError : String -> List String -> ParseContext state res -> String
-- formatError input ms cx =
--     let
--         ( _, inputStream, _ ) =
--             cx

--         lines =
--             String.lines input

--         ( formattedLine, lineNumber, lineOffset, _ ) =
--             List.foldl
--                 (\line ( line_, n, o, pos ) ->
--                     if pos < 0 then
--                         ( line_, n, o, pos )

--                     else
--                         ( line, n + 1, pos, pos - 1 - String.length line_ )
--                 )
--                 ( "", 0, 0, inputStream.position )
--                 lines

--         separator =
--             "|> "

--         expectationSeparator =
--             "\n  * "

--         lineNumberOffset =
--             floor (logBase 10 lineNumber) + 1

--         separatorOffset =
--             String.length separator

--         padding =
--             lineNumberOffset + separatorOffset + lineOffset + 1
--     in
--     "Parse error around line:\n\n"
--         ++ toString lineNumber
--         ++ separator
--         ++ formattedLine
--         ++ "\n"
--         ++ String.padLeft padding ' ' "^"
--         ++ "\nI expected one of the following:\n"
--         ++ expectationSeparator
--         ++ String.join expectationSeparator ms


-- {-| Parse using an arbitrary parser combinator.
-- -}
-- parse : Parser  res -> String -> Result String res
-- parse parser s =
--     case Combine.parse parser (s ++ "\n") of
--         Ok ( _, _, result ) ->
--             Ok result

--         Err ( _, _, _ ) ->
--             Err <| ""



-- lookahead : Parser res -> Parser res
-- lookahead lookaheadParser =
--     let
--         primitiveArg =
--             app lookaheadParser
--     in
--         primitive primitiveArg
