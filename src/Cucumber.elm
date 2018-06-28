module Cucumber exposing (expectFeature, expectFeatureText, matchTags)

{-| This module is responsible for the actual running of a `Gherkin` feature
against a set of Glue functions.

I need to gnerate Expectations from running the glue functions.
To get a test tree structure, I need to generate breadcrumbs along the way,
and generate a tree with the breaccrumbs and Expecations.
I don't want to generate spurious tests from List (GlueFunction state)
which don't match the step description, so glue functions need to
generate Nothing if no match.

In general we expect a `Scenario` to run through to completion.
We hope that every glue function will return either Nothing
(no match between Step and GlueFunction), or new state + pass

If a failure exists, it won't be detected until the Expectations
are executed, and we might get into odd situations where the new state is non-sensical,
so we need to allow List (GlueFunction state) to indicate immediate failure
which will generate a fail Expectation but will also stop further processing of the Scenario.


# Running

@docs expectFeature, expectFeatureText

These functions are for running glue functions with the step arguments as arguments.

It's the glue function's responsibility to decide whether it can handle a
particular step, though we can certainly help with pulling out matching groups.

The execution order is:

  - for each `Scenario` or `Scenario Outline`+`Example`
      - execute each `Background` `Step`
      - `andThen`
      - execute each `Scenario` `Step`


# Reporting


# Temporary

@docs matchTags

-}

import Gherkin exposing (..)
import GherkinParser
import List
import Regex
import Cucumber.Glue exposing (..)
import Result.Extra


{-| Running a feature returns a tuple of `(Boolean, FeatureRun)`
-}
type CucumberResult
    = CucumberResult Bool FeatureRun


{-| The regular `Scenario` and `ScenarioOutline` types won't suffice for reporting,
since we'll have multiple invocations of a set of `Background` `Step`s in the cases
of `Scenario`s and `ScenarioOutline`s, and
-}
type FeatureRun
    = FeatureRun Bool


{-| a data structure to store our Expectations
-}
type Tree a
    = Leaf a
    | Branch List Tree a


{-| If there are any tags associated with the
`Feature`/`Scenario`/`ScenarioOutline`/`Examples` element, then this predicate will
check whether the tag was specified in the filterTags `List`.

The interpretation of tags is documented here:
<https://github.com/cucumber/cucumber/wiki/Tags> .

The gist of it is that the outer layer of lists is or-ed together,
the inner list is and-ed together.

-}
matchTags : List (List Tag) -> List Tag -> Bool
matchTags filterTags elementTags =
    if List.isEmpty elementTags then
        True
    else
        List.any (List.all (flip List.member elementTags)) filterTags


{-| This is the main entry point to the module.

  - Takes a `String` containing a `Feature` definition,
  - Parses it,
  - Runs it against against a set of glue functions,
  - Reports the results.

-}
expectFeatureText : List (GlueFunction state) -> state -> List (List Tag) -> String -> Result String ()
expectFeatureText glueFunctions initialState filterTags featureText =
    GherkinParser.parse GherkinParser.feature featureText
        |> Result.mapError (String.append "Parsing error")
        |> Result.andThen (expectFeature glueFunctions initialState filterTags)
        |> Result.andThen (always (Ok ()))


{-| Verify a `Feature` against a set of glue functions.
-}
expectFeature : List (GlueFunction state) -> state -> List (List Tag) -> Feature -> Result String ()
expectFeature glueFunctions initialState filterTags (Feature featureTags featureDescription _ _ _ background scenarios) =
    if matchTags filterTags featureTags then
        scenarios
            |> List.map (expectScenario glueFunctions background filterTags initialState)
            |> Result.Extra.combine
            |> Result.andThen
                (always (Ok ()))
    else
        Err ("Skipping feature " ++ featureDescription)


