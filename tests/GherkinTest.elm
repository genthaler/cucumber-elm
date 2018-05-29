module GherkinTest exposing (..)

import Test exposing (..)
import Expect
import Gherkin exposing (..)


feature : Feature
feature =
    Feature []
        (Tag "Having fun")
        (AsA "person")
        (InOrderTo "have fun")
        (IWantTo "play baseball")
        NoBackground
        [ ScenarioOutline []
            "guys are swimming"
            [ Step Given
                "a precondition has value <param_1>"
                (DocString "")
            , Step And "something with <param_2>" (DataTable (Table [] [ [] ]))
            , Step Then "check <param_3> is the output" NoArg
            ]
            ([ Examples []
                (Table []
                    [ [ "" ]
                    ]
                )
             ]
            )
        , Scenario []
            "guys are sailing"
            [ Step Given "a precondition is valid" NoArg
            , Step When "an action is performed" NoArg
            , Step Then "something should be asserted" NoArg
            ]
        ]


featureTest : Test
featureTest =
    test "Features" <|
        \() ->
            Expect.equal (3 + 7) 10


all : Test
all =
    describe "GherkinTest"
        [ featureTest
        ]
