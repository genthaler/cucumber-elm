port module Supervisor.Ports exposing (Response(..), cucumberBootRequest, cucumberTestRequest, decoder, echoRequest, exit, exportedInterfacesRequest, fileListRequest, fileReadRequest, fileWriteRequest, makeDirectoriesRequest, moduleDirectoryRequest, rawResponse, request, response, shellRequest)

import Json.Decode as D
import Json.Decode.Extra as JDE
import Json.Encode as E
import Result.Extra



-- Request


port request : E.Value -> Cmd msg


fileReadRequest : List String -> Cmd msg
fileReadRequest paths =
    request <|
        E.object
            [ ( "command", E.string "FileRead" )
            , ( "paths", E.list E.string paths )
            ]


fileWriteRequest : List ( List String, String ) -> Cmd msg
fileWriteRequest files =
    request <|
        E.object
            [ ( "command", E.string "FileWrite" )
            , ( "files"
              , E.list
                    (\( path, content ) ->
                        E.object [ ( "path", E.list E.string path ), ( "content", E.string content ) ]
                    )
                    files
              )
            ]


fileListRequest : List String -> String -> Cmd msg
fileListRequest cwd glob =
    request <|
        E.object
            [ ( "command", E.string "FileList" )
            , ( "cwd", E.list E.string cwd )
            , ( "glob", E.string glob )
            ]


moduleDirectoryRequest : Cmd msg
moduleDirectoryRequest =
    request <|
        E.object
            [ ( "command", E.string "ModuleDirectory" )
            ]


makeDirectoriesRequest : List (List String) -> Cmd msg
makeDirectoriesRequest paths =
    request <|
        E.object
            [ ( "command", E.string "MakeDirectory" )
            , ( "paths", E.list (E.list E.string) paths )
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


exportedInterfacesRequest : Cmd msg
exportedInterfacesRequest =
    request <|
        E.object
            [ ( "command", E.string "ExportedInterfaces" )
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


exit : Int -> String -> Cmd msg
exit exitCode message =
    request <|
        E.object
            [ ( "command", E.string "Exit" )
            , ( "exitCode", E.int exitCode )
            , ( "message", E.string message )
            ]



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
        , D.map Stderr (D.succeed "could not match response")
        ]
