<<<<<<< current
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


main : Test.Runner.Html.TestProgram
main =
    [ Tests.all
    ]
        |> concat
        |> Test.Runner.Html.run
=======

C:\Users\genthaler\AppData\Local\atom\app-1.27.1>"C:\Users\genthaler\AppData\Roaming\npm\\node_modules\elm-format\binaries\elm-format"   --stdin
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


main : Test.Runner.Html.TestProgram
main =
    [ Tests.all
    ]
        |> concat
        |> Test.Runner.Html.run
>>>>>>> before discard
