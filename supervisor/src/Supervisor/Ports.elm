port module Supervisor.Ports exposing (cucumberBootRequest, cucumberBootResponse, cucumberTestRequest, cucumberTestResponse, echoRequest, end, fileGlobResolveRequest, fileGlobResolveResponse, fileReadRequest, fileReadResponse, fileWriteRequest, fileWriteResponse, logAndExit, shellRequest, shellResponse)


port fileReadRequest : String -> Cmd msg


port fileReadResponse : (String -> msg) -> Sub msg


port fileWriteRequest : ( String, String ) -> Cmd msg


port fileWriteResponse : (String -> msg) -> Sub msg


port echoRequest : String -> Cmd msg


port shellRequest : String -> Cmd msg


port shellResponse : (Int -> msg) -> Sub msg


port fileGlobResolveRequest : String -> Cmd msg


port fileGlobResolveResponse : (List String -> msg) -> Sub msg


port cucumberBootRequest : String -> Cmd msg


port cucumberBootResponse : (Int -> msg) -> Sub msg


port cucumberTestRequest : String -> Cmd msg


port cucumberTestResponse : (String -> msg) -> Sub msg


port end : Int -> Cmd msg


logAndExit : Int -> String -> Cmd msg
logAndExit exitCode msg =
    Cmd.batch [ echoRequest msg, end exitCode ]
