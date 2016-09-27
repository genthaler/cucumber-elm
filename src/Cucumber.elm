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

I want to be able to plug any assertions, as well as any extra info provided
by the glue functions, into the pretty-print of the feature.

I'm a little bit hobbled here by the fact that tests are now separated;
i.e. a Test is passed in a closure that returns an Assertion, rather than
just an Assertion. This is a good thing generally,
since it keeps tests separated, but it's bad for me since the whole feature
needs to be run as a "test". This means I need to deal more with Assertions, and
create my own abstractions to pass in the result of eagerly evaluated,
stateful tests.

# Reporting
-}

import Test exposing (Test, describe, test)
import Expect exposing (Expectation, pass, fail)
import Gherkin exposing (..)
import GherkinParser exposing (..)
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
    state -> List (Maybe String) -> List StepArg -> GlueFunctionResult state


type alias GlueFunctions state =
    List (GlueFunction state)


{-| A glue function returns a tuple of modified state, list of GlueOutput and Assertion.
-}
type alias GlueFunctionResult a =
    ( a, Expectation )


{-| Elsewhere we return a tuple of state and `List Test`
-}
type alias ContinuationResult a =
    ( a, Test )


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
testFeature : List (GlueFunction state) -> state -> String -> Test
testFeature glueFunctions initialState featureText =
    case GherkinParser.parse GherkinParser.feature featureText of
        Err error ->
            test "Parsing error" <| \() -> fail error

        Ok feature ->
            featureTest glueFunctions initialState feature


{-| verify a `Feature` against a set of glue functions.
-}
featureTest : GlueFunctions state -> state -> Feature -> Test
featureTest glueFunctions initialState (Feature tags featureDescription (AsA asA) (InOrderTo inOrderTo) (IWantTo iWantTo) background scenarios) =
    let
        ( backgroundState, backgroundSuite ) =
            backgroundTest glueFunctions initialState background

        scenarioTests =
            List.map (scenarioTest glueFunctions backgroundState) scenarios
    in
        describe featureDescription scenarioTests


{-| "Run" a `Background`
-}
backgroundTest : GlueFunctions state -> state -> Background' -> ContinuationResult state
backgroundTest glueFunctions initialState background =
    case background of
        NoBackground ->
            ( initialState, test "No Background" <| defer pass )

        Background backgroundTags backgroundSteps ->
            stepsTest glueFunctions initialState backgroundSteps


scenarioTest : Test -> GlueFunctions state -> state -> Scenario -> Test
scenarioTest backgroundTest glueFunctions initialState scenario =
    case scenario of
        Scenario tags description steps ->
            describe ("Scenario " ++ description) [ backgroundTest, (stepsTest glueFunctions initialState steps) ]

        _ ->
            test "Scenario Outline" <| defer <| fail "not yet implemented"


{-| Run a `List` of `Step`s against a set of `GlueFunctions` using an inital state.
-}
stepsTest : GlueFunctions state -> state -> List Step -> ContinuationResult state
stepsTest glueFunctions initialState steps =
    describe "Steps" (List.map (stepTest glueFunctions) steps)


{-|
runStep will take a Step and an initial state and run them against a Glue function,
returning an updated state (to pass to the next Glue function and/or Step) and an
Assertion.
-}
stepTest : GlueFunctions state -> state -> Step -> ContinuationResult state
stepTest glueFunctions initialState step =
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

        apply glueFunction ( state, output, expectations ) =
            let
                ( newState, expectation ) =
                    glueFunction state
            in
                ( newState, expectation :: expectations )
    in
        List.foldr apply ( initialState, [] ) glueFunctions
