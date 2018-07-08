module Help exposing (..)


help : List String
help =
    [ "init # Create example tests"
    , "TESTFILES # Run TESTFILES, for example " ++ (toString exampleGlob)
    , "[--glue /path/to/glue/functions] # Run tests"
    , "[--glue-arguments-function Fully.Qualified.Glue.Arguments.function] # Fully quaified function name to provide tuple of (List (GlueFunction state), state), where the first item is the list of glue functions to be used by Cucumber and the second is the initial state to be passed to the first step in the feature."
    , "[--initial-state-function Fully.Qualified.Initial.State.function] # Fully quaified function name to provide initial state"
    , "[--add-dependencies path-to-destination-elm-package.json] # Add missing dependencies from current elm-package.json to destination"
    , "[--report json, junit, or console (default)] # Print results to stdout in given format"
    , "[--version] # Print version string and exit"
    , "[--watch] # Run tests on file changes"
    ]


exampleGlob : List String
exampleGlob =
    [ "tests", "**", "*.elm" ]
