# Cucumber Runner

This module is serves as middleware between the Supervisor and the Cucumber pure-Elm library.

The full process is documented in the `supervisor` package
The enclosing folder `runner` is copied to a new temporary package folder, along with Cucumber proper and all required StepDef functions, is  compiled into a .js file, `require`d by the supervisor and hooked into the ports set up by the supervisor.

The ports `runFeature` and `reportFeature` in Runner.elm correspond to the same named ports in Supervisor.elm.

Since this module contains ports, it can't be published as a proper Elm package, so it's here instead.