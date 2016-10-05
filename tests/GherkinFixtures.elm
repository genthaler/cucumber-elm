module GherkinFixtures exposing (..)

import Gherkin exposing (..)


{-| defer execution
-}
defer : a -> (() -> a)
defer x =
    \() -> x


noTags =
    []


tag =
    [ "blah" ]


tags =
    [ "foo", "bar" ]


givenTheQuickBrownFox =
    Step Given "the quick brown fox" NoArg


givenJumpsOverTheLazyDog =
    Step Given "jumps over the lazy dog" NoArg


givenIAmTryingToHaveFun =
    Step Given "I am trying to have fun" <| DataTable table1


givenTheWorldIsRound =
    Step Given "the world is round" NoArg


nowIsTheTime =
    "Now is the time"


tableRowContent =
    "| Now | is | the | time | "


table1 =
    Table [ "Now", "is", "the", "time" ]
        [ [ "For", "all", "good", "men" ]
        ]


tableContent1 =
    """ | Now | is | the | time |\x0D
          | For | all | good | men | """


table2 =
    Table [ "Now" ]
        [ [ "For" ]
        ]


stepContent =
    """Given I am trying to have fun\x0D
  | Now | is | the | time |\x0D
  | For | all | good | men | """


stepContent2 =
    "But I am trying not to be a fool\n"


butIAmTryingNotToBeAFool =
    Step But "I am trying not to be a fool" NoArg


background1 =
    Background "pack my box" [ givenTheQuickBrownFox, givenJumpsOverTheLazyDog ]


background2 =
    Background "Some basic info" [ givenTheWorldIsRound ]


backgroundContent2 =
    """Background: Some basic info\x0D
      Given the world is round\x0D
  """


simpleScenario =
    Scenario [] "with five dozen liquor jugs" [ givenTheQuickBrownFox, givenJumpsOverTheLazyDog ]


scenarioContent =
    """Scenario: Have fun\x0D
  Given I am trying to have fun\x0D
    | Now | is | the | time |\x0D
    | For | all | good | men |\x0D
  But I am trying not to be a fool\x0D
"""


scenario =
    Scenario [] "Have fun" [ givenIAmTryingToHaveFun, butIAmTryingNotToBeAFool ]


scenarioWithTagsContent =
    """@foo\x0D
  @bar\x0D
  Scenario: Have fun\x0D
    Given I am trying to have fun\x0D
      | Now | is | the | time |\x0D
      | For | all | good | men |\x0D
    But I am trying not to be a fool\x0D
  """


scenarioWithTags =
    Scenario tags "Have fun" [ givenIAmTryingToHaveFun, butIAmTryingNotToBeAFool ]


scenarioOutlineContent =
    """Scenario Outline: Have fun\x0D
      Given I am trying to have fun\x0D
        | Now | is | the | time |\x0D
        | For | all | good | men |\x0D
      But I am trying not to be a fool\x0D
      Examples:\x0D
        | Now |\x0D
        | For |\x0D
    """


scenarioOutline =
    ScenarioOutline []
        "Have fun"
        [ givenIAmTryingToHaveFun, butIAmTryingNotToBeAFool ]
        [ examples ]


scenarioOutlineWithTagsContent =
    """@foo\x0D
    @bar\x0D
    Scenario Outline: Have fun\x0D
      Given I am trying to have fun\x0D
        | Now | is | the | time |\x0D
        | For | all | good | men |\x0D
      But I am trying not to be a fool\x0D
      @blah\x0D
      Examples:\x0D
        | Now |\x0D
        | For |\x0D
    """


scenarioOutlineWithTags =
    ScenarioOutline tags
        "Have fun"
        [ givenIAmTryingToHaveFun, butIAmTryingNotToBeAFool ]
        [ examplesWithTag ]


examples =
    Examples [] table2


examplesWithTag =
    Examples tag table2


examplesContentWithTag =
    """@blah\x0D
    Examples:\x0D
      | Now |\x0D
      | For | """


