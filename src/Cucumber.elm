module Cucumber exposing (..)

{-| This module is responsible for the actual running of a Gherkin feature against a set of functions.

The functions need to have the type signature of
``` Regex -> String ->

# This API exposes methods to run Glue functions, and for Glue functions to run

# Running Glue functions
@docs runStep, runSteps, verify, run,


@docs
# Run by Glue functions
@docs include


# Glue
These types describe
@docs Glue, GlueFunction, GlueResult, GlueOutput

# Running

These functions are for running glue functions with the step arguments as arguments.

It's the glue function's responsibility to decide whether it can handle a
particular step, though we can certainly help with pulling out matching groups.

The execution order is:
- for each Scenario or Scenario Outline+Example


# Reporting
-}

import Test exposing (Test, describe, test)
import Expect exposing (pass, fail)
import Gherkin exposing (..)


-- import Automaton exposing (..)

import Regex


{-| According to this definition, glue is defined by a
   regular expression string, plus a glue function

   In OOP implementations of Cucumber, the state is usually the Step class itself.
-}
type Glue a
    = Glue Regex.Regex (GlueFunction a)


{-| A glue function transforms an initial state, a list of Strings extracted
from the matched regular expression, and any StepArg, into a tuple of
modified state and Assertion.
-}
type alias GlueFunction state =
    state -> List (Maybe String) -> StepArg -> GlueResult state


{-| A glue function returns a tuple of modified state, list of GlueOutput and Assertion.
-}
type alias GlueResult a =
    ( a, List GlueOutput, Expect.Expectation )


{-| A glue function can send some output to be displayed inline in the
pretty-print of the Gherkin text. Right now only support text, but eventually
want to support images, in particular screenshots from webdriver.
-- | GlueOutputImage Blob
-}
type GlueOutput
    = GlueOutputString String


verify : Feature -> List (Glue a) -> Test
verify (Feature tags description (AsA asA) (InOrderTo inOrderTo) (IWantTo iWantTo) background scenarios) glueFunctions =
    let
        backgroundTest : Test
        backgroundTest =
            case background of
                NoBackground ->
                    test "No Background" (\() -> pass)

                Background backgroundTags backgroundSteps ->
                    runSteps "Background" glueFunctions backgroundSteps

        scenarioTests =
            List.map (runScenario glueFunctions backgroundTest) scenarios
    in
        describe description [ backgroundTest ]


{-|
Run all the steps for a particular scenario, including any background.

We need to pass state from one step invocation to another, so we use a continuation style for this.

Options I've found so far are evancz/automaton, Task.andThen, Maybe.andThen, Result.andThen, Basic.>>

List Step -> List Glue -> List (Step, Maybe Assertion)

Remember that I want to retain information about what Step is being executed.

For each Scenario, run Feature Background followed by the Scenario steps

For each Scenario Outline, for each Example, run Feature Background followed by the Scenario steps (filtered by Example tokens)

So I want to fold a list of steps, starting with a Nothing Assertion and a Nothing state datastructure

run : List Step -> List (Step, Assertion)
run  =
  let
    reduce start step =

  in
    List.foldl (Nothing, Nothing) steps

-}
runScenario : List (Glue a) -> Test -> Scenario -> Test
runScenario glueFunctions backgroundTest scenario =
    case scenario of
        Scenario tags description steps ->
            describe ("Scenario " ++ description) [ backgroundTest, (runSteps "Scenario Steps" glueFunctions steps) ]

        _ ->
            describe (test "Scenario Outline" (fail "not yet implemented"))


runSteps : String -> List (Glue String) -> List Step -> Test
runSteps description glueFunctions steps =
    describe description (List.map (runStep glueFunctions) steps)


{-|
runStep will take a Step and an initial state and run them against a Glue function,
returning an updated state (to pass to the next Glue function and/or Step) and an
Assertion.
-}
runStep : Step -> a -> Glue a -> GlueResult a
runStep step state (Glue regex glueFunction) =
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

        found =
            Regex.find Regex.All regex string

        oneFound =
            (List.length found) == 1
    in
        case List.head found of
            Nothing ->
                ( state, [], Expect.pass )

            Just match ->
                glueFunction state match.submatches arg


{-| The regular `Scenario` and `ScenarioOutline` types won't suffice for reporting,
since we'll have multiple invocations of a set of `Background` `Step`s in the cases
of `Scenario`s and `ScenarioOutline`s, and

-}
