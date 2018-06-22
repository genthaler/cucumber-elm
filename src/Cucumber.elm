module Cucumber exposing (..)

{-| This module is responsible for the actual running of a `Gherkin` feature
against a set of Glue functions.

I need to gnerate Expectations from running the glue functions.
To get a test tree structure, I need to generate breadcrumbs along the way,
and generate a tree with the breaccrumbs and Expecations.
I don't want to generate spurious tests from GlueFunctions
which don't match the step description, so glue functions need to
generate Nothing if no match.

In general we expect a `Scenario` to run through to completion.
We hope that every glue function will return either Nothing
(no match between Step and GlueFunction), or new state + pass

If a failure exists, it won't be detected until the Expectations
are executed, and we might get into odd situations where the new state is non-sensical,
so we need to allow GlueFunctions to indicate immediate failure
which will generate a fail Expectation but will also stop further processing of the Scenario.

# Glue

These types describe a glue function

@docs GlueFunction, GlueOutput


# Running

@docs expectFeature

These functions are for running glue functions with the step arguments as arguments.

It's the glue function's responsibility to decide whether it can handle a
particular step, though we can certainly help with pulling out matching groups.

The execution order is:

  - for each `Scenario` or `Scenario Outline`+`Example`
      - execute each `Background` `Step`
      - `andThen`
      - execute each `Scenario` `Step`


# Reporting

-}

import Gherkin exposing (..)


-- import GherkinParser exposing (..)

import List
import Regex
import Expect exposing (..)
import Cucumber.Glue exposing (..)


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
type Tree
    = Expectation
    | List Tree


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
        List.any (List.all (Basics.flip List.member elementTags)) filterTags



-- {-| This is the main entry point to the module.
--
--   - Takes a `String` containing a `Feature` definition,
--   - Parses it,
--   - Runs it against against a set of glue functions,
--   - Reports the results.
--
-- -}
-- expectFeatureText : GlueFunctions state -> state -> List (List Tag) -> String -> Expectation
-- expectFeatureText glueFunctions initialState filterTags featureText =
--     case parse GherkinParser.feature featureText of
--         Err error ->
--             "Parsing error" <| defer <| fail error
--
--         Ok feature ->
--             expectFeature glueFunctions initialState filterTags feature
-- {-| Verify a `Feature` against a set of glue functions.
-- -}
-- expectFeature : GlueFunctions state -> state -> List (List Tag) -> Feature -> List Expectation
-- expectFeature glueFunctions initialState filterTags (Feature featureTags featureDescription _ _ _ background scenarios) =
--     let
--         scenarioTests =
--             List.map (expectScenario glueFunctions initialState background filterTags) scenarios
--     in
--         if matchTags filterTags featureTags then
--             Expect.all scenarioTests
--         else
--             skipElement "Feature"


{-| Run a `Scenario` against a set of `GlueFunctions` using an initial state
-}
expectScenario : List (GlueFunction state) -> state -> Background -> List (List Tag) -> Scenario -> List ( String, ExpectationThunk )
expectScenario glueFunctions initialState background filterTags scenario =
    let
        ( backgroundState, backgroundExpectationThunks ) =
            expectBackground glueFunctions initialState background
    in
        case scenario of
            Scenario scenarioTags description steps ->
                let
                    ( _, scenarioExpectationThunks ) =
                        expectSteps glueFunctions backgroundState steps
                in
                    -- ( ("Scenario: " ++ description),
                    if matchTags filterTags scenarioTags then
                        backgroundExpectationThunks ++ scenarioExpectationThunks
                    else
                        -- ("Scenario skipped due to tag mismatch")
                        [ ( description, defer pass ) ]

            -- )
            ScenarioOutline scenarioTags scenarioDescription steps examplesList ->
                let
                    ( _, scenarioExpectationThunks ) =
                        expectSteps glueFunctions backgroundState steps

                    filterExamples (Examples examplesTags _) =
                        matchTags filterTags examplesTags

                    filteredExamplesList =
                        List.filter filterExamples examplesList

                    substituteExamplesInScenario scenarioDescription2 steps2 (Examples _ (Table header rows)) =
                        List.map (substituteExampleInScenario scenarioDescription2 steps2 header)
                            rows

                    substituteExampleInScenario _ steps2 header row =
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

                            filterRow =
                                List.map filterTokens

                            filterTable =
                                List.map filterRow

                            filterStepArg stepArg =
                                case stepArg of
                                    DocString string ->
                                        DocString <| filterTokens string

                                    DataTable (Table dataTableHeader dataTableRows) ->
                                        DataTable
                                            (Table (filterRow dataTableHeader)
                                                (filterTable dataTableRows)
                                            )

                                    NoArg ->
                                        NoArg

                            filterStep (Step stepType stepDescription stepArg) =
                                Step stepType (filterTokens stepDescription) (filterStepArg stepArg)

                            filteredSteps =
                                List.map filterStep steps2
                        in
                            Scenario [] (filterTokens scenarioDescription) filteredSteps

                    instantiatedScenarios =
                        List.map (substituteExamplesInScenario scenarioDescription steps) filteredExamplesList
                in
                    -- ( ("Scenario Outline: " ++ scenarioDescription)
                    -- ,
                    if matchTags filterTags scenarioTags then
                        backgroundExpectationThunks ++ scenarioExpectationThunks
                    else
                        -- [ skipElement "Scenario Outline" ]
                        [ ( scenarioDescription, defer pass ) ]



-- )


