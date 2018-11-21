module SupervisorTest exposing (suite)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Json.Decode as D
import Supervisor.Package exposing (..)
import Test exposing (..)


suite : Test
suite =
    describe "Model module"
        [ test "elmiModuleListDecoder" <|
            \_ ->
                Expect.equal
                    (Ok [ ( "Supervisor.Ports", [ "logAndExit" ] ) ])
                <|
                    D.decodeString elmiModuleListDecoder elmJson
        ]


elmJson =
    """[{
  "moduleName": "Supervisor.Ports",
  "modulePath": "src/Supervisor/Ports.elm",
  "interface": {
    "types": {
      "logAndExit": {
        "annotation": {
          "lambda": [{
            "moduleName": {
              "module": "Basics",
              "package": "elm/core"
            },
            "name": "Int",
            "type": "Type",
            "vars": []
          }, {
            "moduleName": {
              "module": "String",
              "package": "elm/core"
            },
            "name": "String",
            "type": "Type",
            "vars": []
          }, {
            "moduleName": {
              "module": "Cucumber.StepDefs",
              "package": "genthaler/cucumber-elm"
            },
            "name": "StepDefFunctionResult",
            "type": "Type",
            "vars": [{
              "name": "msg",
              "type": "Var"
            }]
          }]
        },
        "vars": ["msg"]
      }
    }
  }}]"""
