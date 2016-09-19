module GherkinMd exposing (..)

import Gherkin exposing (..)
import String


newline : String
newline =
    "\n"


asAMd : AsA -> String
asAMd (AsA detailText) =
    "As a "
        ++ detailText
        ++ newline


inOrderToMd : InOrderTo -> String
inOrderToMd (InOrderTo detailText) =
    "In order to "
        ++ detailText
        ++ newline


iWantToMd : IWantTo -> String
iWantToMd (IWantTo detailText) =
    "I want to "
        ++ detailText
        ++ newline


stepArgMd : StepArg -> String
stepArgMd stepArg =
    case stepArg of
        DocString docStringContent ->
            "```"
                ++ newline
                ++ docStringContent
                ++ newline
                ++ "```"
                ++ newline

        DataTable dataTableContent ->
            dataTableMd dataTableContent

        NoArg ->
            ""


dataTableMd : List (List String) -> String
dataTableMd table =
    ""



-- table []
--     << List.map
--         (\row ->
--             (tr []
--                 <| List.map
--                     (\col ->
--                         td []
--                             <| List.repeat 1
--                                 (text col)
--                     )
--                     row
--             )
--         )


stepMd : Step -> String
stepMd theStep =
    let
        stepArgMd' name detail theStepArg =
            name
                ++ detail
                ++ case (stepArgMd theStepArg) of
                    element ->
                        element
    in
        case theStep of
            Given detail theStepArg ->
                stepArgMd' "Given" detail theStepArg

            When detail theStepArg ->
                stepArgMd' "When" detail theStepArg

            Then detail theStepArg ->
                stepArgMd' "Then" detail theStepArg

            And detail theStepArg ->
                stepArgMd' "And" detail theStepArg

            But detail theStepArg ->
                stepArgMd' "But" detail theStepArg


scenarioMd : Scenario -> String
scenarioMd scenario =
    case scenario of
        Scenario tags detailText steps ->
            "Scenario "
                ++ detailText
                ++ newline
                ++ (String.join newline <| List.map stepMd steps)

        _ ->
            ""


backgroundMd : Background' -> String
backgroundMd background =
    case background of
        Background detailText steps ->
            "Background"
                ++ newline
                ++ detailText
                ++ newline
                ++ (String.join newline <| List.map stepMd steps)

        NoBackground ->
            ""


featureMd : Feature -> String
featureMd feature =
    case feature of
        Feature tags detailText asA inOrderTo iWantTo background scenarios ->
            "Feature: "
                ++ detailText
                ++ newline
                ++ asAMd asA
                ++ inOrderToMd inOrderTo
                ++ iWantToMd iWantTo
                ++ backgroundMd background
                ++ (String.join newline <| List.map scenarioMd scenarios)
