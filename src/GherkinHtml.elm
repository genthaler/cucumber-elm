module GherkinHtml exposing (..)

import Gherkin exposing (..)
import Html exposing (..)


asAHtml : AsA -> Html msg
asAHtml (AsA detailText) =
    li [] [ text ("As a " ++ detailText) ]


inOrderToHtml : InOrderTo -> Html msg
inOrderToHtml (InOrderTo detailText) =
    li [] [ text ("In order to " ++ detailText) ]


iWantToHtml : IWantTo -> Html msg
iWantToHtml (IWantTo detailText) =
    li [] [ text ("I want to " ++ detailText) ]


stepArgHtml : StepArg -> Maybe (Html msg)
stepArgHtml stepArg =
    case stepArg of
        DocString docStringContent ->
            Just (text docStringContent)

        DataTable table ->
            Just (dataTableHtml table)

        NoArg ->
            Nothing


dataTableHtml : Table -> Html msg
dataTableHtml (Table header body) =
    let
        constructRow fn row =
            tr []
                <| List.map
                    (\col ->
                        fn []
                            <| List.repeat 1
                                (text col)
                    )
                    row
    in
        table []
            <| constructRow th header
            :: List.map (constructRow td) body


stepHtml : Step -> Html msg
stepHtml theStep =
    let
        stepArgHtml' name detail theStepArg =
            li []
                ([ text name, text " ", text detail ]
                    ++ case (stepArgHtml theStepArg) of
                        Just element ->
                            [ element ]

                        Nothing ->
                            []
                )
    in
        case theStep of
            Step Given detail theStepArg ->
                stepArgHtml' "Given" detail theStepArg

            Step When detail theStepArg ->
                stepArgHtml' "When" detail theStepArg

            Step Then detail theStepArg ->
                stepArgHtml' "Then" detail theStepArg

            Step And detail theStepArg ->
                stepArgHtml' "And" detail theStepArg

            Step But detail theStepArg ->
                stepArgHtml' "But" detail theStepArg


scenarioHtml : Scenario -> Html msg
scenarioHtml scenario =
    case scenario of
        Scenario tags detailText steps ->
            ul []
                <| (li [] [ text "Scenario: ", text detailText ])
                :: List.map stepHtml steps

        ScenarioOutline tags detailText steps examples ->
            text "Not yet implemented"


backgroundHtml : Background -> Html msg
backgroundHtml background =
    case background of
        Background desc steps ->
            span []
                <| (text ("Background: " ++ desc))
                :: List.map stepHtml steps

        NoBackground ->
            text ""


featureHtml : Feature -> Html msg
featureHtml feature =
    case feature of
        Feature tags detailText asA inOrderTo iWantTo background scenarios ->
            span []
                <| [ ul []
                        [ li []
                            [ text "Feature: "
                            , text detailText
                            ]
                        , li []
                            [ ul []
                                (List.map (\element -> li [] [ element ])
                                    ([ asAHtml asA
                                     , inOrderToHtml inOrderTo
                                     , iWantToHtml iWantTo
                                     ]
                                        ++ (case background of
                                                NoBackground ->
                                                    []

                                                _ ->
                                                    [ backgroundHtml background ]
                                           )
                                        ++ List.map scenarioHtml scenarios
                                    )
                                )
                            ]
                        ]
                   ]
