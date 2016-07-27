module GherkinParserTest exposing (..)

import Combine
import Gherkin
import GherkinParser
import ElmTestBDDStyle exposing (..)


all : Test
all =
    describe "Example Text"
        [ it "parses comments correctly"
            <| let
                comment =
                    "# some comment"

                result =
                    Combine.parse GherkinParser.comment comment
               in
                expect result toBe ( Result.Ok comment, Combine.Context "" 14 )
        , it "does math correctly"
            <| let
                comment =
                    "# some comment"

                result =
                    Combine.parse GherkinParser.comment comment
               in
                expect result toBe ( Result.Ok comment, Combine.Context "" 14 )
        ]
