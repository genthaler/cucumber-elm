module Main exposing (..)

import ElmTest exposing (..)
import GherkinTest
import CucumberTest
import GherkinParserTest


allTests : Test
allTests =
    suite "All tests"
        [ GherkinTest.all
        , GherkinParserTest.all
        , CucumberTest.all
        ]


main : Program Never
main =
    runSuite allTests
