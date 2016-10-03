module CucumberTest.Fixture exposing (..)


myRealFunction : String -> Bool
myRealFunction string =
    case string of
        "lions" ->
            True

        "tigers" ->
            True

        "bears" ->
            True

        _ ->
            False


myFooFunction =
    "foo"


myBarFunction =
    "bar"
