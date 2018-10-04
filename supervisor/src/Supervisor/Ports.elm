port module Supervisor.Ports exposing (Response(..), cucumberBootRequest, cucumberTestRequest, decoder, echoRequest, exit, fileListRequest, fileReadRequest, fileWriteRequest, logAndExit, request, response, shellRequest)

import Json.Decode as D
import Json.Decode.Extra as JDE
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
shellRequest cmd =
    request <|
        E.object
            [ ( "command", E.string "Shell" )
            , ( "cmd", E.string cmd )
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


exit : Int -> Cmd msg
exit exitCode =
    request <|
        E.object
            [ ( "command", E.string "Exit" )
            , ( "exitCode", E.int exitCode )
            ]


logAndExit : Int -> String -> Cmd msg
logAndExit exitCode msg =
    Cmd.batch [ echoRequest msg, exit exitCode ]



-- Response


type Response
    = NoOp
    | Stdout String
    | Stderr String
    | FileList (List String)
    | CucumberResult String


port rawResponse : (D.Value -> msg) -> Sub msg


response : Sub Response
response =
    Sub.map (D.decodeValue decoder >> Result.mapError (Stderr << D.errorToString) >> Result.Extra.merge) (rawResponse identity)


decoder : D.Decoder Response
decoder =
    D.oneOf
        [ D.field "code" D.int
            |> D.andThen
                (\i ->
                    if i == 0 then
                        D.fail "never mind, move along"

                    else
                        D.map Stderr <| JDE.withDefault "No stderr available" <| D.field "stderr" D.string
                )
        , D.map FileList (D.field "fileList" (D.list D.string))
        , D.map Stdout (D.field "stdout" D.string)
        ]
