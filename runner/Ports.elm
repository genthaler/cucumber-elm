port module Ports exposing (..)


port cucumberResponse : String -> Cmd msg


port cucumberRequest : (String -> msg) -> Sub msg


port end : Int -> Cmd msg
