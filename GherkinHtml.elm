module GherkinHtml exposing (..)

import Gherkin exposing (..)
import Html exposing (..)


-- import String


asAHtml : AsA -> Html msg
asAHtml (AsA detailText) =
    text detailText


inOrderToHtml : InOrderTo -> Html msg
inOrderToHtml (InOrderTo detailText) =
    text detailText


iWantToHtml : IWantTo -> Html msg
iWantToHtml (IWantTo detailText) =
    text detailText


stepArgHtml : StepArg -> Maybe (Html msg)
stepArgHtml stepArg =
    case stepArg of
        DocString docStringContent ->
            Just (text docStringContent)

        DataTable dataTableContent ->
            Just (dataTableHtml dataTableContent)

        NoArg ->
            Nothing


dataTableHtml : List (List String) -> Html msg
dataTableHtml content =
    let
        makeTexts : List String -> List (Html msg)
        makeTexts cols =
            List.map text cols

        makeTds : List (Html msg) -> List (Html msg)
        makeTds cols =
            List.map (td []) (List.repeat 1) cols

        makeRows : List (List (Html msg)) -> List (Html msg)
        makeRows tds =
            List.map (tr []) tds
    in
        table [] makeRows (List.map makeRows (List.map makeTds (List.map make)))


stepHtml : Step -> Html msg
stepHtml theStep =
    let
        stepArgHtml' name detail theStepArg =
            p []
                ([ text "Given", text detail ]
                    ++ case (stepArgHtml theStepArg) of
                        Just element ->
                            [ element ]

                        Nothing ->
                            []
                )
    in
        case theStep of
            Given detail theStepArg ->
                stepArgHtml' "Given" detail theStepArg

            _ ->
                text ""



-- scenario : Parser Scenario
-- scenario =
--     Scenario
--         <$> (string "Scenario:"
--                 *> spaces
--                 *> detailText
--                 <* (comment <|> newline)
--             )
--         <* spaces
--         <*> (sepBy1 (newline *> spaces) step)
--
--
-- background : Parser Background
-- background =
--     string "Background:"
--         *> optional "" spaces
--         *> newline
--         *> (Background <$> many1 step)
--
--
-- noBackground : Parser Background
-- noBackground =
--     NoBackground <$ succeed ()
--
--
-- feature : Parser Feature
-- feature =
--     string "Feature:"
--         *> optional "" spaces
--         *> (Feature
--                 <$> detailText
--                 <* (comment <|> newline)
--                 <* optional "" spaces
--                 <*> asA
--                 <* optional "" spaces
--                 <*> inOrderTo
--                 <* optional "" spaces
--                 <*> iWantTo
--                 <* optional "" spaces
--                 <*> (background <|> noBackground)
--                 <* optional "" spaces
--                 <*> (sepBy1 newline scenario)
--            )
--
--
-- formatError : String -> List String -> Context -> String
-- formatError input ms cx =
--     let
--         lines =
--             String.lines input
--
--         lineCount =
--             List.length lines
--
--         ( line, lineNumber, lineOffset, _ ) =
--             List.foldl
--                 (\line ( line', n, o, pos ) ->
--                     if pos < 0 then
--                         ( line', n, o, pos )
--                     else
--                         ( line, n + 1, pos, pos - 1 - String.length line' )
--                 )
--                 ( "", 0, 0, cx.position )
--                 lines
--
--         separator =
--             "|> "
--
--         expectationSeparator =
--             "\n  * "
--
--         lineNumberOffset =
--             floor (logBase 10 lineNumber) + 1
--
--         separatorOffset =
--             String.length separator
--
--         padding =
--             lineNumberOffset + separatorOffset + lineOffset + 1
--     in
--         "Parse error around line:\n\n"
--             ++ (toString lineNumber)
--             ++ separator
--             ++ line
--             ++ "\n"
--             ++ String.padLeft padding ' ' "^"
--             ++ "\nI expected one of the following:\n"
--             ++ expectationSeparator
--             ++ String.join expectationSeparator ms
--
--
-- parse : Parser res -> String -> Result String res
-- parse parser s =
--     case Combine.parse parser (s ++ "\n") of
--         ( Ok es, _ ) ->
--             Ok es
--
--         ( Err ms, cx ) ->
--             Err <| formatError s ms cx