{-| Substitute an Examples row to create a new Scenario
-}
substituteExampleInScenario : List Tag -> String -> List Step -> List String -> List String -> Scenario
substituteExampleInScenario scenarioTags scenarioDescription steps header row =
    let
        filterTokens string =
            let
                zip =
                    List.map2 (,) header row

                replace ( token, value ) oldString =
                    Regex.replace Regex.All
                        (Regex.regex (Regex.escape ("<" ++ token ++ ">")))
                        (always value)
                        oldString
            in
                List.foldl replace string zip

        filterStepArg stepArg =
            case stepArg of
                DocString string ->
                    DocString <| filterTokens string

                DataTable (Table dataTableHeader dataTableRows) ->
                    DataTable <|
                        Table (List.map filterTokens dataTableHeader)
                            (List.map (List.map filterTokens) dataTableRows)

                NoArg ->
                    NoArg

        filterStep (Step stepType stepDescription stepArg) =
            Step stepType (filterTokens stepDescription) (filterStepArg stepArg)

        filteredSteps =
            List.map filterStep steps
    in
        Scenario scenarioTags (filterTokens scenarioDescription) filteredSteps


{-| Run a `Scenario` against a set of `List (GlueFunction state)` using an initial state
-}
expectScenario : List (GlueFunction state) -> Background -> List (List Tag) -> state -> Scenario -> Result String ()
expectScenario glueFunctions background filterTags initialState scenario =
    case scenario of
        Scenario scenarioTags scenarioDescription steps ->
            if matchTags filterTags scenarioTags then
                Ok initialState
                    |> Result.andThen
                        (expectBackground glueFunctions background)
                    |> Result.andThen
                        (expectSteps glueFunctions steps)
                    |> Result.andThen
                        (always (Ok ()))
            else
                Err ("Scenario skipped due to tag mismatch: " ++ scenarioDescription)

        ScenarioOutline scenarioTags scenarioDescription steps examplesList ->
            if matchTags filterTags scenarioTags then
                examplesList
                    |> List.concatMap
                        (\(Examples exampleTags (Table header rows)) ->
                            List.map
                                (\row ->
                                    expectScenario
                                        glueFunctions
                                        background
                                        filterTags
                                        initialState
                                    <|
                                        substituteExampleInScenario
                                            (scenarioTags ++ exampleTags)
                                            scenarioDescription
                                            steps
                                            header
                                            row
                                )
                                rows
                        )
                    |> Result.Extra.combine
                    |> Result.andThen
                        (always (Ok ()))
            else
                Err ("Scenario Outline skipped due to tag mismatch: " ++ scenarioDescription)


{-| Run a `Background` against a set of `GlueFunction` using an initial state
-}
expectBackground : List (GlueFunction state) -> Background -> state -> Result String state
expectBackground glueFunctions background initialState =
    case background of
        NoBackground ->
            Ok initialState

        Background backgroundDescription backgroundSteps ->
            expectSteps glueFunctions backgroundSteps initialState


{-| Run a `List` of `Step`s against some `List (GlueFunction state)` using an inital state.

Because we want failures to be meaningful, `List (GlueFunction state)` need to return a pass
if there's no match on the step description, only fail if there's a match and
an actual Assertion failed.

Each `Scenario`, and each run of a `ScenarioOutline`, result in a separate Expectation.

Return a new state, and a List of (String, Expectation) where the String is the Step description

-}
expectSteps : List (GlueFunction state) -> List Step -> state -> Result String state
expectSteps glueFunctions steps initialState =
    case steps of
        [] ->
            Ok initialState

        x :: xs ->
            expectStep x glueFunctions initialState |> Result.andThen (expectSteps glueFunctions xs)


{-| runStep will take a Step and an initial state and run them against a Glue function,
returning an updated state (to pass to the next Glue function and/or Step) and an
Expectation.

Maybe it makes more sense to return a `Result` of Ok state | Err Expectation. Can then use andThen?

-}
expectStep : Step -> List (GlueFunction state) -> state -> GlueFunctionResult state
expectStep step glueFunctions initialState =
    case glueFunctions of
        [] ->
            Ok initialState

        x :: xs ->
            let
                (Step stepType stepDescription stepArg) =
                    step
            in
                (x stepDescription stepArg initialState) |> Result.andThen (expectStep step xs)
