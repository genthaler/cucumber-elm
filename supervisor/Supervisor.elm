port module Runner exposing (..)

import Ports exposing (..)
import Platform exposing (programWithFlags)
import PackageInfo
import Options


-- 	1. parse options
--  1. get elm-package info
-- 		- node-elm-interface-to-json
-- 		- elm-interface-to-json
-- 		- Janiczek/package-info/1.0.0
-- 	1. create new folder under elm-stuff to do compilation in
-- 	1. construct new elm-package.json
-- 		- glue function path
-- 	1. compile
-- 	1. if any compilation errors, report those, otherwise:
-- 	1. shut down any existing runner
-- 	1. (re-)require the built elm.js file
-- 	1. start up the runner
-- 	1. resolve list of Gherkin files
-- 	1. for each file, ask Node for the text
-- 	1. test the gherkin file, with timing information
-- 	1. if successful, replace the stats for the gherkin file in the report


type Action
    = NoOp
    | FileRead
    | FileWrite


type alias Model =
    { pendingRequests : List String }


init : a -> ( List b, Cmd msg )
init flags =
    ( [], Cmd.none )


update : a -> b -> ( b, Cmd msg )
update action model =
    ( model, Cmd.none )


subscriptions : a -> Sub Action
subscriptions model =
    Sub.none



-- Sub.batch [ input <| always NoOp, close <| always NoOp ]


main : Program Never (List a) Action
main =
    programWithFlags
        { init = init
        , update = update
        , subscriptions = subscriptions
        }
