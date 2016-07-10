module Main exposing (..)

import ElmTest exposing (..)
import GherkinTest
import CucumberTest


allTests : Test
allTests =
    suite "All tests"
        [ GherkinTest.all
        , CucumberTest.all
        ]


main : Program Never
main =
    runSuite allTests
