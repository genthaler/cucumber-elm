module Tests exposing (..)

import CucumberTest
import Expect
import GherkinMdTest
import GherkinParserTest
import GherkinTest
import Test exposing (..)


all : Test
all =
    describe "All tests"
        [ GherkinTest.all
        , GherkinParserTest.all
        , GherkinMdTest.all
        , CucumberTest.all
        ]
