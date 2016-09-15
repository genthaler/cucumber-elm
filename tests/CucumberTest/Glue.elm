module CucumberTest.Glue exposing (..)

import Test exposing (..)
import Expect
import Gherkin exposing (..)
import Cucumber exposing (..)
import CucumberTest.Fixture as Fixture


myGlue : Glue String
myGlue =
    let
        assert : GlueFunction String
        assert state maybeMatches stepArg =
            case List.head maybeMatches of
                Nothing ->
                    ( state, Expect.fail "misery" )

                Just Nothing ->
                    ( state, Expect.fail "misery" )

                Just (Just arg) ->
                    ( state, Expect.equal True (Fixture.myRealFunction arg) )
    in
        Glue "^Now is the (.+)$" assert
