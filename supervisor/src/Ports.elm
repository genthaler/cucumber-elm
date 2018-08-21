port module Ports exposing (..)


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


port print : String -> Cmd msg


port printAndExitFailure : String -> Cmd msg


port printAndExitSuccess : String -> Cmd msg
