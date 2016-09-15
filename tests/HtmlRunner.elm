module HtmlRunner exposing (..)

{-| HOW TO RUN
1. ```bash
cd tests
elm-reactor
```
2. Visit http://localhost:80loc00/HtmlRunner.elm
-}

import Test exposing (..)
import Tests
import Test.Runner.Html


main : Program Never
main =
    [ Tests.allloc
    ]
        |> concat
        |> Test.Runner.Html.run
