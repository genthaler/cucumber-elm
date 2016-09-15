module CucumberTest.Fixture exposing (..)


myRealFunction : String -> Bool
myRealFunction string =
    case string of
        "time" ->
            True

        _ ->
            False
