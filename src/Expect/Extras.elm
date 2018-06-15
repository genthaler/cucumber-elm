module Expect.Extras
    exposing
        ( andThen
        , mapFailure
        , toMaybe
        , fromMaybe
        )

{-| A `Expectation` is the expectation of a computation that may fail. This is a great
way to manage errors in Elm.

# Type and Constructors
@docs Expectation

# Mapping
@docs map, map2, map3, map4, map5

# Chaining
@docs andThen

# Handling Failures
@docs withDefault, toMaybe, fromMaybe, mapFailure
-}

import Expect exposing (Expectation)


{-| Chain together a sequence of computations that may fail. It is helpful
to see its definition:

    andThen : (a -> Expectation e b) -> Expectation e a -> Expectation e b
    andThen callback expectation =
        case expectation of
          Pass value -> callback value
          Fail msg -> Fail msg

This means we only continue with the callback if things are going well. For
example, say you need to use (`toInt : String -> Expectation String Int`) to parse
a month and make sure it is between 1 and 12:

    toValidMonth : Int -> Expectation String Int
    toValidMonth month =
        if month >= 1 && month <= 12
            then Pass month
            else Fail "months must be between 1 and 12"

    toMonth : String -> Expectation String Int
    toMonth rawString =
        toInt rawString
          |> andThen toValidMonth

    -- toMonth "4" == Pass 4
    -- toMonth "9" == Pass 9
    -- toMonth "a" == Fail "cannot parse to an Int"
    -- toMonth "0" == Fail "months must be between 1 and 12"

This allows us to come out of a chain of operations with quite a specific error
message. It is often best to create a custom type that explicitly represents
the exact ways your computation may fail. This way it is easy to handle in your
code.
-}
andThen : (a -> Expectation x b) -> Expectation x a -> Expectation x b
andThen callback expectation =
    case expectation of
        Pass value ->
            callback value

        Fail msg ->
            Fail msg


{-| Transform a `Fail` value. For example, say the errors we get have too much
information:

    parseInt : String -> Expectation ParseFailure Int

    type alias ParseFailure =
        { message : String
        , code : Int
        , position : (Int,Int)
        }

    mapFailure .message (parseInt "123") == Pass 123
    mapFailure .message (parseInt "abc") == Fail "char 'a' is not a number"
-}
mapFailure : (x -> y) -> Expectation x a -> Expectation y a
mapFailure f expectation =
    case expectation of
        Pass v ->
            Pass v

        Fail e ->
            Fail (f e)


{-| Convert to a simpler `Maybe` if the actual error message is not needed or
you need to interact with some code that primarily uses maybes.

    parseInt : String -> Result ParseError Int

    maybeParseInt : String -> Maybe Int
    maybeParseInt string =
        toMaybe (parseInt string)
-}
toMaybe : Result x a -> Maybe a
toMaybe result =
    case result of
        Ok v ->
            Just v

        Err _ ->
            Nothing


{-| Convert from a simple `Maybe` to interact with some code that primarily
uses `Results`.

    parseInt : String -> Maybe Int

    resultParseInt : String -> Result String Int
    resultParseInt string =
        fromMaybe ("error parsing string: " ++ toString string) (parseInt string)
-}
fromMaybe : x -> Maybe a -> Result x a
fromMaybe err maybe =
    case maybe of
        Just v ->
            Ok v

        Nothing ->
            Err err
