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
    state -> List Tag -> String -> StepArg -> GlueFunctionResult state


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


{-| This is the main entry point to the module.
- Takes a String containing a feature definition,
- Parses it,
- Runs it against against a set of glue functions,
- Reports the results.
-}
testFeatureText : GlueFunctions state -> state -> String -> Test
testFeatureText glueFunctions initialState featureText =
    case GherkinParser.parse GherkinParser.feature featureText of
        Err error ->
            test "Parsing error" <| \() -> fail error

        Ok feature ->
            testFeature glueFunctions initialState feature


{-| verify a `Feature` against a set of glue functions.
-}
testFeature : GlueFunctions state -> state -> Feature -> Test
testFeature glueFunctions initialState (Feature tags featureDescription (AsA asA) (InOrderTo inOrderTo) (IWantTo iWantTo) background scenarios) =
    let
        scenarioTests =
            List.map (testScenario glueFunctions initialState background) scenarios
    in
        describe featureDescription scenarioTests


{-| "Run" a `Background`
-}
testBackground : GlueFunctions state -> state -> Background' -> ( state, Test )
testBackground glueFunctions initialState background =
    case background of
        NoBackground ->
            ( initialState, test "No Background" <| defer pass )

        Background backgroundDescription backgroundSteps ->
            let
                ( finalState, finalTest ) =
                    (testSteps glueFunctions initialState [] backgroundSteps)
            in
                ( finalState, describe ("Background " ++ backgroundDescription) [ finalTest ] )


{-| Run a `Scenario` against a set of `GlueFunctions` using an initial state
-}
testScenario : GlueFunctions state -> state -> Background' -> Scenario -> Test
testScenario glueFunctions initialState background scenario =
    case scenario of
        Scenario tags description steps ->
            let
                ( backgroundState, backgroundTest ) =
                    testBackground glueFunctions initialState background

                ( _, scenarioTest ) =
                    testSteps glueFunctions backgroundState tags steps
            in
                describe ("Scenario " ++ description) [ backgroundTest, scenarioTest ]

        _ ->
            test "Scenario Outline" <| defer <| fail "not yet implemented"


{-| Run a `List` of `Step`s against a set of `GlueFunctions` using an inital state.
-}
testSteps : GlueFunctions state -> state -> List Tag -> List Step -> ( state, Test )
testSteps glueFunctions initialState tags steps =
    let
        ( finalState, finalTests ) =
            List.foldr
                (\step ( state, tests ) ->
                    let
                        ( newState, test ) =
                            testStep glueFunctions state tags step
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
testStep : List (GlueFunction state) -> state -> List Tag -> Step -> ( state, Test )
testStep glueFunctions initialState tags step =
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
            function initialState tags string arg

        results =
            glueFunctions
                |> List.map apply
                >> List.filter ((/=) Nothing)
    in
        case results of
            (Just ( newState, expectation )) :: [] ->
                ( newState, test string <| defer <| expectation )

            _ ->
                ( initialState, test string <| defer <| (fail "There should be exactly one GlueFunction that accepts the given Step description and returns a Just Expectation") )
