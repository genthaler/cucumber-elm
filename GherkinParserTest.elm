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
        , it "parses spaces correctly"
            <| let
                whitespace =
                    "  "

                result =
                    Combine.parse GherkinParser.whitespace whitespace
               in
                expect result toBe ( Result.Ok whitespace, Combine.Context "" 2 )
        , it "parses AsA correctly"
            <| let
                asA =
                    "super dev"

                result =
                    Combine.parse GherkinParser.asA ("As a" ++ " " ++ asA)
               in
                expect result toBe ( Result.Ok (Gherkin.AsA asA), Combine.Context "" 14 )
        , it "parses InOrderTo correctly"
            <| let
                inOrderTo =
                    "write super apps"

                result =
                    Combine.parse GherkinParser.inOrderTo ("In order to" ++ " " ++ inOrderTo)
               in
                expect result toBe ( Result.Ok (Gherkin.InOrderTo inOrderTo), Combine.Context "" 28 )
        , it "parses IWantTo correctly"
            <| let
                iWantTo =
                    "use Elm"

                result =
                    Combine.parse GherkinParser.iWantTo ("I want to" ++ " " ++ iWantTo)
               in
                expect result toBe ( Result.Ok (Gherkin.IWantTo iWantTo), Combine.Context "" 17 )
          -- , it "parses DocString correctly"
          --     <| let
          --         docStringQuotes =
          --             "\"\"\""
          --
          --         docStringContent =
          --             "Now is the time"
          --
          --         result =
          --             Combine.parse GherkinParser.docString (docStringQuotes ++ docStringContent ++ docStringQuotes)
          --        in
          --         expect result toBe ( Result.Ok (Gherkin.DocString docStringContent), Combine.Context "" 17 )
        ]
