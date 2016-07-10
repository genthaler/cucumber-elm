module GherkinTest exposing (..)

import ElmTest exposing (..)
import Gherkin exposing (..)


feature : Feature
feature =
    Feature "Having fun"
        (AsA "person")
        (InOrderTo "have fun")
        (IWantTo "play baseball")
        NoBackground
        [ ScenarioOutline "guys are swimming"
            [ Given "a precondition has value <param_1>"
                (DocString "")
            , And "something with <param_2>" (DataTable [ [] ])
            , Then "check <param_3> is the output" NoArg
            ]
            (Examples
                [ [ "" ]
                ]
            )
        , Scenario "guys are sailing"
            [ Given "a precondition is valid" NoArg
            , When "an action is performed" NoArg
            , Then "something should be asserted" NoArg
            ]
        ]


featureTest : Test
featureTest =
    test "Features" (assertEqual feature feature)


all : Test
all =
    suite "GherkinTest"
        [ featureTest
        ]