{-| Run a `Background` against a set of `GlueFunction` using an initial state
-}
expectBackground : List (GlueFunction state) -> state -> Background -> ( state, List ( String, ExpectationThunk ) )
expectBackground glueFunctions initialState background =
    case background of
        NoBackground ->
            ( initialState, [] )

        Background backgroundDescription backgroundSteps ->
            expectSteps glueFunctions initialState backgroundSteps


{-| Run a `List` of `Step`s against some `GlueFunctions` using an inital state.

Because we want failures to be meaningful, `GlueFunctions` need to return a pass
if there's no match on the step description, only fail if there's a match and
an actual Assertion failed.

Each `Scenario`, and each run of a `ScenarioOutline`, result in a separate Expectation.

Return a new state, and a List of (String, Expectation) where the String is the Step description
-}
expectSteps : List (GlueFunction state) -> state -> List Step -> ( state, List ( String, ExpectationThunk ) )
expectSteps glueFunctions initialState steps =
    case steps of
        [] ->
            ( initialState, [] )

        x :: xs ->
            let
                (Step stepType stepDescription stepArg) =
                    x
            in
                case expectStep x initialState glueFunctions of
                    -- shouldn't happen, expectStep should catch this and return a fail as an Expectation
                    ( Nothing, Nothing ) ->
                        ( initialState, [ ( stepDescription, defer <| fail "impossible state..." ) ] )

                    ( Just updatedState, Nothing ) ->
                        ( initialState, [ ( stepDescription, defer <| fail "None of the steps returned an Expectation" ) ] )

                    -- Looks like there was a short-cut failure, we continue to quickly exit
                    ( Nothing, Just expectationThunk ) ->
                        ( initialState, [ ( stepDescription, expectationThunk ) ] )

                    ( Just updatedState, Just expectation ) ->
                        let
                            ( nextState, nextExpectations ) =
                                expectSteps glueFunctions updatedState xs
                        in
                            ( nextState, ( stepDescription, expectation ) :: nextExpectations )


{-| runStep will take a Step and an initial state and run them against a Glue function,
returning an updated state (to pass to the next Glue function and/or Step) and an
Expectation.

Maybe it makes more sense to return a `Result` of Ok state | Err Expectation. Can then use andThen?

-}
expectStep : Step -> state -> List (GlueFunction state) -> GlueFunctionResult state
expectStep (Step stepType stepDescription stepArg) initialState glueFunctions =
    case glueFunctions of
        [] ->
            ( Nothing, Just <| defer <| fail "No matching glue function found" )

        x :: xs ->
            case x stepDescription stepArg initialState of
                ( Nothing, Nothing ) ->
                    expectStep (Step stepType stepDescription stepArg) initialState xs

                ( maybeState, maybeExpectation ) ->
                    ( maybeState, maybeExpectation )
