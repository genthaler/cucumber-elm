module CucumberTest.Glue exposing (..)

import Expect
import Cucumber exposing (..)
import CucumberTest.Fixture as Fixture
import Regex


myGlue : Glue String
myGlue =
    let
        assert : GlueFunction String
        assert state maybeMatches stepArg =
            case List.head maybeMatches of
                Nothing ->
                    Debug.log "case" ( state, [], Expect.fail "misery1" )

                Just Nothing ->
                    ( state, [], Expect.fail "misery2" )

                Just (Just arg) ->
                    ( state, [], Expect.equal True (Fixture.myRealFunction arg) )
    in
        Glue (Regex.regex "Now") assert