simpleFeature : Feature
simpleFeature =
    Feature []
        "Feature Runner"
        (AsA "regular person")
        (InOrderTo "verify a feature")
        (IWantTo "supply some glue code and run it against the feature")
        background1
        [ simpleScenario ]


simpleFeatureContent =
    """Feature: Feature Runner\x0D
As a regular person\x0D
In order to verify a simpleFeature\x0D
I want to supply some glue code and run it against the simpleFeature\x0D
Background: pack my box\x0D
Given the quick brown fox\x0D
Scenario: with five dozen liquor jugs\x0D
Given the quick brown fox\x0D
When jumps over the lazy dog\x0D
"""


feature =
    Feature []
        "Living life"
        (AsA "person")
        (InOrderTo "get through life")
        (IWantTo "be able to do stuff")
        background2
        [ scenario ]


featureContent =
    """Feature: Living life\x0D
  As a person\x0D
  In order to get through life\x0D
  I want to be able to do stuff\x0D
\x0D
  Background: Some basic info\x0D
    Given the world is round\x0D
\x0D
  Scenario: Have fun\x0D
    Given I am trying to have fun\x0D
      | Now | is | the | time |\x0D
      | For | all | good | men |\x0D
    But I am trying not to be a fool\x0D
  """


featureWithTags =
    Feature tags
        "Living life"
        (AsA "person")
        (InOrderTo "get through life")
        (IWantTo "be able to do stuff")
        (Background "Some basic info" [ givenTheWorldIsRound ])
        [ Scenario []
            "Have fun"
            [ givenIAmTryingToHaveFun, butIAmTryingNotToBeAFool ]
        ]


featureWithScenarioWithTags =
    Feature []
        "Living life"
        (AsA "person")
        (InOrderTo "get through life")
        (IWantTo "be able to do stuff")
        (Background "Some basic info" [ givenTheWorldIsRound ])
        [ Scenario tags
            "Have fun"
            [ givenIAmTryingToHaveFun, butIAmTryingNotToBeAFool ]
        ]


featureWithScenarioOutlineWithExamplesWithTags =
    Feature tags
        "Living life"
        (AsA "person")
        (InOrderTo "get through life")
        (IWantTo "be able to do stuff")
        (Background "Some basic info" [ givenTheWorldIsRound ])
        [ ScenarioOutline []
            "Have fun"
            [ givenIAmTryingToHaveFun, butIAmTryingNotToBeAFool ]
            [ Examples tag table2 ]
        ]


featureWithTagsAndScenarioWithTagsAndScenarioOutlineWithTagsWithExamplesWithTags =
    Feature tags
        "Living life"
        (AsA "person")
        (InOrderTo "get through life")
        (IWantTo "be able to do stuff")
        (Background "Some basic info" [ givenTheWorldIsRound ])
        [ Scenario tags
            "Have fun"
            [ givenIAmTryingToHaveFun, butIAmTryingNotToBeAFool ]
        , ScenarioOutline tags
            "Have fun"
            [ givenIAmTryingToHaveFun, butIAmTryingNotToBeAFool ]
            [ Examples tag table2 ]
        ]


featureWithTagsAndScenarioWithTagsAndScenarioOutlineWithTagsWithExamplesWithTagsContent =
    """@foo\x0D
  @bar\x0D
  Feature: Living life\x0D
  As a person\x0D
  In order to get through life\x0D
  I want to be able to do stuff\x0D
\x0D
  Background: Some basic info\x0D
    Given the world is round\x0D
\x0D
  @foo\x0D
  @bar\x0D
  Scenario: Have fun\x0D
    Given I am trying to have fun\x0D
      | Now | is | the | time |\x0D
      | For | all | good | men |\x0D
    But I am trying not to be a fool\x0D
\x0D
  @foo\x0D
  @bar\x0D
  Scenario Outline: Have fun\x0D
    Given I am trying to have fun\x0D
      | Now | is | the | time |\x0D
      | For | all | good | men |\x0D
    But I am trying not to be a fool\x0D
    @blah\x0D
    Examples:\x0D
      | Now |\x0D
      | For |\x0D
  """
