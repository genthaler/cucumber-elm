module ParserTest exposing (..)

import Parser exposing (..)
import Expect
import Test exposing (Test, describe, test)


stringSuite : Test
stringSuite =
    describe "string tests"
        [ test "empty list" <|
            \() ->
                Expect.equal
                    (parse (s "") [])
                    (Nothing)
        , test "empty string" <|
            \() ->
                Expect.equal
                    (parse (s "") [ "" ])
                    (Just "")
        , test "simple string" <|
            \() ->
                Expect.equal
                    (parse (s "a") [ "a" ])
                    (Just "a")
        ]


csvSuite : Test
csvSuite =
    describe "csv string tests"
        [ test "empty list" <|
            \() ->
                Expect.equal
                    (parse (csv) [])
                    (Nothing)
        , test "empty string" <|
            \() ->
                Expect.equal
                    (parse (csv) [ "" ])
                    (Just [ "" ])
        , test "simple string" <|
            \() ->
                Expect.equal
                    (parse (csv) [ "a" ])
                    (Just [ "a" ])
        , test "one comma+space" <|
            \() ->
                Expect.equal
                    (parse (csv) [ "a, b" ])
                    (Just [ "a", "b" ])
        , test "two commas" <|
            \() ->
                Expect.equal
                    (parse (csv) [ "a,b,c" ])
                    (Just [ "a", "b", "c" ])
        ]


intSuite : Test
intSuite =
    describe "int tests"
        [ test "simple int" <|
            \() ->
                Expect.equal
                    (parse (int) [ "100" ])
                    (Just 100)
        ]


oneOfSuite : Test
oneOfSuite =
    describe "testing oneOf tests"
        [ test "choose between two string parsers" <|
            \() ->
                Expect.equal
                    (parse
                        (oneOf
                            [ s "hello"
                            , s "there"
                            ]
                        )
                        [ "there" ]
                    )
                    (Just "there")
        ]



-- manySuite : Test
-- manySuite =
--     describe "testing many tests"
--         [ test "simple int" <|
--             \() ->
--                 let
--                     manyOfInt2 : Parser (Int -> a) (List a)
--                     manyOfInt2 =
--                         manyOf (int)
--                     parseResult : Maybe (List Int)
--                     parseResult =
--                         parse
--                             manyOfInt2
--                             [ "1", "2", "3", "4" ]
--                 in
--                     Expect.equal
--                         parseResult
--                         (Just [ 1, 2, 3, 4 ])
--         ]


mapSuite : Test
mapSuite =
    describe "testing map (a.k.a. <$>) tests"
        [ test "addition" <|
            \() ->
                Expect.equal
                    (parse
                        ((+)
                            <$> start
                            |= int
                            |= int
                        )
                        [ "100"
                        , "3"
                        ]
                    )
                    (Just 103)
        ]


miscSuite : Test
miscSuite =
    describe "misc tests"
        [ test "empty" <|
            \() ->
                Expect.equal
                    (parse
                        ([] <$> start)
                        []
                    )
                    (Just [])
        , test "list append" <|
            \() ->
                Expect.equal
                    (parse
                        List.append
                        <$> ((List.singleton <$> start)
                                |= (List.singleton <$> start)
                            )
                                [ "1", "2" ]
                    )
                    (Just [ 1, 2 ])
        ]
