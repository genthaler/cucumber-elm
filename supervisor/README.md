# Cucumber Supervisor

This package supervises the processing of argument to the original Node process, coordinates the building of the `Cucumber` `Runner` with the `Cucumber` package and glue functions, the running of `Feature`s with that `Runner`, and the collation of reports from the `Runner`.

Here's what's needed:
- a Supervisor
- a Test Runner
    - elm.json
        - source
            - ./elm.json/source-directories
            - ../elm.json/source-directories
            - specify on the command line
                - need to resolve all directories to relative, ensure no duplicates
        - dependencies
            - ./elm.json/dependencies
            - ../elm.json/dependencies
                - no duplicates
            - genthaler/cucumber
                - Need to be VERY sure that the version used is the same as for Supervisor
                - OR include npm module version source & dependencies.
                - OR use published cucumber-elm package in Supervisor
                - Maybe it makes sense to split the repos after all
    - Runner.elm
        - StepDefs (using constructed elm.json)


These are the steps taken for Init
- get the file listing for the user project
- assert that there is no cucumber folder under the user project
    - point to the README.md for how we expect to see the project structured
- generate a cucumebr folder under the user project
- assert that there is an elm.json file under the user project
- get elm.json for the user project
- parse the elm.json
- generate elm.json
    - add genthaler/cucumber/elm - different for package vs application
    - swizzle the source directories
- generate sample feature, Stepdef module and Runner.elm to cucumber folder
- run the thing!!

These are the steps taken for Running
- get the file listing for the user project
- assert that there is a cucumber folder under the user project
    - point to the README.md for how we expect to see the project structured
- assert that there is an elm.json file under the user project
- get elm.json for the user project
- parse the elm.json
- get the file listing for the user project cucumber folder
- assert that there is an elm.json file under the user project
    - otherwise remind the user to elm-cuke --help for init info
- get elm.json for the user project cucumber folder
- parse the elm.json
    - assert that the version of cucumber-elm elm package is the same as the cucumber-elm npm package
        - maybe error if it's less than the npm package, warning if greater than.
- run elmi-to-json
- parse elmi-to-json 
    StepDefs modules
    StepDefs functions

- generate/overwrite Runner.elm to cucumber folder
    - have an option to reset?
    - maybe have a separate runner folder as part of init
    - init could be a pre-step
    - yep, that seems better, since user would be compiling step defs anyway. 
    - still need to add functions that implement StepDef
    - can I get node-elm-compiler to specify an elm.json? then can parse the given one, add src directories and dependencies and use that instead of overwriting the existing one. If --watch, will need to watch elm.json as well. NO we can't

For init:
- construct an elm-json 
    - with user project dependencies
    - genthaler/cucumber-elm
- write elm-json to cucumber folder



# End state
- need a cucumber folder that can be used as a template
- want to be able to integration test that template
- Don't want the test to depend on customer code otherwise it won't compile first time
