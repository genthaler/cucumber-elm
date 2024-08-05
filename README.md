# Cucumber in Elm

## Install and test:

The following assumes node and npm are installed.

```
npm i
npm test
```

[![Travis-CI build Status](https://travis-ci.org/genthaler/cucumber-elm.svg?branch=master)](https://travis-ci.org/genthaler/cucumber-elm)

[![AppVeyor build status](https://ci.appveyor.com/api/projects/status/tn79mfap9v0fg2qb/branch/master?svg=true)](https://ci.appveyor.com/project/genthaler/cucumber-elm/branch/master)

[![](https://raw.githubusercontent.com/ZenHubIO/support/master/zenhub-badge.png)](https://zenhub.com)
This project is bootstrapped with [Create Elm App](https://github.com/halfzebra/create-elm-app).

## Architecture

### Modules

#### cucumber-elm

This is the top-level module that's published to the Elm package repository as cucumber-elm.

It handles parsing of feature files into a data structure made up of a number custom data types (and `List`s  of custom data types). Note there are no `Dict`s involved.

No JavaScript in this module.

#### cucumber-elm/cucumber

Cucumber tests for cucumber-elm. These tests largely mirror the cucumber-elm unit tests.

This module is actually a template folder, which is copied and combined with the user's step definition code to create a new module that can be started by and can communicate with the supervisor CLI application. See [the runner README](./runner/README.md) for instructions.

#### cucumber-elm/supervisor

This module, in the `supervisor` sub-directory, is the CLI that's installed via npm i cucumber-elm. 

It consists of an Elm `port`s module that handles marshalling of CLI arguments. It uses the wonderful `dillonkearns/elm-cli-options-parser` package to do the actual CLI argument parsing.

#### cucumber-elm/supervisor/tests

Unit tests for the `supervisor` module.

#### cucumber-elm/example

This is an example project with Elm source, Gherkin features, and Elm step definitions.

Note that building and running the example project and verifying its behaviour is part of the build for the entire project.

It is also the template project used when invoking `elm-cuke init`, although elm.json is modified and RpnCalculator is moved as part of the init process, and Runner.elm is modified when the project is run.

#### cucumber-elm/tests

Unit tests for cucumber-elm package.

#### cucumber-elm/fiddle TODO

This is an application you can use to validate a Gherkin file and pretty-print it.

Right now you can paste Gherkin text into the application and pretty print for copy-paste into your text editor. This isn't especially useful since you can do the same with your editor's default Gherkin formatter/prettifier. Eventually you'll be able drag-drop files onto the app and to export in Markdown. 

**TODO** can the cli package run as an HTML runner as well?

#### cucumber-elm/canonical TODO

Cucumber test for cucumber-elm. These tests are from the canonical set from the cucumber-js project, and hook into that project to show feature parity between cucumber-elm and cucumber-js

### Orchestration

The supervisor is responsible for:
- parsing command line arguments
- assembling the customer code, customer step definition code, the runner template and cucumber-elm itself into a new module, 
- compiling that module,
- running that module,
- sending that module feature files to be run against customer code,
- watching for changes to customer code and feature files, 
    - recompiling as necessary and 
    - rerunning feature files

The (constructed) runner module accepts feature file text from a port (sent by the supervisor), runs them against the customer code, and returns the result to the supervisor