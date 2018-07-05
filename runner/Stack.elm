-- From http://stackoverflow.com/questions/36951939/reversing-a-string-using-a-stack-adt-in-elm/36952822#36952822
module Stack exposing (..)

import String
import Lazy.List as LL exposing (LazyList)

type alias Stack a = List a

push : a -> Stack a -> Stack a
push tok stack = 
 (tok :: stack)

pop : Stack a -> (Maybe a, Stack a)
pop stack = 
 case stack of
   hd :: tl -> (Just hd, tl)
   _ -> (Nothing, [])

stackIterator : Stack a -> LazyList a
stackIterator stack =
 LL.iterate (\(mhd, tl) -> pop tl) (pop stack)
  |> LL.map Tuple.first
  |> LL.takeWhile ((/=) Nothing)
  |> LL.map (Maybe.map LL.singleton >> Maybe.withDefault LL.empty)
  |> LL.flatten
