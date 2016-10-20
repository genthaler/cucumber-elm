module HtmlRunner exposing (..)

{-| HOW TO RUN
1. ```bash
cd tests
elm-reactor
```
2. Visit http://localhost:8000/HtmlRunner.elm
-}

import Test exposing (..)
import Tests
import Test.Runner.Html


main : Program Never
main =
    [ Tests.all
    ]
        |> concat
        |> Test.Runner.Html.run
