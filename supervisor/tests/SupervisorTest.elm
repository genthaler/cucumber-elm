module SupervisorTest exposing (suite)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (..)
import Json.Decode as D
import Supervisor.Model exposing (..)

suite : Test
suite =
    describe "Model module"
        [test "elmiModuleListDecoder" <|
            \_ -> Expect.equal (Ok []) <|D.decodeString elmiModuleListDecoder elmJson2 ]

elmJson2 = """[{
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
              "module": "Platform.Cmd",
              "package": "elm/core"
            },
            "name": "Cmd",
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

elmJson = """[{
  "moduleName": "Supervisor.Ports",
  "modulePath": "src/Supervisor/Ports.elm",
  "interface": {
    "unions": {
      "Response": {
        "definition": {
          "vars": [],
          "ctors": {
            "FileList": [{
              "moduleName": {
                "module": "List",
                "package": "elm/core"
              },
              "name": "List",
              "type": "Type",
              "vars": [{
                "moduleName": {
                  "module": "String",
                  "package": "elm/core"
                },
                "name": "String",
                "type": "Type",
                "vars": []
              }]
            }],
            "Stdout": [{
              "moduleName": {
                "module": "String",
                "package": "elm/core"
              },
              "name": "String",
              "type": "Type",
              "vars": []
            }],
            "Stderr": [{
              "moduleName": {
                "module": "String",
                "package": "elm/core"
              },
              "name": "String",
              "type": "Type",
              "vars": []
            }],
            "NoOp": [],
            "CucumberResult": [{
              "moduleName": {
                "module": "String",
                "package": "elm/core"
              },
              "name": "String",
              "type": "Type",
              "vars": []
            }]
          }
        },
        "scope": "public open"
      }
    },
    "aliases": {},
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
              "module": "Platform.Cmd",
              "package": "elm/core"
            },
            "name": "Cmd",
            "type": "Type",
            "vars": [{
              "name": "msg",
              "type": "Var"
            }]
          }]
        },
        "vars": ["msg"]
      },
      "shellRequest": {
        "annotation": {
          "lambda": [{
            "moduleName": {
              "module": "String",
              "package": "elm/core"
            },
            "name": "String",
            "type": "Type",
            "vars": []
          }, {
            "moduleName": {
              "module": "Platform.Cmd",
              "package": "elm/core"
            },
            "name": "Cmd",
            "type": "Type",
            "vars": [{
              "name": "msg",
              "type": "Var"
            }]
          }]
        },
        "vars": ["msg"]
      },
      "fileWriteRequest": {
        "annotation": {
          "lambda": [{
            "moduleName": {
              "module": "String",
              "package": "elm/core"
            },
            "name": "String",
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
              "module": "Platform.Cmd",
              "package": "elm/core"
            },
            "name": "Cmd",
            "type": "Type",
            "vars": [{
              "name": "msg",
              "type": "Var"
            }]
          }]
        },
        "vars": ["msg"]
      },
      "exit": {
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
              "module": "Platform.Cmd",
              "package": "elm/core"
            },
            "name": "Cmd",
            "type": "Type",
            "vars": [{
              "name": "msg",
              "type": "Var"
            }]
          }]
        },
        "vars": ["msg"]
      },
      "response": {
        "annotation": {
          "moduleName": {
            "module": "Platform.Sub",
            "package": "elm/core"
          },
          "name": "Sub",
          "type": "Type",
          "vars": [{
            "moduleName": {
              "module": "Supervisor.Ports",
              "package": "author/project"
            },
            "name": "Response",
            "type": "Type",
            "vars": []
          }]
        },
        "vars": []
      },
      "cucumberTestRequest": {
        "annotation": {
          "lambda": [{
            "moduleName": {
              "module": "String",
              "package": "elm/core"
            },
            "name": "String",
            "type": "Type",
            "vars": []
          }, {
            "moduleName": {
              "module": "Platform.Cmd",
              "package": "elm/core"
            },
            "name": "Cmd",
            "type": "Type",
            "vars": [{
              "name": "msg",
              "type": "Var"
            }]
          }]
        },
        "vars": ["msg"]
      },
      "cucumberBootRequest": {
        "annotation": {
          "moduleName": {
            "module": "Platform.Cmd",
            "package": "elm/core"
          },
          "name": "Cmd",
          "type": "Type",
          "vars": [{
            "name": "msg",
            "type": "Var"
          }]
        },
        "vars": ["msg"]
      },
      "fileReadRequest": {
        "annotation": {
          "lambda": [{
            "moduleName": {
              "module": "String",
              "package": "elm/core"
            },
            "name": "String",
            "type": "Type",
            "vars": []
          }, {
            "moduleName": {
              "module": "Platform.Cmd",
              "package": "elm/core"
            },
            "name": "Cmd",
            "type": "Type",
            "vars": [{
              "name": "msg",
              "type": "Var"
            }]
          }]
        },
        "vars": ["msg"]
      },
      "fileListRequest": {
        "annotation": {
          "lambda": [{
            "moduleName": {
              "module": "String",
              "package": "elm/core"
            },
            "name": "String",
            "type": "Type",
            "vars": []
          }, {
            "moduleName": {
              "module": "Platform.Cmd",
              "package": "elm/core"
            },
            "name": "Cmd",
            "type": "Type",
            "vars": [{
              "name": "msg",
              "type": "Var"
            }]
          }]
        },
        "vars": ["msg"]
      },
      "echoRequest": {
        "annotation": {
          "lambda": [{
            "moduleName": {
              "module": "String",
              "package": "elm/core"
            },
            "name": "String",
            "type": "Type",
            "vars": []
          }, {
            "moduleName": {
              "module": "Platform.Cmd",
              "package": "elm/core"
            },
            "name": "Cmd",
            "type": "Type",
            "vars": [{
              "name": "msg",
              "type": "Var"
            }]
          }]
        },
        "vars": ["msg"]
      },
      "decoder": {
        "annotation": {
          "moduleName": {
            "module": "Json.Decode",
            "package": "elm/json"
          },
          "name": "Decoder",
          "type": "Type",
          "vars": [{
            "moduleName": {
              "module": "Supervisor.Ports",
              "package": "author/project"
            },
            "name": "Response",
            "type": "Type",
            "vars": []
          }]
        },
        "vars": []
      },
      "request": {
        "annotation": {
          "lambda": [{
            "moduleName": {
              "module": "Json.Encode",
              "package": "elm/json"
            },
            "name": "Value",
            "type": "Type",
            "vars": []
          }, {
            "moduleName": {
              "module": "Platform.Cmd",
              "package": "elm/core"
            },
            "name": "Cmd",
            "type": "Type",
            "vars": [{
              "name": "msg",
              "type": "Var"
            }]
          }]
        },
        "vars": ["msg"]
      }
    },
    "binops": {}
  }
}, {
  "moduleName": "Supervisor.Options",
  "modulePath": "src/Supervisor/Options.elm",
  "interface": {
    "unions": {
      "CliOptions": {
        "definition": {
          "vars": [],
          "ctors": {
            "Init": [{
              "moduleName": {
                "module": "String",
                "package": "elm/core"
              },
              "name": "String",
              "type": "Type",
              "vars": []
            }],
            "RunTests": [{
              "moduleName": {
                "module": "Supervisor.Options",
                "package": "author/project"
              },
              "name": "RunOptions",
              "type": "Aliased",
              "aliasType": {
                "tag": "Holey",
                "contents": {
                  "type": "Record",
                  "fields": {
                    "maybeDependencies": {
                      "moduleName": {
                        "module": "Maybe",
                        "package": "elm/core"
                      },
                      "name": "Maybe",
                      "type": "Type",
                      "vars": [{
                        "moduleName": {
                          "module": "String",
                          "package": "elm/core"
                        },
                        "name": "String",
                        "type": "Type",
                        "vars": []
                      }]
                    },
                    "testFiles": {
                      "moduleName": {
                        "module": "List",
                        "package": "elm/core"
                      },
                      "name": "List",
                      "type": "Type",
                      "vars": [{
                        "moduleName": {
                          "module": "String",
                          "package": "elm/core"
                        },
                        "name": "String",
                        "type": "Type",
                        "vars": []
                      }]
                    },
                    "maybeCompilerPath": {
                      "moduleName": {
                        "module": "Maybe",
                        "package": "elm/core"
                      },
                      "name": "Maybe",
                      "type": "Type",
                      "vars": [{
                        "moduleName": {
                          "module": "String",
                          "package": "elm/core"
                        },
                        "name": "String",
                        "type": "Type",
                        "vars": []
                      }]
                    },
                    "reportFormat": {
                      "moduleName": {
                        "module": "Supervisor.Options",
                        "package": "author/project"
                      },
                      "name": "ReportFormat",
                      "type": "Type",
                      "vars": []
                    },
                    "maybeGlueArgumentsFunction": {
                      "moduleName": {
                        "module": "Maybe",
                        "package": "elm/core"
                      },
                      "name": "Maybe",
                      "type": "Type",
                      "vars": [{
                        "moduleName": {
                          "module": "String",
                          "package": "elm/core"
                        },
                        "name": "String",
                        "type": "Type",
                        "vars": []
                      }]
                    },
                    "maybeTags": {
                      "moduleName": {
                        "module": "Maybe",
                        "package": "elm/core"
                      },
                      "name": "Maybe",
                      "type": "Type",
                      "vars": [{
                        "moduleName": {
                          "module": "String",
                          "package": "elm/core"
                        },
                        "name": "String",
                        "type": "Type",
                        "vars": []
                      }]
                    },
                    "watch": {
                      "moduleName": {
                        "module": "Basics",
                        "package": "elm/core"
                      },
                      "name": "Bool",
                      "type": "Type",
                      "vars": []
                    }
                  }
                }
              },
              "fields": []
            }]
          }
        },
        "scope": "public open"
      },
      "ReportFormat": {
        "definition": {
          "vars": [],
          "ctors": {
            "Junit": [],
            "Console": [],
            "Json": []
          }
        },
        "scope": "public open"
      }
    },
    "aliases": {
      "RunOptions": {
        "definition": {
          "alias": {
            "type": "Record",
            "fields": {
              "maybeDependencies": {
                "moduleName": {
                  "module": "Maybe",
                  "package": "elm/core"
                },
                "name": "Maybe",
                "type": "Type",
                "vars": [{
                  "moduleName": {
                    "module": "String",
                    "package": "elm/core"
                  },
                  "name": "String",
                  "type": "Type",
                  "vars": []
                }]
              },
              "testFiles": {
                "moduleName": {
                  "module": "List",
                  "package": "elm/core"
                },
                "name": "List",
                "type": "Type",
                "vars": [{
                  "moduleName": {
                    "module": "String",
                    "package": "elm/core"
                  },
                  "name": "String",
                  "type": "Type",
                  "vars": []
                }]
              },
              "maybeCompilerPath": {
                "moduleName": {
                  "module": "Maybe",
                  "package": "elm/core"
                },
                "name": "Maybe",
                "type": "Type",
                "vars": [{
                  "moduleName": {
                    "module": "String",
                    "package": "elm/core"
                  },
                  "name": "String",
                  "type": "Type",
                  "vars": []
                }]
              },
              "reportFormat": {
                "moduleName": {
                  "module": "Supervisor.Options",
                  "package": "author/project"
                },
                "name": "ReportFormat",
                "type": "Type",
                "vars": []
              },
              "maybeGlueArgumentsFunction": {
                "moduleName": {
                  "module": "Maybe",
                  "package": "elm/core"
                },
                "name": "Maybe",
                "type": "Type",
                "vars": [{
                  "moduleName": {
                    "module": "String",
                    "package": "elm/core"
                  },
                  "name": "String",
                  "type": "Type",
                  "vars": []
                }]
              },
              "maybeTags": {
                "moduleName": {
                  "module": "Maybe",
                  "package": "elm/core"
                },
                "name": "Maybe",
                "type": "Type",
                "vars": [{
                  "moduleName": {
                    "module": "String",
                    "package": "elm/core"
                  },
                  "name": "String",
                  "type": "Type",
                  "vars": []
                }]
              },
              "watch": {
                "moduleName": {
                  "module": "Basics",
                  "package": "elm/core"
                },
                "name": "Bool",
                "type": "Type",
                "vars": []
              }
            }
          },
          "vars": []
        },
        "scope": "public open"
      }
    },
    "types": {
      "config": {
        "annotation": {
          "moduleName": {
            "module": "Cli.Program",
            "package": "dillonkearns/elm-cli-options-parser"
          },
          "name": "Config",
          "type": "Type",
          "vars": [{
            "moduleName": {
              "module": "Supervisor.Options",
              "package": "author/project"
            },
            "name": "CliOptions",
            "type": "Type",
            "vars": []
          }]
        },
        "vars": []
      }
    },
    "binops": {}
  }
}, {
  "moduleName": "Supervisor.Model",
  "modulePath": "src/Supervisor/Model.elm",
  "interface": {
    "unions": {
      "Model": {
        "definition": {
          "vars": [],
          "ctors": {
            "InitCopyingTemplate": [{
              "moduleName": {
                "module": "StateMachine",
                "package": "the-sett/elm-state-machines"
              },
              "name": "State",
              "type": "Type",
              "vars": [{
                "type": "Record",
                "fields": {
                  "exiting": {
                    "moduleName": {
                      "module": "StateMachine",
                      "package": "the-sett/elm-state-machines"
                    },
                    "name": "Allowed",
                    "type": "Type",
                    "vars": []
                  }
                }
              }, {
                "type": "Record",
                "fields": {
                  "currentDir": {
                    "moduleName": {
                      "module": "String",
                      "package": "elm/core"
                    },
                    "name": "String",
                    "type": "Type",
                    "vars": []
                  },
                  "folder": {
                    "moduleName": {
                      "module": "String",
                      "package": "elm/core"
                    },
                    "name": "String",
                    "type": "Type",
                    "vars": []
                  },
                  "moduleDir": {
                    "moduleName": {
                      "module": "String",
                      "package": "elm/core"
                    },
                    "name": "String",
                    "type": "Type",
                    "vars": []
                  }
                }
              }]
            }],
            "RunConstructingFolder": [{
              "moduleName": {
                "module": "StateMachine",
                "package": "the-sett/elm-state-machines"
              },
              "name": "State",
              "type": "Type",
              "vars": [{
                "type": "Record",
                "fields": {
                  "runCompiling": {
                    "moduleName": {
                      "module": "StateMachine",
                      "package": "the-sett/elm-state-machines"
                    },
                    "name": "Allowed",
                    "type": "Type",
                    "vars": []
                  }
                }
              }, {
                "type": "Record",
                "fields": {
                  "project": {
                    "moduleName": {
                      "module": "Elm.Project",
                      "package": "elm/project-metadata-utils"
                    },
                    "name": "Project",
                    "type": "Type",
                    "vars": []
                  },
                  "runOptions": {
                    "moduleName": {
                      "module": "Supervisor.Options",
                      "package": "author/project"
                    },
                    "name": "RunOptions",
                    "type": "Aliased",
                    "aliasType": {
                      "tag": "Holey",
                      "contents": {
                        "type": "Record",
                        "fields": {
                          "maybeDependencies": {
                            "moduleName": {
                              "module": "Maybe",
                              "package": "elm/core"
                            },
                            "name": "Maybe",
                            "type": "Type",
                            "vars": [{
                              "moduleName": {
                                "module": "String",
                                "package": "elm/core"
                              },
                              "name": "String",
                              "type": "Type",
                              "vars": []
                            }]
                          },
                          "testFiles": {
                            "moduleName": {
                              "module": "List",
                              "package": "elm/core"
                            },
                            "name": "List",
                            "type": "Type",
                            "vars": [{
                              "moduleName": {
                                "module": "String",
                                "package": "elm/core"
                              },
                              "name": "String",
                              "type": "Type",
                              "vars": []
                            }]
                          },
                          "maybeCompilerPath": {
                            "moduleName": {
                              "module": "Maybe",
                              "package": "elm/core"
                            },
                            "name": "Maybe",
                            "type": "Type",
                            "vars": [{
                              "moduleName": {
                                "module": "String",
                                "package": "elm/core"
                              },
                              "name": "String",
                              "type": "Type",
                              "vars": []
                            }]
                          },
                          "reportFormat": {
                            "moduleName": {
                              "module": "Supervisor.Options",
                              "package": "author/project"
                            },
                            "name": "ReportFormat",
                            "type": "Type",
                            "vars": []
                          },
                          "maybeGlueArgumentsFunction": {
                            "moduleName": {
                              "module": "Maybe",
                              "package": "elm/core"
                            },
                            "name": "Maybe",
                            "type": "Type",
                            "vars": [{
                              "moduleName": {
                                "module": "String",
                                "package": "elm/core"
                              },
                              "name": "String",
                              "type": "Type",
                              "vars": []
                            }]
                          },
                          "maybeTags": {
                            "moduleName": {
                              "module": "Maybe",
                              "package": "elm/core"
                            },
                            "name": "Maybe",
                            "type": "Type",
                            "vars": [{
                              "moduleName": {
                                "module": "String",
                                "package": "elm/core"
                              },
                              "name": "String",
                              "type": "Type",
                              "vars": []
                            }]
                          },
                          "watch": {
                            "moduleName": {
                              "module": "Basics",
                              "package": "elm/core"
                            },
                            "name": "Bool",
                            "type": "Type",
                            "vars": []
                          }
                        }
                      }
                    },
                    "fields": []
                  }
                }
              }]
            }],
            "InitStart": [{
              "moduleName": {
                "module": "StateMachine",
                "package": "the-sett/elm-state-machines"
              },
              "name": "State",
              "type": "Type",
              "vars": [{
                "type": "Record",
                "fields": {
                  "initGettingCurrentDir": {
                    "moduleName": {
                      "module": "StateMachine",
                      "package": "the-sett/elm-state-machines"
                    },
                    "name": "Allowed",
                    "type": "Type",
                    "vars": []
                  }
                }
              }, {
                "type": "Record",
                "fields": {
                  "folder": {
                    "moduleName": {
                      "module": "String",
                      "package": "elm/core"
                    },
                    "name": "String",
                    "type": "Type",
                    "vars": []
                  }
                }
              }]
            }],
            "Exiting": [{
              "moduleName": {
                "module": "StateMachine",
                "package": "the-sett/elm-state-machines"
              },
              "name": "State",
              "type": "Type",
              "vars": [{
                "type": "Record",
                "fields": {
                  "exiting": {
                    "moduleName": {
                      "module": "StateMachine",
                      "package": "the-sett/elm-state-machines"
                    },
                    "name": "Allowed",
                    "type": "Type",
                    "vars": []
                  }
                }
              }, {
                "moduleName": {
                  "module": "Basics",
                  "package": "elm/core"
                },
                "name": "Int",
                "type": "Type",
                "vars": []
              }]
            }],
            "RunWatching": [{
              "moduleName": {
                "module": "StateMachine",
                "package": "the-sett/elm-state-machines"
              },
              "name": "State",
              "type": "Type",
              "vars": [{
                "type": "Record",
                "fields": {
                  "runResolvingGherkinFiles": {
                    "moduleName": {
                      "module": "StateMachine",
                      "package": "the-sett/elm-state-machines"
                    },
                    "name": "Allowed",
                    "type": "Type",
                    "vars": []
                  },
                  "runCompiling": {
                    "moduleName": {
                      "module": "StateMachine",
                      "package": "the-sett/elm-state-machines"
                    },
                    "name": "Allowed",
                    "type": "Type",
                    "vars": []
                  }
                }
              }, {
                "type": "Record",
                "fields": {
                  "testedGherkinFiles": {
                    "moduleName": {
                      "module": "List",
                      "package": "elm/core"
                    },
                    "name": "List",
                    "type": "Type",
                    "vars": [{
                      "moduleName": {
                        "module": "String",
                        "package": "elm/core"
                      },
                      "name": "String",
                      "type": "Type",
                      "vars": []
                    }]
                  },
                  "remainingGherkinFiles": {
                    "moduleName": {
                      "module": "List",
                      "package": "elm/core"
                    },
                    "name": "List",
                    "type": "Type",
                    "vars": [{
                      "moduleName": {
                        "module": "String",
                        "package": "elm/core"
                      },
                      "name": "String",
                      "type": "Type",
                      "vars": []
                    }]
                  }
                }
              }]
            }],
            "InitGettingCurrentDir": [{
              "moduleName": {
                "module": "StateMachine",
                "package": "the-sett/elm-state-machines"
              },
              "name": "State",
              "type": "Type",
              "vars": [{
                "type": "Record",
                "fields": {
                  "initGettingModuleDir": {
                    "moduleName": {
                      "module": "StateMachine",
                      "package": "the-sett/elm-state-machines"
                    },
                    "name": "Allowed",
                    "type": "Type",
                    "vars": []
                  }
                }
              }, {
                "type": "Record",
                "fields": {
                  "folder": {
                    "moduleName": {
                      "module": "String",
                      "package": "elm/core"
                    },
                    "name": "String",
                    "type": "Type",
                    "vars": []
                  }
                }
              }]
            }],
            "RunTestingGherkinFiles": [{
              "moduleName": {
                "module": "StateMachine",
                "package": "the-sett/elm-state-machines"
              },
              "name": "State",
              "type": "Type",
              "vars": [{
                "type": "Record",
                "fields": {
                  "exiting": {
                    "moduleName": {
                      "module": "StateMachine",
                      "package": "the-sett/elm-state-machines"
                    },
                    "name": "Allowed",
                    "type": "Type",
                    "vars": []
                  },
                  "watching": {
                    "moduleName": {
                      "module": "StateMachine",
                      "package": "the-sett/elm-state-machines"
                    },
                    "name": "Allowed",
                    "type": "Type",
                    "vars": []
                  }
                }
              }, {
                "type": "Record",
                "fields": {
                  "testedGherkinFiles": {
                    "moduleName": {
                      "module": "List",
                      "package": "elm/core"
                    },
                    "name": "List",
                    "type": "Type",
                    "vars": [{
                      "moduleName": {
                        "module": "String",
                        "package": "elm/core"
                      },
                      "name": "String",
                      "type": "Type",
                      "vars": []
                    }]
                  },
                  "remainingGherkinFiles": {
                    "moduleName": {
                      "module": "List",
                      "package": "elm/core"
                    },
                    "name": "List",
                    "type": "Type",
                    "vars": [{
                      "moduleName": {
                        "module": "String",
                        "package": "elm/core"
                      },
                      "name": "String",
                      "type": "Type",
                      "vars": []
                    }]
                  }
                }
              }]
            }],
            "RunResolvingGherkinFiles": [{
              "moduleName": {
                "module": "StateMachine",
                "package": "the-sett/elm-state-machines"
              },
              "name": "State",
              "type": "Type",
              "vars": [{
                "type": "Record",
                "fields": {
                  "runResolvingGherkinFiles": {
                    "moduleName": {
                      "module": "StateMachine",
                      "package": "the-sett/elm-state-machines"
                    },
                    "name": "Allowed",
                    "type": "Type",
                    "vars": []
                  }
                }
              }, {
                "type": "Record",
                "fields": {
                  "gherkinFiles": {
                    "moduleName": {
                      "module": "List",
                      "package": "elm/core"
                    },
                    "name": "List",
                    "type": "Type",
                    "vars": [{
                      "moduleName": {
                        "module": "String",
                        "package": "elm/core"
                      },
                      "name": "String",
                      "type": "Type",
                      "vars": []
                    }]
                  }
                }
              }]
            }],
            "RunGettingPackageInfo": [{
              "moduleName": {
                "module": "StateMachine",
                "package": "the-sett/elm-state-machines"
              },
              "name": "State",
              "type": "Type",
              "vars": [{
                "type": "Record",
                "fields": {
                  "runConstructingFolder": {
                    "moduleName": {
                      "module": "StateMachine",
                      "package": "the-sett/elm-state-machines"
                    },
                    "name": "Allowed",
                    "type": "Type",
                    "vars": []
                  }
                }
              }, {
                "type": "Record",
                "fields": {
                  "runOptions": {
                    "moduleName": {
                      "module": "Supervisor.Options",
                      "package": "author/project"
                    },
                    "name": "RunOptions",
                    "type": "Aliased",
                    "aliasType": {
                      "tag": "Holey",
                      "contents": {
                        "type": "Record",
                        "fields": {
                          "maybeDependencies": {
                            "moduleName": {
                              "module": "Maybe",
                              "package": "elm/core"
                            },
                            "name": "Maybe",
                            "type": "Type",
                            "vars": [{
                              "moduleName": {
                                "module": "String",
                                "package": "elm/core"
                              },
                              "name": "String",
                              "type": "Type",
                              "vars": []
                            }]
                          },
                          "testFiles": {
                            "moduleName": {
                              "module": "List",
                              "package": "elm/core"
                            },
                            "name": "List",
                            "type": "Type",
                            "vars": [{
                              "moduleName": {
                                "module": "String",
                                "package": "elm/core"
                              },
                              "name": "String",
                              "type": "Type",
                              "vars": []
                            }]
                          },
                          "maybeCompilerPath": {
                            "moduleName": {
                              "module": "Maybe",
                              "package": "elm/core"
                            },
                            "name": "Maybe",
                            "type": "Type",
                            "vars": [{
                              "moduleName": {
                                "module": "String",
                                "package": "elm/core"
                              },
                              "name": "String",
                              "type": "Type",
                              "vars": []
                            }]
                          },
                          "reportFormat": {
                            "moduleName": {
                              "module": "Supervisor.Options",
                              "package": "author/project"
                            },
                            "name": "ReportFormat",
                            "type": "Type",
                            "vars": []
                          },
                          "maybeGlueArgumentsFunction": {
                            "moduleName": {
                              "module": "Maybe",
                              "package": "elm/core"
                            },
                            "name": "Maybe",
                            "type": "Type",
                            "vars": [{
                              "moduleName": {
                                "module": "String",
                                "package": "elm/core"
                              },
                              "name": "String",
                              "type": "Type",
                              "vars": []
                            }]
                          },
                          "maybeTags": {
                            "moduleName": {
                              "module": "Maybe",
                              "package": "elm/core"
                            },
                            "name": "Maybe",
                            "type": "Type",
                            "vars": [{
                              "moduleName": {
                                "module": "String",
                                "package": "elm/core"
                              },
                              "name": "String",
                              "type": "Type",
                              "vars": []
                            }]
                          },
                          "watch": {
                            "moduleName": {
                              "module": "Basics",
                              "package": "elm/core"
                            },
                            "name": "Bool",
                            "type": "Type",
                            "vars": []
                          }
                        }
                      }
                    },
                    "fields": []
                  }
                }
              }]
            }],
            "InitGettingModuleDir": [{
              "moduleName": {
                "module": "StateMachine",
                "package": "the-sett/elm-state-machines"
              },
              "name": "State",
              "type": "Type",
              "vars": [{
                "type": "Record",
                "fields": {
                  "initCopyingTemplate": {
                    "moduleName": {
                      "module": "StateMachine",
                      "package": "the-sett/elm-state-machines"
                    },
                    "name": "Allowed",
                    "type": "Type",
                    "vars": []
                  }
                }
              }, {
                "type": "Record",
                "fields": {
                  "currentDir": {
                    "moduleName": {
                      "module": "String",
                      "package": "elm/core"
                    },
                    "name": "String",
                    "type": "Type",
                    "vars": []
                  },
                  "folder": {
                    "moduleName": {
                      "module": "String",
                      "package": "elm/core"
                    },
                    "name": "String",
                    "type": "Type",
                    "vars": []
                  }
                }
              }]
            }],
            "RunCompiling": [{
              "moduleName": {
                "module": "StateMachine",
                "package": "the-sett/elm-state-machines"
              },
              "name": "State",
              "type": "Type",
              "vars": [{
                "type": "Record",
                "fields": {
                  "runStartingRunner": {
                    "moduleName": {
                      "module": "StateMachine",
                      "package": "the-sett/elm-state-machines"
                    },
                    "name": "Allowed",
                    "type": "Type",
                    "vars": []
                  }
                }
              }, {
                "type": "Record",
                "fields": {
                  "gherkinFiles": {
                    "moduleName": {
                      "module": "List",
                      "package": "elm/core"
                    },
                    "name": "List",
                    "type": "Type",
                    "vars": [{
                      "moduleName": {
                        "module": "String",
                        "package": "elm/core"
                      },
                      "name": "String",
                      "type": "Type",
                      "vars": []
                    }]
                  }
                }
              }]
            }],
            "RunStartingRunner": [{
              "moduleName": {
                "module": "StateMachine",
                "package": "the-sett/elm-state-machines"
              },
              "name": "State",
              "type": "Type",
              "vars": [{
                "type": "Record",
                "fields": {
                  "runResolvingGherkinFiles": {
                    "moduleName": {
                      "module": "StateMachine",
                      "package": "the-sett/elm-state-machines"
                    },
                    "name": "Allowed",
                    "type": "Type",
                    "vars": []
                  }
                }
              }, {
                "type": "Record",
                "fields": {
                  "gherkinFiles": {
                    "moduleName": {
                      "module": "List",
                      "package": "elm/core"
                    },
                    "name": "List",
                    "type": "Type",
                    "vars": [{
                      "moduleName": {
                        "module": "String",
                        "package": "elm/core"
                      },
                      "name": "String",
                      "type": "Type",
                      "vars": []
                    }]
                  }
                }
              }]
            }],
            "RunStart": [{
              "moduleName": {
                "module": "StateMachine",
                "package": "the-sett/elm-state-machines"
              },
              "name": "State",
              "type": "Type",
              "vars": [{
                "type": "Record",
                "fields": {
                  "runGettingPackageInfo": {
                    "moduleName": {
                      "module": "StateMachine",
                      "package": "the-sett/elm-state-machines"
                    },
                    "name": "Allowed",
                    "type": "Type",
                    "vars": []
                  }
                }
              }, {
                "type": "Record",
                "fields": {
                  "runOptions": {
                    "moduleName": {
                      "module": "Supervisor.Options",
                      "package": "author/project"
                    },
                    "name": "RunOptions",
                    "type": "Aliased",
                    "aliasType": {
                      "tag": "Holey",
                      "contents": {
                        "type": "Record",
                        "fields": {
                          "maybeDependencies": {
                            "moduleName": {
                              "module": "Maybe",
                              "package": "elm/core"
                            },
                            "name": "Maybe",
                            "type": "Type",
                            "vars": [{
                              "moduleName": {
                                "module": "String",
                                "package": "elm/core"
                              },
                              "name": "String",
                              "type": "Type",
                              "vars": []
                            }]
                          },
                          "testFiles": {
                            "moduleName": {
                              "module": "List",
                              "package": "elm/core"
                            },
                            "name": "List",
                            "type": "Type",
                            "vars": [{
                              "moduleName": {
                                "module": "String",
                                "package": "elm/core"
                              },
                              "name": "String",
                              "type": "Type",
                              "vars": []
                            }]
                          },
                          "maybeCompilerPath": {
                            "moduleName": {
                              "module": "Maybe",
                              "package": "elm/core"
                            },
                            "name": "Maybe",
                            "type": "Type",
                            "vars": [{
                              "moduleName": {
                                "module": "String",
                                "package": "elm/core"
                              },
                              "name": "String",
                              "type": "Type",
                              "vars": []
                            }]
                          },
                          "reportFormat": {
                            "moduleName": {
                              "module": "Supervisor.Options",
                              "package": "author/project"
                            },
                            "name": "ReportFormat",
                            "type": "Type",
                            "vars": []
                          },
                          "maybeGlueArgumentsFunction": {
                            "moduleName": {
                              "module": "Maybe",
                              "package": "elm/core"
                            },
                            "name": "Maybe",
                            "type": "Type",
                            "vars": [{
                              "moduleName": {
                                "module": "String",
                                "package": "elm/core"
                              },
                              "name": "String",
                              "type": "Type",
                              "vars": []
                            }]
                          },
                          "maybeTags": {
                            "moduleName": {
                              "module": "Maybe",
                              "package": "elm/core"
                            },
                            "name": "Maybe",
                            "type": "Type",
                            "vars": [{
                              "moduleName": {
                                "module": "String",
                                "package": "elm/core"
                              },
                              "name": "String",
                              "type": "Type",
                              "vars": []
                            }]
                          },
                          "watch": {
                            "moduleName": {
                              "module": "Basics",
                              "package": "elm/core"
                            },
                            "name": "Bool",
                            "type": "Type",
                            "vars": []
                          }
                        }
                      }
                    },
                    "fields": []
                  }
                }
              }]
            }]
          }
        },
        "scope": "public open"
      }
    },
    "aliases": {},
    "types": {
      "toRunGettingPackageInfo": {
        "annotation": {
          "lambda": [{
            "moduleName": {
              "module": "StateMachine",
              "package": "the-sett/elm-state-machines"
            },
            "name": "State",
            "type": "Type",
            "vars": [{
              "extends": "a",
              "type": "Record",
              "fields": {
                "runConstructingFolder": {
                  "moduleName": {
                    "module": "StateMachine",
                    "package": "the-sett/elm-state-machines"
                  },
                  "name": "Allowed",
                  "type": "Type",
                  "vars": []
                }
              }
            }, {
              "type": "Record",
              "fields": {
                "runOptions": {
                  "moduleName": {
                    "module": "Supervisor.Options",
                    "package": "author/project"
                  },
                  "name": "RunOptions",
                  "type": "Aliased",
                  "aliasType": {
                    "tag": "Filled",
                    "contents": {
                      "type": "Record",
                      "fields": {
                        "maybeDependencies": {
                          "moduleName": {
                            "module": "Maybe",
                            "package": "elm/core"
                          },
                          "name": "Maybe",
                          "type": "Type",
                          "vars": [{
                            "moduleName": {
                              "module": "String",
                              "package": "elm/core"
                            },
                            "name": "String",
                            "type": "Type",
                            "vars": []
                          }]
                        },
                        "testFiles": {
                          "moduleName": {
                            "module": "List",
                            "package": "elm/core"
                          },
                          "name": "List",
                          "type": "Type",
                          "vars": [{
                            "moduleName": {
                              "module": "String",
                              "package": "elm/core"
                            },
                            "name": "String",
                            "type": "Type",
                            "vars": []
                          }]
                        },
                        "maybeCompilerPath": {
                          "moduleName": {
                            "module": "Maybe",
                            "package": "elm/core"
                          },
                          "name": "Maybe",
                          "type": "Type",
                          "vars": [{
                            "moduleName": {
                              "module": "String",
                              "package": "elm/core"
                            },
                            "name": "String",
                            "type": "Type",
                            "vars": []
                          }]
                        },
                        "reportFormat": {
                          "moduleName": {
                            "module": "Supervisor.Options",
                            "package": "author/project"
                          },
                          "name": "ReportFormat",
                          "type": "Type",
                          "vars": []
                        },
                        "maybeGlueArgumentsFunction": {
                          "moduleName": {
                            "module": "Maybe",
                            "package": "elm/core"
                          },
                          "name": "Maybe",
                          "type": "Type",
                          "vars": [{
                            "moduleName": {
                              "module": "String",
                              "package": "elm/core"
                            },
                            "name": "String",
                            "type": "Type",
                            "vars": []
                          }]
                        },
                        "maybeTags": {
                          "moduleName": {
                            "module": "Maybe",
                            "package": "elm/core"
                          },
                          "name": "Maybe",
                          "type": "Type",
                          "vars": [{
                            "moduleName": {
                              "module": "String",
                              "package": "elm/core"
                            },
                            "name": "String",
                            "type": "Type",
                            "vars": []
                          }]
                        },
                        "watch": {
                          "moduleName": {
                            "module": "Basics",
                            "package": "elm/core"
                          },
                          "name": "Bool",
                          "type": "Type",
                          "vars": []
                        }
                      }
                    }
                  },
                  "fields": []
                }
              }
            }]
          }, {
            "moduleName": {
              "module": "Supervisor.Model",
              "package": "author/project"
            },
            "name": "Model",
            "type": "Type",
            "vars": []
          }]
        },
        "vars": ["a"]
      },
      "toRunResolvingGherkinFiles": {
        "annotation": {
          "lambda": [{
            "moduleName": {
              "module": "StateMachine",
              "package": "the-sett/elm-state-machines"
            },
            "name": "State",
            "type": "Type",
            "vars": [{
              "extends": "a",
              "type": "Record",
              "fields": {
                "runResolvingGherkinFiles": {
                  "moduleName": {
                    "module": "StateMachine",
                    "package": "the-sett/elm-state-machines"
                  },
                  "name": "Allowed",
                  "type": "Type",
                  "vars": []
                }
              }
            }, {
              "type": "Record",
              "fields": {}
            }]
          }, {
            "moduleName": {
              "module": "List",
              "package": "elm/core"
            },
            "name": "List",
            "type": "Type",
            "vars": [{
              "moduleName": {
                "module": "String",
                "package": "elm/core"
              },
              "name": "String",
              "type": "Type",
              "vars": []
            }]
          }, {
            "moduleName": {
              "module": "Supervisor.Model",
              "package": "author/project"
            },
            "name": "Model",
            "type": "Type",
            "vars": []
          }]
        },
        "vars": ["a"]
      },
      "toRunStartingRunner": {
        "annotation": {
          "lambda": [{
            "moduleName": {
              "module": "StateMachine",
              "package": "the-sett/elm-state-machines"
            },
            "name": "State",
            "type": "Type",
            "vars": [{
              "extends": "a",
              "type": "Record",
              "fields": {
                "runStartingRunner": {
                  "moduleName": {
                    "module": "StateMachine",
                    "package": "the-sett/elm-state-machines"
                  },
                  "name": "Allowed",
                  "type": "Type",
                  "vars": []
                }
              }
            }, {
              "type": "Record",
              "fields": {}
            }]
          }, {
            "moduleName": {
              "module": "List",
              "package": "elm/core"
            },
            "name": "List",
            "type": "Type",
            "vars": [{
              "moduleName": {
                "module": "String",
                "package": "elm/core"
              },
              "name": "String",
              "type": "Type",
              "vars": []
            }]
          }, {
            "moduleName": {
              "module": "Supervisor.Model",
              "package": "author/project"
            },
            "name": "Model",
            "type": "Type",
            "vars": []
          }]
        },
        "vars": ["a"]
      },
      "toInitGettingCurrentDir": {
        "annotation": {
          "lambda": [{
            "moduleName": {
              "module": "StateMachine",
              "package": "the-sett/elm-state-machines"
            },
            "name": "State",
            "type": "Type",
            "vars": [{
              "extends": "a",
              "type": "Record",
              "fields": {
                "initGettingCurrentDir": {
                  "moduleName": {
                    "module": "StateMachine",
                    "package": "the-sett/elm-state-machines"
                  },
                  "name": "Allowed",
                  "type": "Type",
                  "vars": []
                }
              }
            }, {
              "type": "Record",
              "fields": {
                "folder": {
                  "moduleName": {
                    "module": "String",
                    "package": "elm/core"
                  },
                  "name": "String",
                  "type": "Type",
                  "vars": []
                }
              }
            }]
          }, {
            "moduleName": {
              "module": "Supervisor.Model",
              "package": "author/project"
            },
            "name": "Model",
            "type": "Type",
            "vars": []
          }]
        },
        "vars": ["a"]
      },
      "toInitGettingModuleDir": {
        "annotation": {
          "lambda": [{
            "moduleName": {
              "module": "StateMachine",
              "package": "the-sett/elm-state-machines"
            },
            "name": "State",
            "type": "Type",
            "vars": [{
              "extends": "a",
              "type": "Record",
              "fields": {
                "initGettingModuleDir": {
                  "moduleName": {
                    "module": "StateMachine",
                    "package": "the-sett/elm-state-machines"
                  },
                  "name": "Allowed",
                  "type": "Type",
                  "vars": []
                }
              }
            }, {
              "type": "Record",
              "fields": {
                "folder": {
                  "moduleName": {
                    "module": "String",
                    "package": "elm/core"
                  },
                  "name": "String",
                  "type": "Type",
                  "vars": []
                }
              }
            }]
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
              "module": "Supervisor.Model",
              "package": "author/project"
            },
            "name": "Model",
            "type": "Type",
            "vars": []
          }]
        },
        "vars": ["a"]
      },
      "toRunCompiling": {
        "annotation": {
          "lambda": [{
            "moduleName": {
              "module": "StateMachine",
              "package": "the-sett/elm-state-machines"
            },
            "name": "State",
            "type": "Type",
            "vars": [{
              "extends": "a",
              "type": "Record",
              "fields": {
                "runCompiling": {
                  "moduleName": {
                    "module": "StateMachine",
                    "package": "the-sett/elm-state-machines"
                  },
                  "name": "Allowed",
                  "type": "Type",
                  "vars": []
                }
              }
            }, {
              "type": "Record",
              "fields": {
                "gherkinFiles": {
                  "moduleName": {
                    "module": "List",
                    "package": "elm/core"
                  },
                  "name": "List",
                  "type": "Type",
                  "vars": [{
                    "moduleName": {
                      "module": "String",
                      "package": "elm/core"
                    },
                    "name": "String",
                    "type": "Type",
                    "vars": []
                  }]
                }
              }
            }]
          }, {
            "moduleName": {
              "module": "Supervisor.Model",
              "package": "author/project"
            },
            "name": "Model",
            "type": "Type",
            "vars": []
          }]
        },
        "vars": ["a"]
      },
      "toInitCopyingTemplate": {
        "annotation": {
          "lambda": [{
            "moduleName": {
              "module": "StateMachine",
              "package": "the-sett/elm-state-machines"
            },
            "name": "State",
            "type": "Type",
            "vars": [{
              "extends": "a",
              "type": "Record",
              "fields": {
                "initCopyingTemplate": {
                  "moduleName": {
                    "module": "StateMachine",
                    "package": "the-sett/elm-state-machines"
                  },
                  "name": "Allowed",
                  "type": "Type",
                  "vars": []
                }
              }
            }, {
              "type": "Record",
              "fields": {
                "currentDir": {
                  "moduleName": {
                    "module": "String",
                    "package": "elm/core"
                  },
                  "name": "String",
                  "type": "Type",
                  "vars": []
                },
                "folder": {
                  "moduleName": {
                    "module": "String",
                    "package": "elm/core"
                  },
                  "name": "String",
                  "type": "Type",
                  "vars": []
                }
              }
            }]
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
              "module": "Supervisor.Model",
              "package": "author/project"
            },
            "name": "Model",
            "type": "Type",
            "vars": []
          }]
        },
        "vars": ["a"]
      },
      "toRunStart": {
        "annotation": {
          "lambda": [{
            "moduleName": {
              "module": "Supervisor.Options",
              "package": "author/project"
            },
            "name": "RunOptions",
            "type": "Aliased",
            "aliasType": {
              "tag": "Filled",
              "contents": {
                "type": "Record",
                "fields": {
                  "maybeDependencies": {
                    "moduleName": {
                      "module": "Maybe",
                      "package": "elm/core"
                    },
                    "name": "Maybe",
                    "type": "Type",
                    "vars": [{
                      "moduleName": {
                        "module": "String",
                        "package": "elm/core"
                      },
                      "name": "String",
                      "type": "Type",
                      "vars": []
                    }]
                  },
                  "testFiles": {
                    "moduleName": {
                      "module": "List",
                      "package": "elm/core"
                    },
                    "name": "List",
                    "type": "Type",
                    "vars": [{
                      "moduleName": {
                        "module": "String",
                        "package": "elm/core"
                      },
                      "name": "String",
                      "type": "Type",
                      "vars": []
                    }]
                  },
                  "maybeCompilerPath": {
                    "moduleName": {
                      "module": "Maybe",
                      "package": "elm/core"
                    },
                    "name": "Maybe",
                    "type": "Type",
                    "vars": [{
                      "moduleName": {
                        "module": "String",
                        "package": "elm/core"
                      },
                      "name": "String",
                      "type": "Type",
                      "vars": []
                    }]
                  },
                  "reportFormat": {
                    "moduleName": {
                      "module": "Supervisor.Options",
                      "package": "author/project"
                    },
                    "name": "ReportFormat",
                    "type": "Type",
                    "vars": []
                  },
                  "maybeGlueArgumentsFunction": {
                    "moduleName": {
                      "module": "Maybe",
                      "package": "elm/core"
                    },
                    "name": "Maybe",
                    "type": "Type",
                    "vars": [{
                      "moduleName": {
                        "module": "String",
                        "package": "elm/core"
                      },
                      "name": "String",
                      "type": "Type",
                      "vars": []
                    }]
                  },
                  "maybeTags": {
                    "moduleName": {
                      "module": "Maybe",
                      "package": "elm/core"
                    },
                    "name": "Maybe",
                    "type": "Type",
                    "vars": [{
                      "moduleName": {
                        "module": "String",
                        "package": "elm/core"
                      },
                      "name": "String",
                      "type": "Type",
                      "vars": []
                    }]
                  },
                  "watch": {
                    "moduleName": {
                      "module": "Basics",
                      "package": "elm/core"
                    },
                    "name": "Bool",
                    "type": "Type",
                    "vars": []
                  }
                }
              }
            },
            "fields": []
          }, {
            "moduleName": {
              "module": "Supervisor.Model",
              "package": "author/project"
            },
            "name": "Model",
            "type": "Type",
            "vars": []
          }]
        },
        "vars": []
      },
      "toRunTestingGherkinFiles": {
        "annotation": {
          "lambda": [{
            "moduleName": {
              "module": "StateMachine",
              "package": "the-sett/elm-state-machines"
            },
            "name": "State",
            "type": "Type",
            "vars": [{
              "extends": "a",
              "type": "Record",
              "fields": {
                "runTestingGherkinFile": {
                  "moduleName": {
                    "module": "StateMachine",
                    "package": "the-sett/elm-state-machines"
                  },
                  "name": "Allowed",
                  "type": "Type",
                  "vars": []
                }
              }
            }, {
              "type": "Record",
              "fields": {}
            }]
          }, {
            "moduleName": {
              "module": "List",
              "package": "elm/core"
            },
            "name": "List",
            "type": "Type",
            "vars": [{
              "moduleName": {
                "module": "String",
                "package": "elm/core"
              },
              "name": "String",
              "type": "Type",
              "vars": []
            }]
          }, {
            "moduleName": {
              "module": "Supervisor.Model",
              "package": "author/project"
            },
            "name": "Model",
            "type": "Type",
            "vars": []
          }]
        },
        "vars": ["a"]
      },
      "toRunWatching": {
        "annotation": {
          "lambda": [{
            "moduleName": {
              "module": "StateMachine",
              "package": "the-sett/elm-state-machines"
            },
            "name": "State",
            "type": "Type",
            "vars": [{
              "extends": "a",
              "type": "Record",
              "fields": {
                "runWatching": {
                  "moduleName": {
                    "module": "StateMachine",
                    "package": "the-sett/elm-state-machines"
                  },
                  "name": "Allowed",
                  "type": "Type",
                  "vars": []
                }
              }
            }, {
              "type": "Record",
              "fields": {}
            }]
          }, {
            "moduleName": {
              "module": "List",
              "package": "elm/core"
            },
            "name": "List",
            "type": "Type",
            "vars": [{
              "moduleName": {
                "module": "String",
                "package": "elm/core"
              },
              "name": "String",
              "type": "Type",
              "vars": []
            }]
          }, {
            "moduleName": {
              "module": "Supervisor.Model",
              "package": "author/project"
            },
            "name": "Model",
            "type": "Type",
            "vars": []
          }]
        },
        "vars": ["a"]
      },
      "toExiting": {
        "annotation": {
          "lambda": [{
            "moduleName": {
              "module": "StateMachine",
              "package": "the-sett/elm-state-machines"
            },
            "name": "State",
            "type": "Type",
            "vars": [{
              "extends": "a",
              "type": "Record",
              "fields": {
                "exiting": {
                  "moduleName": {
                    "module": "StateMachine",
                    "package": "the-sett/elm-state-machines"
                  },
                  "name": "Allowed",
                  "type": "Type",
                  "vars": []
                }
              }
            }, {
              "name": "b",
              "type": "Var"
            }]
          }, {
            "moduleName": {
              "module": "Basics",
              "package": "elm/core"
            },
            "name": "Int",
            "type": "Type",
            "vars": []
          }, {
            "moduleName": {
              "module": "Supervisor.Model",
              "package": "author/project"
            },
            "name": "Model",
            "type": "Type",
            "vars": []
          }]
        },
        "vars": ["a", "b"]
      },
      "toInitStart": {
        "annotation": {
          "lambda": [{
            "moduleName": {
              "module": "String",
              "package": "elm/core"
            },
            "name": "String",
            "type": "Type",
            "vars": []
          }, {
            "moduleName": {
              "module": "Supervisor.Model",
              "package": "author/project"
            },
            "name": "Model",
            "type": "Type",
            "vars": []
          }]
        },
        "vars": []
      },
      "toRunConstructingFolder": {
        "annotation": {
          "lambda": [{
            "moduleName": {
              "module": "StateMachine",
              "package": "the-sett/elm-state-machines"
            },
            "name": "State",
            "type": "Type",
            "vars": [{
              "extends": "a",
              "type": "Record",
              "fields": {
                "runConstructingFolder": {
                  "moduleName": {
                    "module": "StateMachine",
                    "package": "the-sett/elm-state-machines"
                  },
                  "name": "Allowed",
                  "type": "Type",
                  "vars": []
                }
              }
            }, {
              "type": "Record",
              "fields": {
                "runOptions": {
                  "moduleName": {
                    "module": "Supervisor.Options",
                    "package": "author/project"
                  },
                  "name": "RunOptions",
                  "type": "Aliased",
                  "aliasType": {
                    "tag": "Filled",
                    "contents": {
                      "type": "Record",
                      "fields": {
                        "maybeDependencies": {
                          "moduleName": {
                            "module": "Maybe",
                            "package": "elm/core"
                          },
                          "name": "Maybe",
                          "type": "Type",
                          "vars": [{
                            "moduleName": {
                              "module": "String",
                              "package": "elm/core"
                            },
                            "name": "String",
                            "type": "Type",
                            "vars": []
                          }]
                        },
                        "testFiles": {
                          "moduleName": {
                            "module": "List",
                            "package": "elm/core"
                          },
                          "name": "List",
                          "type": "Type",
                          "vars": [{
                            "moduleName": {
                              "module": "String",
                              "package": "elm/core"
                            },
                            "name": "String",
                            "type": "Type",
                            "vars": []
                          }]
                        },
                        "maybeCompilerPath": {
                          "moduleName": {
                            "module": "Maybe",
                            "package": "elm/core"
                          },
                          "name": "Maybe",
                          "type": "Type",
                          "vars": [{
                            "moduleName": {
                              "module": "String",
                              "package": "elm/core"
                            },
                            "name": "String",
                            "type": "Type",
                            "vars": []
                          }]
                        },
                        "reportFormat": {
                          "moduleName": {
                            "module": "Supervisor.Options",
                            "package": "author/project"
                          },
                          "name": "ReportFormat",
                          "type": "Type",
                          "vars": []
                        },
                        "maybeGlueArgumentsFunction": {
                          "moduleName": {
                            "module": "Maybe",
                            "package": "elm/core"
                          },
                          "name": "Maybe",
                          "type": "Type",
                          "vars": [{
                            "moduleName": {
                              "module": "String",
                              "package": "elm/core"
                            },
                            "name": "String",
                            "type": "Type",
                            "vars": []
                          }]
                        },
                        "maybeTags": {
                          "moduleName": {
                            "module": "Maybe",
                            "package": "elm/core"
                          },
                          "name": "Maybe",
                          "type": "Type",
                          "vars": [{
                            "moduleName": {
                              "module": "String",
                              "package": "elm/core"
                            },
                            "name": "String",
                            "type": "Type",
                            "vars": []
                          }]
                        },
                        "watch": {
                          "moduleName": {
                            "module": "Basics",
                            "package": "elm/core"
                          },
                          "name": "Bool",
                          "type": "Type",
                          "vars": []
                        }
                      }
                    }
                  },
                  "fields": []
                }
              }
            }]
          }, {
            "moduleName": {
              "module": "Elm.Project",
              "package": "elm/project-metadata-utils"
            },
            "name": "Project",
            "type": "Type",
            "vars": []
          }, {
            "moduleName": {
              "module": "Supervisor.Model",
              "package": "author/project"
            },
            "name": "Model",
            "type": "Type",
            "vars": []
          }]
        },
        "vars": ["a"]
      }
    },
    "binops": {}
  }
}]
"""