module Cucumber exposing (..)

{-| This module is responsible for the actual running of a Gherkin feature against a set of functions.

The functions need to have the type signature of
`Regex -> String ->

# This API exposes methods to run Glue functions, and for Glue functions to run

# Running Glue functions
@docs runStep, runSteps, verify, run,


@docs
# Run by Glue functions
@docs include


# Glue
These types describe a glue function

@docs Glue, GlueFunction, GlueResult, GlueOutput

# Running

These functions are for running glue functions with the step arguments as arguments.

It's the glue function's responsibility to decide whether it can handle a
particular step, though we can certainly help with pulling out matching groups.

The execution order is:
- for each Scenario or Scenario Outline+Example
  - execute each Background Step
  - `andThen`
  - execute each Scenario Step


# Reporting
-}

import Test exposing (Test, describe, test)
import Expect exposing (Expectation, pass, fail)
import Gherkin exposing (..)
import GherkinParser exposing (feature, parse)
import List
import Set


-- import Automaton exposing (..)
-- {-| According to this definition, glue is defined by a
--    regular expression string, plus a glue function
--
--    In OOP implementations of Cucumber, the state is usually the Step class itself.
--    Here we pass the state around explicitly.
-- -}
-- type Glue a
--     = Glue Regex.Regex (GlueFunction a)


{-| A glue function transforms an initial state, a list of Strings extracted
from the matched regular expression, and any StepArg, into a tuple of
modified state and Assertion.
-}
type alias GlueFunction state =
    state -> String -> StepArg -> GlueFunctionResult state


type alias GlueFunctions state =
    List (GlueFunction state)


{-| A glue function returns a tuple of modified state, list of GlueOutput and Assertion.
-}
type alias GlueFunctionResult a =
    Maybe ( a, Expectation )


{-| A glue function can send some output to be displayed inline in the
pretty-print of the Gherkin text. Right now only support text, but eventually
want to support images, in particular screenshots from webdriver.
-- | GlueOutputImage Blob
-}
type GlueOutput
    = GlueOutputString String


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


{-| defer execution
-}
defer : a -> (() -> a)
defer x =
    \() -> x


{-| If there are any tags associated with the
`Feature`/`Scenario`/`ScenarioOutline`/`Examples` element, then this predicate will
check whether the tag was specified in the filterTags `List`.
-}
matchTags : List Tag -> List Tag -> Bool
matchTags elementTags filterTags =
    if elementTags == [] then
        True
    else
        Set.intersect (Set.fromList elementTags) (Set.fromList filterTags)
            |> Set.isEmpty
            |> not


{-| Helper function to generate an `Expectation.pass` if an element was skipped
due to tag mismatch
-}
skipElement : String -> Test
skipElement element =
    test (element ++ "skipped due to tag mismatch") <| defer pass


{-| This is the main entry point to the module.
- Takes a `String` containing a `Feature` definition,
- Parses it,
- Runs it against against a set of glue functions,
- Reports the results.
-}
testFeatureText : GlueFunctions state -> state -> List Tag -> String -> Test
testFeatureText glueFunctions initialState filterTags featureText =
    case GherkinParser.parse GherkinParser.feature featureText of
        Err error ->
            test "Parsing error" <| defer <| fail error

        Ok feature ->
            testFeature glueFunctions initialState filterTags feature


{-| verify a `Feature` against a set of glue functions.
-}
testFeature : GlueFunctions state -> state -> List Tag -> Feature -> Test
testFeature glueFunctions initialState filterTags (Feature featureTags featureDescription _ _ _ background scenarios) =
    let
        scenarioTests =
            List.map (testScenario glueFunctions initialState background filterTags) scenarios
    in
        describe featureDescription
            <| if matchTags featureTags filterTags then
                scenarioTests
               else
                [ skipElement "Feature" ]


{-| "Run" a `Background`
-}
testBackground : GlueFunctions state -> state -> Background -> ( state, Test )
testBackground glueFunctions initialState background =
    case background of
        NoBackground ->
            ( initialState, test "No Background" <| defer pass )

        Background backgroundDescription backgroundSteps ->
            let
                ( finalState, finalTest ) =
                    (testSteps glueFunctions initialState backgroundSteps)
            in
                ( finalState, describe ("Background " ++ backgroundDescription) [ finalTest ] )


{-| Run a `Scenario` against a set of `GlueFunctions` using an initial state
-}
testScenario : GlueFunctions state -> state -> Background -> List Tag -> Scenario -> Test
testScenario glueFunctions initialState background filterTags scenario =
    case scenario of
        Scenario scenarioTags description steps ->
            let
                ( backgroundState, backgroundTest ) =
                    testBackground glueFunctions initialState background

                ( _, scenarioTest ) =
                    testSteps glueFunctions backgroundState steps
            in
                describe ("Scenario " ++ description)
                    <| if matchTags scenarioTags filterTags then
                        [ backgroundTest, scenarioTest ]
                       else
                        [ skipElement "Scenario" ]

        ScenarioOutline scenarioTags description steps examplesList ->
            let
                ( backgroundState, backgroundTest ) =
                    testBackground glueFunctions initialState background

                ( _, scenarioTest ) =
                    testSteps glueFunctions backgroundState steps

                filterExamples (Examples examplesTags datatable) =
                    matchTags examplesTags filterTags

                filteredExamplesList =
                    List.filter filterExamples filteredExamplesList

                -- substituteExampleText =
                --     List.map substituteExampleTextInSteps filteredExamplesList
            in
                describe ("Scenario " ++ description)
                    <| if matchTags scenarioTags filterTags then
                        [ backgroundTest, scenarioTest ]
                       else
                        [ skipElement "Scenario Outline" ]



-- {-| For each Example (where tags agree), substitute values from Examples Table, and run just like a Scenario-}
-- iterateExample :


{-| Run a `List` of `Step`s against a set of `GlueFunctions` using an inital state.
-}
testSteps : GlueFunctions state -> state -> List Step -> ( state, Test )
testSteps glueFunctions initialState steps =
    let
        ( finalState, finalTests ) =
            List.foldr
                (\step ( state, tests ) ->
                    let
                        ( newState, test ) =
                            testStep glueFunctions state step
                    in
                        ( newState, test :: tests )
                )
                ( initialState, [] )
                steps
    in
        ( finalState, describe "Steps" finalTests )


{-|
runStep will take a Step and an initial state and run them against a Glue function,
returning an updated state (to pass to the next Glue function and/or Step) and an
Assertion.
-}
testStep : List (GlueFunction state) -> state -> Step -> ( state, Test )
testStep glueFunctions initialState step =
    let
        ( stepName, string, arg ) =
            case step of
                Given string arg ->
                    ( "Given", string, arg )

                When string arg ->
                    ( "When", string, arg )

                Then string arg ->
                    ( "Then", string, arg )

                And string arg ->
                    ( "And", string, arg )

                But string arg ->
                    ( "But", string, arg )

        apply function =
            function initialState string arg

        results =
            glueFunctions
                |> List.map apply
                >> List.filter ((/=) Nothing)
    in
        case results of
            (Just ( newState, expectation )) :: [] ->
                ( newState, test string <| defer <| expectation )

            _ ->
                ( initialState, test string <| defer <| fail "There should be exactly one GlueFunction that accepts the given Step description and returns a Just Expectation" )
