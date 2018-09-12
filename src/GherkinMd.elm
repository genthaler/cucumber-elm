module GherkinMd exposing (asAMd, backgroundMd, examplesMd, featureMd, iWantToMd, inOrderToMd, newline, scenarioMd, stepArgMd, stepMd, tableMd, tagMd, tagsMd)

{-| This module prints out a Gherkin AST in Markdown format, parseable by the elm-markdown parser
-}

import Gherkin exposing (..)
import String


newline : String 
newline =
    "\n"


tagMd : Tag -> String
tagMd (Tag tag) =
    "@" ++ tag


tagsMd : List Tag -> String
tagsMd =
    List.map tagMd >> String.join " " >> flip (++) newline


asAMd : AsA -> String
asAMd (AsA detailText) =
    "> As a "
        ++ detailText
        ++ newline
        ++ newline


inOrderToMd : InOrderTo -> String
inOrderToMd (InOrderTo detailText) =
    "> In order to "
        ++ detailText
        ++ newline
        ++ newline


iWantToMd : IWantTo -> String
iWantToMd (IWantTo detailText) =
    "> I want to "
        ++ detailText
        ++ newline
        ++ newline


stepArgMd : StepArg -> String
stepArgMd stepArg =
    case stepArg of
        DocString docStringContent ->
            "```"
                ++ newline
                ++ newline
                ++ docStringContent
                ++ newline
                ++ newline
                ++ "```"
                ++ newline
                ++ newline

        DataTable table ->
            tableMd table

        NoArg ->
            ""


tableMd : Table -> String
tableMd (Table header body) =
    let
        tag tagbase string =
            "<" ++ tagbase ++ ">" ++ string ++ "</" ++ tagbase ++ ">"

        constructRow tagbase row =
            row |> List.map (tag tagbase) |> String.join "" |> tag "tr"
    in
    constructRow "th" header
        :: List.map (constructRow "td") body
        |> String.join newline
        |> tag "table"


stepMd : Step -> String
stepMd (Step stepType detail stepArg) =
    let
        stepArgMd_ name detail2 theStepArg =
            "**"
                ++ name
                ++ "** "
                ++ detail2
                ++ newline
                ++ newline
                ++ (case stepArgMd theStepArg of
                        element ->
                            element
                   )

        stepTypeDesc =
            case stepType of
                Given ->
                    "Given"

                When ->
                    "When"

                Then ->
                    "Then"

                And ->
                    "And"

                But ->
                    "But"
    in
    stepArgMd_ stepTypeDesc detail stepArg
        ++ newline
        ++ newline


examplesMd : Examples -> String
examplesMd (Examples tags table) =
    tagsMd tags
        ++ "###Examples:"
        ++ newline
        ++ newline
        ++ tableMd table


scenarioMd : Scenario -> String
scenarioMd scenario =
    case scenario of
        Scenario tags detailText steps ->
            tagsMd tags
                ++ "##Scenario: "
                ++ detailText
                ++ newline
                ++ newline
                ++ (String.join newline <| List.map stepMd steps)
                ++ newline
                ++ newline

        ScenarioOutline tags detailText steps examples ->
            tagsMd tags
                ++ "##Scenario: "
                ++ detailText
                ++ newline
                ++ newline
                ++ (String.join newline <| List.map stepMd steps)
                ++ newline
                ++ newline
                ++ (examples |> List.map examplesMd |> String.join (newline ++ newline))
                ++ newline
                ++ newline


backgroundMd : Background -> String
backgroundMd background =
    case background of
        Background detailText steps ->
            "## Background: "
                ++ detailText
                ++ newline
                ++ newline
                ++ (String.join newline <| List.map stepMd steps)
                ++ newline
                ++ newline

        NoBackground ->
            ""


featureMd : Feature -> String
featureMd feature =
    case feature of
        Feature tags detailText asA inOrderTo iWantTo background scenarios ->
            tagsMd tags
                ++ "# Feature: "
                ++ detailText
                ++ newline
                ++ newline
                ++ asAMd asA
                ++ inOrderToMd inOrderTo
                ++ iWantToMd iWantTo
                ++ backgroundMd background
                ++ (String.join (newline ++ newline) <|
                        List.map scenarioMd scenarios
                   )
flip : (a -> b -> c) -> b -> a -> c
flip f b a =
    f a b
