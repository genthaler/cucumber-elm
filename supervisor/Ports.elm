port module Ports exposing (..)


port fileReadRequest : String -> Cmd msg


port fileReadResponse : (String -> msg) -> Sub msg


port fileWriteRequest : ( String, String ) -> Cmd msg


port fileWriteResponse : (String -> msg) -> Sub msg


port shellRequest : String -> Cmd msg


port shellResponse : (Int -> msg) -> Sub msg


port fileListRequest : String -> Cmd msg


port fileListResponse : (List String -> msg) -> Sub msg


port requireRequest : String -> Cmd msg


port requireResponse : (Int -> msg) -> Sub msg


port cucumberRequest : String -> Cmd msg


port cucumberResponse : (String -> msg) -> Sub msg


port end : Int -> Cmd msg
