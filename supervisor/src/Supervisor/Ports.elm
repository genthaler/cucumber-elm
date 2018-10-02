port module Supervisor.Ports exposing (cucumberBootRequest, cucumberBootResponse, cucumberTestRequest, cucumberTestResponse, echoRequest, end, fileGlobResolveRequest, fileGlobResolveResponse, fileReadRequest, fileReadResponse, fileWriteRequest, fileWriteResponse, logAndExit, shellRequest, shellResponse)

import Json.Decode as D
import Json.Encode as E


type Response
    = NoOp
    | FileRead String
    | FileWrite String
    | FileList (List String)
    | Shell Int
    | Require Int
    | Cucumber String


port request : String -> Cmd msg


port response : (String -> msg) -> Sub msg


fileReadRequest : String -> Cmd msg
fileReadRequest fileName =
    request E.object
        [ ( "command", E.string "FileRead" )
        , ( "fileName", E.string fileName )
        ]



fileReadResponse : (String -> msg) -> Sub msg
-- fileReadResponse =
-- fileWriteRequest : ( String, String ) -> Cmd msg
-- fileWriteResponse : (String -> msg) -> Sub msg
-- echoRequest : String -> Cmd msg
-- shellRequest : String -> Cmd msg
-- shellResponse : (Int -> msg) -> Sub msg
-- fileGlobResolveRequest : String -> Cmd msg
-- fileGlobResolveResponse : (List String -> msg) -> Sub msg
-- cucumberBootRequest : String -> Cmd msg
-- cucumberBootResponse : (Int -> msg) -> Sub msg
-- cucumberTestRequest : String -> Cmd msg
-- cucumberTestResponse : (String -> msg) -> Sub msg
-- end : Int -> Cmd msg
-- logAndExit : Int -> String -> Cmd msg
-- logAndExit exitCode msg =
--     Cmd.batch [ echoRequest msg, end exitCode ]
