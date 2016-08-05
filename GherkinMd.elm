module GherkinHtml exposing (..)

import Gherkin exposing (..)


-- import String


asAHtml : AsA -> String
asAHtml (AsA detailText) =
    "As a " ++ detailText ++ "\n\n"


inOrderToHtml : InOrderTo -> String
inOrderToHtml (InOrderTo detailText) =
    "In order to " ++ detailText ++ "\n\n"


iWantToHtml : IWantTo -> String
iWantToHtml (IWantTo detailText) =
    "I want to " ++ detailText ++ "\n\n"


stepArgHtml : StepArg -> String
stepArgHtml stepArg =
    case stepArg of
        DocString docStringContent ->
            "\"\"\"\n" ++ docStringContent + "\"\"\"\n"

        DataTable dataTableContent ->
            dataTableHtml dataTableContent

        NoArg ->
            ""


dataTableHtml : List (List String) -> String
dataTableHtml =
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


stepHtml : Step -> String
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


scenarioHtml : Scenario -> String
scenarioHtml scenario =
    case scenario of
        Scenario detailText steps ->
            span []
                <| (text "Scenario")
                :: (text detailText)
                :: List.map stepHtml steps

        _ ->
            text ""


backgroundHtml : Background -> String
backgroundHtml background =
    case background of
        Background steps ->
            span []
                <| (text "Background")
                :: List.map stepHtml steps

        NoBackground ->
            text ""


featureHtml : Feature -> String
featureHtml feature =
    case feature of
        Feature detailText asA inOrderTo iWantTo background scenarios ->
            span []
                <| [ text detailText, asAHtml asA, inOrderToHtml inOrderTo, iWantToHtml iWantTo, backgroundHtml background ]
                ++ List.map scenarioHtml scenarios
