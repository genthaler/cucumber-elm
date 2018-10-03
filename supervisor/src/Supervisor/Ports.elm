port module Supervisor.Ports exposing (Response(..), cucumberBootRequest, cucumberTestRequest, decoder, echoRequest, end, fileListRequest, fileReadRequest, fileWriteRequest, logAndExit, request, response, shellRequest)

import Json.Decode as D
import Json.Encode as E
import Result.Extra



-- Request


port request : E.Value -> Cmd msg


fileReadRequest : String -> Cmd msg
fileReadRequest fileName =
    request <|
        E.object
            [ ( "command", E.string "FileRead" )
            , ( "fileName", E.string fileName )
            ]


fileWriteRequest : String -> String -> Cmd msg
fileWriteRequest fileName fileContent =
    request <|
        E.object
            [ ( "command", E.string "FileWrite" )
            , ( "fileName", E.string fileName )
            , ( "fileContent", E.string fileContent )
            ]


echoRequest : String -> Cmd msg
echoRequest message =
    request <|
        E.object
            [ ( "command", E.string "Echo" )
            , ( "message", E.string message )
            ]


shellRequest : String -> Cmd msg
shellRequest command =
    request <|
        E.object
            [ ( "command", E.string "Shell" )
            , ( "message", E.string command )
            ]


fileListRequest : String -> Cmd msg
fileListRequest glob =
    request <|
        E.object
            [ ( "command", E.string "FileList" )
            , ( "glob", E.string glob )
            ]


cucumberBootRequest : Cmd msg
cucumberBootRequest =
    request <|
        E.object
            [ ( "command", E.string "CucumberBoot" )
            ]


cucumberTestRequest : String -> Cmd msg
cucumberTestRequest feature =
    request <|
        E.object
            [ ( "command", E.string "Cucumber" )
            , ( "feature", E.string feature )
            ]


end : Int -> Cmd msg
end exitCode =
    request <|
        E.object
            [ ( "command", E.string "Exit" )
            , ( "exitCode", E.int exitCode )
            ]


logAndExit : Int -> String -> Cmd msg
logAndExit exitCode msg =
    Cmd.batch [ echoRequest msg, end exitCode ]



-- Response


type Response
    = NoOp
    | FileRead String
    | FileWrite Int
    | FileList (List String)
    | Shell Int String
    | Require Int
    | Cucumber String
    | Error String


port rawResponse : (D.Value -> msg) -> Sub msg


response : Sub Response
response =
    Sub.map (D.decodeValue decoder >> Result.mapError (Error << D.errorToString) >> Result.Extra.merge) (rawResponse identity)


decoder : D.Decoder Response
decoder =
    D.oneOf
        [ D.map FileRead (D.field "fileContent" D.string)
        , D.map FileWrite (D.field "exitCode" D.int)
        , D.map FileList (D.field "fileList" (D.list D.string))
        , D.map2 Shell (D.field "exitCode" D.int) (D.field "stdout" D.string)
        , D.map Require (D.field "exitCode" D.int)
        , D.map Cucumber (D.field "exitCode" D.string)
        ]
