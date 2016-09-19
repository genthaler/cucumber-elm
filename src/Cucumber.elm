module Cucumber exposing (..)

import Expect
import Gherkin exposing (..)


-- import Automaton exposing (..)

import Regex


{-| According to this definition, glue is defined by a
   regular expression string, plus a glue function

   In OOP implementations of Cucumber, the state is usually the Step class itself.
-}
type Glue a
    = Glue String (GlueFunction a)


{-| A glue function transforms an initial state, a list of Strings extracted
from the matched regular expression, and any StepArg, into a tuple of
modified state and Assertion.
-}
type alias GlueFunction a =
    a -> List (Maybe String) -> StepArg -> GlueResult a


{-| A glue function returns a tuple of smodified state and Assertion.
-}
type alias GlueResult a =
    ( a, Expect.Expectation )



-- verify : Feature -> List (Glue a) -> Test
-- verify (Feature description (AsA asA) (InOrderTo inOrderTo) (IWantTo iWantTo) background scenarios) glueFunctions =
--     let
--         backgroundTest : Test
--         backgroundTest =
--             case background of
--                 NoBackground ->
--                     test "No Background" pass
--
--                 Background backgroundSteps ->
--                     runSteps "Background" glueFunctions backgroundSteps
--
--         scenarioTests =
--             List.map (runScenario glueFunctions backgroundTest) scenarios
--     in
--         suite description [ backgroundTest ]
--
--
-- {-|
-- Run all the steps for a particular scenario, including any background.
--
-- We need to pass state from one step invocation to another, so we use a continuation style for this.
--
-- Options I've found so far are evancz/automaton, Task.andThen, Maybe.andThen, Result.andThen, Basic.>>
--
-- List Step -> List Glue -> List (Step, Maybe Assertion)
--
-- Remember that I want to retain information about what Step is being executed.
--
-- For each Scenario, run Feature Background followed by the Scenario steps
--
-- For each Scenario Outline, for each Example, run Feature Background followed by the Scenario steps (filtered by Example tokens)
--
-- So I want to fold a list of steps, starting with a Nothing Assertion and a Nothing state datastructure
--
-- run : List Step -> List (Step, Assertion)
-- run  =
--   let
--     reduce start step =
--
--   in
--     List.foldl (Nothing, Nothing) steps
--
-- -}
-- runScenario : List (Glue a) -> Test -> Scenario -> Test
-- runScenario glueFunctions backgroundTest scenario =
--     case scenario of
--         Scenario description steps ->
--             suite ("Scenario " ++ description) [ backgroundTest, (runSteps "Scenario Steps" glueFunctions steps) ]
--
--         _ ->
--             test "Scenario Outline" (fail "not yet implemented")
-- runSteps : String -> List (Glue String) -> List Step -> Test
-- runSteps description glueFunctions steps =
--     suite description (List.map (runStep glueFunctions) steps)


{-|
runStep will take a Step and an initial state and run them against a Glue function,
returning an updated state (to pass to the next Glue function and/or Step) and an
Assertion.
-}
runStep : Step -> a -> Glue a -> GlueResult a
runStep step state (Glue regexString glueFunction) =
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

        regex =
            Regex.regex regexString

        found =
            Regex.find Regex.All regex string

        oneFound =
            (List.length found) == 1
    in
        case List.head found of
            Nothing ->
                ( state, Expect.pass )

            Just match ->
                glueFunction state match.submatches arg
