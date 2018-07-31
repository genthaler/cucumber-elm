module Help exposing (..)


help : List String
help =
    [ "--help # Display this help text"
    , "--version # Print version string and exit"

    -- , "init # Create example tests"
    , "TESTFILE # Run Gherkin feature file, for example " ++ (toString exampleGlob)

    -- , "[--glue /path/to/glue/functions] # Run tests"
    , "[--glue-arguments-function Fully.Qualified.StepDef.Arguments.function] # Fully quaified function name to provide tuple of (List (StepDefFunction state), state), where the first item is the list of glue functions to be used by Cucumber and the second is the initial state to be passed to the first step in the feature."
    , "[--initial-state-function Fully.Qualified.Initial.State.function] # Fully quaified function name to provide initial state"
    , "[--tags @tag, @tag]"

    -- , "[--add-dependencies path-to-destination-elm-package.json] # Add missing dependencies from current elm-package.json to destination"
    -- , "[--report json, junit, or console (default)] # Print results to stdout in given format"
    -- , "[--watch] # Run tests on file changes"
    ]


helpText : String
helpText =
    String.join "\n" help


exampleGlob : List String
exampleGlob =
    -- [ "tests", "**", "*.feature" ]
    [ "features", "my_feature.feature" ]
