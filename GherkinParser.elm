module GherkinParser exposing (..)

import Combine exposing (..)
import Combine.Char exposing (..)
import Combine.Infix exposing (..)
import Combine.Num
import String
import Gherkin exposing (..)


type alias Ctx =
    List Int


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
    regex "#[^\n]*"


spaces : Parser String
spaces =
    regex " *"


whitespace : Parser String
whitespace =
    comment <|> spaces <?> "whitespace"


ws : Parser res -> Parser res
ws =
    between whitespace whitespace


step : Parser Step
step =
    Step
        <$> stepType


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


parse : String -> Result String (List C)
parse s =
    case Combine.parse program (s ++ "\n") of
        ( Ok es, _ ) ->
            Ok es

        ( Err ms, cx ) ->
            Err <| formatError s ms cx


test : Result String (List C)
test =
    parse """import os\x0D
\x0D
a = b = 1\x0D
\x0D
def rel(p):\x0D
  return os.path.join(os.path.dirname(__file__), p)\x0D
\x0D
def f(a, b):\x0D
  return a + b\x0D
\x0D
with open(rel('Python.elm')) as f:\x0D
  for line in f:\x0D
    print f\x0D
"""
