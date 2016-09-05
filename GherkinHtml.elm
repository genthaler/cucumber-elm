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
dataTableHtml =
    table []
        << List.map
            (\row ->
                (tr []
                    <| List.map
                        (\col ->
                            td []
                                <| List.repeat 1
                                    (text col)
                        )
                        row
                )
            )


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


scenarioHtml : Scenario -> Html msg
scenarioHtml scenario =
    case scenario of
        Scenario detailText steps ->
            span []
                <| (text "Scenario")
                :: (text detailText)
                :: List.map stepHtml steps

        _ ->
            text ""


backgroundHtml : Background -> Html msg
backgroundHtml background =
    case background of
        Background steps ->
            span []
                <| (text "Background")
                :: List.map stepHtml steps

        NoBackground ->
            text ""


featureHtml : Feature -> Html msg
featureHtml feature =
    case feature of
        Feature detailText asA inOrderTo iWantTo background scenarios ->
            span []
                <| [ text detailText, asAHtml asA, inOrderToHtml inOrderTo, iWantToHtml iWantTo, backgroundHtml background ]
                ++ List.map scenarioHtml scenarios