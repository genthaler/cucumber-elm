# Cucumber Supervisor

This package supervises the processing of argument to the original Node process, coordinates the building of the `Cucumber` `Runner` with the `Cucumber` package and glue functions, the running of `Feature`s with that `Runner`, and the collation of reports from the `Runner`.

These are the steps taken
- get the folder for the user project
- get elm.json for the user project
- assert that there is a cucumber folder under the user project
- parse the elm.json
- get elm.json for the user project cucumber folder
- parse the elm.json
- get elm.json for cucumber-elm for this npm module
- parse the elm.json
- assert that cucumber-elm for this npm module is the same version as user project cucumber folder
- get/create/clean a cucumber folder under user project/cucumber/elm-stuff
- construct an elm-json 
    - with user project dependencies
    - dependencies
- write elm-json to cucumber folder
- copy/overwrite Runner.elm to cucumber folder
    - maybe have a separate runner folder as part of init
    - init could be a pre-step
    - yep, that seems better, since user would be compiling step defs anyway. 
    - still need to add functions that implement StepDef