module Tests exposing (..)

import Test exposing (..)
import Expect
import GherkinTest
import CucumberTest
import GherkinParserTest


all : Test
all =
    describe "All tests"
        [ GherkinTest.all
        , GherkinParserTest.all
        , CucumberTest.all
        ]
