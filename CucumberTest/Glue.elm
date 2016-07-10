module CucumberTest.Glue exposing (..)

import ElmTest exposing (..)
import Gherkin exposing (..)
import Cucumber exposing (..)
import CucumberTest.Fixture as Fixture
import ElmTestBDDStyle exposing (..)


myGlue : Glue String
myGlue =
    let
        assert : GlueFunction String
        assert state maybeMatches stepArg =
            case List.head maybeMatches of
                Nothing ->
                    ( state, fail "misery" )

                Just Nothing ->
                    ( state, fail "misery" )

                Just (Just arg) ->
                    ( state, ElmTest.assertEqual True (Fixture.myRealFunction arg) )
    in
        Glue "^Now is the (.+)$" assert
